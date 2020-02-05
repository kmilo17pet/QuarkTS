/*This file is part of the QuarkTS distribution.*/
#ifndef QTRACE_H
    #define QTRACE_H

    #include "qtypes.h"
    #include "qioutils.h"
   
    #ifdef __cplusplus
    extern "C" {
    #endif

    #ifndef _QTRACE_FUNC
        #if defined __cplusplus && defined __GNUC__ /* Use g++'s demangled names in C++.  */
            #if  __GNUC__ >= 2
                #define _QTRACE_FUNC __PRETTY_FUNCTION__
            #else
                #define _QTRACE_FUNC   __func__
            #endif       
        #elif __STDC_VERSION__ >= 199901L /* C99 requires the use of __func__.  */
            #define _QTRACE_FUNC __func__
        #else /* failed to detect __func__ support.  */
            #define _QTRACE_FUNC ((char *) 0)
        #endif
    # endif

    #define _qSTRINGIFY(x) #x
    #define _qTOSTRING(x) _qSTRINGIFY(x)

    #if ( Q_DEBUGTRACE_FULL == 1 )
        #ifndef _QTRACE_FUNC
            #if defined __cplusplus && defined __GNUC__ /* Use g++'s demangled names in C++.  */
                #define _QTRACE_FUNC __PRETTY_FUNCTION__
            #elif __STDC_VERSION__ >= 199901L /* C99 requires the use of __func__.  */
                #define _QTRACE_FUNC __func__
            #elif __GNUC__ >= 2 /* Older versions of gcc don't have __func__ but can use __FUNCTION__.  */
                #define _QTRACE_FUNC __FUNCTION__
            #else /* failed to detect __func__ support.  */
                #define _QTRACE_FUNC ((char *) 0)
            #  endif
        # endif

        #define _qAT() "[" __FILE__ ":" _qTOSTRING(__LINE__) "] " 
    #else
        #define _qAT()         ""
        #define _QTRACE_FUNC    ((char *) 0)
    #endif

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

    #if ( Q_TRACE_VARIABLES == 1 )
        extern char qTrace_PublicBuffer[Q_DEBUGTRACE_BUFSIZE];
        void _qtrace_func( const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, size_t BlockSize );
        void qTrace_Set_OutputFcn(qPutChar_t fcn);

        /*On-demand debug/trace macros*/
        #define qTrace()                         _qtrace_func (_qAT(), _QTRACE_FUNC, "", "", NULL, 0)      
        #define qDebug_Caller()                  _qtrace_func ("",_QTRACE_FUNC, "", "", NULL, 0)   

        #define qDebug_Message(Var)              _qtrace_func ("", NULL, "", (char*)(Var), NULL, 0)
        #define qDebug_String(Var)               _qtrace_func ("", NULL, #Var "="  , (char*)(Var), NULL, 0)
        #define qDebug_Bool(Var)                 _qtrace_func ("", NULL, #Var "="  , qIOUtil_BtoA(( qBool_t)(Var), qTrace_PublicBuffer    ), NULL, 0)
        #define qDebug_qBool(Var)                _qtrace_func ("", NULL, #Var "="  , qIOUtil_QBtoA(( qBool_t)(Var), qTrace_PublicBuffer   ), NULL, 0)
        #define qDebug_Binary(Var)               _qtrace_func ("", NULL, #Var "=0b", qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer,  2), NULL, 0)
        #define qDebug_Octal(Var)                _qtrace_func ("", NULL, #Var "=0" , qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer,  8), NULL, 0)
        #define qDebug_Hexadecimal(Var)          _qtrace_func ("", NULL, #Var "=0x", qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer, 16), NULL, 0)
        #define qDebug_Decimal(Var)              _qtrace_func ("", NULL, #Var "="  , qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer, 10), NULL, 0)
        #define qDebug_Float(Var)                _qtrace_func ("", NULL, #Var "="  , qIOUtil_FtoA(( qFloat32_t )(Var), qTrace_PublicBuffer, 10), NULL, 0)
        #define qDebug_FloatPrec(Var, Pc)        _qtrace_func ("", NULL, #Var "="  , qIOUtil_FtoA(( qFloat32_t  )(Var), qTrace_PublicBuffer, (Pc)), NULL, 0)
        #define qDebug_UnsignedBinary(Var)       _qtrace_func ("", NULL, #Var "=0b", qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer,  2), NULL, 0)
        #define qDebug_UnsignedOctal(Var)        _qtrace_func ("", NULL, #Var "=0" , qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer,  8), NULL, 0)
        #define qDebug_UnsignedHexadecimal(Var)  _qtrace_func ("", NULL, #Var "=0x", qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer, 16), NULL, 0)
        #define qDebug_UnsignedDecimal(Var)      _qtrace_func ("", NULL, #Var "="  , qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer, 10), NULL, 0)
        

        #define qTrace_Message(Var)              _qtrace_func (_qAT(), _QTRACE_FUNC, "", (char*)(Var), NULL, 0)
        #define qTrace_String(Var)               _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "="  , (char*)(Var), NULL, 0)
        #define qTrace_Bool(Var)                 _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_BtoA(( qBool_t)(Var), qTrace_PublicBuffer    ), NULL, 0)
        #define qTrace_qBool(Var)                _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_QBtoA(( qBool_t)(Var), qTrace_PublicBuffer   ), NULL, 0)
        #define qTrace_Binary(Var)               _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "=0b", qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer,  2), NULL, 0)
        #define qTrace_Octal(Var)                _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "=0" , qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer,  8), NULL, 0)
        #define qTrace_Hexadecimal(Var)          _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "=0x", qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer, 16), NULL, 0)
        #define qTrace_Decimal(Var)              _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_ItoA(( qINT32_t)(Var), qTrace_PublicBuffer, 10), NULL, 0)
        #define qTrace_Float(Var)                _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_FtoA(( qFloat32_t )(Var), qTrace_PublicBuffer, 10), NULL, 0)
        #define qTrace_FloatPrec(Var, Pc)        _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_FtoA(( qFloat32_t )(Var), qTrace_PublicBuffer, (Pc)), NULL, 0)
        #define qTrace_UnsignedBinary(Var)       _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "=0b", qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer,  2), NULL, 0)
        #define qTrace_UnsignedOctal(Var)        _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "=0" , qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer,  8), NULL, 0)
        #define qTrace_UnsignedHexadecimal(Var)  _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "=0x", qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer, 16), NULL, 0)
        #define qTrace_UnsignedDecimal(Var)      _qtrace_func (_qAT(), _QTRACE_FUNC, #Var "="  , qIOUtil_UtoA((qUINT32_t)(Var), qTrace_PublicBuffer, 10), NULL, 0)
        /*qTrace_Mem/qTrace_Memory(Pointer, BlockSize)

        Trace memory from the specified address (HEX output)

        Parameters:

            - Pointer : The target memory address
            - Size: Number of bytes

        Note: the Debug/Trace function must be previously defined with qSetDebugFcn
        */
        #define qTrace_Memory(Pointer, BlockSize)    _qtrace_func (_qAT(), _QTRACE_FUNC, _qTOSTRING(Var) "=", NULL, (Pointer), (BlockSize))
        #define qTrace_Mem(Pointer, BlockSize)       qTrace_Memory((Pointer), (BlockSize))
        #define qDebug_Memory(Pointer, BlockSize)    _qtrace_func ("", NULL, _qTOSTRING(Var) "=", NULL, (Pointer), (BlockSize))
        #define qDebug_Mem(Pointer, BlockSize)       qDebug_Memory((Pointer), (BlockSize)) 
        /*qTrace_Var/qTrace_Variable(Pointer, DISP_TYPE_MODE)
        Trace a variable (up to 32bit data) 

        Parameters:

            - Var : The target variable
            - DISP_TYPE_MODE: Visualization mode. It must be one of the following parameters:
                            Bool, Float, Binary, Octal, Decimal, Hexadecimal, UnsignedBinary, 
                            UnsignedOctal, UnsignedDecimal, UnsignedHexadecimal.
        
        Note: the Debug/Trace function must be previously defined with qSetDebugFcn
        */
        #define qTrace_Variable(Var, DISP_TYPE_MODE) qTrace_##DISP_TYPE_MODE(Var)
        #define qTrace_Var(Var, DISP_TYPE_MODE)      qTrace_##DISP_TYPE_MODE(Var)
        #define qDebug_Var(Var, DISP_TYPE_MODE)      qDebug_##DISP_TYPE_MODE(Var)    
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

    #ifdef __cplusplus
    }
    #endif

#endif
