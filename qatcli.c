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
static char* qATCLI_Input_Fix( char *s,
                               size_t maxlen );

static void qATCLI_HandleCommandResponse( qATCLI_t * const cli,
                                          const qATCLI_Response_t retval );
static qBool_t qATCLI_PreProcessing( qATCLI_Command_t * const cmd,
                                     char *inputBuffer,
                                     qATCLI_Handler_t params );
static qBool_t qATCLI_Notify( qATCLI_t * const cli );

/*helper methods inside <qATCLI_PreCmd_t> to retreive command arguments*/
static char* GetArgPtr( qIndex_t n );
static int GetArgInt( qIndex_t n );
static qFloat32_t GetArgFlt( qIndex_t n );
static qUINT32_t GetArgHex( qIndex_t n );
static char* GetArgString( qIndex_t n,
                           char* pOut );

/*============================================================================*/
static qBool_t qATCLI_Notify( qATCLI_t * const cli )
{
    cli->qPrivate.xInput.ready = qTrue;
    cli->qPrivate.xInput.index = 0u;
    if ( NULL != cli->qPrivate.xNotifyFcn ) {
        /*external task notification if available*/
        cli->qPrivate.xNotifyFcn( cli );
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
qBool_t qATCLI_SetBuiltInString( qATCLI_t * const cli,
                                 qATCLI_BuiltInString_t which,
                                 const char *str )
{
    qBool_t retValue = qTrue;

    if ( NULL != cli ) {
        switch ( which ) {
            case QATCLI_BUILTIN_STR_IDENTIFIER:
                cli->qPrivate.id_rsp = ( NULL != str )? str
                                                      : QATCLI_DEFAULT_DEVID_STRING;
                break;
            case QATCLI_BUILTIN_STR_OK_RESPONSE:
                cli->qPrivate.ok_rsp = ( NULL != str )? str
                                                      : QATCLI_DEFAULT_OK_RSP_STRING;
                break;
            case QATCLI_BUILTIN_STR_ERROR_RESPONSE:
                cli->qPrivate.er_rsp = ( NULL != str )? str
                                                       : QATCLI_DEFAULT_ERROR_RSP_STRING;
                break;
            case QATCLI_BUILTIN_STR_NOTFOUND_RESPONSE:
                cli->qPrivate.nf_rsp = ( NULL != str )? str
                                                      : QATCLI_DEFAULT_NOTFOUND_RSP_STRING;
                break;
            case QATCLI_BUILTIN_STR_TERM_EOL:
                cli->qPrivate.eol = ( NULL != str )? str
                                                   : QATCLI_DEFAULT_EOL_STRING;
                break;
            default:
                retValue = qFalse;
                break;
        }
    }
    else {
        retValue = qFalse;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qATCLI_Setup( qATCLI_t * const cli,
                      const qPutChar_t outFcn,
                      char *pInput,
                      const size_t sizeInput,
                      char *pOutput,
                      const size_t sizeOutput )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != cli ) && ( NULL != outFcn) ) {
        (void)memset( cli, 0 , sizeof(qATCLI_t) );
        cli->qPrivate.first = NULL;
        cli->qPrivate.outputFcn = outFcn;
        cli->qPrivate.id_rsp = QATCLI_DEFAULT_DEVID_STRING;
        cli->qPrivate.ok_rsp = QATCLI_DEFAULT_OK_RSP_STRING;
        cli->qPrivate.er_rsp = QATCLI_DEFAULT_ERROR_RSP_STRING;
        cli->qPrivate.nf_rsp = QATCLI_DEFAULT_NOTFOUND_RSP_STRING;
        cli->qPrivate.eol = QATCLI_DEFAULT_EOL_STRING;
        cli->qPrivate.sizeOutput = sizeOutput;
        cli->qPrivate.xInput.storage = (char*)pInput;
        cli->qPrivate.xInput.size = sizeInput;
        cli->qPrivate.xInput.maxIndex = sizeInput - 1u;
        cli->qPrivate.xInput.ready = qFalse;
        cli->qPrivate.xInput.index = 0u;
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
        (void)memset( (void*)cli->qPrivate.xInput.storage, 0, sizeInput );
        (void)memset( (void*)cli->qPrivate.xPublic.Output, 0, sizeOutput );
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qATCLI_CmdSubscribe( qATCLI_t * const cli,
                             qATCLI_Command_t * const cmd,
                             char *textCommand,
                             const qATCLI_CommandCallback_t cFcn,
                             qATCLI_Options_t cmdOpt,
                             void *param )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != cli ) && ( NULL != cmd ) && ( NULL != textCommand ) && ( NULL != cFcn ) ) {
        (void)memset( cmd, 0, sizeof(qATCLI_Command_t) );
        cmd->qPrivate.cmdLen = qIOUtil_StrLen( textCommand, cli->qPrivate.xInput.size );
        if ( cmd->qPrivate.cmdLen >= 2u ) {
            /*command should start with an <at> at the beginning */
            if ( ( 'a' == textCommand[ 0 ] ) && ( 't' == textCommand[ 1 ] ) ) {
                qATCLI_Command_t *iCmd = NULL;
                cmd->Text = (char*)textCommand;
                cmd->qPrivate.cmdCallback = cFcn; /*install the callback*/
                cmd->qPrivate.cmdOpt = 0x0FFFu & cmdOpt; /*high nibble not used yet*/
                cmd->param = param;
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
                if ( NULL != cli->qPrivate.first ) { /*list already has items*/
                    for ( iCmd = (qATCLI_Command_t*)cli->qPrivate.first ; NULL != iCmd ; iCmd = iCmd->qPrivate.next ) {
                        if ( cmd == iCmd ) {
                            break;
                        }
                    }
                }
                if ( cmd != iCmd ) {
                    cmd->qPrivate.next = (qATCLI_Command_t*)cli->qPrivate.first; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
                    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
                    /*command inserted at the beginning of the list*/
                    cli->qPrivate.first = cmd;
                }
            }
        }
    }

    return retValue;
}
/*============================================================================*/
qATCLI_Command_t* qATCLI_CmdIterate( qATCLI_t * const cli,
                                     const qBool_t reload )
{
    static qATCLI_Command_t *iterator = NULL;
    qATCLI_Command_t *iCmd = NULL;

    if ( NULL != cli ) {
        if ( qTrue == reload ) {
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            iterator = (qATCLI_Command_t*)cli->qPrivate.first; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        }
        else {
            iCmd = iterator;
            if ( NULL != iterator ) {
                iterator = iCmd->qPrivate.next;
            }
        }
    }

    return iCmd;
}
/*============================================================================*/
qBool_t qATCLI_ISRHandler( qATCLI_t * const cli,
                           const char c )
{
    qBool_t retValue = qFalse;

    if ( NULL != cli ) {
        qBool_t readyInput = cli->qPrivate.xInput.ready;
        /*cstat -MISRAC2012-Rule-13.5 -MISRAC2012-Dir-4.11_h*/
        /*isgraph is known to have no-side effects*/
        /*check if the input is available and incoming chars are valid*/
        if ( ( qFalse == readyInput ) && ( 0 != isgraph( (int)c ) ) ) {
        /*cstat +MISRAC2012-Rule-13.5 +MISRAC2012-Dir-4.11_h*/
            /*to avoid undefined order of volatile accesses*/
            qIndex_t currentIndex = cli->qPrivate.xInput.index;

            cli->qPrivate.xInput.storage[ currentIndex++ ] = c; /*insert char*/
            /*put the null-char after to keep the string safe*/
            cli->qPrivate.xInput.storage[ currentIndex ] = (char)'\0';
            /*check if the input buffer its reached*/
            if ( currentIndex >= cli->qPrivate.xInput.maxIndex ) {
                currentIndex = 0u;
            }
            cli->qPrivate.xInput.index = currentIndex;
        }
        if ( '\r' == c ) {
            /*end of line received, send the notification to the cli*/
            retValue = qATCLI_Notify( cli );
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qATCLI_ISRHandlerBlock( qATCLI_t * const cli,
                                char *pData,
                                const size_t n )
{
    qBool_t retValue = qFalse;

    if ( NULL != cli ) {
        qBool_t readyInput = cli->qPrivate.xInput.ready;
        size_t maxToInsert = cli->qPrivate.xInput.maxIndex;

        if ( ( n > 0u ) && ( n < maxToInsert ) &&  ( qFalse == readyInput ) ) {
            if ( 1u == n ) {
                retValue = qATCLI_ISRHandler( cli, pData[ 0 ] );
            }
            else {
                /*cstat -MISRAC2012-Dir-4.11_h*/
                if ( 0 != isgraph( (int)pData[ 0 ] ) ) {
                /*cstat +MISRAC2012-Dir-4.11_h*/
                    /*find the end of line safely*/
                    if ( NULL != qIOUtil_StrChr( pData, (int)'\r', maxToInsert ) ) {
                        (void)qIOUtil_StrlCpy( (char*)cli->qPrivate.xInput.storage,
                                               pData,
                                               maxToInsert );
                        retValue = qATCLI_Notify( cli );
                    }
                }
            }
        }
    }

    return retValue;
}
/*============================================================================*/
static char* qATCLI_Input_Fix( char *s,
                               size_t maxlen )
{
    int i, j = 0;
    int noL = 0;

    for ( i = 0 ; ( (char)'\0' != s[ i ] ) && ( maxlen > 0u ) ; ++i ) {
        if ( ( '=' == s[ i ] ) || ( '?' == s[ i ] ) ) {
            noL = 1;
        }
        if ( '\r' == s[ i ] ) {
            s[ i ] = (char)'\0';
            break;
        }
        /*cstat -MISRAC2012-Dir-4.11_h*/
        if ( 0 != isgraph( (int)s[ i ] ) ) {
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
qBool_t qATCLI_Raise( qATCLI_t * const cli,
                      const char *cmd )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != cli ) && ( NULL != cmd ) ) {
        qBool_t readyInput = cli->qPrivate.xInput.ready;
        size_t maxToInsert = cli->qPrivate.xInput.maxIndex;
        /*cstat -MISRAC2012-Rule-13.5 */
        /*qIOUtil_StrLen is known to have no side effects*/
        if ( ( qFalse == readyInput ) && ( qIOUtil_StrLen( cmd, maxToInsert ) <= maxToInsert ) ) {
        /*cstat +MISRAC2012-Rule-13.5 */
            (void)qIOUtil_StrlCpy( (char*)cli->qPrivate.xInput.storage,
                                   cmd,
                                   maxToInsert );
            (void)qATCLI_Input_Fix( (char*)cli->qPrivate.xInput.storage, maxToInsert );
            retValue = qATCLI_Notify( cli );
        }
    }

    return retValue;
}
/*============================================================================*/
qATCLI_Response_t qATCLI_Exec( qATCLI_t * const cli,
                               char *cmd )
{
    qATCLI_Response_t retValue = qATCLI_NOTFOUND;
    if ( ( NULL != cli ) && ( NULL != cmd ) ) {
        qATCLI_Command_t *iCmd;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /*loop over the subscribed commands*/
        for ( iCmd = (qATCLI_Command_t*)cli->qPrivate.first ; NULL != iCmd ; iCmd = iCmd->qPrivate.next ) { /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            /*check if the input matches the subscribed command */
            if ( 0 == strncmp( cmd, iCmd->Text, iCmd->qPrivate.cmdLen ) ) {
                retValue = qATCLI_NOTALLOWED;
                if( qATCLI_PreProcessing( iCmd, (char*)cmd, &cli->qPrivate.xPublic ) ) {
                    /*if success, proceed with the user pos-processing*/
                    qATCLI_CommandCallback_t cmdCallback = iCmd->qPrivate.cmdCallback;

                    if ( qATCLI_CMDTYPE_UNDEF == cli->qPrivate.xPublic.Type ) {
                        retValue = qATCLI_ERROR;
                    }
                    else {
                        cli_CurrentCmdHelper = &cli->qPrivate.xPublic;
                        cli_OutCharFcn = cli->qPrivate.outputFcn;
                        /*invoke the callback*/
                        retValue = cmdCallback( &cli->qPrivate.xPublic );
                    }
                }
                break;
            }
        }
    }

    return retValue;
}
/*============================================================================*/
static qBool_t qATCLI_PreProcessing( qATCLI_Command_t * const cmd,
                                     char *inputBuffer,
                                     qATCLI_Handler_t params )
{
    qBool_t retValue = qFalse;

    params->Type = qATCLI_CMDTYPE_UNDEF;
    params->Command = cmd;
    params->StrLen = qIOUtil_StrLen( (const char*)inputBuffer,
                                     QATCLI_RECOMMENDED_INPUT_SIZE ) -
                                     cmd->qPrivate.cmdLen;
    params->StrData = (char*)&inputBuffer[ cmd->qPrivate.cmdLen ];
    params->NumArgs = 0u;

    if ( 0u == params->StrLen ) { /*command should be an ACT command */
        if ( 0u != ( cmd->qPrivate.cmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_ACT ) ) {
            params->Type = qATCLI_CMDTYPE_ACT;  /*set the type to ACT*/
            retValue = qTrue;
        }
    }
    else if ( params->StrLen > 0u ) {
        if ( '?' == params->StrData[ 0 ] ) { /*command should be READ command */
            if ( 0u != ( cmd->qPrivate.cmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_READ ) ) {
                params->Type = qATCLI_CMDTYPE_READ; /*set the type to READ*/
                ++params->StrData; /*move string pointer once*/
                --params->StrLen;  /*decrease the len one*/
                retValue = qTrue;
            }
        }
        else if ( params->StrLen >= 2u ) { /*can be at+xx=? or at+xx=...*/
            if ( '=' == params->StrData[ 0 ] ) { /*could be a TEST or PARA command*/
                if ( '?' == params->StrData[ 1 ] ) {
                    if ( ( 2u == params->StrLen ) && ( 0u != ( cmd->qPrivate.cmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_TEST ) ) ) {
                        /*command should be a TEST Command*/
                        params->Type = qATCLI_CMDTYPE_TEST; /*set the type to TEST*/
                        params->StrData += 2; /*move string two positions ahead*/
                        params->StrLen -= 2u;  /*decrease the len*/
                        retValue = qTrue;
                    }
                }
                else { /*definitely is a PARA command*/
                    if ( 0u != ( cmd->qPrivate.cmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_PARA ) ) { /*check if is allowed*/
                        size_t argMin, argMax;
                        /*get the args count using the default delimiter*/
                        params->NumArgs = qATCLI_NumOfArgs( params->StrData );
                        argMin = QATCLI_CMDMASK_ARG_MINNUM( (size_t)cmd->qPrivate.cmdOpt );
                        argMax = QATCLI_CMDMASK_ARG_MAXNUM( (size_t)cmd->qPrivate.cmdOpt );
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
        qATCLI_Input_t *xInput = &cli->qPrivate.xInput;

        xInput->ready = qFalse;
        xInput->index = 0u;
        xInput->storage[ 0 ] = (char)'\0';
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qATCLI_Run( qATCLI_t * const cli )
{
    qBool_t retValue = qFalse;

    if ( NULL != cli ) {
        qATCLI_Input_t *xInput = &cli->qPrivate.xInput;
        /*cstat -CERT-STR32-C*/
        if ( xInput->ready ) { /*a new input has arrived*/
            qATCLI_Response_t outRetval, cliRetVal;
            char *inputBuffer = xInput->storage; /*to conform MISRAC2012-Rule-13.2_b*/

            inputBuffer[ xInput->maxIndex ] = (char)'\0';
            /*remove non-graph chars*/
            (void)qATCLI_Input_Fix( inputBuffer, xInput->size );
            /*Validation : set the value for the response lookup table*/
            if ( 0 == strncmp( (const char*)inputBuffer, QATCLI_DEFAULT_AT_COMMAND, xInput->size ) ) {
                outRetval = qATCLI_OK;
            }
            else if ( qATCLI_NOTFOUND != ( cliRetVal = qATCLI_Exec( cli, xInput->storage ) ) ) {
                /*input is one of the subscribed commands*/
                outRetval = cliRetVal;
            }
            else if ( 0 == strncmp( (const char*)inputBuffer, QATCLI_DEFAULT_ID_COMMAND, xInput->size ) ) {
                outRetval = qATCLI_DEVID;
            }
            else if ( qIOUtil_StrLen( (const char*)inputBuffer, xInput->size ) >= QATCLI_MIN_INPUT_LENGTH ) {
                outRetval = qATCLI_NOTFOUND;
            }
            else {
                outRetval = qATCLI_NORESPONSE; /*nothing to do*/
            }
            /*cstat +CERT-STR32-C*/
            /*show the user output if available*/
            if ( NULL != cli->qPrivate.xPublic.Output ) {
                if ( '\0' != cli->qPrivate.xPublic.Output[ 0 ] ) {
                    qATCLI_HandleCommandResponse( cli, qATCLI_OUTPUT );
                }
            }
            /*print out the command output*/
            qATCLI_HandleCommandResponse( cli, outRetval );
            cli->qPrivate.xPublic.Output[ 0 ] = (char)'\0';
            retValue = qATCLI_Input_Flush( cli ); /*flush buffers*/
        }
    }

    return retValue;
}
/*============================================================================*/
static void qATCLI_HandleCommandResponse( qATCLI_t * const cli,
                                          const qATCLI_Response_t retval )
{
    if ( qATCLI_NORESPONSE != retval ) {
        qPutChar_t putChar = cli->qPrivate.outputFcn;

        switch ( retval ) { /*handle the command-callback response*/
            case qATCLI_ERROR:
                (void)qIOUtil_OutputString( putChar,
                                            NULL,
                                            cli->qPrivate.er_rsp,
                                            qFalse );
                break;
            case qATCLI_OK:
                (void)qIOUtil_OutputString( putChar,
                                            NULL,
                                            cli->qPrivate.ok_rsp,
                                            qFalse );
                break;
            case qATCLI_NOTALLOWED:
                (void)qIOUtil_OutputString( putChar,
                                            NULL,
                                            cli->qPrivate.er_rsp,
                                            qFalse );
                (void)qIOUtil_OutputString( putChar,
                                            NULL,
                                            QATCLI_DEAFULT_NOTALLOWED_RSP_STRING,
                                            qFalse );
                break;
            case qATCLI_DEVID:
                (void)qIOUtil_OutputString( putChar,
                                            NULL,
                                            cli->qPrivate.id_rsp,
                                            qFalse );
                break;
            case qATCLI_NOTFOUND:
                (void)qIOUtil_OutputString( putChar,
                                            NULL,
                                            cli->qPrivate.nf_rsp,
                                            qFalse );
                break;
            case qATCLI_OUTPUT:
                (void)qIOUtil_OutputString( putChar,
                                            NULL,
                                            cli->qPrivate.xPublic.Output,
                                            qFalse );
                break;
            default: /*AT_ERRORCODE(#) */
                if ( (qBase_t)retval < 0 ) {
                    const qINT32_t errorCode = qATCLI_ERRORCODE( (qINT32_t)retval );

                    (void)qIOUtil_ItoA( errorCode, cli->qPrivate.xPublic.Output, 10u );
                    (void)qIOUtil_OutputString( putChar,
                                                NULL,
                                                cli->qPrivate.er_rsp,
                                                qFalse );
                    putChar( NULL, ':' );
                    (void)qIOUtil_OutputString( putChar,
                                                NULL,
                                                cli->qPrivate.xPublic.Output,
                                                qFalse );
                    cli->qPrivate.xPublic.Output[ 0 ] = (char)'\0';
                }
                break;
        }
        (void)qIOUtil_OutputString( putChar, NULL, cli->qPrivate.eol , qFalse );
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
                for ( i = 0u ; '\0' != param->StrData[ i ] ; ++i ) {
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
        retValue = (int)qIOUtil_AtoI( cli_CurrentCmdHelper->GetArgPtr( n ) );
        /*cstat +CERT-STR34-C*/
    }

    return retValue;
}
/*============================================================================*/
static qFloat32_t GetArgFlt( qIndex_t n )
{
    qFloat32_t retValue = 0.0f;

    if ( NULL != cli_CurrentCmdHelper ) {
        retValue = (qFloat32_t)qIOUtil_AtoF( cli_CurrentCmdHelper->GetArgPtr( n ) );
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
static char* GetArgString( qIndex_t n,
                           char* pOut )
{
    char *retPtr = NULL;

    if ( ( NULL != cli_CurrentCmdHelper ) && ( NULL != pOut ) && ( n > 0u ) ) {
        qATCLI_Handler_t param = cli_CurrentCmdHelper;

        if ( qATCLI_CMDTYPE_PARA == param->Type ) {
            qIndex_t i, j, argc = 0u;

            --n;
            j = 0u;
            /*cstat -CERT-STR34-C*/
            for ( i = 0u ; (char)'\0' != param->StrData[ i ] ; ++i ) {
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
