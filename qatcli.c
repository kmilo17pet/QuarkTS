#include "qatcli.h"

#if ( Q_ATCLI == 1)

#define QATCLI_CMDMASK_ARG_MAXNUM(opt)   ( ( (opt)>>4 ) & (qATCLI_Options_t)0x000Fu )
#define QATCLI_CMDMASK_ARG_MINNUM(opt)   ( (opt) & (qATCLI_Options_t)0x000Fu )

static qPutChar_t cli_OutCharFcn = NULL;
static qATCLI_Handler_t cli_CurrentCmdHelper = NULL;
static void qATCLI_Putc_Wrapper( const char c );
static void qATCLI_Puts_Wrapper( const char *s );
static size_t qATCLI_NumOfArgs( const char *str );
static char* qATCLI_Input_Fix( char *s, size_t maxlen );

static void qATCLI_HandleCommandResponse( qATCLI_t * const cli, const qATCLI_Response_t retval );
static qBool_t qATCLI_PreProcessing( qATCLI_Command_t * const Command, char *InputBuffer, qATCLI_Handler_t params );
static qBool_t qATCLI_Notify( qATCLI_t * const cli );

/*helper methods inside <qATCLI_PreCmd_t> to retreive command arguments*/
static char* GetArgPtr( qIndex_t n );
static int GetArgInt( qIndex_t n );
static qFloat32_t GetArgFlt( qIndex_t n );
static qUINT32_t GetArgHex( qIndex_t n );
static char* GetArgString( qIndex_t n, char* out );

/*============================================================================*/
static qBool_t qATCLI_Notify( qATCLI_t * const cli ){
    cli->qPrivate.Input.Ready = qTrue;
    cli->qPrivate.Input.index = 0u;
    if( NULL != cli->qPrivate.xNotifyFcn ){ 
        cli->qPrivate.xNotifyFcn( cli ); /*external task notification if available*/
    }
    return qTrue;
}
/*============================================================================*/
static void qATCLI_Putc_Wrapper( const char c ){
    cli_OutCharFcn( NULL, c );
}
/*============================================================================*/
static void qATCLI_Puts_Wrapper( const char *s ){
    qIndex_t i = 0u;

    while( (char)'\0' != s[ i ] ){
        cli_OutCharFcn( NULL, s[ i++ ] );
    }
}
/*============================================================================*/
/*qBool_t qATCLI_Setup( qATCLI_t * const cli, const qPutChar_t OutputFcn, 
                                char *Input, const size_t SizeInput, char *Output, const size_t SizeOutput, 
                                const char *Identifier, const char *OK_Response, const char *ERROR_Response, 
                                const char *NOTFOUND_Response, const char *term_EOL )
 
Setup an instance of the AT Command Command Line Interface.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - OutputFcn : The basic output-char wrapper function. All the CLI responses 
                   will be printed-out through this function.
    - Input : A memory location to store the cli input (Mandatory)
    - SizeInput: The size of the memory allocated in <Input> 
    - Output: A memory location to store the CLI output
    - SizeOutput : The size of the memory allocated in <Output> 
    - Identifier: The device identifier string. This string will be printed-out
                  after a call to the ATCLI_DEFAULT_ID_COMMAND
    - OK_Response: The output message when a command callback returns QATCLI_OK.  
    - ERROR_Response: The output message when a command callback returns QATCLI_ERROR or any
                      QATCLI_ERRORCODE(#)
    - NOTFOUND_Response: The output message when input doesn't match with any of 
                         the available commands
    - term_EOL: The End-Of-Line string printed out after any of the CLI messages 
  
Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qATCLI_Setup( qATCLI_t * const cli, const qPutChar_t OutputFcn, char *Input, const size_t SizeInput, char *Output, const size_t SizeOutput, const char *Identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL ){
    qBool_t RetValue = qFalse;

    if(  ( NULL != cli ) && ( NULL != OutputFcn) ) {
        cli->qPrivate.First  = NULL;
        cli->qPrivate.OutputFcn = OutputFcn;
        cli->qPrivate.Identifier = Identifier;
        cli->qPrivate.OK_Response = OK_Response;
        cli->qPrivate.ERROR_Response = ERROR_Response;
        cli->qPrivate.NOTFOUND_Response = NOTFOUND_Response;
        cli->qPrivate.term_EOL = term_EOL;
        cli->qPrivate.SizeOutput = SizeOutput;
        cli->qPrivate.Input.Buffer = (char*)Input;
        cli->qPrivate.Input.Size = SizeInput;
        cli->qPrivate.Input.MaxIndex =  SizeInput - 1u;
        cli->qPrivate.Input.Ready = qFalse;
        cli->qPrivate.Input.index = 0u;
        cli->qPrivate.xNotifyFcn = NULL;
        cli->qPrivate.xPublic.Output = Output;
        cli->qPrivate.xPublic.putch = &qATCLI_Putc_Wrapper;
        cli->qPrivate.xPublic.puts = &qATCLI_Puts_Wrapper;
        cli->qPrivate.xPublic.GetArgPtr = &GetArgPtr;
        cli->qPrivate.xPublic.GetArgInt = &GetArgInt;
        cli->qPrivate.xPublic.GetArgFlt = &GetArgFlt;
        cli->qPrivate.xPublic.GetArgHex = &GetArgHex;
        cli->qPrivate.xPublic.GetArgString = &GetArgString;        
        /*Flush input and output buffers*/
        (void)memset( (void*)cli->qPrivate.Input.Buffer, 0, SizeInput );
        (void)memset( (void*)cli->qPrivate.xPublic.Output, 0, SizeOutput );
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qATCLI_CmdSubscribe( qATCLI_t * const cli, qATCLI_Command_t * const Command, const char *TextCommand, const qATCLI_CommandCallback_t Callback, qATCLI_Options_t CmdOpt, void *param )
 
This function subscribes the CLI instance to a specific command with an associated callback function,
so that next time the required command is sent to the CLI input, the callback function will be
executed. 
The CLI module only analyze commands that follows the extended AT-Commands syntax (+ can be ignored).

Parameters:

    - cli : A pointer to the AT Command Line Inteface instance
    - Command : A pointer to the AT command object.
    - TextCommand: The string (name) of the command we want to subscribe to. 
                    Since this service only handles AT commands, this string has 
                    to begin by the "at" characters and should be in lower case.
    - Callback: The handler of the callback function associated to the command.
    			Prototype: qATCLI_Response_t xCallback( qATCLI_Handler_t )
    - CmdOpt : This flag combines with a bitwise OR the following information:
                
                > QATCLI_CMDTYPE_PARA  : "AT+cmd=x,y" is allowed. The execution of the callback
                                     function also depends on whether the number of argument 
                                     is valid or not. Information about number of arguments is
                                     combined with a bitwise 'OR' : QATCMDTYPE_PARA | 0xXY , 
                                     where X which defines maximum argument number for incoming
                                     command and Y which defines minimum argument number for 
                                     incoming command
                > QATCLI_CMDTYPE_TEST  : "AT+cmd=?" is allowed. 
                > QATCLI_CMDTYPE_READ  : "AT+cmd?" is allowed.  
                > QATCLI_CMDTYPE_ACT   : "AT+cmd" is allowed.   
    - param : User storage pointer.
Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qATCLI_CmdSubscribe( qATCLI_t * const cli, qATCLI_Command_t * const Command, char *TextCommand, const qATCLI_CommandCallback_t Callback, qATCLI_Options_t CmdOpt, void *param ){
    qBool_t RetValue = qFalse;

    if( ( NULL != cli ) && ( NULL != Command ) && ( NULL != TextCommand ) && ( NULL != Callback ) ){
        Command->qPrivate.CmdLen = qIOUtil_StrLen( TextCommand, cli->qPrivate.Input.Size );        
        if( Command->qPrivate.CmdLen >= 2u ){
            if( ( 'a' == TextCommand[ 0 ] ) && ( 't' == TextCommand[ 1 ] ) ) { /*command should start with an <at> at the beginning */
                Command->Text = (char*)TextCommand;
                Command->qPrivate.CommandCallback = Callback; /*install the callback*/
                Command->qPrivate.CmdOpt = 0x0FFFu & CmdOpt; /*high nibble not used yet*/
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
                Command->qPrivate.Next = cli->qPrivate.First; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
                /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
                Command->param = param;
                cli->qPrivate.First = Command; /*command inserted at the beginning of the list*/
                RetValue = qTrue;  
            }
        }
    } 
    return RetValue;
}
/*============================================================================*/
/*qATCLI_Command_t* qATCLI_CmdIterate( qATCLI_t * const cli, qBool_t reload )

Iterate between the commands available inside the AT-CLI instance.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - reload : If qTrue, the iterator will set their position at the beginning 

Return value:

    The current iterated command. NULL when no more commands are available

*/
qATCLI_Command_t* qATCLI_CmdIterate( qATCLI_t * const cli, qBool_t reload ){
    static qATCLI_Command_t *Iterator = NULL;
    qATCLI_Command_t *Cmd = NULL;

    if( NULL != cli ){
        if( qTrue == reload ){
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            Iterator = cli->qPrivate.First; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        } 
        else{ 
            Cmd = Iterator;
            if( NULL != Iterator ){
                Iterator = Cmd->qPrivate.Next; 
            }
        }
    }
    return Cmd;
} 
/*============================================================================*/
/*void qATCLI_ISRHandler( qATCLI_t * const cli, char c )
 
Feed the CLI input with a single character. This call is mandatory 
from an interrupt context. Put it inside the desired peripheral's ISR.
If your ISR get a block of data, use instead <qATCLI_ISRHandlerBlock>

Note: This API assumes that the respective ISR catch a single byte at a time.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - c : The incoming byte/char to the input. 

Return value:

    qTrue when the CLI is ready to process the input, otherwise return qFalse

*/
qBool_t qATCLI_ISRHandler( qATCLI_t * const cli, char c ){
    qBool_t RetValue = qFalse;
    
    if( NULL != cli ){
        qBool_t ReadyInput = cli->qPrivate.Input.Ready;
        /*cstat -MISRAC2012-Rule-13.5 -MISRAC2012-Dir-4.11_h*/ /*isgraph is known to have no side effects*/
        if( ( qFalse == ReadyInput ) && ( 0 != isgraph( (int)c ) ) ){ /*check if the input is available and incoming chars are valid*/
        /*cstat +MISRAC2012-Rule-13.5 +MISRAC2012-Dir-4.11_h*/  
            qIndex_t CurrentIndex = cli->qPrivate.Input.index; /*to avoid undefined order of volatile accesses*/

            cli->qPrivate.Input.Buffer[ CurrentIndex++ ] = c; /*insert char*/
            cli->qPrivate.Input.Buffer[ CurrentIndex   ] = (char)'\0'; /*put the null-char after to keep the string safe*/
            if( CurrentIndex >= cli->qPrivate.Input.MaxIndex ){ /*check if the input buffer its reached*/
                CurrentIndex = 0u;  
            }
            cli->qPrivate.Input.index = CurrentIndex;
        }
        if ( '\r' == c ){ /*end of line received, send the notification to the cli*/
            RetValue = qATCLI_Notify( cli ); 
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qATCLI_ISRHandlerBlock( qATCLI_t * const cli, char *Data, const size_t n )
Feed the CLI input with a string. This call is mandatory 
from an interrupt context. Put it inside the desired peripheral's ISR.
If your ISR only get a single char, use instead <qATCLI_ISRHandler>

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - Data : The incoming string.
    - n : The length of the string

Return value:

    qTrue when the CLI is ready to process the input, otherwise return qFalse

*/
qBool_t qATCLI_ISRHandlerBlock( qATCLI_t * const cli, char *Data, const size_t n ){
    qBool_t RetValue = qFalse;

    if( NULL != cli ){
        qBool_t ReadyInput = cli->qPrivate.Input.Ready;
        size_t MaxToInsert = cli->qPrivate.Input.MaxIndex;
        if( ( n > 0u ) && ( n < MaxToInsert ) &&  ( qFalse == ReadyInput ) ) { /**/
            if( 1u == n ){ /*if a single char its incoming, just call the apropiated*/
                RetValue = qATCLI_ISRHandler( cli, Data[ 0 ] );
            }
            else{
                /*cstat -MISRAC2012-Dir-4.11_h*/
                if( 0 != isgraph( (int)Data[ 0 ] ) ){
                /*cstat +MISRAC2012-Dir-4.11_h*/  
                    if( NULL != qIOUtil_StrChr( Data, (int)'\r', MaxToInsert ) ){ /*find the end of line safely*/
                        (void)qIOUtil_StrlCpy( (char*)cli->qPrivate.Input.Buffer, Data, MaxToInsert ); /*safe string copy*/
                        RetValue = qATCLI_Notify( cli );
                    }
                }
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
/*
modifies the input string removing non-graph chars 
*/
static char* qATCLI_Input_Fix( char *s, size_t maxlen ){
    int i, j = 0;
    int NoL = 0;
    
    for( i = 0; ( (char)'\0' != s[ i ] ) && ( maxlen > 0u ) ; ++i ){
        if( ( '=' == s[ i ] ) || ( '?' == s[ i ] ) ){
            NoL = 1;    
        }
        if( '\r' == s[ i ] ){
            s[ i ] = (char)'\0';
            break;    
        } 
        /*cstat -MISRAC2012-Dir-4.11_h*/
        if( 0 != isgraph( (int)s[ i ]) ){
        /*cstat +MISRAC2012-Dir-4.11_h*/  
            if( 0 == NoL ){
                s[ j++ ] = (char)tolower( (int)s[ i ] );
            }
            else{
                s[ j++ ] = s[ i ];
            }
        }
        --maxlen;
    }
    s[ j ] = (char)'\0';
    return s;
}
/*============================================================================*/
/*qBool_t qATCLI_Raise( qATCLI_t * const cli, const char *cmd )

Sends a command to the specified AT Command Line Interface instance.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - cmd : The command string, including arguments if required.

Return value:

    qTrue when the CLI accepts the input. If busy, return qFalse

*/
qBool_t qATCLI_Raise( qATCLI_t * const cli, const char *cmd ){
    qBool_t RetValue = qFalse;
    
    if( ( NULL != cli ) && ( NULL != cmd ) ){
        qBool_t ReadyInput = cli->qPrivate.Input.Ready;        
        size_t MaxToInsert = cli->qPrivate.Input.MaxIndex;
        /*cstat -MISRAC2012-Rule-13.5 */
        if( ( qFalse == ReadyInput ) && ( qIOUtil_StrLen( cmd, MaxToInsert ) <= MaxToInsert ) ){ /*qIOUtil_StrLen is known to have no side effects*/
        /*cstat +MISRAC2012-Rule-13.5 */  
            (void)qIOUtil_StrlCpy( (char*)cli->qPrivate.Input.Buffer, cmd, MaxToInsert ); /*safe string copy*/
            (void)qATCLI_Input_Fix( (char*)cli->qPrivate.Input.Buffer, MaxToInsert );
            RetValue = qATCLI_Notify( cli );
        }
    } 
    return RetValue;
}
/*============================================================================*/
/*qATCLI_Response_t qATCLI_Exec( qATCLI_t * const cli, char *cmd )

Try to execute the requested command.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - cmd : The command string, including arguments if required.

Return value:

    The response output for the requested command

*/
/*============================================================================*/
qATCLI_Response_t qATCLI_Exec( qATCLI_t * const cli, char *cmd ){
    qATCLI_Response_t RetValue = QATCLI_NOTFOUND;
    
    if( ( NULL != cli ) && ( NULL != cmd ) ){
        qATCLI_Command_t *Command;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/

        for( Command = (qATCLI_Command_t*)cli->qPrivate.First ; NULL != Command ; Command = Command->qPrivate.Next ){ /*loop over the subscribed commands*/ /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/  
            if( strstr( cmd, Command->Text ) == cmd ){ /*check if the input match the subscribed command starting from the beginning*/ /*TODO : potentially unsafe, find a better way*/
            	RetValue = qATCLI_NOTALLOWED;
                if( qATCLI_PreProcessing( Command, (char*)cmd, &cli->qPrivate.xPublic ) ){ /*if success, proceed with the user pos-processing*/
                    qATCLI_CommandCallback_t CmdCallback = Command->qPrivate.CommandCallback;

                    if( qATCLI_CMDTYPE_UNDEF == cli->qPrivate.xPublic.Type ){
                        RetValue = QATCLI_ERROR;
                    }
                    else{
                        cli_CurrentCmdHelper = &cli->qPrivate.xPublic;
		                cli_OutCharFcn = cli->qPrivate.OutputFcn;
                        RetValue = CmdCallback( &cli->qPrivate.xPublic ); /*invoke the callback*/
                    }
                }
                break;
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
static qBool_t qATCLI_PreProcessing( qATCLI_Command_t * const Command, char *InputBuffer, qATCLI_Handler_t params ){
    qBool_t RetValue = qFalse;
    
    params->Type = qATCLI_CMDTYPE_UNDEF;
    params->Command = Command;
    params->StrLen = qIOUtil_StrLen( (const char*)InputBuffer, QATCLI_RECOMMENDED_INPUT_SIZE ) - Command->qPrivate.CmdLen;
    params->StrData = (char*)&InputBuffer[ Command->qPrivate.CmdLen ]; /*params->StrData = (char*)(InputBuffer+Command->qPrivate.CmdLen);*/
    params->NumArgs = 0u;

    if( 0u == params->StrLen ){ /*command should be an ACT command */
        if( 0u != ( Command->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_ACT ) ){ /*check if is allowed*/
            params->Type = qATCLI_CMDTYPE_ACT;  /*set the type to ACT*/
            RetValue = qTrue;
        }
    } 
    else if ( params->StrLen > 0u ){
        if( '?' == params->StrData[ 0 ] ){ /*command should be READ command */
            if( 0u != ( Command->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_READ ) ){ /*check if is allowed*/
                params->Type = qATCLI_CMDTYPE_READ; /*set the type to READ*/
                ++params->StrData; /*move string pointer once*/
                --params->StrLen;  /*decrease the len one*/
                RetValue = qTrue;
            }
        } 
        else if( params->StrLen >= 2u ){ /*can be at+xx=? or at+xx=...*/
            if( '=' == params->StrData[ 0 ] ){ /*could be a TEST or PARA command*/
                if( '?' == params->StrData[ 1 ] ){ 
                    if( 2u == params->StrLen ){ /*command should be a TEST Command*/
                        if( 0u != ( Command->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_TEST ) ){ /*check if is allowed*/
                            params->Type = qATCLI_CMDTYPE_TEST; /*set the type to TEXT*/
                            params->StrData += 2; /*move string two positions ahead*/
                            params->StrLen -= 2u;  /*decrease the len*/
                            RetValue = qTrue;
                        }
                    }
                }
                else{ /*definitely is a PARA command*/
                    if( 0u != ( Command->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_PARA ) ){ /*check if is allowed*/
                        size_t argMin, argMax;
                        
                        params->NumArgs = qATCLI_NumOfArgs( params->StrData ); /*get the args count using the default delimiter*/
                        argMin = QATCLI_CMDMASK_ARG_MINNUM( (size_t)Command->qPrivate.CmdOpt );
                        argMax = QATCLI_CMDMASK_ARG_MAXNUM( (size_t)Command->qPrivate.CmdOpt );
                        if( ( params->NumArgs >= argMin ) && ( params->NumArgs <= argMax ) ){
                            params->Type = qATCLI_CMDTYPE_PARA; /*set the type to PARA*/
                            ++params->StrData; /*move string pointer once*/
                            --params->StrLen; /*decrease the len one*/
                            RetValue = qTrue;
                        }
                    }
                }
            }
        }
        else{
          /*nothing to do*/
        }
    }
    else{
        /*nothing to do*/
    }
    return RetValue;
}
/*============================================================================*/
void qATCLI_Input_Flush( qATCLI_t * const cli ){
    if( NULL != cli ){
        qATCLI_Input_t *Input = &cli->qPrivate.Input;
        Input->Ready = qFalse;
        Input->index = 0u;
        Input->Buffer[ 0 ] = (char)'\0';
    }
}
/*============================================================================*/
/*qBool_t qATCLI_Run( qATCLI_t * const cli )
 
Run the AT Command Line Interface when the input is ready.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance

Return value:

    qTrue on success, otherwise return qFalse

*/
qBool_t qATCLI_Run( qATCLI_t * const cli ){
    qBool_t RetValue = qFalse;

    if( NULL != cli ){
        qATCLI_Input_t *Input =  &cli->qPrivate.Input;
        /*cstat -CERT-STR32-C*/
        if( Input->Ready ){ /*a new input has arrived*/
            qATCLI_Response_t OutputRetval, CLIRetVal;
            char *InputBuffer = Input->Buffer; /*to conform MISRAC2012-Rule-13.2_b*/

            InputBuffer[ Input->MaxIndex ] = (char)'\0'; /*to perform string-safe operations */
            (void)qATCLI_Input_Fix( InputBuffer, Input->Size ); /*remove non-graph chars*/
			/*Validation : set the value for the response lookup table*/
			if 	( 0 == strncmp( (const char*)InputBuffer, QATCLI_DEFAULT_AT_COMMAND, Input->Size ) ){
            	OutputRetval = QATCLI_OK;			/*check if the input its the simple AT command*/
            }
			else if	( QATCLI_NOTFOUND != ( CLIRetVal = qATCLI_Exec( cli, Input->Buffer ) ) ){
                OutputRetval = CLIRetVal;	/*check if the input is one of the subscribed commands*/
            }
			else if ( 0 == strncmp( (const char*)InputBuffer, QATCLI_DEFAULT_ID_COMMAND, Input->Size ) ){
                OutputRetval = QATCLI_DEVID;		/*check if the input its an ID request using the ATID command*/
            }
			else if	( qIOUtil_StrLen( (const char*)InputBuffer, Input->Size ) >= QATCLI_MIN_INPUT_LENGTH ){
                OutputRetval = QATCLI_NOTFOUND;	/*check if it is pertinent to show the error*/
            }
			else{
                OutputRetval = QATCLI_NORESPONSE;  /*nothing to do*/
            }
            /*cstat +CERT-STR32-C*/
            if( NULL != cli->qPrivate.xPublic.Output ){ /*show the user output if available*/
            	if( '\0' != cli->qPrivate.xPublic.Output[ 0 ] ){
                    qATCLI_HandleCommandResponse( cli, QATCLI_OUTPUT );
                }
            }
            qATCLI_HandleCommandResponse( cli, OutputRetval ); /*print out the command output*/
            qATCLI_Input_Flush( cli ); /*flush buffers*/
            cli->qPrivate.xPublic.Output[ 0 ] = (char)'\0';
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
static void qATCLI_HandleCommandResponse( qATCLI_t * const cli, const qATCLI_Response_t retval ){
    if( QATCLI_NORESPONSE != retval ){
        qPutchFcn_t PutChar = cli->qPrivate.xPublic.putch;
        qPutsFcn_t PutString = cli->qPrivate.xPublic.puts;

        switch( retval ){ /*handle the command-callback response*/
            case qATCLI_ERROR:
                PutString( ( NULL != cli->qPrivate.ERROR_Response )? cli->qPrivate.ERROR_Response : QATCLI_DEFAULT_ERROR_RSP_STRING);
                break;
            case qATCLI_OK:
                PutString( ( NULL != cli->qPrivate.OK_Response )? cli->qPrivate.OK_Response: QATCLI_DEFAULT_OK_RSP_STRING );
                break;
            case qATCLI_NOTALLOWED:   
                PutString( ( NULL != cli->qPrivate.ERROR_Response )? cli->qPrivate.ERROR_Response : QATCLI_DEFAULT_ERROR_RSP_STRING );
                PutString(QATCLI_DEAFULT_NOTALLOWED_RSP_STRING);
                break; 
            case qATCLI_DEVID:
                PutString( ( NULL != cli->qPrivate.Identifier )? cli->qPrivate.Identifier: QATCLI_DEFAULT_DEVID_STRING );
                break;
            case qATCLI_NOTFOUND:
                PutString( ( NULL != cli->qPrivate.NOTFOUND_Response )? cli->qPrivate.NOTFOUND_Response: QATCLI_DEFAULT_NOTFOUND_RSP_STRING );
                break;        
            case qATCLI_OUTPUT:
                PutString( cli->qPrivate.xPublic.Output );
                break;
            default: /*AT_ERRORCODE(#) */
                if( (qBase_t)retval < 0 ){
                    qINT32_t ErrorCode = QATCLI_ERRORCODE( (qINT32_t)retval );
                    (void)qIOUtil_ItoA( ErrorCode, cli->qPrivate.xPublic.Output, 10u );
                    PutString( ( NULL != cli->qPrivate.ERROR_Response)? cli->qPrivate.ERROR_Response : QATCLI_DEFAULT_ERROR_RSP_STRING );
                    PutChar( ':' );
                    PutString( cli->qPrivate.xPublic.Output );
                    cli->qPrivate.xPublic.Output[ 0 ] = (char)'\0';
                }                            
                break;
        }
        PutString( ( NULL != cli->qPrivate.term_EOL )? cli->qPrivate.term_EOL : QATCLI_DEFAULT_EOL_STRING );
    }
}
/*============================================================================*/
static size_t qATCLI_NumOfArgs( const char *str ){
    size_t count = 0u;
    
    while( '\0' != *str ){
        if ( (char)QATCLI_DEFAULT_ATSET_DELIM == (char)*str++ ){
            ++count;
        }
    }
    return ( count + 1u );
}
/*============================================================================*/
/*char* p->GetArgPtr( qIndex_t n )

Helper method inside the <qATCLI_PreCmd_t> callback parameter
Get the pointer where the desired argument starts.

Parameters:

    - n : The number of the argument

Return value:

    A pointer to the desired argument. NULL  pointer if the argument is not present.
*/
static char* GetArgPtr( qIndex_t n ){
    char *RetPtr = NULL;

    if( ( NULL != cli_CurrentCmdHelper ) && ( n > 0u ) ) {
        qATCLI_Handler_t param = cli_CurrentCmdHelper;

        if( qATCLI_CMDTYPE_PARA == param->Type ) {
            if( 1u == n ){
                RetPtr = param->StrData;
            } 
            else{
                qIndex_t i, argc = 0;        
                --n;
                for( i = 0 ; '\0' != param->StrData[i] ; ++i ){
                    if( (char)QATCLI_DEFAULT_ATSET_DELIM == param->StrData[ i ] ){
        	            if( ++argc >= (qIndex_t)n ){
                            RetPtr = param->StrData + i + 1;        
                            break;
                        }
                    }
                }
            }
        }
    }
    return RetPtr;
}
/*============================================================================*/
/*int p->GetArgInt( qIndex_t n )

Helper method inside the <qATCLI_PreCmd_t> callback parameter
This function get the <n> argument parsed as integer from the incoming AT command.
Note: see <qIOUtil_AtoI>

Parameters:

    - n : The number of the argument

Return value:

    The argument parsed as integer. Same behavior of qIOUtil_AtoI. If argument not found returns 0
*/

static int GetArgInt( qIndex_t n ){
    int RetValue = 0;

    if( NULL != cli_CurrentCmdHelper ){
        /*cstat -CERT-STR34-C*/
        RetValue =  (int)qIOUtil_AtoI( cli_CurrentCmdHelper->GetArgPtr( n ) );
        /*cstat +CERT-STR34-C*/
    }
    return RetValue;    
}
/*============================================================================*/
/*qFloat32_t p->GetArgFlt( qIndex_t n )

Helper method inside the <qATCLI_PreCmd_t> callback parameter
This function get the <n> argument parsed as float from the incoming AT command.
Note: see <qIOUtil_AtoF>

Parameters:

    - n : The number of the argument

Return value:

    The argument parsed as Float. Same behavior of qIOUtil_AtoF. If argument not found returns 0
*/
static qFloat32_t GetArgFlt( qIndex_t n ){
    qFloat32_t RetValue = 0.0f;

    if( NULL != cli_CurrentCmdHelper ){
        RetValue =  (qFloat32_t)qIOUtil_AtoF( cli_CurrentCmdHelper->GetArgPtr( n ) );
    }
    return RetValue;  
}
/*============================================================================*/
/*qUINT32_t p->GetArgHex( qIndex_t n )

Helper method inside the <qATCLI_PreCmd_t> callback parameter
This function get the <n> HEX argument parsed qUINT32_t from the incoming AT command.
Note: see <qIOUtil_XtoU32>

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument

Return value:

    The HEX argument parsed as qUINT32_t. Same behavior of qIOUtil_XtoU32. If argument not found returns 0
*/
static qUINT32_t GetArgHex( qIndex_t n ){
    qUINT32_t RetValue = 0uL;

    if( NULL != cli_CurrentCmdHelper ){
        /*cstat -CERT-STR34-C*/
	    RetValue = (qUINT32_t)qIOUtil_XtoU32( cli_CurrentCmdHelper->GetArgPtr( n ) );
        /*cstat +CERT-STR34-C*/ 
    }
    return RetValue;  
}
/*============================================================================*/
/*char* p->GetArgString( qIndex_t n, char* out )

Helper method from the <qATCLI_PreCmd_t> callback parameter
This function get the <n> argument parsed as string from the incoming AT command.

Parameters:

    - n : The number of the argument
    - out: Array in memory where to store the resulting null-terminated string.

Return value:

    Same as <out> on success, otherwise returns NULL.
*/
static char* GetArgString( qIndex_t n, char* out ){
	char *RetPtr = NULL;
    
    if( ( NULL != cli_CurrentCmdHelper ) && ( NULL != out ) && ( n > 0u ) ){
        qATCLI_Handler_t param = cli_CurrentCmdHelper;

        if( qATCLI_CMDTYPE_PARA ==  param->Type ){
            qIndex_t i, j, argc = 0;

            --n;
            j = 0;
            /*cstat -CERT-STR34-C*/
            for( i = 0 ; (char)'\0' != param->StrData[ i ]; ++i ){
                if( argc == n ){
                    RetPtr = out;
                    if( ( argc > n ) || ( QATCLI_DEFAULT_ATSET_DELIM == param->StrData[ i ] ) ){
                        break;
                    } 
                    out[ j++ ] = param->StrData[ i ];
                    out[ j ] = '\0';
                }
                if( QATCLI_DEFAULT_ATSET_DELIM == param->StrData[ i ] ){
                    ++argc;
                }
            /*cstat +CERT-STR34-C*/
            }
        }
    }
    return RetPtr;
}
/*============================================================================*/
#endif /* #if ( Q_ATCLI == 1) */
