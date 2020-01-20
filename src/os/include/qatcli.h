/*This file is part of the QuarkTS distribution.*/
#ifndef QATCLI_H
    #define QATCLI_H 

    #include "qtypes.h"  
    #include "qioutils.h"  

    #ifdef __cplusplus
    extern "C" {
    #endif

    #define		QAT_DEFAULT_AT_COMMAND	            "at"
    #define		QAT_DEFAULT_ID_COMMAND	            "atid"
    #define		QAT_DEFAULT_ATSET_DELIM	            ','
    #define     QAT_DEFAULT_ERROR_RSP_STRING        "ERROR"
    #define     QAT_DEFAULT_OK_RSP_STRING           "OK"
    #define     QAT_DEFAULT_NOTFOUND_RSP_STRING     "UNKNOWN"
    #define     QAT_DEAFULT_NOTALLOWED_RSP_STRING   ":NOT ALLOWED"
    #define     QAT_DEFAULT_DEVID_STRING             QUARKTS_CAPTION
    #define     QAT_DEFAULT_EOL_STRING               "\r\n"             
    #define     QAT_MIN_INPUT_LENGTH                 ( 3u )

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
        char *Buffer;                                  /*< Points to the user-defined storage area for the input. */
        volatile qIndex_t index;                                /*< Used to hold the index of the current input-buffer. */
        qIndex_t MaxIndex;                                      /*< Max index  = (Size - 1) */
        size_t Size;                                           /*< The size of the input buffer. */     
        volatile qBool_t Ready;                                 /*< A flag that indicates when the input is ready to parse. */  
    }qATParserInput_t;

    typedef void (*qPutchFcn_t)(const char arg);
    typedef void (*qPutsFcn_t)(const char* arg);

    #define QATCMDTYPE_UNDEF    ( 0x0000 )
    #define QATCMDTYPE_PARA     ( 0x0100 )
    #define QATCMDTYPE_TEST     ( 0x0200 )  
    #define QATCMDTYPE_READ     ( 0x0400 )
    #define QATCMDTYPE_ACT      ( 0x0800 )

    #define QATCMDTYPE_SET      ( QATCMDTYPE_PARA )
    #define QATCMDTYPE_CHECK    ( QATCMDTYPE_ACT )

    #define QATCMDMASK_ARG_MAXNUM(opt)   ( ( (opt)>>4 ) & (qATParserOptions_t)0x000Fu )
    #define QATCMDMASK_ARG_MINNUM(opt)   ( (opt) & (qATParserOptions_t)0x000Fu )

    typedef enum{
        qATCMDTYPE_UNDEF    = QATCMDTYPE_UNDEF, /*< None of the above */
        qATCMDTYPE_PARA     = QATCMDTYPE_PARA,  /*< AT+cmd=x,y */
        qATCMDTYPE_TEST     = QATCMDTYPE_TEST,  /*< AT+cmd=? */
        qATCMDTYPE_READ     = QATCMDTYPE_READ,  /*< AT+cmd? */
        qATCMDTYPE_ACT      = QATCMDTYPE_ACT    /*< AT+cmd */     
    }qATCommandType_t;

    typedef qINT8_t qArgNum_t;

    typedef struct{
        void *Command;                                          /*< A pointer to the calling AT Command object. */
        char *StrData;                                          /*< The string data. */      
        char* (*GetArgPtr)( qArgNum_t n );                      /*< To get the pointer where the desired argument starts.*/
        int (*GetArgInt)( qArgNum_t n );                        /*< To get the <n> argument parsed <Integer>*/
        qFloat32_t (*GetArgFlt)( qArgNum_t n );                 /*< To get the <n> argument parsed <Float>*/
        qUINT32_t (*GetArgHex)( qArgNum_t n );                  /*< To get the <n> HEX argument parsed <qUINT32_t>*/
        char* (*GetArgString)( qArgNum_t n, char* out );        /*< This function get the <n> argument parsed as <String>*/
        qATCommandType_t Type;                                  /*< The command type. */
        size_t StrLen;                                          /*< The length of StrData. */
        size_t NumArgs;                                         /*< Number of arguments, only available if Type = QATCMDTYPE_SET. */          
    }qATParser_PreCmd_t;

    typedef struct _qATParser_s{
        qPutchFcn_t putch;                                      /*< Points to a function that writes a single char to the output. */
        qPutsFcn_t puts;                                        /*< Points to a function that writes a string to the output. */
        char *Output;                                           /*< Points to the output buffer storage area. */
        void *UserData;
        private_start{
            void *First;                                        /*< The response printed when OK is needed. */
            const char *OK_Response;                            /*< The response printed when OK is needed. */
            const char *ERROR_Response;                         /*< The response printed when ERROR is needed. */
            const char *NOTFOUND_Response;                      /*< The response printed when NOTFOUND is needed. */
            const char *Identifier;                             /*< The response printed when the "ATID" command has been entered. */
            const char *term_EOL;                               /*< The End Of Line string after a command response */
            qPutChar_t OutputFcn;                               /*< Points to the user-supplied function to write a single byte to the output. */
            void (*xNotifyFcn)(struct _qATParser_s * const arg);/*< Used to notify the attached task if available*/           
            size_t SizeOutput;                                  /*< The size of Output. */
            qATParserInput_t Input;                             /*< The input of the parser. */
            qATParser_PreCmd_t Params;                          /*< The params used as the 2nd cmd-callback argument*/  
        }private_end;
    }qATParser_t;      

    typedef qATResponse_t (*qATCommandCallback_t)(qATParser_t* arg1, qATParser_PreCmd_t* arg2);
    typedef qUINT16_t qATParserOptions_t;

    typedef struct _qATCommand_t{
        void *param;                                            /*< User parameters. */
        char *Text;                                             /*< The command string. Used to match to the input< */
        private_start{                      
            qATCommandCallback_t CommandCallback;               /*< The command callback. */
            struct _qATCommand_t *Next;                         /*< Points to the next command in the list. */
            qATParserOptions_t CmdOpt;                          /*< The command options. */
            size_t CmdLen;                                     /*< The command length. */
        }private_end;       
    }qATCommand_t;

    qBool_t qATParser_Setup( qATParser_t * const Parser, const qPutChar_t OutputFcn, char *Input, const size_t SizeInput, char *Output, const size_t SizeOutput, const char *Identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL );
    qBool_t qATParser_CmdSubscribe( qATParser_t * const Parser, qATCommand_t * const Command, char *TextCommand, const qATCommandCallback_t Callback, qATParserOptions_t CmdOpt, void *param );
    qATCommand_t* qATParser_CmdIterate( qATParser_t * const Parser, qBool_t reload );
    qBool_t qATParser_ISRHandler( qATParser_t * const Parser, char c );
    qBool_t qATParser_ISRHandlerBlock( qATParser_t * const Parser, char *data, const size_t n );
    qBool_t qATParser_Raise( qATParser_t * const Parser, const char *cmd );
    qATResponse_t qATParser_Exec( qATParser_t * const Parser, char *cmd );
    void qATCommandParser_FlushInput( qATParser_t * const Parser );
    qBool_t qATParser_Run( qATParser_t * const Parser );

    char* qATParser_GetArgString( const qATParser_PreCmd_t *param, qINT8_t n, char* out );
    char* qATParser_GetArgPtr( const qATParser_PreCmd_t *param, qINT8_t n );
    int qATParser_GetArgInt( const qATParser_PreCmd_t *param, qINT8_t n );
    qFloat32_t qATParser_GetArgFlt( const qATParser_PreCmd_t *param, qINT8_t n );
    qUINT32_t qATParser_GetArgHex( const qATParser_PreCmd_t *param, qINT8_t n );

    #ifdef __cplusplus
    }
    #endif

#endif