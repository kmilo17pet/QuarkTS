/*!
 * @file qqueues.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qqueues.h"

#if ( Q_QUEUES == 1 )

static void qQueue_CopyDataToQueue( qQueue_t * const q,
                                    const void *itemToQueue,
                                    const qBool_t xPosition );
static void qQueue_MoveReader( qQueue_t * const q );
static void qQueue_CopyDataFromQueue( qQueue_t * const q,
                                      void * const pvBuffer );

/*============================================================================*/
qBool_t qQueue_IsReady( const qQueue_t * const q )
{
    qBool_t retValue = qFalse;

    if ( NULL != q ) {
        if ( NULL != q->qPrivate.head ) {
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qQueue_Setup( qQueue_t * const q,
                      void* pData,
                      const size_t itemSize,
                      const size_t itemsCount )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != q ) && ( NULL != pData ) && ( itemSize > 0u ) && ( itemsCount > 0u ) ) {
        (void)memset( q, 0, sizeof( qQueue_t ) );
        q->qPrivate.itemsCount = itemsCount; /* Initialise the queue members*/
        q->qPrivate.itemSize = itemSize;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /* Set the head to the start of the storage area */
        /*cppcheck-suppress misra-c2012-11.5 */
        q->qPrivate.head = (qUINT8_t*)pData; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        (void)qQueue_Reset( q );
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qQueue_Reset( qQueue_t * const q )
{
    qBool_t retValue = qFalse;

    if ( NULL != q ) {
        qCritical_Enter();
        q->qPrivate.tail = q->qPrivate.head + ( q->qPrivate.itemsCount * q->qPrivate.itemSize );
        q->qPrivate.itemsWaiting = 0u;
        q->qPrivate.writer = q->qPrivate.head;
        q->qPrivate.reader = q->qPrivate.head + ( ( q->qPrivate.itemsCount - 1u ) * q->qPrivate.itemSize );
        qCritical_Exit();
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qQueue_IsEmpty( const qQueue_t * const q )
{
    qBool_t retValue = qTrue;

    if ( NULL != q ) {
        retValue = ( 0u == q->qPrivate.itemsWaiting ) ? qTrue : qFalse;
    }

    return retValue;
}
/*============================================================================*/
size_t qQueue_Count( const qQueue_t * const q )
{
    size_t retValue = 0u;

    if ( NULL != q ) {
        retValue = q->qPrivate.itemsWaiting;
    }

    return retValue;
}
/*============================================================================*/
size_t qQueue_ItemsAvailable( const qQueue_t * const q )
{
    size_t retValue = 0u;

    if ( NULL != q ) {
        retValue = q->qPrivate.itemsCount - q->qPrivate.itemsWaiting;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qQueue_IsFull( const qQueue_t * const q )
{
    qBool_t retValue = qFalse;

    if ( NULL != q ) {
        if ( q->qPrivate.itemsWaiting == q->qPrivate.itemsCount ) {
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
void* qQueue_Peek( const qQueue_t * const q )
{
    qUINT8_t *retValue = NULL;

    if ( NULL != q ) {
        size_t itemsWaiting;
        qCritical_Enter();
        itemsWaiting = q->qPrivate.itemsWaiting; /*to avoid side effects*/
        if ( itemsWaiting > 0u ) {
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            /*cppcheck-suppress cert-EXP05-C */
            retValue = (qUINT8_t *)( q->qPrivate.reader + q->qPrivate.itemSize ); // skipcq: CXX-S1014
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            if ( retValue >= q->qPrivate.tail ) {
                retValue = q->qPrivate.head;
            }
        }
        qCritical_Exit();
    }

    return (void*)retValue;
}
/*============================================================================*/
qBool_t qQueue_RemoveFront( qQueue_t * const q )
{
    qBool_t retValue = qFalse;

    if ( NULL != q ) {
        size_t itemsWaiting;
        qCritical_Enter();
        itemsWaiting = q->qPrivate.itemsWaiting; /*to avoid side effects*/
        if ( itemsWaiting > 0u ) {
            qQueue_MoveReader( q );
            --q->qPrivate.itemsWaiting; /* remove the data. */
            retValue = qTrue;
        }
        qCritical_Exit();
    }

    return retValue;
}
/*============================================================================*/
static void qQueue_CopyDataToQueue( qQueue_t * const q,
                                    const void *itemToQueue,
                                    const qBool_t xPosition )
{
    if ( QUEUE_SEND_TO_BACK == xPosition ) {
        (void)memcpy( (void*)q->qPrivate.writer, itemToQueue, q->qPrivate.itemSize );  /*MISRAC2012-Rule-11.8 allowed*/
        q->qPrivate.writer += q->qPrivate.itemSize;
        if ( q->qPrivate.writer >= q->qPrivate.tail ) {
            q->qPrivate.writer = q->qPrivate.head;
        }
    }
    else {
        (void)memcpy( (void*)q->qPrivate.reader, itemToQueue, q->qPrivate.itemSize );  /*MISRAC2012-Rule-11.8 allowed*/
        q->qPrivate.reader -= q->qPrivate.itemSize;
        if ( q->qPrivate.reader < q->qPrivate.head ) {
            q->qPrivate.reader = ( q->qPrivate.tail - q->qPrivate.itemSize );
        }
    }
    ++q->qPrivate.itemsWaiting;
}
/*============================================================================*/
static void qQueue_MoveReader( qQueue_t * const q )
{
    q->qPrivate.reader += q->qPrivate.itemSize;
    if ( q->qPrivate.reader >= q->qPrivate.tail ) {
        q->qPrivate.reader = q->qPrivate.head;
    }
}
/*============================================================================*/
static void qQueue_CopyDataFromQueue( qQueue_t * const q,
                                      void * const pvBuffer )
{
    qQueue_MoveReader( q );
    (void)memcpy( (void*)pvBuffer, (void*)q->qPrivate.reader, q->qPrivate.itemSize );  /*MISRAC2012-Rule-11.8 allowed*/
}
/*============================================================================*/
qBool_t qQueue_Receive( qQueue_t * const q,
                        void *dst )
{
    qBool_t retValue = qFalse;

    if ( NULL != q ) {
        size_t itemsWaiting;
        qCritical_Enter();
        itemsWaiting = q->qPrivate.itemsWaiting; /*to avoid side effects*/
        if ( itemsWaiting > 0u ) {
            /* items available, remove one of them. */
            qQueue_CopyDataFromQueue( q, dst );
            --q->qPrivate.itemsWaiting;
            retValue = qTrue;
        }
        qCritical_Exit();
    }

    return retValue;
}
/*============================================================================*/
qBool_t qQueue_Send( qQueue_t * const q,
                     void *itemToQueue,
                     const qQueue_InsertMode_t pos )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != q ) && ( pos <= 1u ) ) {
        qCritical_Enter();
        if ( q->qPrivate.itemsWaiting < q->qPrivate.itemsCount ) {
            qQueue_CopyDataToQueue( q, itemToQueue, (qBool_t)pos );
            retValue = qTrue;
        }
        qCritical_Exit();
    }

    return retValue;
}
/*============================================================================*/

#endif /* #if (Q_QUEUES == 1) */
