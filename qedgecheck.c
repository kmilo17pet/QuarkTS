/*!
 * @file qedgecheck.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qedgecheck.h"
#include <string.h>

#if ( Q_EDGE_CHECK_IOGROUPS == 1 )

#define QEDGECHECK_WAIT                         ( (qUINT8_t)0u )
#define QEDGECHECK_UPDATE                       ( (qUINT8_t)1u )
#define QEDGECHECK_CHECK                        ( (qUINT8_t)2u )

#define QEDGECHECK_REG_FCN_DEF(NAME, TYPE)                                  \
_QEDGECHECK_REG_FCN_DEC(NAME)                                               \
{                                                                           \
    TYPE reg, mask, xBit = (TYPE)pinNumber;                                  \
    mask = (TYPE)( (TYPE)1uL << xBit );                                      \
    reg = *( (const TYPE*)addr );                                           \
    return ( (TYPE)0u != ( reg & mask ) );                                  \
}                                                                           \

/*! @cond  */
/*cstat -CERT-INT34-C_a -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
QEDGECHECK_REG_FCN_DEF( _qReg_32Bits, qUINT32_t );
QEDGECHECK_REG_FCN_DEF( _qReg_16Bits, qUINT16_t );
QEDGECHECK_REG_FCN_DEF( _qReg_08Bits,  qUINT8_t );
/*cstat +CERT-INT34-C_a +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
/*! @endcond  */

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
        ec->qPrivate.reader = ( NULL == rSize )? &QREG_32BIT : rSize;
        ec->qPrivate.state = QEDGECHECK_CHECK;
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
        const qCoreRegSize_t pinReader = ec->qPrivate.reader;

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
qBool_t qEdgeCheck_Update( qEdgeCheck_t * const ec )
{
    qBool_t retValue = qFalse;

    if ( NULL != ec ) {
        if ( QEDGECHECK_WAIT == ec->qPrivate.state ) { /*de-bounce wait state*/
            if ( qClock_TimeDeadlineCheck( ec->qPrivate.start, ec->qPrivate.debounceTime ) ) {
                /*debounce time reached, update the inputlevel*/
                ec->qPrivate.state = QEDGECHECK_UPDATE;
            }
            retValue = qTrue;
        }
        else {
            qBool_t v; /*to hold the current pin value*/
            qEdgeCheck_IONode_t *n;
            const qCoreRegSize_t pinReader = ec->qPrivate.reader;
            /*iterate through all the input-nodes*/
            for ( n = ec->qPrivate.head ; NULL != n ; n = n->qPrivate.next ) {
                /*read the pin level*/
                v = pinReader( n->qPrivate.xPort, n->qPrivate.xPin );
                if ( ec->qPrivate.state >= QEDGECHECK_CHECK ) {
                    /*check if input level change since the last inputs-sweep*/
                    if ( n->qPrivate.prevPinValue != v ) {
                        /*
                          change detected, put the node on unknown status until
                          the debounce wait finish
                        */
                        n->qPrivate.status = (qBool_t)qUnknown;
                        /*to indicate that least one node changed its state*/
                        ec->qPrivate.state++;
                    }
                    else {
                        /*
                        if there is no change, let the state of the pin be equal
                        to its own level
                        */
                        n->qPrivate.status = v;
                    }
                }
                else if ( QEDGECHECK_UPDATE == ec->qPrivate.state ) {
                    /*if the level change is effective*/
                    if ( n->qPrivate.prevPinValue != v ) {
                        /*set the edge status*/
                        n->qPrivate.status = ( v )? qRising : qFalling;
                    }
                    /*keep the previous level*/
                    n->qPrivate.prevPinValue = v;
                }
                else {
                    /*nothing to do*/
                }
            }
            /*reload the instance to a full check*/
            if ( QEDGECHECK_UPDATE == ec->qPrivate.state ) {
                ec->qPrivate.state = QEDGECHECK_CHECK; /*reload the init state*/
                ec->qPrivate.start = qClock_GetTick(); /*reload the time*/
            }
            if ( ec->qPrivate.state > QEDGECHECK_CHECK ) {
                /*at least one pin change detected, do the de-bounce wait*/
                ec->qPrivate.state = QEDGECHECK_WAIT;
            }
            retValue = qTrue;
        }
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
