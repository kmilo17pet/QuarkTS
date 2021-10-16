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

    if ( 0u != ( ( k - 1u ) & k ) ) {
        qIndex_t i;
        
        k--;
        for ( i = 1u ; i < ( sizeof(qIndex_t)*8u ) ; i = (qIndex_t)( i * 2u ) ) {
            /*cstat -CERT-INT34-C_a*/
            k = k | (size_t)( k >> i ); /*CERT-INT34-C_a deviation allowed*/
            /*cstat +CERT-INT34-C_a*/
        }
        k = (size_t)( ( k + 1u ) >> 1u);
    }
    
    return ( k < r )? ( k * 2u ) : k;
}
/*============================================================================*/
size_t qBSBuffer_Count( const qBSBuffer_t * const b )
{
    size_t retValue = 0u;
    
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
        retValue = ( b->qPrivate.length == qBSBuffer_Count( b ) )? qTrue : qFalse;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Empty( const qBSBuffer_t * const b )
{
    qBool_t retValue = qTrue;

    if ( NULL != b ) {
        retValue = ( 0u == qBSBuffer_Count( b ) )? qTrue : qFalse;
    }

    return retValue;
}
/*============================================================================*/
qUINT8_t qBSBuffer_Peek( const qBSBuffer_t * const b )
{
    qUINT8_t retValue = 0x0u;

    if ( NULL != b ) {
        qIndex_t index = b->qPrivate.tail % b->qPrivate.length;

        retValue = (qUINT8_t) ( b->qPrivate.buffer[ index ] ); /*MISRAC2004-17.4_b deviation allowed*/
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Get( qBSBuffer_t * const b, qUINT8_t *dst )
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
qBool_t qBSBuffer_Read( qBSBuffer_t * const b, void *dst, const size_t n )
{
    qBool_t retValue = qFalse;

    if ( n > 0u ) {
        size_t i;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qUINT8_t *pData = (qUINT8_t*)dst; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        retValue = qTrue;
        for ( i = 0u ; i < n ; ++i ) {
            retValue = qBSBuffer_Get( b, &pData[ i ] ); /*MISRAC2004-17.4_a deviation allowed*/
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Put( qBSBuffer_t * const b, const qUINT8_t bData )
{
    qBool_t retValue = qFalse;

    if ( NULL != b ) { 
        if ( qFalse == qBSBuffer_IsFull( b ) ) {/* limit the ring to prevent overwriting */
            b->qPrivate.buffer[ b->qPrivate.head % b->qPrivate.length ] = bData; /*MISRAC2004-17.4_b deviation allowed*/
            ++b->qPrivate.head;
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qBSBuffer_Setup( qBSBuffer_t * const b, volatile qUINT8_t *pBuffer, const size_t length )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != b ) && ( NULL != pBuffer ) && ( length > 0u ) ) {
        (void)memset( b, 0, sizeof(qBSBuffer_t) );
        b->qPrivate.head = 0u;
        b->qPrivate.tail = 0u;
        b->qPrivate.buffer = pBuffer;
        b->qPrivate.length = qBSBuffer_CheckValidPowerOfTwo( length );   
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/

#endif /* #if ( Q_BYTE_SIZED_BUFFERS ==1 ) */
