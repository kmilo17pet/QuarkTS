/*!
 * @file qkernel.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qkernel.h"
#include "qkshared.h" /*kernel shared methods*/
#include "qtrace.h"
#include "qflm.h"

#define QKERNEL_BIT_INIT                        ( 0x00000001uL )
#define QKERNEL_BIT_FCALLIDLE                   ( 0x00000002uL )
#define QKERNEL_BIT_RELEASESCHED                ( 0x00000004uL )
#define QKERNEL_BIT_FCALLRELEASED               ( 0x00000008uL )
#define QKERNEL_COREFLAG_SET( FLAG, BIT )       ( FLAG ) |= (qCoreFlags_t)(  BIT )
#define QKERNEL_COREFLAG_CLEAR( FLAG, BIT )     ( FLAG ) &= (qCoreFlags_t)( ~BIT )
#define QKERNEL_COREFLAG_GET( FLAG, BIT )       ( ( 0uL != ( (FLAG) & (BIT) ) )? qTrue : qFalse )

/*an item of the priority-queue*/
/*! @cond  */
typedef struct _qQueueStack_s {
    qTask_t *Task;      /*< A pointer to the task. */
    void *QueueData;    /*< The data to queue. */
}
qQueueStack_t;

typedef qUINT32_t qCoreFlags_t;

typedef qBool_t (*qNotificationSpreaderFcn_t)( qTask_t * const Task, void* eventdata );

typedef struct _qNotificationSpreader_s {
    qNotificationSpreaderFcn_t mode;
    void *eventdata;
}
qNotificationSpreader_t;

typedef struct _qKernelControlBlock_s { /*KCB(Kernel Control Block) definition*/
    qList_t CoreLists[ Q_PRIORITY_LEVELS + 2 ];         /*< [ ReadyLists[...] WaitingList SuspendedList  ]*/
    qTaskFcn_t IDLECallback;                            /*< The callback function that represents the idle-task activities. */
    qTask_t *CurrentRunningTask;                        /*< Points to the current running task. */
    #if ( Q_ALLOW_YIELD_TO_TASK == 1 )
        qTask_t *YieldTask;
    #endif
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        qTaskFcn_t ReleaseSchedCallback;                /*< The callback function for the scheduler release action. */
    #endif
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        void *QueueData;                                /*< Hold temporarily one item-data of the FIFO queue.*/
        qQueueStack_t QueueStack[ Q_PRIO_QUEUE_SIZE ];  /*< The required stack to build the FIFO priority queue. */
        volatile qBase_t QueueIndex;                    /*< The current index of the FIFO priority queue. */
    #endif
    _qEvent_t_ EventInfo;                               /*< Used to hold the event info for a task that will be changed to the qRunning state.*/
    volatile qCoreFlags_t Flag;                         /*< The scheduler Core-Flags. */
    #if ( Q_NOTIFICATION_SPREADER == 1 )
        volatile qNotificationSpreader_t NotificationSpreadRequest;
    #endif
    #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
        size_t TaskEntries;                             /*< Used to hold the number of task entries*/
    #endif
}
qKernelControlBlock_t;
/*! @endcond  */

/*=========================== Kernel Control Block ===========================*/
static qKernelControlBlock_t kernel;
static qList_t *const WaitingList = &kernel.CoreLists[ Q_PRIORITY_LEVELS ];
static qList_t *const SuspendedList = &kernel.CoreLists[ Q_PRIORITY_LEVELS + 1 ];
static qList_t *const ReadyList = &kernel.CoreLists[ 0 ];
static const qPriority_t MaxPriorityValue = (qPriority_t)Q_PRIORITY_LEVELS - 1u;
/*=============================== Private Methods ============================*/
static qBool_t qOS_TaskDeadLineReached( qTask_t * const Task );
static qBool_t qOS_CheckIfReady( qList_ForEachHandle_t h );
static qBool_t qOS_Dispatch( qList_ForEachHandle_t h );
static qTrigger_t qOS_Dispatch_xTask_FillEventInfo( qTask_t *Task );

#define qTaskIterValue( x )    ( ( ( (x) < 0 ) && ( (x) != qPeriodic ) )? -(x) : (x) )

#if ( Q_PRIO_QUEUE_SIZE > 0 )
    static void qOS_PriorityQueue_ClearIndex( qIndex_t indexToClear );
    static void qOS_PriorityQueue_CleanUp( const qTask_t * Task );
    static qTask_t* qOS_PriorityQueue_Get( void );
#endif

#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
    static void qOS_TriggerReleaseSchedEvent( void );
#endif

#if ( Q_QUEUES == 1 )
    static qTrigger_t qOS_AttachedQueue_CheckEvents( const qTask_t * const Task );
#endif

#if ( Q_FSM == 1)
    static void qOS_FSM_TaskCallback( qEvent_t e );
#endif

#if ( Q_ATCLI == 1 )
    static void qOS_ATCLI_TaskCallback( qEvent_t e );
    static void qOS_ATCLI_NotifyFcn( qATCLI_t * const cli );
#endif

#if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
    static qBool_t qOS_TaskEntryOrderPreserver( qList_CompareHandle_t h );
#endif

#if ( Q_ALLOW_TASK_NAMING == 1 )
    static qBool_t qOS_TaskNameLookup( qList_ForEachHandle_t h );
#endif

/*============================================================================*/
#if (Q_SETUP_TIME_CANONICAL == 1)
    qBool_t qOS_Setup( const qGetTickFcn_t tFcn,
                       qTaskFcn_t idleCallback )
#else
    qBool_t qOS_Setup( const qGetTickFcn_t tFcn,
                       const qTimingBase_t t,
                       qTaskFcn_t idleCallback )
#endif
{
    qBool_t retValue = qFalse;
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        if ( NULL != &kernel ) {
    #else
        /*cstat -CERT-FLP36-C*/
        if ( t > (qTimingBase_t)0 ) {
        /*cstat +CERT-FLP36-C*/
    #endif
        qIndex_t i;
        _QTRACE_KERNEL( "(*)Initializing QuarkTS kernel...", NULL, NULL );
        (void)qList_Initialize( SuspendedList );
        (void)qList_Initialize( WaitingList );
        for ( i = (qIndex_t)0 ; i < (qIndex_t)Q_PRIORITY_LEVELS ; i++ ) {
            (void)qList_Initialize( &ReadyList[ i ] );
        }
        #if ( Q_SETUP_TIME_CANONICAL != 1 )
            (void)qClock_SetTimeBase( t );
        #endif
        kernel.IDLECallback = idleCallback;
        #if ( Q_PRIO_QUEUE_SIZE > 0 )
            qOS_PriorityQueue_Init();
        #endif
        #if ( Q_NOTIFICATION_SPREADER == 1 )
            kernel.NotificationSpreadRequest.mode = NULL;
            kernel.NotificationSpreadRequest.eventdata = NULL;
        #endif
        kernel.Flag = 0uL; /*clear all the core flags*/
        #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
            kernel.ReleaseSchedCallback = NULL;
        #endif
        #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
            kernel.TaskEntries = (size_t)0u;
        #endif
        kernel.CurrentRunningTask = NULL;
        (void)qClock_SetTickProvider( tFcn );
        retValue = qTrue;
    }
    else {
        _QTRACE_KERNEL( "(E)QuarkTS kernel can not be initialized", NULL, NULL );
    }
    return retValue;
}
/*========================== Shared Private Method ===========================*/
qTask_t* qOS_Get_TaskRunning( void )
{
    /*get the handle of the current running task*/
    return kernel.CurrentRunningTask;
}
/*============================================================================*/
qBool_t qOS_Set_IdleTask( qTaskFcn_t callbackFcn )
{
    qBool_t retValue = qFalse;

    if ( callbackFcn != kernel.IDLECallback ) {
        kernel.IDLECallback = callbackFcn;
        retValue = qTrue;
        _QTRACE_KERNEL( "(>)Idle-task callback changed", NULL, NULL );
    }

    return retValue;
}
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
/*============================================================================*/
qBool_t qOS_Scheduler_Release( void )
{
    QKERNEL_COREFLAG_SET( kernel.Flag, QKERNEL_BIT_RELEASESCHED );
    _QTRACE_KERNEL( "(>)Scheduler release has been requested", NULL, NULL );

    return qTrue; /*only for API compatibility*/
}
/*============================================================================*/
qBool_t qOS_Set_SchedulerReleaseCallback( qTaskFcn_t rCallback )
{
    qBool_t retValue = qFalse;

    if ( rCallback != kernel.ReleaseSchedCallback ) {
        kernel.ReleaseSchedCallback = rCallback;
        retValue = qTrue;
        _QTRACE_KERNEL( "(>)Scheduler-release callback changed", NULL, NULL );
    }

    return retValue;
}
#endif /* #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 ) */
/*============================================================================*/
qBool_t qOS_Notification_Spread( void *eventdata,
                                 const qTask_NotifyMode_t mode )
{
    qBool_t retValue = qFalse;

    #if ( Q_NOTIFICATION_SPREADER == 1 )
        /*do not proceed if any previous operation is in progress*/
        if ( NULL ==  kernel.NotificationSpreadRequest.mode ) {
            if ( ( qTask_NotifySimple == mode ) || ( qTask_NotifyQueued == mode ) ) {
                kernel.NotificationSpreadRequest.mode = ( qTask_NotifySimple == mode )? &qTask_Notification_Send : &qTask_Notification_Queue;
                kernel.NotificationSpreadRequest.eventdata = eventdata;
                retValue = qTrue;
                _QTRACE_KERNEL( "(>)Notification spread has been requested", NULL, NULL );
            }
        }
        else {
            _QTRACE_KERNEL( "(E)Another notification spread operation is in "
                            "progress. Request ignored",
                            NULL,
                            NULL );
        }

    #else
        Q_UNUSED( eventdata );
        Q_UNUSED( mode );
        _QTRACE_KERNEL( "(E)Notification spread its disabled. Request ignored",
                        NULL,
                        NULL );

    #endif

    return retValue;
}
/*============================================================================*/
#if ( Q_PRIO_QUEUE_SIZE > 0 )
static void qOS_PriorityQueue_CleanUp( const qTask_t * Task )
{
    qIndex_t i;
    _QTRACE_KERNEL( "(*)Performing priority-queue clean-up", NULL, NULL );
    for ( i = 1u ; ( i < (qIndex_t)Q_PRIO_QUEUE_SIZE ) ; ++i ) {
        if ( kernel.QueueStack[ i ].Task == Task ) {
            qOS_PriorityQueue_ClearIndex( i );
        }
    }
}
/*============================================================================*/
static void qOS_PriorityQueue_ClearIndex( qIndex_t indexToClear )
{
    qIndex_t j;
    qBase_t queueIndex;
    /*set the position in the queue as empty*/
    kernel.QueueStack[ indexToClear ].Task = NULL;
    queueIndex = (qBase_t)kernel.QueueIndex; /*to avoid side effects*/
    for ( j = indexToClear ; (qBase_t)j < queueIndex ; ++j ) {
        /*shift the remaining items of the queue*/
        kernel.QueueStack[ j ] = kernel.QueueStack[ j + (qIndex_t)1u ];
    }
    --kernel.QueueIndex; /*decrease the index*/
}
/*========================== Shared Private Method ===========================*/
qBool_t qOS_PriorityQueue_Insert( qTask_t * const Task,
                                  void *pData )
{
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        qBool_t retValue = qFalse;
        const qBase_t queueMaxIndex = Q_PRIO_QUEUE_SIZE - 1;
        qBase_t currentQueueIndex;

        currentQueueIndex = kernel.QueueIndex; /*to avoid side effects */
        /*check if data can be queued*/
        if ( ( NULL != Task )  && ( currentQueueIndex < queueMaxIndex ) ) {
            qQueueStack_t tmp;

            tmp.QueueData = pData;
            tmp.Task = Task;
            /*cstat -CERT-INT32-C_a*/
            /*insert task and the corresponding eventdata to the queue*/
            /*CERT-INT32-C_a checked programatically*/
            kernel.QueueStack[ ++kernel.QueueIndex ] = tmp;
            /*cstat +CERT-INT32-C_a*/
            retValue = qTrue;
            _QTRACE_KERNEL( "(>)Event inserted on priority queue for task ",
                            Task,
                            pData );
        }
        else {
            _QTRACE_KERNEL( "(E)Event not inserted on priority queue. Queue "
                            "full or invalid data.",
                            NULL,
                            NULL );
        }
        return retValue;
    #else
        Q_UNUSED( Task );
        Q_UNUSED( Data );
        _QTRACE_KERNEL( "(E)Event not inserted inserted on priority queue. "
                        "Queue its disabled",
                        NULL,
                        NULL );
        return qFalse;
    #endif
}
/*========================== Shared Private Method ===========================*/
qBool_t qOS_PriorityQueue_IsTaskInside( const qTask_t * const Task )
{
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        qBool_t retValue = qFalse;
        qBase_t currentQueueIndex, i;

        currentQueueIndex = kernel.QueueIndex + 1;
        /*check first if the queue has items inside*/
        if ( currentQueueIndex > 0 ) {
            qCritical_Enter();
            /*loop the queue slots to check if the Task is inside*/
            for ( i = 0 ; i < currentQueueIndex ; ++i ) {
                if ( Task == kernel.QueueStack[ i ].Task ) {
                    retValue = qTrue;
                    break;
                }
            }
            qCritical_Exit();
        }
        return retValue;
    #else
        Q_UNUSED( Task );

        return qFalse;
    #endif
}
/*============================================================================*/
static qTask_t* qOS_PriorityQueue_Get( void )
{
    qTask_t *xTask = NULL;

    if ( kernel.QueueIndex >= 0 ) { /*queue has elements*/
        qPriority_t maxPriorityValue, iPriorityValue;
        qIndex_t indexTaskToExtract = 0u;
        qIndex_t i;

        _QTRACE_KERNEL( "(*)Cheking priority-queue slots...", NULL, NULL );
        qCritical_Enter();
        maxPriorityValue = kernel.QueueStack[ 0 ].Task->qPrivate.Priority;
        /*walk through the queue to find the task with the highest priority*/
        /*loop until all items are checked or if the tail is reached*/
        for ( i = 1u ; ( i < (qIndex_t)Q_PRIO_QUEUE_SIZE ) && ( NULL != kernel.QueueStack[i].Task ) ; ++i ) {
            iPriorityValue = kernel.QueueStack[i].Task->qPrivate.Priority;
            /*check if the queued task has the max priority value*/
            if ( iPriorityValue > maxPriorityValue ) {
                maxPriorityValue = iPriorityValue; /*Reassign the max value*/
                indexTaskToExtract = i;  /*save the index*/
            }
        }
        /*get the data from the queue*/
        kernel.QueueData = kernel.QueueStack[ indexTaskToExtract ].QueueData;
        /*assign the task to the output*/
        xTask = kernel.QueueStack[ indexTaskToExtract ].Task;
        _QTRACE_KERNEL( "(*)Priority-queue item obtained for task ", xTask, NULL );
        qOS_PriorityQueue_ClearIndex( indexTaskToExtract );
        qCritical_Exit();
    }

    return xTask;
}
/*========================== Shared Private Method ===========================*/
size_t qOS_PriorityQueue_GetCount( void )
{
    size_t retValue = (size_t)0u;

    if ( kernel.QueueIndex >= 0 ) {
        retValue = (size_t)kernel.QueueIndex + (size_t)1u;
    }

    return retValue;
}
/*========================== Shared Private Method ===========================*/
void qOS_PriorityQueue_Init( void )
{
    size_t i;
    qCritical_Enter();
    for ( i = 0u ; i < (qIndex_t)Q_PRIO_QUEUE_SIZE ; i++ ) {
        kernel.QueueStack[ i ].Task = NULL;  /*set the priority queue as empty*/
    }
    kernel.QueueIndex = -1;
    kernel.QueueData = NULL;
    qCritical_Exit();
}
/*============================================================================*/
#endif /* #if ( Q_PRIORITY_QUEUE == 1 ) */
/*============================================================================*/
qBool_t qOS_Add_Task( qTask_t * const Task,
                      qTaskFcn_t callbackFcn,
                      const qPriority_t p,
                      const qTime_t t,
                      const qIteration_t n,
                      const qState_t init,
                      void* arg )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        (void)memset( Task, 0, sizeof( qTask_t ) );
        Task->qPrivate.Callback = callbackFcn;
        (void)qSTimer_Set( &Task->qPrivate.timer, t );
        Task->qPrivate.TaskData = arg;
        Task->qPrivate.Priority = qFLM_ClipUpper( p, MaxPriorityValue );
        Task->qPrivate.Iterations = ( qPeriodic == n )? qPeriodic : -n;
        Task->qPrivate.Notification = 0uL;
        Task->qPrivate.Trigger = qTriggerNULL;
        Task->qPrivate.Flags = 0uL;
        qOS_Set_TaskFlags( Task,
                           QTASK_BIT_INIT | QTASK_BIT_QUEUE_RECEIVER |
                           QTASK_BIT_QUEUE_FULL | QTASK_BIT_QUEUE_COUNT |
                           QTASK_BIT_QUEUE_EMPTY | QTASK_BIT_REMOVE_REQUEST,
                           qFalse);
        /*task will be awaken and enabled*/
        qOS_Set_TaskFlags( Task, QTASK_BIT_SHUTDOWN | QTASK_BIT_ENABLED, qTrue );
        (void)qTask_Set_State( Task, init );

        #if ( Q_ALLOW_TASK_NAMING == 1 )
            Task->qPrivate.Name = NULL;
        #endif
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->qPrivate.Cycles = 0uL;
        #endif
        #if ( Q_QUEUES == 1 )
            Task->qPrivate.Queue = NULL;
        #endif
        #if ( ( Q_FSM == 1 ) || ( Q_ATCLI == 1 ) )
            Task->qPrivate.aObj = NULL;
        #endif
        #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
            Task->qPrivate.Entry = kernel.TaskEntries++;
        #endif
        retValue = qList_Insert( WaitingList, Task, QLIST_ATBACK );
        _QTRACE_KERNEL( "(*)Insertion Performed to waiting-list for task ",
                        Task,
                        NULL );
    }
    else {
        _QTRACE_KERNEL( "(E)Bad arguments. Request ignored", NULL, NULL );
    }

    return retValue;
}
/*============================================================================*/
qBool_t qOS_Add_EventTask( qTask_t * const Task,
                           qTaskFcn_t callbackFcn,
                           const qPriority_t p,
                           void* arg )
{
    return qOS_Add_Task( Task,
                         callbackFcn,
                         p,
                         qTimeImmediate,
                         qSingleShot,
                         qDisabled,
                         arg );
}
#if ( Q_FSM == 1 )
/*============================================================================*/
qBool_t qOS_Add_StateMachineTask( qTask_t * const Task,
                                  qSM_t *m,
                                  const qPriority_t p,
                                  const qTime_t t,
                                  const qState_t init,
                                  void *arg )
{
    qBool_t retValue = qFalse;

    if ( NULL != m ) {
        retValue = qOS_Add_Task( Task,
                                 qOS_FSM_TaskCallback,
                                 p,
                                 t,
                                 qPeriodic,
                                 init,
                                 arg );
        if ( qTrue == retValue ) {
            Task->qPrivate.aObj = m;
            m->qPrivate.Owner = Task;
            #if ( Q_QUEUES == 1 )
                if ( NULL != m->qPrivate.queue ) {
                    /*bind the queue*/
                    retValue = qTask_Attach_Queue( Task,
                                                   m->qPrivate.queue,
                                                   qQueueMode_Count,
                                                   1u );
                }
            #endif
            _QTRACE_KERNEL( "(>)State-machine successfully attached to task ",
                            Task,
                            m );
        }
    }

    return retValue;
}
/*============================================================================*/
static void qOS_FSM_TaskCallback( qEvent_t e )
{
    qTask_t * const xTask = qTask_Self();
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    qSM_t * const sm = (qSM_t *)xTask->qPrivate.aObj;
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    /*cstat -MISRAC2012-Rule-11.8*/
    sm->qPrivate.handler.Data = (void*)e;
    /*cstat +MISRAC2012-Rule-11.8*/
    _QTRACE_KERNEL( "(^)Running state-machine from task ", xTask, sm );
    (void)qStateMachine_Run( sm, QSM_SIGNAL_NONE );
}
#endif /* #if ( Q_FSM == 1) */
/*============================================================================*/
#if ( Q_ATCLI == 1 )
qBool_t qOS_Add_ATCLITask( qTask_t * const Task,
                           qATCLI_t *cli,
                           const qPriority_t p,
                           void *arg )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != Task ) && ( NULL != cli ) ) {
        if ( qTrue == qOS_Add_EventTask( Task, qOS_ATCLI_TaskCallback, p, arg ) ) {
            Task->qPrivate.aObj = cli;
            cli->qPrivate.Owner = Task;
            cli->qPrivate.xNotifyFcn = &qOS_ATCLI_NotifyFcn;
            _QTRACE_KERNEL( "(>)CLI successfully attached to task ", Task, cli );
            retValue = qTrue;
        }
    }
    return retValue;
}
/*============================================================================*/
static void qOS_ATCLI_TaskCallback( qEvent_t e )/*wrapper for the task callback */
{
    qTask_t * const xTask = qTask_Self();
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    qATCLI_t * const cli = (qATCLI_t *)xTask->qPrivate.aObj;
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    /*cstat -MISRAC2012-Rule-11.8*/
    cli->qPrivate.xPublic.Data = (void*)e;
    /*cstat +MISRAC2012-Rule-11.8*/
    _QTRACE_KERNEL( "(^)Running AT-CLI from task ", xTask, cli );
    (void)qATCLI_Run( cli ); /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
}
/*============================================================================*/
static void qOS_ATCLI_NotifyFcn( qATCLI_t * const cli )
{
    qTask_t *xTask;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    xTask = (qTask_t *)cli->qPrivate.Owner; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    /*
    simple notifications preferred because queued notification can be disabled
    on <qconfig.h>
    */
    (void)qTask_Notification_Send( xTask, NULL );
}
#endif /* #if ( Q_ATCLI == 1 ) */
/*============================================================================*/
qBool_t qOS_Remove_Task( qTask_t * const Task )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        qOS_Set_TaskFlags( Task, QTASK_BIT_REMOVE_REQUEST, qTrue );
        retValue = qTrue;
        _QTRACE_KERNEL( "(*)Scheduling scheme removal performed for task ", Task, NULL );
    }

    return retValue;
}
#if ( Q_QUEUES == 1 )
/*============================================================================*/
static qTrigger_t qOS_AttachedQueue_CheckEvents( const qTask_t * const Task )
{
    qTrigger_t retValue = qTriggerNULL;

    if ( NULL != Task->qPrivate.Queue ) {
        qBool_t fullFlag, countFlag, receiverFlag, emptyFlag;
        size_t currentQueueCount;

        fullFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_FULL );
        countFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_COUNT );
        receiverFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_RECEIVER );
        emptyFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_EMPTY );

        currentQueueCount = qQueue_Count( Task->qPrivate.Queue ); /*to avoid side effects*/
        /*check the queue events in the corresponding precedence order*/
        /*cstat -MISRAC2012-Rule-13.5 */
        /*qQueue_IsFull is known to have no side effects*/
        if ( fullFlag && qQueue_IsFull( Task->qPrivate.Queue ) ) {
            _QTRACE_KERNEL( "(>)Event::IsFull on attached-queue for task ",
                            Task,
                            Task->qPrivate.Queue );
            retValue =  byQueueFull;
        }
        else if ( ( countFlag ) && ( currentQueueCount >= Task->qPrivate.QueueCount ) ) {
            _QTRACE_KERNEL( "(>)Event::Count on attached-queue for task ",
                            Task,
                            Task->qPrivate.Queue );
            retValue =  byQueueCount;
        }
        else if ( receiverFlag && ( currentQueueCount > 0u ) ) {
            _QTRACE_KERNEL( "(>)Event::Receiver on attached-queue for task ",
                            Task,
                            Task->qPrivate.Queue );
            retValue = byQueueReceiver;
        }
        else if ( emptyFlag && qQueue_IsEmpty( Task->qPrivate.Queue ) ) { 
            /*qQueue_IsEmpty is known to have no side effects*/
            _QTRACE_KERNEL( "(>)Event::IsEmpty on attached-queue for task ",
                            Task,
                            Task->qPrivate.Queue );
            retValue =  byQueueEmpty;
        }
        else {
            /*this case does not need to be handled*/
        }
        /*cstat +MISRAC2012-Rule-13.5 */
    }

    return retValue;
}
#endif
/*============================================================================*/
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
static void qOS_TriggerReleaseSchedEvent( void )
{
    _QTRACE_KERNEL( "(*)Dispatching scheduler release event...", NULL, NULL );
    QKERNEL_COREFLAG_CLEAR( kernel.Flag, QKERNEL_BIT_INIT );
    QKERNEL_COREFLAG_CLEAR( kernel.Flag, QKERNEL_BIT_RELEASESCHED );
    kernel.EventInfo.FirstCall = ( qFalse == QKERNEL_COREFLAG_GET( kernel.Flag, QKERNEL_BIT_FCALLRELEASED ) )? qTrue : qFalse;
    kernel.EventInfo.Trigger = bySchedulingRelease;
    kernel.EventInfo.TaskData = NULL;
    if ( NULL != kernel.ReleaseSchedCallback ) {
        const qTaskFcn_t callback = kernel.ReleaseSchedCallback;
        /*some low-end compilers cant deal with function-pointers inside structs*/
        callback( &kernel.EventInfo );
    }
    QKERNEL_COREFLAG_SET( kernel.Flag, QKERNEL_BIT_FCALLIDLE ); /*MISRAC2012-Rule-11.3 allowed*/
}
#endif
/*============================================================================*/
qBool_t qOS_Run( void )
{
    /*cstat -MISRAC2012-Rule-2.2_c*/
    qBool_t retValue = qFalse; /*only for API compatibility*/
    /*cstat +MISRAC2012-Rule-2.2_c*/
    do {
        /*check for ready tasks in the waiting-list*/
        if ( qList_ForEach( WaitingList, qOS_CheckIfReady, NULL, QLIST_FORWARD, NULL ) ) {
            qPriority_t xPriorityListIndex = MaxPriorityValue;

            do { /*loop every ready-list in descending priority order*/
                /*get the target ready-list*/
                qList_t *xList = &ReadyList[ xPriorityListIndex ];
                if ( xList->size > (size_t)0u ) { /*check for a non-empty target list */
                    /*dispatch every task in the current ready-list*/
                    (void)qList_ForEach( xList, qOS_Dispatch, xList, QLIST_FORWARD, NULL );
                }
            } while ( 0u != xPriorityListIndex-- ); /*move to the next ready-list*/
        }
        else { /*no task in the scheme is ready*/
            if ( NULL != kernel.IDLECallback ) { /*check if idle-task is available*/
                _qList_ForEachHandle_t qOS_BuiltIn_IdleTask = { NULL, NULL, qList_WalkThrough };
                /*special call to dispatch idle-task already hardcoded in the kernel*/
                (void)qOS_Dispatch( &qOS_BuiltIn_IdleTask );
            }
        }
        if ( SuspendedList->size > (size_t)0u ) {  /*check for a non-empty suspended-list*/
            /*move the remaining suspended tasks to the waiting-list*/
            (void)qList_Move( WaitingList, SuspendedList, QLIST_ATBACK );
            #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
                /*preseve the entry order by sorting the new waiting-list*/
                (void)qList_Sort( WaitingList, qOS_TaskEntryOrderPreserver );
            #endif
        }
    }
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        while ( qFalse == QKERNEL_COREFLAG_GET( kernel.Flag, QKERNEL_BIT_RELEASESCHED ) );
        qOS_TriggerReleaseSchedEvent(); /*check for a scheduling-release request*/
        retValue = qTrue;
    #else
        while( qTrue == qTrue );
    #endif

    return retValue;
}
/*============================================================================*/
#if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
static qBool_t qOS_TaskEntryOrderPreserver( qList_CompareHandle_t h )
{
    qTask_t *t1, *t2;

    t1 = (qTask_t*)h->n1;
    t2 = (qTask_t*)h->n1;

    return (qBool_t)( t1->qPrivate.Entry > t2->qPrivate.Entry );
}
#endif
/*============================================================================*/
static qBool_t qOS_CheckIfReady( qList_ForEachHandle_t h )
{
    qTask_t *xTask;
    #if ( Q_QUEUES == 1 )
        qTrigger_t trg;
    #endif
    static qBool_t xReady = qFalse;
    qBool_t retValue = qFalse;

    if ( qList_WalkThrough == h->stage ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        xTask = (qTask_t*)h->node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        #if ( Q_NOTIFICATION_SPREADER == 1 )
            if ( NULL != kernel.NotificationSpreadRequest.mode ) {
                void *eventData= kernel.NotificationSpreadRequest.eventdata;
                _QTRACE_KERNEL( "(*)Spreading notification on task ", xTask, kernel.NotificationSpreadRequest.eventdata );
                kernel.NotificationSpreadRequest.mode( xTask, eventData );
                retValue = qTrue;
            }
        #endif
        if ( qOS_Get_TaskFlag( xTask, QTASK_BIT_SHUTDOWN ) ) {
            #if ( Q_PRIO_QUEUE_SIZE > 0 )
            if ( byNotificationQueued == xTask->qPrivate.Trigger ) {
                _QTRACE_KERNEL( "(<)Event {byNotificationQueued} detected on task "
                                ,
                                xTask,
                                NULL );
                xReady = qTrue;
            }
            else
            #endif
            if ( qOS_TaskDeadLineReached( xTask ) ) {
                _QTRACE_KERNEL( "(<)Event {byTimeElapsed} detected on task ",
                                xTask,
                                NULL );
                (void)qSTimer_Reload( &xTask->qPrivate.timer );
                xTask->qPrivate.Trigger = byTimeElapsed;
                xReady = qTrue;
            }
            #if ( Q_QUEUES == 1 )
            else if ( qTriggerNULL != ( trg = qOS_AttachedQueue_CheckEvents( xTask ) ) ) {
                _QTRACE_KERNEL( "(<)Event {AttachedQueue} detected on task ",
                                xTask,
                                NULL );
                xTask->qPrivate.Trigger = trg;
                xReady = qTrue;
            }
            #endif
            else if ( xTask->qPrivate.Notification > (qNotifier_t)0u ) {
                _QTRACE_KERNEL( "(<)Event {byNotificationSimple} detected on task ",
                                xTask,
                                NULL );
                xTask->qPrivate.Trigger = byNotificationSimple;
                xReady = qTrue;
            }
            #if ( Q_TASK_EVENT_FLAGS == 1 )
            else if ( 0uL != (QTASK_EVENTFLAGS_RMASK & xTask->qPrivate.Flags ) ) {
                _QTRACE_KERNEL( "(<)Event {byEventFlags} detected on task ",
                                xTask,
                                NULL );
                xTask->qPrivate.Trigger = byEventFlags;
                xReady = qTrue;
            }
            #endif
            else {
                xTask->qPrivate.Trigger = qTriggerNULL;
                /*the task has no available events, put it into a suspended state*/
            }
        }
        (void)qList_Remove( WaitingList, NULL, QLIST_ATFRONT );
        /*check if the task has a removal request*/
        if ( qOS_Get_TaskFlag( xTask, QTASK_BIT_REMOVE_REQUEST) ) {
            #if ( Q_PRIO_QUEUE_SIZE > 0 )
                qCritical_Enter();
                /*clean any entry of this task from the priority queue */
                qOS_PriorityQueue_CleanUp( xTask );
                qCritical_Exit();
            #endif
            /*clear the removal request*/
            qOS_Set_TaskFlags( xTask, QTASK_BIT_REMOVE_REQUEST, qFalse );
        }
        else {
            qList_t *xList;

            if ( qTriggerNULL != xTask->qPrivate.Trigger ) {
                xList = &ReadyList[ xTask->qPrivate.Priority ];
                _QTRACE_KERNEL( "(*)Moving to ready-list task ", xTask, NULL );
            }
            else {
                xList = SuspendedList;
            }
            (void)qList_Insert( xList, xTask, QLIST_ATBACK );
        }
    }
    else if ( qList_WalkInit == h->stage ) {
        xReady = qFalse;
        #if ( Q_PRIO_QUEUE_SIZE > 0 )
            /*try to extract a task from the front of the priority queue*/
            xTask = qOS_PriorityQueue_Get();
            if ( NULL != xTask ) {  /*got a task from the priority queue?*/
                xTask->qPrivate.Trigger = byNotificationQueued;
                /*wake-up the task!!*/
                qOS_Set_TaskFlags( xTask, QTASK_BIT_SHUTDOWN, qTrue );
            }
        #endif
    }
    else if ( qList_WalkEnd == h->stage ) {
        #if ( Q_NOTIFICATION_SPREADER == 1 )
            /*spread operation done, clean-up*/
            kernel.NotificationSpreadRequest.mode = NULL;
            kernel.NotificationSpreadRequest.eventdata = NULL;
        #endif
        retValue = xReady;
    }
    else {
        /*this should never enter here*/
    }

    return retValue;
}
/*============================================================================*/
static qTrigger_t qOS_Dispatch_xTask_FillEventInfo( qTask_t *Task )
{
    qTrigger_t xEvent;
    qIteration_t taskIteration;

    xEvent = Task->qPrivate.Trigger;
    /*
    take the necessary actions before dispatching, depending on the event that
    triggered the task
    */
    switch ( xEvent ) {
        case byTimeElapsed:
            /*handle the iteration value and the FirstIteration flag*/
            taskIteration = Task->qPrivate.Iterations;
            kernel.EventInfo.FirstIteration = ( ( qPeriodic != taskIteration ) && ( taskIteration < 0 ) )? qTrue : qFalse;
            Task->qPrivate.Iterations = ( kernel.EventInfo.FirstIteration )? -Task->qPrivate.Iterations : Task->qPrivate.Iterations;
            if ( qPeriodic != Task->qPrivate.Iterations ) {
                --Task->qPrivate.Iterations;
            }
            kernel.EventInfo.LastIteration = ( 0 == Task->qPrivate.Iterations )? qTrue : qFalse;
            if ( kernel.EventInfo.LastIteration ) {
                /*When the iteration value is reached, the task will be disabled*/
                qOS_Set_TaskFlags( Task, QTASK_BIT_ENABLED, qFalse );
            }
            kernel.EventInfo.StartDelay = qClock_GetTick() - Task->qPrivate.timer.Start;
            break;
        case byNotificationSimple:
            /*Transfer async-data to the eventinfo structure*/
            kernel.EventInfo.EventData = Task->qPrivate.AsyncData;
            --Task->qPrivate.Notification;
            break;
        #if ( Q_QUEUES == 1 )
            case byQueueReceiver:
                /*the EventData will point to the queue front-data*/
                kernel.EventInfo.EventData = qQueue_Peek( Task->qPrivate.Queue );
                break;
            case byQueueFull: case byQueueCount: case byQueueEmpty:
                /*the EventData will point to the the linked queue*/
                kernel.EventInfo.EventData = (void*)Task->qPrivate.Queue;
                break;
        #endif
        #if ( Q_PRIO_QUEUE_SIZE > 0 )
            case byNotificationQueued:
                /*get the extracted data from queue*/
                kernel.EventInfo.EventData = kernel.QueueData;
                kernel.QueueData = NULL;
                break;
        #endif
        #if ( Q_TASK_EVENT_FLAGS == 1 )
            case byEventFlags:
                break;
        #endif
            default: break;
    }
    /*Fill the event info structure: Trigger, FirstCall and TaskData */
    kernel.EventInfo.Trigger = Task->qPrivate.Trigger;
    kernel.EventInfo.FirstCall = ( qFalse == qOS_Get_TaskFlag( Task, QTASK_BIT_INIT ) )? qTrue : qFalse;
    kernel.EventInfo.TaskData = Task->qPrivate.TaskData;
    kernel.CurrentRunningTask = Task; /*needed for qTask_Self()*/

    return xEvent;
}
/*============================================================================*/
static qBool_t qOS_Dispatch( qList_ForEachHandle_t h ) {
    /*cstat -MISRAC2012-Rule-11.5 -MISRAC2012-Rule-14.3_a -MISRAC2012-Rule-14.3_b -CERT-EXP36-C_b*/
    if ( qList_WalkThrough == h->stage ) { /*#!OK: false-positive can be reported here*/
        qList_t *xList = (qList_t*)h->arg; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        qTaskFcn_t taskActivities;
        qTrigger_t xEvent = byNoReadyTasks;

        if ( NULL != xList ) { /*#!OK* false-positive can be reported here*/
            qTask_t *xTask = (qTask_t*)h->node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            /*cstat +MISRAC2012-Rule-11.5 +MISRAC2012-Rule-14.3_a +MISRAC2012-Rule-14.3_b +CERT-EXP36-C_b*/
            xEvent = qOS_Dispatch_xTask_FillEventInfo( xTask ); /*#!OK : false-positive can be reported here*/
            taskActivities = xTask->qPrivate.Callback; /*#!OK: false-positive can be reported here*/

            #if ( Q_ALLOW_YIELD_TO_TASK == 1 )
                kernel.YieldTask = NULL;
            #endif

            if ( NULL != taskActivities ) {
                _QTRACE_KERNEL( "(^)Dispatching task ", xTask, NULL );
                taskActivities( &kernel.EventInfo );
            }

            #if ( Q_ALLOW_YIELD_TO_TASK == 1 )
                while ( NULL != kernel.YieldTask ) {
                    kernel.CurrentRunningTask = kernel.YieldTask;
                    taskActivities = kernel.CurrentRunningTask->qPrivate.Callback;
                    kernel.YieldTask = NULL;
                    if ( NULL != taskActivities ) {
                        _QTRACE_KERNEL( "(^)Control yielded to task ",
                                        kernel.CurrentRunningTask,
                                        NULL );
                        /*yielded task inherits eventdata*/
                        taskActivities( &kernel.EventInfo );
                    }
                }
            #endif

            kernel.CurrentRunningTask = NULL;
            /*remove the task from the ready-list*/
            (void)qList_Remove( xList, NULL, QLIST_ATFRONT );
            /*and insert the task back to the waiting-list*/
            (void)qList_Insert( WaitingList, xTask, QLIST_ATBACK );
            #if ( Q_QUEUES == 1 )
                if ( byQueueReceiver == xEvent ) {
                    /*remove the data from the attached Queue*/
                    (void)qQueue_RemoveFront( xTask->qPrivate.Queue );
                }
            #endif
            /*set the init flag*/
            qOS_Set_TaskFlags( xTask, QTASK_BIT_INIT, qTrue );
            kernel.EventInfo.FirstIteration = qFalse;
            kernel.EventInfo.LastIteration =  qFalse;
            kernel.EventInfo.StartDelay = (qClock_t)0uL;
            kernel.EventInfo.EventData = NULL; /*clear the eventdata*/
            #if ( Q_TASK_COUNT_CYCLES == 1 )
                ++xTask->qPrivate.Cycles; /*increase the task-cycles value*/
            #endif
            xTask->qPrivate.Trigger = qTriggerNULL;
        }
        else { /*run the idle*/
            kernel.EventInfo.FirstCall = ( qFalse == QKERNEL_COREFLAG_GET( kernel.Flag, QKERNEL_BIT_FCALLIDLE ) )? qTrue : qFalse;
            kernel.EventInfo.TaskData = NULL;
            kernel.EventInfo.Trigger = xEvent;
            taskActivities = kernel.IDLECallback;
            /*some compilers can´t deal with function pointers inside structs*/
            taskActivities( &kernel.EventInfo ); /*run the idle callback*/
            QKERNEL_COREFLAG_SET( kernel.Flag, QKERNEL_BIT_FCALLIDLE );
        }
    }

    return qFalse;
}
/*============================================================================*/
static qBool_t qOS_TaskDeadLineReached( qTask_t * const Task )
{
    qBool_t retValue = qFalse;

    if ( qOS_Get_TaskFlag( Task, QTASK_BIT_ENABLED ) ) {
        const qIteration_t taskIterations = Task->qPrivate.Iterations;
        /*task should be periodic or must have available iters*/
        if ( ( qTaskIterValue( taskIterations ) > 0 ) || ( qPeriodic == taskIterations ) ) {
            qClock_t taskInterval = Task->qPrivate.timer.TV;
            qBool_t deadLineReached;

            deadLineReached = qSTimer_Expired( &Task->qPrivate.timer );
            /*check the time deadline*/
            if( ( 0uL == taskInterval ) || deadLineReached ) {
                retValue = qTrue;
            }
        }
    }

    return retValue;
}
/*========================== Shared Private Method ===========================*/
qTask_GlobalState_t qOS_GetTaskGlobalState( const qTask_t * const Task )
{
    qTask_GlobalState_t retValue = qUndefinedGlobalState;

    if ( NULL != Task ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        const qList_t * const xList = (qList_t *)Task->qPrivate.container; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        if ( kernel.CurrentRunningTask == Task ) {
            retValue = qRunning;
        }
        else if ( WaitingList == xList ) {
            retValue = qWaiting;
        }
        else if ( SuspendedList == xList ) {
            retValue = qSuspended;
        }
        else if ( NULL == xList ) {
            /*undefined*/
        }
        else {
            retValue = qReady; /*by discard, it must be ready*/
        }
    }

    return retValue;
}
/*========================== Shared Private Method ===========================*/
qBool_t qOS_Get_TaskFlag( const qTask_t * const Task,
                          const qUINT32_t flag )
{
    qUINT32_t xBit;

    xBit = Task->qPrivate.Flags & flag;

    return ( ( 0uL != xBit )? qTrue : qFalse );
}
/*========================== Shared Private Method ===========================*/
void qOS_Set_TaskFlags( qTask_t * const Task,
                        const qUINT32_t flags,
                        const qBool_t value )
{
    if ( qTrue == value ) {
        qFLM_BitsSet( Task->qPrivate.Flags, flags );
    }
    else {
        qFLM_BitsClear( Task->qPrivate.Flags, flags );
    }
}
/*============================================================================*/
#if ( Q_ALLOW_TASK_NAMING == 1 )
static qBool_t qOS_TaskNameLookup( qList_ForEachHandle_t h )
{
    qBool_t retValue = qFalse;

    if ( qList_WalkThrough == h->stage ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        void **xLookupData = (void**)h->arg;
        const char *name = (const char*)xLookupData[ 0 ];
        qTask_t *xTask = (qTask_t*)h->node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */

        if ( NULL != xTask->qPrivate.Name ) {
            /*cstat -CERT-STR32-C */
            if ( 0 == strncmp( name, xTask->qPrivate.Name, 32u ) ) {
                xLookupData[ 1 ] = (void*)xTask;
                retValue = qTrue;
            }
            /*cstat +CERT-STR32-C */
        }
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    }

    return retValue;
}
/*============================================================================*/
qTask_t* qOS_FindTaskByName( const char *name )
{
    qTask_t *found = NULL;

    if ( NULL != name ) {
        const void *xLookupData[ 2 ] = { (const void*)name, NULL };
        const size_t maxLists = qFLM_ArraySize( kernel.CoreLists );
        size_t i;

        for ( i = 0u ; i < maxLists ; ++i ) {
            if ( qTrue == qList_ForEach( &kernel.CoreLists[ i ], qOS_TaskNameLookup, &xLookupData, QLIST_FORWARD, NULL ) ) {
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.8*/
                found = (qTask_t*)xLookupData[ 1 ];
                /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b +MISRAC2012-Rule-11.8b*/
                break;
            }
        }
    }

    return found;
}
/*============================================================================*/
#endif /*#if ( Q_ALLOW_TASK_NAMING == 1 )*/
#if ( Q_ALLOW_YIELD_TO_TASK == 1 )
/*============================================================================*/
qBool_t qOS_YieldToTask( qTask_t * const Task )
{
    qBool_t retValue = qFalse;
    if ( ( NULL != kernel.CurrentRunningTask ) && ( Task != kernel.CurrentRunningTask ) ) {
        kernel.YieldTask = Task;
        retValue = qTrue;
    }
    return retValue;
}
/*============================================================================*/
#endif
