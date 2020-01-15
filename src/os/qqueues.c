#include "qqueues.h"

#if (Q_QUEUES == 1)

static void qQueueCopyDataToQueue( qQueue_t * const obj, const void *pvItemToQueue, const qBool_t xPosition );
static void qQueueMoveReader( qQueue_t * const obj );
static void qQueueCopyDataFromQueue( qQueue_t * const obj, void * const pvBuffer );

/*============================================================================*/
/*qBool_t qQueueCreate(qQueue_t * const obj, void* DataBlock, const qSize_t ElementSize, const qSize_t ElementCount)
 
Create and configures a Queue. Here, the RAM used to hold the queue data <DataBlock>
is statically allocated at compile time by the application writer.
 
Parameters:

    - obj : a pointer to the Queue object
    - DataBlock :  data block or array of data
    - ElementSize : size of one element in the data block
    - ElementCount : size of one element in the data block
 
Note: Element_count should be a power of two, or it will only use the next 
      higher power of two

    Return value:

    qTrue on success, otherwise returns qFalse.

 */
qBool_t qQueueCreate( qQueue_t * const obj, void* DataArea, size_t ItemSize, size_t ItemsCount ){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( NULL != DataArea ) && ( ItemSize > 0u ) && ( ItemsCount > 0u) ){
        obj->ItemsCount = ItemsCount;   /* Initialise the queue members*/
        obj->ItemSize = ItemSize;
        obj->pHead = DataArea; /* MISRAC2012-Rule-11.5 deviation allowed */
        obj->pTail = obj->pHead + ( obj->ItemsCount * obj->ItemSize ); 
        qQueueReset( obj );
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qQueueReset(qQueue_t * const obj)
 
Resets a queue to its original empty state.
 
Parameters:

    - obj : a pointer to the Queue object
*/
void qQueueReset( qQueue_t * const obj ){
    if ( NULL != obj ){
        qCritical_Enter();
        obj->ItemsWaiting = 0u;
        obj->pcWriteTo = obj->pHead;
        obj->pcReadFrom = obj->pHead + ( ( obj->ItemsCount - 1u ) * obj->ItemSize );
        qCritical_Exit();
    }
}
/*============================================================================*/
/*qBool_t qQueueIsEmpty(const qQueue_t * const obj)
 
Returns the empty status of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if the Queue is empty, qFalse if it is not.
 */
qBool_t qQueueIsEmpty( const qQueue_t * const obj ){
    qBool_t RetValue = qTrue;
    if( NULL != obj ){
        if( obj->ItemsWaiting == 0u ){
            RetValue = qTrue;
        }
        else{
            RetValue = qFalse;
        }  
    }
    return RetValue;   
}
/*============================================================================*/
/*qSize_t qQueueCount(const qQueue_t * const obj)
 
Returns the number of items in the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    The number of elements in the queue
 */
size_t qQueueCount( const qQueue_t * const obj ){
    size_t RetValue = 0u;
    if ( NULL != obj ){
        RetValue = obj->ItemsWaiting;
    } 
    return RetValue;
}
/*============================================================================*/
/*qBool_t qQueueIsFull(const qQueue_t * const obj)
 
Returns the full status of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if the Queue is full, qFalse if it is not.
 */
/*============================================================================*/
qBool_t qQueueIsFull( const qQueue_t * const obj ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( obj->ItemsWaiting == obj->ItemsCount ){
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*void* qQueuePeek(const qQueue_t * const obj)
 
Looks at the data from the front of the Queue without removing it. 
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    Pointer to the data, or NULL if there is nothing in the queue
 */
void* qQueuePeek( const qQueue_t * const obj ){
    qUINT8_t *RetValue = NULL;
    if( NULL != obj ){
        if( obj->ItemsWaiting > 0u ){
            qCritical_Enter();
            RetValue = (void*)( obj->pcReadFrom + obj->ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/ /* MISRAC2012-Rule-11.5 deviation allowed */
            if( RetValue >= obj->pTail ){
                RetValue = obj->pHead;
            }
            qCritical_Exit();
        }
    }
    return (void*)RetValue;
}
/*============================================================================*/
/*qBool_t qQueueRemoveFront(qQueue_t * const obj)
 
Remove the data located at the front of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if data was removed from the Queue, otherwise returns qFalse
 */
qBool_t qQueueRemoveFront( qQueue_t * const obj ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( obj->ItemsWaiting > 0u ){
            qCritical_Enter();
            qQueueMoveReader( obj );
            --( obj->ItemsWaiting ); /* remove the data. */
            qCritical_Exit();
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
static void qQueueCopyDataToQueue( qQueue_t * const obj, const void *pvItemToQueue, const qBool_t xPosition ){
    if( QUEUE_SEND_TO_BACK == xPosition ){
        (void) memcpy( (void*) obj->pcWriteTo, pvItemToQueue, obj->ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
        obj->pcWriteTo += obj->ItemSize;
        if( obj->pcWriteTo >= obj->pTail ){
            obj->pcWriteTo = obj->pHead;
        }
              
    }
    else{
        (void) memcpy( (void*) obj->pcReadFrom, pvItemToQueue, obj->ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
        obj->pcReadFrom -= obj->ItemSize;
        if( obj->pcReadFrom < obj->pHead ){
            obj->pcReadFrom = ( obj->pTail - obj->ItemSize ); 
        }   
    }
    ++( obj->ItemsWaiting );
}
/*==================================================================================*/
static void qQueueMoveReader( qQueue_t * const obj ){
    obj->pcReadFrom += obj->ItemSize;
    if( obj->pcReadFrom >= obj->pTail ){
        obj->pcReadFrom = obj->pHead;
    }
}
/*==================================================================================*/
static void qQueueCopyDataFromQueue( qQueue_t * const obj, void * const pvBuffer ){
    qQueueMoveReader( obj );
    (void) memcpy( (void*) pvBuffer, (void*)obj->pcReadFrom, obj->ItemSize );  /*MISRAC2012-Rule-11.8 allowed*/
}
/*============================================================================*/
/*qBool_t qQueueReceive(qQueue_t * const obj, void *dest)
 
Receive an item from a queue (and removes it). The item is received by copy so a 
buffer of adequate size must be provided. The number of bytes copied into the buffer 
was defined when the queue was created.
 
Parameters:

    - obj : a pointer to the Queue object
    - dest: Pointer to the buffer into which the received item will be copied.
  
Return value:

    qTrue if data was retrieved from the Queue, otherwise returns qFalse
*/
qBool_t qQueueReceive( qQueue_t * const obj, void *dest ){
    qBool_t RetValue = qFalse;
    if( obj->ItemsWaiting > 0u ){
        qCritical_Enter();
        qQueueCopyDataFromQueue( obj, dest );
        --( obj->ItemsWaiting ); /* remove the data. */
        qCritical_Exit();
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qQueueGenericSend(qQueue_t * const obj, void *ItemToQueue, qBool_t InsertMode)
 
Post an item to the back of the queue. The item is queued by copy, not by reference
 
Parameters:

    - obj : a pointer to the Queue object
    - ItemToQueue : A pointer to the item that is to be placed on the queue. The size of 
            the items the queue will hold was defined when the queue was created, 
            so this many bytes will be copied from ItemToQueue into the queue storage
            area.
    - InsertMode : Can take the value QUEUE_SEND_TO_BACK to place the item at the back 
                  of the queue, or QUEUE_SEND_TO_FRONT to place the item at the front of 
                  the queue (for high priority messages).
  
Return value:

    qTrue on successful add, qFalse if not added
*/
qBool_t qQueueGenericSend( qQueue_t * const obj, void *ItemToQueue, qQueueMode_t InsertMode ){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( InsertMode <= 1u ) ){
        if( obj->ItemsWaiting < obj->ItemsCount ){ /* Is there room on the queue?*/
            qCritical_Enter();
            qQueueCopyDataToQueue( obj, ItemToQueue, (qBool_t)InsertMode );
            qCritical_Exit();
            RetValue = qTrue;
        }
    }
    return RetValue;   
}
/*============================================================================*/

#endif /* #if (Q_QUEUES == 1) */