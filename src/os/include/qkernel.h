/*This file is part of the QuarkTS distribution.*/
#ifndef QKERNEL_H
    #define QKERNEL_H

    #include "qtypes.h"
    #include "qcritical.h"
    #include "qtasks.h"
   
    #ifdef __cplusplus
    extern "C" {
    #endif

    /*Default priority levels*/
    #define qLowest_Priority        ( (qPriority_t)( 0u ) )
    #define qMedium_Priority        ( (qPriority_t)( Q_PRIORITY_LEVELS >> 1 ) )
    #define qHigh_Priority          ( (qPriority_t)( Q_PRIORITY_LEVELS - 1u ) )

    #define qPeriodic               ( (qIteration_t)(-2147483648) )
    #define qIndefinite             ( qPeriodic )
    #define qSingleShot             ( (qIteration_t)(1) )

    typedef enum{
        qUndefinedGlobalState,
        qReady,
        qWaiting,
        qSuspended,
        qRunning
    }qStateGlobal_t;

    typedef qBool_t (*qTaskNotifyMode_t)(qTask_t* arg1, void* arg2);

    #if (Q_SETUP_TIME_CANONICAL == 1)
        void qSchedulerSetup( const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback );
    #else
        void qSchedulerSetup( const qGetTickFcn_t TickProvider, const qTimingBase_type BaseTimming, qTaskFcn_t IdleCallback );
    #endif

    qTask_t* _qScheduler_GetTaskRunning( void );
    void qSchedulerSetIdleTask( qTaskFcn_t Callback );

    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        void qSchedulerRelease( void );
        void qSchedulerSetReleaseCallback( qTaskFcn_t Callback );
    #endif       

    qBool_t qSchedulerSpreadNotification( void *eventdata, const qTaskNotifyMode_t mode );
    qBool_t qSchedulerAdd_Task( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg );
    qBool_t qSchedulerAdd_EventTask( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg );
    #if ( Q_FSM == 1)
        qBool_t qSchedulerAdd_StateMachineTask( qTask_t * const Task, qPriority_t Priority, qTime_t Time,
                            qSM_t * const StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg );
        qBool_t qScheduler_StateMachineTask_SignalConnect( qTask_t * const Task );                    
    #endif

    #if ( Q_ATCOMMAND_PARSER == 1)
        qBool_t qSchedulerAdd_ATParserTask( qTask_t * const Task, qATParser_t *Parser, qPriority_t Priority );
    #endif

    qBool_t qSchedulerRemoveTask( qTask_t * const Task );
    void qSchedulerRun( void );
    #if ( Q_PRIO_QUEUE_SIZE > 0 )  
        qBool_t _qScheduler_PriorityQueue_Insert(qTask_t * const Task, void *data);
        qBool_t _qScheduler_PriorityQueue_IsTaskInside( const qTask_t * const Task );
        size_t qOS_Get_PriorityQueueCount( void );
    #endif

    void __qFSMCallbackMode( qEvent_t e );

    qStateGlobal_t qScheduler_GetTaskGlobalState( const qTask_t * const Task);

    #ifdef __cplusplus
    }
    #endif

#endif /*QKERNEL_H*/