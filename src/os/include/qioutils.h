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

    #define Q_IOUTIL_MAX_STRLEN      ( (size_t)512 )

    typedef void (*qPutChar_t)(void* arg1, const char arg2);
    typedef void (*qPutString_t)(void* arg1, const char* arg2);
    typedef char (*qGetChar_t)(void* arg1);

    size_t qIOUtil_StrLen( const char* str, size_t maxlen);
    size_t qIOUtil_StrlCpy( char * dst, const char * src, size_t maxlen );
    void qIOUtil_SwapBytes( void *data, const size_t n );
    qBool_t qIOUtil_CheckEndianness( void);
    void qIOUtil_OutputString( qPutChar_t fcn, void* pStorage, const char *s, qBool_t AIP );
    void qIOUtil_PrintXData( qPutChar_t fcn, void* pStorage, void *data, size_t n );
    void qIOUtil_OutputRaw( qPutChar_t fcn, void* pStorage, void *data, const size_t n, qBool_t AIP );
    void qIOUtil_InputRaw( const qGetChar_t fcn, void* pStorage, void *data, const size_t n, qBool_t AIP );
      
    /*qIOUtil_PrintString(fcn, pStorage, s)
    
    This macro is a Wrapper method to write a string through fcn
    
    Parameters:

        - fcn : The basic output byte function
        - pStorage : The storage pointer passed to fcn
        - s: The string to be written
    */
    #define qIOUtil_PrintString(fcn, pStorage, s)          qIOUtil_OutputString((fcn), (void*)(pStorage), (const char *)(s), qFalse)
    #define qIOUtil_PrintRaw(fcn, pStorage, data, n)       qIOUtil_OutputRaw((fcn), (void*)(pStorage), (void*)(data), (n), qFalse) 

    /*Some utilities*/
    char* qIOUtil_U32toX( qUINT32_t value, char *str, qINT8_t n );
    qUINT32_t qIOUtil_XtoU32( const char *s );
    qFloat64_t qIOUtil_AtoF( const char *s );
    char* qIOUtil_FtoA( qFloat32_t num, char *str, qUINT8_t precision );
    int qIOUtil_AtoI( const char *s );
    char* qIOUtil_UtoA( qUINT32_t num, char* str, qUINT8_t base );
    char* qIOUtil_ItoA( qINT32_t num, char* str, qUINT8_t base );
    char* qIOUtil_BtoA( qBool_t num, char *str );
    char* qIOUtil_QBtoA (qBool_t num, char *str );
    qBool_t qIOUtil_IsInf( qFloat32_t f );
    qBool_t qIOUtil_IsNan( qFloat32_t f );

    
    #ifdef __cplusplus
    }
    #endif

#endif
