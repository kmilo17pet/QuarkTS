/*!
 * @file qlists.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qlists.h"

static qList_Node_t* qList_NodeInit( void * const node );
static void qList_InsertAtFront( qList_t * const l,
                                 qList_Node_t * const node );
static void qList_InsertAtBack( qList_t * const l,
                               qList_Node_t * const node );
static qList_Node_t* qList_RemoveFront( qList_t * const l );
static qList_Node_t* qList_RemoveBack( qList_t * const l );
static qList_Node_t* qList_GetiNode( const qList_t *const l,
                                     const qList_Position_t p );
static qBool_t qList_ChangeContainer( qList_ForEachHandle_t h );
static void qList_GivenNodes_SwapBoundaries( qList_Node_t *n1,
                                             qList_Node_t *n2 );
static void qList_GivenNodes_SwapAdjacent( qList_Node_t *n1,
                                           qList_Node_t *n2 );
static void qList_GivenNodes_UpdateOuterLinks( qList_Node_t *n1,
                                               qList_Node_t *n2 );

/*============================================================================*/
qBool_t qList_Initialize( qList_t * const l )
{
    qBool_t retValue = qFalse;

    if ( NULL != l ) {
        l->head = NULL;
        l->tail = NULL;
        l->size = 0u;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
static qList_Node_t* qList_NodeInit( void * const node )
{
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    qList_Node_t *xNode = (qList_Node_t*)node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    xNode->prev = NULL;
    xNode->next = NULL;
    xNode->container = NULL;

    return xNode;
}
/*============================================================================*/
static void qList_InsertAtFront( qList_t * const l,
                                 qList_Node_t * const node )
{
    node->next = l->head;
    l->head->prev = node;
    l->head = node;
}
/*============================================================================*/
static void qList_InsertAtBack( qList_t * const l,
                               qList_Node_t * const node )
{
    l->tail->next = node;
    node->prev = l->tail;
    l->tail = node;
}
/*============================================================================*/
static qList_Node_t* qList_RemoveFront( qList_t * const l )
{
    qList_Node_t *removed;

    removed = l->head;
    l->head = removed->next;
    if ( NULL == l->head ) {
        l->tail = l->head;
    }
    else {
        l->head->prev = NULL;
    }

    return removed;
}
/*============================================================================*/
static qList_Node_t* qList_RemoveBack( qList_t * const l )
{
    qList_Node_t *removed;

    removed = l->tail;
    l->tail = removed->prev;
    if ( NULL == l->tail ) {
        l->head = l->tail;
    }
    else {
        l->tail->next = NULL;
    }

    return removed;
}
/*============================================================================*/
static qList_Node_t* qList_GetiNode( const qList_t *const l,
                                     const qList_Position_t p )
{
    qList_Node_t *iNode;
    qBase_t iPos = 0;

    for ( iNode = l->head ; ( iPos < (qBase_t)p ) && ( NULL != iNode->next ) ; iNode = iNode->next ) {
        ++iPos;
    }

    return iNode;
}
/*============================================================================*/
qBool_t qList_Insert( qList_t *const l,
                      void * const node,
                      const qList_Position_t p )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != l ) && ( NULL != node ) && ( p >= (qList_Position_t)(-1) ) ) {
        if ( qFalse == qList_IsMember( l, node ) ) {
            qList_Node_t *newNode;

            newNode = qList_NodeInit( node );
            retValue = qTrue;
            if ( NULL == l->head ) { /*list is empty*/
                l->head = newNode;
                l->tail = newNode;
            }
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            else if ( QLIST_ATFRONT == p ) {
                qList_InsertAtFront( l, (qList_Node_t*)node ); /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            }
            else if ( p >= ( (qList_Position_t)l->size - 1 ) ) {
                qList_InsertAtBack( l, (qList_Node_t*)node ); /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            }
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            else { /*insert the new node after the position*/
                qList_Node_t *iNode;

                iNode = qList_GetiNode( l, p );
                newNode->next = iNode->next;  /* NEW -> (i+1)NODE */
                newNode->prev = iNode;        /* iNODE <- NEW */
                iNode->next->prev = newNode;  /* NEW <- (i+1)NODE */
                iNode->next = newNode;        /* iNODE -> NEW */
            }                                 /* result: iNODE <-> NEW <-> (i+1)NODE*/
            ++l->size;
            newNode->container = l;
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qList_RemoveItself( void * const node )
{
    qBool_t retValue = qFalse;

    if ( NULL != node ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qList_Node_t *toRemove = (qList_Node_t*)node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */

        if ( NULL != toRemove->container ) {
            qList_t *l;

            l = (qList_t*)toRemove->container; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            if ( toRemove == l->head ) {
                (void)qList_RemoveFront( l );
            }
            else if ( toRemove == l->tail ) {
                (void)qList_RemoveBack( l );
            }
            else {
                toRemove->prev->next = toRemove->next;
                if ( NULL != toRemove->next ) {
                    toRemove->next->prev = toRemove->prev;
                }
            }
            --l->size;
            toRemove->container = NULL;
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
void* qList_Remove( qList_t * const l,
                    void * const node,
                    const qList_Position_t p )
{
    qList_Node_t *removed = NULL;

    if ( ( NULL != l->head ) && ( p >= (qList_Position_t)(-1) ) ) {
        if ( qList_IsMember( l, node ) ) {
            if ( qList_RemoveItself( node ) ) {
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
                removed = (qList_Node_t*)node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
                /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            }
        }
        else {
            if ( p <= (qList_Position_t)0 ) {
                removed = qList_RemoveFront( l );
            }
            else if ( p > ( (qList_Position_t)l->size - 1 ) ) {
                removed = qList_RemoveBack( l );
            }
            else {
                qList_Node_t *iNode;
                qBase_t lastIndex = ( (qBase_t)p - 1 );

                iNode = qList_GetiNode( l, (qList_Position_t)lastIndex );
                removed = iNode->next; /* <-> (inode0) <-> inode1 <-> inode2 */
                iNode->next = removed->next;
                if ( NULL != removed->next ) {
                    iNode->next->prev = iNode;
                }
            }
            removed->container = NULL;
            --l->size;
        }
    }

    return removed;
}
/*============================================================================*/
qBool_t qList_Move( qList_t *const dst,
                    qList_t *const src,
                    const qList_Position_t p )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != dst ) && ( NULL != src ) && ( p >= (qList_Position_t)(-1) ) ) {
        if ( NULL != src->head) { /*source has items*/
            (void)qList_ForEach( src,
                                 qList_ChangeContainer,
                                 dst,
                                 QLIST_FORWARD,
                                 NULL );
            if ( NULL == dst->head ) { /*destination is empty*/
                dst->head = src->head;
                dst->tail = src->tail;
            }
            else if ( QLIST_ATFRONT == p ) {
                src->tail->next = dst->head;
                dst->head->prev = src->tail;
                dst->head = src->head;
            }
            else if ( p >= ( (qList_Position_t)dst->size - 1 ) ) {
                dst->tail->next = src->head;
                src->head->prev = dst->tail;
                dst->tail = src->tail;
            }
            else { /*insert the new list after the position*/
                qList_Node_t *iNode;

                iNode = qList_GetiNode( dst, p );
                src->tail->next = iNode->next;
                src->head->prev = iNode;
                iNode->next = src->head;
            }
            dst->size += src->size;
            retValue = qList_Initialize( src ); /*clean up source*/
        }
    }

    return retValue;
}
/*============================================================================*/
static qBool_t qList_ChangeContainer( qList_ForEachHandle_t h )
{
    if ( qList_WalkThrough == h->stage ) {
        qList_Node_t *xNode;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        xNode = (qList_Node_t*)h->node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        xNode->container = h->arg; /*new container stored into <arg>*/
    }

    return qFalse;
}
/*============================================================================*/
qBool_t qList_IsMember( const qList_t * const l,
                        const void * const node )
{
    qBool_t retValue = qFalse;

    if ( NULL != node ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        const qList_Node_t * const xNode = (const qList_Node_t * const)node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */

        if ( l == (const qList_t * const)xNode->container ) { /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            retValue = qTrue;
        }
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    }

    return retValue;
}
/*============================================================================*/
void* qList_GetFront( const qList_t * const l )
{
    void *retValue = NULL;

    if ( NULL != l ) {
        retValue = (void*)l->head;
    }

    return retValue;
}
/*============================================================================*/
void* qList_GetBack( const qList_t * const l )
{
    void *retValue = NULL;

    if ( NULL != l ) {
        retValue = (void*)l->tail;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qList_IsEmpty( const qList_t * const l )
{
    qBool_t retValue = qTrue;

    if ( NULL != l ) {
        retValue = ( NULL == l->head )? qTrue : qFalse;
    }
    return retValue;
}
/*============================================================================*/
size_t qList_Length( const qList_t * const l )
{
    size_t retValue = 0u;

    if ( NULL != l ) {
        retValue = l->size;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qList_Sort( qList_t * const l,
                    qList_CompareFcn_t f )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != l ) && ( NULL != f ) ) {
        size_t count = l->size;

        if ( count >= 2u ) {
            qList_Node_t *current = NULL, *before, *after;
            _qList_CompareHandle_t xHandle;
            size_t i, j;
            qBool_t xRetCmp;

            for ( i = 1u ; i < count ; ++i ) {
                size_t n = count - i - 1u;
                current = l->head;
                for ( j = 0u; j <= n; ++j ) {
                    xHandle.n1 = current;
                    xHandle.n2 = current->next;
                    xRetCmp = f( &xHandle );
                    if ( qTrue == xRetCmp ) { /*compare adjacent nodes*/
                        before = current->prev;
                        after = current->next;

                        if ( NULL != before ) {
                            before->next = after;
                        }
                        else {
                            /*
                            In case <before> pointer is null, <after> pointer
                            should be the new head
                            */
                            l->head = after;
                        }
                        current->next = after->next;
                        current->prev = after;

                        if ( NULL != after->next ) {
                            after->next->prev = current;
                        }

                        after->next = current;
                        after->prev = before;
                        retValue = qTrue;
                    }
                    else {
                        /*
                        Go to next node only if :
                        current->data > current->next->data
                        condition is false.
                        */
                        current = current->next;
                    }
                }
            }
            /*loop remaining nodes until find the new tail*/
            while ( NULL != current->next ) {
                current = current->next;
            }
            l->tail = current;
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qList_IteratorSet( qList_Iterator_t *i,
                           qList_t *const l,
                           void *nodeOffset,
                           qList_Direction_t d )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != l ) && ( NULL != i ) && ( ( &QLIST_FORWARD == d ) || ( &QLIST_BACKWARD == d ) ) ) {
        qList_Node_t *offset;

        i->direction = d;
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        offset = (qList_Node_t*)nodeOffset; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        if ( NULL != offset ) {
            if ( l == offset->container ) {
                i->next = offset;
                retValue = qTrue;
            }
        }
        else {
            i->next = ( QLIST_FORWARD == d )? l->head : l->tail;
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
void* qList_IteratorGetNext( qList_Iterator_t *i )
{
    void *iNode = NULL;

    if ( NULL != i ) {
        iNode = i->next;
        if ( NULL != iNode ) {
            i->next = i->direction( i->next );
        }
    }

    return iNode;
}
/*============================================================================*/
qBool_t qList_ForEach( qList_t *const l,
                       const qList_NodeFcn_t f,
                       void *arg,
                       qList_Direction_t d,
                       void *nodeOffset )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != l ) && ( NULL != f ) && ( ( &QLIST_FORWARD == d ) || ( &QLIST_BACKWARD == d ) ) ) {
        if ( NULL != l->head ) { /*walk the list only if it has items*/
            qList_Node_t *iNode;
            qList_Node_t *adjacent; /*to allow i-node links to be changed in the walk-through*/
            _qList_ForEachHandle_t xHandle = { NULL, arg, qList_WalkInit };
            /*select starting point*/
            adjacent = ( &QLIST_FORWARD == d )? l->head : l->tail;
            if ( NULL != nodeOffset ) { /*offset request?*/
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
                iNode = (qList_Node_t*)nodeOffset; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
                /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
                if( iNode->container == l ){ /*the offset belongs to the list?*/
                    adjacent = iNode; /*take offset as a starting point*/
                }
            }
            /*run initial stage before looping through list*/
            retValue = f( &xHandle );
            if ( qFalse == retValue ) { /*check if initial stage allows us to continue*/
                xHandle.stage = qList_WalkThrough;
                for ( iNode = adjacent ; NULL != iNode ; iNode = adjacent ) {
                    /*Save adjacent node if current node changes its links. */
                    adjacent = d( iNode );
                    xHandle.node = iNode;
                    retValue = f( &xHandle ); /*perform action over the node*/
                    if ( retValue ) { /*check if the last node handling breaks the loop*/
                        break;
                    }
                }
                if ( qFalse == retValue ) {
                    /*last node allows to continue, run the ending stage*/
                    xHandle.node = NULL;
                    xHandle.stage = qList_WalkEnd;
                    retValue = f( &xHandle );
                }
            }
        }
    }

    return retValue;
}
/*============================================================================*/
qList_Node_t* _qNode_Forward( const qList_Node_t *const n )
{
    return n->next;
}
/*============================================================================*/
qList_Node_t* _qNode_Backward( const qList_Node_t *const n )
{
    return n->prev;
}
/*============================================================================*/
qBool_t qList_Swap( void *node1,
                    void *node2 )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != node1 ) && ( NULL != node2 ) && ( node1 != node2 ) ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qList_Node_t *n1 = (qList_Node_t*)node1; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        qList_Node_t *n2 = (qList_Node_t*)node2; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */

        if ( ( NULL != n1->container ) && ( n1->container == n2->container ) ) {
            /*nodes are part of the same list*/
            qList_Node_t *tmp1, *tmp2;

            if ( n2->next == n1 ) {
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
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
static void qList_GivenNodes_SwapBoundaries( qList_Node_t *n1,
                                             qList_Node_t *n2 )
{
    qList_t *list;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    list = (qList_t*)n1->container; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    /*update the list links*/
    if ( list->head == n1 ) {
        list->head = n2;
    }
    else if ( list->head == n2 ) {
        list->head = n1;
    }
    else {
        /*nothing to do here*/
    }
    if ( list->tail == n1 ) {
        list->tail = n2;
    }
    else if ( list->tail == n2 ) {
        list->tail = n1;
    }
    else {
        /*nothing to do here*/
    }
}
/*============================================================================*/
static void qList_GivenNodes_SwapAdjacent( qList_Node_t *n1,
                                           qList_Node_t *n2 )
{
    /*check for adjacent nodes*/
    if ( ( ( n1->next == n2 ) && ( n2->prev == n1 ) ) || ( ( n1->prev == n2 ) && ( n2->next == n1 ) ) ) {
        n1->prev = n1->next;
        n2->next = n2->prev;
    }
    else {
        n1->prev = n2->prev;
        n2->next = n1->next;
    }
}
/*============================================================================*/
static void qList_GivenNodes_UpdateOuterLinks( qList_Node_t *n1,
                                               qList_Node_t *n2 )
{
    if ( NULL != n1->prev ) {
        n1->prev->next = n1;
    }
    if ( NULL != n1->next ) {
        n1->next->prev = n1;
    }
    if ( NULL != n2->prev ) {
        n2->prev->next = n2;
    }
    if ( NULL != n2->next ) {
        n2->next->prev = n2;
    }
}
/*============================================================================*/
