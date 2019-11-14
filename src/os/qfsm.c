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
        obj->StateFirstEntry  = 0u;
        obj->PreviousReturnStatus = qSM_EXIT_SUCCESS;
        obj->qPrivate.Failure = FailureState;
        obj->qPrivate.Success = SuccessState;
        obj->qPrivate.Unexpected = UnexpectedState;
        obj->qPrivate.BeforeAnyState = BeforeAnyState;
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
    - Data : Represents the FSM arguments. All arguments must be passed by 
             reference and cast to (void *). Only one argument is allowed, so,
             for multiple arguments, create a structure that contains all of 
             the arguments and pass a pointer to that structure.
*/    
void qStateMachine_Run( qSM_t * const obj, void *Data ){
    qSM_State_t prev  = NULL; /*used to hold the previous state*/
    if( NULL != obj ){
        obj->Data = Data;   /*pass the data through the fsm*/
        qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.BeforeAnyState , obj); /*eval the BeforeAnyState if available*/
        if( NULL != obj->NextState ){ /*eval nextState if available*/
            obj->StateFirstEntry = ( obj->LastState != obj->NextState )? qTrue : qFalse;  /*Get the StateFirstEntry flag*/
            if( obj->StateFirstEntry ){ /*if StateFistEntry is set, update the PreviousState*/
                obj->PreviousState = obj->LastState ; 
            }
            prev = obj->NextState; /*keep the next state in prev for LastState update*/
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
            obj->NextState = (qSM_State_t)s;
            obj->PreviousState = NULL;
            obj->LastState = NULL;
            obj->StateFirstEntry = 0u;
            obj->PreviousReturnStatus = qSM_EXIT_SUCCESS;            
            break;
        case qSM_CLEAR_STATE_FIRST_ENTRY_FLAG:
            obj->PreviousState = NULL;
            obj->LastState = NULL;
            break;
        case qSM_FAILURE_STATE:
            obj->qPrivate.Failure = (qSM_SubState_t)subs;
            break;
        case qSM_SUCCESS_STATE:
            obj->qPrivate.Success = (qSM_SubState_t)subs;
            break;    
        case qSM_UNEXPECTED_STATE:
            obj->qPrivate.Unexpected = (qSM_SubState_t)subs;
            break;   
        case qSM_BEFORE_ANY_STATE:
            obj->qPrivate.BeforeAnyState = (qSM_SubState_t)subs;
            break;              
        default:
            break;
    }
}
/*============================================================================*/

#endif /* #if ( Q_FSM == 1 ) */