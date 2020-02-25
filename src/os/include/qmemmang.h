/*This file is part of the QuarkTS distribution.*/
#ifndef QMEMMANG_H  
    #define  QMEMMANG_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    #if ( Q_MEMORY_MANAGER == 1)

    #ifndef Q_BYTE_ALIGNMENT    
        #define Q_BYTE_ALIGNMENT    ( 8 )
    #endif

    /* Linked list structure to connect the free blocks in order of their memory address. */
    typedef struct _qMemMang_BlockConnect_s{
        struct _qMemMang_BlockConnect_s *Next;      /*< used to point the next free block in the list*/
        size_t BlockSize;	                        /*< The size of the free block*/     
    }qMemMang_BlockConnect_t;

    typedef struct{
        /*This data should be handled only using the provided API*/
        struct _qMemMang_Pool_Private_s{
            qMemMang_BlockConnect_t *End;           /*< Points to the last block of the list. */
            qUINT8_t *Heap;                         /*< Points to the beginning of the heap area statically allocated. */
            size_t HeapSize;                        /*< The size of the memory block pinted by "heap". */
            size_t FreeBytesRemaining;              /*< The number of free bytes in the heap. */
            size_t BlockAllocatedBit;               /*< A bit that is set when the block belongs to the application. Clearead when the block is part of the free space (only the MSB is used) */    
            qMemMang_BlockConnect_t Start;          /*< The first block of the heap. */
        }qPrivate;
    }qMemMang_Pool_t;
    
    qBool_t qMemMang_Pool_Setup( qMemMang_Pool_t * const mPool, void* Area, size_t size );
    void qMemMang_Pool_Select( qMemMang_Pool_t * const mPool );
    size_t qMemMang_Get_FreeSize( qMemMang_Pool_t *mPool );    

    void* qMemMang_Allocate( qMemMang_Pool_t *mPool, size_t size );
    void qMemMang_Free( qMemMang_Pool_t *mPool, void *ptr );

    void* qMalloc( size_t size );
    void qFree(void *ptr);

    #endif

    #ifdef __cplusplus
    }
    #endif

#endif
