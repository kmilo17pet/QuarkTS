/*!
 * @file qatcli.h
 * @author J. Camilo Gomez C.
 * @version 2.53
 * @note This file is part of the QuarkTS distribution.
 * @brief API for the AT Command Line Interface(AT-CLI) module.
 **/
#ifndef QATCLI_H
    #define QATCLI_H 

    #include "qtypes.h"  
    #include "qioutils.h"  

    #ifdef __cplusplus
    extern "C" {
    #endif

    #ifndef Q_ATCLI
        #define Q_ATCLI     ( 1 )
    #endif

    /** @addtogroup  qatcli AT Command Line Interface
    * @brief API for the AT Command Line Interface(AT-CLI) module.
    *  @{
    */

    /**
    * @brief an enumeration to define the possible values that can be returned from the callback of a command.
    */
    typedef enum{
        qATCLI_ERROR = -32767,          /**< To indicate an error operation. The CLI will print the  ERROR_String to the output.*/
        qATCLI_NOTALLOWED = -32766,     /**< To indicate an successfull operation. The CLI will print the " string to the output.*/
        qATCLI_NORESPONSE = 0,          /**< To indicate that no response will be printed out.*/
        qATCLI_OK = 1,                  /**< To indicate an successfull operation. The CLI will print the  OK_String to the output.*/
        qATCLI_DEVID = 32765,           /**< To indicate that the Device Identifier should be print out.*/
        qATCLI_NOTFOUND = 32766,        /**< To indicate that the command was not found. The CLI will print the NOTFOUND_strint to the output*/
        qATCLI_OUTPUT = 32767           /**< To indicate that only the output buffer will be print out*/
    }qATCLI_Response_t; 

    /**
    * @brief Used to indicate an error code as return value inside a command-callback.
    * This code is defined by the application writer and should be a value between 1 and 32766. 
    * 
    * For example, a return value of QATCLI_ERRORCODE(15), will print out the string "ERROR:15".
    */ 
    #define     qATCLI_ERRORCODE(ecode)     (-(ecode) )


    /*! @cond PRIVATE */
    typedef volatile struct _qATCLI_Input_s{
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

    #define QATCLI_CMDTYPE_SET      ( QATCLI_CMDTYPE_PARA )
    #define QATCLI_CMDTYPE_CHECK    ( QATCLI_CMDTYPE_ACT )

    /*! @endcond PRIVATE */    

    /**
    * @brief An enum to describe the available AT command types.
    */
    typedef enum{
        qATCLI_CMDTYPE_UNDEF    = QATCLI_CMDTYPE_UNDEF, /**< Was not able to detected a correct input command*/
        qATCLI_CMDTYPE_PARA     = QATCLI_CMDTYPE_PARA,  /**< Command that receives parameters (comma separated arguments after the equal(=) symbol) : AT+cmd=x,y */
        qATCLI_CMDTYPE_TEST     = QATCLI_CMDTYPE_TEST,  /**< Command in test mode (no arguments allowed): AT+cmd=? */
        qATCLI_CMDTYPE_READ     = QATCLI_CMDTYPE_READ,  /**< Command to query information(data allowed after the ? symbol)  : AT+cmd? */
        qATCLI_CMDTYPE_ACT      = QATCLI_CMDTYPE_ACT    /**< Command to perform an action (no arguments allowed) : AT+cmd */     
    }qATCLI_CommandType_t;

    /** 
    * @brief The command argument with all the regarding information of the incoming AT command.
    * @note Should be used only in command-callbacks as the only input argument. 
    * @note The members of this structure must be read as if it were a pointer.
    */
    typedef struct _qATCLI_PublicData_s{ /*public data only available inside the command callback*/
        /**
        * @brief  A pointer to the calling AT Command object. 
        */  
        void *Command;
        /**
        * @brief  The string data received after the detected command. 
        */          
        char *StrData;  
        /**
        * @brief  Helper method to get the pointer where the desired argument starts.
        * @param n The number of the argument
        * @return  A pointer to the desired argument. NULL  pointer if the argument is not present.
        */            
        char* (*GetArgPtr)( qIndex_t n );
        /**
        * @brief  Helper method to get the <b>n</b> argument parsed as integer from the
        * incoming AT command.
        * @note see <b>qIOUtil_AtoI</b>
        * @param n The number of the argument
        * @return  The argument parsed as integer. Same behavior of <b>qIOUtil_AtoI</b>. If argument not found returns 0.
        */            
        int (*GetArgInt)( qIndex_t n );                         
        /**
        * @brief  Helper method to get the <b>n</b> argument parsed as float from the
        * incoming AT command.
        * @note see <b>qIOUtil_AtoF</b>
        * @param n The number of the argument
        * @return  The argument parsed as Float. Same behavior of <b>qIOUtil_AtoF</b>. If argument not found returns 0.0f
        */         
        qFloat32_t (*GetArgFlt)( qIndex_t n );
        /**
        * @brief  Helper method to get the <b>n</b> HEX argument parsed qUINT32_t from the incoming AT command.
        * @note see <b>qIOUtil_XtoU32</b>
        * @param n The number of the argument
        * @return  The HEX argument parsed as qUINT32_t. Same behavior of <b>qIOUtil_XtoU32</b>. If argument not found returns 0.
        */          
        qUINT32_t (*GetArgHex)( qIndex_t n );
        /**
        * @brief  Helper method to get the <b>n</b> argument parsed as string from the incoming AT command.
        * @param n The number of the argument
        * @param out Array in memory where to store the resulting null-terminated string.
        * @return  Same as <b>out</b> on success, otherwise returns NULL.
        */          
        char* (*GetArgString)( qIndex_t n, char* out );
        /**
        * @brief  Helper method for printing character to the CLI output. 
        * It displays only one character at a time.
        * @param arg The ASCII character. 
        * @return  none.
        */         
        qPutchFcn_t putch;
        /**
        * @brief Writes a string to CLI output including the EOF string appended at the end.
        * @param arg This is the C string to be written.
        * @return  none.
        */         
        qPutsFcn_t puts;
        /**
        * @brief The CLI output buffer. Can be writtern by the user. 
        */          
        char *Output;
        /**
        * @brief Points to the user-defined data - Storage Pointer.
        */             
        void *UserData;
        /**
        * @brief The length of <b>StrData</b>.
        */           
        size_t StrLen;
        /**
        * @brief Number of arguments, only available if Type = <b>QATCMDTYPE_SET</b>.
        */             
        size_t NumArgs;       
        /**
        * @brief The incoming command type. *
        */          
        qATCLI_CommandType_t Type;
    #ifdef DOXYGEN    
    }qATCLI_Handler_t;
    #else
    }_qATCLI_PublicData_t; 
    typedef _qATCLI_PublicData_t* qATCLI_Handler_t; 
    #endif

    /** 
    * @brief An AT Command Line Interface (CLI) object
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qATCLI_ControlBlock_s{
        /*! @cond PRIVATE */
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
            _qATCLI_PublicData_t xPublic;                                   /*< External accesible throught the qATCLI_Handler_t*/
        }qPrivate;
        /*! @endcond PRIVATE */
    }qATCLI_t;  

    /**
    * @brief Pointer to function  : An AT-Command callback
    * 
    * Example :
    * @code{.c}
    * qATCLI_Response_t commandCallback_example( qATCLI_Handler_t h ){
    *       qATCLI_Response_t retValue = qATCLI_ERROR;
    *       switch( h->Type ){
    *           case qATCLI_CMDTYPE_ACT:
    *               h->puts( "Test message" );
    *               retValue = qATCLI_OK;
    *               break;
    *           default:
    *               break; 
    *       }
    *       return retValue;
    * }
    * @endcode
    * @param arg1 The current interrupt configuration 
    * @return none.
    */
    typedef qATCLI_Response_t (*qATCLI_CommandCallback_t)(qATCLI_Handler_t arg1);

    /** 
    * @brief A typedef that holds the options for an AT-Command object
    */
    typedef qUINT16_t qATCLI_Options_t;

    /** 
    * @brief An AT-Command object
    */
    typedef struct _qATCLI_Command_s{
        void *param;                                            /**< User parameters. */
        char *Text;                                             /**< The command string. Used to match to the input*/
        /*! @cond PRIVATE */
        struct _qATCLI_Command_Private_s{                      
            qATCLI_CommandCallback_t CommandCallback;           /*< The command callback. */
            struct _qATCLI_Command_s *Next;                     /*< Points to the next command in the list. */
            qATCLI_Options_t CmdOpt;                            /*< The command options. */
            size_t CmdLen;                                      /*< The command length. */
        }qPrivate;      
        /*! @endcond PRIVATE */ 
    }qATCLI_Command_t;

    /**
    * @brief Setup an instance of the AT Command Command Line Interface.
    * @param cli A pointer to the AT Command Line Interface instance
    * @param OutputFcn The basic output-char wrapper function. All the CLI responses will be 
    * printed-out through this function.
    * @param Input A memory location to store the cli input (Mandatory)
    * @param SizeInput The size of the memory allocated in <b>Input</b> 
    * @param Output A memory location to store the CLI output
    * @param SizeOutput The size of the memory allocated in <b>Output</b> 
    * @param Identifier The device identifier string. This string will be printed-out
    * after a call to the ATCLI_DEFAULT_ID_COMMAND
    * @param OK_Response The output message when a command callback returns QATCLI_OK.  
    * @param ERROR_Response  The output message when a command callback returns QATCLI_ERROR 
    * or any QATCLI_ERRORCODE(#)
    * @param NOTFOUND_Response The output message when input doesn't match with any of 
    * the available commands
    * @param term_EOL The End-Of-Line string printed out after any of the CLI messages 
    * @return qTrue on success, otherwise return qFalse.
    */   
    qBool_t qATCLI_Setup( qATCLI_t * const cli, const qPutChar_t OutputFcn, char *Input, const size_t SizeInput, char *Output, const size_t SizeOutput, const char *Identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL );

    /**
    * @brief This function subscribes the CLI instance to a specific command with an associated 
    * Callback function, so that next time the required command is sent to the CLI input, the 
    * callback function will be executed. The CLI module only analyze commands that follows the 
    * extended AT-Commands syntax (+ can be ignored).
    * @param cli A pointer to the AT Command Line Interface instance
    * @param Command A pointer to the AT command object.
    * @param TextCommand The string (name) of the command we want to subscribe to. Since this 
    * service only handles AT commands, this string has  to begin by the "at" characters and 
    * should be in lower case.
    * @param Callback The handler of the callback function associated to the command. 
    * Prototype: qATCLI_Response_t xCallback( qATCLI_Handler_t )
    * @param CmdOpt This flag combines with a bitwise OR the following information:
    * 
    * <b>qATCLI_CMDTYPE_PARA</b>  : "AT+cmd=x,y" is allowed. The execution of the callback
    * function also depends on whether the number of argument  is valid or not. Information 
    * about number of arguments is combined with a bitwise 'OR' : QATCMDTYPE_PARA | 0xXY , 
    * where X which defines maximum argument number for incoming command and Y which 
    * defines minimum argument number for incoming command
    * 
    * <b>qATCLI_CMDTYPE_TEST</b>  : "AT+cmd=?" is allowed. 
    * 
    * <b>qATCLI_CMDTYPE_READ</b>  : "AT+cmd?" is allowed.
    * 
    * <b>qATCLI_CMDTYPE_ACT</b>   : "AT+cmd" is allowed.  
    * 
    * @param param User storage pointer.
    * @return qTrue on success, otherwise return qFalse.
    */ 
    qBool_t qATCLI_CmdSubscribe( qATCLI_t * const cli, qATCLI_Command_t * const Command, char *TextCommand, const qATCLI_CommandCallback_t Callback, qATCLI_Options_t CmdOpt, void *param );
    
    /**
    * @brief Iterate between the commands available inside the AT-CLI instance.
    * @param cli A pointer to the AT Command Line Interface instance
    * @param reload If qTrue, the iterator will set their position at the beginning.
    * @return The current iterated command. NULL when no more commands are available.
    */ 
    qATCLI_Command_t* qATCLI_CmdIterate( qATCLI_t * const cli, qBool_t reload );

    /**
    * @brief Feed the CLI input with a single character. This call is mandatory 
    * from an interrupt context. Put it inside the desired peripheral's ISR.
    * If your ISR get a block of data, use instead <b>qATCLI_ISRHandlerBlock</b>
    * @param cli A pointer to the AT Command Line Interface instance
    * @param c The incoming byte/char to the input. 
    * @return qTrue when the CLI is ready to process the input, otherwise return qFalse
    */     
    qBool_t qATCLI_ISRHandler( qATCLI_t * const cli, char c );

    /**
    * @brief Feed the CLI input with a string. This call is mandatory 
    * from an interrupt context. Put it inside the desired peripheral's ISR.
    * If your ISR only get a single char, use instead <b>qATCLI_ISRHandler</b>
    * @param cli A pointer to the AT Command Line Interface instance
    * @param Data The incoming string.
    * @param n The length of the string.
    * @return qTrue when the CLI is ready to process the input, otherwise return qFalse
    */     
    qBool_t qATCLI_ISRHandlerBlock( qATCLI_t * const cli, char *Data, const size_t n );

    /**
    * @brief Sends a command to the specified AT Command Line Interface instance.
    * @param cli A pointer to the AT Command Line Interface instance
    * @param cmd The command string, including arguments if required.
    * @return qTrue when the CLI accepts the input. If busy, return qFalse
    */         
    qBool_t qATCLI_Raise( qATCLI_t * const cli, const char *cmd );

    /**
    * @brief Try to execute the requested command.
    * @param cli A pointer to the AT Command Line Interface instance
    * @param cmd The command string, including arguments if required.
    * @return The response output for the requested command.
    */     
    qATCLI_Response_t qATCLI_Exec( qATCLI_t * const cli, char *cmd );

    /**
    * @brief Flush the CLI input buffer.
    * @param cli A pointer to the AT Command Line Interface instance
    * @return qTrue on success, otherwise return qFalse
    */   
    void qATCLI_Input_Flush( qATCLI_t * const cli );

    /**
    * @brief Run the AT Command Line Interface when the input is ready.
    * @param cli A pointer to the AT Command Line Interface instance
    * @return qTrue on success, otherwise return qFalse
    */       
    qBool_t qATCLI_Run( qATCLI_t * const cli );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif