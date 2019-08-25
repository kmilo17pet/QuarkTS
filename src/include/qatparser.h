#ifndef QATPARSER_H
    #define QATPARSER_H 

    #define     QAT_PARSER_TASK_LINK                1   /*enable or disable the task attachment functionality to this module*/
    
    #include "qtypes.h"  
    #if ( QAT_PARSER_TASK_LINK == 1)
        #include "qkernel.h"
    #endif 
    #include "qioutils.h"  

    
    #define		QAT_DEFAULT_AT_COMMAND	            "at"
    #define		QAT_DEFAULT_ID_COMMAND	            "atid"
    #define		QAT_DEFAULT_ATSET_DELIM	            ','
    #define     QAT_DEFAULT_ERROR_RSP_STRING        "ERROR"
    #define     QAT_DEFAULT_OK_RSP_STRING           "OK"
    #define     QAT_DEFAULT_NOTFOUND_RSP_STRING     "UNKNOWN"
    #define     QAT_DEAFULT_NOTALLOWED_RSP_STRING   ":NOT ALLOWED"
    #define     QAT_DEFAULT_DEVID_STRING            QUARKTS_CAPTION
    #define     QAT_DEFAULT_EOL_STRING              "\r\n"              
    #define     QAT_MIN_INPUT_LENGTH                ( 3u )

    typedef enum{
        qAT_ERROR = -32768,
        qAT_NOTALLOWED = -32767,
        qAT_NORESPONSE = 0,
        qAT_OK = 1,
        qAT_DEVID = 32765,
        qAT_NOTFOUND = 32766,
        qAT_OUTPUT = 32767
    }qATResponse_t; 

    #define     qAT_ERRORCODE(ecode)     (-(ecode) )
    #define     QAT_ERROR                ( qAT_ERROR )
    #define     QAT_NORESPONSE           ( qAT_NORESPONSE )
    #define     QAT_OK                   ( qAT_OK )
    #define     QAT_ERRORCODE(_num_)     ( qAT_ERRORCODE(_num_) )
    #define     QAT_DEVID                ( qAT_DEVID )
    #define     QAT_NOTFOUND             ( qAT_NOTFOUND )    
    #define     QAT_OUTPUT               ( qAT_OUTPUT )

    typedef volatile struct{
        volatile uint8_t Ready;
        volatile uint16_t index;
        qSize_t Size;
        volatile char *Buffer;
    }qATParserInput_t;

    typedef void (*qPutchFcn_t)(const char arg);
    typedef void (*qPutsFcn_t)(const char* arg);

    typedef struct{
        qPutchFcn_t putch;
        qPutsFcn_t puts;
        char *Output;
        private_start{
            void *First;
            const char *OK_Response;
            const char *ERROR_Response;
            const char *NOTFOUND_Response;
            const char *Identifier;
            const char *term_EOL;
            qPutChar_t OutputFcn;
            #if ( QAT_PARSER_TASK_LINK == 1 )
                qTask_t *Task;
            #endif
            qSize_t SizeOutput;
            qATParserInput_t Input;
        }private_end;
    }qATParser_t;   
    
    #define QATCMDTYPE_UNDEF    ( 0x0000 )
    #define QATCMDTYPE_PARA     ( 0x0100 )
    #define QATCMDTYPE_TEST     ( 0x0200 )  
    #define QATCMDTYPE_READ     ( 0x0400 )
    #define QATCMDTYPE_ACT      ( 0x0800 )

    #define QATCMDTYPE_SET      ( QATCMDTYPE_PARA )
    #define QATCMDTYPE_CHECK    ( QATCMDTYPE_ACT )

    #define QATCMDMASK_ARG_MAXNUM(opt)   (((opt)>>4)&0x000Fu)
    #define QATCMDMASK_ARG_MINNUM(opt)   ((opt)&0x000Fu)

    typedef enum{
        qATCMDTYPE_UNDEF    = QATCMDTYPE_UNDEF, /* None of the above */
        qATCMDTYPE_PARA     = QATCMDTYPE_PARA,  /* AT+cmd=x,y */
        qATCMDTYPE_TEST     = QATCMDTYPE_TEST,  /* AT+cmd=? */
        qATCMDTYPE_READ     = QATCMDTYPE_READ,  /* AT+cmd? */
        qATCMDTYPE_ACT      = QATCMDTYPE_ACT    /* AT+cmd */     
    }qATCommandType_t;

    typedef struct{
        void *Command; /*a pointer to the calling AT Command object*/
        char *StrData; /*the string data*/
        qATCommandType_t Type; /*The command type*/
        qSize_t StrLen; /*the length of StrData*/
        qSize_t NumArgs; /*Number of arguments, only available if Type = QATCMDTYPE_SET*/
    }qATParser_PreCmd_t;

    typedef qATResponse_t (*qATCommandCallback_t)(qATParser_t*arg1, qATParser_PreCmd_t* arg2);
    
    typedef struct _qATCommand_t{
        private_start{
            char *Text;
            qATCommandCallback_t CommandCallback;
            struct _qATCommand_t *Next;
            uint16_t CmdOpt;
            qSize_t CmdLen;
        }private_end;
    }qATCommand_t;

    qBool_t qATParser_Setup( qATParser_t * const Parser, const qPutChar_t OutputFcn, char *Input, const qSize_t SizeInput, char *Output, const qSize_t SizeOutput, const char *Identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL );
    qBool_t qATParser_CmdSubscribe( qATParser_t * const Parser, qATCommand_t * const Command, const char *TextCommand, qATCommandCallback_t Callback, uint16_t CmdOpt );
    qBool_t qATParser_ISRHandler( qATParser_t * const Parser, char c );
    qBool_t qATParser_ISRHandlerBlock( qATParser_t * const Parser, char *data, const qSize_t n );
    qBool_t qATParser_Raise( qATParser_t * const Parser, const char *cmd );
    qATResponse_t qATParser_Exec( qATParser_t * const Parser, const char *cmd );
    void qATCommandParser_FlushInput( qATParser_t * const Parser );
    qBool_t qATParser_Run( qATParser_t * const Parser );

    char* qATParser_GetArgString( const qATParser_PreCmd_t *param, int8_t n, char* out );
    char* qATParser_GetArgPtr( const qATParser_PreCmd_t *param, int8_t n );
    int qATParser_GetArgInt( const qATParser_PreCmd_t *param, int8_t n );
    float qATParser_GetArgFlt( const qATParser_PreCmd_t *param, int8_t n );
    uint32_t qATParser_GetArgHex( const qATParser_PreCmd_t *param, int8_t n );

    #if ( QAT_PARSER_TASK_LINK == 1 )
        qBool_t qSchedulerAdd_ATParserTask( qTask_t *Task, qATParser_t *Parser, qPriority_t Priority );
    #endif

#endif