/*!
 * @file qbsbuffers.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qbsbuffers.h"
#include <string.h>

#if ( Q_BYTE_SIZED_BUFFERS == 1 )

static size_t qBSBuffer_CheckValidPowerOfTwo( size_t k );

/*============================================================================*/
static size_t qBSBuffer_CheckValidPowerOfTwo( size_t k )
{
    size_t r = k;

    if ( 0U != ( ( k - 1U ) & k ) ) {
        qIndex_t i;

        k--;
        for ( i = 1U ; i < ( sizeof(qIndex_t)*8U ) ; i = (qIndex_t)( i * 2U ) ) { // skipcq: CXX-W1240
            /*cstat -CERT-INT34-C_a*/
            k = k | (size_t)( k >> i ); /*CERT-INT34-C_a deviation allowed*/
            /*cstat +CERT-INT34-C_a*/
        }
        k = (size_t)( ( k + 1U ) >> 1U );
    }

    return ( k < r ) ? ( k * 2U ) : k;
}
/*============================================================================*/
size_t qBSBuffer_Count( const qBSBuffer_t * const b )
{
    size_t retValue = 0U;

    if ( NULL != b ) {
        qIndex_t head = b->qPrivate.head;
        qIndex_t tail = b->qPrivate.tail;

        retValue = (size_t)( head - tail );
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_IsFull( const qBSBuffer_t * const b )
{
    qBool_t retValue = qFalse;

    if ( NULL != b ) {
        retValue = ( b->qPrivate.length == qBSBuffer_Count( b ) ) ? qTrue : qFalse;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Empty( const qBSBuffer_t * const b )
{
    qBool_t retValue = qTrue;

    if ( NULL != b ) {
        retValue = ( 0U == qBSBuffer_Count( b ) ) ? qTrue : qFalse;
    }

    return retValue;
}
/*============================================================================*/
qUINT8_t qBSBuffer_Peek( const qBSBuffer_t * const b )
{
    qUINT8_t retValue = 0x0U;

    if ( NULL != b ) {
        qIndex_t index = b->qPrivate.tail % b->qPrivate.length;

        retValue = (qUINT8_t) ( b->qPrivate.buffer[ index ] ); /*MISRAC2004-17.4_b deviation allowed*/
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Get( qBSBuffer_t * const b,
                       qUINT8_t *dst )
{
    qBool_t retValue = qFalse;

    if ( qFalse == qBSBuffer_Empty( b ) ) {
        qIndex_t index = b->qPrivate.tail % b->qPrivate.length;

        *dst = b->qPrivate.buffer[ index ]; /*MISRAC2004-17.4_b deviation allowed*/
        ++b->qPrivate.tail;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Read( qBSBuffer_t * const b,
                        void *dst,
                        const size_t n )
{
    qBool_t retValue = qFalse;

    if ( n > 0U ) {
        size_t i;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /*cppcheck-suppress misra-c2012-11.5 */
        qUINT8_t *pData = (qUINT8_t*)dst; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        retValue = qTrue;
        for ( i = 0U ; i < n ; ++i ) {
            retValue = qBSBuffer_Get( b, &pData[ i ] ); /*MISRAC2004-17.4_a deviation allowed*/
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Put( qBSBuffer_t * const b,
                       const qUINT8_t bData )
{
    qBool_t retValue = qFalse;

    if ( NULL != b ) {
        /* limit the ring to prevent overwriting */
        if ( qFalse == qBSBuffer_IsFull( b ) ) {
            b->qPrivate.buffer[ b->qPrivate.head % b->qPrivate.length ] = bData; /*MISRAC2004-17.4_b deviation allowed*/
            ++b->qPrivate.head;
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Setup( qBSBuffer_t * const b,
                         volatile qUINT8_t *pBuffer,
                         const size_t length )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != b ) && ( NULL != pBuffer ) && ( length > 0U ) ) {
        (void)memset( b, 0, sizeof(qBSBuffer_t) );
        b->qPrivate.head = 0U;
        b->qPrivate.tail = 0U;
        b->qPrivate.buffer = pBuffer;
        b->qPrivate.length = qBSBuffer_CheckValidPowerOfTwo( length );
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/

#endif /* #if ( Q_BYTE_SIZED_BUFFERS ==1 ) */
