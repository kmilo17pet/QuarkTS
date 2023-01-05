/*!
 * @file qfsm.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qfsm.h"
#include "qflm.h"
#include <string.h>

#if ( Q_FSM == 1 )

typedef qByte_t qSM_LCA_t;

static void qStateMachine_Transition( qSM_t *m,
                                      qSM_State_t *target,
                                      const qSM_TransitionHistoryMode_t mHistory );
static qSM_LCA_t qStateMachine_LevelsToLCA( qSM_t * const m,
                                            qSM_State_t * const target );
static void qStateMachine_ExitUpToLCA( qSM_t * const m,
                                       qSM_LCA_t lca );
static void qStateMachine_PrepareHandler( qSM_UnprotectedHandler_t h,
                                          const qSM_Signal_t sig,
                                          qSM_State_t * const s );
static qSM_Status_t qStateMachine_InvokeStateCallback( qSM_t * const m,
                                                       qSM_State_t * const s,
                                                       qSM_UnprotectedHandler_t h );
static qSM_State_t* qStateMachine_StateOnExit( qSM_t * const m,
                                               qSM_State_t * const s );
static void qStateMachine_StateOnEntry( qSM_t * const m,
                                        qSM_State_t * const s );
static qSM_State_t* qStateMachine_StateOnStart( qSM_t * const m,
                                                qSM_State_t * const s );
static qSM_Status_t qStateMachine_StateOnSignal( qSM_t * const m,
                                                 qSM_State_t * const s,
                                                 const qSM_Signal_t sig );
static void qStateMachine_TracePathAndRetraceEntry( qSM_t * const m,
                                                    qSM_State_t **trace );
static void qStateMachine_TraceOnStart( qSM_t * const m,
                                        qSM_State_t **entryPath );
static qSM_Signal_t qStateMachine_CheckForSignals( qSM_t * const m,
                                                   const qSM_Signal_t sig );
static void qStateMachine_SweepTransitionTable( qSM_State_t * const currentState,
                                                qSM_UnprotectedHandler_t h );
static void qStateMachine_TimeoutCheckSignals( qSM_t * const m );
static void qStateMachine_TimeoutPerformSpecifiedActions( qSM_t * const m,
                                                          qSM_State_t *current,
                                                          const qSM_SigId_t sig );
static qBool_t qStateMachine_SignalSend( qSM_t * const m,
                                         qSM_SigId_t sig,
                                         void *sData,
                                         const qBool_t isUrgent );

#define QSM_TSOPT_INDEX_MASK    ( 0x00FFFFFFuL )

#if ( Q_FSM_PS_SIGNALS_MAX > 0 )  && ( Q_FSM_PS_SUB_PER_SIGNAL_MAX > 0 )

typedef enum {
    QSM_PS_SIGNAL_NOT_FOUND,
    QSM_PS_SUBSCRIBER_NOT_FOUND,
    QSM_PS_SUBSCRIBER_FOUND,
    QSM_PS_SIGNAL_SLOTS_FULL,
    QSM_PS_SUBSCRIBER_SLOTS_FULL
} qSM_PS_ReqStatus_t;

typedef struct {
    qSM_PS_ReqStatus_t status;
    size_t sig_slot, sub_slot;
} qSM_PS_Index_t;

static void qStateMachine_UnsubscribeAll( void );
static qSM_PS_Index_t qStateMachine_GetSubscriptionStatus( const qSM_t * const m,
                                                           qSM_SigId_t s );

/*cstat -MISRAC2012-Rule-9.2 -MISRAC2012-Rule-9.3*/
static qSM_SigId_t psSignals[ Q_FSM_PS_SIGNALS_MAX ] = { 0xFFFFFFFFuL };
/*cstat +MISRAC2012-Rule-9.2 +MISRAC2012-Rule-9.3*/
static qSM_t *psSubs[ Q_FSM_PS_SIGNALS_MAX ][ Q_FSM_PS_SUB_PER_SIGNAL_MAX ];

/*============================================================================*/
static void qStateMachine_UnsubscribeAll( void )
{
    size_t i, j;

    for ( i = 0u ; i < (size_t)Q_FSM_PS_SIGNALS_MAX ; ++i ) {
        psSignals[ i ] = QSM_SIGNAL_NONE;
        for ( j = 0u; j < (size_t)Q_FSM_PS_SUB_PER_SIGNAL_MAX; ++j ) {
            psSubs[ i ][ j ] = NULL;
        }
    }
}
/*============================================================================*/
static qSM_PS_Index_t qStateMachine_GetSubscriptionStatus( const qSM_t * const m,
                                                           qSM_SigId_t s )
{
    qSM_PS_Index_t idx = { QSM_PS_SIGNAL_NOT_FOUND, 0u ,0u };
    size_t i, j = 0u;
    const size_t maxSig = (size_t)Q_FSM_PS_SIGNALS_MAX;
    const size_t maxSub = (size_t)Q_FSM_PS_SUB_PER_SIGNAL_MAX;
    /*cstat -MISRAC2012-Rule-15.4*/
    for ( i = 0u ; ( i < maxSig ) && ( QSM_SIGNAL_NONE != psSignals[ i ] ) ; ++i ) {
        if ( s == psSignals[ i ] ) {
            idx.status = QSM_PS_SUBSCRIBER_NOT_FOUND;
            for ( j = 0u ; ( j < maxSub ) && ( NULL != psSubs[ i ][ j ] ) ; ++j ) {
                if ( m == psSubs[ i ][ j ] ) {
                    idx.status = QSM_PS_SUBSCRIBER_FOUND;
                    break;
                }
            }
        }
        if ( QSM_PS_SIGNAL_NOT_FOUND != idx.status ) {
            break;
        }
    }
    /*cstat +MISRAC2012-Rule-15.4*/
    if ( i >= maxSig ) {
        idx.status = QSM_PS_SIGNAL_SLOTS_FULL;
    }
    if ( j >= maxSub ) {
        idx.status = QSM_PS_SUBSCRIBER_SLOTS_FULL;
    }

    idx.sig_slot = i;
    idx.sub_slot = j;
    return idx;
}
#endif /*( Q_FSM_PS_SIGNALS_MAX > 0 )  && ( Q_FSM_PS_SUB_PER_SIGNAL_MAX > 0 )*/
/*============================================================================*/
qBool_t qStateMachine_SubscribeToSignal( qSM_t * const m,
                                         qSM_SigId_t s )
{
    qBool_t retValue = qFalse;

    #if ( Q_FSM_PS_SIGNALS_MAX > 0 ) && ( Q_FSM_PS_SUB_PER_SIGNAL_MAX > 0 )
        if ( ( NULL != m ) && ( s < QSM_SIGNAL_RANGE_MAX ) ) {
            qSM_PS_Index_t r = qStateMachine_GetSubscriptionStatus( m, s );

            retValue = qTrue;
            switch ( r.status ) {
                case QSM_PS_SIGNAL_NOT_FOUND:
                    psSignals[ r.sig_slot ] = s;
                    psSubs[ r.sig_slot ][ r.sub_slot ] = m;
                    break;
                case QSM_PS_SUBSCRIBER_NOT_FOUND:
                    psSubs[ r.sig_slot ][ r.sub_slot ] = m;
                    break;
                case QSM_PS_SUBSCRIBER_FOUND:
                    break;
                default:
                    retValue = qFalse;
                    break;
            }
        }
    #else
        Q_UNUSED( m );
        Q_UNUSED( s );
    #endif /*( Q_FSM_PS_SIGNALS_MAX > 0 ) && ( Q_FSM_PS_SUB_PER_SIGNAL_MAX > 0 )*/
    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_UnsubscribeFromSignal( qSM_t * const m,
                                             qSM_SigId_t s )
{
    qBool_t retValue = qFalse;
    #if ( Q_FSM_PS_SIGNALS_MAX > 0 ) && ( Q_FSM_PS_SUB_PER_SIGNAL_MAX > 0 )
        if ( ( NULL != m ) && ( s < QSM_SIGNAL_RANGE_MAX ) ) {
            qSM_PS_Index_t r = qStateMachine_GetSubscriptionStatus( m, s );

            if ( QSM_PS_SUBSCRIBER_FOUND == r.status ) {
                size_t i, li = (size_t)Q_FSM_PS_SUB_PER_SIGNAL_MAX - 1u;

                for ( i = r.sub_slot ; i < li ; ++i ) {
                    psSubs[ r.sig_slot ][ i ] = psSubs[ r.sig_slot ][ i + 1u ];
                }
                psSubs[ r.sig_slot ][ li ] = NULL;

                if ( NULL == psSubs[ r.sig_slot ][ 0 ] ) { /*no subscribers left?*/
                    /*remove the signal from the psSignals list*/
                    li = (size_t)Q_FSM_PS_SIGNALS_MAX - 1u;
                    for ( i = r.sig_slot ; i < li ; ++i ) {
                        psSignals[ i ] = psSignals[ i + 1u ];
                    }
                    psSignals[ li ] = QSM_SIGNAL_NONE;
                }
                retValue = qTrue;
            }
        }
    #else
        Q_UNUSED( m );
        Q_UNUSED( s );
    #endif /*( Q_FSM_PS_SIGNALS_MAX > 0 ) && ( Q_FSM_PS_SUB_PER_SIGNAL_MAX > 0 )*/
    return retValue;
}
/*============================================================================*/
static void qStateMachine_Transition( qSM_t *m,
                                      qSM_State_t *target,
                                      const qSM_TransitionHistoryMode_t mHistory )
{
    /*
    When a transition its performed, all exit actions must precede any actions
    associated with the transition, which must precede any entry actions
    associated with the newly entered state(s). To discover which exit actions
    to execute, we first find the Least Common Ancestor (LCA) of the source and
    target states.
    */
    qStateMachine_ExitUpToLCA( m, qStateMachine_LevelsToLCA( m, target ) );
    /*then, handle the required history mode*/
    if ( qSM_TRANSITION_NO_HISTORY == mHistory ) {
        /*just restore the default transition*/
        target->qPrivate.lastRunningChild = target->qPrivate.initState;
    }
    else if ( qSM_TRANSITION_SHALLOW_HISTORY == mHistory ) {
        if ( NULL != target->qPrivate.lastRunningChild ) {
            qSM_State_t * lrc = target->qPrivate.lastRunningChild;
            /*restore the default transition in the last running nested state*/
            lrc->qPrivate.lastRunningChild = lrc->qPrivate.initState;
        }
    }
    else {
        /*
        nothing to do : qSM_TRANSITION_DEEP_HISTORY handled by default all deep
        history its preserved in the "lastRunningChild" attribute, so there is
        no need to change it. qStateMachine_StateOnStart will assign this by
        default.
        */
    }
    m->qPrivate.next = target; /*notify SM that there was indeed a transition*/
}
/*============================================================================*/
static qSM_LCA_t qStateMachine_LevelsToLCA( qSM_t * const m,
                                            qSM_State_t * const target )
{
    qSM_LCA_t xLca = 0u;

    /*
    To discover which exit actions to execute, it is necessary to find the
    LCA(LeastCommon Ancestor) of the source and target states.
    */
    if ( m->qPrivate.source == target ) {
        xLca = 1u; /*recursive transition, only a level needs to be performed*/
    }
    else {
        qSM_State_t *s, *t;
        qBool_t xBreak = qFalse; /*to be in compliance with MISRAC2012-Rule-15.5*/
        qSM_LCA_t n = 0u;

        for ( s = m->qPrivate.source ;
             ( NULL != s ) && ( qFalse == xBreak ) ;
             s = s->qPrivate.parent ) {
            for ( t = target ; NULL != t ; t = t->qPrivate.parent ) {
                if ( s == t ) {
                    xLca = n;
                    xBreak = qTrue;
                    break;
                }
            }
            ++n;
        }
    }

    return xLca; /*return # of levels from the current state to the LCA.*/
}
/*============================================================================*/
static void qStateMachine_ExitUpToLCA( qSM_t * const m,
                                       qSM_LCA_t lca )
{
    qSM_State_t *s = m->qPrivate.current;

    /*exit current states*/
    while ( s != m->qPrivate.source ) {
        s = qStateMachine_StateOnExit( m, s );
    }
    /*exit all superstates up to LCA*/
    while ( 0u != lca-- ) {
        s = qStateMachine_StateOnExit( m, s );
    }
    m->qPrivate.current = s;
}
/*============================================================================*/
static void qStateMachine_PrepareHandler( qSM_UnprotectedHandler_t h,
                                          const qSM_Signal_t sig,
                                          qSM_State_t * const s )
{
    h->Signal = sig.id;
    h->SignalData = sig.sigData;
    h->NextState = NULL;
    h->StartState = NULL;
    h->Status = qSM_STATUS_NULL;
    h->TransitionHistory = qSM_TRANSITION_NO_HISTORY;
    h->StateData = s->qPrivate.sData;
    h->state = s;
}
/*============================================================================*/
static qSM_Status_t qStateMachine_InvokeStateCallback( qSM_t *m,
                                                       qSM_State_t * const s,
                                                       qSM_UnprotectedHandler_t h )
{
    if ( NULL != m->qPrivate.surrounding ) {
        h->Status = qSM_STATUS_BEFORE_ANY;
        /*cstat -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
        m->qPrivate.surrounding( (qSM_Handler_t)h ); /*cast allowed, struct layout its compatible*/
        /*cstat +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
    }
    if ( NULL != s->qPrivate.sCallback ) {
        h->Status = qSM_STATUS_NULL;
        /*cstat -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
        /*execute the state callback (Transitions here are not allowed)*/
        h->Status = s->qPrivate.sCallback( (qSM_Handler_t)h ); /*cast allowed, struct layout its compatible*/
        /*cstat +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
    }
    else {
        h->Status = qSM_STATUS_EXIT_FAILURE;
    }
    /*this property can change from the callback, so check it again*/
    if ( NULL != m->qPrivate.surrounding ) {
        if ( h->Status < qSM_STATUS_EXIT_FAILURE ) {
            h->Status = qSM_STATUS_EXIT_FAILURE;
        }
        /*cstat -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
        m->qPrivate.surrounding( (qSM_Handler_t)h ); /*cast allowed, struct layout compatible*/
        /*cstat +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
    }

    return h->Status;
}
/*============================================================================*/
static qSM_State_t* qStateMachine_StateOnExit( qSM_t * const m,
                                               qSM_State_t * const s )
{
    static qSM_Signal_t qSM_SIG_MSG_EXIT = { QSM_SIGNAL_EXIT, NULL };
    qSM_UnprotectedHandler_t h = &m->qPrivate.handler;

    qStateMachine_PrepareHandler( h, qSM_SIG_MSG_EXIT, s );
    (void)qStateMachine_InvokeStateCallback( m, s, h );

    if ( ( NULL != m->qPrivate.timeSpec ) && ( NULL != s->qPrivate.tdef ) ) {
        qStateMachine_TimeoutPerformSpecifiedActions( m, s, QSM_SIGNAL_EXIT );
    }
    s->qPrivate.parent->qPrivate.lastRunningChild = s;

    return s->qPrivate.parent;
}
/*============================================================================*/
static void qStateMachine_StateOnEntry( qSM_t * const m,
                                        qSM_State_t * const s )
{
    static qSM_Signal_t qSM_SIG_MSG_ENTRY = { QSM_SIGNAL_ENTRY, NULL };
    qSM_UnprotectedHandler_t h = &m->qPrivate.handler;

    qStateMachine_PrepareHandler( h, qSM_SIG_MSG_ENTRY, s );
    (void)qStateMachine_InvokeStateCallback( m, s, h );

    if ( ( NULL != m->qPrivate.timeSpec ) && ( NULL != s->qPrivate.tdef ) ) {
        qStateMachine_TimeoutPerformSpecifiedActions( m, s, QSM_SIGNAL_ENTRY );
    }
}
/*============================================================================*/
static qSM_State_t* qStateMachine_StateOnStart( qSM_t * const m,
                                                qSM_State_t * const s )
{
    static qSM_Signal_t qSM_SIG_MSG_START = { QSM_SIGNAL_START, NULL };
    qSM_UnprotectedHandler_t h = &m->qPrivate.handler;

    qStateMachine_PrepareHandler( h, qSM_SIG_MSG_START, s );
    (void)qStateMachine_InvokeStateCallback( m, s, h );

    if ( NULL != h->StartState ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /*changes from callback takes more precedence*/
        m->qPrivate.next = (qSM_State_t*)h->StartState;
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    }
    else {
        if ( NULL != s->qPrivate.lastRunningChild ) {
            /*try to preserve history*/
            m->qPrivate.next = s->qPrivate.lastRunningChild;
        }
    }

    return m->qPrivate.next;
}
/*============================================================================*/
static qSM_Status_t qStateMachine_StateOnSignal( qSM_t * const m,
                                                 qSM_State_t * const s,
                                                 const qSM_Signal_t sig )
{
    qSM_UnprotectedHandler_t h = &m->qPrivate.handler;
    qSM_Status_t status;

    qStateMachine_PrepareHandler( h, sig, s );
    if ( NULL != s->qPrivate.tTable ) {
        /*evaluate the transition table if available*/
        qStateMachine_SweepTransitionTable( s, h );
    }
    status = qStateMachine_InvokeStateCallback( m, s, h );

    if ( NULL != h->NextState ) { /*perform the transition if available*/
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qStateMachine_Transition( m,
                                  (qSM_State_t*)h->NextState,
                                  h->TransitionHistory );
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        /*the signal is assumed to be handled if the transition occurs*/
        status = qSM_STATUS_SIGNAL_HANDLED;
    }

    return status;
}
/*============================================================================*/
static void qStateMachine_TracePathAndRetraceEntry( qSM_t * const m,
                                                    qSM_State_t **trace )
{
    qSM_State_t *s;

    /*
    Entry actions must be executed in order form the least deeply nested to the
    most deeply nested state. This is opposite to the normal navigability of the
    module data-structure design. So this is solved by first recording the entry
    path from the LCA to the target, then playing it backwards. with execution
    of entry actions.
    qStateMachine_TracePathAndRetraceEntry and qStateMachine_TraceOnStart are
    used to handle this after the transition perform all the required exit
    actions.
    */
    *trace = NULL;
    for ( s = m->qPrivate.next ; s != m->qPrivate.current ; s = s->qPrivate.parent ) {
        *(++trace) = s; /* trace path to target */
    }
    while ( NULL != ( s = *trace-- ) ) { /* retrace entry from LCA */
        qStateMachine_StateOnEntry( m, s );
    }
    m->qPrivate.current = m->qPrivate.next;
    m->qPrivate.next = NULL;
}
/*============================================================================*/
static void qStateMachine_TraceOnStart( qSM_t * const m,
                                        qSM_State_t **entryPath )
{
    while ( NULL != qStateMachine_StateOnStart( m, m->qPrivate.current ) ) {
        qStateMachine_TracePathAndRetraceEntry( m, entryPath );
    }
}
/*============================================================================*/
static qSM_Signal_t qStateMachine_CheckForSignals( qSM_t * const m,
                                                      const qSM_Signal_t sig )
{
    qSM_Signal_t xSignal = sig;

    /*
    initially checks for time signals if the state machine has a
    timeout-specification object installed. If any timeout expires, the signal
    is put on the available recipient.
    */
    if ( NULL != m->qPrivate.timeSpec ) {
        qStateMachine_TimeoutCheckSignals( m );
        /*use the available recipient: signal-queue or the EV*/
    }
    /*
    If the state machine has the signal-queue installed, the signal that is in
    front of the queue is obtained. In case of there is no signal-queue or the
    queue its empty, the input argument and the exclusion variable are verified.
    */
    #if ( Q_QUEUES == 1 )
        if ( NULL != m->qPrivate.sQueue ) {
            qSM_Signal_t receivedSignal;

            if ( qTrue == qQueue_Receive( m->qPrivate.sQueue, &receivedSignal ) ) {
                xSignal = receivedSignal;
            }
        }
    #endif
    /*A signal coming from the signal-queue has the higher precedence.*/
    if ( ( QSM_SIGNAL_NONE == xSignal.id ) && ( QSM_SIGNAL_NONE != m->qPrivate.signalNot.id ) ) {
        xSignal = m->qPrivate.signalNot; /*exclusion variable*/
        m->qPrivate.signalNot.id = QSM_SIGNAL_NONE;
        m->qPrivate.signalNot.sigData = NULL;
    }

    return xSignal;
}
/*============================================================================*/
qBool_t qStateMachine_Run( qSM_t * const m,
                           qSM_Signal_t sig )
{
    qBool_t retValue = qFalse;

    if ( NULL != m ) {
        qSM_State_t *entryPath[ Q_FSM_MAX_NEST_DEPTH ];
        qSM_State_t *s;

        sig = qStateMachine_CheckForSignals( m, sig );

        /*Enter here only once to start the top state*/
        if ( NULL == m->qPrivate.current ) {
            m->qPrivate.current = &m->qPrivate.top;
            m->qPrivate.next = NULL;
            qStateMachine_StateOnEntry( m, m->qPrivate.current );
            qStateMachine_TraceOnStart( m, entryPath );
        }
        /*evaluate the hierarchy until the signal is handled*/
        for ( s = m->qPrivate.current ; NULL != s ; s = s->qPrivate.parent ) {
            m->qPrivate.source = s; /* level of outermost event handler */
            if ( qSM_STATUS_SIGNAL_HANDLED == qStateMachine_StateOnSignal( m, s, sig ) ) {
                if ( NULL != m->qPrivate.next ) {  /* state transition taken? */
                    /*
                     execute entry/start actions in the rest of the hierarchy
                     after transition
                     */
                    qStateMachine_TracePathAndRetraceEntry( m, entryPath );
                    qStateMachine_TraceOnStart( m, entryPath );
                }
                retValue = qTrue;
                break;/* signal processed */
            }
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_Setup( qSM_t * const m,
                             qSM_StateCallback_t topFcn,
                             qSM_State_t * const init,
                             qSM_SurroundingCallback_t sFcn,
                             void *pData )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != m ) ) {
        (void)memset( m, 0, sizeof( qSM_t ) );
        m->qPrivate.current = NULL;
        m->qPrivate.next = NULL;
        m->qPrivate.source = NULL;
        m->qPrivate.mData = pData;
        m->qPrivate.surrounding = sFcn;
        m->qPrivate.handler.machine = m;
        m->qPrivate.handler.Data = pData;
        #if ( Q_QUEUES == 1 )
            m->qPrivate.sQueue = NULL;
        #endif
        m->qPrivate.timeSpec = NULL;
        /*subscribe the built-in top state*/
        retValue = qStateMachine_StateSubscribe( m,
                                                 &m->qPrivate.top,
                                                 NULL,
                                                 topFcn,
                                                 init,
                                                 NULL );
        m->qPrivate.top.qPrivate.parent = NULL;
        #if ( Q_FSM_PS_SIGNALS_MAX > 0 )  && ( Q_FSM_PS_SUB_PER_SIGNAL_MAX > 0 )
        if ( psSignals[ 0 ] > QSM_SIGNAL_NONE ) {
            qStateMachine_UnsubscribeAll( );
        }
        #endif
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_StateSubscribe( qSM_t * const m,
                                      qSM_State_t * const s,
                                      qSM_State_t * const parent,
                                      qSM_StateCallback_t sFcn,
                                      qSM_State_t * const init,
                                      void *pData )
{
    qBool_t retValue = qFalse;

    if ( NULL != s ) {
        (void)memset( s, 0, sizeof(qSM_State_t) );
        s->qPrivate.sData = pData;
        s->qPrivate.lastRunningChild = init;
        s->qPrivate.initState = init;
        s->qPrivate.sCallback = sFcn;
        s->qPrivate.parent = ( NULL == parent )? &m->qPrivate.top : parent;
        s->qPrivate.tTable = NULL;
        s->qPrivate.tEntries = (size_t)0u;
        s->qPrivate.tdef = NULL;
        s->qPrivate.nTm = (size_t)0u;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_Set_StateTransitions( qSM_State_t * const s,
                                            qSM_Transition_t * const table,
                                            const size_t n )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != s ) && ( NULL != table ) && ( n > 0u ) ) {
        s->qPrivate.tTable = table;
        s->qPrivate.tEntries = n;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_InstallSignalQueue( qSM_t * const m,
                                          qQueue_t *q )
{
    qBool_t retValue = qFalse;
    #if ( Q_QUEUES == 1 )
        if ( ( NULL != m ) && ( NULL != q ) ) {
            if ( ( qTrue == qQueue_IsReady( q ) ) && ( sizeof(qSM_Signal_t) == q->qPrivate.itemSize ) ) {
                m->qPrivate.sQueue = q; /*install the queue*/
                retValue = qTrue;
            }
        }
    #else
        Q_UNUSED( m );
        Q_UNUSED( q );
    #endif

    return retValue;
}
/*============================================================================*/
static void qStateMachine_SweepTransitionTable( qSM_State_t * const currentState,
                                                qSM_UnprotectedHandler_t h )
{
    size_t i, n;
    const qSM_Transition_t *iTransition;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    const qSM_Transition_t *table = (qSM_Transition_t *)currentState->qPrivate.tTable;
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    n = currentState->qPrivate.tEntries;
    for ( i = 0u ; i < n ; ++i ) {
        qBool_t transitionAllowed = qTrue; /*allow the transition by default*/

        iTransition = &table[ i ]; /*get the i-element from the table*/
        if ( ( h->Signal >= QSM_SIGNAL_TM_RMIN ) && ( h->Signal <= QSM_SIGNAL_TM_RMAX ) ) {
            h->SignalData = NULL; /*ignore signal data on timeout signals*/
        }
        if ( ( h->Signal == iTransition->xSignal ) && ( h->SignalData == iTransition->signalData ) ) { /*table entry match*/
            if ( NULL != iTransition->guard ) {
                /*cstat -MISRAC2012-Rule-11.3 -CERT-EXP39-C_d*/
                /*if signal-guard available, run the guard function*/
                transitionAllowed = iTransition->guard( (qSM_Handler_t)h ); /*cast allowed, struct layout compatible*/
                /*cstat +MISRAC2012-Rule-11.3 +CERT-EXP39-C_d*/
            }
            if ( qTrue == transitionAllowed ) {
                if ( NULL != iTransition->nextState ) {
                    /*if target state available, set the transition from table*/
                    h->NextState = iTransition->nextState;
                    /*set the history mode form the table*/
                    h->TransitionHistory = iTransition->historyMode;
                    break;
                }
            }
        }
    }
}
/*============================================================================*/
static qBool_t qStateMachine_SignalSend( qSM_t * const m,
                                         qSM_SigId_t sig,
                                         void *sData,
                                         const qBool_t isUrgent )
{
    qBool_t retValue = qFalse;
    #if ( Q_QUEUES == 1 )
        /*check if the state-machine has a signal queue*/
        if ( NULL != m->qPrivate.sQueue ) {
            qSM_Signal_t sig_msg = { sig, sData };

            retValue = qQueue_Send( m->qPrivate.sQueue,
                                    &sig_msg,
                                    (qQueue_InsertMode_t)isUrgent );
        }
    #else
        Q_UNUSED( isUrgent );
    #endif

    if ( ( qFalse == retValue ) && ( QSM_SIGNAL_NONE == m->qPrivate.signalNot.id ) ) {
        m->qPrivate.signalNot.id = sig;
        m->qPrivate.signalNot.sigData = sData;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_SendSignal( qSM_t * const m,
                                  qSM_SigId_t sig,
                                  void *sData,
                                  const qBool_t isUrgent )
{
    qBool_t retValue = qFalse;

    if ( sig < QSM_SIGNAL_NONE ) {
        if ( NULL != m ) {
            retValue = qStateMachine_SignalSend( m, sig, sData, isUrgent );
        }
        #if ( Q_FSM_PS_SIGNALS_MAX > 0 )  && ( Q_FSM_PS_SUB_PER_SIGNAL_MAX > 0 )
            else {
                size_t i, j;
                const size_t maxSig = (size_t)Q_FSM_PS_SIGNALS_MAX;
                const size_t maxSub = (size_t)Q_FSM_PS_SUB_PER_SIGNAL_MAX;

                for ( i = 0u ; ( i < maxSig ) && ( QSM_SIGNAL_NONE != psSignals[ i ] ) ; ++i ) {
                    if ( sig == psSignals[ i ] ) {
                        retValue = qTrue;
                        for ( j = 0u ; ( j < maxSub ) && ( NULL != psSubs[ i ][ j ] ) ; ++j ) {
                            /*cstat -MISRAC2012-Rule-10.1_R3 -CERT-EXP46-C*/
                            retValue &= qStateMachine_SignalSend( psSubs[ i ][ j ], sig, sData, isUrgent );
                            /*cstat +MISRAC2012-Rule-10.1_R3 +CERT-EXP46-C*/
                        }
                        break;
                    }
                }
            }
        #endif
    }

    return retValue;
}
/*============================================================================*/
static void qStateMachine_TimeoutCheckSignals( qSM_t * const m )
{
    qSM_TimeoutSpec_t *ts = m->qPrivate.timeSpec;
    size_t i;

    for ( i = 0u ; i < (size_t)Q_FSM_MAX_TIMEOUTS ; ++i ) {
        if ( qTrue == qSTimer_Expired( &ts->builtin_timeout[ i ] ) ) {
            #if ( Q_QUEUES == 1 )
                (void)qStateMachine_SendSignal( m, QSM_SIGNAL_TIMEOUT( i ), NULL, qFalse );
            #endif
            if ( 0uL  != ( ts->isPeriodic & ( 1uL <<  i ) ) ) {
                (void)qSTimer_Reload( &ts->builtin_timeout[ i ] );
            }
            else {
                (void)qSTimer_Disarm( &ts->builtin_timeout[ i ] );
            }
        }
    }
}
/*============================================================================*/
static void qStateMachine_TimeoutPerformSpecifiedActions( qSM_t * const m,
                                                          qSM_State_t *current,
                                                          const qSM_SigId_t sig )
{
    qSM_TimeoutStateDefinition_t *tbl = current->qPrivate.tdef;
    size_t n = current->qPrivate.nTm;

    if ( ( n > 0u ) && ( NULL != tbl ) ) {
        size_t i;
        qSM_TimeoutSpecOptions_t setCheck, resetCheck;

        if ( QSM_SIGNAL_ENTRY == sig ) {
            setCheck = QSM_TSOPT_SET_ENTRY;
            resetCheck = QSM_TSOPT_RST_ENTRY;
        }
        else {
            setCheck = QSM_TSOPT_SET_EXIT;
            resetCheck = QSM_TSOPT_RST_EXIT;
        }
        for ( i = 0u ; i < n ; ++i ) { /*loop table */
            qSM_TimeoutSpecOptions_t opt = tbl[ i ].options;
            qIndex_t index = (qIndex_t)( opt & QSM_TSOPT_INDEX_MASK );
            /*state match and index is valid?*/
            if ( index < (qIndex_t)Q_FSM_MAX_TIMEOUTS ) {
                qSTimer_t *tmr = &m->qPrivate.timeSpec->builtin_timeout[ index ];
                qTime_t tValue = tbl[ i ].xTimeout;

                if ( 0uL != ( opt & setCheck ) ) {
                    if ( 0uL == ( opt & QSM_TSOPT_KEEP_IF_SET ) ) {
                        (void)qSTimer_Set( tmr, tValue );
                    }
                    if ( 0uL != ( opt & QSM_TSOPT_PERIODIC ) ) {
                        qFLM_BitSet( m->qPrivate.timeSpec->isPeriodic,
                                     index,
                                     qUINT32_t );
                    }
                    else {
                        qFLM_BitClear( m->qPrivate.timeSpec->isPeriodic,
                                       index,
                                       qUINT32_t );
                    }
                }
                if ( 0uL != ( opt & resetCheck ) ) {
                    (void)qSTimer_Disarm( tmr );
                }
            }
        }
    }
}
/*============================================================================*/
qBool_t qStateMachine_InstallTimeoutSpec( qSM_t * const m,
                                          qSM_TimeoutSpec_t * const ts )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != m ) && ( NULL != ts ) ) {
        size_t i;

        (void)memset( ts, 0, sizeof(qSM_TimeoutSpec_t) );
        m->qPrivate.timeSpec = ts;
        for ( i = 0u ; i < (size_t)Q_FSM_MAX_TIMEOUTS ; ++i ) {
            (void)qSTimer_Disarm( &m->qPrivate.timeSpec->builtin_timeout[ i ] );
        }
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_Set_StateTimeouts( qSM_State_t * const s,
                                         qSM_TimeoutStateDefinition_t *tdef,
                                         const size_t n )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != s ) && ( NULL != tdef ) && ( n > (size_t)0uL ) ) {
        s->qPrivate.tdef = tdef;
        s->qPrivate.nTm= n;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_TimeoutSet( qSM_t * const m,
                                  const qIndex_t xTimeout,
                                  const qTime_t t )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != m ) && ( xTimeout <= (qIndex_t)Q_FSM_MAX_TIMEOUTS ) ) {
        if ( NULL != m->qPrivate.timeSpec ) {
            retValue = qSTimer_Set( &m->qPrivate.timeSpec->builtin_timeout[ xTimeout ], t );
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_TimeoutStop( qSM_t * const m,
                                   const qIndex_t xTimeout )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != m->qPrivate.timeSpec ) && ( xTimeout < (qIndex_t)Q_FSM_MAX_TIMEOUTS ) ) {
        #if ( Q_QUEUES == 1 )
            size_t cnt;
            qSM_Signal_t xSignal;

            cnt = qQueue_Count( m->qPrivate.sQueue );
            while ( 0u != cnt-- ) {
                if ( qTrue == qQueue_Receive( m->qPrivate.sQueue, &xSignal ) ) {
                    if ( xSignal.id != QSM_SIGNAL_TIMEOUT( xTimeout ) ) {
                        /*keep non-timeout signals*/
                        (void)qQueue_Send( m->qPrivate.sQueue,
                                           &xSignal,
                                           QUEUE_SEND_TO_BACK );
                    }
                }
            }
        #endif
        retValue = qSTimer_Disarm( &m->qPrivate.timeSpec->builtin_timeout[ xTimeout ] );
    }

    return retValue;
}
/*============================================================================*/
void* qStateMachine_Get_Machine( qSM_t * const m,
                                 const qSM_Attribute_t a )
{
    void *xAttribute = NULL;

    if ( NULL != m ) {
        switch ( a ) {
            case qSM_ATTRIB_STATE_TOP:
                xAttribute = &m->qPrivate.top;
                break;
            case qSM_ATTRIB_STATE_CURRENT:
                xAttribute = m->qPrivate.current;
                break;
            #if ( Q_QUEUES == 1 )
            case qSM_ATTRIB_SIGNAL_QUEUE:
                xAttribute = m->qPrivate.sQueue;
                break;
            #endif
            case qSM_ATTRIB_TIMESPEC:
                xAttribute = m->qPrivate.timeSpec;
                break;
            case qSM_ATTRIB_DATA:
                xAttribute = m->qPrivate.mData;
                break;
            default:
                break;
        }
    }

    return xAttribute;
}
/*============================================================================*/
void* qStateMachine_Get_State( qSM_State_t * const s,
                               const qSM_Attribute_t a )
{
    void *xAttribute = NULL;

    if ( NULL != s ) {
        switch ( a ) {
            case qSM_ATTRIB_COMPOSITE_INITSTATE:
                xAttribute = s->qPrivate.initState;
                break;
            case qSM_ATTRIB_COMPOSITE_LASTSTATE:
                xAttribute = s->qPrivate.lastRunningChild;
                break;
            case qSM_ATTRIB_COMPOSITE_PARENT:
                xAttribute = s->qPrivate.parent;
                break;
            case qSM_ATTRIB_DATA:
                xAttribute = s->qPrivate.sData;
                break;
            case qSM_ATTRIB_TRANSITION_TABLE:
                xAttribute = s->qPrivate.tTable;
                break;
            default:
                break;
        }
    }

    return xAttribute;
}
/*============================================================================*/
qBool_t qStateMachine_Set_StateCallback( qSM_State_t * const state,
                                         qSM_StateCallback_t sFcn )
{
    qBool_t retValue = qFalse;

    if ( NULL != state ) {
        state->qPrivate.sCallback = sFcn;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qStateMachine_Set_MachineSurrounding( qSM_t * const m,
                                              qSM_SurroundingCallback_t sFcn )
{
    qBool_t retValue = qFalse;

    if ( NULL != m ) {
        m->qPrivate.surrounding = sFcn;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/

#endif /*#if ( Q_FSM == 1 )*/
