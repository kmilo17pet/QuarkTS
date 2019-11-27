/*This file is part of the QuarkTS distribution.*/
#ifndef  QLISTS_H
    #define QLISTS_H

    #include "qtypes.h"
    #include <string.h>

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef struct node_s{
        struct node_s *next, *prev; /*< Pointers to the adyacent nodes. */
    }qNode_t;

    #define qNode_MinimalFields     void *next, *prev
    #define qNode_MinimalMembers    qNode_MinimalFields                

    typedef struct{
        qNode_MinimalFields;        /*< to allow list of lists*/
        qNode_t *head, *tail;       /*< Pointers to the beginning of and the end of the list. */
        qSize_t size;               /*< Used to hold the current size of the list. */
    }qList_t;

    #define QLIST_INITIALIZER   { NULL, NULL, NULL, NULL, 0u }

    typedef enum{ qList_WalkInit, qList_WalkThrough, qList_WalkEnd }qList_WalkStage_t;
    #define QLIST_WALKINIT          ( qList_WalkInit ) 
    #define QLIST_WALKTHROUGH       ( qList_WalkThrough )
    #define QLIST_WALKEND           ( qList_WalkEnd )

    typedef qBool_t (*qListNodeFcn_t)(void *node, void *arg, qList_WalkStage_t stage );
    typedef enum{ qList_AtFront =-1 , qList_AtBack = 32766 }qListPosition_t;

    typedef void* (*qListMemAllocator_t)( size_t size );
    typedef void (*qListMemFree_t)(void *ptr);

    #define QLIST_ATFRONT           ( qList_AtFront )
    #define QLIST_ATBACK            ( qList_AtBack  )

    void qList_Initialize( qList_t * const list );
    qBool_t qList_Insert( qList_t * const list, void * const node, const qListPosition_t position );
    qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qListPosition_t position );
    void* qList_Remove( qList_t * const list, void * const node, const qListPosition_t position );
    qBool_t qList_IsMember( const qList_t * const list, const void * const node );
    void* qList_GetFront( const qList_t * const list );
    void* qList_GetBack( const qList_t * const list );
    qBool_t qList_IsEmpty( const qList_t * const list );
    qSize_t qList_Length( const qList_t * const list );
    qBool_t qList_Sort( qList_t * const list, qBool_t (*CompareFcn)(const void *n1, const void *n2) ) ;
    qBool_t qList_ForEach( qList_t *const list, qListNodeFcn_t Fcn, void *arg, qBool_t reverse);


    void qList_SetMemoryAllocation( qListMemAllocator_t mallocFcn, qListMemFree_t freeFcn );
    qBool_t qList_DInsert( qList_t *const list, void *data, qSize_t size, qListPosition_t position );
    void* qList_DRemove( qList_t * const list, void * const node, const qListPosition_t position );

    #ifdef __cplusplus
    }
    #endif

#endif 