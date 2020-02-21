/*This file is part of the QuarkTS distribution.*/
#ifndef  QLISTS_H
    #define QLISTS_H

    #include "qtypes.h"
    #include <string.h>

    #ifdef __cplusplus
    extern "C" {
    #endif

    #define _qNodeMembers  *next, *prev, *container

    typedef struct _qList_Node_s{
        struct _qList_Node_s *next, *prev;  /*< Pointers to the adyacent nodes. */
        void *container;                    /*< Pointer to the container list*/
    }qList_Node_t;

    #define qNode_MinimalFields     void _qNodeMembers
    #define qNode_MinimalMembers    qNode_MinimalFields

    typedef struct{
        qNode_MinimalFields;        /*< to allow list of lists*/
        qList_Node_t *head, *tail;  /*< Pointers to the beginning of and the end of the list. */
        size_t size;                /*< Used to hold the current size of the list. */
    }qList_t;

    #define QLIST_INITIALIZER   { NULL, NULL, NULL, NULL, NULL, 0u }

    typedef enum{ qList_WalkInit, qList_WalkThrough, qList_WalkEnd }qList_WalkStage_t;
    #define QLIST_WALKINIT          ( qList_WalkInit )      /*< When the loop is about to start. In this case, A NULL value will be pased in the node pointer*/
    #define QLIST_WALKTHROUGH       ( qList_WalkThrough )   /*< When the loop is transversing the list.*/
    #define QLIST_WALKEND           ( qList_WalkEnd )       /*< When the loop has finished. In this case, A NULL value will be passed in the node pointer*/

    typedef qBool_t (*qList_NodeFcn_t)(void *node, void *arg, qList_WalkStage_t stage );
    typedef qINT32_t qList_Position_t;

    typedef void* (*qList_MemAllocator_t)( size_t size );
    typedef void (*qList_MemFree_t)(void *ptr);

    #define qList_AtFront           ((qList_Position_t)(-1))
    #define qList_AtBack            ((qList_Position_t)(2147483647))
    #define QLIST_ATFRONT           ( qList_AtFront )
    #define QLIST_ATBACK            ( qList_AtBack  )

    void qList_Initialize( qList_t * const list );
    qBool_t qList_Insert( qList_t * const list, void * const node, const qList_Position_t position );


    qBool_t qList_RemoveItself( void *const node );
    void* qList_Remove( qList_t * const list, void * const node, const qList_Position_t position );
    qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qList_Position_t position );
    qBool_t qList_IsMember( qList_t * const list, void * const node );
    void* qList_GetFront( const qList_t * const list );
    void* qList_GetBack( const qList_t * const list );
    qBool_t qList_IsEmpty( const qList_t * const list );
    size_t qList_Length( const qList_t * const list );
    qBool_t qList_Sort( qList_t * const list, qBool_t (*CompareFcn)(const void *n1, const void *n2) ) ;


    qList_Node_t* _qNode_Backward( const qList_Node_t *const node ); /*This function are not intended for the user usage*/
    qList_Node_t* _qNode_Forward( const qList_Node_t *const node ); /*This function are not intended for the user usage*/

    typedef qList_Node_t* (*qList_Direction_t)( const qList_Node_t *const node );      
    #define QLIST_FORWARD   ( _qNode_Forward  )  
    #define QLIST_BACKWARD  ( _qNode_Backward )
    
    typedef struct{
        qList_Node_t *next;
        qList_Direction_t direction;
    }qList_Iterator_t;

    qBool_t qList_IteratorSet( qList_Iterator_t *iterator, qList_t *const list, void *NodeOffset, qList_Direction_t dir);
    void* qList_IteratorGetNext( qList_Iterator_t *iterator );
    qBool_t qList_ForEach( qList_t *const list, const qList_NodeFcn_t Fcn, void *arg, qList_Direction_t dir, void *NodeOffset );
    qBool_t qList_Swap( void *node1, void *node2 );


    void qList_SetMemoryAllocation( qList_MemAllocator_t mallocFcn, qList_MemFree_t freeFcn );
    qBool_t qList_DInsert( qList_t *const list, void *data, size_t size, qList_Position_t position );
    void* qList_DRemove( qList_t * const list, void * const node, const qList_Position_t position );
    qBool_t qList_DRemoveItself( void * const node );

    #ifdef __cplusplus
    }
    #endif

#endif 
