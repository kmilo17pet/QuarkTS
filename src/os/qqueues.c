#include "qqueues.h"

#if (Q_QUEUES == 1)

static void qQueueCopyDataToQueue( qQueue_t *obj, const void *pvItemToQueue, qBool_t xPosition );
static void qQueueMoveReader( qQueue_t *obj );

/*============================================================================*/
/*qBool_t qQueueCreate(qQueue_t *obj, void* DataBlock, const qSize_t ElementSize, const qSize_t ElementCount)
 
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
qBool_t qQueueCreate( qQueue_t *obj, void* DataArea, qSize_t ItemSize, qSize_t ItemsCount ){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( NULL != DataArea ) && ( ItemSize > 0u ) && ( ItemsCount > 0u) ){
        obj->ItemsCount = ItemsCount;   /* Initialise the queue members*/
        obj->ItemSize = ItemSize;
        obj->pHead = DataArea;
        obj->pTail = obj->pHead + ( obj->ItemsCount * obj->ItemSize ); 
        qQueueReset( obj );
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qQueueReset(qQueue_t *obj)
 
Resets a queue to its original empty state.
 
Parameters:

    - obj : a pointer to the Queue object
*/
void qQueueReset( qQueue_t *obj ){
    if ( NULL != obj ){
        qEnterCritical();
        obj->ItemsWaiting = 0u;
        obj->pcWriteTo = obj->pHead;
        obj->pcReadFrom = obj->pHead + ( ( obj->ItemsCount - 1u ) * obj->ItemSize );
        qExitCritical();
    }
}
/*============================================================================*/
/*qBool_t qQueueIsEmpty(qQueue_t *obj)
 
Returns the empty status of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if the Queue is empty, qFalse if it is not.
 */
qBool_t qQueueIsEmpty( const qQueue_t *obj ){
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
/*qSize_t qQueueCount(qQueue_t *obj)
 
Returns the number of items in the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    The number of elements in the queue
 */
qSize_t qQueueCount( const qQueue_t *obj ){
    qSize_t RetValue = 0u;
    if ( NULL != obj ){
        RetValue = obj->ItemsWaiting;
    } 
    return RetValue;
}
/*============================================================================*/
/*qBool_t qQueueIsFull(qQueue_t *obj)
 
Returns the full status of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if the Queue is full, qFalse if it is not.
 */
/*============================================================================*/
qBool_t qQueueIsFull( const qQueue_t *obj ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( obj->ItemsWaiting == obj->ItemsCount ){
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*void* qQueuePeek(qQueue_t *obj)
 
Looks at the data from the front of the Queue without removing it. 
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    Pointer to the data, or NULL if there is nothing in the queue
 */
void* qQueuePeek( const qQueue_t *obj ){
    uint8_t *RetValue = NULL;
    if( NULL != obj ){
        if( obj->ItemsWaiting > 0u ){
            qEnterCritical();
            RetValue = (void*)( obj->pcReadFrom + obj->ItemSize );
            if( RetValue >= obj->pTail ){
                RetValue = obj->pHead;
            }
            qExitCritical();
        }
    }
    return (void*)RetValue;
}
/*============================================================================*/
/*qBool_t qQueueRemoveFront(qQueue_t *obj)
 
Remove the data located at the front of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if data was removed from the Queue, otherwise returns qFalse
 */
qBool_t qQueueRemoveFront( qQueue_t *obj ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( obj->ItemsWaiting > 0u ){
            qEnterCritical();
            qQueueMoveReader( obj );
            --( obj->ItemsWaiting ); /* remove the data. */
            qExitCritical();
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
static void qQueueCopyDataToQueue( qQueue_t *obj, const void *pvItemToQueue, qBool_t xPosition ){
    if( QUEUE_SEND_TO_BACK == xPosition ){
        memcpy( (void*) obj->pcWriteTo, pvItemToQueue, (unsigned)obj->ItemSize );
        obj->pcWriteTo += obj->ItemSize;
        if( obj->pcWriteTo >= obj->pTail ){
            obj->pcWriteTo = obj->pHead;
        }
              
    }
    else{
        memcpy( (void*) obj->pcReadFrom, pvItemToQueue, (unsigned)obj->ItemSize );
        obj->pcReadFrom -= obj->ItemSize;
        if( obj->pcReadFrom < obj->pHead ){
            obj->pcReadFrom = ( obj->pTail - obj->ItemSize ); 
        }   
    }
    ++( obj->ItemsWaiting );
}
/*==================================================================================*/
static void qQueueMoveReader( qQueue_t *obj ){
    obj->pcReadFrom += obj->ItemSize;
    if( obj->pcReadFrom >= obj->pTail ){
        obj->pcReadFrom = obj->pHead;
    }
}
/*==================================================================================*/
static void qQueueCopyDataFromQueue( qQueue_t *obj, const void *pvBuffer ){
    qQueueMoveReader( obj );
    memcpy( (void*) pvBuffer, (void*)obj->pcReadFrom, (unsigned)obj->ItemSize );
}
/*============================================================================*/
/*void* qQueueReceive(qQueue_t *obj, void *dest)
 
Receive an item from a queue (and removes it). The item is received by copy so a 
buffer of adequate size must be provided. The number of bytes copied into the buffer 
was defined when the queue was created.
 
Parameters:

    - obj : a pointer to the Queue object
    - dest: Pointer to the buffer into which the received item will be copied.
  
Return value:

    qTrue if data was retrieved from the Queue, otherwise returns qFalse
*/
qBool_t qQueueReceive( qQueue_t *obj, void *dest ){
    qBool_t RetValue = qFalse;
    if( obj->ItemsWaiting > 0u ){
        qEnterCritical();
        qQueueCopyDataFromQueue( obj, dest );
        --( obj->ItemsWaiting ); /* remove the data. */
        qExitCritical();
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qQueueGenericSend(qQueue_t *obj, void *ItemToQueue, qBool_t InsertMode)
 
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
qBool_t qQueueGenericSend( qQueue_t *obj, void *ItemToQueue, uint8_t InsertMode ){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( InsertMode <= 1u ) ){
        if( obj->ItemsWaiting < obj->ItemsCount ){ /* Is there room on the queue?*/
            qEnterCritical();
            qQueueCopyDataToQueue( obj, ItemToQueue, InsertMode );
            qExitCritical();
            RetValue = qTrue;
        }
    }
    return RetValue;   
}
/*============================================================================*/

#endif /* #if (Q_QUEUES == 1) */