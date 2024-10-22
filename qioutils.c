/*!
 * @file qioutils.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qioutils.h"
#include "qflm.h"


static size_t qIOUtil_xBase_U32toA( qUINT32_t num,
                                    char* str,
                                    qUINT8_t base );
static char qIOUtil_NibbleToX( qUINT8_t value );
static const char * qIOUtil_DiscardWhitespaces( const char *s,
                                                size_t maxlen );
static const char * qIOUtil_CheckStrSign( const char *s,
                                          int *sgn );
static qBool_t qIOUtil_IOOperation( const qIOFcn_t fcn,
                                    void* pStorage,
                                    void *pData,
                                    const size_t n,
                                    qBool_t aip,
                                    qBool_t operation );
static qUINT8_t qIOUtil_cXtoU8( const char c );

/*============================================================================*/
static const char * qIOUtil_DiscardWhitespaces( const char *s,
                                                size_t maxlen )
{
    /*cstat -MISRAC2012-Rule-13.5 -MISRAC2012-Dir-4.11_h*/
    /*isspace is known to not have side effects*/
    while ( ( maxlen > (size_t)0U ) && ( 0 != isspace( (int)*s ) ) ) {
    /*cstat +MISRAC2012-Rule-13.5 +MISRAC2012-Dir-4.11_h*/
        s++; /*discard whitespaces*/ /*MISRAC2004-17.4_a deviation allowed*/
        --maxlen;
    }

    return s;
}
/*============================================================================*/
static const char * qIOUtil_CheckStrSign( const char *s,
                                          int *sgn )
{
    if ( '-' == *s ) { /*if negative found*/
        *sgn = -1; /*set the sign*/
        ++s; /*move to next*/ /*MISRAC2004-17.4_a deviation allowed*/
    }
    else if ( '+' == *s ) {
        /*plus sign ignored, move to next*/
        ++s; /*MISRAC2004-17.4_a deviation allowed*/
    }
    else {
        /*nothing to do*/
    }

    return s;
}
/*============================================================================*/
char* qIOUtil_StrChr( const char *s,
                      int c,
                      size_t maxlen )
{
    /*cstat -MISRAC2012-Rule-8.13*/
    char *retValue = NULL;
    /*cstat +MISRAC2012-Rule-8.13*/
    do {
        if ( (int)(*s) == c ) {
            /*cstat -MISRAC2012-Rule-11.8*/
            /*cppcheck-suppress cert-EXP05-C */
            retValue = (char*)s; /*MISRAC2012-Rule-11.8 deviation allowed*/
            /*cstat +MISRAC2012-Rule-11.8*/
            break;
        }
        --maxlen;
    } while ( ( '\0' != ( *s++ ) ) && ( maxlen > 0U ) );

    return retValue;
}
/*============================================================================*/
size_t qIOUtil_StrLen( const char* s,
                       size_t maxlen )
{
    size_t count;

    if ( ( NULL == s ) || ( (size_t)0U == maxlen ) ) {
        count = 0U;
    }
    else {
        count = 0U;
        while ( ( (char)'\0' != *s ) && ( maxlen > (size_t)0U ) ) {
            ++count;
            --maxlen;
            ++s;
        }
    }

    return count;
}
/*============================================================================*/
size_t qIOUtil_StrlCpy( char * dst,
                        const char * src,
                        size_t maxlen )
{
    size_t srclen = qIOUtil_StrLen( src, Q_IO_UTIL_MAX_STRLEN );

    if ( ( srclen + 1U ) < maxlen ) {
        (void)memcpy( dst, src, srclen + 1U );
    }
    else if ( 0U != maxlen ) {
        (void)memcpy( dst, src, maxlen - 1U );
        dst[ maxlen - 1U ] = (char)'\0';
    }
    else {
        /*nothing to do here*/
    }

    return srclen;
}
/*============================================================================*/
size_t qIOUtil_StrlCat( char *dst,
                       const char *src,
                       size_t maxlen )
{
    size_t srclen = qIOUtil_StrLen( src, Q_IO_UTIL_MAX_STRLEN );
    size_t dstlen = qIOUtil_StrLen( dst, maxlen);
    size_t retVal;

    if ( dstlen == maxlen ) {
        retVal = maxlen + srclen;
    }
    else {
        if ( srclen < ( maxlen - dstlen ) ) {
            (void)memcpy( &dst[ dstlen ], src, srclen + 1U ) ;
        }
        else {
            (void)memcpy( &dst[ dstlen ], src, maxlen - 1U );
            dst[ dstlen + maxlen - 1U ] = '\0';
        }
        retVal = dstlen + srclen;
    }

    return retVal;
}
/*============================================================================*/
/*perform conversion of unsigned integer to ASCII. NULL Terminator not included*/
static size_t qIOUtil_xBase_U32toA( qUINT32_t num,
                                    char* str,
                                    qUINT8_t base )
{
    size_t i = 0U;

    /* Handle 0 explicitly, otherwise empty string is printed for 0 */
    if ( ( 0UL == num ) || ( 0U == base ) ) {
        str[ i++ ] = '0';  /*MISRAC2004-17.4_b deviation allowed*/
    }
    else {
        while ( 0UL != num ) { /*Process individual digits*/
            qUINT32_t rem = num % (qUINT32_t)base;
            /*cstat -CERT-INT30-C_a*/
            str[ i++ ] = ( rem > 9UL ) ?
                         (char)( (qUINT8_t)( rem - 10UL ) + 'A' ) :
                         (char)( (qUINT8_t)rem + '0' );
            /*cstat +CERT-INT30-C_a*/
            num = num/base;
        }
        (void)qIOUtil_SwapBytes( str, i );/*Reverse the string*/
    }

    return i;
}
/*============================================================================*/
static char qIOUtil_NibbleToX( qUINT8_t value )
{
    char ch;

    ch = (char)( (qUINT8_t)( value & 0x0FU ) + '0' );

    return ( ch <= '9' ) ? ch : ( ch + 7 );
}
/*============================================================================*/
qBool_t qIOUtil_SwapBytes( void *pData,
                           const size_t n )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != pData ) && ( n > 0U ) ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /*cppcheck-suppress misra-c2012-11.5 */
        qUINT8_t *p = (qUINT8_t*)pData; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        size_t lo, hi;

        hi = n - 1U;
        for ( lo = 0U ; hi > lo ; ++lo ) {
            qUINT8_t tmp = p[ lo ];
            p[ lo ] = p[ hi ];
            p[ hi ] = tmp;
            --hi;
        }
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qIOUtil_CheckEndianness( void )
{
    qUINT16_t i = 1U;

    return (qBool_t)( *( (qUINT8_t*)&i ) );
}
/*============================================================================*/
qBool_t qIOUtil_OutputString( qPutChar_t fcn,
                              void* pStorage,
                              const char *s,
                              qBool_t AIP )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != fcn ) && ( NULL != s ) ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-8.13*/
        /*cppcheck-suppress misra-c2012-11.5 */
        char *xPtr = (char*)pStorage; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-8.13*/
        if ( ( qTrue == AIP ) && ( NULL != xPtr ) ) {
            size_t i = 0U;
            while ( (char)'\0' != *s ) {
                fcn( &xPtr[ i ] , *s++ );
                ++i;
            }
            retValue = qTrue;
        }
        else {
            while ( '\0' != *s ) {
                fcn( pStorage, *s++ );
            }
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
/*cstat -MISRAC2012-Rule-8.13*/
qBool_t qIOUtil_PrintXData( qPutChar_t fcn,
                            void* pStorage,
                            void *pData,
                            size_t n )
{
    /*cstat +MISRAC2012-Rule-8.13*/
    qBool_t retValue = qFalse;

    if ( ( NULL != fcn ) && ( n > 0U ) ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-8.13*/
        /*cppcheck-suppress misra-c2012-11.5 */
        qUINT8_t *pdat =(qUINT8_t*)pData;  /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-8.13 */
        size_t i;

        for ( i = 0U ; i < n ; ++i ) {
            fcn( pStorage, qIOUtil_NibbleToX( pdat[ i ] >> 4U ) );   /*MISRAC2004-17.4_b deviation allowed*/
            fcn( pStorage, qIOUtil_NibbleToX( pdat[ i ] & 0x0FU ) ); /*MISRAC2004-17.4_b deviation allowed*/
            fcn( pStorage, ' ' );
        }
        fcn( pStorage, '\r' );
        fcn( pStorage, '\n' );
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
static qBool_t qIOUtil_IOOperation( const qIOFcn_t fcn,
                                    void* pStorage,
                                    void *pData,
                                    const size_t n,
                                    qBool_t aip,
                                    qBool_t operation )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != fcn ) && ( pData != NULL ) && ( n > 0U ) ) {
        size_t i;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /*cppcheck-suppress misra-c2012-11.5 */
        char *cdata = (char*)pData; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cppcheck-suppress misra-c2012-11.5 */
        char *iStg = (char*)pStorage; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cppcheck-suppress misra-c2012-11.5 */
        char *nStg = (char*)pStorage;
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        char tmp;
        char *ptmp = &tmp;
        char **dstDat, **dstStg;

        /* Operation -> Output=qFalse : Input=qTrue */
        dstDat = ( qFalse == operation ) ? &ptmp : &cdata;
        dstStg = ( ( qTrue == aip ) && ( NULL != pStorage ) ) ? &iStg : &nStg;

        for ( i = 0U ; i < n ; ++i ) {
            dstDat[ 0 ][ 0 ] = fcn( dstStg[ 0 ] , dstDat[ 0 ][ 0 ] );
            cdata++;
            iStg++;
        }
        retValue = qTrue;
    }
    return retValue;
}
/*cstat -MISRAC2012-Rule-8.13*/
/*============================================================================*/
qBool_t qIOUtil_OutputRaw( const qIOFcn_t oFcn,
                           void* pStorage,
                           void *pData,
                           const size_t n,
                           qBool_t aip )
{
    return qIOUtil_IOOperation( oFcn, pStorage, pData, n, aip, qFalse );
}
/*============================================================================*/
qBool_t qIOUtil_InputRaw( const qIOFcn_t iFcn,
                          void* pStorage,
                          void *pData,
                          const size_t n,
                          qBool_t aip )
{
    return qIOUtil_IOOperation( iFcn, pStorage, pData, n, aip, qTrue );
}
/*cstat +MISRAC2012-Rule-8.13*/
/*============================================================================*/
char* qIOUtil_U32toX( qUINT32_t value,
                      char *str,
                      qINT8_t n )
{
    qBase_t i;
    /*cstat -CERT-STR34-C*/
    str[ n ] = '\0'; /*MISRAC2004-17.4_b deviation allowed*/ /*CERT-STR34-C deviation allowed*/
    for ( i = ( (qBase_t)n - 1 ) ; i >= 0 ; --i ) {
        str[ i ] = qIOUtil_NibbleToX( (qUINT8_t)value ); /*MISRAC2004-17.4_b deviation allowed*/
        value >>= 4UL;
    }
    /*cstat +CERT-STR34-C*/
    return str;
}
/*============================================================================*/
static qUINT8_t qIOUtil_cXtoU8( const char c ) /* <c> should only contain a valid hex character*/
{
    qUINT8_t b = (qUINT8_t)c;
    return (qUINT8_t)( ( ( b & 0xFU ) + ( b >> 6U ) ) | ( ( b >> 3U ) & 0x8U ) );
}
/*============================================================================*/
qUINT32_t qIOUtil_XtoU32( const char *s )
{
    qUINT32_t val = 0UL;

    if ( NULL != s ) {
        qUINT8_t nParsed = 0U;
        /*
        loop until the end of the string or the number of parsed chars exceeds
        the 32bit notation
        */
        while ( ( (char)'\0' != *s ) && ( nParsed < 8U ) ) {
            char c = *s++;
            /*cstat -MISRAC2012-Dir-4.11_h*/
            if ( 0 != isxdigit( (int)c ) ) {
                val = ( val << 4UL ) | (qUINT32_t)qIOUtil_cXtoU8( c );
                ++nParsed;
            }
            else if ( 0 != isspace( (int)c ) ) {
                /*discard any white-space character*/
            }
            else {
                break; /*not valid character, break the conversion*/
            }
            /*cstat +MISRAC2012-Dir-4.11_h*/
        }
    }

    return val;
}
/*============================================================================*/
qFloat64_t qIOUtil_AtoF( const char *s )
{
    qFloat64_t rez = 0.0, fact;
    qBool_t point_seen = qFalse;
    int sgn = 1;
    char c;

    #if ( Q_ATOF_FULL == 1 )
        int power2 = 0, powerSign = 1;
        qFloat64_t power = 1.0, eFactor;
    #endif

    s = qIOUtil_DiscardWhitespaces( s, Q_IO_UTIL_MAX_STRLEN );
    s = qIOUtil_CheckStrSign( s, &sgn );
    /*cstat -CERT-FLP36-C*/
    fact = ( qFloat64_t )sgn; /*CERT-FLP36-C deviation allowed*/

    while ( (char)'\0' != ( c = *s ) ) { /*MISRAC2004-17.4_a deviation allowed*/
        if ( '.' == c ) {
            point_seen = qTrue;
        }
        /*cstat -MISRAC2012-Dir-4.11_h*/
        else if ( 0 != isdigit( (int)c ) ) {
        /*cstat +MISRAC2012-Dir-4.11_h*/
            if ( qTrue == point_seen ) {
                fact *= 0.1;
            }
            rez = ( rez * 10.0 ) + ( (qFloat64_t)c ) - 48.0; /*CERT-FLP36-C deviation allowed*/
        }
        else {
            break;
        }
        s++;
    }
    /*cstat +CERT-FLP36-C*/
    #if ( Q_ATOF_FULL == 1 )
    if ( ( 'e' == *s ) || ( 'E' == *s ) ) {
        s++;
        if ( ( '-' == *s ) || ( '+' == *s ) ) {
            powerSign = ( '-' == *s ) ? -1 : 1;
            s++;
        }
        /*cstat -MISRAC2012-Dir-4.11_h*/
        while ( 0 != isdigit( (int)*s ) ) {
            power2 = ( 10*power2 ) + ( *s - '0' );
            s++;
        }
        /*cstat +MISRAC2012-Dir-4.11_h*/
        if ( power2 > 0 ) {
            eFactor = ( -1 == powerSign ) ? 0.1 : 10.0;
            while ( 0 != power2 ) {
                power *= eFactor;
                --power2;
            }
        }
    }

    return power * rez * fact;
    #else
        return rez * fact;
    #endif
}
/*============================================================================*/
char* qIOUtil_FtoA( qFloat32_t num,
                    char *str,
                    qUINT8_t precision ) /*limited to precision=10*/
{
    if ( NULL != str ) {
        qUINT32_t u = 0U;

        (void)memcpy( &u, &num, sizeof(qUINT32_t) );
        u &= 0x7FFFFFFFU;

        if ( 0U == u ) {
            (void)qIOUtil_StrlCpy( str, "0.0", 4 );
        }
        else if ( u < 0x7F800000U ) {
            qUINT32_t intPart;
            size_t i = 0U;

            precision = qFLM_ClipUpper( precision, Q_MAX_FTOA_PRECISION );
            if ( num < 0.0F ) {
                num = -num;
                str[ i++ ] = '-';
            }

            intPart = (qUINT32_t)num;
            /*cstat -CERT-FLP36-C*/
            num -= (qFloat32_t)intPart;
            i += qIOUtil_xBase_U32toA( intPart, &str[ i ], 10U );
            if ( precision > 0U ) {
                str[ i++ ] = '.';
                while ( 0U != precision-- ) {
                    char c;
                    num *= 10.0F;
                    c = (char)num;
                    str[ i++ ] = (char)( (qUINT8_t)c + '0' );
                    num -= (qFloat32_t)c;
                }
            }
            /*cstat +CERT-FLP36-C*/
            str[ i ] = (char)'\0';
        }
        else if ( 0x7F800000U == u ) {
            str[ 0 ] = ( num > 0.0F ) ? '+' : '-';
            (void)qIOUtil_StrlCpy( &str[ 1 ] , "inf", 4 );
        }
        else {
            (void)qIOUtil_StrlCpy( str, "nan", 4 );
        }
    }

    return str;
}
/*============================================================================*/
int qIOUtil_AtoI( const char *s )
{
    int retValue = 0;

    if ( NULL != s ) {
        int res = 0; /*holds the resulting integer*/
        int sgn = 1; /*only to hold the sign*/

        s = qIOUtil_DiscardWhitespaces( s, Q_IO_UTIL_MAX_STRLEN );
        s = qIOUtil_CheckStrSign( s, &sgn );
        while ( '\0' != *s ) { /*iterate until null char is found*/
            if ( ( *s < '0' ) || ( *s > '9' ) ) {
                break;
            }
            /*if the char is digit, compute the resulting integer*/
            res = ( res * 10 ) + ( (int)*s ) - ( (int)'0' );
            ++s; /*MISRAC2004-17.4_a deviation allowed*/
        }
        retValue = sgn * res; /*return the computed integer with sign*/
    }

    return retValue;
}
/*============================================================================*/
char* qIOUtil_UtoA( qUINT32_t num,
                    char* str,
                    qUINT8_t base )
{
    if ( NULL != str ) {
        size_t i;

        /*make the unsigned conversion without the null terminator*/
        i = qIOUtil_xBase_U32toA( num, str, base );
        str[ i ] = (char)'\0'; /*MISRAC2004-17.4_b deviation allowed*/
    }

    return str;
}
/*============================================================================*/
char* qIOUtil_ItoA( qINT32_t num,
                    char* str,
                    qUINT8_t base )
{
    if ( NULL != str ) {
        size_t i = 0U;

        if ( num < 0 ) {
            if ( 10U == base ) { /*handle negative numbers only with 10-base*/
                /*put the sign at the beginning*/
                str[ i++ ] = '-'; /*MISRAC2004-17.4_b deviation allowed*/
            }
            num = -num;
        }
        /*make the unsigned conversion without the null terminator*/
        i += qIOUtil_xBase_U32toA( (qUINT32_t)num, &str[ i ], base ); /*MISRAC2004-17.4_b deviation allowed*/
        /*Append string terminator*/
        str[ i ] = '\0'; /*MISRAC2004-17.4_b deviation allowed*/
    }

    return str;
}
/*============================================================================*/
char* qIOUtil_BtoA( const qBool_t num,
                    char *str )
{
    qBool_t v = qFalse != num;

    return qIOUtil_QBtoA( v, str );
}
/*============================================================================*/
char* qIOUtil_QBtoA( const qBool_t num,
                     char *str )
{
    if ( NULL != str ) {
        switch ( (qUINT8_t)num ) {
            case qTrue:
                (void)qIOUtil_StrlCpy( str, "true", 5 );
                break;
            case qFalse:
                (void)qIOUtil_StrlCpy( str, "false", 6 );
                break;
            case qResponseTimeout:
                (void)qIOUtil_StrlCpy( str, "timeout", 8 );
                break;
            case qRising:
                (void)qIOUtil_StrlCpy( str, "rising", 7 );
                break;
            case qFalling:
                (void)qIOUtil_StrlCpy( str, "falling", 8 );
                break;
            default:
                (void)qIOUtil_StrlCpy( str, "unknown", 8 );
                break;
        }
    }

    return str;
}
/*============================================================================*/
