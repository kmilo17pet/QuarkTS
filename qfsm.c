#include "qfsm.h"

#if ( Q_FSM == 1 )

typedef struct qSM_Stack_s{
    qSM_t *t;                   /*<The stack data, a pointer to a fsm*/
    struct qSM_Stack_s *next;   /*<A pointer to the next item in the stack*/
}qSM_Stack_t;

#ifndef Q_FSM_MAX_NEST_DEPTH
    #define Q_FSM_MAX_NEST_DEPTH   ( 5 )
#endif

typedef struct{
    size_t Index;
    qSM_Stack_t Element[ Q_FSM_MAX_NEST_DEPTH ];
}qSM_Stack_Handle_t;
static qSM_Stack_Handle_t qSM_NestStack = { 0u };

static void qStateMachine_ExecStateIfAvailable( qSM_t * const obj, const qSM_State_t state, qSM_Signal_t xSignal );


#define QSM_PACK_CHILDS     ( (void*)&qSM_NestStack )

static qBool_t qStateMachine_StackIsEmpty( qSM_Stack_t *top );
static void qStateMachine_StackPush( qSM_Stack_t **top_ref, qSM_t *t );
static qSM_t* qStateMachine_StackPop( qSM_Stack_t **top_ref );
static void qStateMachine_StackCleanUp( void );

static qSM_Status_t qStateMachine_Evaluate( qSM_t * const obj, void *Data );
static void qStateMachine_PackChilds( qSM_t * current, void *xRoot );
static void qStateMachine_HierarchicalExec( qSM_t * current, void *Data );

static void qStateMachine_CheckTimeoutSignals( qSM_t * const obj );
static void qStateMachine_DisableTimeouts( qSM_t * const obj );
static void qStateMachine_TimeoutQueueCleanup( qSM_t * const obj  );
static void qStateMachine_TimeoutStateArm( qSM_t * const obj, qSM_State_t current );

qBool_t _qSM_DummyPtrValues[ 2 ]; 

/*============================================================================*/
qSM_Status_t _qStateMachine_UndefinedStateCallback( qSM_Handler_t h ){ /*a dummy state-callback to be used in hierarchical fsm without an initial-state definition*/
    Q_UNUSED( h );
    return qSM_EXIT_SUCCESS;
}
qSM_Status_t _qStateMachine_RecursiveStateCallback( qSM_Handler_t h ){
    h->NextState = h->LastState;
    return qSM_EXIT_SUCCESS;
}
/*============================================================================*/
/*qBool_t qStateMachine_Setup( qSM_t * const obj, qSM_State_t InitState, qSM_SurroundingState_t Surrounding )

Initializes a finite state machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - InitState : The first state to be performed. This argument is a pointer 
                  to a callback function, returning qSM_Status_t and with a 
                  qSM_Handler_t as input argument.
    - Surrounding : The surrounding state To ignore pass NULL                 

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qStateMachine_Setup( qSM_t * const obj, qSM_State_t InitState, qSM_SurroundingState_t Surrounding  ){
    qBool_t RetValue = qFalse;
    
    if( ( NULL != obj ) && ( NULL != InitState ) ){
        obj->qPrivate.InitState = InitState;
        obj->qPrivate.xPublic.NextState = InitState;
        obj->qPrivate.xPublic.PreviousState = NULL;
        obj->qPrivate.xPublic.Signal  = QSM_SIGNAL_NONE;
        obj->qPrivate.xPublic.PreviousReturnStatus = qSM_EXIT_SUCCESS;
        obj->qPrivate.xPublic.LastState = NULL;
        obj->qPrivate.xPublic.Signal = (qSM_Signal_t)0u;
        obj->qPrivate.xPublic.Parent = NULL;
        obj->qPrivate.Surrounding = Surrounding;
        obj->qPrivate.TransitionTable = NULL;
        obj->qPrivate.Owner = NULL;
        obj->qPrivate.SignalQueue = NULL;

        obj->qPrivate.Composite.head = NULL;
        obj->qPrivate.Composite.next = NULL;
        obj->qPrivate.Composite.rootState = NULL;
        obj->qPrivate.hInstance = NULL;

        obj->qPrivate.TimeSpec = NULL;
        RetValue = qTrue;     
    }
    return RetValue;
}
/*============================================================================*/
/*void qStateMachine_Run( qSM_t * const root, void* Data )

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
    void (*hAction)( qSM_t *arg1, void* arg2 );

    if( QSM_PACK_CHILDS == Data ){
        hAction = &qStateMachine_PackChilds;
        Data = root;
    }
    else{
        hAction = &qStateMachine_HierarchicalExec;
        root->qPrivate.Active = qTrue; /*the root fsm is always active*/
    }
    
    qStateMachine_StackCleanUp( );
    while( qFalse == hierarchy_drilled ){
        if( NULL != current ){     /* Reach the deep-most fsm of the current*/
            qStateMachine_StackPush( &s, current );  /* place pointer to the current fsm on the stack before traversing the nested fsm */            
            current = current->qPrivate.Composite.next;
        }
        else{   /* backtrack from the empty subtree and visit the nested fsm at the top of the stack; however, if the stack is empty, we are done */
            hierarchy_drilled = qStateMachine_StackIsEmpty( s );
            if( qFalse ==  hierarchy_drilled ){
                current = qStateMachine_StackPop( &s );           
                if( NULL != current ){
                    hAction( current, Data );        
                    current = current->qPrivate.Composite.head; /* we have visited the fsm and its nested subtree. Now, it's same-level fsm turn */                   
                }
            }
        }
    }
}
/*============================================================================*/
static void qStateMachine_PackChilds( qSM_t * current, void *xRoot ){ 
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    qSM_t *root = xRoot; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/  
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    if( root->qPrivate.hInstance->childscount < (size_t)Q_FSM_MAX_NEST_DEPTH ){
        root->qPrivate.hInstance->childs[ root->qPrivate.hInstance->childscount++ ] = current;
    }
}
/*============================================================================*/
static void qStateMachine_HierarchicalExec( qSM_t * current, void *Data ){
    qBool_t exec = qTrue;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    qSM_t *parent =  (qSM_t*)current->qPrivate.xPublic.Parent;  /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/              
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    if( NULL != parent ){
        exec = ( parent->qPrivate.xPublic.NextState == current->qPrivate.Composite.rootState ) ;
        if( ( qTrue == current->qPrivate.Active ) && ( qFalse == exec ) ){
            qStateMachine_ExecStateIfAvailable(  current, current->qPrivate.xPublic.NextState, QSM_SIGNAL_EXIT ); /*execute exit action*/
            qStateMachine_TimeoutQueueCleanup( current ); 
        }
        if( ( qFalse == current->qPrivate.Active ) && ( qTrue == exec ) ){
            qStateMachine_ExecStateIfAvailable(  current, current->qPrivate.xPublic.NextState, QSM_SIGNAL_ENTRY ); /*execute entry action*/
        }
        current->qPrivate.Active = exec;
    }
    if( qTrue == exec ){
        (void)qStateMachine_Evaluate( current, Data );
    }        
}
/*============================================================================*/
static qSM_Status_t qStateMachine_Evaluate( qSM_t * const obj, void *Data ){
    qSM_State_t CurrentState = obj->qPrivate.xPublic.NextState; 
    qSM_Status_t RetValue = qSM_EXIT_FAILURE;

    obj->qPrivate.xPublic.Data = Data;   /*pass the data through the fsm*/
    if( obj->qPrivate.xPublic.LastState != CurrentState ){ /*entry condition, update the PreviousState*/
        obj->qPrivate.xPublic.PreviousState = obj->qPrivate.xPublic.LastState ; 
        obj->qPrivate.xPublic.PreviousReturnStatus = obj->qPrivate.xPublic.LastReturnStatus;
        qStateMachine_ExecStateIfAvailable( obj, CurrentState, QSM_SIGNAL_ENTRY );
    }
    else{        
        qSM_Signal_t xSignal = QSM_SIGNAL_NONE;
        #if ( Q_QUEUES == 1 )
        if( NULL != obj->qPrivate.SignalQueue ){ /*check if the state-machine has a signal queue*/
            qStateMachine_CheckTimeoutSignals( obj );
            if( qTrue == qQueue_Receive( obj->qPrivate.SignalQueue, &xSignal ) ){
                if( NULL != obj->qPrivate.Composite.head ){
                    obj->qPrivate.xPublic.Signal = xSignal; /*store the signal if any child needs it*/
                }
                (void)qStateMachine_SweepTransitionTable( obj, xSignal ); 
            }
        }
        else
        #endif
        {
            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
            qSM_t *parent = (qSM_t*)obj->qPrivate.xPublic.Parent; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
            if( NULL != parent ){/*check if the current fsm its a child*/
                if( ( QSM_SIGNAL_ENTRY != parent->qPrivate.xPublic.Signal ) && ( QSM_SIGNAL_EXIT != parent->qPrivate.xPublic.Signal ) ){
                    xSignal = parent->qPrivate.xPublic.Signal; /*use the parent signal if the child doesn't have their own signal-queue*/
                }
                (void)qStateMachine_SweepTransitionTable( obj, xSignal );
            }
        }
        
        qStateMachine_ExecStateIfAvailable( obj, CurrentState, xSignal );

        if( CurrentState != obj->qPrivate.xPublic.NextState ){ /*Has a transition occurred??*/           
            qStateMachine_ExecStateIfAvailable( obj, CurrentState, QSM_SIGNAL_EXIT ); 
            qStateMachine_TimeoutQueueCleanup( obj );
        }
    }
    
    return RetValue;
 }
 /*============================================================================*/
 static void qStateMachine_ExecStateIfAvailable( qSM_t * const obj, const qSM_State_t state, qSM_Signal_t xSignal ){
    qSM_Status_t ExitStatus = qSM_EXIT_FAILURE;
    qSM_Handler_t handle = &obj->qPrivate.xPublic;

    handle->Signal = xSignal;
    if( NULL != obj->qPrivate.Surrounding ){
        ExitStatus = handle->LastReturnStatus; /*temporally save the LastReturnStatus*/
        handle->LastReturnStatus = qSM_BEFORE_ANY; /*set the LastReturnStatus field to the qSM_BEFORE_ANY*/
        obj->qPrivate.Surrounding( handle ); /*execute the surrounding state with the qSM_BEFORE_ANY*/
        handle->LastReturnStatus = ExitStatus; /*restore  the LastReturnStatus */
        ExitStatus = qSM_EXIT_FAILURE; /*let the default ExitStatus value into qSM_EXIT_FAILURE*/
    }

    if( NULL != state ){ /*eval the state if available*/
        if( QSM_SIGNAL_ENTRY == xSignal ){ 
            qStateMachine_TimeoutStateArm( obj, state ); /*re-arm timeouts at the entry if available*/
        }
        ExitStatus = state( handle );
        if( ExitStatus < qSM_EXIT_FAILURE ){ /*just in case, fix the return value*/
            ExitStatus = qSM_EXIT_FAILURE; /*failure by default*/
        }
    }
    obj->qPrivate.xPublic.LastReturnStatus = ExitStatus;
    obj->qPrivate.xPublic.LastState = state; /*update the LastState*/
    /*Check return status to eval extra states*/
    if( ( NULL != obj->qPrivate.Surrounding ) && ( ExitStatus > qSM_EXIT_NULL ) ){ /*check again, because this property may have been changed asynchronously*/
        obj->qPrivate.Surrounding( handle );  /*execute the surrounding state with the latest return status*/
    }
}
/*============================================================================*/
static void qStateMachine_DisableTimeouts( qSM_t * const obj ){
    size_t i;
    for( i = 0 ; i < (size_t)Q_FSM_MAX_TIMEOUTS; ++i ){
        qSTimer_Disarm( &obj->qPrivate.TimeSpec->builtin_timeout[ i ] );
    }
}
/*============================================================================*/
static void qStateMachine_CheckTimeoutSignals( qSM_t * const obj ){
    if( NULL != obj->qPrivate.TimeSpec) {
        size_t i;
        for( i = 0 ; i < (size_t)Q_FSM_MAX_TIMEOUTS; ++i ){
            if( qTrue == qSTimer_Expired( &obj->qPrivate.TimeSpec->builtin_timeout[ i ] ) ) {
                (void)qStateMachine_SendSignal( obj, QSM_SIGNAL_TIMEOUT(i), qFalse );   
                qSTimer_Disarm( &obj->qPrivate.TimeSpec->builtin_timeout[ i ] );
            } 
        }
    }
}
/*============================================================================*/
static void qStateMachine_TimeoutQueueCleanup( qSM_t * const obj ){
    if( NULL != obj->qPrivate.TimeSpec ){
        if( NULL != obj->qPrivate.SignalQueue ){ /*check if the state-machine has a signal queue*/
            size_t cnt;
            qSM_Signal_t xSignal;
            
            cnt = qQueue_Count( obj->qPrivate.SignalQueue );
            while( 0u != cnt-- ){
                if( qTrue == qQueue_Receive( obj->qPrivate.SignalQueue , &xSignal ) ){
                    if( ( xSignal < QSM_SIGNAL_TIMEOUT(0) ) || ( xSignal > QSM_SIGNAL_TIMEOUT(2) ) ){ /*keep the non-timeout signals*/
                        (void)qQueue_SendToBack( obj->qPrivate.SignalQueue , &xSignal );
                    }
                }
            }
        }
        qStateMachine_DisableTimeouts( obj );
    }
}
/*============================================================================*/
static void qStateMachine_TimeoutStateArm( qSM_t * const obj, qSM_State_t current ){
    if( NULL != obj->qPrivate.TimeSpec ){
        qSM_TimeoutStateDefinition_t *tbl = obj->qPrivate.TimeSpec->spec;
        size_t n = obj->qPrivate.TimeSpec->n;    

        if( ( n > 0u ) && ( NULL != tbl ) ){
            size_t i;
            for( i = 0; i < n;  ++i ){
                if( current == tbl[ i ].xState ){
                    (void)qSTimer_Set( &obj->qPrivate.TimeSpec->builtin_timeout[ tbl[ i ].index ], tbl[ i ].xTimeout  );
                    break;
                }
            }
        }
    }
}
/*============================================================================*/
/*qBool_t qStateMachine_TimeoutSpecInstall( qSM_t * const obj,  qSM_TimeoutSpec_t *ts, qSM_TimeoutStateDefinition_t *tdef, size_t n )

Install the specification object to use the FSM built-in timeouts.
This methods also set fixed timeouts for specific states using a lookup-table. 
The QSM_SIGNAL_TIMEOUT0 will be acquired for this purpose. 

Note : This feature its only available if the FSM has a signal queue installed.
Note: The lookup table will be an array of type <qSM_TimeoutStateDefinition_t> with 
      <nEntries> elements matching { state, time }. 

Parameters:

    - obj : a pointer to the target FSM object.
    - ts : a pointer to the timeout specification object
    - tdef : the lookup table matching the target state and the requested timeout.
             to ignore or disable, pass NULL as argument.
    - n: the number of elements inside <tdef>. To ignore pass 0 as argument

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/ 
qBool_t qStateMachine_TimeoutSpecInstall( qSM_t * const obj,  qSM_TimeoutSpec_t *ts, qSM_TimeoutStateDefinition_t *tdef, size_t n ){
    qBool_t RetValue = qFalse;

    if( ( NULL != obj ) && ( NULL != ts ) ){
        obj->qPrivate.TimeSpec = ts;
        qStateMachine_DisableTimeouts( obj );
        if( ( NULL != tdef ) && ( n > 0u ) ){
            obj->qPrivate.TimeSpec->n = n;
            obj->qPrivate.TimeSpec->spec = tdef;
        }
        else{
            obj->qPrivate.TimeSpec->n = 0u;
            obj->qPrivate.TimeSpec->spec = NULL;
        }
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_SetTimeout( qSM_t * const obj, const qIndex_t xTimeout, const qTime_t time )

Set the time for one of the built-in timeouts inside the target FSM

<Requirements> : 
   *> An installed time specification. For this use <qStateMachine_TimeoutSpecInstall>
   *> An installed signal queue. For this use <qStateMachine_SignalQueueSetup>
Note : In a hierarchical FSM, the signal QSM_SIGNAL_TIMEOUTx can be propagated from the parent 
if childs do not have their own signal queue.

Parameters:

    - obj : a pointer to the target FSM object.
    - xTimeout : the index of the timeout (0, 1 ot 2)
    - time : the specified time

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/ 
qBool_t qStateMachine_SetTimeout( qSM_t * const obj, const qIndex_t xTimeout, const qTime_t time ){
    qBool_t RetValue = qFalse;

    if( ( xTimeout <= 2u ) && ( NULL != obj ) ){
        if( NULL != obj->qPrivate.TimeSpec ){
            RetValue = qSTimer_Set( &obj->qPrivate.TimeSpec->builtin_timeout[ xTimeout ], time  );
        }
    }

    return RetValue;
}
/*============================================================================*/
/*void qStateMachine_Attribute( qSM_t * const obj, const qSM_Attribute_t Flag , qSM_State_t  s, qSM_SurroundingState_t Surrounding )

Change attributes or set actions to the Finite State Machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - Flag: The attribute/action to be taken
         > qSM_RESTART : Restart the FSM (val argument must correspond to the init state)
         > qSM_CLEAR_STATE_FIRST_ENTRY_FLAG: clear the entry flag for the 
                current state if the NextState field doesn't change.
         > qSM_SURROUNDING_STATE: Set the surrounding State
         > qSM_UNISTALL_TRANSTABLE : To uninstall the transition table if available
    - s : The new value for state (only apply in qSM_RESTART). If not used, pass NULL.
    - Surrounding : The new value for SubStSurrounding (only apply in qSM_SURROUNDING_STATE).
     If not used, pass NULL.
*/    
void qStateMachine_Attribute( qSM_t * const obj, const qSM_Attribute_t Flag , qSM_State_t  s, qSM_SurroundingState_t Surrounding ){
    if( NULL != obj ){
        switch( Flag ){
            case qSM_RESTART:
                obj->qPrivate.xPublic.NextState = s;
                obj->qPrivate.xPublic.PreviousState = NULL;
                obj->qPrivate.xPublic.LastState = NULL;
                obj->qPrivate.xPublic.Signal = QSM_SIGNAL_NONE;
                obj->qPrivate.xPublic.PreviousReturnStatus = qSM_EXIT_SUCCESS;            
                break;
            case qSM_CHANGE_INITSTATE:
                obj->qPrivate.InitState = s;
                break;    
            case qSM_CLEAR_STATE_FIRST_ENTRY_FLAG:
                obj->qPrivate.xPublic.PreviousState = NULL;
                obj->qPrivate.xPublic.LastState = NULL;
                break;
            case qSM_SURROUNDING_STATE:
                obj->qPrivate.Surrounding = Surrounding; 
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
/*qBool_t qStateMachine_TransitionTableInstall( qSM_t * const obj, qSM_TransitionTable_t *table, qSM_Transition_t *entries, size_t NoOfEntries )

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

    if( ( NULL != obj ) && ( NULL != table ) && ( NULL != entries ) && ( NoOfEntries > (size_t)0 ) ){
        table->qPrivate.NumberOfEntries = NoOfEntries;
        table->qPrivate.Transitions = entries;
        obj->qPrivate.TransitionTable = table;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_SignalQueueSetup( qSM_t * const obj, qQueue_t *xQueue, qSM_Signal_t *AxSignals, size_t MaxSignals )

Setup the state-machine signal queue.
Note : Signals feature only available if queues are enabled in qconfig.h [ Q_QUEUES == 1 ]

Parameters:

    - obj : a pointer to the FSM object.
    - xQueue : a pointer to the queue instance.
    - AxSignals : A pointer to the memory area used for queueing signals. qSM_Signal_t[MaxSignals]
    - MaxSignals : The number of items inside <AxSignals>.

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/ 
qBool_t qStateMachine_SignalQueueSetup( qSM_t * const obj, qQueue_t *xQueue, qSM_Signal_t *AxSignals, size_t MaxSignals ){
    qBool_t RetValue = qFalse;

    #if ( Q_QUEUES == 1 )
        if( ( NULL != AxSignals ) && ( MaxSignals > (size_t)0u ) ){
            obj->qPrivate.SignalQueue = xQueue;
            RetValue = qQueue_Setup( xQueue, AxSignals, sizeof(qSM_Signal_t), MaxSignals );
        }
    #else
        Q_UNUSED( obj );
        Q_UNUSED( AxSignals );
        Q_UNUSED( MaxSignals );
    #endif
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_SweepTransitionTable( qSM_t * const obj, qSM_Signal_t xSignal )

Forces a sweep over the installed transition table. The instance will be updated 
if a transition from the table is performed.

Note : This method is performed from the <qStateMachine_Run> API before the 
current state callback is invoked.

Parameters:

    - obj : a pointer to the FSM object.
    - xSignal : the incoming signal

Return value:

    Returns qTrue if the sweep produce a state transition, otherwise returns qFalse;
*/
qBool_t qStateMachine_SweepTransitionTable( qSM_t * const obj, qSM_Signal_t xSignal ){
    qBool_t RetValue = qFalse;
                 
    if( NULL != obj ){
        qSM_TransitionTable_t *table = obj->qPrivate.TransitionTable; /*MISRAC2012-Rule-11.5 deviation allowed*/

        if( NULL != table ){
            /*xSignal = obj->qPrivate.xPublic.Signal;*/
            if( xSignal <= QSM_SIGNAL_RANGE_MAX ){ /*check for a valid signal value*/
                qSM_State_t xCurrentState = obj->qPrivate.xPublic.NextState;
                qSM_Transition_t iTransition;
                size_t iEntry;
                qBool_t SigActionGuard = qTrue;

                for( iEntry = 0; iEntry < table->qPrivate.NumberOfEntries; ++iEntry ){ /*loop the transition-table entries*/
                    iTransition = table->qPrivate.Transitions[ iEntry ]; /*get the current entry*/
                    if( ( xSignal == iTransition.Signal) && ( ( NULL == iTransition.xCurrentState ) || ( xCurrentState == iTransition.xCurrentState ) ) ){ /*both conditions match*/
                        if( NULL != iTransition.SignalAction ){  /*run the signal-action(or guard) if available*/
                            SigActionGuard = iTransition.SignalAction( &obj->qPrivate.xPublic );
                        }
                        if( qTrue == SigActionGuard ){ /*check if the guard allow the transition*/
                            qSM_t *toTargetFSM;

                            obj->qPrivate.xPublic.NextState = iTransition.xNextState;    /*make the transition to the target state*/
                            /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
                            toTargetFSM = (qSM_t*)iTransition.xToTargetHandle; /*MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed*/
                            /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/       

                            if( QSM_H_DEEP_HISTORY == toTargetFSM ){
                                /* nothing to do, deep history its preserved by default*/
                            }
                            else if( QSM_H_SHALLOW_HISTORY == toTargetFSM ){
                                /*TODO*/
                                break;
                            }
                            else if( QSM_H_NO_HISTORY == toTargetFSM ){ /*restore init/states on nested*/
                                qSM_HierarchicalInstance_t *hi = obj->qPrivate.hInstance;
                                obj->qPrivate.Active = qFalse;
                                if ( NULL != hi ){
                                    if( hi->childscount > (size_t)1u ){
                                        size_t i;
                                        for( i = 1u ; i < hi->childscount; ++i ){
                                            qStateMachine_ExecStateIfAvailable( hi->childs[ i ], hi->childs[ i ]->qPrivate.xPublic.NextState, QSM_SIGNAL_EXIT );
                                            hi->childs[ i ]->qPrivate.xPublic.NextState = hi->childs[ i ]->qPrivate.InitState;
                                        }
                                    }
                                }
                                break;
                            }
                            else{
                                if( iTransition.xToTargetState != toTargetFSM->qPrivate.xPublic.LastState ){ /*innermost check : target state differs from the current?*/
                                    qStateMachine_ExecStateIfAvailable( toTargetFSM, toTargetFSM->qPrivate.xPublic.NextState, QSM_SIGNAL_EXIT );
                                    toTargetFSM->qPrivate.xPublic.NextState = iTransition.xToTargetState; /*move to the new state*/
                                    qStateMachine_TimeoutQueueCleanup( toTargetFSM ); 
                                    break; 
                                }
                            }

                        }
                        else if( qIgnore == SigActionGuard ){
                            /* TODO: signal should be queueded again*/ 
                        }
                        else{
                            /*nothing to do here*/
                        }
                        RetValue = qTrue;
                    } 
                    SigActionGuard = qTrue;
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
Note : Signals feature only available if queues are enabled in qconfig.h [ Q_QUEUES == 1 ]  

Parameters:

    - obj : a pointer to the FSM object.
    - signal : The user-defined signal
    - isUrgent : If qTrue, the signal will be sent to the front of the transition-table queue.

Return value:

    qTrue if the provided signal was successfully delivered to the FSM, otherwise return qFalse.

*/
qBool_t qStateMachine_SendSignal( qSM_t * const obj, qSM_Signal_t xSignal, qBool_t isUrgent ){
    qBool_t RetValue = qFalse;

    #if ( Q_QUEUES == 1 )
        if( ( NULL != obj ) && ( QSM_SIGNAL_NONE != xSignal ) ){
            if( NULL != obj->qPrivate.SignalQueue ){ /*check if the state-machine has a signal queue*/
                RetValue = qQueue_SendGeneric( obj->qPrivate.SignalQueue, &xSignal, (qQueue_Mode_t)isUrgent );  
            }
        }
    #else
        Q_UNUSED( obj );
        Q_UNUSED( xSignal );
        Q_UNUSED( isUrgent );
    #endif
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
    /*qSM_t *last;*/
    if( ( NULL != parent ) && ( NULL != state ) && ( NULL != child ) ){
        child->qPrivate.xPublic.Parent = parent;
        child->qPrivate.Composite.rootState = state;

        /*insert child fsm into the composite fsm list*/
        child->qPrivate.Composite.next = parent->qPrivate.Composite.head;
        parent->qPrivate.Composite.head = child;        
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
/*this functionality its under test*/
void qStateMachine_CloseDesign( qSM_t * const obj, qSM_HierarchicalInstance_t *h ){
    if( ( NULL != obj ) && ( NULL != h ) ){
        size_t i;
        obj->qPrivate.hInstance = h;

        for( i = 0u ; i < (size_t)Q_FSM_MAX_NEST_DEPTH; ++i ){
            obj->qPrivate.hInstance->childs[ i ] = NULL;
        }
        obj->qPrivate.hInstance->childscount = 0u;

        qStateMachine_Run( obj, QSM_PACK_CHILDS );
    }
}
/*============================================================================*/
static qBool_t qStateMachine_StackIsEmpty( qSM_Stack_t *top ){ 
    qBool_t RetValue = qTrue;

    if( NULL != top ){
        RetValue = ( 0u == qSM_NestStack.Index )? qTrue : qFalse;
    }
    return RetValue; 
}  
/*============================================================================*/
static void qStateMachine_StackPush( qSM_Stack_t **top_ref, qSM_t *t ){ 
    if( qSM_NestStack.Index < (size_t)Q_FSM_MAX_NEST_DEPTH ){
        qSM_Stack_t *new_tNode;

        new_tNode = &qSM_NestStack.Element[ qSM_NestStack.Index++ ];
        new_tNode->t  = t;  /* put in the data  */
        new_tNode->next = (*top_ref);  /* link the old list of the new tNode */   
        (*top_ref) = new_tNode;   /* move the head to point to the new tNode */      
    }
} 
/*============================================================================*/
static qSM_t* qStateMachine_StackPop( qSM_Stack_t **top_ref ){ 
    qSM_t *res = NULL; 
    
    if( qFalse == qStateMachine_StackIsEmpty( *top_ref ) ){ 
        qSM_Stack_t *top = *top_ref; 
        res = top->t; 
        *top_ref = top->next; 
        --qSM_NestStack.Index; 
    } 
    return res;
} 
/*============================================================================*/
static void qStateMachine_StackCleanUp( void ){
    size_t i;

    for( i = 0u; i < (size_t)Q_FSM_MAX_NEST_DEPTH; ++i ){
        qSM_NestStack.Element[ i ].next = NULL;
        qSM_NestStack.Element[ i ].t = NULL;
    }
    qSM_NestStack.Index = 0u;
}
/*============================================================================*/

#endif /* #if ( Q_FSM == 1 ) */
