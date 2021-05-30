/*!
 * @file qlists.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qlists.h"

static qList_Node_t* qList_NodeInit( void * const node );
static void qList_InsertAtFront( qList_t * const list, qList_Node_t * const node );
static void qList_InserAtBack( qList_t * const list, qList_Node_t * const node );
static qList_Node_t* qList_RemoveFront( qList_t * const list );
static qList_Node_t* qList_RemoveBack( qList_t * const list );
static qList_Node_t* qList_GetiNode( const qList_t *const list, const qList_Position_t position );
static qBool_t qList_ChangeContainer( qList_ForEachHandle_t h );
static void qList_GivenNodes_SwapBoundaries( qList_Node_t *n1, qList_Node_t *n2 );
static void qList_GivenNodes_SwapAdjacent( qList_Node_t *n1, qList_Node_t *n2 );
static void qList_GivenNodes_UpdateOuterLinks( qList_Node_t *n1, qList_Node_t *n2 );


#ifdef QLIST_D_HANDLING  /*use only if strictly necessary*/
static qList_MemAllocator_t qListMalloc = NULL; 
static qList_MemFree_t qListFree = NULL; 
#endif

/*============================================================================*/
void qList_Initialize( qList_t * const list ){
    if( NULL != list ){
        list->head = NULL;
        list->tail = NULL;
        list->size = 0u;
    }
}
/*=========================================================*/
static qList_Node_t* qList_NodeInit( void * const node ){
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    qList_Node_t *xNode = (qList_Node_t*)node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    xNode->prev = NULL;
    xNode->next = NULL;
    xNode->container = NULL;
    return xNode;
}
/*=========================================================*/
static void qList_InsertAtFront( qList_t * const list, qList_Node_t * const node ){
    node->next = list->head;
    list->head->prev = node;
    list->head = node;
}
/*=========================================================*/
static void qList_InserAtBack( qList_t * const list, qList_Node_t * const node ){
    list->tail->next = node;
    node->prev = list->tail;
    list->tail = node;
}
/*=========================================================*/
static qList_Node_t* qList_RemoveFront( qList_t * const list ){
    qList_Node_t *removed;
    
    removed = list->head;
    list->head = removed->next;
    if( NULL == list->head ){
        list->tail = list->head;
    }
    else{
        list->head->prev = NULL;    
    }
    return removed;
}
/*=========================================================*/
static qList_Node_t* qList_RemoveBack( qList_t * const list ){
    qList_Node_t *removed;
    
    removed = list->tail;
    list->tail = removed->prev;
    if( NULL == list->tail ){
        list->head = list->tail;
    }
    else{
        list->tail->next = NULL;    
    }
    return removed;
}
/*=========================================================*/
static qList_Node_t* qList_GetiNode( const qList_t *const list, const qList_Position_t position ){
    qList_Node_t *iNode;
    qBase_t iPos = 0;

    for( iNode = list->head ; ( iPos < (qBase_t)position ) && ( NULL != iNode->next ) ; iNode = iNode->next ){
        ++iPos;
    }
    return iNode;
}
/*=========================================================*/
qBool_t qList_Insert( qList_t *const list, void * const node, const qList_Position_t position ){
    qBool_t RetValue = qFalse;
 
    if( ( NULL != list ) && ( NULL != node ) && ( position >= (qList_Position_t)(-1) ) ){    
        if( qFalse == qList_IsMember( list, node )){
            qList_Node_t *newnode;

            newnode = qList_NodeInit( node );
            RetValue = qTrue;
            if( NULL == list->head ){ /*list is empty*/
                list->head = newnode; 
                list->tail = newnode;
            }
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            else if( QLIST_ATFRONT == position ){
                qList_InsertAtFront( list, (qList_Node_t*)node ); /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            }
            else if( position >= ( (qList_Position_t)list->size - 1 ) ){
                qList_InserAtBack( list, (qList_Node_t*)node ); /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            }
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            else{ /*insert the new node after the position*/
                qList_Node_t *iNode;

                iNode = qList_GetiNode( list, position );
                newnode->next = iNode->next;  /*  NEW -> (i+1)NODE */
                newnode->prev = iNode;        /*  iNODE <- NEW */
                iNode->next->prev = newnode;  /*  NEW <- (i+1)NODE  */
                iNode->next = newnode;        /*  iNODE -> NEW */  
            }                                 /*  result: iNODE <-> NEW <-> (i+1)NODE    */
            ++list->size;
            newnode->container = list;
        }
    }
    return RetValue;  
}
/*=========================================================*/                     
qBool_t qList_RemoveItself( void * const node ){
    qBool_t RetValue = qFalse;
    
    if( NULL != node ){
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qList_Node_t *toRemove = (qList_Node_t*)node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        
        if( NULL != toRemove->container ){
            qList_t *list;

            list = (qList_t*)toRemove->container; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            if( toRemove == list->head ){
                (void)qList_RemoveFront( list );          
            }
            else if( toRemove == list->tail ){
                (void)qList_RemoveBack( list );
            }
            else{
                toRemove->prev->next = toRemove->next;
                if( NULL != toRemove->next ){
                    toRemove->next->prev = toRemove->prev;
                }
            }
            --list->size;
            toRemove->container = NULL;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*=========================================================*/           
void* qList_Remove( qList_t * const list, void * const node, const qList_Position_t position ){
    qList_Node_t *removed = NULL;

    if( ( NULL != list->head ) && ( position >= (qList_Position_t)(-1) ) ){
        if ( qList_IsMember( list, node ) ){
            if( qList_RemoveItself( node ) ){
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
                removed = (qList_Node_t*)node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
                /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            }
        }
        else{
            if( position <= (qList_Position_t)0 ){
                removed = qList_RemoveFront( list );     
            }
            else if( position > ( (qList_Position_t)list->size - 1 ) ){
                removed = qList_RemoveBack( list );  
            }
            else{
                qList_Node_t *iNode;
                qBase_t LastIndex = ( (qBase_t)position - 1 );

                iNode = qList_GetiNode( list, (qList_Position_t)LastIndex );
                removed = iNode->next;       /*  <-> (inode0) <-> inode1 <-> inode2 */
                iNode->next = removed->next;
                if( NULL != removed->next ){
                    iNode->next->prev = iNode;
                }
            }
            removed->container = NULL;
            --list->size;
        }
    }
    return removed;
}
/*=========================================================*/           
qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qList_Position_t position ){
    qBool_t RetValue = qFalse;

    if( ( NULL != destination ) && ( NULL != source ) && ( position >= (qList_Position_t)(-1) )  ) {    
        if( NULL != source->head){ /*source has items*/
            RetValue = qTrue;
            (void)qList_ForEach( source, qList_ChangeContainer, destination, QLIST_FORWARD, NULL );          
            if( NULL == destination->head ){ /*destination is empty*/
                destination->head = source->head;
                destination->tail = source->tail;
            }
            else if( QLIST_ATFRONT == position ){
                source->tail->next = destination->head;
                destination->head->prev = source->tail;
                destination->head = source->head;
            }
            else if( position >= ( (qList_Position_t)destination->size - 1 ) ){
                destination->tail->next = source->head;
                source->head->prev = destination->tail;
                destination->tail = source->tail;
            }
            else{ /*insert the new list after the position*/
                qList_Node_t *iNode;

                iNode = qList_GetiNode( destination, position );
                source->tail->next = iNode->next; 
                source->head->prev = iNode;
                iNode->next = source->head;
            }
            destination->size += source->size;
            qList_Initialize( source ); /*clean up source*/
        }
    }
    return RetValue;
}
/*=========================================================*/
static qBool_t qList_ChangeContainer( qList_ForEachHandle_t h ){
    qList_Node_t *xNode;

    if( qList_WalkThrough == h->stage ){
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/ 
        xNode = (qList_Node_t*)h->node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        xNode->container = h->arg; /*new container stored into <arg>*/
    }
    return qFalse;
}
/*=========================================================*/
qBool_t qList_IsMember( qList_t * const list, void * const node ){
    qBool_t RetValue = qFalse;

    if( NULL != node ){
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qList_Node_t *xNode = (qList_Node_t*)node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        
        if( list  == (qList_t*)xNode->container ){ /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            RetValue = qTrue;
        }
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    }
    return RetValue;
}
/*=========================================================*/
void* qList_GetFront( const qList_t *const list ){
    void *RetValue = NULL;

    if( NULL != list ){
        RetValue = (void*)list->head;
    }
    return RetValue;
}
/*=========================================================*/
void* qList_GetBack( const qList_t *const list ){
    void *RetValue = NULL;

    if( NULL != list ){
        RetValue = (void*)list->tail;
    }
    return RetValue;
}
/*=========================================================*/
qBool_t qList_IsEmpty( const qList_t * const list ){
    qBool_t RetValue = qTrue;
    
    if( NULL != list ){
        RetValue = ( NULL == list->head )? qTrue : qFalse;
    }
    return RetValue;
}
/*=========================================================*/
size_t qList_Length( const qList_t * const list ){
    size_t RetValue = 0u;

    if( NULL != list ){
        RetValue = list->size;
    }
    return RetValue;
}
/*=========================================================*/
qBool_t qList_Sort( qList_t * const list, qList_CompareFcn_t CompareFcn ){
    qBool_t RetValue = qFalse;

    if( ( NULL != list ) && ( NULL != CompareFcn ) ){
        size_t count = list->size;

        if( count >= (size_t)2 ){ /*It is only worth running the algorithm if the list has two or more nodes*/
            qList_Node_t *current = NULL, *before, *after;
            _qList_CompareHandle_t xHandle;
            size_t i, j, n;
            qBool_t xRetCmp;

            for( i = (size_t)1; i < count; ++i ){
                current = list->head;
                n = count - i - (size_t)1;
                for( j = (size_t)0; j <= n; ++j ){ 
                    xHandle.n1 = current;
                    xHandle.n2 = current->next;
                    xRetCmp = CompareFcn( &xHandle );
                    if( qTrue == xRetCmp ) { /*compare adjacent nodes*/
                        before = current->prev;
                        after = current->next;

                        if( NULL != before){
                            before->next = after;
                        } 
                        else{
                            list->head = after; /* In case <before> pointer is null, <after> pointer should be the new head*/
                        }
                        current->next = after->next;
                        current->prev = after;

                        if( NULL != after->next ){
                            after->next->prev = current; /* <prev> pointer of after->next should be set to current. */
                        }

                        after->next = current;
                        after->prev = before;
                        RetValue = qTrue;
                    } 
                    else{
                        current = current->next; /* Go to next node only if current->data > current->next->data condition is false. */
                    }
                }
            }
            while( NULL != current->next ){ /*loop remaining nodes until find the new tail*/
                current = current->next;
            }
            list->tail = current;            
        }
    }
    return RetValue;
}
/*=========================================================*/
qBool_t qList_IteratorSet( qList_Iterator_t *iterator, qList_t *const list, void *NodeOffset, qList_Direction_t dir ){
    qBool_t RetValue = qFalse;

    if( ( NULL != list ) && ( NULL != iterator ) && ( ( &QLIST_FORWARD == dir ) || ( &QLIST_BACKWARD == dir) ) ){
        qList_Node_t *Offset;
        
        iterator->direction = dir;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        Offset = (qList_Node_t*)NodeOffset; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        if( NULL != Offset){
            if( list == Offset->container ){
                iterator->next = Offset;
                RetValue = qTrue;
            }
        }
        else{
            iterator->next = ( QLIST_FORWARD == dir )? list->head : list->tail;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*=========================================================*/
void* qList_IteratorGetNext( qList_Iterator_t *iterator ){
    void *iNode = NULL;

    if( NULL != iterator ){
        iNode = iterator->next;
        if( NULL != iNode ){
            iterator->next = iterator->direction( iterator->next );
        }
    }
    return iNode;
}
/*=========================================================*/
qBool_t qList_ForEach( qList_t *const list, const qList_NodeFcn_t Fcn, void *arg, qList_Direction_t dir, void *NodeOffset ){
    qBool_t RetValue = qFalse;
    
    if( ( NULL != list ) && ( NULL != Fcn ) && ( ( &QLIST_FORWARD == dir ) || ( &QLIST_BACKWARD == dir) ) ){
        if ( NULL != list->head ){  /*walk the list only if it has items*/
            qList_Node_t *iNode;
            qList_Node_t *adjacent; /*to allow i-node links to be changed in the walk throught*/
            _qList_ForEachHandle_t xHandle = { NULL, arg,  qList_WalkInit };

            adjacent = ( &QLIST_FORWARD == dir )? list->head : list->tail; /*select starting point*/
            if( NULL != NodeOffset ){ /*offset request?*/
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
                iNode = (qList_Node_t*)NodeOffset; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
                /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
                if( iNode->container == list ){ /*the offset belongs to the list?*/
                    adjacent = iNode; /*take offset as a starting point*/
                }
            }
            RetValue = Fcn( &xHandle ); /*run initial stage before looping through list*/
            if( qFalse == RetValue ){ /*check if the initial stage allows us to continue*/
                xHandle.stage = qList_WalkThrough;
                for( iNode = adjacent; NULL != iNode; iNode = adjacent ){ /*loop the list*/
                    adjacent = dir( iNode ); /*Save the adjacent node if the current node changes its links. */
                    xHandle.node = iNode;
                    RetValue = Fcn( &xHandle ); /*perform action over the node*/
                    if( RetValue ){ /*check if the last node handling breaks the loop*/
                        break;
                    }               
                }
                if( qFalse == RetValue ){ /*if the last node allows to continue, run the ending stage*/
                    xHandle.node = NULL;
                    xHandle.stage = qList_WalkEnd;
                    RetValue = Fcn( &xHandle ); 
                }
            }    
        }    
    }
    return RetValue;
}
/*=========================================================*/
qList_Node_t* _qNode_Forward( const qList_Node_t *const node ){
    return node->next;
}
/*=========================================================*/
qList_Node_t* _qNode_Backward( const qList_Node_t *const node){
    return node->prev;
}
/*=========================================================*/
qBool_t qList_Swap( void *node1, void *node2 ){
    qBool_t RetValue = qFalse;

    if( ( NULL != node1 ) && ( NULL != node2) && ( node1 != node2 ) ){ 
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qList_Node_t *n1 = (qList_Node_t*)node1; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        qList_Node_t *n2 = (qList_Node_t*)node2; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        
        if( ( NULL != n1->container ) && ( n1->container == n2->container ) ){ /*nodes are part of the same list*/
            qList_Node_t *tmp1, *tmp2;

            if( n2->next == n1 ){
                n1 = (qList_Node_t*)node2; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */ 
                n2 = (qList_Node_t*)node1; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */              
            }          
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            tmp1 = n1->prev; /*save links prior swap*/
            tmp2 = n2->next;           
            qList_GivenNodes_SwapBoundaries( n1, n2 );
            qList_GivenNodes_SwapAdjacent( n1, n2 );
            n2->prev = tmp1; /*restore previously saved links*/
            n1->next = tmp2;
            qList_GivenNodes_UpdateOuterLinks( n1, n2 );   
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*=========================================================*/
static void qList_GivenNodes_SwapBoundaries( qList_Node_t *n1, qList_Node_t *n2 ){
    qList_t *list;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    list = (qList_t*)n1->container; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    /*update the list links*/
    if( list->head == n1 ){
        list->head = n2;
    }
    else if( list->head == n2 ){
        list->head = n1;
    }    
    else{
        /*nothing to do here*/         
    }        
    if( list->tail == n1 ){
        list->tail = n2;
    }
    else if( list->tail == n2 ){
        list->tail = n1;
    }
    else{
        /*nothing to do here*/
    } 
}
/*=========================================================*/
static void qList_GivenNodes_SwapAdjacent( qList_Node_t *n1, qList_Node_t *n2 ){
    if( ( (n1->next == n2 ) && ( n2->prev == n1 ) ) || ( ( n1->prev == n2 ) && ( n2->next == n1 ) ) ){ /*adjacent nodes?*/
        n1->prev = n1->next; 
        n2->next = n2->prev;
    }
    else{
        n1->prev = n2->prev;
        n2->next = n1->next;
    }
}
/*=========================================================*/
static void qList_GivenNodes_UpdateOuterLinks( qList_Node_t *n1, qList_Node_t *n2 ){
    if( NULL != n1->prev ){
        n1->prev->next = n1;
    }
    if( NULL != n1->next ){
        n1->next->prev = n1;
    }
    if( NULL != n2->prev ){
        n2->prev->next = n2;
    }
    if( NULL != n2->next ){
        n2->next->prev = n2;
    } 
}

#ifdef QLIST_D_HANDLING  /*use only if strictly necessary*/
/*=========================================================*/
void qList_SetMemoryAllocation( qList_MemAllocator_t mallocFcn, qList_MemFree_t freeFcn  ){
    qListFree = freeFcn;
    qListMalloc = mallocFcn;
}
/*=========================================================*/
qBool_t qList_DInsert( qList_t *const list, void *Data, size_t Size, qList_Position_t position ){
    qBool_t RetValue = qFalse;
    
    if( ( NULL != qListMalloc ) && ( NULL != qListFree ) && ( Size > (size_t)0) ){
        void *NewNode = qListMalloc( Size );
        if( NULL != NewNode ){
            (void)memcpy( NewNode, Data, Size );
            RetValue = qList_Insert( list, NewNode, position );
            if( qFalse == RetValue ){
                qListFree( NewNode );
            }
        }
    }
    return RetValue;
}
/*=========================================================*/
void* qList_DRemove( qList_t * const list, void * const node, const qList_Position_t position ){
    void *removed = NULL;

    if( ( NULL != qListMalloc ) && ( NULL != qListFree ) ){
        removed = qList_Remove( list, node, position );
        if( NULL != removed ){
            qListFree( removed );        
        }    
    }
    return removed;
}
/*=========================================================*/
qBool_t qList_DRemoveItself( void * const node ){
    qBool_t RetValue = qFalse;
    
    if( ( NULL != qListMalloc ) && ( NULL != qListFree ) ){
        if( qList_RemoveItself( node ) ){
            qListFree( node );
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*=========================================================*/
#endif