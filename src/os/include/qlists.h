/*This file is part of the QuarkTS distribution.*/
#ifndef  QLISTS_H
    #define QLISTS_H

    #include "qtypes.h"
    #include <string.h>

    #ifdef __cplusplus
    extern "C" {
    #endif

    #define __qNodeMembers  *next, *prev, *container

    typedef struct node_s{
        struct node_s *next, *prev; /*< Pointers to the adyacent nodes. */
        void *container;            /*< Pointer to the container list*/
    }qNode_t;

    #define qNode_MinimalFields     void __qNodeMembers
    #define qNode_MinimalMembers    qNode_MinimalFields

    typedef struct{
        qNode_MinimalFields;        /*< to allow list of lists*/
        qNode_t *head, *tail;       /*< Pointers to the beginning of and the end of the list. */
        size_t size;                /*< Used to hold the current size of the list. */
    }qList_t;

    #define QLIST_INITIALIZER   { NULL, NULL, NULL, NULL, NULL, 0u }

    typedef enum{ qList_WalkInit, qList_WalkThrough, qList_WalkEnd }qList_WalkStage_t;
    #define QLIST_WALKINIT          ( qList_WalkInit )      /*< When the loop is about to start. In this case, A NULL value will be pased in the node pointer*/
    #define QLIST_WALKTHROUGH       ( qList_WalkThrough )   /*< When the loop is transversing the list.*/
    #define QLIST_WALKEND           ( qList_WalkEnd )       /*< When the loop has finished. In this case, A NULL value will be passed in the node pointer*/

    typedef qBool_t (*qListNodeFcn_t)(void *node, void *arg, qList_WalkStage_t stage );
    typedef qINT32_t qListPosition_t;

    typedef void* (*qListMemAllocator_t)( size_t size );
    typedef void (*qListMemFree_t)(void *ptr);

    #define qList_AtFront           ((qListPosition_t)(-1))
    #define qList_AtBack            ((qListPosition_t)(2147483647))
    #define QLIST_ATFRONT           ( qList_AtFront )
    #define QLIST_ATBACK            ( qList_AtBack  )

    void qList_Initialize( qList_t * const list );
    qBool_t qList_Insert( qList_t * const list, void * const node, const qListPosition_t position );


    qBool_t qList_RemoveItself( void *const node );
    void* qList_Remove( qList_t * const list, void * const node, const qListPosition_t position );
    qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qListPosition_t position );
    qBool_t qList_IsMember( qList_t * const list, void * const node );
    void* qList_GetFront( const qList_t * const list );
    void* qList_GetBack( const qList_t * const list );
    qBool_t qList_IsEmpty( const qList_t * const list );
    size_t qList_Length( const qList_t * const list );
    qBool_t qList_Sort( qList_t * const list, qBool_t (*CompareFcn)(const void *n1, const void *n2) ) ;


    qNode_t* __qNode_Backward( const qNode_t *const node ); /*This function are not intended for the user usage*/
    qNode_t* __qNode_Forward( const qNode_t *const node ); /*This function are not intended for the user usage*/

    typedef qNode_t* (*qListDirection_t)( const qNode_t *const node );      
    #define QLIST_FORWARD   ( __qNode_Forward  )  
    #define QLIST_BACKWARD  ( __qNode_Backward )
    
    typedef struct{
        qNode_t *next;
        qListDirection_t direction;
    }qListIterator_t;

    qBool_t qList_IteratorSet( qListIterator_t *iterator, qList_t *const list, void *NodeOffset, qListDirection_t dir);
    void* qList_IteratorGetNext( qListIterator_t *iterator );
    
    qBool_t qList_ForEach( qList_t *const list, const qListNodeFcn_t Fcn, void *arg, qListDirection_t dir, void *NodeOffset );

    qBool_t qList_Swap( void *node1, void *node2 );


    void qList_SetMemoryAllocation( qListMemAllocator_t mallocFcn, qListMemFree_t freeFcn );
    qBool_t qList_DInsert( qList_t *const list, void *data, size_t size, qListPosition_t position );
    void* qList_DRemove( qList_t * const list, void * const node, const qListPosition_t position );
    qBool_t qList_DRemoveItself( void * const node );

    #ifdef __cplusplus
    }
    #endif

#endif 