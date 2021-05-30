/*!
 * @file qedgecheck.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qedgecheck.h"

#if ( Q_EDGE_CHECK_IOGROUPS == 1 )

#define QEDGECHECK_WAIT         ( (qUINT8_t)0u )
#define QEDGECHECK_UPDATE       ( (qUINT8_t)1u )
#define QEDGECHECK_CHECK        ( (qUINT8_t)2u )

/*============================================================================*/
qBool_t qEdgeCheck_Setup( qEdgeCheck_t * const Instance, const qCoreRegSize_t RegisterSize, const qClock_t DebounceTime ){
    qBool_t RetValue = qFalse;

    if( NULL != Instance ){
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
qBool_t qEdgeCheck_Add_Node( qEdgeCheck_t * const Instance, qEdgeCheck_IONode_t * const Node, void *PortAddress, const qBool_t PinNumber ){
    qBool_t RetValue = qFalse;

    if( ( NULL != Node ) && ( NULL != Instance ) ){
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
qBool_t qEdgeCheck_Update( qEdgeCheck_t * const Instance ){
    qBool_t RetValue = qFalse;   

    if( NULL != Instance ){ 
        if( QEDGECHECK_WAIT == Instance->qPrivate.State ){ /*de-bounce wait state*/
            if( ( qClock_GetTick() - Instance->qPrivate.Start ) >= Instance->qPrivate.DebounceTime ){
                Instance->qPrivate.State = QEDGECHECK_UPDATE; /*debounce time reached, update the inputlevel*/ 
            }      
            RetValue = qTrue;
        }
        else{
            qBool_t CurrentPinValue;
            qEdgeCheck_IONode_t *Node;
            const qCoreRegSize_t PinReader = Instance->qPrivate.Reader;
            
            for( Node = Instance->qPrivate.Head ; NULL != Node ; Node = Node->qPrivate.Next ){ /*iterate through all the input-nodes*/
                CurrentPinValue = PinReader( Node->qPrivate.Port, Node->qPrivate.Pin ); /*read the pin level*/        
                if( Instance->qPrivate.State >= QEDGECHECK_CHECK ){ /*check state*/
                    if( Node->qPrivate.PreviousPinValue != CurrentPinValue ){ /*check if the input level change since the last inputs-sweep*/
                        Node->qPrivate.Status = (qBool_t)qUnknown; /*change detected, put the node on unknown status until the debounce wait finish*/
                        Instance->qPrivate.State++; /* just to know that at least one node changed its state(count of nodes subject to the range of qUINT8_t)*/
                    }
                    else{
                        Node->qPrivate.Status = CurrentPinValue; /*if there is no change, let the state of the pin be equal to its own level*/
                    } 
                }
                else if( QEDGECHECK_UPDATE == Instance->qPrivate.State ){ /*update state*/
                    if( Node->qPrivate.PreviousPinValue != CurrentPinValue ){ /*if the level change is effective*/
                        Node->qPrivate.Status = ( CurrentPinValue )? qRising : qFalling; /*set the edge status*/
                    }      
                    Node->qPrivate.PreviousPinValue = CurrentPinValue; /*keep the previous level*/
                }
                else{
                    /*nothing to do*/
                }
            }       
        
            if( QEDGECHECK_UPDATE == Instance->qPrivate.State ){ /*reload the instance to a full check*/
                Instance->qPrivate.State = QEDGECHECK_CHECK; /*reload the init state*/
                Instance->qPrivate.Start = qClock_GetTick(); /*reload the time*/
            }
            if( Instance->qPrivate.State > QEDGECHECK_CHECK ){
                Instance->qPrivate.State = QEDGECHECK_WAIT; /*at least one pin change detected, do the de-bounce wait*/
            }
            RetValue = qTrue;  
        }  
    }
    return RetValue;
}
/*============================================================================*/
qBool_t qEdgeCheck_Get_NodeStatus( const qEdgeCheck_IONode_t * const Node ){
    qBool_t RetValue = qUnknown;

    if( NULL != Node ){
        RetValue = Node->qPrivate.Status;
    }
    return RetValue;
}
/*============================================================================*/
void qEdgeCheck_Set_NodePin( qEdgeCheck_IONode_t * const Node, const qBool_t PinNumber ){
    if( NULL != Node ){
        Node->qPrivate.Pin = PinNumber;
    }
}
/*============================================================================*/
/*                        PRIVATE METHODS, DONT USE THEM                      */
/*============================================================================*/
/*cstat -CERT-INT34-C_a -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
qBool_t _qReg_32Bits( const void *Address, qBool_t PinNumber ){ 
    qUINT32_t Register, Mask, Bit = (qUINT32_t)PinNumber; 

    Mask = (qUINT32_t)((qUINT32_t)1uL << Bit);
    Register = *((const qUINT32_t*)Address);
    return ( (qUINT32_t)0 != (Register & Mask) ); 
}
qBool_t _qReg_16Bits( const void *Address, qBool_t PinNumber ){
    qUINT16_t Register, Mask, Bit = (qUINT16_t)PinNumber; 

    Mask = (qUINT16_t)((qUINT16_t)1uL << Bit);
    Register = *((const qUINT16_t*)Address);
    return ( (qUINT16_t)0 != (Register & Mask) ); 
}
qBool_t _qReg_08Bits( const void *Address, qBool_t PinNumber ){
    qUINT8_t Register, Mask, Bit = (qUINT8_t)PinNumber; 
    
    Mask = (qUINT8_t)((qUINT8_t)1uL << Bit);
    Register = *((const qUINT8_t*)Address);
    return ( (qUINT8_t)0 != (Register & Mask) );
}
/*cstat +CERT-INT34-C_a +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
/*============================================================================*/

#endif /* #if ( Q_EDGE_CHECK_IOGROUPS == 1 ) */
