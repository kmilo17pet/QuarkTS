/*This file is part of the QuarkTS distribution.*/
#ifndef  QLISTS_H
    #define QLISTS_H

    #include "qtypes.h"
    #include <string.h>

    #ifdef __cplusplus
    extern "C" {
    #endif


    #undef  QLIST_CHECK_NODE_MEMBERSHIP /*disabled for performance reasons*/
    #define QLIST_NODE_WITH_CONTAINER   /*used by the kernel for future features*/


    #ifdef QLIST_NODE_WITH_CONTAINER
        #define __qNodeMembers  *next, *prev, *container
    #else
        #define __qNodeMembers  *next, *prev
    #endif


    typedef struct node_s{
        struct node_s *next, *prev; /*< Pointers to the adyacent nodes. */
        #ifdef QLIST_NODE_WITH_CONTAINER
            void *container;
        #endif
    }qNode_t;

    #define qNode_MinimalFields     void __qNodeMembers
    #define qNode_MinimalMembers    qNode_MinimalFields

    typedef struct{
        qNode_MinimalFields;        /*< to allow list of lists*/
        qNode_t *head, *tail;       /*< Pointers to the beginning of and the end of the list. */
        size_t size;                /*< Used to hold the current size of the list. */
    }qList_t;

    #define QLIST_INITIALIZER   { NULL, NULL, NULL, NULL, 0u }

    typedef enum{ qList_WalkInit, qList_WalkThrough, qList_WalkEnd }qList_WalkStage_t;
    #define QLIST_WALKINIT          ( qList_WalkInit ) 
    #define QLIST_WALKTHROUGH       ( qList_WalkThrough )
    #define QLIST_WALKEND           ( qList_WalkEnd )

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
    qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qListPosition_t position );
    void* qList_Remove( qList_t * const list, void * const node, const qListPosition_t position );
    qBool_t qList_IsMember( qList_t * const list, void * const node );
    void* qList_GetFront( const qList_t * const list );
    void* qList_GetBack( const qList_t * const list );
    qBool_t qList_IsEmpty( const qList_t * const list );
    size_t qList_Length( const qList_t * const list );
    qBool_t qList_Sort( qList_t * const list, qBool_t (*CompareFcn)(const void *n1, const void *n2) ) ;


    qNode_t* __qNode_Backward( const qNode_t *const node ); /*This function are not intended for the user usage*/
    typedef qNode_t* (*qListDirection_t)( const qNode_t *const node );      
    #define QLIST_FORWARD   ( NULL )  
    #define QLIST_BACKWARD  ( __qNode_Backward )
    qBool_t qList_ForEach( qList_t *const list, const qListNodeFcn_t Fcn, void *arg, qListDirection_t dir );


    void qList_SetMemoryAllocation( qListMemAllocator_t mallocFcn, qListMemFree_t freeFcn );
    qBool_t qList_DInsert( qList_t *const list, void *data, size_t size, qListPosition_t position );
    void* qList_DRemove( qList_t * const list, void * const node, const qListPosition_t position );


    


    #ifdef __cplusplus
    }
    #endif

#endif 