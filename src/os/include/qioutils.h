/*This file is part of the QuarkTS distribution.*/
#ifndef QIOUTILS_H
    #define QIOUTILS_H

    #include "qtypes.h"
    #include "qconfig.h"
    #include "qedgecheck.h"
    
    #include <string.h>
    #include <ctype.h>

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef void (*qPutChar_t)(void* arg1, const char arg2);
    typedef void (*qPutString_t)(void* arg1, const char* arg2);
    typedef char (*qGetChar_t)(void* arg1);

    void qSwapBytes( void *data, const size_t n );
    qBool_t qCheckEndianness( void);
    void qOutputString( qPutChar_t fcn, void* pStorage, const char *s, qBool_t AIP );
    void qOutputRaw( qPutChar_t fcn, void* pStorage, void *data, const size_t n, qBool_t AIP );
    void qInputRaw( const qGetChar_t fcn, void* pStorage, void *data, const size_t n, qBool_t AIP );

    /*qPrintString(fcn, pStorage, s)
    
    This macro is a Wrapper method to write a string through fcn
    
    Parameters:

        - fcn : The basic output byte function
        - pStorage : The storage pointer passed to fcn
        - s: The string to be written
    */
    #define qPrintString(fcn, pStorage, s)          qOutputString((fcn), (void*)(pStorage), (const char *)(s), qFalse)
     
    #define qPrintRaw(fcn, pStorage, data, n)       qOutputRaw((fcn), (void*)(pStorage), (void*)(data), (n), qFalse) 

    /*Some utilities*/
    char* qU32toX( qUINT32_t value, char *str, qINT8_t n );
    qUINT32_t qXtoU32( const char *s );
    qFloat64_t qAtoF( const char *s );
    int qAtoI( const char *s );
    char* qUtoA( qUINT32_t num, char* str, qUINT8_t base );
    char* qItoA( qINT32_t num, char* str, qUINT8_t base );
    char* qBtoA( qBool_t num, char *str );
    char* qQBtoA (qBool_t num, char *str );
    qBool_t qIsInf( qFloat32_t f );
    qBool_t qIsNan( qFloat32_t f );
    char* qFtoA( qFloat32_t num, char *str, qUINT8_t precision );
    qUINT32_t qStringHash( const char* s, qUINT8_t mode );
    void qPrintXData( qPutChar_t fcn, void* pStorage, void *data, size_t n );
    
    #ifdef __cplusplus
    }
    #endif

#endif