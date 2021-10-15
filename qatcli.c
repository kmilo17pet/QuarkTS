/*!
 * @file qatcli.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qatcli.h"

#if ( Q_ATCLI == 1)

#define QATCLI_DEFAULT_AT_COMMAND               "at"
#define QATCLI_DEFAULT_ID_COMMAND               "atid"
#define QATCLI_DEFAULT_ATSET_DELIM              ','
#define QATCLI_DEFAULT_ERROR_RSP_STRING         "ERROR"
#define QATCLI_DEFAULT_OK_RSP_STRING            "OK"
#define QATCLI_DEFAULT_NOTFOUND_RSP_STRING      "UNKNOWN"
#define QATCLI_DEAFULT_NOTALLOWED_RSP_STRING    ":NOT ALLOWED"
#define QATCLI_DEFAULT_DEVID_STRING             "QuarkTS CLI"
#define QATCLI_DEFAULT_EOL_STRING               "\r\n"             
#define QATCLI_MIN_INPUT_LENGTH                 ( 3u )
#define QATCLI_RECOMMENDED_INPUT_SIZE           ( (size_t)128 )

#define QATCLI_CMDMASK_ARG_MAXNUM(opt)          ( ( (opt)>>4 ) & (qATCLI_Options_t)0x000Fu )
#define QATCLI_CMDMASK_ARG_MINNUM(opt)          ( (opt) & (qATCLI_Options_t)0x000Fu )

static qPutChar_t cli_OutCharFcn = NULL;
static qATCLI_Handler_t cli_CurrentCmdHelper = NULL;
static void qATCLI_Putc_Wrapper( const char c );
static void qATCLI_Puts_Wrapper( const char *s );
static size_t qATCLI_NumOfArgs( const char *str );
static char* qATCLI_Input_Fix( char *s, size_t maxlen );

static void qATCLI_HandleCommandResponse( qATCLI_t * const cli, const qATCLI_Response_t retval );
static qBool_t qATCLI_PreProcessing( qATCLI_Command_t * const cmd, char *inputBuffer, qATCLI_Handler_t params );
static qBool_t qATCLI_Notify( qATCLI_t * const cli );

/*helper methods inside <qATCLI_PreCmd_t> to retreive command arguments*/
static char* GetArgPtr( qIndex_t n );
static int GetArgInt( qIndex_t n );
static qFloat32_t GetArgFlt( qIndex_t n );
static qUINT32_t GetArgHex( qIndex_t n );
static char* GetArgString( qIndex_t n, char* pOut );

/*============================================================================*/
static qBool_t qATCLI_Notify( qATCLI_t * const cli )
{
    cli->qPrivate.Input.Ready = qTrue;
    cli->qPrivate.Input.index = 0u;
    if ( NULL != cli->qPrivate.xNotifyFcn ) { 
        cli->qPrivate.xNotifyFcn( cli ); /*external task notification if available*/
    }

    return qTrue;
}
/*============================================================================*/
static void qATCLI_Putc_Wrapper( const char c )
{
    cli_OutCharFcn( NULL, c );
}
/*============================================================================*/
static void qATCLI_Puts_Wrapper( const char *s )
{
    (void)qIOUtil_OutputString( cli_OutCharFcn, NULL, s, qFalse ); 
}
/*============================================================================*/
qBool_t qATCLI_Setup( qATCLI_t * const cli, const qPutChar_t outFcn, char *pInput, const size_t sizeInput, char *pOutput, const size_t sizeOutput, const char *identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != cli ) && ( NULL != outFcn) ) {
        (void)memset( cli, 0 , sizeof(qATCLI_t) );
        cli->qPrivate.First  = NULL;
        cli->qPrivate.OutputFcn = outFcn;
        cli->qPrivate.Identifier = ( NULL != identifier )? identifier : QATCLI_DEFAULT_DEVID_STRING;
        cli->qPrivate.OK_Response = ( NULL != OK_Response )? OK_Response : QATCLI_DEFAULT_OK_RSP_STRING;
        cli->qPrivate.ERROR_Response = ( NULL != ERROR_Response )? ERROR_Response : QATCLI_DEFAULT_ERROR_RSP_STRING;
        cli->qPrivate.NOTFOUND_Response = ( NULL != NOTFOUND_Response )? NOTFOUND_Response : QATCLI_DEFAULT_NOTFOUND_RSP_STRING;
        cli->qPrivate.term_EOL = ( NULL != term_EOL )? term_EOL : QATCLI_DEFAULT_EOL_STRING;
        cli->qPrivate.SizeOutput = sizeOutput;
        cli->qPrivate.Input.Buffer = (char*)pInput;
        cli->qPrivate.Input.Size = sizeInput;
        cli->qPrivate.Input.MaxIndex =  sizeInput - 1u;
        cli->qPrivate.Input.Ready = qFalse;
        cli->qPrivate.Input.index = 0u;
        cli->qPrivate.xNotifyFcn = NULL;
        cli->qPrivate.xPublic.Output = pOutput;
        cli->qPrivate.xPublic.putch = &qATCLI_Putc_Wrapper;
        cli->qPrivate.xPublic.puts = &qATCLI_Puts_Wrapper;
        cli->qPrivate.xPublic.GetArgPtr = &GetArgPtr;
        cli->qPrivate.xPublic.GetArgInt = &GetArgInt;
        cli->qPrivate.xPublic.GetArgFlt = &GetArgFlt;
        cli->qPrivate.xPublic.GetArgHex = &GetArgHex;
        cli->qPrivate.xPublic.GetArgString = &GetArgString;        
        /*Flush input and output buffers*/
        (void)memset( (void*)cli->qPrivate.Input.Buffer, 0, sizeInput );
        (void)memset( (void*)cli->qPrivate.xPublic.Output, 0, sizeOutput );
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qATCLI_CmdSubscribe( qATCLI_t * const cli, qATCLI_Command_t * const cmd, char *textCommand, const qATCLI_CommandCallback_t cFcn, qATCLI_Options_t cmdOpt, void *param )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != cli ) && ( NULL != cmd ) && ( NULL != textCommand ) && ( NULL != cFcn ) ) {
        (void)memset( cmd, 0, sizeof(qATCLI_Command_t) );
        cmd->qPrivate.CmdLen = qIOUtil_StrLen( textCommand, cli->qPrivate.Input.Size );        
        if ( cmd->qPrivate.CmdLen >= 2u ) {
            if ( ( 'a' == textCommand[ 0 ] ) && ( 't' == textCommand[ 1 ] ) ) { /*command should start with an <at> at the beginning */
                qATCLI_Command_t *iCommand = NULL;
                cmd->Text = (char*)textCommand;
                cmd->qPrivate.CommandCallback = cFcn; /*install the callback*/
                cmd->qPrivate.CmdOpt = 0x0FFFu & cmdOpt; /*high nibble not used yet*/
                cmd->param = param;
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
                if ( NULL != cli->qPrivate.First ) { /*list already has items*/
                    for ( iCommand = (qATCLI_Command_t*)cli->qPrivate.First ; NULL != iCommand ; iCommand = iCommand->qPrivate.Next ) {
                        if ( cmd == iCommand ) {
                            break;
                        }
                    }
                }
                if ( cmd != iCommand ) {
                    cmd->qPrivate.Next = (qATCLI_Command_t*)cli->qPrivate.First; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
                    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
                    cli->qPrivate.First = cmd; /*command inserted at the beginning of the list*/
                }
            }
        }
    } 

    return retValue;
}
/*============================================================================*/
qATCLI_Command_t* qATCLI_CmdIterate( qATCLI_t * const cli, qBool_t reload )
{
    static qATCLI_Command_t *iterator = NULL;
    qATCLI_Command_t *iCmd = NULL;

    if ( NULL != cli ) {
        if ( qTrue == reload ) {
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            iterator = (qATCLI_Command_t*)cli->qPrivate.First; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        } 
        else { 
            iCmd = iterator;
            if ( NULL != iterator ) {
                iterator = iCmd->qPrivate.Next; 
            }
        }
    }

    return iCmd;
} 
/*============================================================================*/
qBool_t qATCLI_ISRHandler( qATCLI_t * const cli, char c )
{
    qBool_t retValue = qFalse;
    
    if ( NULL != cli ) {
        qBool_t readyInput = cli->qPrivate.Input.Ready;
        /*cstat -MISRAC2012-Rule-13.5 -MISRAC2012-Dir-4.11_h*/ /*isgraph is known to have no side effects*/
        if ( ( qFalse == readyInput ) && ( 0 != isgraph( (int)c ) ) ) { /*check if the input is available and incoming chars are valid*/
        /*cstat +MISRAC2012-Rule-13.5 +MISRAC2012-Dir-4.11_h*/  
            qIndex_t currentIndex = cli->qPrivate.Input.index; /*to avoid undefined order of volatile accesses*/

            cli->qPrivate.Input.Buffer[ currentIndex++ ] = c; /*insert char*/
            cli->qPrivate.Input.Buffer[ currentIndex   ] = (char)'\0'; /*put the null-char after to keep the string safe*/
            if ( currentIndex >= cli->qPrivate.Input.MaxIndex ) { /*check if the input buffer its reached*/
                currentIndex = 0u;  
            }
            cli->qPrivate.Input.index = currentIndex;
        }
        if ( '\r' == c ) { /*end of line received, send the notification to the cli*/
            retValue = qATCLI_Notify( cli ); 
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qATCLI_ISRHandlerBlock( qATCLI_t * const cli, char *pData, const size_t n )
{
    qBool_t retValue = qFalse;

    if ( NULL != cli ) {
        qBool_t readyInput = cli->qPrivate.Input.Ready;
        size_t maxToInsert = cli->qPrivate.Input.MaxIndex;

        if ( ( n > 0u ) && ( n < maxToInsert ) &&  ( qFalse == readyInput ) ) { /**/
            if ( 1u == n ) { /*if a single char its incoming, just call the apropiated*/
                retValue = qATCLI_ISRHandler( cli, pData[ 0 ] );
            }
            else {
                /*cstat -MISRAC2012-Dir-4.11_h*/
                if ( 0 != isgraph( (int)pData[ 0 ] ) ) {
                /*cstat +MISRAC2012-Dir-4.11_h*/  
                    if ( NULL != qIOUtil_StrChr( pData, (int)'\r', maxToInsert ) ) { /*find the end of line safely*/
                        (void)qIOUtil_StrlCpy( (char*)cli->qPrivate.Input.Buffer, pData, maxToInsert ); /*safe string copy*/
                        retValue = qATCLI_Notify( cli );
                    }
                }
            }
        }
    }

    return retValue;
}
/*============================================================================*/
static char* qATCLI_Input_Fix( char *s, size_t maxlen ) /*modifies the input string removing non-graph chars */
{
    int i, j = 0;
    int noL = 0;
    
    for ( i = 0; ( (char)'\0' != s[ i ] ) && ( maxlen > 0u ) ; ++i ) {
        if ( ( '=' == s[ i ] ) || ( '?' == s[ i ] ) ) {
            noL = 1;    
        }
        if ( '\r' == s[ i ] ) {
            s[ i ] = (char)'\0';
            break;    
        } 
        /*cstat -MISRAC2012-Dir-4.11_h*/
        if ( 0 != isgraph( (int)s[ i ]) ) {
        /*cstat +MISRAC2012-Dir-4.11_h*/  
            if ( 0 == noL ) {
                s[ j++ ] = (char)tolower( (int)s[ i ] );
            }
            else {
                s[ j++ ] = s[ i ];
            }
        }
        --maxlen;
    }
    s[ j ] = (char)'\0';

    return s;
}
/*============================================================================*/
qBool_t qATCLI_Raise( qATCLI_t * const cli, const char *cmd )
{
    qBool_t retValue = qFalse;
    
    if ( ( NULL != cli ) && ( NULL != cmd ) ) {
        qBool_t readyInput = cli->qPrivate.Input.Ready;        
        size_t maxToInsert = cli->qPrivate.Input.MaxIndex;
        /*cstat -MISRAC2012-Rule-13.5 */
        if ( ( qFalse == readyInput ) && ( qIOUtil_StrLen( cmd, maxToInsert ) <= maxToInsert ) ) { /*qIOUtil_StrLen is known to have no side effects*/
        /*cstat +MISRAC2012-Rule-13.5 */  
            (void)qIOUtil_StrlCpy( (char*)cli->qPrivate.Input.Buffer, cmd, maxToInsert ); /*safe string copy*/
            (void)qATCLI_Input_Fix( (char*)cli->qPrivate.Input.Buffer, maxToInsert );
            retValue = qATCLI_Notify( cli );
        }
    } 

    return retValue;
}
/*============================================================================*/
qATCLI_Response_t qATCLI_Exec( qATCLI_t * const cli, char *cmd )
{
    qATCLI_Response_t retValue = qATCLI_NOTFOUND;
    if ( ( NULL != cli ) && ( NULL != cmd ) ) {
        qATCLI_Command_t *iCommand;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        for ( iCommand = (qATCLI_Command_t*)cli->qPrivate.First ; NULL != iCommand ; iCommand = iCommand->qPrivate.Next ) { /*loop over the subscribed commands*/ /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/  
            if ( 0 == strncmp( cmd, iCommand->Text, iCommand->qPrivate.CmdLen ) ) { /*check if the input match the subscribed command */
            	retValue = qATCLI_NOTALLOWED;
                if( qATCLI_PreProcessing( iCommand, (char*)cmd, &cli->qPrivate.xPublic ) ) { /*if success, proceed with the user pos-processing*/
                    qATCLI_CommandCallback_t cmdCallback = iCommand->qPrivate.CommandCallback;

                    if ( qATCLI_CMDTYPE_UNDEF == cli->qPrivate.xPublic.Type ) {
                        retValue = qATCLI_ERROR;
                    }
                    else {
                        cli_CurrentCmdHelper = &cli->qPrivate.xPublic;
                        cli_OutCharFcn = cli->qPrivate.OutputFcn;
                        retValue = cmdCallback( &cli->qPrivate.xPublic ); /*invoke the callback*/
                    }
                }
                break;
            }
        }
    }

    return retValue;
}
/*============================================================================*/
static qBool_t qATCLI_PreProcessing( qATCLI_Command_t * const cmd, char *inputBuffer, qATCLI_Handler_t params )
{
    qBool_t retValue = qFalse;
    
    params->Type = qATCLI_CMDTYPE_UNDEF;
    params->Command = cmd;
    params->StrLen = qIOUtil_StrLen( (const char*)inputBuffer, QATCLI_RECOMMENDED_INPUT_SIZE ) - cmd->qPrivate.CmdLen;
    params->StrData = (char*)&inputBuffer[ cmd->qPrivate.CmdLen ]; /*params->StrData = (char*)(InputBuffer+Command->qPrivate.CmdLen);*/
    params->NumArgs = 0u;

    if ( 0u == params->StrLen ) { /*command should be an ACT command */
        if ( 0u != ( cmd->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_ACT ) ) { /*check if is allowed*/
            params->Type = qATCLI_CMDTYPE_ACT;  /*set the type to ACT*/
            retValue = qTrue;
        }
    } 
    else if ( params->StrLen > 0u ) {
        if ( '?' == params->StrData[ 0 ] ) { /*command should be READ command */
            if ( 0u != ( cmd->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_READ ) ) { /*check if is allowed*/
                params->Type = qATCLI_CMDTYPE_READ; /*set the type to READ*/
                ++params->StrData; /*move string pointer once*/
                --params->StrLen;  /*decrease the len one*/
                retValue = qTrue;
            }
        } 
        else if ( params->StrLen >= 2u ) { /*can be at+xx=? or at+xx=...*/
            if ( '=' == params->StrData[ 0 ] ) { /*could be a TEST or PARA command*/
                if ( '?' == params->StrData[ 1 ] ) { 
                    if ( ( 2u == params->StrLen ) && ( 0u != ( cmd->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_TEST ) ) ) { /*command should be a TEST Command*/
                        params->Type = qATCLI_CMDTYPE_TEST; /*set the type to TEST*/
                        params->StrData += 2; /*move string two positions ahead*/
                        params->StrLen -= 2u;  /*decrease the len*/
                        retValue = qTrue;
                    }
                }
                else { /*definitely is a PARA command*/
                    if ( 0u != ( cmd->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_PARA ) ) { /*check if is allowed*/
                        size_t argMin, argMax;
                        
                        params->NumArgs = qATCLI_NumOfArgs( params->StrData ); /*get the args count using the default delimiter*/
                        argMin = QATCLI_CMDMASK_ARG_MINNUM( (size_t)cmd->qPrivate.CmdOpt );
                        argMax = QATCLI_CMDMASK_ARG_MAXNUM( (size_t)cmd->qPrivate.CmdOpt );
                        if ( ( params->NumArgs >= argMin ) && ( params->NumArgs <= argMax ) ) {
                            params->Type = qATCLI_CMDTYPE_PARA; /*set the type to PARA*/
                            ++params->StrData; /*move string pointer once*/
                            --params->StrLen; /*decrease the len one*/
                            retValue = qTrue;
                        }
                    }
                }
            }
        }
        else {
          /*nothing to do*/
        }
    }
    else {
        /*nothing to do*/
    }

    return retValue;
}
/*============================================================================*/
qBool_t qATCLI_Input_Flush( qATCLI_t * const cli )
{
    qBool_t retValue = qFalse;

    if ( NULL != cli ) {
        qATCLI_Input_t *xInput = &cli->qPrivate.Input;
        
        xInput->Ready = qFalse;
        xInput->index = 0u;
        xInput->Buffer[ 0 ] = (char)'\0';
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qATCLI_Run( qATCLI_t * const cli )
{
    qBool_t retValue = qFalse;

    if ( NULL != cli ) {
        qATCLI_Input_t *xInput =  &cli->qPrivate.Input;
        /*cstat -CERT-STR32-C*/
        if ( xInput->Ready ) { /*a new input has arrived*/
            qATCLI_Response_t outputRetval, CLIRetVal;
            char *inputBuffer = xInput->Buffer; /*to conform MISRAC2012-Rule-13.2_b*/
            
            inputBuffer[ xInput->MaxIndex ] = (char)'\0'; /*to perform string-safe operations */
            (void)qATCLI_Input_Fix( inputBuffer, xInput->Size ); /*remove non-graph chars*/
            /*Validation : set the value for the response lookup table*/
            if ( 0 == strncmp( (const char*)inputBuffer, QATCLI_DEFAULT_AT_COMMAND, xInput->Size ) ) {
            	outputRetval = qATCLI_OK;   /*check if the input its the simple AT command*/
            }
            else if ( qATCLI_NOTFOUND != ( CLIRetVal = qATCLI_Exec( cli, xInput->Buffer ) ) ) {
                outputRetval = CLIRetVal;	/*check if the input is one of the subscribed commands*/
            }
            else if ( 0 == strncmp( (const char*)inputBuffer, QATCLI_DEFAULT_ID_COMMAND, xInput->Size ) ) {
                outputRetval = qATCLI_DEVID;    /*check if the input its an ID request using the ATID command*/
            }
            else if ( qIOUtil_StrLen( (const char*)inputBuffer, xInput->Size ) >= QATCLI_MIN_INPUT_LENGTH ) {
                outputRetval = qATCLI_NOTFOUND; /*check if it is pertinent to show the error*/
            }
            else {
                outputRetval = qATCLI_NORESPONSE;   /*nothing to do*/
            }
            /*cstat +CERT-STR32-C*/
            if ( NULL != cli->qPrivate.xPublic.Output ) { /*show the user output if available*/
                if ( '\0' != cli->qPrivate.xPublic.Output[ 0 ] ) {
                    qATCLI_HandleCommandResponse( cli, qATCLI_OUTPUT );
                }
            }
            qATCLI_HandleCommandResponse( cli, outputRetval ); /*print out the command output*/
            cli->qPrivate.xPublic.Output[ 0 ] = (char)'\0';
            retValue = qATCLI_Input_Flush( cli ); /*flush buffers*/
        }
    }

    return retValue;
}
/*============================================================================*/
static void qATCLI_HandleCommandResponse( qATCLI_t * const cli, const qATCLI_Response_t retval )
{
    if ( qATCLI_NORESPONSE != retval ) {
        qPutChar_t putChar = cli->qPrivate.OutputFcn;

        switch ( retval ) { /*handle the command-callback response*/
            case qATCLI_ERROR:
                (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.ERROR_Response , qFalse ); 
                break;
            case qATCLI_OK:
                (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.OK_Response , qFalse );
                break;
            case qATCLI_NOTALLOWED:   
                (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.ERROR_Response , qFalse );
                (void)qIOUtil_OutputString( putChar, NULL, QATCLI_DEAFULT_NOTALLOWED_RSP_STRING , qFalse );
                break; 
            case qATCLI_DEVID:
                (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.Identifier , qFalse );
                break;
            case qATCLI_NOTFOUND:
                (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.NOTFOUND_Response , qFalse );
                break;        
            case qATCLI_OUTPUT:
                (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.xPublic.Output , qFalse );
                break;
            default: /*AT_ERRORCODE(#) */
                if ( (qBase_t)retval < 0 ) {
                    qINT32_t errorCode = qATCLI_ERRORCODE( (qINT32_t)retval );

                    (void)qIOUtil_ItoA( errorCode, cli->qPrivate.xPublic.Output, 10u );
                    (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.ERROR_Response , qFalse );
                    putChar( NULL, ':' );
                    (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.xPublic.Output , qFalse );
                    cli->qPrivate.xPublic.Output[ 0 ] = (char)'\0';
                }                            
                break;
        }
        (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.term_EOL , qFalse );
    }
}
/*============================================================================*/
static size_t qATCLI_NumOfArgs( const char *str )
{
    size_t count = 0u;
    
    while ( '\0' != *str ) {
        if ( (char)QATCLI_DEFAULT_ATSET_DELIM == (char)*str++ ) {
            ++count;
        }
    }

    return ( count + 1u );
}
/*============================================================================*/
static char* GetArgPtr( qIndex_t n )
{
    char *retPtr = NULL;

    if ( ( NULL != cli_CurrentCmdHelper ) && ( n > 0u ) ) {
        qATCLI_Handler_t param = cli_CurrentCmdHelper;

        if ( qATCLI_CMDTYPE_PARA == param->Type ) {
            if ( 1u == n ) {
                retPtr = param->StrData;
            } 
            else {
                qIndex_t i, argc = 0u;

                --n;
                for ( i = 0u ; '\0' != param->StrData[i] ; ++i ) {
                    if ( (char)QATCLI_DEFAULT_ATSET_DELIM == param->StrData[ i ] ) {
                        if ( ++argc >= (qIndex_t)n ) {
                            retPtr = param->StrData + i + 1;        
                            break;
                        }
                    }
                }
            }
        }
    }

    return retPtr;
}
/*============================================================================*/
static int GetArgInt( qIndex_t n )
{
    int retValue = 0;

    if ( NULL != cli_CurrentCmdHelper ) {
        /*cstat -CERT-STR34-C*/
        retValue =  (int)qIOUtil_AtoI( cli_CurrentCmdHelper->GetArgPtr( n ) );
        /*cstat +CERT-STR34-C*/
    }

    return retValue;    
}
/*============================================================================*/
static qFloat32_t GetArgFlt( qIndex_t n )
{
    qFloat32_t retValue = 0.0f;

    if ( NULL != cli_CurrentCmdHelper ) {
        retValue =  (qFloat32_t)qIOUtil_AtoF( cli_CurrentCmdHelper->GetArgPtr( n ) );
    }

    return retValue;  
}
/*============================================================================*/
static qUINT32_t GetArgHex( qIndex_t n )
{
    qUINT32_t retValue = 0uL;

    if ( NULL != cli_CurrentCmdHelper ) {
        /*cstat -CERT-STR34-C*/
        retValue = (qUINT32_t)qIOUtil_XtoU32( cli_CurrentCmdHelper->GetArgPtr( n ) );
        /*cstat +CERT-STR34-C*/ 
    }

    return retValue;  
}
/*============================================================================*/
static char* GetArgString( qIndex_t n, char* pOut )
{
    char *retPtr = NULL;
    
    if ( ( NULL != cli_CurrentCmdHelper ) && ( NULL != pOut ) && ( n > 0u ) ) {
        qATCLI_Handler_t param = cli_CurrentCmdHelper;

        if ( qATCLI_CMDTYPE_PARA ==  param->Type ) {
            qIndex_t i, j, argc = 0u;

            --n;
            j = 0u;
            /*cstat -CERT-STR34-C*/
            for ( i = 0u ; (char)'\0' != param->StrData[ i ]; ++i ) {
                if ( argc == n ) {
                    retPtr = pOut;
                    if ( ( argc > n ) || ( QATCLI_DEFAULT_ATSET_DELIM == param->StrData[ i ] ) ) {
                        break;
                    } 
                    pOut[ j++ ] = param->StrData[ i ];
                    pOut[ j ] = '\0';
                }
                if ( QATCLI_DEFAULT_ATSET_DELIM == param->StrData[ i ] ) {
                    ++argc;
                }
            /*cstat +CERT-STR34-C*/
            }
        }
    }
    
    return retPtr;
}
/*============================================================================*/
#endif /* #if ( Q_ATCLI == 1 ) */
