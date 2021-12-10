/*!
 * @file qmemmang.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qmemmang.h"
#include "qflm.h"

#if ( Q_MEMORY_MANAGER == 1 )

typedef size_t qAddress_t;  /*restrict*/

#define BYTE_ALIGN_MASK     ( (size_t)Q_BYTE_ALIGNMENT - (size_t)1u )

static qUINT8_t defaultPoolMemory[ Q_DEFAULT_HEAP_SIZE ] = { 0 };
static qMemMang_Pool_t defaultMemPool = {
                                            {
                                                NULL,
                                                defaultPoolMemory,
                                                Q_DEFAULT_HEAP_SIZE,
                                                Q_DEFAULT_HEAP_SIZE,
                                                { NULL, 0 }
                                            }
                                        };
static qMemMang_Pool_t *selectedMemPool = &defaultMemPool;
static const size_t byteAlignmentMask = BYTE_ALIGN_MASK;
/*
The index of the bit that is set when a block belongs to the application.
Clearead when the block is part of the free space (only the MSB is used)
Work out the position of the top bit in a size_t variable.
*/
static const size_t blockAllocatedBit = (
                                            ( (size_t)1u ) <<
                                            (
                                                ( sizeof(size_t)*(size_t)8u ) -
                                                (size_t)1u
                                            )
                                        );
static const size_t heapStructSize = (
                                        (   sizeof(qMemMang_BlockConnect_t) +
                                            ( BYTE_ALIGN_MASK - (size_t)1u )
                                        )
                                        & ~BYTE_ALIGN_MASK
                                     );

static void qMemMang_HeapInit( qMemMang_Pool_t *mPool );
static void qMemMang_InsertBlockIntoFreeList( qMemMang_Pool_t *mPool,
                                              qMemMang_BlockConnect_t *xBlock );

/*============================================================================*/
qBool_t qMemMang_Pool_Setup( qMemMang_Pool_t * const mPool,
                             void* pArea,
                             const size_t pSize )
{
    qBool_t retValue = qFalse;

    if ( NULL != mPool ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        mPool->qPrivate.poolMemory = (qUINT8_t*)pArea; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        mPool->qPrivate.poolMemSize = pSize;
        mPool->qPrivate.end = NULL;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qMemMang_Pool_Select( qMemMang_Pool_t * const mPool )
{
    if ( NULL != mPool ) {
        selectedMemPool = mPool; /*select the default pool*/
    }
    else {
        selectedMemPool = &defaultMemPool;
    }

    return qTrue; /*only for API compatibility*/
}
/*============================================================================*/
void qFree( void *ptr )
{
    (void)qMemMang_Free( selectedMemPool, ptr );
}
/*============================================================================*/
qBool_t qMemMang_Free( qMemMang_Pool_t *mPool,
                       void *ptr )
{
    qBool_t retValue = qFalse;

    if ( NULL != mPool ) {
        /*cstat -MISRAC2012-Rule-18.4 -MISRAC2012-Rule-11.3 -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
        qUINT8_t *pToFree = (qUINT8_t*)ptr; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        if ( NULL != ptr ) {
            qMemMang_BlockConnect_t *xConnect;
            /*
            memory being freed will have an qMemBlockConnect_t immediately
            before it.
            */
            pToFree -= heapStructSize; /*MISRAC2004-17.4_a deviation allowed*/ /*MISRAC2012-Rule-18.4 allowed*/
            /*cstat -CERT-EXP36-C_a*/
            xConnect = (qMemMang_BlockConnect_t*)pToFree; /*MISRAC2012-Rule-11.3,CERT-EXP39-C_d,CERT-EXP36-C_a deviation allowed*/
            /*cstat +CERT-EXP36-C_a*/
            /*cstat +MISRAC2012-Rule-18.4 +MISRAC2012-Rule-11.3 +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
            if ( (size_t)0 != ( xConnect->blockSize & blockAllocatedBit ) ) {
                /*
                The block is being returned to the heap - it is no longer
                allocated.
                */
                qFLM_BitsClear( xConnect->blockSize, blockAllocatedBit );
                /* Add this block to the list of free blocks. */
                mPool->qPrivate.freeBytesRemaining += xConnect->blockSize;
                qMemMang_InsertBlockIntoFreeList( mPool, xConnect );
            }
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
static void qMemMang_HeapInit( qMemMang_Pool_t *mPool )
{
    qMemMang_BlockConnect_t *firstFreeBlock;
    qUINT8_t *aligned;
    qAddress_t address, xAddrTmp;
    size_t totalPoolSize = mPool->qPrivate.poolMemSize;

    if ( mPool == &defaultMemPool ) { /*initialize the default memory pool */
        (void)qMemMang_Pool_Setup( mPool,
                                   mPool->qPrivate.poolMemory,
                                   (size_t)Q_DEFAULT_HEAP_SIZE );
    }

    mPool->qPrivate.start.blockSize = (size_t)0u;
    mPool->qPrivate.start.next = NULL;
    mPool->qPrivate.freeBytesRemaining = (size_t)0u;
    /*cstat -MISRAC2012-Rule-11.4 -CERT-INT36-C -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    address = (qAddress_t)mPool->qPrivate.poolMemory; /*MISRAC2012-Rule-11.4,CERT-INT36-C deviation allowed*/
    if ( 0uL != ( address & byteAlignmentMask ) ) {
        address += byteAlignmentMask;
        address &= ~byteAlignmentMask;
        totalPoolSize -= address - (qAddress_t)mPool->qPrivate.poolMemory; /*MISRAC2012-Rule-11.4 deviation allowed*/
    }
    aligned = (qUINT8_t*)address; /*MISRAC2012-Rule-11.4 deviation allowed*/
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.3 -CERT-EXP36-C_a -CERT-EXP39-C_d*/
    /*
     Start is used to hold a pointer to the first item in the list of free
     blocks
    */
    mPool->qPrivate.start.next = ( qMemMang_BlockConnect_t* )aligned;  /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.3 +CERT-EXP36-C_a +CERT-EXP39-C_d*/
    mPool->qPrivate.start.blockSize = (size_t)0u;
    xAddrTmp = (qAddress_t)aligned; /*MISRAC2012-Rule-11.4 deviation allowed*/
    address = xAddrTmp + totalPoolSize; /*MISRAC2004-17.4_a deviation allowed*/
    address -= heapStructSize;
    address &= ~byteAlignmentMask;
    /*
    End is used to mark the end of the list of free blocks and is inserted at
    the end of the heap space.
    */
    mPool->qPrivate.end = (qMemMang_BlockConnect_t*)address; /*MISRAC2012-Rule-11.4 deviation allowed*/ /*MISRAC2012-Rule-11.6 allowed*/
    mPool->qPrivate.end->next = NULL;
    mPool->qPrivate.end->blockSize = (size_t)0u;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.3 -CERT-EXP36-C_a -CERT-EXP39-C_d*/
    /*
    To start with there is a single free block that is sized to take up the
    entire heap space, minus the space taken by End.
    */
    firstFreeBlock = (qMemMang_BlockConnect_t*)aligned; /* MISRAC2012-Rule-11.5 deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.3 +CERT-EXP36-C_a +CERT-EXP39-C_d*/
    xAddrTmp = (qAddress_t)firstFreeBlock; /*MISRAC2012-Rule-11.4 deviation allowed*/
    /*cstat +MISRAC2012-Rule-11.4 +CERT-INT36-C +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    firstFreeBlock->blockSize = address - xAddrTmp; /*MISRAC2004-17.4_a deviation allowed*/
    firstFreeBlock->next = mPool->qPrivate.end;
    mPool->qPrivate.freeBytesRemaining = firstFreeBlock->blockSize;
}
/*============================================================================*/
static void qMemMang_InsertBlockIntoFreeList( qMemMang_Pool_t *mPool,
                                              qMemMang_BlockConnect_t *xBlock )
{
    qMemMang_BlockConnect_t *iterator;
    qUINT8_t *ptr;

    /*
    Iterate through the list until a block is found that has a higher address
    than the block being inserted.
    */
    for ( iterator = &mPool->qPrivate.start ;
          iterator->next < xBlock ;
          iterator = iterator->next ) {}
    ptr = (qUINT8_t*)iterator;
    /*cstat -SEC-NULL-cmp-bef -PTR-null-cmp-bef -CERT-EXP34-C_g*/
    /*
    Do the block being inserted, and the block it is being inserted after
    make a contiguous block of memory?
    */
    if ( &ptr[ iterator->blockSize ] == (qUINT8_t*)xBlock ) { /*MISRAC2004-17.4_a deviation allowed*/
        iterator->blockSize += xBlock->blockSize; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
        xBlock = iterator;
    }
    ptr = (qUINT8_t*)xBlock;
    /*
    Check if the block being inserted, and the block it is being inserted before
    make a contiguous block of memory?
    */
    if ( &ptr[ xBlock->blockSize ] == (qUINT8_t*)iterator->next ) { /*MISRAC2004-17.4_a deviation allowed*/ /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
        if ( iterator->next != mPool->qPrivate.end ) {
            /* Form one big block from the two blocks. */
            xBlock->blockSize += iterator->next->blockSize; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
            xBlock->next = iterator->next->next; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
        }
        else {
            xBlock->next = mPool->qPrivate.end; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
        }
    }
    else {
        xBlock->next = iterator->next; /*PTR-null-cmp-bef,CERT-EXP34-C_g ok*/
    }
    /*cstat +SEC-NULL-cmp-bef +PTR-null-cmp-bef +CERT-EXP34-C_g*/
    if ( iterator != xBlock ) {
        iterator->next = xBlock;
    }
}
/*============================================================================*/
void* qMalloc( size_t mSize )
{
    return qMemMang_Allocate( selectedMemPool, mSize );
}
/*============================================================================*/
void* qMemMang_Allocate( qMemMang_Pool_t *mPool,
                         size_t pSize )
{
    void *pAllocated = NULL;

    if ( NULL != mPool ) {
        if ( NULL == mPool->qPrivate.end ) { /*First call,*/
            /*initialize the heap to setup the list of free blocks*/
            qMemMang_HeapInit( mPool );
        }
        if ( (size_t)0u == ( pSize & blockAllocatedBit ) ) {
            if ( pSize > (size_t)0 ) {
                /*
                The requested size is increased so it can contain a
                qMemBlockConnect_t in addition to the requested amount of bytes.
                */
                pSize += heapStructSize;
                /*Ensure blocks are always aligned to the required # of bytes. */
                if ( 0x00u != ( pSize & byteAlignmentMask ) ) {
                    pSize += ( (size_t)Q_BYTE_ALIGNMENT - ( pSize & byteAlignmentMask ) ); /* byte-alignment */
                }
            }
            if ( ( pSize > (size_t)0u ) && ( pSize <= mPool->qPrivate.freeBytesRemaining ) ) {
                qMemMang_BlockConnect_t *xBlock, *previousBlock, *newBlockLink;

                /*
                Check list from the start (lowest address) block until one of
                adequate size is found.
                */
                previousBlock = &mPool->qPrivate.start;
                xBlock = mPool->qPrivate.start.next;
                while ( ( xBlock->blockSize < pSize ) && ( NULL != xBlock->next ) ) {
                    previousBlock = xBlock;
                    xBlock = xBlock->next;
                }
                /*
                If the end marker was reached then a block of adequate size was
                not found.
                */
                if ( xBlock != mPool->qPrivate.end ) {
                    const size_t minBlockSize = heapStructSize*(size_t)2u;

                    /*
                    Return the memory space pointed to - jumping over the
                    qMemBlockConnect_t node at its start.
                    */
                    /* This block is being returned for use so must be. */
                    pAllocated = (void*)( ( (qUINT8_t*)previousBlock->next ) + heapStructSize );
                    /* Allocated must be removed from the list of free blocks*/
                    previousBlock->next = xBlock->next;
                    if ( ( xBlock->blockSize - pSize ) > minBlockSize ) {
                        /*
                        If the block is larger than required it can be split
                        into two.
                         */
                        qUINT8_t *pBlockU8 = (qUINT8_t*)xBlock;
                        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.3 -CERT-EXP36-C_a -CERT-EXP39-C_d*/
                        /*Create a new block following the # of bytes requested.*/
                        newBlockLink = (qMemMang_BlockConnect_t*)&pBlockU8[ pSize ];  /*MISRAC2004-17.4_a deviation allowed*/ /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
                        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.3 +CERT-EXP36-C_a +CERT-EXP39-C_d*/
                        /*compute the sizes of two blocks split from the single block.*/
                        newBlockLink->blockSize = xBlock->blockSize - pSize;
                        xBlock->blockSize = pSize;
                        /* Insert the new block into the list of free blocks. */
                        qMemMang_InsertBlockIntoFreeList( mPool, newBlockLink );
                    }
                    mPool->qPrivate.freeBytesRemaining -= xBlock->blockSize;
                    /*
                    The block is being returned - it is allocated and owned by
                    the application and has no "next" block
                    */
                    qFLM_BitsSet( xBlock->blockSize, blockAllocatedBit );
                    xBlock->next = NULL;
                }
            }
        }
    }

    return pAllocated;
}
/*============================================================================*/
size_t qMemMang_Get_FreeSize( qMemMang_Pool_t *mPool )
{
    size_t retValue;

    if ( NULL == mPool ) { /*use the default memory pool if select*/
        mPool = &defaultMemPool;
    }
    retValue = mPool->qPrivate.poolMemSize;
    if ( NULL != mPool->qPrivate.end ) {
        retValue =  mPool->qPrivate.freeBytesRemaining;
    }

    return retValue;
}
/*============================================================================*/

#endif /* #if ( Q_MEMORY_MANAGER == 1) */
