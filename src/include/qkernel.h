/*This file is part of the QuarkTS distribution.*/
#ifndef QKERNEL_H
    #define QKERNEL_H

    #include "qtypes.h"
    #include "qcritical.h"
    #include "qtasks.h"
   
    #ifdef __cplusplus
    extern "C" {
    #endif

    #define qLowest_Priority        ((qPriority_t)(0x00u))
    #define qMedium_Priority        ((qPriority_t)(0x7Fu))
    #define qHigh_Priority          ((qPriority_t)(0xFEu))
    #define qPeriodic               ((qIteration_t)(-32768))
    #define qIndefinite             ( qPeriodic )
    #define qSingleShot             ((qIteration_t)(1))

    #define LOWEST_Priority         ( qLowest_Priority )
    #define MEDIUM_Priority         ( qMedium_Priority )
    #define HIGH_Priority           ( qHigh_Priority )

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

    typedef qBool_t (*qTaskNotifyMode_t)(qTask_t* arg1, void* arg2);

    qBool_t qSchedulerSpreadNotification( void *eventdata, const qTaskNotifyMode_t mode );
    qBool_t qSchedulerAdd_Task( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg );
    qBool_t qSchedulerAdd_EventTask( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg );
    #if ( Q_FSM == 1)
        qBool_t qSchedulerAdd_StateMachineTask( qTask_t * const Task, qPriority_t Priority, qTime_t Time,
                            qSM_t * const StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg );
    #endif

    #if ( Q_ATCOMMAND_PARSER == 1)
        qBool_t qSchedulerAdd_ATParserTask( qTask_t * const Task, qATParser_t *Parser, qPriority_t Priority );
    #endif

    qBool_t qSchedulerRemoveTask( qTask_t * const Task );
    void qSchedulerRun( void );

    /*void qSchedulerSetup(qGetTickFcn_t TickProviderFcn,  qTime_t ISRTick, qTaskFcn_t IDLE_Callback, unsigned char QueueSize)
        
    Task Scheduler Setup. This function is required and must be called once in 
    the application main thread before any tasks creation.

    Parameters:

        - TickProviderFcn :  The function that provides the tick value. If the user application 
                            uses the qClock_SysTick() from the ISR, this parameter can be NULL.
                            Note: Function should take void and return a 32bit value. 

        - TimmingBase : This parameter specifies the ISR background timer base time.
                        This can be the period in seconds(Floating-point format) or frequency 
                        in Herzt(Only if Q_SETUP_TICK_IN_HERTZ is enabled).

        - IDLE_Callback : Callback function to the Idle Task. To disable the 
                        Idle Task functionality, pass NULL as argument.

        */
    qBool_t _qScheduler_PQueueInsert(qTask_t * const Task, void *data);
    void _qScheduler_ReloadScheme(void);

    #define __qFSMCallbackMode      ((qTaskFcn_t)1)

    #ifdef __cplusplus
    }
    #endif

#endif /*QKERNEL_H*/