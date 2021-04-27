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

    #ifndef Q_PRIORITY_LEVELS
        #define Q_PRIORITY_LEVELS           ( 3 )
    #endif
    
    #ifndef Q_SETUP_TIME_CANONICAL
        #define Q_SETUP_TIME_CANONICAL      ( 0 )
    #endif
    
    #ifndef Q_SETUP_TICK_IN_HERTZ
        #define Q_SETUP_TICK_IN_HERTZ       ( 0 )
    #endif
    
    #ifndef Q_PRIO_QUEUE_SIZE
        #define Q_PRIO_QUEUE_SIZE           ( 3 )
    #endif

    #ifndef Q_PRIO_QUEUE_SIZE
        #define Q_PRIO_QUEUE_SIZE           ( 3 )
    #endif

    #ifndef Q_PRESERVE_TASK_ENTRY_ORDER
        #define Q_PRIO_QUEUE_SIZE           ( 0 )
    #endif

    #ifndef Q_NOTIFICATION_SPREADER
        #define Q_NOTIFICATION_SPREADER     ( 1 )
    #endif

    #ifndef Q_ALLOW_SCHEDULER_RELEASE
        #define Q_ALLOW_SCHEDULER_RELEASE   ( 1 )
    #endif

    #if ( Q_PRIORITY_LEVELS < 1 )
        #error Q_PRIORITY_LEVELS must be defined to be greater than or equal to 1.
    #endif    


    /*Default priority levels*/
    #define qLowest_Priority        ( (qPriority_t)( 0u ) )
    #define qMedium_Priority        ( (qPriority_t)( Q_PRIORITY_LEVELS >> 1 ) )
    #define qHigh_Priority          ( (qPriority_t)( Q_PRIORITY_LEVELS - 1u ) )

    #define qPeriodic               ( (qIteration_t)(-2147483648) )
    #define qIndefinite             ( qPeriodic )
    #define qSingleShot             ( (qIteration_t)(1) )

    /*a single container is used to publish the private methods outside the kernel*/
    /* Please don't access any members of this structure directly */

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
        qBool_t qOS_Add_StateMachineTask( qTask_t * const Task, qSM_t *m, qPriority_t Priority, qTime_t Time, qState_t InitialTaskState, void *arg );                  
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
