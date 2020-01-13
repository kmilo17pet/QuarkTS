#include "qfsm.h"

#if ( Q_FSM == 1 )

static void qStatemachine_ExecSubStateIfAvailable( const qSM_SubState_t substate, qSM_t * const obj );

/*============================================================================*/
/*qBool_t qStateMachine_Init(qSM_t * const obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);

Initializes a finite state machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - InitState : The first state to be performed. This argument is a pointer 
                  to a callback function, returning qSM_Status_t and with a 
                  qFSM_t pointer as input argument.
    - SuccessState : Sub-State performed after a state finish with return status 
                     qSM_EXIT_SUCCESS. This argument is a pointer to a callback
                     function with a qFSM_t pointer as input argument.
    - FailureState : Sub-State performed after a state finish with return status 
                     qSM_EXIT_FAILURE. This argument is a pointer to a callback
                     function with a qFSM_t pointer as input argument.
    - UnexpectedState : Sub-State performed after a state finish with return status
                        value between -32766 and 32767. This argument is a 
                        pointer to a callback function with a qFSM_t pointer
                        as input argument.

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qStateMachine_Init( qSM_t * const obj, qSM_State_t InitState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState, qSM_SubState_t BeforeAnyState ){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( NULL != InitState ) ){
        obj->NextState = InitState;
        obj->PreviousState = NULL;
        obj->StateFirstEntry  = qFalse;
        obj->PreviousReturnStatus = qSM_EXIT_SUCCESS;
        obj->qPrivate.Failure = FailureState;
        obj->qPrivate.Success = SuccessState;
        obj->qPrivate.Unexpected = UnexpectedState;
        obj->qPrivate.BeforeAnyState = BeforeAnyState;
        obj->qPrivate.TransitionTable = NULL;
        obj->LastState = NULL;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
static void qStatemachine_ExecSubStateIfAvailable( const qSM_SubState_t substate, qSM_t * const obj ){
    if( NULL != substate ){
        substate( obj );
    }
}
/*============================================================================*/
/*void qStateMachine_Run(qSM_t * const obj, void* Data)

Execute the Finite State Machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - Signal : The signal data used to produce a state changes if a 
              transition table is available.
    - Data : Represents the FSM arguments. All arguments must be passed by 
             reference and cast to (void *). Only one argument is allowed, so,
             for multiple arguments, create a structure that contains all of 
             the arguments and pass a pointer to that structure.
*/    
void qStateMachine_Run( qSM_t * const obj, void *Data ){
    qSM_State_t prev; /*used to hold the previous state*/
    if( NULL != obj ){
        obj->Data = Data;   /*pass the data through the fsm*/
        qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.BeforeAnyState , obj); /*eval the BeforeAnyState if available*/
        if( NULL != obj->NextState ){ /*eval nextState if available*/
            obj->StateFirstEntry = ( obj->LastState != obj->NextState )? qTrue : qFalse;  /*Get the StateFirstEntry flag*/
            if( obj->StateFirstEntry ){ /*if StateFistEntry is set, update the PreviousState*/
                obj->PreviousState = obj->LastState ; 
            }
            prev = obj->NextState; /*keep the next state in prev for LastState update*/
            obj->Signal = qStateMachine_SweepTransitionTable( obj ); /*sweep the table if available*/
            obj->PreviousReturnStatus = prev(obj); /*Eval the current state, and get their return status*/
            obj->LastState = prev; /*update the LastState*/
        }
        else{
            obj->PreviousReturnStatus = qSM_EXIT_FAILURE; /*otherwise jump to the failure state*/
        }
        /*Check return status to eval extra states*/
        if( qSM_EXIT_FAILURE == obj->PreviousReturnStatus ){
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.Failure, obj ); /*Run failure state if available*/
        }
        else if ( qSM_EXIT_SUCCESS == obj->PreviousReturnStatus ){
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.Success, obj ); /*Run success state if available*/
        } 
        else{
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.Unexpected, obj ); /*Run unexpected state if available*/
        }
    }
 }
/*============================================================================*/
/*void qStateMachine_Attribute(qSM_t * const obj, const qFSM_Attribute_t Flag , qSM_State_t  s, qSM_SubState_t subs)

Change attributes or set actions to the Finite State Machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - Flag: The attribute/action to be taken
         > qSM_RESTART : Restart the FSM (val argument must correspond to the init state)
         > qSM_CLEAR_STATE_FIRST_ENTRY_FLAG: clear the entry flag for the 
                current state if the NextState field doesn't change.
         > qSM_FAILURE_STATE: Set the Failure State
         > qSM_SUCCESS_STATE: Set the Success State
         > qSM_UNEXPECTED_STATE: Set the Unexpected State
         > qSM_BEFORE_ANY_STATE: Set the state executed before any state.
    - s : The new value for state (only apply in qSM_RESTART). If not used, pass NULL.
    - subs : The new value for SubState (only apply in qSM_FAILURE_STATE, qSM_SUCCESS_STATE, 
             qSM_UNEXPECTED_STATE, qSM_BEFORE_ANY_STATE). If not used, pass NULL.
*/    
void qStateMachine_Attribute( qSM_t * const obj, const qFSM_Attribute_t Flag , qSM_State_t  s, qSM_SubState_t subs ){
    switch(Flag){
        case qSM_RESTART:
            obj->NextState = s;
            obj->PreviousState = NULL;
            obj->LastState = NULL;
            obj->StateFirstEntry = qFalse;
            obj->PreviousReturnStatus = qSM_EXIT_SUCCESS;            
            break;
        case qSM_CLEAR_STATE_FIRST_ENTRY_FLAG:
            obj->PreviousState = NULL;
            obj->LastState = NULL;
            break;
        case qSM_FAILURE_STATE:
            obj->qPrivate.Failure = subs;        /*MISRAC2004-11.1 deviation allowed*/
            break;
        case qSM_SUCCESS_STATE:
            obj->qPrivate.Success = subs;        /*MISRAC2004-11.1 deviation allowed*/
            break;    
        case qSM_UNEXPECTED_STATE:
            obj->qPrivate.Unexpected = subs;     /*MISRAC2004-11.1 deviation allowed*/
            break;   
        case qSM_BEFORE_ANY_STATE:
            obj->qPrivate.BeforeAnyState = subs; /*MISRAC2004-11.1 deviation allowed*/
            break;              
        default:
            break;
    }
}
/*============================================================================*/
/*qBool_t qStateMachine_TransitionTableInstall( qSM_t * const obj, qSM_TransitionTable_t *table, qSM_Transition_t *entries, size_t NoOfEntries, qSignal_t *AxSignals, size_t MaxSignals)

Install a transition table for the supplied state machine instance.

Parameters:

    - obj : a pointer to the FSM object.
    - table: a pointer tot he transtition table instance
    - entries : The array of transitions (qSM_Transition_t[]).
    - NoOfEntries : The number of transtitions inside <entries>
    - AxSignals : A pointer to the memory area used for queueing signals. qSignal_t[]
    - MaxSignals : The number of items inside AxSignals.

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/  
qBool_t qStateMachine_TransitionTableInstall( qSM_t * const obj, qSM_TransitionTable_t *table, qSM_Transition_t *entries, size_t NoOfEntries, qSignal_t *AxSignals, size_t MaxSignals){
    qBool_t RetValue = qFalse;
    if( ( NULL != table ) && ( NULL != entries) && (NoOfEntries > (size_t)0 ) ){
        table->NumberOfEntries = NoOfEntries;
        table->Transitions = entries;
        RetValue = qQueueCreate( &table->SignalQueue, AxSignals, sizeof(qSignal_t), MaxSignals );
        if( qTrue == RetValue ){
            obj->qPrivate.TransitionTable = table;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*void qStateMachine_TransitionTableUnistall( qSM_t * const obj )

Unistall the transtition table fromt he state machine instance if available

Parameters:

    - obj : a pointer to the FSM object.

*/  
void qStateMachine_TransitionTableUnistall( qSM_t * const obj ){
    if( NULL != obj ){
        obj->qPrivate.TransitionTable = NULL;
    }
}
/*============================================================================*/
/* qSignal_t qStateMachine_SweepTable( qSM_t * const obj )

Forces a sweep over the installed transition table. The instance will be updated 
if a transition from the table is performed.

Note : This method is performed from the qStateMachine_Run() API before the 
current state callback is invoked.

Parameters:

    - obj : a pointer to the FSM object.

Return value:

    Return the signal that produces the transitiion over the instance.
    QSIGNAL_NONE if no signals available or an error is found;
*/
qSignal_t qStateMachine_SweepTransitionTable( qSM_t * const obj ){
    qSignal_t signal = QSIGNAL_NONE;   
    qSM_TransitionTable_t *table;
    qSM_Transition_t iTransition;
    qSM_State_t xCurrentState;
    size_t iEntry;

    table = (qSM_TransitionTable_t*)obj->qPrivate.TransitionTable; /*MISRAC2012-Rule-11.5 deviation allowed*/
    if( NULL != table ){
        if( qTrue == qQueueReceive( &table->SignalQueue, &signal ) ){
            xCurrentState = obj->NextState;
            for( iEntry = 0; iEntry < table->NumberOfEntries; iEntry++ ){
                iTransition = table->Transitions[iEntry];
                if( ( xCurrentState == iTransition.xCurrentState ) && ( signal == iTransition.Signal) ){ /*both conditions match*/
                    obj->NextState = iTransition.xNextState;    /*make the transition to the target state*/
                    break; 
                } 
            }
        }
        else{
            signal = QSIGNAL_NONE; 
        }
    }
    return signal;
}
/*============================================================================*/
/*qBool_t qStateMachine_SendSignal( qSM_t * const obj, qSignal_t signal, qBool_t isUrgent )

Sends a signal to the state machine.
Note : The state machine instance must have a transtition table previously installed

Parameters:

    - obj : a pointer to the FSM object.
    - signal : The user-defined signal
    - isUrgent : If qTrue, the signal will be sended to the front of the transition-table queue.

Return value:

    Return the signal that produces the transitiion over the instance.
    QSIGNAL_NONE if no signals available or an error is found;

*/
qBool_t qStateMachine_SendSignal( qSM_t * const obj, qSignal_t signal, qBool_t isUrgent ){
    qBool_t RetValue = qFalse;
    qSM_TransitionTable_t *tTable;
    if( ( NULL != obj ) && ( QSIGNAL_NONE != signal ) ){
        tTable = (qSM_TransitionTable_t*)obj->qPrivate.TransitionTable; /*MISRAC2012-Rule-11.5 deviation allowed*/
        if( NULL != tTable ){
            RetValue = qQueueGenericSend( &tTable->SignalQueue, &signal, (qQueueMode_t)isUrgent );  
        }
    }
    return RetValue;
}
/*============================================================================*/
#endif /* #if ( Q_FSM == 1 ) */