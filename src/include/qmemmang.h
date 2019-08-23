#ifndef QMEMMANG_H  
    #define  QMEMMANG_H

    #include "qtypes.h"

    #ifndef Q_BYTE_ALIGNMENT    
        #define Q_BYTE_ALIGNMENT    ( 8 )
    #endif

    #ifdef __GNUC__
        #ifdef __x86_64__
            typedef uint64_t qAddress_t; 
        #else
            typedef uint32_t qAddress_t;
        #endif
    #else
        typedef uint32_t qAddress_t;
    #endif

    /* Linked list structure to connect the free blocks in order of their memory address. */
    typedef struct qMemBlockConnect_s{
        struct qMemBlockConnect_s *Next; /*used to point the next free block*/
        size_t BlockSize;	
    }qMemBlockConnect_t;

    typedef struct{
        qMemBlockConnect_t *End; 
        uint8_t *Heap;
        size_t HeapSize; 
        size_t FreeBytesRemaining;
        size_t BlockAllocatedBit;
        qMemBlockConnect_t Start;
    }qMemoryPool_t;
    
    qBool_t qMemoryPool_Init (qMemoryPool_t * const mPool, void* Area, size_t size );
    void qMemoryPool_Select( qMemoryPool_t * const mPool );

    void* qMalloc(size_t size);
    void qFree(void *ptr);
    size_t qHeapGetFreeSize( void );
    
    

#endif 