#include "qedgecheck.h"

#if ( Q_EDGE_CHECK_IOGROUPS == 1 )

/*============================================================================*/
qBool_t __qReg_32Bits( void *Address, qBool_t PinNumber ){
    uint32_t Register = 0ul;
    Register = *((uint32_t*)Address);    
    return (Register & (1ul << PinNumber))? qFalse : qTrue;
}
/*============================================================================*/
qBool_t __qReg_16Bits( void *Address, qBool_t PinNumber ){
    uint16_t Register = 0u;
    uint16_t Mask;
    Mask = (uint16_t)1u << (uint16_t)PinNumber;
    Register = *( (uint16_t*)Address );
    return ( Register & Mask )? qFalse : qTrue;
}
/*============================================================================*/
qBool_t __qReg_08Bits( void *Address, qBool_t PinNumber ){
    uint8_t Register = 0u;
    Register = *((uint8_t*)Address);
    return ( Register & (1u << PinNumber) )? qFalse : qTrue;
}
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
        Instance->private.Head = NULL;
        Instance->private.DebounceTime = DebounceTime;
        Instance->private.Reader = ( NULL == RegisterSize )? QREG_32BIT  : RegisterSize;
        Instance->private.State = QEDGECHECK_CHECK;
        Instance->private.Start = qClock_GetTick();
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
        Node->private.Port = PortAddress;
        Node->Pin = PinNumber;
        Node->private.Next = Instance->private.Head;
        PinReader = Instance->private.Reader;
        Node->private.PreviousPinValue = PinReader( Node->private.Port, Node->Pin ); /*some compilers cant deal with function pointers inside structs*/
        Instance->private.Head = Node;
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
        if( QEDGECHECK_WAIT == Instance->private.State ){ /*de-bounce wait state*/
            if( ( qClock_GetTick() - Instance->private.Start ) >= Instance->private.DebounceTime ){
                Instance->private.State = QEDGECHECK_UPDATE; /*debounce time reached, update the inputlevel*/ 
            }      
            RetValue = qTrue;
        }
        else{
            PinReader = Instance->private.Reader;
            for( Node = Instance->private.Head ; NULL != Node ; Node = Node->private.Next ){ /*iterate through all the input-nodes*/
                CurrentPinValue = PinReader( Node->private.Port, Node->Pin ); /*read the pin level*/        
                if( Instance->private.State >= QEDGECHECK_CHECK ){ /*check state*/
                    if( Node->private.PreviousPinValue != CurrentPinValue ){ /*check if the input level change since the last inputs-sweep*/
                        Node->Status = qUNKNOWN; /*change detected, put the node on unknown status until the debounce wait finish*/
                        Instance->private.State++; /* just to know that at least one node changed its state(count of nodes subject to the range of uint8_t)*/
                    }
                    else{
                        Node->Status = CurrentPinValue; /*if there is no change, let the state of the pin be equal to its own level*/
                    } 
                }
                else if( QEDGECHECK_UPDATE == Instance->private.State ){ /*update state*/
                    if( Node->private.PreviousPinValue != CurrentPinValue ){ /*if the level change is effective*/
                        Node->Status = ( CurrentPinValue )? qRISING : qFALLING; /*set the edge status*/
                    }      
                    Node->private.PreviousPinValue = CurrentPinValue; /*keep the previous level*/
                }
                else{
                    /*nothing to do*/
                }
            }       
        
            if( QEDGECHECK_UPDATE == Instance->private.State ){ /*reload the instance to a full check*/
                Instance->private.State = QEDGECHECK_CHECK; /*reload the init state*/
                Instance->private.Start = qClock_GetTick(); /*reload the time*/
            }
            if( Instance->private.State > QEDGECHECK_CHECK ){
                Instance->private.State = QEDGECHECK_WAIT; /*at least one pin change detected, do the de-bounce wait*/
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

#endif /* #if ( Q_EDGE_CHECK_IOGROUPS == 1 ) */