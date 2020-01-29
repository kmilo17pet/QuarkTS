#include "qfsm.h"

#if ( Q_FSM == 1 )

static void qStatemachine_ExecSubStateIfAvailable( const qSM_SubState_t substate, qSM_Handler_t handle );

/*============================================================================*/
/*qBool_t qStateMachine_Setup(qSM_t * const obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);

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
qBool_t qStateMachine_Setup( qSM_t * const obj, qSM_State_t InitState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState, qSM_SubState_t BeforeAnyState ){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( NULL != InitState ) ){
        obj->qPrivate.xPublic.NextState = InitState;
        obj->qPrivate.xPublic.PreviousState = NULL;
        obj->qPrivate.xPublic.StateFirstEntry  = qFalse;
        obj->qPrivate.xPublic.PreviousReturnStatus = qSM_EXIT_SUCCESS;
        obj->qPrivate.xPublic.LastState = NULL;
        obj->qPrivate.xPublic.Signal = (qSM_Signal_t)0u;
        obj->qPrivate.Failure = FailureState;
        obj->qPrivate.Success = SuccessState;
        obj->qPrivate.Unexpected = UnexpectedState;
        obj->qPrivate.BeforeAnyState = BeforeAnyState;
        obj->qPrivate.TransitionTable = NULL;
        obj->qPrivate.Owner = NULL;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
static void qStatemachine_ExecSubStateIfAvailable( const qSM_SubState_t substate, qSM_Handler_t handle ){
    if( NULL != substate ){
        substate( handle );
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
    qSM_Handler_t handle;

    if( NULL != obj ){
        obj->qPrivate.xPublic.Data = Data;   /*pass the data through the fsm*/
        handle = &obj->qPrivate.xPublic;
        qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.BeforeAnyState , handle ); /*eval the BeforeAnyState if available*/
        if( NULL != obj->qPrivate.xPublic.NextState ){ /*eval nextState if available*/
            obj->qPrivate.xPublic.StateFirstEntry = ( obj->qPrivate.xPublic.LastState != obj->qPrivate.xPublic.NextState )? qTrue : qFalse;  /*Get the StateFirstEntry flag*/
            if( obj->qPrivate.xPublic.StateFirstEntry ){ /*if StateFistEntry is set, update the PreviousState*/
                obj->qPrivate.xPublic.PreviousState = obj->qPrivate.xPublic.LastState ; 
            }
            prev = obj->qPrivate.xPublic.NextState; /*keep the next state in prev for LastState update*/
            obj->qPrivate.xPublic.Signal = qStateMachine_SweepTransitionTable( obj ); /*sweep the table if available*/
            obj->qPrivate.xPublic.PreviousReturnStatus = prev( handle ); /*Eval the current state, and get their return status*/
            obj->qPrivate.xPublic.LastState = prev; /*update the LastState*/
        }
        else{
            obj->qPrivate.xPublic.PreviousReturnStatus = qSM_EXIT_FAILURE; /*otherwise jump to the failure state*/
        }
        /*Check return status to eval extra states*/
        if( qSM_EXIT_FAILURE == obj->qPrivate.xPublic.PreviousReturnStatus ){
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.Failure, handle ); /*Run failure state if available*/
        }
        else if ( qSM_EXIT_SUCCESS == obj->qPrivate.xPublic.PreviousReturnStatus ){
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.Success, handle ); /*Run success state if available*/
        } 
        else{
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.Unexpected, handle ); /*Run unexpected state if available*/
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
         > qSM_UNISTALL_TRANSTABLE : To uninstall the transition table if available
    - s : The new value for state (only apply in qSM_RESTART). If not used, pass NULL.
    - subs : The new value for SubState (only apply in qSM_FAILURE_STATE, qSM_SUCCESS_STATE, 
             qSM_UNEXPECTED_STATE, qSM_BEFORE_ANY_STATE). If not used, pass NULL.
*/    
void qStateMachine_Attribute( qSM_t * const obj, const qFSM_Attribute_t Flag , qSM_State_t  s, qSM_SubState_t subs ){
    if( NULL != obj){
        switch(Flag){
            case qSM_RESTART:
                obj->qPrivate.xPublic.NextState = s;
                obj->qPrivate.xPublic.PreviousState = NULL;
                obj->qPrivate.xPublic.LastState = NULL;
                obj->qPrivate.xPublic.StateFirstEntry = qFalse;
                obj->qPrivate.xPublic.PreviousReturnStatus = qSM_EXIT_SUCCESS;            
                break;
            case qSM_CLEAR_STATE_FIRST_ENTRY_FLAG:
                obj->qPrivate.xPublic.PreviousState = NULL;
                obj->qPrivate.xPublic.LastState = NULL;
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
            case qSM_UNINSTALL_TRANSTABLE:
                obj->qPrivate.TransitionTable = NULL;
                break;   
            default:
                break;
        }        
    }
}
/*============================================================================*/
/*qBool_t qStateMachine_TransitionTableInstall( qSM_t * const obj, qSM_TransitionTable_t *table, qSM_Transition_t *entries, size_t NoOfEntries, qSM_Signal_t *AxSignals, size_t MaxSignals)

Install a transition table for the supplied state machine instance.

Parameters:

    - obj : a pointer to the FSM object.
    - table: a pointer to the transition table instance
    - entries : The array of transition (qSM_Transition_t[]).
    - NoOfEntries : The number of transitions inside <entries>
    - AxSignals : A pointer to the memory area used for queueing signals. qSM_Signal_t[]
    - MaxSignals : The number of items inside AxSignals.

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/  
qBool_t qStateMachine_TransitionTableInstall( qSM_t * const obj, qSM_TransitionTable_t *table, qSM_Transition_t *entries, size_t NoOfEntries, qSM_Signal_t *AxSignals, size_t MaxSignals){
    qBool_t RetValue = qFalse;
    if( (NULL != obj) && ( NULL != table ) && ( NULL != entries) && (NoOfEntries > (size_t)0 ) ){
        table->qPrivate.NumberOfEntries = NoOfEntries;
        table->qPrivate.Transitions = entries;
        RetValue = qQueue_Setup( &table->qPrivate.SignalQueue, AxSignals, sizeof(qSM_Signal_t), MaxSignals );
        if( qTrue == RetValue ){
            obj->qPrivate.TransitionTable = table;
        }
    }
    return RetValue;
}
/*============================================================================*/
/* qSMSignal_t qStateMachine_SweepTable( qSM_t * const obj )

Forces a sweep over the installed transition table. The instance will be updated 
if a transition from the table is performed.

Note : This method is performed from the qStateMachine_Run() API before the 
current state callback is invoked.

Parameters:

    - obj : a pointer to the FSM object.

Return value:

    Return the signal that produces the transition over the instance.
    QFSM_SIGNAL_NONE if no signals available or an error is found;
*/
qSM_Signal_t qStateMachine_SweepTransitionTable( qSM_t * const obj ){
    qSM_Signal_t signal = QSM_SIGNAL_NONE;   
    qSM_TransitionTable_t *table;
    qSM_Transition_t iTransition;
    qSM_State_t xCurrentState;
    size_t iEntry;

    if( NULL != obj ){
        table = (qSM_TransitionTable_t*)obj->qPrivate.TransitionTable; /*MISRAC2012-Rule-11.5 deviation allowed*/
        if( NULL != table ){
            if( qTrue == qQueue_Receive( &table->qPrivate.SignalQueue, &signal ) ){
                xCurrentState = obj->qPrivate.xPublic.NextState;
                for( iEntry = 0; iEntry < table->qPrivate.NumberOfEntries; iEntry++ ){
                    iTransition = table->qPrivate.Transitions[iEntry];
                    if( ( xCurrentState == iTransition.xCurrentState ) && ( signal == iTransition.Signal) ){ /*both conditions match*/
                        obj->qPrivate.xPublic.NextState = iTransition.xNextState;    /*make the transition to the target state*/
                        break; 
                    } 
                }
            }
            else{
                signal = QSM_SIGNAL_NONE; 
            }
        }        
    }

    return signal;
}
/*============================================================================*/
/*qBool_t qStateMachine_SendSignal( qSM_t * const obj, qSM_Signal_t signal, qBool_t isUrgent )

Sends a signal to the state machine.
Note : The state machine instance must have a transition table previously installed

Parameters:

    - obj : a pointer to the FSM object.
    - signal : The user-defined signal
    - isUrgent : If qTrue, the signal will be sent to the front of the transition-table queue.

Return value:

    qTrue if the provided signal was successfully delivered to the FSM, otherwise return qFalse.

*/
qBool_t qStateMachine_SendSignal( qSM_t * const obj, qSM_Signal_t signal, qBool_t isUrgent ){
    qBool_t RetValue = qFalse;
    qSM_TransitionTable_t *tTable;
    if( ( NULL != obj ) && ( QSM_SIGNAL_NONE != signal ) ){
        tTable = (qSM_TransitionTable_t*)obj->qPrivate.TransitionTable; /*MISRAC2012-Rule-11.5 deviation allowed*/
        if( NULL != tTable ){
            RetValue = qQueue_SendGeneric( &tTable->qPrivate.SignalQueue, &signal, (qQueue_Mode_t)isUrgent );  
        }
    }
    return RetValue;
}
/*============================================================================*/
qSM_Handler_t qStateMachine_Get_Handler( qSM_t * const obj ){
    qSM_Handler_t h =  NULL;
    if( NULL != obj ){
        h = &obj->qPrivate.xPublic;
    }
    return h;
}
/*============================================================================*/
#endif /* #if ( Q_FSM == 1 ) */