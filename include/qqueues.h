/*!
 * @file qqueues.h
 * @author J. Camilo Gomez C.
 * @version 2.02
 * @note This file is part of the QuarkTS distribution.
 * @brief API interface to create and handle queues.
 **/
#ifndef QQUEUES_H
    #define QQUEUES_H

    #include "qtypes.h"
    #include "qcritical.h"
    
    #include <string.h>

    #ifdef __cplusplus
    extern "C" {
    #endif
    

    #ifndef Q_QUEUES
        #define Q_QUEUES        ( 1 )
    #endif

    /** @addtogroup  Queues
    * @brief API interface to create and handle queues.
    * @{
    */

    /** 
    * @brief A Queue object
    * @note Do not access any member of this structure directly. 
    */
    typedef struct{
        /*! @cond PRIVATE */
        struct _qQueue_Private_s{
            qUINT8_t *head;			        /*< Points to the beginning of the queue storage area. */
            qUINT8_t *tail;			        /*< Points to the byte at the end of the queue storage area.  Once more byte is allocated than necessary to store the queue items, this is used as a marker. */
            qUINT8_t *writer;	            /*< Points to the free next place in the storage area. */
            qUINT8_t *reader;	            /*< Points to the last place that a queued item was read from. */
            volatile size_t ItemsWaiting;   /*< The number of items currently in the queue. */
            size_t ItemsCount;		        /*< The length of the queue defined as the number of items it will hold, not the number of bytes. */
            size_t ItemSize;		        /*< The size of each items that the queue will hold. */
        }qPrivate;
        /*! @endcond PRIVATE */
    }qQueue_t;

    /** @brief A macro directive to indicate whether the item in the queue should be sent to the back. */
    #define QUEUE_SEND_TO_BACK     ( 0u )

    /** @brief A macro directive to indicate whether the item in the queue should be sent to the front. */
    #define QUEUE_SEND_TO_FRONT    ( 1u )

    /** @brief A typedef to indicate the queue send mode : QUEUE_SEND_TO_BACK or QUEUE_SEND_TO_FRONT*/
    typedef qUINT8_t qQueue_Mode_t;

    /**
    * @brief Post an item to the back of the queue. The item is queued by copy, not by reference
    * @param obj A pointer to the Queue object
    * @param ItemToQueue A pointer to the item that is to be placed on the queue. The size of 
    * the items the queue will hold was defined when the queue was created, 
    * so this many bytes will be copied from ItemToQueue into the queue storage area.
    * @return qTrue on successful add, qFalse if not added.
    */      
    #define qQueue_SendToBack( obj, ItemToQueue )      qQueue_SendGeneric( (obj), (ItemToQueue), QUEUE_SEND_TO_BACK )

    /**
    * @brief Post an item to the back of the queue. The item is queued by copy, not by reference
    * @param obj A pointer to the Queue object
    * @param ItemToQueue A pointer to the item that is to be placed on the queue. The size of 
    * the items the queue will hold was defined when the queue was created, 
    * so this many bytes will be copied from ItemToQueue into the queue storage area.
    * @return qTrue on successful add, qFalse if not added.
    */     
    #define qQueue_Send( obj, ItemToQueue )            qQueue_SendGeneric( (obj), (ItemToQueue), QUEUE_SEND_TO_BACK )

    /**
    * @brief Post an item in the front of the queue. The item is queued by copy, not by reference.
    * @param obj A pointer to the Queue object
    * @param ItemToQueue A pointer to the item that is to be placed on the queue. The size of 
    * the items the queue will hold was defined when the queue was created, 
    * so this many bytes will be copied from ItemToQueue into the queue storage area.
    * @return qTrue on successful add, qFalse if not added.
    */         
    #define qQueue_SendToFront( obj, ItemToQueue )     qQueue_SendGeneric( (obj), (ItemToQueue), QUEUE_SEND_TO_FRONT )

    /**
    * @brief Check if the queue is already initialized by using qQueue_Setup API.
    * @param obj a pointer to the Queue object
    * @return qTrue if the queue is initialized, qFalse if not.
    */   
    qBool_t qQueue_IsReady( const qQueue_t * const obj );

    /**
    * @brief Configures a Queue. Here, the RAM used to hold the queue data <b>DataArea</b>
    * is statically allocated at compile time by the application writer.
    * @param obj A pointer to the Queue object
    * @param DataArea Data block or array of data.
    * @param ItemSize The size, in bytes, of one single item in the queue.
    * @param ItemsCount The maximum number of items the queue can hold.
    * @return qTrue on success, otherwise returns qFalse.
    */       
    qBool_t qQueue_Setup( qQueue_t * const obj, void* DataArea, size_t ItemSize, size_t ItemsCount );
   
    /**
    * @brief Resets a queue to its original empty state.
    * @param obj A pointer to the Queue object
    * @return none.
    */   
    void qQueue_Reset( qQueue_t * const obj );

    /**
    * @brief Returns the empty status of the Queue
    * @param obj A pointer to the Queue object
    * @return qTrue if the Queue is empty, qFalse if it is not.
    */       
    qBool_t qQueue_IsEmpty( const qQueue_t * const obj );

    /**
    * @brief Returns the number of items in the Queue
    * @param obj A pointer to the Queue object
    * @return The number of elements in the queue
    */     
    size_t qQueue_Count( const qQueue_t * const obj );

    /**
    * @brief Returns the number of available slots to hold items inside the Queue.
    * @param obj A pointer to the Queue object
    * @return The number of available slots in the queue.
    */      
    size_t qQueue_ItemsAvailable( const qQueue_t * const obj );

    /**
    * @brief Returns the full status of the Queue
    * @param obj A pointer to the Queue object
    * @return qTrue if the Queue is full, qFalse if it is not.
    */     
    qBool_t qQueue_IsFull( const qQueue_t * const obj );

    /**
    * @brief Looks at the data from the front of the Queue without removing it. 
    * @param obj A pointer to the Queue object
    * @return Pointer to the data, or NULL if there is nothing in the queue.
    */        
    void* qQueue_Peek( const qQueue_t * const obj );

    /**
    * @brief Remove the data located at the front of the Queue
    * @param obj A pointer to the Queue object
    * @return qTrue if data was removed from the Queue, otherwise returns qFalse
    */       
    qBool_t qQueue_RemoveFront( qQueue_t * const obj );

    /**
    * @brief Receive an item from a queue (and removes it). The item is received by copy so a 
    * buffer of adequate size must be provided. The number of bytes copied into the buffer 
    * was defined when the queue was created.
    * @param obj A pointer to the Queue object
    * @param dest Pointer to the buffer into which the received item will be copied.
    * @return qTrue if data was retrieved from the Queue, otherwise returns qFalse
    */         
    qBool_t qQueue_Receive( qQueue_t * const obj, void *dest );

    /**
    * @brief Post an item to the back of the queue. The item is queued by copy, not by reference
    * @param obj A pointer to the Queue object
    * @param ItemToQueue A pointer to the item that is to be placed on the queue. The size of 
    * the items the queue will hold was defined when the queue was created, 
    * so this many bytes will be copied from <b>ItemToQueue</b> into the queue storage
    * area.
    * @param InsertMode Can take the value QUEUE_SEND_TO_BACK to place the item at the back 
    * of the queue, or QUEUE_SEND_TO_FRONT to place the item at the front of 
    * the queue (for high priority messages).
    * @return qTrue on successful add, qFalse if not added
    */      
    qBool_t qQueue_SendGeneric( qQueue_t * const obj, void *ItemToQueue, qQueue_Mode_t InsertMode );
    
    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif 
