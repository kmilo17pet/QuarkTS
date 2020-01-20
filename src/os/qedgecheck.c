#include "qedgecheck.h"

#if ( Q_EDGE_CHECK_IOGROUPS == 1 )

/*============================================================================*/
/*qBool_t qEdgeCheck_Initialize(qIOEdgeCheck_t * const Instance, const qCoreRegSize_t RegisterSize, const qClock_t DebounceTime)
 
Initialize a I/O Edge-Check instance 

Parameters:

    - Instance : A pointer to the I/O Edge-Check object
    - RegisterSize: The specific-core register size: QREG_8BIT, QREG_16BIT or QREG_32BIT(Default)
    - DebounceTime : The specified time to bypass the bounce of the input nodes
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qEdgeCheck_Initialize( qIOEdgeCheck_t * const Instance, const qCoreRegSize_t RegisterSize, const qClock_t DebounceTime ){
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
/*qBool_t qEdgeCheck_InsertNode(qIOEdgeCheck_t * const Instance, qIONode_t * const Node, void *PortAddress, const qBool_t PinNumber)
 
Initialize an I/O Edge-Check instance 

Parameters:

    - Instance : A pointer to the I/O Edge-Check object
    - Node: A pointer to the Input-Node object
    - PortAddress : The address of the core PORTx-register to read the levels of the specified PinNumber
    - PinNumber : The specified Pin to read from PortAddress 
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qEdgeCheck_InsertNode( qIOEdgeCheck_t * const Instance, qIONode_t * const Node, void *PortAddress, const qBool_t PinNumber ){
    qBool_t RetValue = qFalse;
    qCoreRegSize_t PinReader;
    if( ( NULL != Node ) && ( NULL != Instance ) ){
        Node->qPrivate.Port = PortAddress;
        Node->Pin = PinNumber;
        Node->qPrivate.Next = Instance->qPrivate.Head;
        PinReader = Instance->qPrivate.Reader;
        Node->qPrivate.PreviousPinValue = PinReader( Node->qPrivate.Port, Node->Pin ); /*some compilers cant deal with function pointers inside structs*/
        Instance->qPrivate.Head = Node;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qEdgeCheck_Update(qIOEdgeCheck_t * const Instance)
 
Update the status of all nodes inside the I/O Edge-Check instance (Non-Blocking call).

Parameters:

    - Instance : A pointer to the I/O Edge-Check object
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
/*============================================================================*/
qBool_t qEdgeCheck_Update( qIOEdgeCheck_t * const Instance ){
    qIONode_t *Node;
    qBool_t CurrentPinValue;
    qBool_t RetValue = qFalse;   
    qCoreRegSize_t PinReader;
    if( NULL != Instance ){
        if( QEDGECHECK_WAIT == Instance->qPrivate.State ){ /*de-bounce wait state*/
            if( ( qClock_GetTick() - Instance->qPrivate.Start ) >= Instance->qPrivate.DebounceTime ){
                Instance->qPrivate.State = QEDGECHECK_UPDATE; /*debounce time reached, update the inputlevel*/ 
            }      
            RetValue = qTrue;
        }
        else{
            PinReader = Instance->qPrivate.Reader;
            for( Node = Instance->qPrivate.Head ; NULL != Node ; Node = Node->qPrivate.Next ){ /*iterate through all the input-nodes*/
                CurrentPinValue = PinReader( Node->qPrivate.Port, Node->Pin ); /*read the pin level*/        
                if( Instance->qPrivate.State >= QEDGECHECK_CHECK ){ /*check state*/
                    if( Node->qPrivate.PreviousPinValue != CurrentPinValue ){ /*check if the input level change since the last inputs-sweep*/
                        Node->Status = (qBool_t)qUNKNOWN; /*change detected, put the node on unknown status until the debounce wait finish*/
                        Instance->qPrivate.State++; /* just to know that at least one node changed its state(count of nodes subject to the range of qUINT8_t)*/
                    }
                    else{
                        Node->Status = CurrentPinValue; /*if there is no change, let the state of the pin be equal to its own level*/
                    } 
                }
                else if( QEDGECHECK_UPDATE == Instance->qPrivate.State ){ /*update state*/
                    if( Node->qPrivate.PreviousPinValue != CurrentPinValue ){ /*if the level change is effective*/
                        Node->Status = ( CurrentPinValue )? qRISING : qFALLING; /*set the edge status*/
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
/*qBool_t qEdgeCheck_GetNodeStatus(const qIONode_t * const Node)
 
Query the status of the specified input-node.

Parameters:

    - Node : Node: A pointer to the Input-Node object
  
Return value:

    The status of the input node : qTrue, qFalse, qRising, qFalling or qUnknown
*/
qBool_t qEdgeCheck_GetNodeStatus( const qIONode_t * const Node ){
    return Node->Status;
}
/*============================================================================*/
/*                        PRIVATE METHODS, DONT USE THEM                      */
/*============================================================================*/
qBool_t __qReg_32Bits( const void *Address, qBool_t PinNumber ){
    qUINT32_t Register, Mask, Bit = (qUINT32_t)PinNumber;
    Mask = (qUINT32_t)1uL << Bit; 
    Register = *((const qUINT32_t*)Address); /*MISRAC2012-Rule-11.5 deviation allowed*/  
    return ( 0uL != (Register & Mask) );
}
/*============================================================================*/
qBool_t __qReg_16Bits( const void *Address, qBool_t PinNumber ){
    qUINT16_t Register, Mask, Bit = (qUINT16_t)PinNumber;
    Mask = (qUINT16_t)1u << Bit;
    Register = *( (const qUINT16_t*)Address ); /*MISRAC2012-Rule-11.5 deviation allowed*/
    return ( 0u != ( Register & Mask ) );
}
/*============================================================================*/
qBool_t __qReg_08Bits( const void *Address, qBool_t PinNumber ){
    qUINT8_t Register, Mask, Bit = (qUINT8_t)PinNumber;;
    Mask = (qUINT8_t)1u << Bit;
    Register = *((const qUINT8_t*)Address); /*MISRAC2012-Rule-11.5 deviation allowed*/
    return ( 0u != ( Register & Mask ) );
}
/*============================================================================*/

#endif /* #if ( Q_EDGE_CHECK_IOGROUPS == 1 ) */