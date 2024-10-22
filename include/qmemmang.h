/*!
 * @file qmemmang.h
 * @author J. Camilo Gomez C.
 * @version 2.09
 * @note This file is part of the QuarkTS distribution.
 * @brief API interface for the @ref q_memmang extension.
 **/
#ifndef QMEMMANG_H
    #define  QMEMMANG_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif


    #ifndef Q_MEMORY_MANAGER
        #define Q_MEMORY_MANAGER        ( 1 )
    #endif

    #if ( Q_MEMORY_MANAGER == 1 )

    #ifndef Q_BYTE_ALIGNMENT
        #define Q_BYTE_ALIGNMENT        ( 8 )
    #endif

    #ifndef Q_DEFAULT_HEAP_SIZE
        #define Q_DEFAULT_HEAP_SIZE     ( 512 )
    #endif

    #if ( Q_DEFAULT_HEAP_SIZE < 64 )
        #error Q_DEFAULT_HEAP_SIZE it is too small. Min(64).
    #endif

    #if ( ( Q_BYTE_ALIGNMENT != 1 ) && ( Q_BYTE_ALIGNMENT != 2 ) && ( Q_BYTE_ALIGNMENT != 4 ) && ( Q_BYTE_ALIGNMENT != 8 ) )
        #error Q_BYTE_ALIGNMENT value not allowed, use only 1,2,4 or 8(default).
    #endif


    /** @addtogroup qmemmang
    * @brief API interface for the @ref q_memmang extension.
    *  @{
    */

    /* List to connect the free blocks in order of their memory address. */
    /*! @cond  */
    typedef struct _qMemMang_BlockConnect_s { // skipcq: CXX-E2000
        struct _qMemMang_BlockConnect_s *next;  /*< Points to the next free block in the list*/
        size_t blockSize;                       /*< The size of the free block*/
    }
    qMemMang_BlockConnect_t;
    /*! @endcond  */

    /**
    * @brief A Memory Pool object
    * @details A memory pool its a special resource that allows memory blocks to
    * be dynamically allocated from a user-designated memory region. Instead of
    * typical pools with fixed-size block allocation, the pools in QuarkTS can
    * be of any size, thereby the user is responsible for selecting the
    * appropriate memory pool to allocate data with the same size.
    *
    * The default memory management unit resides in a memory pool object. Also
    * called the default-pool. The total amount of available heap space in the
    * default memory pool is set by @c Q_DEFAULT_HEAP_SIZE, which is defined in
    * @c qconfig.h.
    *
    * Besides the default pool, any number of additional memory pools can be
    * defined. Like any other object in QuarkTS, memory pools are referenced by
    * handles, a variable of type qMemMang_Pool_t and should be initialized
    * before use with the qMemMang_Pool_Setup() API.
    * @note Do not access any member of this structure directly.
    */
    typedef struct _qMemMang_Pool_s { // skipcq: CXX-E2000
        /*! @cond  */
        struct _qMemMang_Pool_Private_s { // skipcq: CXX-E2000
            qMemMang_BlockConnect_t *end;           /*< Points to the last block of the list. */
            qUINT8_t *poolMemory;                   /*< Points to the beginning of the heap area statically allocated. */
            size_t poolMemSize;                     /*< The size of the memory block pointed by "heap". */
            size_t freeBytesRemaining;              /*< The number of free bytes in the heap. */
            qMemMang_BlockConnect_t start;          /*< The first block of the heap. */
        }
        qPrivate;
        /*! @endcond  */
    }
    qMemMang_Pool_t;

    /**
    * @brief Initializes a memory pool instance. This function should be called
    * once before any heap memory request.
    * @param[in] mPool A pointer to the memory pool instance
    * @param[in] pArea A pointer to a memory block @c uint8_t statically
    * allocated to act as Heap of the memory pool. The size of this block should
    * match the @a pSize argument.
    * @param[in] pSize The size of the memory block pointed by @a pArea
    * @return Returns #qTrue on success, otherwise, returns #qFalse.
    */
    qBool_t qMemMang_Pool_Setup( qMemMang_Pool_t * const mPool,
                                 void* pArea,
                                 const size_t pSize );

    /**
    * @brief Select the memory pool to perform heap memory requests with
    * qMalloc() and qFree().
    * @param[in] mPool A pointer to the memory pool instance
    * @return #qTrue on success. Otherwise return #qFalse.
    */
    qBool_t qMemMang_Pool_Select( qMemMang_Pool_t * const mPool );

    /**
    * @brief Returns the total amount of heap space that remains unallocated for
    * the selected memory pool.
    * @param[in] mPool A pointer to the memory pool instance. Pass @c NULL to
    * select the default memory pool.
    * @return The size of the unallocated heap.
    */
    size_t qMemMang_Get_FreeSize( const qMemMang_Pool_t *mPool );

    /**
    * @brief Allocate a block of memory that is @a pSize bytes large. Allocation
    * will be performed in the selected memory pool. If the requested memory can
    * be allocated, a pointer is returned to the beginning of the memory block.
    * @attention qMemMang_Allocate() its NOT interrupt-safe.
    * @param[in] mPool A pointer to the memory pool instance.
    * @param[in] pSize Size of the memory block in bytes.
    * @return If the request is successful then a pointer to the memory block is
    * returned. If the function failed to allocate the requested block of memory
    * , a @c NULL pointer is returned.
    */
    void* qMemMang_Allocate( qMemMang_Pool_t *mPool,
                             size_t pSize );

    /**
    * @brief Deallocates previously allocated space from the memory pool.
    * If @a ptr is a @c NULL pointer, the function does nothing.
    * The behavior is undefined if selected memory pool has not been initialized.
    * The behavior is undefined if the value of ptr does not equal a value
    * returned earlier by qMalloc().
    * The behavior is undefined if the memory area referred to by @a ptr has
    * already been deallocated, that is, qFree() has already been called with
    * @a ptr as the argument and no calls to qMalloc() resulted in a pointer
    * equal to @a ptr afterwards. The behavior is undefined if after qFree()
    * returns, an access is made through the pointer @a ptr.
    * @attention qMemMang_Free() its NOT interrupt-safe.
    * @param[in] mPool A pointer to the memory pool instance.
    * @param[in] ptr to the memory to deallocate
    * @return #qTrue on success. Otherwise return #qFalse.
    */
    qBool_t qMemMang_Free( qMemMang_Pool_t *mPool,
                           void *ptr );

    /**
    * @brief Wrapper API for qMemMang_Allocate() in order to be compatible with
    * @c malloc(). Allocate a block of memory that is @a mSize bytes large.
    * Allocation will be performed in the selected memory pool. If the requested
    * memory can be allocated, a pointer is returned to the beginning of the
    * memory block.
    * @note The behavior is undefined if selected memory pool has not been
    * initialized.
    * @attention qMalloc() its NOT interrupt-safe.
    * @param[in] mSize Size of the memory block in bytes.
    * @return If the request is successful then a pointer to the memory block
    * is returned. If the function failed to allocate the requested block of
    * memory, a @c NULL pointer is returned.
    */
    void* qMalloc( size_t mSize );

    /**
    * @brief Wrapper API for qMemMang_Free() in order to be compatible with
    * @c free(). Deallocates the space previously allocated by qMalloc().
    * Deallocation will be performed in the selected memory pool.
    * If @a ptr is a null pointer, the function does nothing.
    * The behavior is undefined if selected memory pool has not been initialized.
    * The behavior is undefined if the value of @a ptr  does not equal a value
    * returned earlier by qMalloc().
    * The behavior is undefined if the memory area referred to by @a ptr has
    * already been deallocated, that is, qFree() has already been called with
    * @a ptr as the argument and no calls to qMalloc() resulted in a pointer
    * equal to @a ptr afterwards. The behavior is undefined if after qFree()
    * returns, an access is made through the pointer @a ptr.
    * @attention qFree() its NOT interrupt-safe.
    * @param[in] ptr to the memory to deallocate
    * @return none.
    */
    void qFree( void *ptr );

    /** @}*/

    #endif

    #ifdef __cplusplus
    }
    #endif

#endif
