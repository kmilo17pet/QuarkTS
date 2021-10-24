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
#define _QEDGECHECK_REG_FCN_DEF(NAME, TYPE)     _QEDGECHECK_REG_FCN_DEC(NAME) \
                                                { \
                                                    TYPE Register, Mask, Bit = (TYPE)PinNumber; \
                                                    Mask = (TYPE)( (TYPE)1uL << Bit ); \
                                                    Register = *( (const TYPE*)Address ); \
                                                    return ( (TYPE)0u != ( Register & Mask ) ); \
                                                } \

/*! @cond  */
/*cstat -CERT-INT34-C_a -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
_QEDGECHECK_REG_FCN_DEF( _qReg_32Bits, qUINT32_t );
_QEDGECHECK_REG_FCN_DEF( _qReg_16Bits, qUINT16_t );
_QEDGECHECK_REG_FCN_DEF( _qReg_08Bits,  qUINT8_t );
/*cstat +CERT-INT34-C_a +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
/*! @endcond  */

/*============================================================================*/
qBool_t qEdgeCheck_Setup( qEdgeCheck_t * const ec, const qCoreRegSize_t rSize, const qClock_t debounceTime )
{
    qBool_t retValue = qFalse;

    if ( NULL != ec ) {
        (void)memset( ec, 0, sizeof(qEdgeCheck_t) );
        ec->qPrivate.Head = NULL;
        ec->qPrivate.DebounceTime = debounceTime;
        ec->qPrivate.Reader = ( NULL == rSize )? &QREG_32BIT  : rSize;
        ec->qPrivate.State = QEDGECHECK_CHECK;
        ec->qPrivate.Start = qClock_GetTick();
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Add_Node( qEdgeCheck_t * const ec, qEdgeCheck_IONode_t * const n, void *portAddress, const qBool_t pinNumber )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != n ) && ( NULL != ec ) ) {
        qCoreRegSize_t pinReader = ec->qPrivate.Reader;

        (void)memset( n, 0, sizeof(qEdgeCheck_IONode_t) );
        n->qPrivate.Port = portAddress;
        n->qPrivate.Pin = pinNumber;
        n->qPrivate.Next = ec->qPrivate.Head;
        n->qPrivate.PreviousPinValue = pinReader( n->qPrivate.Port, n->qPrivate.Pin ); /*some compilers cant deal with function pointers inside structs*/
        ec->qPrivate.Head = n;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Update( qEdgeCheck_t * const ec )
{
    qBool_t retValue = qFalse;   

    if ( NULL != ec ) { 
        if ( QEDGECHECK_WAIT == ec->qPrivate.State ) { /*de-bounce wait state*/
            if ( ( qClock_GetTick() - ec->qPrivate.Start ) >= ec->qPrivate.DebounceTime ) {
                ec->qPrivate.State = QEDGECHECK_UPDATE; /*debounce time reached, update the inputlevel*/ 
            }      
            retValue = qTrue;
        }
        else {
            qBool_t v; /*to hold the current pin value*/
            qEdgeCheck_IONode_t *n;
            const qCoreRegSize_t pinReader = ec->qPrivate.Reader;
            
            for ( n = ec->qPrivate.Head ; NULL != n ; n = n->qPrivate.Next ) { /*iterate through all the input-nodes*/
                v = pinReader( n->qPrivate.Port, n->qPrivate.Pin ); /*read the pin level*/        
                if ( ec->qPrivate.State >= QEDGECHECK_CHECK ) { /*check state*/
                    if ( n->qPrivate.PreviousPinValue != v ) { /*check if the input level change since the last inputs-sweep*/
                        n->qPrivate.Status = (qBool_t)qUnknown; /*change detected, put the node on unknown status until the debounce wait finish*/
                        ec->qPrivate.State++; /* just to know that at least one node changed its state(count of nodes subject to the range of qUINT8_t)*/
                    }
                    else {
                        n->qPrivate.Status = v; /*if there is no change, let the state of the pin be equal to its own level*/
                    } 
                }
                else if ( QEDGECHECK_UPDATE == ec->qPrivate.State ) { /*update state*/
                    if ( n->qPrivate.PreviousPinValue != v ) { /*if the level change is effective*/
                        n->qPrivate.Status = ( v )? qRising : qFalling; /*set the edge status*/
                    }      
                    n->qPrivate.PreviousPinValue = v; /*keep the previous level*/
                }
                else {
                    /*nothing to do*/
                }
            }       
        
            if ( QEDGECHECK_UPDATE == ec->qPrivate.State ) { /*reload the instance to a full check*/
                ec->qPrivate.State = QEDGECHECK_CHECK; /*reload the init state*/
                ec->qPrivate.Start = qClock_GetTick(); /*reload the time*/
            }
            if ( ec->qPrivate.State > QEDGECHECK_CHECK ) {
                ec->qPrivate.State = QEDGECHECK_WAIT; /*at least one pin change detected, do the de-bounce wait*/
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
        retValue = n->qPrivate.Status;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Set_NodePin( qEdgeCheck_IONode_t * const n, const qBool_t pinNumber )
{
    qBool_t retValue = qFalse;
    /*cstat -MISRAC2012-Rule-10.1_R3*/ /*false-positive*/
    if ( ( NULL != n ) && ( pinNumber < (qBool_t)32u ) ) {
    /*cstat +MISRAC2012-Rule-10.1_R3*/  
        n->qPrivate.Pin = pinNumber;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/

#endif /* #if ( Q_EDGE_CHECK_IOGROUPS == 1 ) */
