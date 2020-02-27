/*This file is part of the QuarkTS distribution.*/
#ifndef QKERNEL_H
    #define QKERNEL_H

    #include "qtypes.h"
    #include "qcritical.h"
    #include "qtasks.h"

    #if ( Q_ATCLI == 1)
        #include "qatcli.h"
    #endif
   
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

    typedef struct{
        #if ( Q_PRIO_QUEUE_SIZE > 0 ) 
            qBool_t (*PriorityQueue_Insert)(qTask_t * const Task, void *data);
            qBool_t (*PriorityQueue_IsTaskInside)( const qTask_t * const Task );
            size_t (*PriorityQueue_GetCount)( void );
        #endif
        void (*DummyTask_Callback)( qEvent_t e);
        qTask_GlobalState_t (*Get_TaskGlobalState)( const qTask_t * const Task);
        qTask_t* (*Get_TaskRunning)( void );
    }_qOS_PrivateMethodsContainer_t;
    extern _qOS_PrivateMethodsContainer_t _qOS_PrivateMethods;

    typedef qBool_t (*qTask_NotifyMode_t)(qTask_t * const arg1, void* arg2);

    #if (Q_SETUP_TIME_CANONICAL == 1)
        void qOS_Setup( const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback );
    #else
        void qOS_Setup( const qGetTickFcn_t TickProvider, const qTimingBase_t BaseTimming, qTaskFcn_t IdleCallback );
    #endif

    void qOS_Set_IdleTask( qTaskFcn_t Callback );

    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        void qOS_Scheduler_Release( void );
        void qOS_Set_SchedulerReleaseCallback( qTaskFcn_t Callback );
    #endif       

    qBool_t qOS_Notification_Spread( void *eventdata, const qTask_NotifyMode_t mode );
    qBool_t qOS_Add_Task( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg );
    qBool_t qOS_Add_EventTask( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg );
    #if ( Q_FSM == 1)
        qBool_t qOS_Add_StateMachineTask( qTask_t * const Task, qPriority_t Priority, qTime_t Time,
                            qSM_t * const StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg );
        qBool_t qOS_StateMachineTask_SigCon( qTask_t * const Task );                    
    #endif

    #if ( Q_ATCLI == 1)
        qBool_t qOS_Add_ATCLITask( qTask_t * const Task, qATCLI_t *cli, qPriority_t Priority );
    #endif

    qBool_t qOS_Remove_Task( qTask_t * const Task );
    void qOS_Run( void );
    
    #ifdef __cplusplus
    }
    #endif

#endif /*QKERNEL_H*/
