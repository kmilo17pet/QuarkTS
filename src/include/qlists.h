/*This file is part of the QuarkTS distribution.*/
#ifndef  QLISTS_H
    #define QLISTS_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef struct node_s{
        struct node_s *next, *prev;
    }qNode_t;

    typedef struct{
        qNode_t *head, *tail;   /*< Pointers to the beginning of and the end of the list. */
        qSize_t size;           /*< Used to hold the current size of the list. */
    }qList_t;
    #define qNode_MinimalFields                  void *next, *prev, *data

    typedef void(*qListVisualizer_t)(void* arg1);
    typedef enum{qList_AtFront =-1 , qList_AtBack = 32766}qListPosition_t;
    #define QLIST_ATFRONT             ( qList_AtFront )
    #define QLIST_ATBACK              ( qList_AtBack  )

    void qList_Initialize( qList_t * const list );
    qBool_t qList_Insert( qList_t * const list, void * const node, const qListPosition_t position );
    void* qList_Remove( qList_t * const list, void * const node, const qListPosition_t position );
    qBool_t qList_IsMember( const qList_t * const list, const void * const node );
    void qList_View( const qList_t * const list, const qListVisualizer_t visualizer );
    void* qList_GetFront( const qList_t * const list );
    void* qList_GetBack( const qList_t * const list );
    qBool_t qList_IsEmpty( const qList_t * const list );
    qSize_t qList_Length( const qList_t * const list );

    #ifdef __cplusplus
    }
    #endif

#endif 