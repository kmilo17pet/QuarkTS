#include "qatcli.h"

#if ( Q_ATCOMMAND_PARSER == 1)

static qPutChar_t ATOutCharFcn = NULL;
static qATParser_t *Current = NULL;
static void _qATPutc_Wrapper( const char c );
static void _qATPuts_Wrapper( const char *s );
static size_t qATParser_NumOfArgs( const char *str );
static char* _qATParser_FixInput( char *s );
static void _qATParser_HandleCommandResponse( const qATParser_t * const Parser, const qATResponse_t retval );
static qBool_t _qATParser_PreProcessing( qATCommand_t * const Command, char *InputBuffer, qATParser_PreCmd_t *params );
static qBool_t _aATParser_Notify(qATParser_t * const Parser);

static char* GetArgPtr( qArgNum_t n );
static int GetArgInt( qArgNum_t n );
static qFloat32_t GetArgFlt( qArgNum_t n );
static qUINT32_t GetArgHex( qArgNum_t n );
static char* GetArgString( qArgNum_t n, char* out );
/*============================================================================*/
static char* GetArgPtr( qArgNum_t n ){
    char *RetValue = NULL;
    if( NULL != Current){
        RetValue = qATParser_GetArgPtr( &Current->qPrivate.Params, n );
    }
    return RetValue;
}
/*============================================================================*/
static int GetArgInt( qArgNum_t n ){
    int RetValue = 0;
    if( NULL != Current){
        RetValue = qATParser_GetArgInt( &Current->qPrivate.Params, n );
    }
    return RetValue;    
}
/*============================================================================*/
static qFloat32_t GetArgFlt( qArgNum_t n ){
    qFloat32_t RetValue = 0.0f;
    if( NULL != Current){
        RetValue = qATParser_GetArgFlt( &Current->qPrivate.Params, n );
    }
    return RetValue;  
}
/*============================================================================*/
static qUINT32_t GetArgHex( qArgNum_t n ){
    qUINT32_t RetValue = 0uL;
    if( NULL != Current){
        RetValue = qATParser_GetArgHex( &Current->qPrivate.Params, n );
    }
    return RetValue;  
}
/*============================================================================*/
static char* GetArgString( qArgNum_t n, char* out ){
    char* RetValue = NULL;
    if( NULL != Current){
        RetValue = qATParser_GetArgString( &Current->qPrivate.Params, n, out );
    }
    return RetValue;
}
/*============================================================================*/
static qBool_t _aATParser_Notify(qATParser_t * const Parser){
    Parser->qPrivate.Input.Ready = qTrue;
    Parser->qPrivate.Input.index = 0u;
    if( NULL != Parser->qPrivate.xNotifyFcn ){
        Parser->qPrivate.xNotifyFcn( Parser );
    }
    return qTrue;
}
/*============================================================================*/
static void _qATPutc_Wrapper( const char c ){
	ATOutCharFcn( NULL, c );
}
/*============================================================================*/
static void _qATPuts_Wrapper( const char *s ){
	qIndex_t i = 0u;
	while( '\0' != s[i] ){
        ATOutCharFcn( NULL, s[i++] );
    }
}
/*============================================================================*/
/*qBool_t qATParser_Setup(qATParser_t * const Parser, const qPutChar_t OutputFcn, 
                                char *Input, const qSize_t SizeInput, char *Output, const qSize_t SizeOutput, 
                                const char *Identifier, const char *OK_Response, const char *ERROR_Response, 
                                const char *NOTFOUND_Response, const char *term_EOL)
 
Setup an instance of the AT Command parser.

Parameters:

    - Parser : A pointer to the AT Command Parser instance
    - OutputFcn : The basic output-char wrapper function. All the parser responses 
                   will be printed-out through this function.
    - Input : A memory location to store the parser input (Mandatory)
    - SizeInput: The size of the memory allocated in <Input> 
    - Output: A memory location to store the parser output
    - SizeOutput : The size of the memory allocated in <Output> 
    - Identifier: The device identifier string. This string will be printed-out
                  after a call to the AT_DEFAULT_ID_COMMAND
    - OK_Response: The output message when a command callback returns QAT_OK.  
    - ERROR_Response: The output message when a command callback returns QAT_ERROR or any
                      QAT_ERRORCODE(#)
    - NOTFOUND_Response: The output message when input doesn't match with any of 
                         the available commands
    - term_EOL: The End Of Line string printed out after any of the parser messages 
  
Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qATParser_Setup( qATParser_t * const Parser, const qPutChar_t OutputFcn, char *Input, const size_t SizeInput, char *Output, const size_t SizeOutput, const char *Identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL ){
    qBool_t RetValue = qFalse;
    if(  ( NULL != Parser ) && ( NULL != OutputFcn) ) {
        Parser->qPrivate.First  = NULL;
        Parser->qPrivate.OutputFcn = OutputFcn;
        Parser->qPrivate.Identifier = Identifier;
        Parser->qPrivate.OK_Response = OK_Response;
        Parser->qPrivate.ERROR_Response = ERROR_Response;
        Parser->qPrivate.NOTFOUND_Response = NOTFOUND_Response;
        Parser->qPrivate.term_EOL = term_EOL;
        Parser->qPrivate.SizeOutput = SizeOutput;
        Parser->qPrivate.Input.Buffer = (char*)Input;
        Parser->qPrivate.Input.Size = SizeInput;
        Parser->qPrivate.Input.MaxIndex =  SizeInput - 1u;
        Parser->qPrivate.Input.Ready = qFalse;
        Parser->qPrivate.Input.index = 0u;
        Parser->qPrivate.xNotifyFcn = NULL;
        Parser->Output = Output;
        Parser->putch = &_qATPutc_Wrapper;
        Parser->puts = &_qATPuts_Wrapper;
        Parser->qPrivate.Params.GetArgPtr = &GetArgPtr;
        Parser->qPrivate.Params.GetArgInt = &GetArgInt;
        Parser->qPrivate.Params.GetArgFlt = &GetArgFlt;
        Parser->qPrivate.Params.GetArgHex = &GetArgHex;
        Parser->qPrivate.Params.GetArgString = &GetArgString;
        /*Flush input and output buffers*/
        (void)memset( (void*)Parser->qPrivate.Input.Buffer, 0, SizeInput );
        (void)memset( (void*)Parser->Output, 0, SizeOutput );
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qATParser_CmdSubscribe(qATParser_t * const Parser, qATCommand_t * const Command, const char *TextCommand, qATCommandCallback_t Callback, qATParserOptions_t CmdOpt, void *param )
 
This function subscribes the parser to a specific command with an associated callback function,
so that next time the required command is sent to the parser input, the callback function will be
executed. 
The parser only analyze commands that follows the extended AT-Commands syntax (+ can be ignored).

Parameters:

    - Parser : A pointer to the ATParser instance
    - Command : A pointer to the AT command object.
    - TextCommand: The string (name) of the command we want to subscribe to. 
                    Since this service only handles AT commands, this string has 
                    to begin by the "at" characters and should be in lower case.
    - Callback: The handler of the callback function associated to the command.
    			Prototype: qATResponse_t xCallback(qATParser_t* parser, qATParser_PreCmd_t* param)
    - CmdOpt : This flag combines with a bitwise ‘OR’ (‘|’) the following information:
                
                > QATCMDTYPE_PARA  : "AT+cmd=x,y" is allowed. The execution of the callback
                                     function also depends on whether the number of argument 
                                     is valid or not. Information about number of arguments is
                                     combined with a bitwise 'OR' : QATCMDTYPE_PARA | 0xXY , 
                                     where X which defines maximum argument number for incoming
                                     command and Y which defines minimum argument number for 
                                     incoming command
                > QATCMDTYPE_TEST  : "AT+cmd=?" is allowed. 
                > QATCMDTYPE_READ  : "AT+cmd?" is allowed.  
                > QATCMDTYPE_ACT   : "AT+cmd" is allowed.   
    - param : User storage pointer.
Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qATParser_CmdSubscribe( qATParser_t * const Parser, qATCommand_t * const Command, char *TextCommand, const qATCommandCallback_t Callback, qATParserOptions_t CmdOpt, void *param ){
    qBool_t RetValue = qFalse;
    if( ( NULL != Parser ) && ( NULL != Command ) && ( NULL != TextCommand ) && ( NULL != Callback ) ){
        Command->qPrivate.CmdLen = strlen( TextCommand );
        if( Command->qPrivate.CmdLen >= 2u ){
            if( ( 'a' == TextCommand[0] ) && ( 't' == TextCommand[1] ) ) { /*command should start with an <at> at the beginning */
                Command->Text = (char*)TextCommand;
                Command->qPrivate.CommandCallback = Callback;
                Command->qPrivate.CmdOpt = 0x0FFFu & CmdOpt; /*high nibble not used yet*/
                Command->qPrivate.Next = Parser->qPrivate.First; /*MISRAC2012-Rule-11.5 deviation allowed*/
                Command->param = param;
                Parser->qPrivate.First = Command;
                RetValue = qTrue;  
            }
        }
    } 
    return RetValue;
}
/*============================================================================*/
/*qATCommand_t* qATParser_CmdIterate( qATParser_t * const Parser, qBool_t reload )

Iterate between the commands available inside the parser.

Parameters:

    - Parser : A pointer to the ATParser instance
    - reload : If qTrue, the iterator will set their position at the beginning 

Return value:

    The current iterated command. NULL when no more commands are available

*/
qATCommand_t* qATParser_CmdIterate( qATParser_t * const Parser, qBool_t reload ){
    static qATCommand_t *Iterator = NULL;
    qATCommand_t *Cmd = NULL;
      
    if(NULL != Parser){
      if( qTrue == reload ){
          Iterator = Parser->qPrivate.First; /*MISRAC2012-Rule-11.5 deviation allowed*/
      } 
      else{
        Cmd = Iterator;
        Iterator = Iterator->qPrivate.Next; 
      }
    }
    return Cmd;
} 
/*============================================================================*/
/*void qATCommandParser_ISRHandler(qATParser_t * const Parser, char c)
 
Feed the parser input with a single character. This call is mandatory 
from an interrupt context. Put it inside the desired peripheral's ISR.
If your ISR get a block of data, use instead qATParser_ISRHandlerBlock

Note: This API assumes that the respective ISR catch a single byte at a time.

Parameters:

    - Parser : A pointer to the ATParser instance
    - c : The incoming byte/char to the input. 

Return value:

    qTrue when the Parser is ready to process the input, otherwise return qFalse

*/
qBool_t qATParser_ISRHandler( qATParser_t * const Parser, char c ){
    qBool_t RetValue = qFalse;
    qBool_t ReadyInput;
    qIndex_t CurrentIndex;
    ReadyInput = Parser->qPrivate.Input.Ready;
    if( ( 0 != isgraph( (int)c ) ) && ( qFalse == ReadyInput ) ){
        CurrentIndex = Parser->qPrivate.Input.index; /*to avoid undefined order of volatile accesses*/
        Parser->qPrivate.Input.Buffer[ CurrentIndex++ ] = (char)tolower( (int)c );
        Parser->qPrivate.Input.Buffer[ CurrentIndex   ] = (char)0x00u;
        if( CurrentIndex >= Parser->qPrivate.Input.MaxIndex ){
            CurrentIndex = 0u;
        }
        Parser->qPrivate.Input.index = CurrentIndex;
    }
    if ( '\r' == c ){
        RetValue = _aATParser_Notify( Parser );
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qATParser_ISRHandlerBlock(qATParser_t * const Parser, char *data, const qSize_t n)
Feed the parser input with a string. This call is mandatory 
from an interrupt context. Put it inside the desired peripheral's ISR.
If your ISR only get a single char, use instead qATParser_ISRHandler

Parameters:

    - Parser : A pointer to the ATParser instance
    - data : The incoming string.
    - n : The length of the string

Return value:

    qTrue when the Parser is ready to process the input, otherwise return qFalse

*/
qBool_t qATParser_ISRHandlerBlock( qATParser_t * const Parser, char *data, const size_t n ){
    qBool_t RetValue = qFalse;
    qBool_t ReadyInput;
    size_t MaxToInsert;
    
    ReadyInput = Parser->qPrivate.Input.Ready;
    MaxToInsert = Parser->qPrivate.Input.MaxIndex;
    if( ( n > 0u ) && ( n < MaxToInsert ) &&  ( qFalse == ReadyInput ) ) {
        if( 1u == n ){
            RetValue = qATParser_ISRHandler( Parser, data[0] );
        }
        else{
            if( 0 != isgraph( (int)data[0] ) ){
                if( NULL != strchr( data, (int)'\r' ) ){ 
                    (void)strncpy( (char*)Parser->qPrivate.Input.Buffer, data, n);
                    (void)_qATParser_FixInput( (char*)Parser->qPrivate.Input.Buffer );
                    RetValue = _aATParser_Notify( Parser );
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
static char* _qATParser_FixInput( char *s ){
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
/*qBool_t qATParser_Raise(qATParser_t * const Parser, const char *cmd)

Sends a command to the specified Parser.

Parameters:

    - Parser : A pointer to the ATParser instance
    - cmd : The command string, including arguments if required.

Return value:

    qTrue when the Parser accepts the input. If busy, return qFalse

*/
qBool_t qATParser_Raise( qATParser_t * const Parser, const char *cmd ){
    qBool_t RetValue = qFalse;
    qBool_t ReadyInput;           
    size_t MaxToInsert, CmdLen, MaxBytestoCopy;
    
    if( ( NULL != Parser ) && ( NULL != cmd ) ){
        ReadyInput = Parser->qPrivate.Input.Ready;        
        MaxToInsert = Parser->qPrivate.Input.MaxIndex;
        CmdLen = strlen( cmd );
        if( ( qFalse == ReadyInput ) && ( CmdLen <= MaxToInsert ) ){ 
            MaxBytestoCopy = Parser->qPrivate.Input.Size; /*to avoid undefined order of volatile accesses*/
            (void)strncpy( (char*)Parser->qPrivate.Input.Buffer, cmd, MaxBytestoCopy );
            (void)_qATParser_FixInput( (char*)Parser->qPrivate.Input.Buffer );
            RetValue = _aATParser_Notify( Parser );
        }
    } 
    return RetValue;
}
/*============================================================================*/
/*qATResponse_t qATParser_Exec(qATParser_t * const Parser, const char *cmd)

Try to execute the requested command.

Parameters:

    - Parser : A pointer to the ATParser instance
    - cmd : The command string, including arguments if required.

Return value:

    The response output for the requested command

*/
/*============================================================================*/
qATResponse_t qATParser_Exec( qATParser_t * const Parser, char *cmd ){
    qATResponse_t RetValue = QAT_NOTFOUND;
    qATCommand_t *Command;
    qATCommandCallback_t CmdCallback;
    if( ( NULL != Parser ) && ( NULL != cmd ) ){
        for( Command = (qATCommand_t*)Parser->qPrivate.First ; NULL != Command ; Command = Command->qPrivate.Next ){ /*loop over the subscribed commands*/ /*MISRAC2012-Rule-11.5 deviation allowed*/
            if( strstr( cmd, Command->Text ) == cmd ){ /*check if the input match the subscribed command starting from the beginning*/
            	RetValue = qAT_NOTALLOWED;
                if( _qATParser_PreProcessing( Command, (char*)cmd, &Parser->qPrivate.Params ) ){ /*if success, proceed with the user pos-processing*/
                    CmdCallback = Command->qPrivate.CommandCallback;
                    if( qATCMDTYPE_UNDEF == Parser->qPrivate.Params.Type ){
                        RetValue = QAT_ERROR;
                    }
                    else{
                        RetValue = CmdCallback( Parser, &Parser->qPrivate.Params  ); /*invoke the callback*/
                    }
                }
                break;
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
static qBool_t _qATParser_PreProcessing( qATCommand_t * const Command, char *InputBuffer, qATParser_PreCmd_t *params ){
    qBool_t RetValue = qFalse;
    size_t argMin, argMax;
    
    params->Type = qATCMDTYPE_UNDEF;
    params->Command = Command;
    params->StrLen = strlen( (const char*)InputBuffer ) - Command->qPrivate.CmdLen;
    params->StrData = (char*)&InputBuffer[ Command->qPrivate.CmdLen ]; /*params->StrData = (char*)(InputBuffer+Command->qPrivate.CmdLen);*/
    params->NumArgs = 0u;

    if( 0u == params->StrLen ){ /*command should be an ACT command */
        if( 0u != ( Command->qPrivate.CmdOpt & (qATParserOptions_t)qATCMDTYPE_ACT ) ){ /*check if is allowed*/
            params->Type = qATCMDTYPE_ACT;  /*set the type to ACT*/
            RetValue = qTrue;
        }
    } 
    else if ( params->StrLen > 0u ){
        if( '?' == params->StrData[0] ){ /*command should be READ command */
            if( 0u != ( Command->qPrivate.CmdOpt & (qATParserOptions_t)qATCMDTYPE_READ ) ){ /*check if is allowed*/
                params->Type = qATCMDTYPE_READ; /*set the type to READ*/
                params->StrData++; /*move string pointer once*/
                params->StrLen--;  /*decrease the len one*/
                RetValue = qTrue;
            }
        } 
        else if( params->StrLen >= 2u ){ /*can be at+xx=? or at+xx=...*/
            if( '=' == params->StrData[0] ){ /*could be a TEST or PARA command*/
                if( '?' == params->StrData[1] ){ 
                    if( 2u == params->StrLen ){ /*command should be a TEST Command*/
                        if( 0u != ( Command->qPrivate.CmdOpt & (qATParserOptions_t)qATCMDTYPE_TEST ) ){ /*check if is allowed*/
                            params->Type = qATCMDTYPE_TEST; /*set the type to TEXT*/
                            params->StrData+=2; /*move string two positions ahead*/
                            params->StrLen-=2u;  /*decrease the len*/
                            RetValue = qTrue;
                        }
                    }
                }
                else{ /*definitely is a PARA command*/
                    if( 0u != ( Command->qPrivate.CmdOpt & (qATParserOptions_t)qATCMDTYPE_PARA ) ){ /*check if is allowed*/
                        params->NumArgs = qATParser_NumOfArgs( params->StrData ); /*get the args count using the default delimiter*/
                        argMin = QATCMDMASK_ARG_MINNUM( (size_t)Command->qPrivate.CmdOpt );
                        argMax = QATCMDMASK_ARG_MAXNUM( (size_t)Command->qPrivate.CmdOpt );
                        if( ( params->NumArgs >= argMin ) && ( params->NumArgs <= argMax ) ){
                            params->Type = qATCMDTYPE_PARA; /*set the type to PARA*/
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
void qATCommandParser_FlushInput( qATParser_t * const Parser ){
	qATParserInput_t *Input;
    if( NULL != Parser ){
        Input = &Parser->qPrivate.Input;
        Input->Ready = qFalse;
        Input->index = 0u;
        Input->Buffer[0] = (char)0x00u;
    }
}
/*============================================================================*/
/*qBool_t qATCommandParser_Run(qATParser_t * const Parser)
 
Run the AT Command Parser when the input is ready.

Parameters:

    - Parser : A pointer to the ATParser instance

Return value:

    qTrue on success, otherwise return qFalse

*/
qBool_t qATParser_Run( qATParser_t * const Parser ){
    qATResponse_t OutputRetval;
    qATResponse_t ParserRetVal;
    qATParserInput_t *Input;
    qBool_t RetValue = qFalse;
    if( NULL != Parser){
		Current = Parser;
        Input =  &Parser->qPrivate.Input;
		ATOutCharFcn = Parser->qPrivate.OutputFcn;
        
		if( Input->Ready ){ /*a new input has arrived*/
			/*Validation : set the value for the response lookup table*/
			if 	( 0 == strcmp( (const char*)Input->Buffer, QAT_DEFAULT_AT_COMMAND ) ){
            	OutputRetval = QAT_OK;			/*check if the input its the simple AT command*/
            }
			else if	( QAT_NOTFOUND != (ParserRetVal = qATParser_Exec( Parser, Input->Buffer ) ) ){
                OutputRetval = ParserRetVal;	/*check if the input is one of the subscribed commands*/
            }
			else if ( 0 == strcmp( (const char*)Input->Buffer, QAT_DEFAULT_ID_COMMAND ) ){
                OutputRetval = QAT_DEVID;		/*check if the input its an ID request using the ATID command*/
            }
			else if	( strlen( (const char*)Input->Buffer ) >= QAT_MIN_INPUT_LENGTH ){
                OutputRetval = QAT_NOTFOUND;	/*check if it is pertinent to show the error*/
            }
			else{
                OutputRetval = QAT_NORESPONSE;  /*nothing to do*/
            }

			if( NULL != Parser->Output ){ /*show the user output if available*/
				if( '\0' != Parser->Output[0] ){
                    _qATParser_HandleCommandResponse( Parser, QAT_OUTPUT );
                }
			}
			_qATParser_HandleCommandResponse( Parser, OutputRetval ); /*print out the command output*/
			/*flush buffers*/
			qATCommandParser_FlushInput( Parser );
			Parser->Output[0] = '\0';
			RetValue = qTrue;
		}
    }
    return RetValue;
}
/*============================================================================*/
static void _qATParser_HandleCommandResponse( const qATParser_t * const Parser, const qATResponse_t retval ){
    qINT32_t ErrorCode;
    qPutchFcn_t PutChar;
    qPutsFcn_t PutString;

    PutChar = Parser->putch;
    PutString = Parser->puts;
    
	if( QAT_NORESPONSE != retval ){
        switch( retval ){ /*handle the command-callback response*/
            case qAT_ERROR:
                PutString( ( NULL != Parser->qPrivate.ERROR_Response )? Parser->qPrivate.ERROR_Response : QAT_DEFAULT_ERROR_RSP_STRING);
                break;
            case qAT_OK:
                PutString( ( NULL != Parser->qPrivate.OK_Response )? Parser->qPrivate.OK_Response: QAT_DEFAULT_OK_RSP_STRING );
                break;
            case qAT_NOTALLOWED:   
                PutString( ( NULL != Parser->qPrivate.ERROR_Response )? Parser->qPrivate.ERROR_Response : QAT_DEFAULT_ERROR_RSP_STRING);
                PutString(QAT_DEAFULT_NOTALLOWED_RSP_STRING);
                break; 
            case qAT_DEVID:
                PutString( ( NULL != Parser->qPrivate.Identifier )? Parser->qPrivate.Identifier: QAT_DEFAULT_DEVID_STRING );
                break;
            case qAT_NOTFOUND:
                PutString( ( NULL != Parser->qPrivate.NOTFOUND_Response )? Parser->qPrivate.NOTFOUND_Response: QAT_DEFAULT_NOTFOUND_RSP_STRING );
                break;        
            case qAT_OUTPUT:
                PutString( Parser->Output );
                break;
            default: /*AT_ERRORCODE(#) */
                if( (qBase_t)retval < 0 ){
                    ErrorCode = QAT_ERRORCODE( (qINT32_t)retval );
                    (void)qItoA(ErrorCode, Parser->Output, 10u);
                    PutString( ( NULL != Parser->qPrivate.ERROR_Response)? Parser->qPrivate.ERROR_Response : QAT_DEFAULT_ERROR_RSP_STRING);
                    PutChar(':');
                    PutString(Parser->Output);
                    Parser->Output[0] = '\0';
                }                            
                break;
        }
        PutString( ( NULL != Parser->qPrivate.term_EOL )? Parser->qPrivate.term_EOL : QAT_DEFAULT_EOL_STRING );
    }
}
/*============================================================================*/
/*char* qATParser_GetArgString( const qATParser_PreCmd_t *param, qINT8_t n, char* out)

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
char* qATParser_GetArgString( const qATParser_PreCmd_t *param, qINT8_t n, char* out ){
	qINT8_t i,j, argc = 0;
	char *RetPtr = NULL;

    if( ( NULL != param ) && ( NULL != out ) && ( n > 0 ) ){
        if( qATCMDTYPE_PARA ==  param->Type ){
            n--;
            j = 0;
            for( i=0 ; '\0' != param->StrData[i]; i++){
                if(argc == n){
                    RetPtr = out;
                    if( ( argc > n ) || ( QAT_DEFAULT_ATSET_DELIM == param->StrData[i] ) ){
                        break;
                    } 
                    out[j++] = param->StrData[i];
                    out[j] = '\0';
                }
                if( QAT_DEFAULT_ATSET_DELIM == param->StrData[i] ){
                    argc++;
                }
            }
        }
    }
	return RetPtr;
}
/*============================================================================*/
static size_t qATParser_NumOfArgs( const char *str ){
	size_t count = 0u;
	while( '\0' != *str ){
        if ( (char)QAT_DEFAULT_ATSET_DELIM == (char)*str++ ){
            ++count;
        }
    }
	return ( count + 1u );
}
/*============================================================================*/
/*char* qATParser_GetArgPtr( const qATParser_PreCmd_t *param, qINT8_t n)

Get the pointer where the desired argument starts.
This function should be only invoked from the callback context of the  recognized command.

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument

Return value:

    A pointer to the desired argument. NULL  pointer if the argument is not present.
*/
char* qATParser_GetArgPtr(const qATParser_PreCmd_t *param, qINT8_t n){
	qIndex_t i, argc = 0;
    char *RetPtr = NULL;
	if( ( NULL != param ) && ( n > 0 ) ) {
        if( qATCMDTYPE_PARA == param->Type ) {
            if( 1 == n ){
                RetPtr = param->StrData;
            } 
            else{
                n--;
	            for( i = 0 ; '\0' != param->StrData[i] ; i++){
		            if( (char)QAT_DEFAULT_ATSET_DELIM == param->StrData[i] ){
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
/*int qATParser_GetArgInt(const qATParser_PreCmd_t *param, qINT8_t n)

This function get the <n> argument parsed as <Integer> from the incoming AT command.
This function should be only invoked from the callback context of the recognized command.
Note: see qAtoI


Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the at-command callback)
    - n : The number of the argument

Return value:

    The argument parsed as integer. Same behavior of qAtoI. If argument not found returns 0
*/
int qATParser_GetArgInt(const qATParser_PreCmd_t *param, qINT8_t n){
	return (int) qAtoI( qATParser_GetArgPtr(param, n) );
}
/*============================================================================*/
/*float qATParser_GetArgFlt(const qATParser_PreCmd_t *param, qINT8_t n)

This function get the <n> argument parsed as <Float> from the incoming AT command.
This function should be only invoked from the callback context of the  recognized command.
Note: see qAtoF

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the at-command callback)
    - n : The number of the argument

Return value:

    The argument parsed as Float. Same behavior of qAtoF. If argument not found returns 0
*/
qFloat32_t qATParser_GetArgFlt( const qATParser_PreCmd_t *param, qINT8_t n ){
	return (qFloat32_t) qAtoF( qATParser_GetArgPtr(param, n) );
}
/*============================================================================*/
/*qUINT32_t qATParser_GetArgHex( const qATParser_PreCmd_t *param, qINT8_t n)

This function get the <n> HEX argument parsed <qUINT32_t> from the
incoming AT command.
This function should be only invoked from the callback context of the recognized command.
Note: see qXtoU32

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument

Return value:

    The HEX argument parsed as qUINT32_t. Same behavior of qXtoU32. If argument not found returns 0
*/
qUINT32_t qATParser_GetArgHex( const qATParser_PreCmd_t *param, qINT8_t n ){
	return (qUINT32_t) qXtoU32( qATParser_GetArgPtr(param, n) );
}
/*=============================================================================*/
#endif /* #if ( Q_ATCOMMAND_PARSER == 1) */