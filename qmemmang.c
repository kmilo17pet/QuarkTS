/*!
 * @file qmemmang.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qmemmang.h"

#if ( Q_MEMORY_MANAGER == 1)

typedef size_t qAddress_t;  /*restrict*/

/*cstat -MISRAC2012-Rule-8.9_b*/
static qUINT8_t DefaultPoolMemory[ Q_DEFAULT_HEAP_SIZE ] = {0}; /*MISRAC2012-Rule-8.9_b deviation allowed, required for <DefaultMemPool>*/
/*cstat +MISRAC2012-Rule-8.9_b*/
static qMemMang_Pool_t DefaultMemPool = { {NULL, DefaultPoolMemory, Q_DEFAULT_HEAP_SIZE, Q_DEFAULT_HEAP_SIZE, 0, {NULL, 0} } };
static qMemMang_Pool_t *Selected_MemPool = &DefaultMemPool;
static const size_t ByteAlignmentMask   = ( (size_t)Q_BYTE_ALIGNMENT - (size_t)1 );
static const size_t HeapStructSize	= ( ( sizeof( qMemMang_BlockConnect_t ) + ( ( (size_t)( (size_t)Q_BYTE_ALIGNMENT - (size_t)1 ) ) - (size_t)1 ) ) 
                                        & ~( (size_t)( (size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) );

static void qMemMang_HeapInit( qMemMang_Pool_t *mPool );
static void qMemMang_InsertBlockIntoFreeList( qMemMang_Pool_t *mPool, qMemMang_BlockConnect_t *BlockToInsert );

/*============================================================================*/
qBool_t qMemMang_Pool_Setup( qMemMang_Pool_t * const mPool, void* Area, size_t Size ){
    qBool_t RetValue = qFalse;

    if( NULL != mPool ){
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        mPool->qPrivate.PoolMemory = (qUINT8_t*)Area; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        mPool->qPrivate.PoolMemSize = Size;
        mPool->qPrivate.End = NULL;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
void qMemMang_Pool_Select( qMemMang_Pool_t * const mPool ){
    if( NULL != mPool ){ 
        Selected_MemPool = mPool; /*select the default pool*/
    }
    else{
        Selected_MemPool = &DefaultMemPool;
    }
}
/*============================================================================*/
void qFree( void *ptr ){
    qMemMang_Free( Selected_MemPool, ptr );
}
/*============================================================================*/
void qMemMang_Free( qMemMang_Pool_t *mPool, void *ptr ){
    if( NULL != mPool ){
        /*cstat -MISRAC2012-Rule-18.4 -MISRAC2012-Rule-11.3 -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/ 
        qUINT8_t *pToFree = (qUINT8_t*)ptr; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        if( NULL != ptr ){
            qMemMang_BlockConnect_t *Connect;

            pToFree -= HeapStructSize; /* memory being freed will have an qMemBlockConnect_t immediately before it. */ /*MISRAC2004-17.4_a deviation allowed*/ /*MISRAC2012-Rule-18.4 allowed*/
            /*cstat -CERT-EXP36-C_a*/
            Connect = (qMemMang_BlockConnect_t*)pToFree; /*MISRAC2012-Rule-11.3,CERT-EXP39-C_d,CERT-EXP36-C_a deviation allowed*/
            /*cstat +CERT-EXP36-C_a*/
            /*cstat +MISRAC2012-Rule-18.4 +MISRAC2012-Rule-11.3 +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
            if( (size_t)0 != ( Connect->BlockSize & mPool->qPrivate.BlockAllocatedBit ) ){
                Connect->BlockSize &= ~mPool->qPrivate.BlockAllocatedBit; /* The block is being returned to the heap - it is no longer allocated. */
                mPool->qPrivate.FreeBytesRemaining += Connect->BlockSize; /* Add this block to the list of free blocks. */
                qMemMang_InsertBlockIntoFreeList( mPool, Connect );
            }
        }
    }
}
/*============================================================================*/
static void qMemMang_HeapInit( qMemMang_Pool_t *mPool ){
    qMemMang_BlockConnect_t *FirstFreeBlock;
    qUINT8_t *Aligned;
    qAddress_t Address, xAddrTmp;
    size_t TotalPoolSize = mPool->qPrivate.PoolMemSize;
       
    if( mPool == &DefaultMemPool ){ /*initialize the default memory pool */
        (void)qMemMang_Pool_Setup( mPool, DefaultPoolMemory, (size_t)Q_DEFAULT_HEAP_SIZE );
    }

    mPool->qPrivate.Start.BlockSize = (size_t)0;
    mPool->qPrivate.Start.Next = NULL;
    mPool->qPrivate.FreeBytesRemaining = (size_t)0;
    /*cstat -MISRAC2012-Rule-11.4 -CERT-INT36-C -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    Address = (qAddress_t)mPool->qPrivate.PoolMemory; /*MISRAC2012-Rule-11.4,CERT-INT36-C deviation allowed*/
    if( 0uL != ( Address & ByteAlignmentMask ) ){
        Address += ( (size_t)Q_BYTE_ALIGNMENT - (size_t)1 );
        Address &= ~ByteAlignmentMask;
        TotalPoolSize -= Address - (qAddress_t)mPool->qPrivate.PoolMemory; /*MISRAC2012-Rule-11.4 deviation allowed*/
    }
    Aligned = (qUINT8_t*)Address; /*MISRAC2012-Rule-11.4 deviation allowed*/
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.3 -CERT-EXP36-C_a -CERT-EXP39-C_d*/
    mPool->qPrivate.Start.Next = ( qMemMang_BlockConnect_t* )Aligned; /* Start is used to hold a pointer to the first item in the list of free blocks*/ /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.3 +CERT-EXP36-C_a +CERT-EXP39-C_d*/
    mPool->qPrivate.Start.BlockSize = (size_t)0;
    xAddrTmp = (qAddress_t)Aligned; /*MISRAC2012-Rule-11.4 deviation allowed*/
    Address = xAddrTmp + TotalPoolSize; /*MISRAC2004-17.4_a deviation allowed*/
    Address -= HeapStructSize;
    Address &= ~ByteAlignmentMask;
    
    mPool->qPrivate.End = (qMemMang_BlockConnect_t*)Address; /* End is used to mark the end of the list of free blocks and is inserted at the end of the heap space. */ /*MISRAC2012-Rule-11.4 deviation allowed*/ /*MISRAC2012-Rule-11.6 allowed*/ 
    mPool->qPrivate.End->Next = NULL;
    mPool->qPrivate.End->BlockSize = (size_t)0;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.3 -CERT-EXP36-C_a -CERT-EXP39-C_d*/
    FirstFreeBlock = (qMemMang_BlockConnect_t*)Aligned; /* To start with there is a single free block that is sized to take up the entire heap space, minus the space taken by End. */ /* MISRAC2012-Rule-11.5 deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.3 +CERT-EXP36-C_a +CERT-EXP39-C_d*/
    xAddrTmp = (qAddress_t)FirstFreeBlock; /*MISRAC2012-Rule-11.4 deviation allowed*/
    /*cstat +MISRAC2012-Rule-11.4 +CERT-INT36-C +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    FirstFreeBlock->BlockSize = Address - xAddrTmp; /*MISRAC2004-17.4_a deviation allowed*/
    FirstFreeBlock->Next = mPool->qPrivate.End;

    mPool->qPrivate.FreeBytesRemaining = FirstFreeBlock->BlockSize;
    mPool->qPrivate.BlockAllocatedBit = ( (size_t)1 ) << ( (sizeof(size_t)*(size_t)8) - (size_t)1 ); /* Work out the position of the top bit in a size_t variable. */
}
/*============================================================================*/
static void qMemMang_InsertBlockIntoFreeList( qMemMang_Pool_t *mPool, qMemMang_BlockConnect_t *BlockToInsert ){
    qMemMang_BlockConnect_t *Iterator;
    qUINT8_t *ptr;
    
    /* Iterate through the list until a block is found that has a higher address than the block being inserted. */
    for( Iterator = &mPool->qPrivate.Start ; Iterator->Next < BlockToInsert ; Iterator = Iterator->Next ){}
    ptr = (qUINT8_t*) Iterator; /* Do the block being inserted, and the block it is being inserted after make a contiguous block of memory? */
    /*cstat -SEC-NULL-cmp-bef -PTR-null-cmp-bef -CERT-EXP34-C_g*/
    if( &ptr[ Iterator->BlockSize ] == (qUINT8_t*)BlockToInsert ){ /*check if the block that its being inserted after make a contiguous block of memory*/ /*MISRAC2004-17.4_a deviation allowed*/
	    Iterator->BlockSize += BlockToInsert->BlockSize; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
	    BlockToInsert = Iterator;
    }
    ptr = (qUINT8_t*)BlockToInsert;
    if( &ptr[ BlockToInsert->BlockSize ] == (qUINT8_t*)Iterator->Next ){ /* check if the block being inserted, and the block it is being inserted before make a contiguous block of memory? */ /*MISRAC2004-17.4_a deviation allowed*/ /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
        if( Iterator->Next != mPool->qPrivate.End ){ 
            BlockToInsert->BlockSize += Iterator->Next->BlockSize; /* Form one big block from the two blocks. */ /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
            BlockToInsert->Next = Iterator->Next->Next; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
        }
        else{
            BlockToInsert->Next = mPool->qPrivate.End; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
        }
    }
    else{
        BlockToInsert->Next = Iterator->Next; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
    }
    /*cstat +SEC-NULL-cmp-bef +PTR-null-cmp-bef +CERT-EXP34-C_g*/
    if( Iterator != BlockToInsert ){
	    Iterator->Next = BlockToInsert;
    }
}
/*============================================================================*/
void* qMalloc( size_t Size ){
    return qMemMang_Allocate( Selected_MemPool, Size );
}
/*============================================================================*/
void* qMemMang_Allocate( qMemMang_Pool_t *mPool, size_t Size ){
    void *Allocated = NULL;
    
    if( NULL != mPool ){
        if( NULL == mPool->qPrivate.End ){ /*First call,*/
            qMemMang_HeapInit( mPool ); /*initialize the heap to setup the list of free blocks*/
        }
        if( (size_t)0 == ( Size & mPool->qPrivate.BlockAllocatedBit ) ){
            if( Size > (size_t)0 ){ /* The requested size is increased so it can contain a qMemBlockConnect_t in addition to the requested amount of bytes. */
                Size += HeapStructSize;
                if( 0x00u != ( Size & ByteAlignmentMask ) ){ /*Ensure blocks are always aligned to the required number of bytes. */
                    Size += ( (size_t)Q_BYTE_ALIGNMENT - ( Size & ByteAlignmentMask ) ); /* byte-alignment */
                }
            }
            if( ( Size > (size_t)0 ) && ( Size <= mPool->qPrivate.FreeBytesRemaining ) ){
                qMemMang_BlockConnect_t *Block, *PreviousBlock, *NewBlockLink;

                PreviousBlock = &mPool->qPrivate.Start; /* check list from the start (lowest address) block until one of adequate size is found. */
                Block = mPool->qPrivate.Start.Next;
                while( ( Block->BlockSize < Size ) && ( NULL != Block->Next ) ){
                    PreviousBlock = Block;
                    Block = Block->Next;
                }
                if( Block != mPool->qPrivate.End ){ /* If the end marker was reached then a block of adequate size was not found. */
                    const size_t MinBlockSize = ( ( sizeof( qMemMang_BlockConnect_t ) + ( ( (size_t) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) - (size_t)1 ) ) 
                                                & ~( (size_t) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) )*(size_t)2;
    

                    /* Return the memory space pointed to - jumping over the qMemBlockConnect_t node at its start. */
                    Allocated = (void*)( ( (qUINT8_t*)PreviousBlock->Next ) + HeapStructSize ); /* This block is being returned for use so must be. */
                    PreviousBlock->Next = Block->Next; /* Allocated must be removed from the list of free blocks  */
                    if( ( Block->BlockSize - Size ) > MinBlockSize ){ /* If the block is larger than required it can be split into two. */
                        qUINT8_t *pBlockU8 = (qUINT8_t*)Block;
                        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.3 -CERT-EXP36-C_a -CERT-EXP39-C_d*/
                        NewBlockLink = (qMemMang_BlockConnect_t*)&pBlockU8[ Size ] ; /* Create a new block following the number of bytes requested. */ /*MISRAC2004-17.4_a deviation allowed*/ /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
                        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.3 +CERT-EXP36-C_a +CERT-EXP39-C_d*/
                        NewBlockLink->BlockSize = Block->BlockSize - Size; /* compute the sizes of two blocks split from the single block. */
                        Block->BlockSize = Size;
                        qMemMang_InsertBlockIntoFreeList( mPool, NewBlockLink ); /* Insert the new block into the list of free blocks. */
                    }
                    mPool->qPrivate.FreeBytesRemaining -= Block->BlockSize;
                    Block->BlockSize |= mPool->qPrivate.BlockAllocatedBit; /* The block is being returned - it is allocated and owned by the application and has no "next" block*/
                    Block->Next = NULL;
                }
            }
        }
    }
    return Allocated;
}
/*============================================================================*/
size_t qMemMang_Get_FreeSize( qMemMang_Pool_t *mPool ){
    size_t RetValue;
    
    if( NULL == mPool ){ /*use the default memory pool if select*/
        mPool = &DefaultMemPool;
    }
    RetValue = mPool->qPrivate.PoolMemSize;   
    if( NULL != mPool->qPrivate.End ){
        RetValue =  mPool->qPrivate.FreeBytesRemaining;
    }
    return RetValue;
}
/*============================================================================*/

#endif /* #if ( Q_MEMORY_MANAGER == 1) */
