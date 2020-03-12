#include "qatcli.h"

#if ( Q_ATCLI == 1)

#define QATCLI_CMDMASK_ARG_MAXNUM(opt)   ( ( (opt)>>4 ) & (qATCLI_Options_t)0x000Fu )
#define QATCLI_CMDMASK_ARG_MINNUM(opt)   ( (opt) & (qATCLI_Options_t)0x000Fu )

static qPutChar_t ATOutCharFcn = NULL;
static qATCLI_t *Current = NULL;
static void qATCLI_Putc_Wrapper( const char c );
static void qATCLI_Puts_Wrapper( const char *s );
static size_t qATCLI_NumOfArgs( const char *str );
static char* qATCLI_Input_Fix( char *s );
static void qATCLI_HandleCommandResponse( const qATCLI_t * const cli, const qATCLI_Response_t retval );
static qBool_t qATCLI_PreProcessing( qATCLI_Command_t * const Command, char *InputBuffer, qATCLI_PreCmd_t params );
static qBool_t qATCLI_Notify( qATCLI_t * const clicb );
static char* GetArgPtr( qArgNum_t n );
static int GetArgInt( qArgNum_t n );
static qFloat32_t GetArgFlt( qArgNum_t n );
static qUINT32_t GetArgHex( qArgNum_t n );
static char* GetArgString( qArgNum_t n, char* out );
/*============================================================================*/
static char* GetArgPtr( qArgNum_t n ){
    char *RetValue = NULL;
    if( NULL != Current){
        RetValue = qATCLI_GetArgPtr( &Current->qPrivate.Params, n );
    }
    return RetValue;
}
/*============================================================================*/
static int GetArgInt( qArgNum_t n ){
    int RetValue = 0;
    if( NULL != Current){
        RetValue = qATCLI_GetArgInt( &Current->qPrivate.Params, n );
    }
    return RetValue;    
}
/*============================================================================*/
static qFloat32_t GetArgFlt( qArgNum_t n ){
    qFloat32_t RetValue = 0.0f;
    if( NULL != Current){
        RetValue = qATCLI_GetArgFlt( &Current->qPrivate.Params, n );
    }
    return RetValue;  
}
/*============================================================================*/
static qUINT32_t GetArgHex( qArgNum_t n ){
    qUINT32_t RetValue = 0uL;
    if( NULL != Current){
        RetValue = qATCLI_GetArgHex( &Current->qPrivate.Params, n );
    }
    return RetValue;  
}
/*============================================================================*/
static char* GetArgString( qArgNum_t n, char* out ){
    char* RetValue = NULL;
    if( NULL != Current){
        RetValue = qATCLI_GetArgString( &Current->qPrivate.Params, n, out );
    }
    return RetValue;
}
/*============================================================================*/
static qBool_t qATCLI_Notify( qATCLI_t * const cli ){
    cli->qPrivate.Input.Ready = qTrue;
    cli->qPrivate.Input.index = 0u;
    if( NULL != cli->qPrivate.xNotifyFcn ){
        cli->qPrivate.xNotifyFcn( cli );
    }
    return qTrue;
}
/*============================================================================*/
static void qATCLI_Putc_Wrapper( const char c ){
	ATOutCharFcn( NULL, c );
}
/*============================================================================*/
static void qATCLI_Puts_Wrapper( const char *s ){
	qIndex_t i = 0u;
	while( '\0' != s[i] ){
        ATOutCharFcn( NULL, s[i++] );
    }
}
/*============================================================================*/
/*qBool_t qATCLI_Setup(qATCLI_t * const cli, const qPutChar_t OutputFcn, 
                                char *Input, const size_t SizeInput, char *Output, const size_t SizeOutput, 
                                const char *Identifier, const char *OK_Response, const char *ERROR_Response, 
                                const char *NOTFOUND_Response, const char *term_EOL)
 
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
    - term_EOL: The End Of Line string printed out after any of the CLI messages 
  
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
        cli->qPrivate.Params.GetArgPtr = &GetArgPtr;
        cli->qPrivate.Params.GetArgInt = &GetArgInt;
        cli->qPrivate.Params.GetArgFlt = &GetArgFlt;
        cli->qPrivate.Params.GetArgHex = &GetArgHex;
        cli->qPrivate.Params.GetArgString = &GetArgString;
        /*Flush input and output buffers*/
        (void)memset( (void*)cli->qPrivate.Input.Buffer, 0, SizeInput );
        (void)memset( (void*)cli->qPrivate.xPublic.Output, 0, SizeOutput );
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qATCLI_CmdSubscribe(qATCLI_t * const cli, qATCLI_Command_t * const Command, const char *TextCommand, qATCLI_CommandCallback_t Callback, qATCLI_Options_t CmdOpt, void *param )
 
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
    			Prototype: qATCLI_Response_t xCallback( qATCLI_Handler_t, qATCLI_PreCmd_t )
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
            if( ( 'a' == TextCommand[0] ) && ( 't' == TextCommand[1] ) ) { /*command should start with an <at> at the beginning */
                Command->Text = (char*)TextCommand;
                Command->qPrivate.CommandCallback = Callback;
                Command->qPrivate.CmdOpt = 0x0FFFu & CmdOpt; /*high nibble not used yet*/
                Command->qPrivate.Next = cli->qPrivate.First; /*MISRAC2012-Rule-11.5 deviation allowed*/
                Command->param = param;
                cli->qPrivate.First = Command;
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

    if(NULL != cli){
        if( qTrue == reload ){
            Iterator = cli->qPrivate.First; /*MISRAC2012-Rule-11.5 deviation allowed*/
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
/*void qATCLI_ISRHandler(qATCLI_t * const cli, char c)
 
Feed the CLI input with a single character. This call is mandatory 
from an interrupt context. Put it inside the desired peripheral's ISR.
If your ISR get a block of data, use instead qATCLI_ISRHandlerBlock

Note: This API assumes that the respective ISR catch a single byte at a time.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - c : The incoming byte/char to the input. 

Return value:

    qTrue when the CLI is ready to process the input, otherwise return qFalse

*/
qBool_t qATCLI_ISRHandler( qATCLI_t * const cli, char c ){
    qBool_t RetValue = qFalse;
    qBool_t ReadyInput;
    qIndex_t CurrentIndex;

    if( NULL != cli ){
        ReadyInput = cli->qPrivate.Input.Ready;
        if( ( 0 != isgraph( (int)c ) ) && ( qFalse == ReadyInput ) ){
            CurrentIndex = cli->qPrivate.Input.index; /*to avoid undefined order of volatile accesses*/
            cli->qPrivate.Input.Buffer[ CurrentIndex++ ] = (char)tolower( (int)c );
            cli->qPrivate.Input.Buffer[ CurrentIndex   ] = (char)0x00u;
            if( CurrentIndex >= cli->qPrivate.Input.MaxIndex ){
                CurrentIndex = 0u;
            }
            cli->qPrivate.Input.index = CurrentIndex;
        }
        if ( '\r' == c ){
            RetValue = qATCLI_Notify( cli );
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qATCLI_ISRHandlerBlock(qATCLI_t * const cli, char *data, const size_t n)
Feed the CLI input with a string. This call is mandatory 
from an interrupt context. Put it inside the desired peripheral's ISR.
If your ISR only get a single char, use instead qATCLI_ISRHandler

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - data : The incoming string.
    - n : The length of the string

Return value:

    qTrue when the CLI is ready to process the input, otherwise return qFalse

*/
qBool_t qATCLI_ISRHandlerBlock( qATCLI_t * const cli, char *data, const size_t n ){
    qBool_t RetValue = qFalse;
    qBool_t ReadyInput;
    size_t MaxToInsert;

    if( NULL != cli ){
        ReadyInput = cli->qPrivate.Input.Ready;
        MaxToInsert = cli->qPrivate.Input.MaxIndex;
        if( ( n > 0u ) && ( n < MaxToInsert ) &&  ( qFalse == ReadyInput ) ) {
            if( 1u == n ){
                RetValue = qATCLI_ISRHandler( cli, data[0] );
            }
            else{
                if( 0 != isgraph( (int)data[0] ) ){
                    if( NULL != strchr( data, (int)'\r' ) ){ 
                        (void)qIOUtil_StrlCpy( (char*)cli->qPrivate.Input.Buffer, data, n); /*safe string copy*/
                        (void)qATCLI_Input_Fix( (char*)cli->qPrivate.Input.Buffer );
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
static char* qATCLI_Input_Fix( char *s ){
    int i,j;
    j = 0;
    for( i = 0; '\0' != s[i] ; i++ ){
        if( '\r' == s[i] ){
            s[i] = '\0';
            break;    
        } 
        if( 0 != isgraph( (int)s[i]) ){
            s[j++] = (char)tolower( (int)s[i] );
        }
    }
    s[j] = '\0';
    return s;
}
/*============================================================================*/
/*qBool_t qATCLI_Raise(qATCLI_t * const cli, const char *cmd)

Sends a command to the specified AT Command Line Interface instance.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance
    - cmd : The command string, including arguments if required.

Return value:

    qTrue when the CLI accepts the input. If busy, return qFalse

*/
qBool_t qATCLI_Raise( qATCLI_t * const cli, const char *cmd ){
    qBool_t RetValue = qFalse;
    qBool_t ReadyInput;           
    size_t MaxToInsert, CmdLen, MaxBytestoCopy;
    
    if( ( NULL != cli ) && ( NULL != cmd ) ){
        ReadyInput = cli->qPrivate.Input.Ready;        
        MaxToInsert = cli->qPrivate.Input.MaxIndex;
        CmdLen = qIOUtil_StrLen( cmd, cli->qPrivate.Input.Size );
        if( ( qFalse == ReadyInput ) && ( CmdLen <= MaxToInsert ) ){ 
            MaxBytestoCopy = cli->qPrivate.Input.Size; /*to avoid undefined order of volatile accesses*/
            (void)qIOUtil_StrlCpy( (char*)cli->qPrivate.Input.Buffer, cmd, MaxBytestoCopy ); /*safe string copy*/
            (void)qATCLI_Input_Fix( (char*)cli->qPrivate.Input.Buffer );
            RetValue = qATCLI_Notify( cli );
        }
    } 
    return RetValue;
}
/*============================================================================*/
/*qATCLI_Response_t qATCLI_Exec( qATCLI_t * const cli, const char *cmd)

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
    qATCLI_Command_t *Command;
    qATCLI_CommandCallback_t CmdCallback;
    
    if( ( NULL != cli ) && ( NULL != cmd ) ){
        for( Command = (qATCLI_Command_t*)cli->qPrivate.First ; NULL != Command ; Command = Command->qPrivate.Next ){ /*loop over the subscribed commands*/ /*MISRAC2012-Rule-11.5 deviation allowed*/
            if( strstr( cmd, Command->Text ) == cmd ){ /*check if the input match the subscribed command starting from the beginning*/
            	RetValue = qATCLI_NOTALLOWED;
                if( qATCLI_PreProcessing( Command, (char*)cmd, &cli->qPrivate.Params ) ){ /*if success, proceed with the user pos-processing*/
                    CmdCallback = Command->qPrivate.CommandCallback;
                    if( qATCLI_CMDTYPE_UNDEF == cli->qPrivate.Params.Type ){
                        RetValue = QATCLI_ERROR;
                    }
                    else{
                        RetValue = CmdCallback( &cli->qPrivate.xPublic, &cli->qPrivate.Params  ); /*invoke the callback*/
                    }
                }
                break;
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
static qBool_t qATCLI_PreProcessing( qATCLI_Command_t * const Command, char *InputBuffer, qATCLI_PreCmd_t params ){
    qBool_t RetValue = qFalse;
    size_t argMin, argMax;
    
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
        if( '?' == params->StrData[0] ){ /*command should be READ command */
            if( 0u != ( Command->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_READ ) ){ /*check if is allowed*/
                params->Type = qATCLI_CMDTYPE_READ; /*set the type to READ*/
                params->StrData++; /*move string pointer once*/
                params->StrLen--;  /*decrease the len one*/
                RetValue = qTrue;
            }
        } 
        else if( params->StrLen >= 2u ){ /*can be at+xx=? or at+xx=...*/
            if( '=' == params->StrData[0] ){ /*could be a TEST or PARA command*/
                if( '?' == params->StrData[1] ){ 
                    if( 2u == params->StrLen ){ /*command should be a TEST Command*/
                        if( 0u != ( Command->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_TEST ) ){ /*check if is allowed*/
                            params->Type = qATCLI_CMDTYPE_TEST; /*set the type to TEXT*/
                            params->StrData+=2; /*move string two positions ahead*/
                            params->StrLen-=2u;  /*decrease the len*/
                            RetValue = qTrue;
                        }
                    }
                }
                else{ /*definitely is a PARA command*/
                    if( 0u != ( Command->qPrivate.CmdOpt & (qATCLI_Options_t)qATCLI_CMDTYPE_PARA ) ){ /*check if is allowed*/
                        params->NumArgs = qATCLI_NumOfArgs( params->StrData ); /*get the args count using the default delimiter*/
                        argMin = QATCLI_CMDMASK_ARG_MINNUM( (size_t)Command->qPrivate.CmdOpt );
                        argMax = QATCLI_CMDMASK_ARG_MAXNUM( (size_t)Command->qPrivate.CmdOpt );
                        if( ( params->NumArgs >= argMin ) && ( params->NumArgs <= argMax ) ){
                            params->Type = qATCLI_CMDTYPE_PARA; /*set the type to PARA*/
                            params->StrData++; /*move string pointer once*/
                            params->StrLen--; /*decrease the len one*/
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
	qATCLI_Input_t *Input;
    if( NULL != cli ){
        Input = &cli->qPrivate.Input;
        Input->Ready = qFalse;
        Input->index = 0u;
        Input->Buffer[0] = (char)0x00u;
    }
}
/*============================================================================*/
/*qBool_t qATCLI_Run(qATCLI_t * const cli)
 
Run the AT Command Line Interface when the input is ready.

Parameters:

    - cli : A pointer to the AT Command Line Interface instance

Return value:

    qTrue on success, otherwise return qFalse

*/
qBool_t qATCLI_Run( qATCLI_t * const cli ){
    qATCLI_Response_t OutputRetval;
    qATCLI_Response_t CLIRetVal;
    qATCLI_Input_t *Input;
    qBool_t RetValue = qFalse;
    char *InputBuffer;

    if( NULL != cli){
		Current = cli;
        Input =  &cli->qPrivate.Input;
		ATOutCharFcn = cli->qPrivate.OutputFcn;
        
		if( Input->Ready ){ /*a new input has arrived*/
            InputBuffer = Input->Buffer; /*to conform MISRAC2012-Rule-13.2_b*/
			/*Validation : set the value for the response lookup table*/
			if 	( 0 == strncmp( (const char*)InputBuffer, QATCLI_DEFAULT_AT_COMMAND, Input->Size ) ){
            	OutputRetval = QATCLI_OK;			/*check if the input its the simple AT command*/
            }
			else if	( QATCLI_NOTFOUND != (CLIRetVal = qATCLI_Exec( cli, Input->Buffer ) ) ){
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

			if( NULL != cli->qPrivate.xPublic.Output ){ /*show the user output if available*/
				if( '\0' != cli->qPrivate.xPublic.Output[0] ){
                    qATCLI_HandleCommandResponse( cli, QATCLI_OUTPUT );
                }
			}
			qATCLI_HandleCommandResponse( cli, OutputRetval ); /*print out the command output*/
			qATCLI_Input_Flush( cli ); /*flush buffers*/
			cli->qPrivate.xPublic.Output[0]  = '\0';
			RetValue = qTrue;
		}
    }
    return RetValue;
}
/*============================================================================*/
static void qATCLI_HandleCommandResponse( const qATCLI_t * const cli, const qATCLI_Response_t retval ){
    qINT32_t ErrorCode;
    qPutchFcn_t PutChar;
    qPutsFcn_t PutString;

    PutChar = cli->qPrivate.xPublic.putch;
    PutString = cli->qPrivate.xPublic.puts;
    
	if( QATCLI_NORESPONSE != retval ){
        switch( retval ){ /*handle the command-callback response*/
            case qATCLI_ERROR:
                PutString( ( NULL != cli->qPrivate.ERROR_Response )? cli->qPrivate.ERROR_Response : QATCLI_DEFAULT_ERROR_RSP_STRING);
                break;
            case qATCLI_OK:
                PutString( ( NULL != cli->qPrivate.OK_Response )? cli->qPrivate.OK_Response: QATCLI_DEFAULT_OK_RSP_STRING );
                break;
            case qATCLI_NOTALLOWED:   
                PutString( ( NULL != cli->qPrivate.ERROR_Response )? cli->qPrivate.ERROR_Response : QATCLI_DEFAULT_ERROR_RSP_STRING);
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
                    ErrorCode = QATCLI_ERRORCODE( (qINT32_t)retval );
                    (void)qIOUtil_ItoA( ErrorCode, cli->qPrivate.xPublic.Output, 10u );
                    PutString( ( NULL != cli->qPrivate.ERROR_Response)? cli->qPrivate.ERROR_Response : QATCLI_DEFAULT_ERROR_RSP_STRING);
                    PutChar(':');
                    PutString( cli->qPrivate.xPublic.Output );
                    cli->qPrivate.xPublic.Output[0] = '\0';
                }                            
                break;
        }
        PutString( ( NULL != cli->qPrivate.term_EOL )? cli->qPrivate.term_EOL : QATCLI_DEFAULT_EOL_STRING );
    }
}
/*============================================================================*/
/*char* qATCLI_GetArgString( const qATCLI_PreCmd_t param, qINT8_t n, char* out)

This function get the <n> argument parsed as <String> from the incoming AT command.
This function should be only invoked from the callback context of the  recognized command.

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument
    - out: Array in memory where to store the resulting null-terminated string.

Return value:

    Same as <out>  on success, otherwise returns NULL.
*/
char* qATCLI_GetArgString( const qATCLI_PreCmd_t param, qINT8_t n, char* out ){
	qINT8_t i,j, argc = 0;
	char *RetPtr = NULL;

    if( ( NULL != param ) && ( NULL != out ) && ( n > 0 ) ){
        if( qATCLI_CMDTYPE_PARA ==  param->Type ){
            n--;
            j = 0;
            for( i=0 ; '\0' != param->StrData[i]; i++){
                if(argc == n){
                    RetPtr = out;
                    if( ( argc > n ) || ( QATCLI_DEFAULT_ATSET_DELIM == param->StrData[i] ) ){
                        break;
                    } 
                    out[j++] = param->StrData[i];
                    out[j] = '\0';
                }
                if( QATCLI_DEFAULT_ATSET_DELIM == param->StrData[i] ){
                    argc++;
                }
            }
        }
    }
	return RetPtr;
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
/*char* qATCLI_GetArgPtr( const qATCLI_PreCmd_t param, qINT8_t n)

Get the pointer where the desired argument starts.
This function should be only invoked from the callback context of the  recognized command.

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument

Return value:

    A pointer to the desired argument. NULL  pointer if the argument is not present.
*/
char* qATCLI_GetArgPtr(const qATCLI_PreCmd_t param, qINT8_t n){
	qIndex_t i, argc = 0;
    char *RetPtr = NULL;
	if( ( NULL != param ) && ( n > 0 ) ) {
        if( qATCLI_CMDTYPE_PARA == param->Type ) {
            if( 1 == n ){
                RetPtr = param->StrData;
            } 
            else{
                n--;
	            for( i = 0 ; '\0' != param->StrData[i] ; i++){
		            if( (char)QATCLI_DEFAULT_ATSET_DELIM == param->StrData[i] ){
			            if( ++argc >= (qIndex_t)n ){
                            RetPtr = param->StrData+i+1;        
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
/*int qATCLI_GetArgInt(const qATCLI_PreCmd_t param, qINT8_t n)

This function get the <n> argument parsed as <Integer> from the incoming AT command.
This function should be only invoked from the callback context of the recognized command.
Note: see qIOUtil_AtoI


Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the at-command callback)
    - n : The number of the argument

Return value:

    The argument parsed as integer. Same behavior of qIOUtil_AtoI. If argument not found returns 0
*/
int qATCLI_GetArgInt(const qATCLI_PreCmd_t param, qINT8_t n){
	return (int) qIOUtil_AtoI( qATCLI_GetArgPtr(param, n) );
}
/*============================================================================*/
/*float qATCLI_GetArgFlt(const qATCLI_PreCmd_t *param, qINT8_t n)

This function get the <n> argument parsed as <Float> from the incoming AT command.
This function should be only invoked from the callback context of the  recognized command.
Note: see qIOUtil_AtoF

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the at-command callback)
    - n : The number of the argument

Return value:

    The argument parsed as Float. Same behavior of qIOUtil_AtoF. If argument not found returns 0
*/
qFloat32_t qATCLI_GetArgFlt( const qATCLI_PreCmd_t param, qINT8_t n ){
	return (qFloat32_t) qIOUtil_AtoF( qATCLI_GetArgPtr(param, n) );
}
/*============================================================================*/
/*qUINT32_t qATCLI_GetArgHex( const qATCLI_PreCmd_t *param, qINT8_t n)

This function get the <n> HEX argument parsed <qUINT32_t> from the
incoming AT command.
This function should be only invoked from the callback context of the recognized command.
Note: see qIOUtil_XtoU32

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument

Return value:

    The HEX argument parsed as qUINT32_t. Same behavior of qIOUtil_XtoU32. If argument not found returns 0
*/
qUINT32_t qATCLI_GetArgHex( const qATCLI_PreCmd_t param, qINT8_t n ){
	return (qUINT32_t) qIOUtil_XtoU32( qATCLI_GetArgPtr(param, n) );
}
/*=============================================================================*/
#endif /* #if ( Q_ATCLI == 1) */
