/*!
 * @file qqueues.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qqueues.h"

#if (Q_QUEUES == 1)

static void qQueue_CopyDataToQueue( qQueue_t * const obj, const void *ItemToQueue, const qBool_t xPosition );
static void qQueue_MoveReader( qQueue_t * const obj );
static void qQueue_CopyDataFromQueue( qQueue_t * const obj, void * const pvBuffer );

/*============================================================================*/
qBool_t qQueue_IsReady( const qQueue_t * const obj ){
    qBool_t RetValue = qFalse;

    if( NULL != obj ){
        if( NULL != obj->qPrivate.head ){
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
qBool_t qQueue_Setup( qQueue_t * const obj, void* DataArea, size_t ItemSize, size_t ItemsCount ){
    qBool_t RetValue = qFalse;

    if( ( NULL != obj ) && ( NULL != DataArea ) && ( ItemSize > 0u ) && ( ItemsCount > 0u) ){
        obj->qPrivate.ItemsCount = ItemsCount;   /* Initialise the queue members*/
        obj->qPrivate.ItemSize = ItemSize;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /* Set the head to the start of the storage area */
        obj->qPrivate.head = (qUINT8_t*)DataArea; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        qQueue_Reset( obj );
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
void qQueue_Reset( qQueue_t * const obj ){
    if ( NULL != obj ){
        qCritical_Enter();
        obj->qPrivate.tail = obj->qPrivate.head + ( obj->qPrivate.ItemsCount * obj->qPrivate.ItemSize ); 
        obj->qPrivate.ItemsWaiting = 0u;
        obj->qPrivate.writer = obj->qPrivate.head;
        obj->qPrivate.reader = obj->qPrivate.head + ( ( obj->qPrivate.ItemsCount - 1u ) * obj->qPrivate.ItemSize );
        qCritical_Exit();
    }
}
/*============================================================================*/
qBool_t qQueue_IsEmpty( const qQueue_t * const obj ){
    qBool_t RetValue = qTrue;

    if( NULL != obj ){
        if( 0u == obj->qPrivate.ItemsWaiting ){
            RetValue = qTrue;
        }
        else{
            RetValue = qFalse;
        }  
    }
    return RetValue;   
}
/*============================================================================*/
size_t qQueue_Count( const qQueue_t * const obj ){
    size_t RetValue = 0u;

    if ( NULL != obj ){
        RetValue = obj->qPrivate.ItemsWaiting;
    } 
    return RetValue;
}
/*============================================================================*/
size_t qQueue_ItemsAvailable( const qQueue_t * const obj ){
    size_t RetValue = 0u;

    if ( NULL != obj ){
        RetValue = obj->qPrivate.ItemsCount - obj->qPrivate.ItemsWaiting;
    } 
    return RetValue;
}
/*============================================================================*/
qBool_t qQueue_IsFull( const qQueue_t * const obj ){
    qBool_t RetValue = qFalse;

    if( NULL != obj ){
        if( obj->qPrivate.ItemsWaiting == obj->qPrivate.ItemsCount ){
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
void* qQueue_Peek( const qQueue_t * const obj ){
    qUINT8_t *RetValue = NULL;

    if( NULL != obj ){
        size_t ItemsWaiting;
        qCritical_Enter(); 
        ItemsWaiting = obj->qPrivate.ItemsWaiting; /*to avoid side effects*/
        if( ItemsWaiting > 0u ){ 
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            RetValue = (qUINT8_t *)( obj->qPrivate.reader + obj->qPrivate.ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/ /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            if( RetValue >= obj->qPrivate.tail ){
                RetValue = obj->qPrivate.head;
            }
        }
        qCritical_Exit();
    }
    return (void*)RetValue;
}
/*============================================================================*/
qBool_t qQueue_RemoveFront( qQueue_t * const obj ){
    qBool_t RetValue = qFalse;

    if( NULL != obj ){
        size_t ItemsWaiting;
        qCritical_Enter(); 
        ItemsWaiting = obj->qPrivate.ItemsWaiting; /*to avoid side effects*/
        if( ItemsWaiting > 0u ){ 
            qQueue_MoveReader( obj );
            --obj->qPrivate.ItemsWaiting; /* remove the data. */
            RetValue = qTrue;
        }
        qCritical_Exit();
    }
    return RetValue;
}
/*============================================================================*/
static void qQueue_CopyDataToQueue( qQueue_t * const obj, const void *ItemToQueue, const qBool_t xPosition ){
    if( QUEUE_SEND_TO_BACK == xPosition ){
        (void)memcpy( (void*)obj->qPrivate.writer, ItemToQueue, obj->qPrivate.ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
        obj->qPrivate.writer += obj->qPrivate.ItemSize;
        if( obj->qPrivate.writer >= obj->qPrivate.tail ){
            obj->qPrivate.writer = obj->qPrivate.head;
        }         
    }
    else{
        (void)memcpy( (void*)obj->qPrivate.reader, ItemToQueue, obj->qPrivate.ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
        obj->qPrivate.reader -= obj->qPrivate.ItemSize;
        if( obj->qPrivate.reader < obj->qPrivate.head ){
            obj->qPrivate.reader = ( obj->qPrivate.tail - obj->qPrivate.ItemSize ); 
        }   
    }
    ++obj->qPrivate.ItemsWaiting;
}
/*==================================================================================*/
static void qQueue_MoveReader( qQueue_t * const obj ){
    obj->qPrivate.reader += obj->qPrivate.ItemSize;
    if( obj->qPrivate.reader >= obj->qPrivate.tail ){
        obj->qPrivate.reader = obj->qPrivate.head;
    }
}
/*==================================================================================*/
static void qQueue_CopyDataFromQueue( qQueue_t * const obj, void * const pvBuffer ){
    qQueue_MoveReader( obj );
    (void)memcpy( (void*)pvBuffer, (void*)obj->qPrivate.reader, obj->qPrivate.ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
}
/*============================================================================*/
qBool_t qQueue_Receive( qQueue_t * const obj, void *dest ){
    qBool_t RetValue = qFalse;
    
    if( NULL != obj ){
        size_t ItemsWaiting;
        qCritical_Enter(); 
        ItemsWaiting = obj->qPrivate.ItemsWaiting; /*to avoid side effects*/
        if( ItemsWaiting > 0u ){ 
            qQueue_CopyDataFromQueue( obj, dest ); /* items available, remove one of them. */
            --obj->qPrivate.ItemsWaiting; /* remove the data. */
            RetValue = qTrue;
        }        
        qCritical_Exit();
    }
    return RetValue;
}
/*============================================================================*/
qBool_t qQueue_SendGeneric( qQueue_t * const obj, void *ItemToQueue, qQueue_Mode_t InsertMode ){
    qBool_t RetValue = qFalse;
    
    if( ( NULL != obj ) && ( InsertMode <= 1u ) ){
        qCritical_Enter();
        if( obj->qPrivate.ItemsWaiting < obj->qPrivate.ItemsCount ){ /* Is there room on the queue?*/
            qQueue_CopyDataToQueue( obj, ItemToQueue, (qBool_t)InsertMode );
            RetValue = qTrue;
        }
        qCritical_Exit();
    }
    return RetValue;   
}
/*============================================================================*/

#endif /* #if (Q_QUEUES == 1) */
