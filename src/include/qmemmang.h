/*This file is part of the QuarkTS distribution.*/
#ifndef QMEMMANG_H  
    #define  QMEMMANG_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    #ifndef Q_BYTE_ALIGNMENT    
        #define Q_BYTE_ALIGNMENT    ( 8 )
    #endif

    /* Linked list structure to connect the free blocks in order of their memory address. */
    typedef struct qMemBlockConnect_s{
        struct qMemBlockConnect_s *Next;    /*< used to point the next free block in the list*/
        size_t BlockSize;	                /*< The size of the free block*/     
    }qMemBlockConnect_t;

    typedef struct{
        qMemBlockConnect_t *End;            /*< Points to the last block of the list. */
        qUINT8_t *Heap;                     /*< Points to the beginning of the heap area statically allocated. */
        size_t HeapSize;                    /*< The size of the memory block pinted by "heap". */
        size_t FreeBytesRemaining;          /*< The number of free bytes in the heap. */
        size_t BlockAllocatedBit;           /*< A bit that is set when the block belongs to the application. Clearead when the block is part of the free space (only the MSB is used) */    
        qMemBlockConnect_t Start;           /*< The first block of the heap. */
    }qMemoryPool_t;
    
    qBool_t qMemoryPool_Init( qMemoryPool_t * const mPool, void* Area, size_t size );
    void qMemoryPool_Select( qMemoryPool_t * const mPool );

    void* qMalloc(size_t size);
    void qFree(void *ptr);
    size_t qHeapGetFreeSize( void );    

    #ifdef __cplusplus
    }
    #endif

#endif 