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
        q->qPrivate.ItemsCount = itemsCount;   /* Initialise the queue members*/
        q->qPrivate.ItemSize = itemSize;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /* Set the head to the start of the storage area */
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
        q->qPrivate.tail = q->qPrivate.head + ( q->qPrivate.ItemsCount * q->qPrivate.ItemSize ); 
        q->qPrivate.ItemsWaiting = 0u;
        q->qPrivate.writer = q->qPrivate.head;
        q->qPrivate.reader = q->qPrivate.head + ( ( q->qPrivate.ItemsCount - 1u ) * q->qPrivate.ItemSize );
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
        retValue =  ( 0u == q->qPrivate.ItemsWaiting )? qTrue : qFalse;
    }
    
    return retValue;   
}
/*============================================================================*/
size_t qQueue_Count( const qQueue_t * const q )
{
    size_t retValue = 0u;

    if ( NULL != q ) {
        retValue = q->qPrivate.ItemsWaiting;
    } 

    return retValue;
}
/*============================================================================*/
size_t qQueue_ItemsAvailable( const qQueue_t * const q )
{
    size_t retValue = 0u;

    if ( NULL != q ) {
        retValue = q->qPrivate.ItemsCount - q->qPrivate.ItemsWaiting;
    } 

    return retValue;
}
/*============================================================================*/
qBool_t qQueue_IsFull( const qQueue_t * const q )
{
    qBool_t retValue = qFalse;

    if ( NULL != q ) {
        if ( q->qPrivate.ItemsWaiting == q->qPrivate.ItemsCount ) {
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
        itemsWaiting = q->qPrivate.ItemsWaiting; /*to avoid side effects*/
        if ( itemsWaiting > 0u ) { 
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            retValue = (qUINT8_t *)( q->qPrivate.reader + q->qPrivate.ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/ /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
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
        itemsWaiting = q->qPrivate.ItemsWaiting; /*to avoid side effects*/
        if ( itemsWaiting > 0u ) { 
            qQueue_MoveReader( q );
            --q->qPrivate.ItemsWaiting; /* remove the data. */
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
        (void)memcpy( (void*)q->qPrivate.writer, itemToQueue, q->qPrivate.ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
        q->qPrivate.writer += q->qPrivate.ItemSize;
        if ( q->qPrivate.writer >= q->qPrivate.tail ) {
            q->qPrivate.writer = q->qPrivate.head;
        }         
    }
    else {
        (void)memcpy( (void*)q->qPrivate.reader, itemToQueue, q->qPrivate.ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
        q->qPrivate.reader -= q->qPrivate.ItemSize;
        if ( q->qPrivate.reader < q->qPrivate.head ) {
            q->qPrivate.reader = ( q->qPrivate.tail - q->qPrivate.ItemSize ); 
        }   
    }
    ++q->qPrivate.ItemsWaiting;
}
/*==================================================================================*/
static void qQueue_MoveReader( qQueue_t * const q )
{
    q->qPrivate.reader += q->qPrivate.ItemSize;
    if ( q->qPrivate.reader >= q->qPrivate.tail ) {
        q->qPrivate.reader = q->qPrivate.head;
    }
}
/*==================================================================================*/
static void qQueue_CopyDataFromQueue( qQueue_t * const q, 
                                      void * const pvBuffer )
{
    qQueue_MoveReader( q );
    (void)memcpy( (void*)pvBuffer, (void*)q->qPrivate.reader, q->qPrivate.ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
}
/*============================================================================*/
qBool_t qQueue_Receive( qQueue_t * const q, 
                        void *dst )
{
    qBool_t retValue = qFalse;
    
    if ( NULL != q ) {
        size_t itemsWaiting;
        qCritical_Enter(); 
        itemsWaiting = q->qPrivate.ItemsWaiting; /*to avoid side effects*/
        if ( itemsWaiting > 0u ) { 
            qQueue_CopyDataFromQueue( q, dst ); /* items available, remove one of them. */
            --q->qPrivate.ItemsWaiting; /* remove the data. */
            retValue = qTrue;
        }        
        qCritical_Exit();
    }

    return retValue;
}
/*============================================================================*/
qBool_t qQueue_SendGeneric( qQueue_t * const q, 
                            void *itemToQueue, 
                            const qQueue_Mode_t insertMode )
{
    qBool_t retValue = qFalse;
    
    if ( ( NULL != q ) && ( insertMode <= 1u ) ) {
        qCritical_Enter();
        if ( q->qPrivate.ItemsWaiting < q->qPrivate.ItemsCount ) { /* Is there room on the queue?*/
            qQueue_CopyDataToQueue( q, itemToQueue, (qBool_t)insertMode );
            retValue = qTrue;
        }
        qCritical_Exit();
    }

    return retValue;   
}
/*============================================================================*/

#endif /* #if (Q_QUEUES == 1) */