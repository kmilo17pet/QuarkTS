#ifndef  QLISTS_H
    #define QLISTS_H

    #include "qtypes.h"

    typedef struct node_s{
        struct node_s *next, *prev;
    }qNode_t;

    typedef struct{
        qNode_t *head, *tail;
        qSize_t size;
    }qList_t;
    #define qNode_MinimalFields                  void *next, *prev, *data

    typedef void(*qListVisualizer_t)(void*);
    typedef enum{qList_AtFront =-1 , qList_AtBack = 32766}qListPosition_t;
    #define QLIST_ATFRONT             ( qList_AtFront )
    #define QLIST_ATBACK              ( qList_AtBack  )

    void qList_Initialize( qList_t *list );
    qBool_t qList_Insert( qList_t *list, void *node, qListPosition_t position );
    void* qList_Remove( qList_t *list, void *node, qListPosition_t position );
    qBool_t qList_IsMember( const qList_t *list, void *node );
    void qList_View( const qList_t *list, const qListVisualizer_t visualizer );
    void* qList_GetFront( const qList_t *list );
    void* qList_GetBack( const qList_t *list );
    qBool_t qList_IsEmpty( const qList_t *list );
    qSize_t qList_Length( const qList_t *list );


#endif 