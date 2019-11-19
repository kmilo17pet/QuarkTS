#include "qlists.h"

#if ( Q_LISTS == 1)

static qNode_t* qList_NodeInit( void * const node );
static void qList_InsertAtFront( qList_t * const list, qNode_t * const node );
static void qList_InserAtBack( qList_t * const list, qNode_t * const node );

static qNode_t* qList_RemoveFront( qList_t * const list );
static qNode_t* qList_RemoveBack( qList_t * const list );

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
/*qBool_t qList_Insert(qList_t * const list, const void * const node, const qListPosition_t position)
 
Insert an item into the list.

Parameters:

    - list : Pointer to the list.
    - node : A pointer to the node to be inserted
    - position :  The position where the node will be inserted. Could be 
                 qList_AtFront, qList_AtBack or any other index number 
                 where the node will be inserted after.

Return value:

    qTrue if the item was successfully added tot he list, othewise returns qFalse   

*/
qBool_t qList_Insert( qList_t *const list, void * const node, const qListPosition_t position ){
    qBool_t RetValue = qFalse;
    qNode_t *newnode;
    qNode_t *iNode;
    qBase_t iPos;
 
    if( ( NULL != list ) && ( NULL != node ) && ( position >= -1 ) && ( position <= qList_AtBack )) {    
        if( qFalse == qList_IsMember( list, node )){
            newnode = qList_NodeInit( node );
            RetValue = qTrue;
            if( NULL == list->head ){ /*list is empty*/
                list->head = newnode; 
                list->tail = newnode;
            }
            else if( qList_AtFront == position){
                qList_InsertAtFront( list, node );
            }
            else if( ( qList_AtBack == position ) || ( position >= ( (qListPosition_t)list->size - 1 ) ) ){
                qList_InserAtBack( list, node );
            }
            else{ /*insert the new node after the position*/
                iPos = 0;
                for( iNode = list->head ; ( iPos < position ) && ( NULL != iNode->next ) ; iNode = iNode->next ){
                    iPos++;
                }
                newnode->next = iNode->next;  /*  NEW -> (i+1)NODE */
                newnode->prev = iNode;        /*  iNODE <- NEW */
                iNode->next->prev = newnode;  /*  NEW <- (i+1)NODE  */
                iNode->next = newnode;        /*  iNODE -> NEW */  
            }                                 /*  result: iNODE <-> NEW <-> (i+1)NODE    */
            list->size++;
        }
    }
    return RetValue;  
}
/*=========================================================*/           
/*void* qList_Remove(qList_t * const list, void * const node, const qListPosition_t position)
 
Remove an item from the list.

Parameters:

    - list : Pointer to the list.
    - node : A pointer to the node to be deleted (to ignore pass NULL )
    - position : The position of the node that will be removed. Could be 
                 qList_AtFront, qList_AtBack or any other index number.

Return value:

    A pointer to the removed node. NULL if removal can be performed.  

*/ 
void* qList_Remove( qList_t * const list, void * const node, const qListPosition_t position ){
    qNode_t *removed = NULL;
    qBase_t iPos = 0;
    qBase_t LastIndex;
    qNode_t *iNode;
    qNode_t *toRemove;
    if( ( NULL != list->head ) && ( position >= -1 ) ){
        if ( qList_IsMember( list, node ) ){
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
            LastIndex = ( (int)position - 1 );
            for( iNode = list->head ; iPos < LastIndex ; iNode = iNode->next ){ 
                iPos++;
            }
            removed = iNode->next;       /*  <-> (inode0) <-> inode1 <-> inode2 */
            iNode->next = removed->next;
            if( NULL != removed->next ){
                iNode->next->prev = iNode;
            }
            list->size--;
        }                
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
/*void qList_View(const qList_t * const list, const qListVisualizer_t visualizer)
 
List visualization. The application writer should provide the
function to print out the corresponding node data.

Parameters:

    - list : Pointer to the list.
    - visualizer : The function for node data visualization.

*/ 
void qList_View( const qList_t *const list, const qListVisualizer_t visualizer ){
    qNode_t *iNode;
    for( iNode = list->head ; NULL != iNode ; iNode = iNode->next ){
        visualizer( iNode );
    }
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
qSize_t qList_Length( const qList_t * const list ){
    qSize_t RetValue = 0u;
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
    qSize_t count;
    qNode_t *current = NULL, *before = NULL, *after = NULL;
    qBase_t i, j;

    if( ( NULL != list ) && ( NULL != CompareFcn ) ){
        count = list->size;
        if( count >= 2){ /*It is only worth running the algorithm if the list has two or more nodes*/
            for (i = 1; i < count; i++) {
                current = list->head;
                for (j = 0; j <= count - i - 1; j++) { 
                    if( qTrue == CompareFcn( current, current->next )  ) { /*compare adyacent nodes*/
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
                    } else {
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

#endif /* #if ( Q_LISTS == 1) */