/*!
 * @file qqueues.h
 * @author J. Camilo Gomez C.
 * @version 2.07
 * @note This file is part of the QuarkTS distribution.
 * @brief API interface to create and handle @ref q_queues.
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

    /** @addtogroup qqueues
    * @brief API interface to create and handle @ref  q_queues.
    * @{
    */

    /**
    * @brief A Queue object
    * @details A queue is a linear data structure with simple operations based
    * on the FIFO (First In First Out) principle. It is capable to hold a finite
    * number of fixed-size data items. The maximum number of items that a queue
    * can hold is called its length. Both the length and the size of each data
    * item are set when the queue is created.
    *
    * In general, this kind of data structure is used to serialize data between
    * tasks, allowing some elasticity in time. In many cases, the queue is used
    * as a data buffer in interrupt service routines. This buffer will collect
    * the data so, at some later time, another task can fetch the data for
    * further processing. This use case is the single "task to task" buffering
    * case. There are also other applications for queues as serializing  many
    * data streams into one receiving streams (multiple tasks to a single task)
    * or vice-versa (single task to multiple tasks).
    *
    * These objects are referenced by handles, which are variables of type
    * qQueue_t. The qQueue_Setup() API function configures the queue and
    * initialize the instance.
    * The required RAM for the queue data should be provided by the application
    * writer and could be statically allocated at compile time or in run-time
    * using the memory management extension.
    * @note Do not access any member of this structure directly.
    */
    typedef struct _qQueue_s { // skipcq: CXX-E2000
        /*! @cond  */
        struct _qQueue_Private_s { // skipcq: CXX-E2000
            qUINT8_t *head;                 /*< Points to the beginning of the queue storage area. */
            qUINT8_t *tail;                 /*< Points to the byte at the end of the queue storage area.  Once more byte is allocated than necessary to store the queue items, this is used as a marker. */
            qUINT8_t *writer;               /*< Points to the free next place in the storage area. */
            qUINT8_t *reader;               /*< Points to the last place that a queued item was read from. */
            volatile size_t itemsWaiting;   /*< The number of items currently in the queue. */
            size_t itemsCount;              /*< The length of the queue defined as the number of items it will hold, not the number of bytes. */
            size_t itemSize;                /*< The size of each items that the queue will hold. */
        }
        qPrivate;
        /*! @endcond  */
    }
    qQueue_t;

    /** @brief A macro directive to indicate whether the item in the queue
     * should be sent to the back. */
    #define QUEUE_SEND_TO_BACK     ( 0U )

    /** @brief A macro directive to indicate whether the item in the queue
     * should be sent to the front. */
    #define QUEUE_SEND_TO_FRONT    ( 1U )

    /** @brief A typedef to indicate the queue send mode : #QUEUE_SEND_TO_BACK
     * or #QUEUE_SEND_TO_FRONT*/
    typedef qUINT8_t qQueue_InsertMode_t;

    /**
    * @brief Check if the queue is already initialized by using qQueue_Setup()
    * API.
    * @param[in] q A pointer to the Queue object
    * @return #qTrue if the queue is initialized, #qFalse if not.
    */
    qBool_t qQueue_IsReady( const qQueue_t * const q );

    /**
    * @brief Configures a Queue. Here, the RAM used to hold the queue data
    * @a pData is statically allocated at compile time by the application writer.
    * @param[in] q A pointer to the Queue object
    * @param[in] pData Data block or array of data.
    * @param[in] itemSize The size, in bytes, of one single item in the queue.
    * @param[in] itemsCount The maximum number of items the queue can hold.
    * @return #qTrue on success, otherwise returns #qFalse.
    */
    qBool_t qQueue_Setup( qQueue_t * const q,
                          void* pData,
                          const size_t itemSize,
                          const size_t itemsCount );

    /**
    * @brief Resets a queue to its original empty state.
    * @param[in] q A pointer to the Queue object
    * @return #qTrue on success, otherwise returns #qFalse.
    */
    qBool_t qQueue_Reset( qQueue_t * const q );

    /**
    * @brief Returns the empty status of the Queue
    * @param[in] q A pointer to the Queue object
    * @return #qTrue if the Queue is empty, #qFalse if it is not.
    */
    qBool_t qQueue_IsEmpty( const qQueue_t * const q );

    /**
    * @brief Returns the number of items in the Queue
    * @param[in] q A pointer to the Queue object
    * @return The number of elements in the queue
    */
    size_t qQueue_Count( const qQueue_t * const q );

    /**
    * @brief Returns the number of available slots to hold items inside the
    * queue.
    * @param[in] q A pointer to the Queue object
    * @return The number of available slots in the queue.
    */
    size_t qQueue_ItemsAvailable( const qQueue_t * const q );

    /**
    * @brief Returns the full status of the Queue
    * @param[in] q A pointer to the Queue object
    * @return #qTrue if the Queue is full, #qFalse if it is not.
    */
    qBool_t qQueue_IsFull( const qQueue_t * const q );

    /**
    * @brief Looks at the data from the front of the Queue without removing it.
    * @param[in] q A pointer to the Queue object
    * @return Pointer to the data, or @c NULL if there is nothing in the queue.
    */
    void* qQueue_Peek( const qQueue_t * const q );

    /**
    * @brief Remove the data located at the front of the Queue
    * @param[in] q A pointer to the Queue object
    * @return #qTrue if data was removed from the Queue, otherwise returns
    * #qFalse
    */
    qBool_t qQueue_RemoveFront( qQueue_t * const q );

    /**
    * @brief Receive an item from a queue (and removes it). The item is received
    * by copy so a buffer of adequate size must be provided. The number of bytes
    * copied into the buffer was defined when the queue was created.
    * @param[in] q A pointer to the Queue object
    * @param[out] dst Pointer to the buffer into which the received item will
    * be copied.
    * @return #qTrue if data was retrieved from the Queue, otherwise returns
    * #qFalse
    */
    qBool_t qQueue_Receive( qQueue_t * const q,
                            void *dst );

    /**
    * @brief Post an item to the the queue. The item is queued by copy, not by
    * reference
    * @param[in] q A pointer to the Queue object
    * @param[in] itemToQueue A pointer to the item that is to be placed on the
    * queue. The size of the items the queue will hold was defined when the
    * queue was created, so this many bytes will be copied from @a itemToQueue
    * into the queue storage area.
    * @param[in] pos Can take the value #QUEUE_SEND_TO_BACK to place the
    * item at the back of the queue, or #QUEUE_SEND_TO_FRONT to place the item
    * at the front of the queue (for high priority messages).
    * @return #qTrue on successful add, #qFalse if not added
    */
    qBool_t qQueue_Send( qQueue_t * const q,
                         void *itemToQueue,
                         const qQueue_InsertMode_t pos );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
