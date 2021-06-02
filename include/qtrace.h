/*!
* @file qtrace.h
* @author J. Camilo Gomez C.
* @version 1.45
* @note This file is part of the QuarkTS distribution.
* @brief API interfaces for the trace and debug messages
*/
#ifndef QTRACE_H
    #define QTRACE_H

    #include "qtypes.h"
    #include "qclock.h"
    #include "qioutils.h"
   
    #ifdef __cplusplus
    extern "C" {
    #endif


    #ifndef Q_TRACE_VARIABLES
        #define Q_TRACE_VARIABLES       ( 1 )
    #endif

    #ifndef Q_DEBUGTRACE_BUFSIZE
        #define Q_DEBUGTRACE_BUFSIZE    ( 36 )
    #endif

    #ifndef Q_DEBUGTRACE_FULL
        #define Q_DEBUGTRACE_FULL       ( 1 )
    #endif

    #if ( Q_DEBUGTRACE_BUFSIZE < 36 )
        #error Q_DEBUGTRACE_BUFSIZE its is too small. Use a value greather o equal to 36.
    #endif

    #define _qSTRINGIFY(x) #x
    #define _qTOSTRING(x) _qSTRINGIFY(x)

    #ifndef _QTRACE_FUNC
        #if defined __cplusplus && defined __GNUC__ /* Use g++'s demangled names in C++.  */
            #if  __GNUC__ >= 2
                #define _QTRACE_FUNC __PRETTY_FUNCTION__
            #else
                #define _QTRACE_FUNC   __func__
            #endif       
        #elif defined(__GNUC__) || (defined(__MWERKS__) && (__MWERKS__ >= 0x3000)) || (defined(__ICC) && (__ICC >= 600)) || defined(__ghs__)
            #define _QTRACE_FUNC __PRETTY_FUNCTION__
        #elif defined(__DMC__) && (__DMC__ >= 0x810)
            #define _QTRACE_FUNC __PRETTY_FUNCTION__
        #elif defined(__FUNCSIG__)
            #define _QTRACE_FUNC __FUNCSIG__
        #elif (defined(__INTEL_COMPILER) && (__INTEL_COMPILER >= 600)) || (defined(__IBMCPP__) && (__IBMCPP__ >= 500))
            #define _QTRACE_FUNC __FUNCTION__
        #elif defined(__BORLANDC__) && (__BORLANDC__ >= 0x550)
            #define _QTRACE_FUNC __FUNC__
        #elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901)
            #define _QTRACE_FUNC __func__
        #elif defined(__cplusplus) && (__cplusplus >= 201103)
            #define _QTRACE_FUNC __func__                
        #else /* failed to detect __func__ support.  */
            #define _QTRACE_FUNC ((char *) 0)
        #endif
    #endif

    #define _qAT() ":" _qTOSTRING(__LINE__) " "

    /** @addtogroup qtrace
    * @brief API interfaces to print out trace and debug messages.
    *  @{
    */
  
    /*! @cond  */
    #ifndef Message
        #define Message             Message
    #endif
    #ifndef String
        #define String              String
    #endif
    #ifndef Bool
        #define Bool                Bool
    #endif
    #ifndef qBool
        #define qBool               qBool
    #endif
    #ifndef Float
        #define Float               Float
    #endif
    #ifndef Binary
        #define Binary              Binary
    #endif
    #ifndef Octal
        #define Octal               Octal
    #endif
    #ifndef Decimal
        #define Decimal             Decimal 
    #endif
    #ifndef Hexadecimal
        #define Hexadecimal         Hexadecimal
    #endif
    #ifndef UnsignedBinary
        #define UnsignedBinary      UnsignedBinary
    #endif
    #ifndef UnsignedOctal
        #define UnsignedOctal       UnsignedOctal
    #endif
    #ifndef UnsignedDecimal
        #define UnsignedDecimal     UnsignedDecimal
    #endif
    #ifndef UnsignedHexadecimal
        #define UnsignedHexadecimal UnsignedHexadecimal
    #endif
    /*! @endcond  */

    #if ( Q_TRACE_VARIABLES == 1 )
        /*! @cond  */
        extern char qTrace_PublicBuffer[ Q_DEBUGTRACE_BUFSIZE ];
        void _qtrace_func( const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, size_t BlockSize );
        /*! @endcond  */

        /**
        * @brief This API set the output method for debug/trace messages.
        * @param[in] fcn The basic output byte function.
        * @return none.
        */            
        void qTrace_Set_OutputFcn(qPutChar_t fcn);

        /*On-demand debug/trace macros*/
        /**
        * @brief Output a trace message,
        * @note The Debug/Trace function must be previously defined with qTrace_Set_OutputFcn()
        * @return none.
        */         
        #define qTrace()                         _qtrace_func( _qAT(), _QTRACE_FUNC, "", "", NULL, 0 )   

        /**
        * @brief Output a debug message,
        * @note the Debug/Trace function must be previously defined with qTrace_Set_OutputFcn
        * @return none.
        */               
        #define qDebug_Caller()                  _qtrace_func( "",_QTRACE_FUNC, "", "", NULL, 0 )   

        /*! @cond  */
        #define qDebug_Message(Var)              _qtrace_func( "", NULL, "", (char*)(Var), NULL, 0)
        #define qDebug_String(Var)               _qtrace_func( "", NULL, #Var "="  , (char*)(Var), NULL, 0)
        #define qDebug_Bool(Var)                 _qtrace_func( "", NULL, #Var "="  , qIOUtil_BtoA(( qBool_t)(Var), qTrace_PublicBuffer    ), NULL, 0 )
        #define qDebug_qBool(Var)                _qtrace_func( "", NULL, #Var "="  , qIOUtil_QBtoA(( qBool_t)(Var), qTrace_PublicBuffer   ), NULL, 0 )
        #define qDebug_Binary(Var)               _qtrace_func( "", NULL, #Var "=0b", qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer,  2), NULL, 0 )
        #define qDebug_Octal(Var)                _qtrace_func( "", NULL, #Var "=0" , qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer,  8), NULL, 0 )
        #define qDebug_Hexadecimal(Var)          _qtrace_func( "", NULL, #Var "=0x", qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer, 16), NULL, 0 )
        #define qDebug_Decimal(Var)              _qtrace_func( "", NULL, #Var "="  , qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer, 10), NULL, 0 )
        #define qDebug_Float(Var)                _qtrace_func( "", NULL, #Var "="  , qIOUtil_FtoA(( qFloat32_t )(Var), qTrace_PublicBuffer, 10), NULL, 0 )
        #define qDebug_FloatPrec(Var, Pc)        _qtrace_func( "", NULL, #Var "="  , qIOUtil_FtoA(( qFloat32_t  )(Var), qTrace_PublicBuffer, (Pc)), NULL, 0 )
        #define qDebug_UnsignedBinary(Var)       _qtrace_func( "", NULL, #Var "=0b", qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer,  2), NULL, 0 )
        #define qDebug_UnsignedOctal(Var)        _qtrace_func( "", NULL, #Var "=0" , qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer,  8), NULL, 0 )
        #define qDebug_UnsignedHexadecimal(Var)  _qtrace_func( "", NULL, #Var "=0x", qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer, 16), NULL, 0 )
        #define qDebug_UnsignedDecimal(Var)      _qtrace_func( "", NULL, #Var "="  , qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer, 10), NULL, 0 ) 
        

        #define qTrace_Message(Var)              _qtrace_func( _qAT(), _QTRACE_FUNC, "", (char*)(Var), NULL, 0)
        #define qTrace_String(Var)               _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "="  , (char*)(Var), NULL, 0)
        #define qTrace_Bool(Var)                 _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_BtoA(( qBool_t)(Var), qTrace_PublicBuffer    ), NULL, 0 )
        #define qTrace_qBool(Var)                _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_QBtoA(( qBool_t)(Var), qTrace_PublicBuffer   ), NULL, 0 )
        #define qTrace_Binary(Var)               _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "=0b", qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer,  2), NULL, 0 )
        #define qTrace_Octal(Var)                _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "=0" , qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer,  8), NULL, 0 )
        #define qTrace_Hexadecimal(Var)          _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "=0x", qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer, 16), NULL, 0 )
        #define qTrace_Decimal(Var)              _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer, 10), NULL, 0 )
        #define qTrace_Float(Var)                _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_FtoA(( qFloat32_t )(Var), qTrace_PublicBuffer, 10), NULL, 0 )
        #define qTrace_FloatPrec(Var, Pc)        _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_FtoA(( qFloat32_t )(Var), qTrace_PublicBuffer, (Pc)), NULL, 0 )
        #define qTrace_UnsignedBinary(Var)       _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "=0b", qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer,  2), NULL, 0 )
        #define qTrace_UnsignedOctal(Var)        _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "=0" , qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer,  8), NULL, 0 )
        #define qTrace_UnsignedHexadecimal(Var)  _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "=0x", qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer, 16), NULL, 0 )
        #define qTrace_UnsignedDecimal(Var)      _qtrace_func( _qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer, 10), NULL, 0 )
        /*! @endcond  */
        
        /**
        * @brief Output a trace message for the memory from the specified address (HEX output)
        * @note The Debug/Trace function must be previously defined with qTrace_Set_OutputFcn()
        * @param[in] Pointer The target memory address
        * @param[in] BlockSize Number of bytes
        * @return none.
        */          
        #define qTrace_Mem(Pointer, BlockSize)       qTrace_Memory( (Pointer), (BlockSize) )

        /**
        * @brief Same behavior of #qTrace_Mem
        * @param[in] Pointer The target memory address
        * @param[in] BlockSize Number of bytes
        * @return none.
        */           
        #define qTrace_Memory(Pointer, BlockSize)    _qtrace_func ( _qAT(), _QTRACE_FUNC, #Pointer "=", NULL, (Pointer), (BlockSize) )

        /**
        * @brief Output a debug message for the memory from the specified address (HEX output)
        * @note The Debug/Trace function must be previously defined with qTrace_Set_OutputFcn()
        * @param[in] Pointer The target memory address
        * @param[in] BlockSize Number of bytes
        * @return none.
        */              
        #define qDebug_Mem(Pointer, BlockSize)       qDebug_Memory( (Pointer), (BlockSize) ) 

        /**
        * @brief Same behavior of #qDebug_Mem
        * @note The Debug/Trace function must be previously defined with qTrace_Set_OutputFcn()
        * @param[in] Pointer The target memory address
        * @param[in] BlockSize Number of bytes
        * @return none.
        */          
        #define qDebug_Memory(Pointer, BlockSize)    _qtrace_func ( "", NULL, #Pointer "=", NULL, (Pointer), (BlockSize) )

        /**
        * @brief Output a trace message for the supplied variable (up to 32bit data) 
        * @note The Debug/Trace function must be previously defined with qTrace_Set_OutputFcn()
        * @param[in] Var The target variable
        * @param[in] DISP_TYPE_MODE Visualization mode. It must be one of the following parameters:
        * - Bool
        * - qBool
        * - Float
        * - Binary
        * - Octal
        * - Decimal
        * - Hexadecimal
        * - UnsignedBinary, 
        * - UnsignedOctal
        * - UnsignedDecimal
        * - UnsignedHexadecimal.
        * - String
        * - Message
        * @return none.
        */             
        #define qTrace_Var(Var, DISP_TYPE_MODE)      qTrace_##DISP_TYPE_MODE(Var)

        /**
        * @brief Same behavior of #qTrace_Var
        * @note The Debug/Trace function must be previously defined with qTrace_Set_OutputFcn()
        * @param[in] Var The target variable
        * @param[in] DISP_TYPE_MODE Visualization mode. 
        * @return none.
        */         
        #define qTrace_Variable(Var, DISP_TYPE_MODE) qTrace_##DISP_TYPE_MODE(Var)

        /**
        * @brief Output a debug message for the supplied variable (up to 32bit data) 
        * @note The Debug/Trace function must be previously defined with qTrace_Set_OutputFcn()
        * @param Var The target variable
        * @param DISP_TYPE_MODE Visualization mode. It must be one of the following parameters:
        * - Bool
        * - qBool
        * - Float
        * - Binary
        * - Octal
        * - Decimal
        * - Hexadecimal
        * - UnsignedBinary, 
        * - UnsignedOctal
        * - UnsignedDecimal
        * - UnsignedHexadecimal.
        * - String
        * - Message
        * @return none.
        */             
        #define qDebug_Var(Var, DISP_TYPE_MODE)      qDebug_##DISP_TYPE_MODE(Var)    

        /**
        * @brief Same behavior of #qDebug_Var
        * @note The Debug/Trace function must be previously defined with qTrace_Set_OutputFcn()
        * @param[in] Var The target variable
        * @param[in] DISP_TYPE_MODE Visualization mode.
        * @return none.
        */             
        #define qDebug_Variable(Var, DISP_TYPE_MODE) qDebug_##DISP_TYPE_MODE(Var)  
    #else
        #define qTrace()
        #define qTrace_Message(Var)
        #define qTrace_String(Var)
        #define qTrace_Var(Var, DISP_TYPE_MODE)
        #define qTrace_Variable(Var, DISP_TYPE_MODE)
        #define qTrace_Bool(Var) 
        #define qTrace_qBool(Var) 
        #define qTrace_Binary(Var)
        #define qTrace_Octal(Var)
        #define qTrace_Hexadecimal(Var)
        #define qTrace_Decimal(Var) 
        #define qTrace_Float(Var)
        #define qTrace_UnsignedBinary(Var)
        #define qTrace_UnsignedOctal(Var)
        #define qTrace_UnsignedHexadecimal(Var)
        #define qTrace_UnsignedDecimal(Var)
        #define qTrace_UnsignedDecimal(Var)
        #define qTrace_Memory(Pointer, BlockSize)
        #define qTrace_Mem(Pointer, BlockSize)
        #define qTrace_Variable(Var, DISP_TYPE_MODE)
        #define qTrace_Var(Var, DISP_TYPE_MODE)

        #define qDebug_Caller()               
        #define qDebug_Message(Var)
        #define qDebug_String(Var)
        #define qDebug_Bool(Var)
        #define qDebug_qBool(Var)
        #define qDebug_Binary(Var) 
        #define qDebug_Octal(Var)
        #define qDebug_Hexadecimal(Var)
        #define qDebug_Decimal(Var)
        #define qDebug_Float(Var)
        #define qDebug_FloatPrec(Var, Pc)
        #define qDebug_UnsignedBinary(Var)
        #define qDebug_UnsignedOctal(Var)
        #define qDebug_UnsignedHexadecimal(Var)
        #define qDebug_UnsignedDecimal(Var)
        #define qDebug_Memory(Pointer, BlockSize)
        #define qDebug_Mem(Pointer, BlockSize)   
        #define qDebug_Var(Var, DISP_TYPE_MODE)   
        #define qDebug_Variable(Var, DISP_TYPE_MODE)    
    #endif

    /** @}*/


    #ifdef __cplusplus
    }
    #endif

#endif
