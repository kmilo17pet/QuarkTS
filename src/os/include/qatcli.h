/*This file is part of the QuarkTS distribution.*/
#ifndef QATCLI_H
    #define QATCLI_H 

    #include "qtypes.h"  
    #include "qioutils.h"  

    #ifdef __cplusplus
    extern "C" {
    #endif

    #define		QATCLI_DEFAULT_AT_COMMAND	            "at"
    #define		QATCLI_DEFAULT_ID_COMMAND	            "atid"
    #define		QATCLI_DEFAULT_ATSET_DELIM	            ','
    #define     QATCLI_DEFAULT_ERROR_RSP_STRING         "ERROR"
    #define     QATCLI_DEFAULT_OK_RSP_STRING            "OK"
    #define     QATCLI_DEFAULT_NOTFOUND_RSP_STRING      "UNKNOWN"
    #define     QATCLI_DEAFULT_NOTALLOWED_RSP_STRING    ":NOT ALLOWED"
    #define     QATCLI_DEFAULT_DEVID_STRING             QUARKTS_CAPTION
    #define     QATCLI_DEFAULT_EOL_STRING               "\r\n"             
    #define     QATCLI_MIN_INPUT_LENGTH                 ( 3u )
    #define     QATCLI_RECOMMENDED_INPUT_SIZE           ( (size_t)128 )

    typedef enum{
        qATCLI_ERROR = -32768,
        qATCLI_NOTALLOWED = -32767,
        qATCLI_NORESPONSE = 0,
        qATCLI_OK = 1,
        qATCLI_DEVID = 32765,
        qATCLI_NOTFOUND = 32766,
        qATCLI_OUTPUT = 32767
    }qATCLI_Response_t; 

    #define     qATCLI_ERRORCODE(ecode)     (-(ecode) )
    #define     QATCLI_ERRORCODE(_num_)     ( qATCLI_ERRORCODE(_num_) )
    
    #define     QATCLI_ERROR                ( qATCLI_ERROR )
    #define     QATCLI_NORESPONSE           ( qATCLI_NORESPONSE )
    #define     QATCLI_OK                   ( qATCLI_OK )
    #define     QATCLI_DEVID                ( qATCLI_DEVID )
    #define     QATCLI_NOTFOUND             ( qATCLI_NOTFOUND )    
    #define     QATCLI_OUTPUT               ( qATCLI_OUTPUT )

    typedef volatile struct{
        char *Buffer;                       /*< Points to the user-defined storage area for the input. */
        volatile qIndex_t index;            /*< Used to hold the index of the current input-buffer. */
        qIndex_t MaxIndex;                  /*< Max index  = (Size - 1) */
        size_t Size;                        /*< The size of the input buffer. */     
        volatile qBool_t Ready;             /*< A flag that indicates when the input is ready to parse. */  
    }qATCLI_Input_t;

    typedef void (*qPutchFcn_t)(const char arg);
    typedef void (*qPutsFcn_t)(const char* arg);

    #define QATCLI_CMDTYPE_UNDEF    ( 0x0000 )
    #define QATCLI_CMDTYPE_PARA     ( 0x0100 )
    #define QATCLI_CMDTYPE_TEST     ( 0x0200 )  
    #define QATCLI_CMDTYPE_READ     ( 0x0400 )
    #define QATCLI_CMDTYPE_ACT      ( 0x0800 )

    #define QATCLI_CMDTYPE_SET      ( QATCMDTYPE_PARA )
    #define QATCLI_CMDTYPE_CHECK    ( QATCMDTYPE_ACT )

    typedef enum{
        qATCLI_CMDTYPE_UNDEF    = QATCLI_CMDTYPE_UNDEF, /*< None of the above */
        qATCLI_CMDTYPE_PARA     = QATCLI_CMDTYPE_PARA,  /*< AT+cmd=x,y */
        qATCLI_CMDTYPE_TEST     = QATCLI_CMDTYPE_TEST,  /*< AT+cmd=? */
        qATCLI_CMDTYPE_READ     = QATCLI_CMDTYPE_READ,  /*< AT+cmd? */
        qATCLI_CMDTYPE_ACT      = QATCLI_CMDTYPE_ACT    /*< AT+cmd */     
    }qATCLI_CommandType_t;

    typedef qINT8_t qArgNum_t;

    typedef struct{
        void *Command;                                          /*< A pointer to the calling AT Command object. */
        char *StrData;                                          /*< The string data. */      
        char* (*GetArgPtr)( qArgNum_t n );                      /*< To get the pointer where the desired argument starts.*/
        int (*GetArgInt)( qArgNum_t n );                        /*< To get the <n> argument parsed <Integer>*/
        qFloat32_t (*GetArgFlt)( qArgNum_t n );                 /*< To get the <n> argument parsed <Float>*/
        qUINT32_t (*GetArgHex)( qArgNum_t n );                  /*< To get the <n> HEX argument parsed <qUINT32_t>*/
        char* (*GetArgString)( qArgNum_t n, char* out );        /*< This function get the <n> argument parsed as <String>*/
        qATCLI_CommandType_t Type;                              /*< The command type. */
        size_t StrLen;                                          /*< The length of StrData. */
        size_t NumArgs;                                         /*< Number of arguments, only available if Type = QATCMDTYPE_SET. */          
    }_qATCLI_PreCmd_Block_t;

    typedef struct{
        qPutchFcn_t putch;                                      /*< Points to a function that writes a single char to the output. */
        qPutsFcn_t puts;                                        /*< Points to a function that writes a string to the output. */
        char *Output;                                           /*< Points to the output buffer storage area. */
        void *UserData;
    }_qATCLI_PublicData_t;

    typedef _qATCLI_PublicData_t* qATCLI_Handler_t; 
    typedef _qATCLI_PreCmd_Block_t* qATCLI_PreCmd_t;

    typedef struct _qATCLI_ControlBlock_s{
        /*This data should be handled only using the provided API*/
        struct _qATCLI_Private_s{
            void *First;                                                    /*< Points to the first command*/
            const char *OK_Response;                                        /*< The response printed when OK is needed. */
            const char *ERROR_Response;                                     /*< The response printed when ERROR is needed. */
            const char *NOTFOUND_Response;                                  /*< The response printed when NOTFOUND is needed. */
            const char *Identifier;                                         /*< The response printed when the "ATID" command has been entered. */
            const char *term_EOL;                                           /*< The End Of Line string after a command response */
            qPutChar_t OutputFcn;                                           /*< Points to the user-supplied function to write a single byte to the output. */
            void (*xNotifyFcn)(struct _qATCLI_ControlBlock_s * const arg);  /*< Used to notify the attached task if available*/           
            size_t SizeOutput;                                              /*< The size of Output. */
            qATCLI_Input_t Input;                                           /*< The input of the CLI. */
            _qATCLI_PreCmd_Block_t Params;                                  /*< The params used as the 2nd cmd-callback argument*/     
            _qATCLI_PublicData_t xPublic;                                   /*< External accesible throught the qATCLI_Handler_t*/
        }qPrivate;
    }qATCLI_t;  

    typedef qATCLI_Response_t (*qATCLI_CommandCallback_t)(qATCLI_Handler_t arg1, qATCLI_PreCmd_t arg2);
    typedef qUINT16_t qATCLI_Options_t;

    typedef struct _qATCLI_Command_s{
        void *param;                                            /*< User parameters. */
        char *Text;                                             /*< The command string. Used to match to the input< */
        /*This data should be handled only using the provided API*/
        struct _qATCLI_Command_Private_s{                      
            qATCLI_CommandCallback_t CommandCallback;           /*< The command callback. */
            struct _qATCLI_Command_s *Next;                     /*< Points to the next command in the list. */
            qATCLI_Options_t CmdOpt;                            /*< The command options. */
            size_t CmdLen;                                      /*< The command length. */
        }qPrivate;       
    }qATCLI_Command_t;

    qBool_t qATCLI_Setup( qATCLI_t * const cli, const qPutChar_t OutputFcn, char *Input, const size_t SizeInput, char *Output, const size_t SizeOutput, const char *Identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL );
    qBool_t qATCLI_CmdSubscribe( qATCLI_t * const cli, qATCLI_Command_t * const Command, char *TextCommand, const qATCLI_CommandCallback_t Callback, qATCLI_Options_t CmdOpt, void *param );
    qATCLI_Command_t* qATCLI_CmdIterate( qATCLI_t * const cli, qBool_t reload );
    qBool_t qATCLI_ISRHandler( qATCLI_t * const cli, char c );
    qBool_t qATCLI_ISRHandlerBlock( qATCLI_t * const cli, char *data, const size_t n );
    qBool_t qATCLI_Raise( qATCLI_t * const cli, const char *cmd );
    qATCLI_Response_t qATCLI_Exec( qATCLI_t * const cli, char *cmd );
    void qATCLI_Input_Flush( qATCLI_t * const cli );
    qBool_t qATCLI_Run( qATCLI_t * const cli );

    char* qATCLI_GetArgString( const qATCLI_PreCmd_t param, qINT8_t n, char* out );
    char* qATCLI_GetArgPtr( const qATCLI_PreCmd_t param, qINT8_t n );
    int qATCLI_GetArgInt( const qATCLI_PreCmd_t param, qINT8_t n );
    qFloat32_t qATCLI_GetArgFlt( const qATCLI_PreCmd_t param, qINT8_t n );
    qUINT32_t qATCLI_GetArgHex( const qATCLI_PreCmd_t param, qINT8_t n );

    #ifdef __cplusplus
    }
    #endif

#endif
