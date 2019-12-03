/*This file is part of the QuarkTS distribution.*/
#ifndef QTRACE_H
    #define QTRACE_H

    #include "qtypes.h"
    #include "qioutils.h"
   
    #ifdef __cplusplus
    extern "C" {
    #endif

    #ifndef __QTRACE_FUNC
        #if defined __cplusplus && defined __GNUC__ /* Use g++'s demangled names in C++.  */
            #if  __GNUC__ >= 2
                #define __QTRACE_FUNC __PRETTY_FUNCTION__
            #else
                #define __QTRACE_FUNC   __func__
            #endif       
        #elif __STDC_VERSION__ >= 199901L /* C99 requires the use of __func__.  */
            #define __QTRACE_FUNC __func__
        #else /* failed to detect __func__ support.  */
            #define __QTRACE_FUNC ((char *) 0)
        #endif
    # endif

    #define __qSTRINGIFY(x) #x
    #define __qTOSTRING(x) __qSTRINGIFY(x)

    #if ( Q_DEBUGTRACE_FULL == 1 )
        #ifndef __QTRACE_FUNC
            #if defined __cplusplus && defined __GNUC__ /* Use g++'s demangled names in C++.  */
                #define __QTRACE_FUNC __PRETTY_FUNCTION__
            #elif __STDC_VERSION__ >= 199901L /* C99 requires the use of __func__.  */
                #define __QTRACE_FUNC __func__
            #elif __GNUC__ >= 2 /* Older versions of gcc don't have __func__ but can use __FUNCTION__.  */
                #define __QTRACE_FUNC __FUNCTION__
            #else /* failed to detect __func__ support.  */
                #define __QTRACE_FUNC ((char *) 0)
            #  endif
        # endif

        #define __qAT() "[" __FILE__ ":" __qTOSTRING(__LINE__) "] " 
    #else
        #define __qAT()         ""
        #define __QTRACE_FUNC    ((char *) 0)
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
        extern char qDebugTrace_Buffer[Q_DEBUGTRACE_BUFSIZE];
        void __qtrace_func( const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, size_t BlockSize );
        void qSetDebugFcn(qPutChar_t fcn);

        /*On-demand debug/trace macros*/
        #define qTrace()                        __qtrace_func (__qAT(), __QTRACE_FUNC, "", "", NULL, 0)      
        #define qDebugCaller()                  __qtrace_func ("",__QTRACE_FUNC, "", "", NULL, 0)   

        #define qDebugMessage(Var)              __qtrace_func ("", NULL, "", (char*)(Var), NULL, 0)
        #define qDebugString(Var)               __qtrace_func ("", NULL, #Var "="  , (char*)(Var), NULL, 0)
        #define qDebugBool(Var)                 __qtrace_func ("", NULL, #Var "="  , qBtoA(( qBool_t)(Var), qDebugTrace_Buffer    ), NULL, 0)
        #define qDebugqBool(Var)                __qtrace_func ("", NULL, #Var "="  , qQBtoA(( qBool_t)(Var), qDebugTrace_Buffer   ), NULL, 0)
        #define qDebugBinary(Var)               __qtrace_func ("", NULL, #Var "=0b", qItoA(( qINT32_t)(Var), qDebugTrace_Buffer,  2), NULL, 0)
        #define qDebugOctal(Var)                __qtrace_func ("", NULL, #Var "=0" , qItoA(( qINT32_t)(Var), qDebugTrace_Buffer,  8), NULL, 0)
        #define qDebugHexadecimal(Var)          __qtrace_func ("", NULL, #Var "=0x", qItoA(( qINT32_t)(Var), qDebugTrace_Buffer, 16), NULL, 0)
        #define qDebugDecimal(Var)              __qtrace_func ("", NULL, #Var "="  , qItoA(( qINT32_t)(Var), qDebugTrace_Buffer, 10), NULL, 0)
        #define qDebugFloat(Var)                __qtrace_func ("", NULL, #Var "="  , qFtoA(( qFloat32_t )(Var), qDebugTrace_Buffer, 10), NULL, 0)
        #define qDebugFloatPrec(Var, Pc)        __qtrace_func ("", NULL, #Var "="  , qFtoA(( qFloat32_t  )(Var), qDebugTrace_Buffer, (Pc)), NULL, 0)
        #define qDebugUnsignedBinary(Var)       __qtrace_func ("", NULL, #Var "=0b", qUtoA((qUINT32_t)(Var), qDebugTrace_Buffer,  2), NULL, 0)
        #define qDebugUnsignedOctal(Var)        __qtrace_func ("", NULL, #Var "=0" , qUtoA((qUINT32_t)(Var), qDebugTrace_Buffer,  8), NULL, 0)
        #define qDebugUnsignedHexadecimal(Var)  __qtrace_func ("", NULL, #Var "=0x", qUtoA((qUINT32_t)(Var), qDebugTrace_Buffer, 16), NULL, 0)
        #define qDebugUnsignedDecimal(Var)      __qtrace_func ("", NULL, #Var "="  , qUtoA((qUINT32_t)(Var), qDebugTrace_Buffer, 10), NULL, 0)
        

        #define qTraceMessage(Var)              __qtrace_func (__qAT(), __QTRACE_FUNC, "", (char*)(Var), NULL, 0)
        #define qTraceString(Var)               __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , (char*)(Var), NULL, 0)
        #define qTraceBool(Var)                 __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qBtoA(( qBool_t)(Var), qDebugTrace_Buffer    ), NULL, 0)
        #define qTraceqBool(Var)                __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qQBtoA(( qBool_t)(Var), qDebugTrace_Buffer   ), NULL, 0)
        #define qTraceBinary(Var)               __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0b", qItoA(( qINT32_t)(Var), qDebugTrace_Buffer,  2), NULL, 0)
        #define qTraceOctal(Var)                __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0" , qItoA(( qINT32_t)(Var), qDebugTrace_Buffer,  8), NULL, 0)
        #define qTraceHexadecimal(Var)          __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0x", qItoA(( qINT32_t)(Var), qDebugTrace_Buffer, 16), NULL, 0)
        #define qTraceDecimal(Var)              __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qItoA(( qINT32_t)(Var), qDebugTrace_Buffer, 10), NULL, 0)
        #define qTraceFloat(Var)                __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qFtoA(( qFloat32_t )(Var), qDebugTrace_Buffer, 10), NULL, 0)
        #define qTraceFloatPrec(Var, Pc)        __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qFtoA(( qFloat32_t )(Var), qDebugTrace_Buffer, (Pc)), NULL, 0)
        #define qTraceUnsignedBinary(Var)       __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0b", qUtoA((qUINT32_t)(Var), qDebugTrace_Buffer,  2), NULL, 0)
        #define qTraceUnsignedOctal(Var)        __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0" , qUtoA((qUINT32_t)(Var), qDebugTrace_Buffer,  8), NULL, 0)
        #define qTraceUnsignedHexadecimal(Var)  __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0x", qUtoA((qUINT32_t)(Var), qDebugTrace_Buffer, 16), NULL, 0)
        #define qTraceUnsignedDecimal(Var)      __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qUtoA((qUINT32_t)(Var), qDebugTrace_Buffer, 10), NULL, 0)
        /*qTraceMem/qTraceMemory(Pointer, BlockSize)

        Trace memory from the specified address (HEX output)

        Parameters:

            - Pointer : The target memory address
            - Size: Number of bytes

        Note: the Debug/Trace function must be previously defined with qSetDebugFcn
        */
        #define qTraceMemory(Pointer, BlockSize)    __qtrace_func (__qAT(), __QTRACE_FUNC, __qTOSTRING(Var) "=", NULL, (Pointer), (BlockSize))
        #define qTraceMem(Pointer, BlockSize)       qTraceMemory((Pointer), (BlockSize))
        #define qDebugMemory(Pointer, BlockSize)    __qtrace_func ("", NULL, __qTOSTRING(Var) "=", NULL, (Pointer), (BlockSize))
        #define qDebugMem(Pointer, BlockSize)       qDebugMemory((Pointer), (BlockSize)) 
        /*qTraceVar/qTraceVariable(Pointer, DISP_TYPE_MODE)
        Trace a variable (up to 32bit data) 

        Parameters:

            - Var : The target variable
            - DISP_TYPE_MODE: Visualization mode. It must be one of the following parameters:
                            Bool, Float, Binary, Octal, Decimal, Hexadecimal, UnsignedBinary, 
                            UnsignedOctal, UnsignedDecimal, UnsignedHexadecimal.
        
        Note: the Debug/Trace function must be previously defined with qSetDebugFcn
        */
        #define qTraceVariable(Var, DISP_TYPE_MODE) qTrace##DISP_TYPE_MODE(Var)
        #define qTraceVar(Var, DISP_TYPE_MODE)      qTrace##DISP_TYPE_MODE(Var)
        #define qDebugVar(Var, DISP_TYPE_MODE)      qDebug##DISP_TYPE_MODE(Var)    
        #define qDebugVariable(Var, DISP_TYPE_MODE) qDebug##DISP_TYPE_MODE(Var)  
    #else
        #define qTrace()
        #define qTraceMessage(Var)
        #define qTraceString(Var)
        #define qTraceVar(Var, DISP_TYPE_MODE)
        #define qTraceVariable(Var, DISP_TYPE_MODE)
        #define qTraceBool(Var) 
        #define qTraceqBool(Var) 
        #define qTraceBinary(Var)
        #define qTraceOctal(Var)
        #define qTraceHexadecimal(Var)
        #define qTraceDecimal(Var) 
        #define qTraceFloat(Var)
        #define qTraceUnsignedBinary(Var)
        #define qTraceUnsignedOctal(Var)
        #define qTraceUnsignedHexadecimal(Var)
        #define qTraceUnsignedDecimal(Var)
        #define qTraceUnsignedDecimal(Var)
        #define qTraceMemory(Pointer, BlockSize)
        #define qTraceMem(Pointer, BlockSize)
        #define qTraceVariable(Var, DISP_TYPE_MODE)
        #define qTraceVar(Var, DISP_TYPE_MODE)

        #define qDebugCaller()               
        #define qDebugMessage(Var)
        #define qDebugString(Var)
        #define qDebugBool(Var)
        #define qDebugqBool(Var)
        #define qDebugBinary(Var) 
        #define qDebugOctal(Var)
        #define qDebugHexadecimal(Var)
        #define qDebugDecimal(Var)
        #define qDebugFloat(Var)
        #define qDebugFloatPrec(Var, Pc)
        #define qDebugUnsignedBinary(Var)
        #define qDebugUnsignedOctal(Var)
        #define qDebugUnsignedHexadecimal(Var)
        #define qDebugUnsignedDecimal(Var)
        #define qDebugMemory(Pointer, BlockSize)
        #define qDebugMem(Pointer, BlockSize)   
        #define qDebugVar(Var, DISP_TYPE_MODE)   
        #define qDebugVariable(Var, DISP_TYPE_MODE)    
    #endif

    #ifdef __cplusplus
    }
    #endif

#endif