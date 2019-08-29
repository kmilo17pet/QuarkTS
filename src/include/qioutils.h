/*This file is part of the QuarkTS distribution.*/
#ifndef QIOUTILS_H
    #define QIOUTILS_H

    #include "qtypes.h"
    #include "qconfig.h"
    #include "qedgecheck.h"
    
    #include <string.h>
    #include <ctype.h>

    typedef void (*qPutChar_t)(void* arg1, const char arg2);
    typedef void (*qPutString_t)(void* arg1, const char* arg2);
    typedef char (*qGetChar_t)(void* arg1);

    void qSwapBytes( void *data, const qSize_t n );
    qBool_t qCheckEndianness( void);
    void qOutputString( qPutChar_t fcn, void* pStorage, const char *s, qBool_t AIP );
    void qOutputRaw( qPutChar_t fcn, void* pStorage, void *data, const qSize_t n, qBool_t AIP );
    void qInputRaw( const qGetChar_t fcn, void* pStorage, void *data, const qSize_t n, qBool_t AIP );

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
    char* qU32toX( uint32_t value, char *str, int8_t n );
    uint32_t qXtoU32( const char *s );
    double qAtoF( const char *s );
    int qAtoI( const char *s );
    char* qUtoA( uint32_t num, char* str, uint8_t base );
    char* qItoA( int32_t num, char* str, uint8_t base );
    char* qBtoA( qBool_t num, char *str );
    char* qQBtoA (qBool_t num, char *str );
    qBool_t qIsInf( float f );
    qBool_t qIsNan( float f );
    char* qFtoA( float num, char *str, uint8_t precision );
    uint32_t qStringHash( const char* s, uint8_t mode );
    void qPrintXData( qPutChar_t fcn, void* pStorage, void *data, qSize_t n );

#endif