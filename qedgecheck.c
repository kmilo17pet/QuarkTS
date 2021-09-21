/*!
 * @file qedgecheck.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qedgecheck.h"

#if ( Q_EDGE_CHECK_IOGROUPS == 1 )

#define QEDGECHECK_WAIT                         ( (qUINT8_t)0u )
#define QEDGECHECK_UPDATE                       ( (qUINT8_t)1u )
#define QEDGECHECK_CHECK                        ( (qUINT8_t)2u )
#define _QEDGECHECK_REG_FCN_DEF(NAME, TYPE)     _QEDGECHECK_REG_FCN_DEC(NAME) \
                                                { \
                                                    TYPE Register, Mask, Bit = (TYPE)PinNumber; \
                                                    Mask = (TYPE)((TYPE)1uL << Bit); \
                                                    Register = *((const TYPE*)Address); \
                                                    return ( (TYPE)0 != (Register & Mask) ); \
                                                } \

/*! @cond  */
/*cstat -CERT-INT34-C_a -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
_QEDGECHECK_REG_FCN_DEF( _qReg_32Bits, qUINT32_t );
_QEDGECHECK_REG_FCN_DEF( _qReg_16Bits, qUINT16_t );
_QEDGECHECK_REG_FCN_DEF( _qReg_08Bits,  qUINT8_t );
/*cstat +CERT-INT34-C_a +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
/*! @endcond  */

/*============================================================================*/
qBool_t qEdgeCheck_Setup( qEdgeCheck_t * const Instance, const qCoreRegSize_t RegisterSize, const qClock_t DebounceTime )
{
    qBool_t RetValue = qFalse;

    if ( NULL != Instance ) {
        Instance->qPrivate.Head = NULL;
        Instance->qPrivate.DebounceTime = DebounceTime;
        Instance->qPrivate.Reader = ( NULL == RegisterSize )? &QREG_32BIT  : RegisterSize;
        Instance->qPrivate.State = QEDGECHECK_CHECK;
        Instance->qPrivate.Start = qClock_GetTick();
        RetValue = qTrue;
    }

    return RetValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Add_Node( qEdgeCheck_t * const Instance, qEdgeCheck_IONode_t * const Node, void *PortAddress, const qBool_t PinNumber )
{
    qBool_t RetValue = qFalse;

    if ( ( NULL != Node ) && ( NULL != Instance ) ) {
        qCoreRegSize_t PinReader = Instance->qPrivate.Reader;

        Node->qPrivate.Port = PortAddress;
        Node->qPrivate.Pin = PinNumber;
        Node->qPrivate.Next = Instance->qPrivate.Head;
        Node->qPrivate.PreviousPinValue = PinReader( Node->qPrivate.Port, Node->qPrivate.Pin ); /*some compilers cant deal with function pointers inside structs*/
        Instance->qPrivate.Head = Node;
        RetValue = qTrue;
    }

    return RetValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Update( qEdgeCheck_t * const Instance )
{
    qBool_t RetValue = qFalse;   

    if ( NULL != Instance ) { 
        if ( QEDGECHECK_WAIT == Instance->qPrivate.State ) { /*de-bounce wait state*/
            if ( ( qClock_GetTick() - Instance->qPrivate.Start ) >= Instance->qPrivate.DebounceTime ) {
                Instance->qPrivate.State = QEDGECHECK_UPDATE; /*debounce time reached, update the inputlevel*/ 
            }      
            RetValue = qTrue;
        }
        else {
            qBool_t CurrentPinValue;
            qEdgeCheck_IONode_t *Node;
            const qCoreRegSize_t PinReader = Instance->qPrivate.Reader;
            
            for ( Node = Instance->qPrivate.Head ; NULL != Node ; Node = Node->qPrivate.Next ) { /*iterate through all the input-nodes*/
                CurrentPinValue = PinReader( Node->qPrivate.Port, Node->qPrivate.Pin ); /*read the pin level*/        
                if ( Instance->qPrivate.State >= QEDGECHECK_CHECK ){ /*check state*/
                    if ( Node->qPrivate.PreviousPinValue != CurrentPinValue ) { /*check if the input level change since the last inputs-sweep*/
                        Node->qPrivate.Status = (qBool_t)qUnknown; /*change detected, put the node on unknown status until the debounce wait finish*/
                        Instance->qPrivate.State++; /* just to know that at least one node changed its state(count of nodes subject to the range of qUINT8_t)*/
                    }
                    else {
                        Node->qPrivate.Status = CurrentPinValue; /*if there is no change, let the state of the pin be equal to its own level*/
                    } 
                }
                else if ( QEDGECHECK_UPDATE == Instance->qPrivate.State ) { /*update state*/
                    if ( Node->qPrivate.PreviousPinValue != CurrentPinValue ) { /*if the level change is effective*/
                        Node->qPrivate.Status = ( CurrentPinValue )? qRising : qFalling; /*set the edge status*/
                    }      
                    Node->qPrivate.PreviousPinValue = CurrentPinValue; /*keep the previous level*/
                }
                else{
                    /*nothing to do*/
                }
            }       
        
            if ( QEDGECHECK_UPDATE == Instance->qPrivate.State ) { /*reload the instance to a full check*/
                Instance->qPrivate.State = QEDGECHECK_CHECK; /*reload the init state*/
                Instance->qPrivate.Start = qClock_GetTick(); /*reload the time*/
            }
            if ( Instance->qPrivate.State > QEDGECHECK_CHECK ) {
                Instance->qPrivate.State = QEDGECHECK_WAIT; /*at least one pin change detected, do the de-bounce wait*/
            }
            RetValue = qTrue;  
        }  
    }

    return RetValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Get_NodeStatus( const qEdgeCheck_IONode_t * const Node )
{
    qBool_t RetValue = qUnknown;

    if ( NULL != Node ) {
        RetValue = Node->qPrivate.Status;
    }

    return RetValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Set_NodePin( qEdgeCheck_IONode_t * const Node, const qBool_t PinNumber )
{
    qBool_t RetValue = qFalse;
    /*cstat -MISRAC2012-Rule-10.1_R3*/ /*false-positive*/
    if ( ( NULL != Node ) && ( PinNumber < (qBool_t)32u ) ) {
    /*cstat +MISRAC2012-Rule-10.1_R3*/  
        Node->qPrivate.Pin = PinNumber;
        RetValue = qTrue;
    }

    return RetValue;
}
/*============================================================================*/

#endif /* #if ( Q_EDGE_CHECK_IOGROUPS == 1 ) */
