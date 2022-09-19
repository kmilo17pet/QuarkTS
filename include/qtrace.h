/*!
* @file qtrace.h
* @author J. Camilo Gomez C.
* @version 1.49
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
                #define _QFCN    __PRETTY_FUNCTION__
            #else
                #define _QFCN    __func__
            #endif
        #elif defined(__GNUC__) || (defined(__MWERKS__) && (__MWERKS__ >= 0x3000)) || (defined(__ICC) && (__ICC >= 600)) || defined(__ghs__)
            #define _QFCN       __PRETTY_FUNCTION__
        #elif defined(__DMC__) && (__DMC__ >= 0x810)
            #define _QFCN       __PRETTY_FUNCTION__
        #elif defined(__FUNCSIG__)
            #define _QFCN       __FUNCSIG__
        #elif (defined(__INTEL_COMPILER) && (__INTEL_COMPILER >= 600)) || (defined(__IBMCPP__) && (__IBMCPP__ >= 500))
            #define _QFCN       __FUNCTION__
        #elif defined(__BORLANDC__) && (__BORLANDC__ >= 0x550)
            #define _QFCN       __FUNC__
        #elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901)
            #define _QFCN       __func__
        #elif defined(__cplusplus) && (__cplusplus >= 201103)
            #define _QFCN    __func__
        #else /* failed to detect __func__ support.  */
            #define _QFCN       ( (char *)0 )
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
        #if ( Q_TRACE_KERNEL_AND_MODULES == 1 )
            void _qTrace_krn( const char *msg,
                              const void *id,
                              const void *obj );
            #define _QTRACE_KERNEL( msg, id, obj )                          \
            _qTrace_krn( (char*)(msg), (id), (obj) );                       \

        #else
            #define _QTRACE_KERNEL( msg, id, obj )
        #endif

        extern char qTrace_PublicBuffer[ Q_DEBUGTRACE_BUFSIZE ];
        void _qTrace_dgb( const char *loc,
                          const char* fcn,
                          const char *vName,
                          const char* vValue,
                          void* ptr,
                          const size_t blockSize );
        /*! @endcond  */

        /**
        * @brief This API set the output method for debug/trace messages.
        * @param[in] fcn The basic output byte function.
        * @return none.
        */
        void qTrace_Set_OutputFcn( qPutChar_t fcn );

        /*On-demand debug/trace macros*/
        /**
        * @brief Output a trace message,
        * @note The Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn()
        * @return none.
        */
        #define qTrace()                                                    \
        _qTrace_dgb( _qAT(), _QFCN, "", "", NULL, 0 )                       \

        /**
        * @brief Output a debug message,
        * @note the Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn
        * @return none.
        */
        #define qDebug_Caller()                                             \
        _qTrace_dgb( "", _QFCN, "", "", NULL, 0 )                           \


        /*! @cond  */
        #define qDebug_Message( v )                                         \
        _qTrace_dgb( "", NULL, "", (char*)(v), NULL, 0 )                    \


        #define qDebug_String( v )                                          \
        _qTrace_dgb( "", NULL, #v "=" , (char*)(v), NULL, 0 )               \


        #define qDebug_Bool( v )                                            \
        qIOUtil_BtoA( (qBool_t)(v), qTrace_PublicBuffer );                  \
        _qTrace_dgb( "", NULL, #v "=", qTrace_PublicBuffer, NULL, 0 )       \


        #define qDebug_qBool( v )                                           \
        qIOUtil_QBtoA( (qBool_t)(v), qTrace_PublicBuffer );                 \
        _qTrace_dgb( "", NULL, #v "=", qTrace_PublicBuffer, NULL, 0 )       \

        #define qDebug_Binary( v )                                          \
        qIOUtil_ItoA( (qINT32_t)(v), qTrace_PublicBuffer, 2 );              \
        _qTrace_dgb( "", NULL, #v "=0b", qTrace_PublicBuffer, NULL, 0 )     \


        #define qDebug_Octal( v )                                           \
        qIOUtil_ItoA( (qINT32_t)(v), qTrace_PublicBuffer, 8 );              \
        _qTrace_dgb( "", NULL, #v "=0", qTrace_PublicBuffer, NULL, 0 )      \


        #define qDebug_Hexadecimal( v )                                     \
        qIOUtil_ItoA( (qINT32_t)(v), qTrace_PublicBuffer, 16 );             \
        _qTrace_dgb( "", NULL, #v "=0x", qTrace_PublicBuffer, NULL, 0 )     \


        #define qDebug_Decimal( v )                                         \
        qIOUtil_ItoA( (qINT32_t)(v), qTrace_PublicBuffer, 10 );             \
        _qTrace_dgb( "", NULL, #v "=", qTrace_PublicBuffer, NULL, 0 )       \


        #define qDebug_Float( v )                                           \
        qIOUtil_FtoA( (qFloat32_t)(v), qTrace_PublicBuffer, 10 );           \
        _qTrace_dgb( "", NULL, #v "=", qTrace_PublicBuffer, NULL, 0 )       \


        #define qDebug_FloatPrec( v , prec )                                \
        qIOUtil_FtoA( (qFloat32_t)(v), qTrace_PublicBuffer, (prec) );       \
        _qTrace_dgb( "", NULL, #v "=", qTrace_PublicBuffer, NULL, 0 )       \


        #define qDebug_UnsignedBinary( v )                                  \
        qIOUtil_UtoA( (qUINT32_t)(v), qTrace_PublicBuffer, 2 );             \
        _qTrace_dgb( "", NULL, #v "=0b", qTrace_PublicBuffer, NULL, 0 )     \


        #define qDebug_UnsignedOctal( v )                                   \
        qIOUtil_UtoA( (qUINT32_t)(v), qTrace_PublicBuffer, 8 );             \
        _qTrace_dgb( "", NULL, #v "=0", qTrace_PublicBuffer, NULL, 0 )      \


        #define qDebug_UnsignedHexadecimal( v )                             \
        qIOUtil_UtoA( (qUINT32_t)(v), qTrace_PublicBuffer, 16 );            \
        _qTrace_dgb( "", NULL, #v "=0x", qTrace_PublicBuffer, NULL, 0 )     \


        #define qDebug_UnsignedDecimal( v )                                 \
        qIOUtil_UtoA( (qUINT32_t)(v), qTrace_PublicBuffer, 10 );            \
        _qTrace_dgb( "", NULL, #v "=", , NULL, 0 )                          \


        #define qTrace_Message( v )                                         \
        _qTrace_dgb( _qAT(), _QFCN, "", (char*)(v), NULL, 0 )               \


        #define qTrace_String( v )                                          \
        _qTrace_dgb( _qAT(), _QFCN, #v "=" , (char*)(v), NULL, 0 )          \


        #define qTrace_Bool( v )                                            \
        qIOUtil_BtoA( (qBool_t)(v), qTrace_PublicBuffer );                  \
        _qTrace_dgb( _qAT(), _QFCN, #v "=", qTrace_PublicBuffer, NULL, 0 )  \


        #define qTrace_qBool( v )                                           \
        qIOUtil_QBtoA( (qBool_t)(v), qTrace_PublicBuffer );                 \
        _qTrace_dgb( _qAT(), _QFCN, #v "=", qTrace_PublicBuffer, NULL, 0 )  \


        #define qTrace_Binary( v )                                          \
        qIOUtil_ItoA( (qINT32_t)(v), qTrace_PublicBuffer, 2 );              \
        _qTrace_dgb( _qAT(), _QFCN, #v "=0b", qTrace_PublicBuffer, NULL, 0 )\


        #define qTrace_Octal( v )                                           \
        qIOUtil_ItoA( (qINT32_t)(v), qTrace_PublicBuffer, 8 );              \
        _qTrace_dgb( _qAT(), _QFCN, #v "=0", qTrace_PublicBuffer, NULL, 0 ) \


        #define qTrace_Hexadecimal( v )                                     \
        qIOUtil_ItoA( (qINT32_t)(v), qTrace_PublicBuffer, 16 );             \
        _qTrace_dgb( _qAT(), _QFCN, #v "=0x", qTrace_PublicBuffer, NULL, 0 )\


        #define qTrace_Decimal( v )                                         \
        qIOUtil_ItoA( (qINT32_t)(v), qTrace_PublicBuffer, 10 );             \
        _qTrace_dgb( _qAT(), _QFCN, #v "=", qTrace_PublicBuffer, NULL, 0 )  \


        #define qTrace_Float( v )                                           \
        qIOUtil_FtoA( (qFloat32_t)(v), qTrace_PublicBuffer, 10 );           \
        _qTrace_dgb( _qAT(), _QFCN, #v "=", qTrace_PublicBuffer, NULL, 0 )  \


        #define qTrace_FloatPrec( v , prec )                                \
        qIOUtil_FtoA( (qFloat32_t)(v), qTrace_PublicBuffer, (prec) );       \
        _qTrace_dgb( _qAT(), _QFCN, #v "=", qTrace_PublicBuffer, NULL, 0 )  \


        #define qTrace_UnsignedBinary( v )                                  \
        qIOUtil_UtoA( (qUINT32_t)(v), qTrace_PublicBuffer, 2 );             \
        _qTrace_dgb( _qAT(), _QFCN, #v "=0b", qTrace_PublicBuffer, NULL, 0 )\


        #define qTrace_UnsignedOctal( v )                                   \
        qIOUtil_UtoA( (qUINT32_t)(v), qTrace_PublicBuffer, 8 );             \
        _qTrace_dgb( _qAT(), _QFCN, #v "=0", qTrace_PublicBuffer, NULL, 0 ) \


        #define qTrace_UnsignedHexadecimal( v )                             \
        qIOUtil_UtoA( (qUINT32_t)(v), qTrace_PublicBuffer, 16 );            \
        _qTrace_dgb( _qAT(), _QFCN, #v "=0x", qTrace_PublicBuffer, NULL, 0 )\


        #define qTrace_UnsignedDecimal( v )                                 \
        qIOUtil_UtoA( (qUINT32_t)(v), qTrace_PublicBuffer, 10 );            \
        _qTrace_dgb( _qAT(), _QFCN, #v "=", qTrace_PublicBuffer, NULL, 0 )  \


        /*! @endcond  */

        /**
        * @brief Output a trace message for the memory from the specified
        * address (HEX output)
        * @note The Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn()
        * @param[in] pMem The target memory address
        * @param[in] bSize Number of bytes
        * @return none.
        */
        #define qTrace_Mem( pMem, bSize )       qTrace_Memory( (pMem), (bSize) )

        /**
        * @brief Same behavior of #qTrace_Mem
        * @param[in] pMem The target memory address
        * @param[in] bSize Number of bytes
        * @return none.
        */
        #define qTrace_Memory(pMem, bSize )                                 \
        _qTrace_dgb( _qAT(),                                                \
                     _QFCN,                                                 \
                     #pMem "=",                                             \
                     NULL,                                                  \
                     (pMem),                                                \
                     (bSize) )                                              \

        /**
        * @brief Output a debug message for the memory from the specified
        * address (HEX output)
        * @note The Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn()
        * @param[in] pMem The target memory address
        * @param[in] bSize Number of bytes
        * @return none.
        */
        #define qDebug_Mem( pMem, bSize )       qDebug_Memory( (pMem), (bSize) )

        /**
        * @brief Same behavior of #qDebug_Mem
        * @note The Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn()
        * @param[in] pMem The target memory address
        * @param[in] bSize Number of bytes
        * @return none.
        */
        #define qDebug_Memory( pMem, bSize )                                \
        _qTrace_dgb( "", NULL, #pMem "=", NULL, (pMem), (bSize) )           \

        /**
        * @brief Output a trace message for the supplied variable (up to 32bit
        * data)
        * @note The Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn()
        * @param[in] v The target variable
        * @param[in] mode Visualization mode. It must be one of the following
        * parameters:
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
        #define qTrace_Var( v, mode )           qTrace_##mode( v )

        /**
        * @brief Same behavior of #qTrace_Var
        * @note The Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn()
        * @param[in] v The target variable
        * @param[in] mode Visualization mode.
        * @return none.
        */
        #define qTrace_Variable( v, mode )      qTrace_##mode( v )

        /**
        * @brief Output a debug message for the supplied variable (up to 32bit data)
        * @note The Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn()
        * @param v The target variable
        * @param mode Visualization mode. It must be one of the following
        * parameters:
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
        #define qDebug_Var( v, mode )           qDebug_##mode( v )

        /**
        * @brief Same behavior of #qDebug_Var
        * @note The Debug/Trace function must be previously defined with
        * qTrace_Set_OutputFcn()
        * @param[in] v The target variable
        * @param[in] mode Visualization mode.
        * @return none.
        */
        #define qDebug_Variable( v, mode )      qDebug_##mode( v )
    #else
        #define qTrace_Set_OutputFcn( fcn )
        #define _QTRACE_KERNEL( msg, id, obj )
        #define qTrace()
        #define qTrace_Message( v )
        #define qTrace_String( v )
        #define qTrace_Var( v, mode )
        #define qTrace_Variable( v, mode )
        #define qTrace_Bool( v )
        #define qTrace_qBool( v )
        #define qTrace_Binary( v )
        #define qTrace_Octal( v )
        #define qTrace_Hexadecimal( v )
        #define qTrace_Decimal( v )
        #define qTrace_Float( v )
        #define qDebug_FloatPrec( v, prec )
        #define qTrace_UnsignedBinary( v )
        #define qTrace_UnsignedOctal( v )
        #define qTrace_UnsignedHexadecimal( v )
        #define qTrace_UnsignedDecimal( v )
        #define qTrace_UnsignedDecimal( v )
        #define qTrace_Memory( pMem, bSize )
        #define qTrace_Mem( pMem, bSize )
        #define qTrace_Variable( v , mode )
        #define qTrace_Var( v , mode )

        #define qDebug_Caller()
        #define qDebug_Message( v )
        #define qDebug_String( v )
        #define qDebug_Bool( v )
        #define qDebug_qBool( v )
        #define qDebug_Binary( v )
        #define qDebug_Octal( v )
        #define qDebug_Hexadecimal( v )
        #define qDebug_Decimal( v )
        #define qDebug_Float( v )
        #define qDebug_FloatPrec( v , prec )
        #define qDebug_UnsignedBinary( v )
        #define qDebug_UnsignedOctal( v )
        #define qDebug_UnsignedHexadecimal( v )
        #define qDebug_UnsignedDecimal( v )
        #define qDebug_Memory( pMem, bSize )
        #define qDebug_Mem( pMem, bSize )
        #define qDebug_Var( v , mode )
        #define qDebug_Variable( v , mode )
    #endif

    /** @}*/


    #ifdef __cplusplus
    }
    #endif

#endif
