#include "qlists.h"

static qNode_t* qList_NodeInit( void * const node );
static void qList_InsertAtFront( qList_t * const list, qNode_t * const node );
static void qList_InserAtBack( qList_t * const list, qNode_t * const node );

static qNode_t* qList_RemoveFront( qList_t * const list );
static qNode_t* qList_RemoveBack( qList_t * const list );

static qNode_t* qList_GetiNode( const qList_t *const list, const qListPosition_t position );


static qListMemAllocator_t qListMalloc = NULL; 
static qListMemFree_t qListFree = NULL; 

static qNode_t* __qNode_Forward( const qNode_t *const node );

#ifdef QLIST_NODE_WITH_CONTAINER
    static qBool_t qList_ChangeContainer( void *node, void *newcontainer, qList_WalkStage_t stage );
#endif
/*============================================================================*/
/*void qList_Initialize(qList_t *list)
 
Must be called before a list is used!  This initialises all the members of the 
list structure.

Parameters:

    - list : Pointer to the list being initialised.   

*/
void qList_Initialize( qList_t * const list ){
    if( NULL != list ){
        list->head = NULL;
        list->tail = NULL;
        list->size = 0u;
    }
}
/*=========================================================*/
static qNode_t* qList_NodeInit( void * const node ){
    qNode_t *xNode = (qNode_t*)node;
    xNode->prev = NULL;
    xNode->next = NULL;
    #ifdef QLIST_NODE_WITH_CONTAINER
        xNode->container = NULL;
    #endif
    return xNode;
}
/*=========================================================*/
static void qList_InsertAtFront( qList_t * const list, qNode_t * const node ){
    node->next = list->head;
    list->head->prev = node;
    list->head = node;
}
/*=========================================================*/
static void qList_InserAtBack( qList_t * const list, qNode_t * const node ){
    list->tail->next = node;
    node->prev = list->tail;
    list->tail = node;
}
/*=========================================================*/
static qNode_t* qList_RemoveFront( qList_t * const list ){
    qNode_t *removed;
    
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
static qNode_t* qList_RemoveBack( qList_t * const list ){
    qNode_t *removed;
    
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
static qNode_t* qList_GetiNode( const qList_t *const list, const qListPosition_t position ){
    qNode_t *iNode = NULL;
    qBase_t iPos = 0;
    for( iNode = list->head ; ( iPos < position ) && ( NULL != iNode->next ) ; iNode = iNode->next ){
        iPos++;
    }
    return iNode;
}
/*=========================================================*/
/*qBool_t qList_Insert(qList_t * const list, const void * const node, const qListPosition_t position)
 
Insert an item into the list.

Parameters:

    - list : Pointer to the list.
    - node : A pointer to the node to be inserted
    - position : The position where the node will be inserted. Could be 
                 qList_AtFront, qList_AtBack or any other index number 
                 where the node will be inserted after.

Return value:

    qTrue if the item was successfully added to the list, othewise returns qFalse   

*/
qBool_t qList_Insert( qList_t *const list, void * const node, const qListPosition_t position ){
    qBool_t RetValue = qFalse;
    qNode_t *newnode;
    qNode_t *iNode;
 
    if( ( NULL != list ) && ( NULL != node ) && ( position >= -1 ) && ( position <= qList_AtBack ) ){    
        #ifdef QLIST_CHECK_NODE_MEMBERSHIP
        if( qFalse == qList_IsMember( list, node )){
        #endif    
            newnode = qList_NodeInit( node );
            RetValue = qTrue;
            if( NULL == list->head ){ /*list is empty*/
                list->head = newnode; 
                list->tail = newnode;
            }
            else if( qList_AtFront == position ){
                qList_InsertAtFront( list, node );
            }
            else if( ( qList_AtBack == position ) || ( position >= ( (qListPosition_t)list->size - 1 ) ) ){
                qList_InserAtBack( list, node );
            }
            else{ /*insert the new node after the position*/
                iNode = qList_GetiNode( list, position );
                newnode->next = iNode->next;  /*  NEW -> (i+1)NODE */
                newnode->prev = iNode;        /*  iNODE <- NEW */
                iNode->next->prev = newnode;  /*  NEW <- (i+1)NODE  */
                iNode->next = newnode;        /*  iNODE -> NEW */  
            }                                 /*  result: iNODE <-> NEW <-> (i+1)NODE    */
            list->size++;
            #ifdef QLIST_NODE_WITH_CONTAINER
                newnode->container = list;
            #endif
        #ifdef QLIST_CHECK_NODE_MEMBERSHIP    
        }
        #endif
    }
    return RetValue;  
}
/*=========================================================*/           
/*qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qListPosition_t position )

Moves(or merge) the entire list pointed by <source> to the list pointed by 
<destination> at location specified by <position> 
After the move operation, this function leaves empty the list pointed 
by <source>.

Parameters:

    - destination : Pointer to the list where the <source> nodes are to be moved.
    - source : Pointer to the source list to be moved.
    - position : The position where <source> list will be inserted. Could be 
                 qList_AtFront, qList_AtBack or any other index number 
                 where the list will be inserted after.

Return value:

    qTrue if the move operation is performed successfully, otherwise 
    returns qFalse   

*/
qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qListPosition_t position ){
    qBool_t RetValue = qFalse;
    qNode_t *iNode;

    if( ( NULL != destination ) && ( NULL != source ) && ( position >= -1 ) && ( position <= qList_AtBack ) ) {    
        if( NULL != source->head){ /*source has items*/
            RetValue = qTrue;
            if( NULL == destination->head ){ /*destination is empty*/
                destination->head = source->head;
                destination->tail = source->tail;
            }
            else if( qList_AtFront == position ){
                source->tail->next = destination->head;
                destination->head->prev = source->tail;
                destination->head = source->head;
            }
            else if( ( qList_AtBack == position ) || ( position >= ( (qListPosition_t)destination->size - 1 ) ) ){
                destination->tail->next = source->head;
                source->head->prev = destination->tail;
                destination->tail = source->tail;
            }
            else{ /*insert the new list after the position*/
                iNode = qList_GetiNode( destination, position );
                source->tail->next = iNode->next; 
                source->head->prev = iNode;
                iNode->next = source->head;
            }
            destination->size += source->size;
            qList_Initialize( source ); /*clean up source*/
            #ifdef QLIST_NODE_WITH_CONTAINER
                qList_ForEach( destination, qList_ChangeContainer, destination, QLIST_FORWARD );
            #endif
        }
    }
    return RetValue;
}
/*=========================================================*/
#ifdef QLIST_NODE_WITH_CONTAINER
static qBool_t qList_ChangeContainer( void *node, void *newcontainer, qList_WalkStage_t stage ){
    qNode_t *xNode;
    if( qList_WalkThrough == stage ){
        xNode = (qNode_t*)node;
        xNode->container = newcontainer;
    }
    return qFalse;
}
#endif
/*=========================================================*/           
/*void* qList_Remove(qList_t * const list, void * const node, const qListPosition_t position)
 
Remove an item from the list.

Parameters:

    - list : Pointer to the list.
    - node : A pointer to the node to be deleted (to ignore pass NULL )
    - position : The position of the node that will be removed. Could be 
                 qList_AtFront, qList_AtBack or any other index number.

Return value:

    A pointer to the removed node. NULL if removal can't be performed.  

*/ 
void* qList_Remove( qList_t * const list, void * const node, const qListPosition_t position ){
    qNode_t *removed = NULL;
    qBase_t LastIndex;
    qNode_t *iNode;
    qNode_t *toRemove;

    if( ( NULL != list->head ) && ( position >= -1 ) ){
        #ifdef QLIST_CHECK_NODE_MEMBERSHIP
        if ( qList_IsMember( list, node ) ){
        #else
        if( NULL != node ){
        #endif     
            toRemove = (qNode_t*)node;
            if( toRemove == list->head ){
                removed = qList_RemoveFront( list );          
            }
            else{
                removed = toRemove;
                removed->prev->next = removed->next;
                if( NULL != removed->next ){
                    removed->next->prev = removed->prev;
                }
            }
            list->size--;
        }
        else if( position <= 0 ){
            removed = qList_RemoveFront( list );     
            list->size--;
        }
        else if( ( qList_AtBack == position ) || ( position > ( (qListPosition_t)list->size - 1 ) ) ){
            removed = qList_RemoveBack( list );  
            list->size--;
        }
        else{
            LastIndex = ( (qBase_t)position - 1 );
            iNode = qList_GetiNode( list, (qListPosition_t)LastIndex );
            removed = iNode->next;       /*  <-> (inode0) <-> inode1 <-> inode2 */
            iNode->next = removed->next;
            if( NULL != removed->next ){
                iNode->next->prev = iNode;
            }
            list->size--;
        }                
        #ifdef QLIST_NODE_WITH_CONTAINER
            if( NULL != removed ){
                removed->container = NULL;
            }
        #endif
    }
    return removed;
}
/*=========================================================*/
/*qBool_t qList_IsMember(const qList_t * const list, const void * const node)
 
Check if the node is member of the list.

Parameters:

    - list : Pointer to the list.
    - node : A pointer to the node

Return value:

    qTrue if the node belongs to the list, qFalse if it is not.  

*/ 
qBool_t qList_IsMember( const qList_t * const list, const void * const node ){
    qBool_t RetValue = qFalse;
    qNode_t *iNode;
    const qNode_t * const xNode = (qNode_t const*)node;
    
    if( NULL != node ){
        for( iNode = list->head ; NULL != iNode ; iNode = iNode->next ){
            if( iNode == xNode){
                RetValue = qTrue;
                break;
            }
        }
    }
    return RetValue;
}
/*=========================================================*/
/*void* qList_GetFront(const qList_t * const list)
 
Get a pointer to the front item of the list

Parameters:

    - list : Pointer to the list.

Return value:

    A pointer to the front node. NULL if the list is empty  

*/ 
void* qList_GetFront( const qList_t *const list ){
    void *RetValue = NULL;
    if( NULL != list ){
        RetValue = (void*)list->head;
    }
    return RetValue;
}
/*=========================================================*/
/*void* qList_GetBack(const qList_t * const list)
 
Get a pointer to the back item of the list

Parameters:

    - list : Pointer to the list.

Return value:

    A pointer to the back node. NULL if the list is empty  

*/ 
void* qList_GetBack( const qList_t *const list ){
    void *RetValue = NULL;
    if( NULL != list ){
        RetValue = (void*)list->tail;
    }
    return RetValue;
}
/*=========================================================*/
/*qBool_t qList_IsEmpty(const qList_t * const list)
 
Check if the list is empty.

Parameters:

    - list : Pointer to the list.

Return value:

    qTrue if the list is empty, qFalse if it is not.  

*/ 
qBool_t qList_IsEmpty( const qList_t * const list ){
    qBool_t RetValue = qTrue;
    if( NULL != list ){
        RetValue = (NULL == list->head)? qTrue : qFalse;
    }
    return RetValue;
}
/*=========================================================*/
/*void* qList_Length(const qList_t * const list)
 
Get the number of items inside the list

Parameters:

    - list : Pointer to the list.

Return value:

    The number of items of the list. 

*/ 
size_t qList_Length( const qList_t * const list ){
    size_t RetValue = 0u;
    if( NULL != list ){
        RetValue = list->size;
    }
    return RetValue;
}
/*=========================================================*/
/*qBool_t qList_Sort( qList_t * const list, qBool_t (*CompareFcn)(void *n1, void *n2) ) 

Sort the double linked list using the <CompareFcn> function to 
determine the order.
The sorting algorithm used by this function compares pairs of 
adyacent nodes by calling the specified <CompareFcn> function 
with pointers to them as argument. Sort is performed only 
modifying node link's without data swapping, improving performance 
if nodes has large storage.

Note: The function modifies the content of the list by reordering its 
elements as defined by CompareFcn.

Parameters:

    - list : Pointer to the list.
    - CompareFcn :  Pointer to a function that compares two nodes.
                    This function is called repeatedly by qList_Sort
                    to compare two nodes. It shall follow the 
                    following prototype:
                    qBool_t (*CompareFcn)(void *node1, void *node2)
                    Taking two pointers as arguments (both converted
                    to const void*). The function defines the order
                    of the elements by returning a Boolean data, where
                    a <qTrue> value indicates that element pointed by 
                    <node1> goes after the element pointed to by <node2>

Return value:

    qTrue if at least one reordering is performed over the list. 
*/
qBool_t qList_Sort( qList_t * const list, qBool_t (*CompareFcn)(const void *n1, const void *n2) ) {
    qBool_t RetValue = qFalse;
    qBool_t xRetCmp;
    size_t count, i, j, n;
    qNode_t *current = NULL, *before = NULL, *after = NULL;

    if( ( NULL != list ) && ( NULL != CompareFcn ) ){
        count = list->size;
        if( count >= (size_t)2){ /*It is only worth running the algorithm if the list has two or more nodes*/
          for (i = (size_t)1; i < count; i++) {
                current = list->head;
                n = count - i - (size_t)1;
                for (j = (size_t)0; j <= n; j++) { 
                    xRetCmp = CompareFcn( current, current->next );
                    if( qTrue == xRetCmp ) { /*compare adyacent nodes*/
                        before = current->prev;
                        after = current->next;

                        if( NULL != before) {
                            before->next = after;
                        } 
                        else {
                            list->head = after; /* In case before pointer is null, after pointer should be the new head*/
                        }
                        current->next = after->next;
                        current->prev = after;

                        if( NULL != after->next ) {
                            after->next->prev = current; /* prev pointer of after->next should be set to current. */
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
            while(current->next){ /*loop remaining nodes until find the new tail*/
                current = current->next;
            }
            list->tail = current;            
        }
    }
    return RetValue;
}
/*=========================================================*/
/*qBool_t qList_ForEach( qList_t *const list, qListNodeFcn_t Fcn, void *arg, qListDirection_t dir )
 
Operate on each element of the list.

Parameters:

    - list : Pointer to the list.
    - Fcn : The function to perform over the node. 
            Should have this prototype:
            qBool_t Function( void* Node, void *arg, qList_WalkStage_t stage )
            
            If <Function> returns qTrue, the walk through loop
            will be terminated.

    - arg : Argument passed to <Fcn>
    - dir : Use one of the following options:
               QLIST_FORWARD or NULL : to walk through the list forwards.
               QLIST_BACKWARD : to walk through the list backwards.

Return value:

    qTrue if the walk through was early terminated, otherwise returns qFalse.

*/ 
qBool_t qList_ForEach( qList_t *const list, const qListNodeFcn_t Fcn, void *arg, qListDirection_t dir ){
    qBool_t RetValue = qFalse;
    qNode_t *iNode;
    qNode_t *adyacent; /*to allow i-node links to be changed in the walk throught*/
    
    if( ( NULL != list ) && ( NULL != Fcn ) && ( ( QLIST_FORWARD == dir ) || ( &QLIST_BACKWARD == dir) ) ){
        if( QLIST_FORWARD == dir ){
            dir = &__qNode_Forward;
            adyacent = list->head;
        }
        else{
            adyacent = list->tail;
        }
        RetValue = Fcn( NULL, arg, qList_WalkInit );
        if( qFalse == RetValue ){
            for( iNode = adyacent; NULL != iNode; iNode = adyacent ){
                adyacent = dir( iNode ); /*Save the adjacent node if the current node changes its links. */
                RetValue = Fcn( iNode, arg, qList_WalkThrough );
                if( RetValue ){
                    break;
                }               
            }
            if( qFalse == RetValue ){
                RetValue = Fcn( NULL, arg, qList_WalkEnd ); 
            }
        }
        
    }
    return RetValue;
} 
/*=========================================================*/
static qNode_t* __qNode_Forward( const qNode_t *const node ){
    return node->next;
}
/*=========================================================*/
qNode_t* __qNode_Backward( const qNode_t *const node){
    return node->prev;
}
/*=========================================================*/
void qList_SetMemoryAllocation( qListMemAllocator_t mallocFcn, qListMemFree_t freeFcn  ){
    qListFree = freeFcn;
    qListMalloc = mallocFcn;
}
/*=========================================================*/
qBool_t qList_DInsert( qList_t *const list, void *data, size_t size, qListPosition_t position ){
    qBool_t RetValue = qFalse;
    void *NewNode = NULL;
    if( ( NULL != qListMalloc ) && ( NULL != qListFree ) && ( size > (size_t)0) ){
        NewNode = qListMalloc( size );
        if( NULL != NewNode ){
            memcpy( NewNode, data, size );
            RetValue = qList_Insert( list, NewNode, position );
            if( qFalse == RetValue ){
                qListFree( NewNode );
            }
        }
    }
    return RetValue;
}
/*=========================================================*/
void* qList_DRemove( qList_t * const list, void * const node, const qListPosition_t position ){
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
