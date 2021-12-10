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

/*============================================================================*/
static const char * qIOUtil_DiscardWhitespaces( const char *s,
                                                size_t maxlen )
{
    /*cstat -MISRAC2012-Rule-13.5 -MISRAC2012-Dir-4.11_h*/
    /*isspace is known to not have side effects*/
    while ( ( maxlen > (size_t)0u ) && ( 0 != isspace( (int)*s ) ) ) {
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
    char *retValue = NULL;
    do {
        if ( (int)(*s) == c ) {
            /*cstat -MISRAC2012-Rule-11.8*/
            retValue = (char*)s; /*MISRAC2012-Rule-11.8 deviation allowed*/
            /*cstat +MISRAC2012-Rule-11.8*/
            break;
        }
        --maxlen;
    } while( ( '\0' != ( *s++ ) ) && ( maxlen > 0u ) );

    return retValue;
}
/*============================================================================*/
size_t qIOUtil_StrLen( const char* s,
                       size_t maxlen )
{
    size_t count;

    if ( ( NULL == s ) || ( (size_t)0u == maxlen ) ) {
        count = 0u;
    }
    else {
        count = 0u;
        while ( ( (char)'\0' != *s ) && ( maxlen > (size_t)0u ) ) {
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
    const size_t srclen = qIOUtil_StrLen( src, Q_IOUTIL_MAX_STRLEN );

    if ( ( srclen + 1u ) < maxlen ) {
        (void)memcpy( dst, src, srclen + 1u );
    }
    else if ( 0u != maxlen ) {
        (void)memcpy( dst, src, maxlen - 1u );
        dst[ maxlen - 1u ] = (char)'\0';
    }
    else {
        /*nothing to do here*/
    }

    return srclen;
}
/*============================================================================*/
/*perform conversion of unsigned integer to ASCII. NULL Terminator not included*/
static size_t qIOUtil_xBase_U32toA( qUINT32_t num,
                                    char* str,
                                    qUINT8_t base )
{
    size_t i = 0u;

    /* Handle 0 explicitly, otherwise empty string is printed for 0 */
    if ( ( 0uL == num ) || ( 0u == base ) ) {
        str[ i++ ] = '0';  /*MISRAC2004-17.4_b deviation allowed*/
    }
    else {
        qUINT32_t rem;
        while ( 0uL != num ) { /*Process individual digits*/
            rem = num % (qUINT32_t)base;
            /*cstat -CERT-INT30-C_a*/
            str[ i++ ] = ( rem > 9uL )?
                         (char)( (qUINT8_t)( rem - 10uL ) + 'A' ) :
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

    ch = (char)( (qUINT8_t)( value & 0x0Fu ) + '0' );

    return (char)( ( ch > '9' )? (char)( ch + 7 ) : ch );
}
/*============================================================================*/
qBool_t qIOUtil_SwapBytes( void *pData,
                           const size_t n )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != pData ) && ( n > 0u ) ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qUINT8_t *p = (qUINT8_t*)pData, tmp; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        size_t lo, hi;

        hi = n - 1u;
        for ( lo = 0u ; hi > lo ; ++lo ) {
            tmp = p[ lo ];
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
    qUINT16_t i = 1u;

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
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        char *xPtr = (char*)pStorage; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        if ( ( qTrue == AIP ) && ( NULL != xPtr ) ) {
            size_t i = 0u;
            while ( (char)'\0' != *s ) {
                fcn( &xPtr[ i ] ,  *s++ );
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
qBool_t qIOUtil_PrintXData( qPutChar_t fcn,
                            void* pStorage,
                            void *pData,
                            size_t n )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != fcn ) && ( n > 0u ) ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qUINT8_t *pdat =(qUINT8_t*)pData;  /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        size_t i;

        for ( i = 0u ; i < n ; ++i ) {
            fcn( pStorage, qIOUtil_NibbleToX( pdat[ i ] >> 4u ) );   /*MISRAC2004-17.4_b deviation allowed*/
            fcn( pStorage, qIOUtil_NibbleToX( pdat[ i ] & 0x0Fu ) ); /*MISRAC2004-17.4_b deviation allowed*/
            fcn( pStorage, ' ');
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

    if ( ( NULL != fcn ) && ( pData != NULL ) && ( n > 0u ) ) {
        size_t i;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        char *cdata = (char*)pData; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        char *iStg = (char*)pStorage; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        char *nStg = (char*)pStorage;
        char tmp;
        char *ptmp = &tmp;
        char **dstDat, **dstStg;

        /* Operation -> Output=qFalse : Input=qTrue */
        dstDat = ( qFalse == operation ) ? &ptmp : &cdata;
        dstStg = ( ( qTrue == aip ) && ( NULL != pStorage ) ) ? &iStg : &nStg;

        for ( i = 0u ; i < n ; ++i ) {
            dstDat[ 0 ][ 0 ] = fcn( dstStg[ 0 ] , dstDat[ 0 ][ 0 ] );
            cdata++;
            iStg++;
        }
        retValue = qTrue;
    }
    return retValue;
}
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
        value >>= 4uL;
    }
    /*cstat +CERT-STR34-C*/
    return str;
}
/*============================================================================*/
qUINT32_t qIOUtil_XtoU32( const char *s )
{
    qUINT32_t val = 0uL;

    if ( NULL != s ) {
        qUINT8_t nparsed = 0u;
        qUINT8_t xByte;

        /*
        loop until the end of the string or the number of parsed chars exceeds
        the 32bit notation
        */
        while ( ( (char)'\0' != *s ) && ( nparsed < 8u ) ) {
            /*get the hex char, considerate only upper case*/
            xByte = (qUINT8_t)toupper( (int)*s++ ); /*MISRAC2004-17.4_a deviation allowed*/
            /*cstat -MISRAC2012-Dir-4.11_h*/
            if ( 0 != isxdigit( (int)xByte ) ) { /*if is a valid hex digit*/
                ++nparsed; /*increase the parsed char count*/
                if ( ( (char)xByte >= '0' ) && ( (char)xByte <= '9' ) ) {
                    xByte = (qUINT8_t)( xByte - (qUINT8_t)48u );
                }
                else if ( ( (char)xByte >= 'A' ) && ( (char)xByte <='F' ) ) {
                    xByte = (qUINT8_t)( xByte - (qUINT8_t)75u );
                }
                else {
                    /*nothing to do */
                }
                /*add the corresponding nibble to the output*/
                val = (qUINT32_t)((qUINT32_t)(val << 4uL) |
                      ((qUINT32_t)xByte & 0xFuL) );
            }
            else if ( 0 != isspace( (int)xByte ) ) {
            /*cstat +MISRAC2012-Dir-4.11_h*/
                /*discard any white-space char*/
            }
            else {
                break;  /*not valid char, break the conversion*/
            }
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
        int power2, powersign = 1;
        qFloat64_t power = 1.0, efactor;
    #endif

    s = qIOUtil_DiscardWhitespaces( s, Q_IOUTIL_MAX_STRLEN );
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
            rez = ( rez * 10.0 ) + ( (double)c ) - 48.0; /*CERT-FLP36-C deviation allowed*/
        }
        else {
            break;
        }
        s++;
    }
    /*cstat +CERT-FLP36-C*/
    #if ( Q_ATOF_FULL == 1 )
    if ( ( 'e'  == *s ) || ( 'E' == *s ) ) {
        s++;
        if ( ( '-' == *s ) || ( '+' == *s ) ) {
            powersign = ( '-' == *s )? -1 : 1;
            s++;
        }
        for ( power2 = 0 ; isdigit( *s ) ; s++ ) {
            power2 = power2 * 10 + ( *s - '0' );
        }
        if ( power2 > 0 ) {
            efactor = ( -1 == powersign )? 0.1 : 10.0;
            for ( power = 1; 0 != power2; power2-- ) {
                power *= efactor;
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
        if ( ( num >= 0.0f ) && ( num < 1.0E-38 ) ) { /*handle the 0.0f*/
            (void)qIOUtil_StrlCpy( str, "0.0", 4 );
        }
        else if ( qTrue == qIOUtil_IsInf( num ) ) { /*handle the infinity*/
            str[ 0 ] = ( num > 0.0f )? '+' : '-'; /*MISRAC2004-17.4_b deviation allowed*/
            (void)qIOUtil_StrlCpy( &str[1] , "inf", 4 );
        }
        else if ( qTrue == qIOUtil_IsNan( num ) ) { /*handle the NAN*/
            (void)qIOUtil_StrlCpy( str, "nan", 4 );
        }
        else {
            qUINT32_t intPart;
            size_t i = 0u;

            precision = qFLM_ClipUpper( precision, Q_MAX_FTOA_PRECISION );
            if ( num < 0.0f ) { /*handle the negative numbers*/
                num = -num; /*leave it positive for the convert method*/
                str[ i++ ] = '-'; /*add the negative sign*/
            }

            intPart = (qUINT32_t)num; /*get the integer parts*/
            /*cstat -CERT-FLP36-C*/
            /*
            get the floating-point part subtracting the integer part from the
            original value
            */
            num -= (qFloat32_t)intPart; /*CERT-FLP36-C deviation allowed*/
            /*convert the integer part in decimal form*/
            i += qIOUtil_xBase_U32toA( intPart, &str[ i ], 10u );
            if ( precision > 0u ) { /*decimal part*/
                str[ i++ ] = '.'; /*MISRAC2004-17.4_b deviation allowed*/
                while ( 0u != precision-- ) { /*convert until precision reached*/
                    char c;
                    /*start moving the float part one by one multiplying by 10*/
                    num *= 10.0f;
                    c = (char)num; /*get the bcd byte*/
                    /*convert to ASCII and put it inside the buffer*/
                    str[ i++ ] = (char)( (qUINT8_t)c + '0' );
                    num -= (qFloat32_t)c;
                }
            }
            /*cstat +CERT-FLP36-C*/
            /*put the null char*/
            str[ i ] = (char)'\0'; /*MISRAC2004-17.4_b deviation allowed*/
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

        s = qIOUtil_DiscardWhitespaces( s, Q_IOUTIL_MAX_STRLEN );
        s = qIOUtil_CheckStrSign( s, &sgn );
        while ( '\0' != *s ) { /*iterate until null char is found*/
            if ( ( *s < '0' ) || ( *s > '9' ) ) {
                break;
            }
            /*if the char is digit, compute the resulting integer*/
            res = ( res * 10 ) + ( (int)*s ) - ( (int)'0' );
            ++s; /*MISRAC2004-17.4_a deviation allowed*/
        }
        retValue =  sgn * res; /*return the computed integer with sign*/
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
        size_t i = 0u;

        if ( num < 0 ) {
            if ( 10u == base ) { /*handle negative numbers only with 10-base*/
                /*put the sign at the begining*/
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
qBool_t qIOUtil_IsInf( const qFloat32_t f )
{
    qUINT32_t u = 0uL;
    const qUINT32_t infP = 0x7F800000uL;
    const qUINT32_t infN = 0xFF800000uL;

    (void)memcpy( &u, &f, sizeof(u) );

    return ( ( infP == u ) || ( infN == u ) )? qTrue : qFalse;
}
/*============================================================================*/
qBool_t qIOUtil_IsNan( const qFloat32_t f )
{
    qUINT32_t u = 0uL;
    const qUINT32_t mask1 = 0x7F800000uL;
    const qUINT32_t mask2 = 0x007FFFFFuL;
    const qUINT32_t xNaNv = 0x7F800000uL;

    (void)memcpy( &u, &f, sizeof(u) );

    return ( ( xNaNv == ( u & mask1 ) ) && ( 0uL != ( u & mask2 ) ) )? qTrue
                                                                     : qFalse;
}
/*============================================================================*/
