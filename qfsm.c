#include "qfsm.h"

#if ( Q_FSM == 1 )


typedef qByte_t qSM_LCA_t;

static void qStateMachine_Transition( qSM_t *m, qSM_State_t *target );

static qSM_LCA_t qStateMachine_LevelsToLeastCommonAncestor( qSM_t * const m, qSM_State_t * const target );
static void qStateMachine_ExitUpToLeastCommonAncestor( qSM_t * const m, qSM_LCA_t lca );
static void qStateMachine_PrepareHandler( qSM_UnprotectedHandler_t h, qSM_Signal_t xSignal );
static qSM_Status_t qStateMachine_InvokeStateCallback( qSM_t * const m, qSM_State_t * const s, qSM_UnprotectedHandler_t h );


static void qStateMachine_StateOnExit( qSM_t * const m, qSM_State_t * const s );
static void qStateMachine_StateOnEntry( qSM_t * const m, qSM_State_t * const s );
static qSM_State_t* qStateMachine_StateOnStart( qSM_t * const m, qSM_State_t * const s );
static qSM_Status_t qStateMachine_StateOnSignal( qSM_t * const m, qSM_State_t * const s, qSM_Signal_t xSignal );
static void qStateMachine_TracePathandRetraceEntry( qSM_t * const m, qSM_State_t **entryPath );
static void qStateMachine_TraceOnStart( qSM_t * const m, qSM_State_t **entryPath );

static void qStateMachine_SweepTransitionTable( qSM_t * const m, qSM_State_t * const CurrentState, qSM_UnprotectedHandler_t h );

static void qStateMachine_TimeoutCheckSignals( qSM_t * const m );
static void qStateMachine_TimeoutPerformSpecifiedActions( qSM_t * const m, qSM_State_t *current, qSM_Signal_t xSignal );

#define QSM_TSOPT_INDEX_MASK    ( 0x00FFFFFFuL )

/*============================================================================*/
static void qStateMachine_Transition( qSM_t *m, qSM_State_t *target ){ /*wrapper*/
    if( NULL == m->qPrivate.next ){
        qStateMachine_ExitUpToLeastCommonAncestor( m,  qStateMachine_LevelsToLeastCommonAncestor( m, target ) );
        m->qPrivate.next = target;
    }
}
/*============================================================================*/
static qSM_LCA_t qStateMachine_LevelsToLeastCommonAncestor( qSM_t * const m, qSM_State_t * const target ){
    qSM_LCA_t toLca = 0u;

    if( m->qPrivate.source == target ){ /*recursive transition, only a level needs to be performed*/
        toLca = 1u;
    }
    else{
        qSM_State_t *s, *t;
        qBool_t xBreak = qFalse; /*just to be in compliance with the MISRAC2012-Rule-15.5*/
        qSM_LCA_t n = 0u; 
        for( s = m->qPrivate.source; NULL != s; s = s->qPrivate.parent ) {
            for( t = target; NULL != t; t = t->qPrivate.parent ) {
                if( s == t ){
                    toLca = n;
                    xBreak = qTrue;
                    break;
                }
            }
            if( qTrue == xBreak ){ /*also break the outer loop*/
                break;
            }
            ++n;
        }        
    }
    return toLca;  
}
/*============================================================================*/
static void qStateMachine_ExitUpToLeastCommonAncestor( qSM_t * const m, qSM_LCA_t lca ){
    qSM_State_t *s = m->qPrivate.current;
    while( s != m->qPrivate.source ){
        (void)qStateMachine_StateOnExit( m, s );
        s = s->qPrivate.parent;   
    }
    while( 0u != lca-- ) {
        (void)qStateMachine_StateOnExit( m, s ); 
        s = s->qPrivate.parent;
    }
    m->qPrivate.current = s;    
}
/*============================================================================*/
static void qStateMachine_PrepareHandler( qSM_UnprotectedHandler_t h, qSM_Signal_t xSignal ){
    h->Signal = xSignal;
    h->NextState = NULL;
    h->StartState = NULL;
    h->Status = qSM_STATUS_NULL;    
}
/*============================================================================*/
static qSM_Status_t qStateMachine_InvokeStateCallback( qSM_t *m, qSM_State_t * const s, qSM_UnprotectedHandler_t h ){
    if( NULL != m->qPrivate.surrounding ){
        h->Status = qSM_STATUS_BEFORE_ANY;
        /*cstat -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
        m->qPrivate.surrounding( (qSM_Handler_t)h ); /*cast allowed, struct layout its compatible*/
        /*cstat +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
    }
    if( NULL != s->qPrivate.sCallback ){
        h->Status = qSM_STATUS_NULL;
        /*cstat -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
        h->Status = s->qPrivate.sCallback( (qSM_Handler_t)h ); /*execute the state callback (Transitions here are not allowed)*/ /*cast allowed, struct layout its compatible*/
        /*cstat +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
    }
    else{
        h->Status = qSM_STATUS_EXIT_FAILURE;
    }

    if( NULL != m->qPrivate.surrounding ){ /*this property can change from the callback, so check it again*/
        if( h->Status < qSM_STATUS_EXIT_FAILURE ){
            h->Status = qSM_STATUS_EXIT_FAILURE;
        }
        /*cstat -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
        m->qPrivate.surrounding( (qSM_Handler_t)h ); /*cast allowed, struct layout its compatible*/
        /*cstat +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
    }
    return h->Status;
}
/*============================================================================*/
static void qStateMachine_StateOnExit( qSM_t * const m, qSM_State_t * const s ){ 
    qSM_UnprotectedHandler_t h = &m->qPrivate.handler;
    
    qStateMachine_PrepareHandler( h, QSM_SIGNAL_EXIT );
    (void)qStateMachine_InvokeStateCallback( m, s, h);
    s->qPrivate.lastRunningChild = m->qPrivate.current; /*remember the last running child*/
    qStateMachine_TimeoutPerformSpecifiedActions( m, s , QSM_SIGNAL_EXIT );
}
/*============================================================================*/
static void qStateMachine_StateOnEntry( qSM_t * const m, qSM_State_t * const s ){ 
    qSM_UnprotectedHandler_t h = &m->qPrivate.handler;
    
    qStateMachine_PrepareHandler( h, QSM_SIGNAL_ENTRY );
    (void)qStateMachine_InvokeStateCallback( m, s, h );
    qStateMachine_TimeoutPerformSpecifiedActions( m, s , QSM_SIGNAL_ENTRY );
}
/*============================================================================*/
static qSM_State_t* qStateMachine_StateOnStart( qSM_t * const m, qSM_State_t * const s ){
    qSM_UnprotectedHandler_t h = &m->qPrivate.handler;

    qStateMachine_PrepareHandler( h, QSM_SIGNAL_START );
    (void)qStateMachine_InvokeStateCallback( m, s, h );
    if( NULL != s->qPrivate.ChildStart ){ /*set the start transition if available*/
        if( qTrue == s->qPrivate.keephistory ){
            if( NULL != s->qPrivate.lastRunningChild ){
                m->qPrivate.next = s->qPrivate.lastRunningChild; 
            }
        }
        else{
            m->qPrivate.next = s->qPrivate.ChildStart;
        }
    }
    if( NULL != h->StartState ){ /*changes from callback takes more precedence*/
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        m->qPrivate.next = (qSM_State_t*)h->StartState ;
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    }   
    return m->qPrivate.next;
}
/*============================================================================*/
static qSM_Status_t qStateMachine_StateOnSignal( qSM_t * const m, qSM_State_t * const s, qSM_Signal_t xSignal ){
    qSM_UnprotectedHandler_t h = &m->qPrivate.handler;
    qSM_Status_t status;
    
    qStateMachine_PrepareHandler( h, xSignal );
    if( NULL != m->qPrivate.tTable ){
        qStateMachine_SweepTransitionTable( m, s, h ); 
    }
    status = qStateMachine_InvokeStateCallback( m, s, h );
 
    if( NULL != h->NextState ){ /*perform the transition if available*/
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qStateMachine_Transition( m, (qSM_State_t*)h->NextState );
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        status = qSM_STATUS_SIGNAL_HANDLED; /*the signal is assumed to be handled if the transition occurs*/
    }
    
    return status;
}
/*============================================================================*/
static void qStateMachine_TracePathandRetraceEntry( qSM_t * const m, qSM_State_t **trace ){
    qSM_State_t *s;

    *trace = NULL;
    for(s = m->qPrivate.next; s != m->qPrivate.current; s = s->qPrivate.parent ) {
        *(++trace) = s;  /* trace path to target */
    }
    while( NULL != ( s = *trace-- ) ) {  /* retrace entry from LCA */
        qStateMachine_StateOnEntry( m, s );
    }
    m->qPrivate.current = m->qPrivate.next;
    m->qPrivate.next = NULL;    
}
/*============================================================================*/
static void qStateMachine_TraceOnStart( qSM_t * const m, qSM_State_t **entryPath ){
    while( NULL != qStateMachine_StateOnStart( m, m->qPrivate.current ) ){
        qStateMachine_TracePathandRetraceEntry( m, entryPath );
    }
}
/*============================================================================*/
/*qBool_t qStateMachine_Run( qSM_t * const m, qSM_Signal_t xSignal )

Execute the Finite State Machine (FSM).

Parameters:

    - m : a pointer to the FSM object.
    - xSignal : User-defined signal (this value will be ignored if the installed queue 
                has items available)

Return value: 

    qTrue if the signal was successfully handled, otherwise returns qFalse.
*/
qBool_t qStateMachine_Run( qSM_t * const m, qSM_Signal_t xSignal ){
    qBool_t RetValue = qFalse;
    if( NULL != m ){
        qSM_State_t *entryPath[ Q_FSM_MAX_NEST_DEPTH ];
        qSM_State_t *s;
        
        qStateMachine_TimeoutCheckSignals( m );
        #if ( Q_QUEUES == 1 )
            if( NULL != m->qPrivate.queue ){
                qSM_Signal_t ReceivedSignal;
                if( qTrue == qQueue_Receive( m->qPrivate.queue, &ReceivedSignal ) ){
                    xSignal = ReceivedSignal; 
                }
            }
        #endif
        if ( ( QSM_SIGNAL_NONE == xSignal ) && ( QSM_SIGNAL_NONE != m->qPrivate.SignalNot ) ){ 
            xSignal = m->qPrivate.SignalNot;
            m->qPrivate.SignalNot = QSM_SIGNAL_NONE; 
        }

        if( NULL == m->qPrivate.current  ){ /*Enter only once to start the top state*/
            m->qPrivate.current = &m->qPrivate.top;
            m->qPrivate.next = NULL;
            qStateMachine_StateOnEntry( m, m->qPrivate.current );
            qStateMachine_TraceOnStart( m, entryPath );
        }
        
        for( s = m->qPrivate.current; NULL != s; s = s->qPrivate.parent ){
            m->qPrivate.source = s; /* level of outermost event handler */
            if( qSM_STATUS_SIGNAL_HANDLED == qStateMachine_StateOnSignal( m, s, xSignal ) ) {
                if( NULL != m->qPrivate.next) {  /* state transition taken? */
                    qStateMachine_TracePathandRetraceEntry( m, entryPath );
                    qStateMachine_TraceOnStart( m, entryPath );
                }
                RetValue = qTrue;
                break;/* signal processed */
            }
        }   
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_Setup( qSM_t * const m, qSM_StateCallback_t topCallback, qSM_State_t * const childstart, qSM_SurroundingCallback_t surrounding, void *Data )

Initializes a finite state machine (FSM) object.
(this API also initializes the top state)

Parameters:

    - m : a pointer to the FSM object.
    - topCallback : the callback for the "Top" state
    - childstart : The first state to be executed (init-state). 
    - Surrounding : The surrounding callback. To ignore pass NULL      
    - Data : Represents the FSM arguments. All arguments must be passed by 
             reference and cast to (void *). Only one argument is allowed, so,
             for multiple arguments, create a structure that contains all of 
             the arguments and pass a pointer to that structure.           

Return value:

    Returns qTrue on Success, otherwise returns qFalse
*/
qBool_t qStateMachine_Setup( qSM_t * const m, qSM_StateCallback_t topCallback, qSM_State_t * const childstart, qSM_SurroundingCallback_t surrounding, void *Data ){
    qBool_t RetValue = qFalse;
    if( ( NULL != m ) ){
        m->qPrivate.current = NULL;
        m->qPrivate.next = NULL;
        m->qPrivate.source = NULL;
        m->qPrivate.Data = Data;
        m->qPrivate.surrounding = surrounding;
        m->qPrivate.handler.machine = m;
        m->qPrivate.handler.Data = Data;
        #if ( Q_QUEUES == 1 )
            m->qPrivate.queue = NULL;
        #endif
        m->qPrivate.TimeSpec = NULL;
        m->qPrivate.tTable = NULL;
        m->qPrivate.tEntries = 0u;

        RetValue = qStateMachine_StateSubscribe( m, &m->qPrivate.top, NULL, topCallback, childstart, qFalse );
        m->qPrivate.top.qPrivate.parent = NULL;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_StateSubscribe( qSM_t * const m, qSM_State_t * const state, qSM_State_t * const parent, qSM_StateCallback_t StateFcn, qSM_State_t * const ChildStart, const qBool_t KeepHistory )

This function subscribes the FSM instance to a specific state with an associated 
callback function. 

Parameters:

    - m : a pointer to the FSM object.
    - state : A pointer to the state object.
    - parent : A pointer to the parent state. 
              ( pass NULL if this state its a child of the "Top" state)
    - StateFcn: The handler function associated to the state.
    			Prototype: qSM_Status_t xCallback( qSM_Handler_t h )
    - ChildStart : The first child-state to be executed if the 
                    subscribed state its a parent in an hierarchical pattern,
                   To ignore pass NULL as argument.
    - KeepHistory : <qTrue> to keep the shallow history of the subscribed state.

Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qStateMachine_StateSubscribe( qSM_t * const m, qSM_State_t * const state, qSM_State_t * const parent, qSM_StateCallback_t StateFcn, qSM_State_t * const ChildStart, const qBool_t KeepHistory ){
    qBool_t RetValue = qFalse;
    if( NULL != state ){
        state->qPrivate.keephistory = KeepHistory;
        state->qPrivate.lastRunningChild = ( qTrue == KeepHistory )? ChildStart : NULL;
        state->qPrivate.ChildStart = ChildStart;
        state->qPrivate.sCallback = StateFcn;
        if( NULL == parent ){
            state->qPrivate.parent = &m->qPrivate.top;
        }
        else{
            state->qPrivate.parent = parent;
        }
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_InstallTransitionTable( qSM_t * const m, qSM_Transition_t * const table, const size_t n )

Installs a transition table in to the supplied state machine

Parameters:

    - m : a pointer to the FSM object.
    - table : An array of transitions that describes the state-machine behavior.
    - n : The number of transitions available within the table

Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qStateMachine_InstallTransitionTable( qSM_t * const m, qSM_Transition_t * const table, const size_t n ){
    qBool_t RetValue = qFalse;
    if( ( NULL != m ) && ( NULL != table) && ( n > 0u ) ){
        m->qPrivate.tTable = table;
        m->qPrivate.tEntries = n;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_InstallSignalQueue( qSM_t * const m, qQueue_t *queue )

Installs a signal queue of qSM_Signal_t in to the supplied state machine
Note: Queue object should be previously initialized by using "qQueue_Setup"
Note: Queue itemsize == qSM_Signal_t. 

Parameters:

    - m : a pointer to the FSM object.
    - queue: a pointer to the queue object.

Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qStateMachine_InstallSignalQueue( qSM_t * const m, qQueue_t *queue ){
    qBool_t RetValue = qFalse;
    #if ( Q_QUEUES == 1 )
        if( ( NULL != m ) && ( NULL != queue) ){
            if( ( qTrue == qQueue_IsReady( queue ) )  &&  ( sizeof(qSM_Signal_t) == queue->qPrivate.ItemSize )  ){
                m->qPrivate.queue = queue;
                RetValue = qTrue;
            }
        }
    #else
        Q_UNUSED( m );
        Q_UNUSED( queue );
    #endif    
    return RetValue;
}
/*============================================================================*/
static void qStateMachine_SweepTransitionTable( qSM_t * const m, qSM_State_t * const CurrentState, qSM_UnprotectedHandler_t h ){
    size_t i, n;
    qBool_t TransitionAllowed;
    qSM_Transition_t *iTransition;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    qSM_Transition_t *table = (qSM_Transition_t *)m->qPrivate.tTable;
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    n = m->qPrivate.tEntries;
    for( i = 0; i < n; ++i ){
        iTransition = &table[ i ];
        TransitionAllowed = qTrue; /*if no signal-guard available, allow the transition by default*/
        if( ( CurrentState == iTransition->CurrentState ) && ( h->Signal == iTransition->xSignal ) ){ /*table entry match*/
            if( NULL != iTransition->Guard ){
                /*cstat -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
                TransitionAllowed = iTransition->Guard( (qSM_Handler_t)h ); /*cast allowed, struct layout its compatible*/
                /*cstat +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
            }
            if( qTrue == TransitionAllowed ){
                if( NULL != iTransition->NextState ){
                    h->NextState = iTransition->NextState; /*set the transition from the table*/    
                    break;
                }
            }
        }
    }
}
/*============================================================================*/
/*qBool_t qStateMachine_SendSignal( qSM_t * const obj, qSM_Signal_t signal, const qBool_t isUrgent )

Send a signal to the specified state machine.

Note : If the signal queue is not available, an exclusion variable will be used.
       This means that the signal cannot be sent until the variable is empty. 
       (the signal was handled by the state-machine engine).
Note: The signal-queue has the highest precedence.       

Parameters:
    - obj : a pointer to the FSM object.
    - signal : The user-defined signal
    - isUrgent : If qTrue, the signal will be sent to the front of the queue. (only if the
                 there is a signal-queue available)

Return value:

    qTrue if the provided signal was successfully delivered to the FSM, otherwise return qFalse.
    qFalse if there is a queue, and the signal cannot be inserted because it is full.
*/
qBool_t qStateMachine_SendSignal( qSM_t * const m, qSM_Signal_t xSignal, const qBool_t isUrgent ){
    qBool_t RetValue = qFalse;

    if( ( NULL != m ) && ( xSignal < QSM_SIGNAL_NONE  ) ){
        #if ( Q_QUEUES == 1 )
            if( NULL != m->qPrivate.queue ){ /*check if the state-machine has a signal queue*/
                RetValue = qQueue_SendGeneric( m->qPrivate.queue, &xSignal, (qQueue_Mode_t)isUrgent );  
            }
        #else
            Q_UNUSED( isUrgent );
        #endif
        
        if( ( qFalse == RetValue ) && ( QSM_SIGNAL_NONE == m->qPrivate.SignalNot ) ){
            m->qPrivate.SignalNot = xSignal;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
static void qStateMachine_TimeoutCheckSignals( qSM_t * const m ){
    qSM_TimeoutSpec_t *ts = m->qPrivate.TimeSpec;
    if( NULL != ts ) {
        size_t i;
        for( i = 0 ; i < (size_t)Q_FSM_MAX_TIMEOUTS; ++i ){
            if( qTrue == qSTimer_Expired( &ts->builtin_timeout[ i ] ) ) {
                #if ( Q_QUEUES == 1 )
                    (void)qStateMachine_SendSignal( m, QSM_SIGNAL_TIMEOUT(i), qFalse );   
                #endif
                if( 0uL  != ( ts->isPeriodic & (1uL <<  i) ) ){
                    (void)qSTimer_Reload( &ts->builtin_timeout[ i ] );
                }
                else{
                    (void)qSTimer_Disarm( &ts->builtin_timeout[ i ] );
                }
            } 
        }
    }
}
/*============================================================================*/
static void qStateMachine_TimeoutPerformSpecifiedActions( qSM_t * const m, qSM_State_t *current, qSM_Signal_t xSignal ){
    if( NULL != m->qPrivate.TimeSpec ){
        qSM_TimeoutStateDefinition_t *tbl = m->qPrivate.TimeSpec->spec;
        size_t n = m->qPrivate.TimeSpec->n;    

        if( ( n > 0u ) && ( NULL != tbl ) ){
            size_t i;
            qSM_TimeoutSpecOptions_t SetCheck, ResetCheck;
            if( QSM_SIGNAL_ENTRY == xSignal){
                SetCheck = QSM_TSOPT_SET_ENTRY; 
                ResetCheck = QSM_TSOPT_RST_ENTRY;
            }
            else{
                SetCheck = QSM_TSOPT_SET_EXIT; 
                ResetCheck = QSM_TSOPT_RST_EXIT;
            }

            for( i = 0u; i < n;  ++i ){ /*loop table */
                qSM_TimeoutSpecOptions_t opt = tbl[ i ].options;
                qIndex_t index = opt & QSM_TSOPT_INDEX_MASK; /*get the timeout index*/

                if( ( current == tbl[ i ].xState ) &&  ( index < (qIndex_t)Q_FSM_MAX_TIMEOUTS ) ){ /*state match and index is valid?*/
                    qSTimer_t *tmr = &m->qPrivate.TimeSpec->builtin_timeout[ index ]; /*get the timeout handle*/
                    qTime_t tValue = tbl[ i ].xTimeout;
                    if( 0uL != ( opt & SetCheck ) ){
                        if( 0uL == ( opt & QSM_TSOPT_KEEP_IF_SET ) ){
                            (void)qSTimer_Set( tmr, tValue  );        
                        }
                        if( 0uL != (opt & QSM_TSOPT_PERIODIC) ){
                            m->qPrivate.TimeSpec->isPeriodic |= (qUINT32_t)( ( 1uL << index ));         
                        }
                        else{
                            m->qPrivate.TimeSpec->isPeriodic &= (qUINT32_t)(~( 1uL << index ));      
                        }
                    }   
                    if( 0uL != ( opt & ResetCheck ) ){
                        (void)qSTimer_Disarm( tmr );
                    }     
                }
            }
        }
    }
}
/*============================================================================*/
/*qBool_t qStateMachine_InstallTimeoutSpec( qSM_t * const m,  qSM_TimeoutSpec_t * const ts, qSM_TimeoutStateDefinition_t *tdef, const size_t n )

Install the Timeout specification object to use the FSM built-in timeouts.
This methods also set fixed timeouts for specific states using a lookup-table. 
Note : This feature its only available if the FSM has a signal queue installed.
Note : The lookup table will be an array of type <qSM_TimeoutStateDefinition_t> with 
      <nEntries> elements matching { state, time, options }. 
Note : You can increse the number of available timeouts instances by changing 
        the Q_FSM_MAX_TIMEOUTS configuration macro inside qconfig.h      

Parameters:

    - m : a pointer to the target FSM object.
    - ts : a pointer to the timeout specification object
    - tdef : the lookup table matching the target state and the requested timeout.
    - n: the number of elements inside <tdef>. 

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/ 
qBool_t qStateMachine_InstallTimeoutSpec( qSM_t * const m,  qSM_TimeoutSpec_t * const ts, qSM_TimeoutStateDefinition_t *tdef, const size_t n ){
    qBool_t RetValue = qFalse;

    if( ( NULL != m ) && ( NULL != ts ) ){
        size_t i;

        m->qPrivate.TimeSpec = ts;
        for( i = 0 ; i < (size_t)Q_FSM_MAX_TIMEOUTS; ++i ){
            qSTimer_Disarm( &m->qPrivate.TimeSpec->builtin_timeout[ i ] );
        }
        if( ( NULL != tdef ) && ( n > 0u ) ){
            m->qPrivate.TimeSpec->n = n;
            m->qPrivate.TimeSpec->spec = tdef;
        }
        else{
            m->qPrivate.TimeSpec->n = 0u;
            m->qPrivate.TimeSpec->spec = NULL;
        }
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_TimeoutSet( qSM_t * const m, const qIndex_t xTimeout, const qTime_t time )

Set the time for the selected built-in timeout inside the target FSM
<Requirements> : 
   *> An installed time specification. For this use <qStateMachine_InstallTimeoutSpec>
   *> An installed signal queue. For this use <qStateMachine_InstallSignalQueue>

Parameters:
    - m : a pointer to the target FSM object.
    - xTimeout : the index of the timeout (0, 1, 2 ... (Q_FSM_MAX_TIMEOUTS-1) )
    - time : the specified time

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/ 
qBool_t qStateMachine_TimeoutSet( qSM_t * const m, const qIndex_t xTimeout, const qTime_t time ){
    qBool_t RetValue = qFalse;

    if( ( NULL != m ) && ( xTimeout <= (qIndex_t)Q_FSM_MAX_TIMEOUTS ) ){
        if( NULL != m->qPrivate.TimeSpec ){
            RetValue = qSTimer_Set( &m->qPrivate.TimeSpec->builtin_timeout[ xTimeout ], time  );
        }
    }

    return RetValue;
}
/*============================================================================*/
/*qBool_t qStateMachine_TimeoutSet( qSM_t * const m, const qIndex_t xTimeout, const qTime_t time )

Stop the time count for the selected built-in timeout inside the target FSM
<Requirements> : 
   *> An installed time specification. For this use <qStateMachine_InstallTimeoutSpec>
   *> An installed signal queue. For this use <qStateMachine_InstallSignalQueue>

Parameters:
    - m : a pointer to the target FSM object.
    - xTimeout : the index of the timeout (0, 1, 2 ... (Q_FSM_MAX_TIMEOUTS-1) )

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/ 
void qStateMachine_TimeoutStop( qSM_t * const m, const qIndex_t xTimeout ){
    if( ( NULL != m->qPrivate.TimeSpec ) && ( xTimeout < (qIndex_t)Q_FSM_MAX_TIMEOUTS ) ){
        #if ( Q_QUEUES == 1 )
            size_t cnt;
            qSM_Signal_t xSignal;
            
            cnt = qQueue_Count( m->qPrivate.queue );
            while( 0u != cnt-- ){
                if( qTrue == qQueue_Receive( m->qPrivate.queue , &xSignal ) ){
                    if( xSignal != QSM_SIGNAL_TIMEOUT(xTimeout) ){ /*keep the non-timeout signals*/
                        (void)qQueue_SendToBack( m->qPrivate.queue , &xSignal );
                    }
                }
            }           
        #endif
        qSTimer_Disarm( &m->qPrivate.TimeSpec->builtin_timeout[ xTimeout ] );
    }    
}
/*============================================================================*/
void* qStateMachine_Get( qSM_t * const m, const qSM_Attribute_t attr ){
    void *Attribute = NULL;
    if( NULL != m ){
        switch ( attr ){
            case qSM_ATTRIB_STATE_TOP:
                Attribute = &m->qPrivate.top;
                break;  
            case qSM_ATTRIB_STATE_CURRENT:
                Attribute = m->qPrivate.current;
                break;           
            case qSM_ATTRIB_SIGNAL_QUEUE:
                Attribute = m->qPrivate.queue;
                break;         
            case qSM_ATTRIB_TIMESPEC:
                Attribute = m->qPrivate.TimeSpec;
                break;       
            case qSM_ATTRIB_TRANSITION_TABLE:
                Attribute = m->qPrivate.tTable;
                break;  
            case qSM_ATTRIB_DATA:
                Attribute = m->qPrivate.Data;
                break;                
            default:
                break;
        }
    }
    return Attribute;
}
/*============================================================================*/
qBool_t qStateMachine_Set_StateCallback( qSM_State_t * const state, qSM_StateCallback_t StateFcn ){
    qBool_t RetValue = qFalse;
    if( NULL != state ){
        state->qPrivate.sCallback = StateFcn;
    }
    return RetValue;
}
/*============================================================================*/


#endif /*#if ( Q_FSM == 1 )*/