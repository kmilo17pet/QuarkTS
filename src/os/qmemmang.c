#include "qmemmang.h"

#if ( Q_MEMORY_MANAGER == 1)

typedef size_t qAddress_t;  /*restrict*/

static qUINT8_t DefaultHeap[ Q_DEFAULT_HEAP_SIZE ] = {0};
static qMemoryPool_t DefaultMemPool = {NULL, DefaultHeap, Q_DEFAULT_HEAP_SIZE, Q_DEFAULT_HEAP_SIZE, 0, {NULL, 0}};
static qMemoryPool_t *MemPool = &DefaultMemPool;

static void qHeapInit( void );
static void qInsertBlockIntoFreeList( qMemoryPool_t *pool, qMemBlockConnect_t *BlockToInsert );

static const size_t ByteAlignmentMask   = ((size_t)Q_BYTE_ALIGNMENT - (size_t)1);
static const size_t HeapStructSize	= ( ( sizeof( qMemBlockConnect_t ) + ( ( ( size_t ) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) - ( size_t ) 1 ) ) & ~( ( size_t ) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) );
/*============================================================================*/
/*qBool_t qMemoryPool_Init(qMemoryPool_t * const mPool, void* Area, size_t size)

Initializes a memory pool instance.
This function should be called once before any heap memory request.

Parameters:

    - mPool : A pointer to the memory pool instance
    - Area : A pointer to a memory block (uint8_t) statically allocated 
            to act as Heap of the memory pool. The size of this block
            should match the <size> argument.
    - size: The size of the memory block pointed by <Area>. 

Return value:

    qTrue on success, otherwise returns qFalse

*/
qBool_t qMemoryPool_Init(qMemoryPool_t * const mPool, void* Area, size_t size){
    qBool_t RetValue = qFalse;
    if( NULL != mPool ){
        mPool->Heap = Area; /* MISRAC2012-Rule-11.5 deviation allowed */
        mPool->HeapSize = size;
        mPool->End = NULL;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qMemoryPool_Select(qMemoryPool_t * const mPool)

Select the memory pool to perform heap memory requests with qMalloc and qFree.

Parameters:

    - mPool : A pointer to the memory pool instance

*/
void qMemoryPool_Select(qMemoryPool_t * const mPool){
    MemPool = mPool;
}
/*============================================================================*/
/*void qFree(void *ptr)

Deallocates the space previously allocated by qMalloc(). Deallocation will 
be performed in the selected memory pool.
If ptr is a null pointer, the function does nothing.
The behavior is undefined if selected memory pool has not been initialized.
The behavior is undefined if the value of ptr does not equal a value returned 
earlier by qMalloc.
The behavior is undefined if the memory area referred to by ptr has already been
deallocated, that is, qFree() has already been called with ptr as the argument 
and no calls to qMalloc() resulted in a pointer equal to ptr afterwards.
The behavior is undefined if after qFree() returns, an access is made through 
the pointer ptr.

Note: qFree its NOT interrupt-safe. 

Parameters:

    - ptr : Pointer to the memory to deallocate

*/
void qFree(void *ptr){
    qUINT8_t *pToFree;
    qMemBlockConnect_t *Connect;
    
    if( NULL == MemPool ){ /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    pToFree = (qUINT8_t*)ptr; /* MISRAC2012-Rule-11.5 deviation allowed */
    
    if( NULL != ptr){
        pToFree -= HeapStructSize; /* memory being freed will have an qMemBlockConnect_t immediately before it. */ /*MISRAC2004-17.4_a deviation allowed*/ /*MISRAC2012-Rule-18.4 allowed*/
        Connect = (qMemBlockConnect_t*)pToFree; /*MISRAC2012-Rule-11.3 allowed*/
        if( (size_t)0 != (Connect->BlockSize & MemPool->BlockAllocatedBit) ){
            Connect->BlockSize &= ~MemPool->BlockAllocatedBit; /* The block is being returned to the heap - it is no longer allocated. */
            MemPool->FreeBytesRemaining += Connect->BlockSize; /* Add this block to the list of free blocks. */
            qInsertBlockIntoFreeList( MemPool, Connect );
        }
    }
}
/*============================================================================*/
static void qHeapInit( void ){
    qMemBlockConnect_t *FirstFreeBlock;
    qUINT8_t *Aligned;
    qAddress_t Address, xAddrTmp;
    size_t TotalHeapSize;
    
    if( NULL == MemPool ){ /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    
    if( MemPool == &DefaultMemPool ){ /*initialize the default memory pool */
        (void)qMemoryPool_Init(MemPool, DefaultHeap, (size_t)Q_DEFAULT_HEAP_SIZE);
    }

    TotalHeapSize = MemPool->HeapSize;
    MemPool->Start.BlockSize = (size_t)0;
    MemPool->Start.Next = NULL;
    MemPool->FreeBytesRemaining = (size_t)0;
    
    Address = (qAddress_t)MemPool->Heap;
    if( 0uL != ( Address & ByteAlignmentMask ) ){
        Address += ( (size_t)Q_BYTE_ALIGNMENT - (size_t)1 );
        Address &= ~ByteAlignmentMask;
        TotalHeapSize -= Address - (qAddress_t)MemPool->Heap;
    }
    Aligned = (qUINT8_t*) Address;
    
    MemPool->Start.Next = ( void * ) Aligned; /* Start is used to hold a pointer to the first item in the list of free blocks*/ /* MISRAC2012-Rule-11.5 deviation allowed */
    MemPool->Start.BlockSize = (size_t)0;
    xAddrTmp = (qAddress_t)Aligned;
    Address = xAddrTmp + TotalHeapSize; /*MISRAC2004-17.4_a deviation allowed*/
    Address -= HeapStructSize;
    Address &= ~ByteAlignmentMask;
    
    MemPool->End = (qMemBlockConnect_t*) Address; /* End is used to mark the end of the list of free blocks and is inserted at the end of the heap space. */ /*MISRAC2012-Rule-11.6 allowed*/
    MemPool->End->Next = NULL;
    MemPool->End->BlockSize = (size_t)0;
    FirstFreeBlock = (void*) Aligned; /* To start with there is a single free block that is sized to take up the entire heap space, minus the space taken by End. */ /* MISRAC2012-Rule-11.5 deviation allowed */
    xAddrTmp = (qAddress_t)FirstFreeBlock;
    FirstFreeBlock->BlockSize = Address - xAddrTmp; /*MISRAC2004-17.4_a deviation allowed*/
    FirstFreeBlock->Next = MemPool->End;

    MemPool->FreeBytesRemaining = FirstFreeBlock->BlockSize;
    MemPool->BlockAllocatedBit = ( (size_t)1 ) << ( (sizeof(size_t)*(size_t)8) - (size_t)1 ); /* Work out the position of the top bit in a size_t variable. */
}
/*============================================================================*/
static void qInsertBlockIntoFreeList( qMemoryPool_t *pool, qMemBlockConnect_t *BlockToInsert ){
    qMemBlockConnect_t *Iterator;
    qUINT8_t *ptr;
    
    /* Iterate through the list until a block is found that has a higher address than the block being inserted. */
    for( Iterator = &pool->Start ; Iterator->Next < BlockToInsert ; Iterator = Iterator->Next ){}
    
    ptr = (qUINT8_t*) Iterator; /* Do the block being inserted, and the block it is being inserted after make a contiguous block of memory? */
    if( &ptr[ Iterator->BlockSize ] == (qUINT8_t*) BlockToInsert ){ /*check if the block that its being inserted after make a contiguous block of memory*/ /*MISRAC2004-17.4_a deviation allowed*/
	    Iterator->BlockSize += BlockToInsert->BlockSize;
	    BlockToInsert = Iterator;
    }
	
    ptr = (qUINT8_t*) BlockToInsert;
    if( &ptr[ BlockToInsert->BlockSize ] == (qUINT8_t*)Iterator->Next ){ /* check if the block being inserted, and the block it is being inserted before make a contiguous block of memory? */ /*MISRAC2004-17.4_a deviation allowed*/
        if( Iterator->Next != pool->End ){ 
            BlockToInsert->BlockSize += Iterator->Next->BlockSize; /* Form one big block from the two blocks. */
            BlockToInsert->Next = Iterator->Next->Next;
        }
        else{
            BlockToInsert->Next = MemPool->End;
        }
    }
    else{
        BlockToInsert->Next = Iterator->Next;
    }

    if( Iterator != BlockToInsert ){
	    Iterator->Next = BlockToInsert;
    }
}
/*============================================================================*/
/*void* qMalloc( size_t size )

Allocate a block of memory that is <size> bytes large. Allocation will be performed
in the selected memory pool. If the requested memory can be allocated, a pointer 
is returned to the beginning of the memory block.

The behavior is undefined if selected memory pool has not been initialized.

Note: qMalloc its NOT interrupt-safe. 

Parameters:

    - size : Size of the memory block in bytes.

Return value:

    If the request is successful then a pointer to the memory block is returned.
    If the function failed to allocate the requested block of memory, a NULL
    pointer is returned.
*/
void* qMalloc( size_t size ){
    const size_t MinBlockSize = ( ( sizeof( qMemBlockConnect_t ) + ( ( ( size_t ) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) - ( size_t ) 1 ) ) & ~( ( size_t ) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) )*(size_t)2;
    qMemBlockConnect_t *Block, *PreviousBlock, *NewBlockLink;
    void *Allocated = NULL;
    qUINT8_t *pBlockU8;
    
    if( NULL == MemPool ){ /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    
    if( NULL == MemPool->End ){ /*First call,*/
	    qHeapInit(); /*initialize the heap to setup the list of free blocks*/
    }
    if( ( size & MemPool->BlockAllocatedBit ) == (size_t)0 ){
	    if( size > (size_t)0 ){ /* The requested size is increased so it can contain a qMemBlockConnect_t in addition to the requested amount of bytes. */
            size += HeapStructSize;
            if( ( size & ByteAlignmentMask ) != 0x00u ){ /*Ensure blocks are always aligned to the required number of bytes. */
		        size += ( (size_t)Q_BYTE_ALIGNMENT - ( size & ByteAlignmentMask ) ); /* byte-alignment */
            }
	    }
        if( ( size > (size_t)0 ) && ( size <= MemPool->FreeBytesRemaining ) ){
            PreviousBlock = &MemPool->Start; /* check list from the start (lowest address) block until one of adequate size is found. */
            Block = MemPool->Start.Next;
            while( ( Block->BlockSize < size ) && ( Block->Next != NULL ) ){
                PreviousBlock = Block;
                Block = Block->Next;
            }
            if( Block != MemPool->End ){ /* If the end marker was reached then a block of adequate size was	not found. */
                /* Return the memory space pointed to - jumping over the qMemBlockConnect_t node at its start. */
                Allocated = (void*) ( ( (qUINT8_t*)PreviousBlock->Next ) + HeapStructSize ); /* This block is being returned for use so must be. */
                PreviousBlock->Next = Block->Next; /* Allocated must be removed from the list of free blocks  */
                if( ( Block->BlockSize - size ) > MinBlockSize ){ /* If the block is larger than required it can be split into two. */
                    pBlockU8 = (qUINT8_t*)Block;
                    NewBlockLink = (void*)&pBlockU8[ size ] ; /* Create a new block following the number of bytes requested. */ /*MISRAC2004-17.4_a deviation allowed*/ /* MISRAC2012-Rule-11.5 deviation allowed */
                    NewBlockLink->BlockSize = Block->BlockSize - size; /* compute the sizes of two blocks split from the single block. */
                    Block->BlockSize = size;
                    qInsertBlockIntoFreeList( MemPool, NewBlockLink ); /* Insert the new block into the list of free blocks. */
                }

                MemPool->FreeBytesRemaining -= Block->BlockSize;
                Block->BlockSize |= MemPool->BlockAllocatedBit; /* The block is being returned - it is allocated and owned by the application and has no "next" block*/
                Block->Next = NULL;
            }
        }
    }
    return Allocated;
}
/*============================================================================*/
/*size_t qHeapGetFreeSize(void)

Returns the total amount of heap space that remains unallocated for the selected
memory pool.

Return value:

    The size of the unallocated heap*

*/
size_t qHeapGetFreeSize( void ){
    size_t RetValue;
    
    if( NULL == MemPool ){ /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    RetValue = MemPool->HeapSize;
    
    if( NULL != MemPool->End ){
        RetValue =  MemPool->FreeBytesRemaining;
    }
    return RetValue;
}
/*============================================================================*/
#endif /* #if ( Q_MEMORY_MANAGER == 1) */