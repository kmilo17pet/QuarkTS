#ifndef QQUEUES_H
    #define QQUEUES_H

    #include "qtypes.h"
    #include "qcritical.h"
    
    #include <string.h>

    typedef struct {
        uint8_t *pHead;			        /*< Points to the beginning of the queue storage area. */
        uint8_t *pTail;			        /*< Points to the byte at the end of the queue storage area.  Once more byte is allocated than necessary to store the queue items, this is used as a marker. */
        volatile uint8_t *pcWriteTo;	/*< Points to the free next place in the storage area. */
        volatile uint8_t *pcReadFrom;	/*< Points to the last place that a queued item was read from. */
        volatile qSize_t ItemsWaiting;  /*< The number of items currently in the queue. */
        qSize_t ItemsCount;		        /*< The length of the queue defined as the number of items it will hold, not the number of bytes. */
        qSize_t ItemSize;		        /*< The size of each items that the queue will hold. */
    }qQueue_t;

    #define QUEUE_SEND_TO_BACK     ( 0u )
    #define QUEUE_SEND_TO_FRONT    ( 1u )
    /*qBool_t qQueueSendToBack(qQueue_t *obj, void *ItemToQueue)

    Post an item to the back of the queue. The item is queued by copy, not by reference
    
    Parameters:

        - obj : a pointer to the Queue object
        - ItemToQueue : A pointer to the item that is to be placed on the queue. The size of 
                the items the queue will hold was defined when the queue was created, 
                so this many bytes will be copied from ItemToQueue into the queue storage
                area.
    
    Return value:

        qTrue on successful add, qFalse if not added
    */
    #define qQueueSendToBack(_qQueue_t_, _ItemToQueue_)     qQueueGenericSend((_qQueue_t_), (_ItemToQueue_), QUEUE_SEND_TO_BACK)
    /*qBool_t qQueueSend(qQueue_t *obj, void *ItemToQueue)

    Post an item to the back of the queue. The item is queued by copy, not by reference
    
    Parameters:

        - obj : a pointer to the Queue object
        - ItemToQueue : A pointer to the item that is to be placed on the queue. The size of 
                the items the queue will hold was defined when the queue was created, 
                so this many bytes will be copied from ItemToQueue into the queue storage
                area.
    
    Return value:

        qTrue on successful add, qFalse if not added
    */
    #define qQueueSend(_qQueue_t_, _ItemToQueue_)           qQueueGenericSend((_qQueue_t_), (_ItemToQueue_), QUEUE_SEND_TO_BACK)
    /*qBool_t qQueueSendToFront(qQueue_t *obj, void *ItemToQueue)
    
    Post an item in the front of the queue. The item is queued by copy, not by reference
    
    Parameters:

        - obj : a pointer to the Queue object
        - item : A pointer to the item that is to be placed on the queue. The size of 
                the items the queue will hold was defined when the queue was created, 
                so this many bytes will be copied from ItemToQueue into the queue storage
                area.
    
    Return value:

        qTrue on successful add, qFalse if not added
    */        
    #define qQueueSendToFront(_qQueue_t_, _ItemToQueue_)    qQueueGenericSend((_qQueue_t_), (_ItemToQueue_), QUEUE_SEND_TO_FRONT)


    qBool_t qQueueCreate( qQueue_t *obj, void* DataArea, qSize_t ItemSize, qSize_t ItemsCount );
    void qQueueReset( qQueue_t *obj );
    qSize_t qQueueCount( const qQueue_t *obj );
    qBool_t qQueueIsFull( const qQueue_t *obj );
    qBool_t qQueueIsEmpty( const qQueue_t *obj );
    void* qQueuePeek( const qQueue_t *obj );
    qBool_t qQueueRemoveFront( qQueue_t *obj );
    qBool_t qQueueGenericSend( qQueue_t *obj, void *ItemToQueue, uint8_t InsertMode );
    qBool_t qQueueReceive (qQueue_t *obj, void *dest );

#endif 