/*!
 * @file qedgecheck.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qedgecheck.h"
#include <string.h>

#if ( Q_EDGE_CHECK_IOGROUPS == 1 )

#define QEDGECHECK_REG_FCN_DEF(NAME, TYPE)                                  \
_QEDGECHECK_REG_FCN_DEC(NAME)                                               \
{                                                                           \
    TYPE reg, mask, xBit = (TYPE)pinNumber;                                 \
    mask = (TYPE)( (TYPE)1uL << xBit );                                     \
    reg = *( (const TYPE*)addr );                                           \
    return ( (TYPE)0u != ( reg & mask ) );                                  \
}                                                                           \

/*! @cond  */
/*cstat -CERT-INT34-C_a -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
QEDGECHECK_REG_FCN_DEF( _qReg_32Bits, qUINT32_t )
QEDGECHECK_REG_FCN_DEF( _qReg_16Bits, qUINT16_t )
QEDGECHECK_REG_FCN_DEF( _qReg_08Bits, qUINT8_t )
/*cstat +CERT-INT34-C_a +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
/*! @endcond  */

static void qEdgeCheck_StateWait( qEdgeCheck_t * const ec );
static void qEdgeCheck_StateCheck( qEdgeCheck_t * const ec );
static void qEdgeCheck_StateUpdate( qEdgeCheck_t * const ec );

typedef void (*qEdgeCheck_NodeIteratorFcn_t)( qEdgeCheck_IONode_t *n, qBool_t v, void *arg );
static void qEdgeCheck_NodeChangeIterator( qEdgeCheck_t * const ec, qEdgeCheck_NodeIteratorFcn_t fcn, void *arg );
static void qEdgeCheck_IterNodeStateCheck( qEdgeCheck_IONode_t *n, qBool_t v, void *arg );
static void qEdgeCheck_IterNodeStateUpdate( qEdgeCheck_IONode_t *n, qBool_t v, void *arg );

/*============================================================================*/
qBool_t qEdgeCheck_Setup( qEdgeCheck_t * const ec,
                          const qCoreRegSize_t rSize,
                          const qClock_t debounceTime )
{
    qBool_t retValue = qFalse;

    if ( NULL != ec ) {
        (void)memset( ec, 0, sizeof(qEdgeCheck_t) );
        ec->qPrivate.head = NULL;
        ec->qPrivate.debounceTime = debounceTime;
        ec->qPrivate.reader = ( NULL == rSize ) ? &QREG_32BIT : rSize;
        ec->qPrivate.state = &qEdgeCheck_StateCheck;
        ec->qPrivate.start = qClock_GetTick();
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Add_Node( qEdgeCheck_t * const ec,
                             qEdgeCheck_IONode_t * const n,
                             void *portAddress,
                             const qBool_t pinNumber )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != n ) && ( NULL != ec ) ) {
        qCoreRegSize_t pinReader = ec->qPrivate.reader;

        (void)memset( n, 0, sizeof(qEdgeCheck_IONode_t) );
        n->qPrivate.xPort = portAddress;
        n->qPrivate.xPin = pinNumber;
        n->qPrivate.next = ec->qPrivate.head;
        /*some compilers cant deal with function pointers inside structs*/
        n->qPrivate.prevPinValue = pinReader( n->qPrivate.xPort, n->qPrivate.xPin );
        ec->qPrivate.head = n;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
static void qEdgeCheck_StateWait( qEdgeCheck_t * const ec )
{
    if ( qClock_TimeDeadlineCheck( ec->qPrivate.start, ec->qPrivate.debounceTime ) ) {
        /*debounce time reached, update the inputlevel*/
        ec->qPrivate.state = &qEdgeCheck_StateUpdate;
    }
}
/*============================================================================*/
static void qEdgeCheck_NodeChangeIterator( qEdgeCheck_t * const ec, qEdgeCheck_NodeIteratorFcn_t fcn, void *arg )
{
    qCoreRegSize_t pinReader = ec->qPrivate.reader;
    qEdgeCheck_IONode_t *n;

    for ( n = ec->qPrivate.head ; NULL != n ; n = n->qPrivate.next ) {
        qBool_t v = pinReader( n->qPrivate.xPort, n->qPrivate.xPin );
        fcn( n, v, arg );
    }
}
/*============================================================================*/
static void qEdgeCheck_IterNodeStateCheck( qEdgeCheck_IONode_t *n, qBool_t v, void *arg )
{
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    size_t *nodeChange = (size_t *)arg;
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    /*check if input level change since the last inputs-sweep*/
    if ( n->qPrivate.prevPinValue != v ) {
        /*
          change detected, put the node on unknown status until the debounce
          wait finish
        */
        n->qPrivate.status = (qBool_t)qUnknown;
        /*to indicate that least one node changed its state*/
        nodeChange[ 0 ]++;
    }
    else {
        /* no change, let the state of the pin be equal to its own level*/
        n->qPrivate.status = v;
    }
}
/*============================================================================*/
static void qEdgeCheck_IterNodeStateUpdate( qEdgeCheck_IONode_t *n, qBool_t v, void *arg )
{
    Q_UNUSED( arg );
    if ( n->qPrivate.prevPinValue != v ) {
        /*set the edge status*/
        n->qPrivate.status = ( v ) ? qRising : qFalling;
    }
    /*keep the previous level*/
    n->qPrivate.prevPinValue = v;
}
/*============================================================================*/
static void qEdgeCheck_StateCheck( qEdgeCheck_t * const ec )
{
    size_t nodeChange = 0u;
    /*iterate through all the input-nodes*/
    qEdgeCheck_NodeChangeIterator( ec, &qEdgeCheck_IterNodeStateCheck, &nodeChange );

    if ( nodeChange > 0u ) {
        ec->qPrivate.state = &qEdgeCheck_StateWait;
    }
}
/*============================================================================*/
static void qEdgeCheck_StateUpdate( qEdgeCheck_t * const ec )
{
    qEdgeCheck_NodeChangeIterator( ec, &qEdgeCheck_IterNodeStateUpdate, NULL );
    ec->qPrivate.state = &qEdgeCheck_StateCheck; /*reload the init state*/
    ec->qPrivate.start = qClock_GetTick(); /*reload the time*/
}
/*============================================================================*/
qBool_t qEdgeCheck_Update( qEdgeCheck_t * const ec )
{
    qBool_t retValue = qFalse;

    if ( NULL != ec ) {
        ec->qPrivate.state( ec );
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Get_NodeStatus( const qEdgeCheck_IONode_t * const n )
{
    qBool_t retValue = qUnknown;

    if ( NULL != n ) {
        retValue = n->qPrivate.status;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Set_NodePin( qEdgeCheck_IONode_t * const n,
                                const qBool_t pinNumber )
{
    qBool_t retValue = qFalse;
    /*cstat -MISRAC2012-Rule-10.1_R3*/ /*false-positive*/
    if ( ( NULL != n ) && ( pinNumber < (qBool_t)32u ) ) {
    /*cstat +MISRAC2012-Rule-10.1_R3*/
        n->qPrivate.xPin = pinNumber;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/

#endif /* #if ( Q_EDGE_CHECK_IOGROUPS == 1 ) */
