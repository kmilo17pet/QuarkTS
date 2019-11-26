/*This file is part of the QuarkTS distribution.*/
#ifndef  QLISTS_H
    #define QLISTS_H

    #include "qtypes.h"

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

    typedef qBool_t (*qListNodeFcn_t)(void *node, void *arg );
    typedef enum{ qList_AtFront =-1 , qList_AtBack = 32766 }qListPosition_t;
    
    #define QLIST_ATFRONT           ( qList_AtFront )
    #define QLIST_ATBACK            ( qList_AtBack  )

    void qList_Initialize( qList_t * const list );
    qBool_t qList_Insert( qList_t * const list, void * const node, const qListPosition_t position );
    qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qListPosition_t position );
    void* qList_Remove( qList_t * const list, void * const node, const qListPosition_t position );
    qBool_t qList_IsMember( const qList_t * const list, const void * const node );
    void qList_View( qList_t * const list, const qListNodeFcn_t visualizer );
    void* qList_GetFront( const qList_t * const list );
    void* qList_GetBack( const qList_t * const list );
    qBool_t qList_IsEmpty( const qList_t * const list );
    qSize_t qList_Length( const qList_t * const list );
    qBool_t qList_Sort( qList_t * const list, qBool_t (*CompareFcn)(const void *n1, const void *n2) ) ;
    qBool_t qList_ForEach( qList_t *const list, qListNodeFcn_t Fcn, void *arg, qBool_t reverse);


    #ifdef __cplusplus
    }
    #endif

#endif 