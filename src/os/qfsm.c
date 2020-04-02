#include "qfsm.h"

#if ( Q_FSM == 1 )

static void qStateMachine_ExecSubStateIfAvailable( const qSM_SubState_t substate, qSM_Handler_t handle );
static void qStateMachine_ExecStateIfAvailable( qSM_t * const obj, const qSM_State_t state );


typedef struct qSM_Stack_s{
    qSM_t *t;
    struct qSM_Stack_s *next;
}qSM_Stack_t;

#ifndef Q_FSM_MAX_NEST_DEPTH
    #define Q_FSM_MAX_NEST_DEPTH   ( 5 )
#endif

static size_t qSM_StackIndex = 0;
static qSM_Stack_t qSM_RAM_Area[ Q_FSM_MAX_NEST_DEPTH ] = {0};

static qBool_t qStateMachine_StackIsEmpty( qSM_Stack_t *top );
static void qStateMachine_StackPush( qSM_Stack_t **top_ref, qSM_t *t );
static qSM_t* qStateMachine_StackPop( qSM_Stack_t **top_ref );
static qSM_Status_t qStateMachine_Evalutate( qSM_t * const obj, void *Data );

/*============================================================================*/
/*qBool_t qStateMachine_Setup(qSM_t * const obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState, qSM_SubState_t BeforeAnyState);

Initializes a finite state machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - InitState : The first state to be performed. This argument is a pointer 
                  to a callback function, returning qSM_Status_t and with a 
                  qSM_Handler_t as input argument.
    - SuccessState : Sub-State performed after a state finish with return status 
                     qSM_EXIT_SUCCESS. This argument is a pointer to a callback
                     function with a qSM_Handler_t pointer as input argument.
    - FailureState : Sub-State performed after a state finish with return status 
                     qSM_EXIT_FAILURE. This argument is a pointer to a callback
                     function with a qSM_Handler_t as input argument.
    - UnexpectedState : Sub-State performed after a state finish with return status
                        value between -32766 and 32767. This argument is a 
                        pointer to a callback function with a qSM_Handler_t 
                        as input argument.
    - BeforeAnyState : A state called before the normal state machine execution,                   

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qStateMachine_Setup( qSM_t * const obj, qSM_State_t InitState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState, qSM_SubState_t BeforeAnyState ){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( NULL != InitState ) ){
        obj->qPrivate.xPublic.NextState = InitState;
        obj->qPrivate.xPublic.PreviousState = NULL;
        obj->qPrivate.xPublic.Signal  = QSM_SIGNAL_NONE;
        obj->qPrivate.xPublic.PreviousReturnStatus = qSM_EXIT_SUCCESS;
        obj->qPrivate.xPublic.LastState = NULL;
        obj->qPrivate.xPublic.Signal = (qSM_Signal_t)0u;
        obj->qPrivate.xPublic.Parent = NULL;
        obj->qPrivate.Failure = FailureState;
        obj->qPrivate.Success = SuccessState;
        obj->qPrivate.Unexpected = UnexpectedState;
        obj->qPrivate.BeforeAnyState = BeforeAnyState;
        obj->qPrivate.TransitionTable = NULL;
        obj->qPrivate.Owner = NULL;
        obj->qPrivate.SignalQueue.qPrivate.pHead = NULL;

        obj->qPrivate.Composite.head = NULL;
        obj->qPrivate.Composite.next = NULL;
        obj->qPrivate.Composite.rootState = NULL;
        obj->qPrivate.Composite.UnFlatten = qFalse;
        RetValue = qTrue;

    }
    return RetValue;
}
/*============================================================================*/
static void qStateMachine_ExecSubStateIfAvailable( const qSM_SubState_t substate, qSM_Handler_t handle ){
    if( NULL != substate ){
        substate( handle );
    }
}
/*============================================================================*/
static qSM_Status_t qStateMachine_Evalutate( qSM_t * const obj, void *Data ){
    qSM_State_t CurrentState; 
    qSM_Status_t RetValue = qSM_EXIT_FAILURE;
    qSM_t *parent;

    obj->qPrivate.xPublic.Data = Data;   /*pass the data through the fsm*/
    obj->qPrivate.xPublic.Signal = QSM_SIGNAL_NONE;
    CurrentState = obj->qPrivate.xPublic.NextState;

    if( obj->qPrivate.xPublic.LastState != CurrentState ){ /*entry condition, update the PreviousState*/
        obj->qPrivate.xPublic.PreviousState = obj->qPrivate.xPublic.LastState ; 
        obj->qPrivate.xPublic.PreviousReturnStatus = obj->qPrivate.xPublic.LastReturnStatus;
        obj->qPrivate.xPublic.Signal = QSM_SIGNAL_ENTRY;
        qStateMachine_ExecStateIfAvailable( obj, CurrentState );
    }
    else{
        if( QSM_SIGNAL_NONE == obj->qPrivate.xPublic.Signal ){
            if( qTrue == qQueue_IsReady( &obj->qPrivate.SignalQueue ) ){
                if( qTrue == qQueue_Receive( &obj->qPrivate.SignalQueue, &obj->qPrivate.xPublic.Signal ) ){
                   (void)qStateMachine_SweepTransitionTable( obj ); /*sweep the table if available*/
                }
            }
            else{
                parent = (qSM_t*)obj->qPrivate.xPublic.Parent;
                if( NULL != parent ){/*check if the current fsm is a child*/
                    if( ( QSM_SIGNAL_ENTRY != parent->qPrivate.xPublic.Signal ) && ( QSM_SIGNAL_EXIT != parent->qPrivate.xPublic.Signal ) ){
                        obj->qPrivate.xPublic.Signal = parent->qPrivate.xPublic.Signal; /*use the parent signal if the child doest have their own signal-queue*/
                    }
                    (void)qStateMachine_SweepTransitionTable( obj ); /*sweep the table if available*/
                }
            }
        }  
        qStateMachine_ExecStateIfAvailable( obj, CurrentState  );
        
        if( CurrentState != obj->qPrivate.xPublic.NextState ){ /*Has a transition been made?*/
            obj->qPrivate.xPublic.Signal = QSM_SIGNAL_EXIT; 
            qStateMachine_ExecStateIfAvailable( obj, CurrentState );
        }
    }
    
    return RetValue;
 }
/*============================================================================*/
static void qStateMachine_ExecStateIfAvailable( qSM_t * const obj, const qSM_State_t state ){
    qSM_Status_t ExitStatus = qSM_EXIT_FAILURE;
    qSM_Handler_t handle;

    handle = &obj->qPrivate.xPublic;
    qStateMachine_ExecSubStateIfAvailable( obj->qPrivate.BeforeAnyState , handle ); /*eval the BeforeAnyState if available*/
    if( NULL != state ){ /*eval the state if available*/
        ExitStatus = state( handle );
    }
    obj->qPrivate.xPublic.LastReturnStatus = ExitStatus;
    obj->qPrivate.xPublic.LastState = state; /*update the LastState*/
    /*Check return status to eval extra states*/
    if( qSM_EXIT_FAILURE == ExitStatus ){
        qStateMachine_ExecSubStateIfAvailable( obj->qPrivate.Failure, handle ); /*Run failure state if available*/
    }
    else if ( qSM_EXIT_SUCCESS == ExitStatus ){
        qStateMachine_ExecSubStateIfAvailable( obj->qPrivate.Success, handle ); /*Run success state if available*/
    } 
    else{
        qStateMachine_ExecSubStateIfAvailable( obj->qPrivate.Unexpected, handle ); /*Run unexpected state if available*/
    }
}
/*============================================================================*/
/*void qStateMachine_Run(qSM_t * const root, void* Data)

Execute the Finite State Machine (FSM).

Parameters:

    - root : a pointer to the FSM object.
    - Data : Represents the FSM arguments. All arguments must be passed by 
             reference and cast to (void *). Only one argument is allowed, so,
             for multiple arguments, create a structure that contains all of 
             the arguments and pass a pointer to that structure.
*/
void qStateMachine_Run( qSM_t * const root, void *Data ){
    qSM_t *current = root; 
    qSM_Stack_t *s = NULL;  /* Initialize stack s */
    qBool_t hierarchy_drilled = qFalse;     
    qSM_t *parent;
    qBool_t exec;

    while( qFalse == hierarchy_drilled ){
        if( NULL != current ){     /* Reach the deep-most fsm of the current*/
            qStateMachine_StackPush( &s, current );  /* place pointer to the current fsm on the stack before traversing the nested fsm */            
            current = current->qPrivate.Composite.head;
        }
        else{   /* backtrack from the empty subtree and visit the nested fsm at the top of the stack; however, if the stack is empty, we are done */
            hierarchy_drilled = qStateMachine_StackIsEmpty( s );
            if( qFalse ==  hierarchy_drilled ){
                current = qStateMachine_StackPop( &s );
                
                if( NULL != current){
                    exec = qTrue;
                    parent =  (qSM_t*)current->qPrivate.xPublic.Parent;
                    
                    if( NULL != parent ){
                        exec = parent->qPrivate.xPublic.NextState == current->qPrivate.Composite.rootState;
                    }
                    
                    if( qTrue == exec ){
                        (void)qStateMachine_Evalutate( current, Data );
                    }                    
                    
                    current = current->qPrivate.Composite.next; /* we have visited the fsm and its nested subtree. Now, it's same-level fsm's turn */
                }
            }
        }
    }
}
/*============================================================================*/
/*void qStateMachine_Attribute( qSM_t * const obj, const qFSM_Attribute_t Flag , qSM_State_t  s, qSM_SubState_t subs )

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
                obj->qPrivate.xPublic.Signal = QSM_SIGNAL_NONE;
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

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/  
qBool_t qStateMachine_TransitionTableInstall( qSM_t * const obj, qSM_TransitionTable_t *table, qSM_Transition_t *entries, size_t NoOfEntries ){
    qBool_t RetValue = qFalse;
    if( (NULL != obj) && ( NULL != table ) && ( NULL != entries) && (NoOfEntries > (size_t)0 ) ){
        table->qPrivate.NumberOfEntries = NoOfEntries;
        table->qPrivate.Transitions = entries;
        obj->qPrivate.TransitionTable = table;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_SignalQueueSetup( qSM_t * const obj, qSM_Signal_t *AxSignals, size_t MaxSignals )

Setup the state-machine signal queue.

Parameters:

    - obj : a pointer to the FSM object.
    - AxSignals : A pointer to the memory area used for queueing signals. qSM_Signal_t[MaxSignals]
    - MaxSignals : The number of items inside AxSignals.

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/ 
qBool_t qStateMachine_SignalQueueSetup( qSM_t * const obj, qSM_Signal_t *AxSignals, size_t MaxSignals ){
    qBool_t RetValue = qFalse;
    if( ( NULL != AxSignals ) && ( MaxSignals > (size_t)0u ) ){
        RetValue = qQueue_Setup( &obj->qPrivate.SignalQueue, AxSignals, sizeof(qSM_Signal_t), MaxSignals );
    }
    return RetValue;
}
/*============================================================================*/
/* qBool_t qStateMachine_SweepTable( qSM_t * const obj )

Forces a sweep over the installed transition table. The instance will be updated 
if a transition from the table is performed.

Note : This method is performed from the qStateMachine_Run() API before the 
current state callback is invoked.

Parameters:

    - obj : a pointer to the FSM object.

Return value:

    Returns qTrue if the sweep produce a state transition, otherwise returns qFalse;
*/
qBool_t qStateMachine_SweepTransitionTable( qSM_t * const obj ){
    qBool_t RetValue = qFalse;
    qSM_TransitionTable_t *table;
    qSM_Transition_t iTransition;
    qSM_State_t xCurrentState;
    size_t iEntry;
    qSM_Signal_t signal;
    qBool_t SigActionGuard = qTrue;
    qSM_t *toChild, *xParent;

    if( NULL != obj ){
        table = obj->qPrivate.TransitionTable; /*MISRAC2012-Rule-11.5 deviation allowed*/
        if( NULL != table ){
            signal = obj->qPrivate.xPublic.Signal;
            if( signal < QSM_SIGNAL_RANGE_MAX){
                xCurrentState = obj->qPrivate.xPublic.NextState;
                for( iEntry = 0; iEntry < table->qPrivate.NumberOfEntries; iEntry++ ){
                    iTransition = table->qPrivate.Transitions[iEntry];
                    if( ( xCurrentState == iTransition.xCurrentState ) && ( signal == iTransition.Signal) ){ /*both conditions match*/
                        if( NULL != iTransition.SignalAction ){
                            SigActionGuard = iTransition.SignalAction( &obj->qPrivate.xPublic );
                        }
                        if( qTrue == SigActionGuard ){
                            obj->qPrivate.xPublic.NextState = iTransition.xNextState;    /*make the transition to the target state*/
                            
                            if( ( NULL != iTransition.xToChildHandle ) && ( NULL != iTransition.xToChildState ) && ( NULL == iTransition.xToParentState) ){ /*make the transition inside composite states*/
                                toChild = (qSM_t*)iTransition.xToChildHandle;
                                if( obj == toChild->qPrivate.xPublic.Parent ){ /*check if the the target child its actually a child of the current fsm*/
                                    toChild->qPrivate.xPublic.NextState = iTransition.xToChildState;
                                } 
                            }
                            else if( ( NULL != iTransition.xToParentState ) && ( NULL == iTransition.xToChildHandle ) && ( NULL == iTransition.xToChildState) ){
                                xParent = (qSM_t*)obj->qPrivate.xPublic.Parent;
                                if( NULL != xParent ){
                                    xParent->qPrivate.xPublic.NextState = iTransition.xToParentState;
                                }
                            }
                            else{
                                /*bad table configuration, not handled*/
                            }
                        }
                        RetValue = qTrue;
                        break; 
                    } 
                }
            }
        }        
    }
    return RetValue;
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
    if( ( NULL != obj ) && ( QSM_SIGNAL_NONE != signal ) ){
        if( qTrue == qQueue_IsReady( &obj->qPrivate.SignalQueue ) ){
            RetValue = qQueue_SendGeneric( &obj->qPrivate.SignalQueue, &signal, (qQueue_Mode_t)isUrgent );  
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qSM_Handler_t qStateMachine_Get_Handler( qSM_t * const obj )

Return the state-machine handler.

Parameters:

    - obj : a pointer to the FSM object.

Return value:

    The requested FSM handler. NULL if the handler cant be retrieved.

*/
qSM_Handler_t qStateMachine_Get_Handler( qSM_t * const obj ){
    qSM_Handler_t h =  NULL;
    if( NULL != obj ){
        h = &obj->qPrivate.xPublic;
    }
    return h;
}
/*============================================================================*/
/*qBool_t qStateMachine_Set_CompositeState( qSM_t * const parent, qSM_State_t state, qSM_t * const child )

Setup a state-machine as a composite state.

Parameters:

    - parent : A pointer to the parent FSM object.
    - state : A state from <parent> to relate the <child> fsm .
    - child : A pointer to the child FSM object who becomes part of the composite state.

Return value:

    qTrue on success. Otherwise, returns qFalse.

*/
qBool_t qStateMachine_Set_CompositeState( qSM_t * const parent, qSM_State_t state, qSM_t * const child ){
    qBool_t RetValue = qFalse;
    qSM_t *last;
    if( ( NULL != parent ) && ( NULL != state ) && (child != NULL ) ){
        child->qPrivate.xPublic.Parent = parent;
        child->qPrivate.Composite.rootState = state;

        /*insert child fsm into the composite fsm list*/
        if( NULL == parent->qPrivate.Composite.head ){
             parent->qPrivate.Composite.head = child;
        }
        else{
            last = parent->qPrivate.Composite.head;
            while( NULL != last->qPrivate.Composite.next ){
                last = last->qPrivate.Composite.next;
            }
            last->qPrivate.Composite.next = child;
        }
        /*
        child->qPrivate.Composite.next = parent->qPrivate.Composite.head;
        parent->qPrivate.Composite.head = child;
        */
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qStateMachine_Set_Parent( qSM_t * const Child, qSM_t * const Parent)

Set the state-machine parent.

Parameters:

    - Child : a pointer to the child FSM object.
    - Parent : a pointer to the parent FSM object.

Return value:

    The requested FSM handler. NULL if the handler cant be retrieved.

*/
void qStateMachine_Set_Parent( qSM_t * const Child, qSM_t * const Parent ){
    if( NULL != Child ){
        Child->qPrivate.xPublic.Parent = Parent;
    }
}
/*============================================================================*/
static qBool_t qStateMachine_StackIsEmpty( qSM_Stack_t *top ){ 
    qBool_t RetValue = qTrue;
    if( NULL != top ){
        RetValue = ( 0u == qSM_StackIndex )? qTrue : qFalse;
    }
    return RetValue; 
}  
/*============================================================================*/
static void qStateMachine_StackPush( qSM_Stack_t **top_ref, qSM_t *t ){ 
    qSM_Stack_t *new_tNode;
    if( qSM_StackIndex < (size_t)Q_FSM_MAX_NEST_DEPTH ){
        new_tNode = &qSM_RAM_Area[ qSM_StackIndex++ ];
        new_tNode->t  = t;  /* put in the data  */
        new_tNode->next = (*top_ref);  /* link the old list of the new tNode */   
        (*top_ref) = new_tNode;   /* move the head to point to the new tNode */      
    }
} 
/*============================================================================*/
static qSM_t* qStateMachine_StackPop( qSM_Stack_t **top_ref ){ 
    qSM_t *res = NULL; 
    qSM_Stack_t *top; 
  
    if( qFalse == qStateMachine_StackIsEmpty( *top_ref )) { 
        top = *top_ref; 
        res = top->t; 
        *top_ref = top->next; 
        qSM_StackIndex--; 
    } 
    return res;
} 
/*============================================================================*/

#endif /* #if ( Q_FSM == 1 ) */
