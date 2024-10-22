/*!
 * @file qkernel.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qkernel.h"
#include "qkshared.h" /*kernel shared methods*/
#include "qtrace.h"
#include "qflm.h"

#define QKERNEL_BIT_INIT                     ( 0x00000001uL )
#define QKERNEL_BIT_FCALL_IDLE               ( 0x00000002uL )
#define QKERNEL_BIT_RELEASE_SCHED            ( 0x00000004uL )
#define QKERNEL_BIT_FCALL_RELEASED           ( 0x00000008uL )

#define QKERNEL_CORE_FLAG_SET( FLAG, BIT )                                  \
( FLAG ) |= (qCoreFlags_t)( BIT )                                           \

#define QKERNEL_CORE_FLAG_CLEAR( FLAG, BIT )                                \
( FLAG ) &= (qCoreFlags_t)( ~BIT )                                          \

#define QKERNEL_CORE_FLAG_GET( FLAG, BIT )                                  \
( ( 0uL != ( (FLAG) & (BIT) ) ) ? qTrue : qFalse )                          \

#define QTASK_ITER_VALUE( x )                                               \
( ( ( (x) < 0 ) && ( (x) != qPeriodic ) ) ? -(x) : (x) )                    \

/*an item of the priority-queue*/
/*! @cond  */
typedef struct _qQueueStack_s {
    qTask_t *Task;      /*< A pointer to the task. */
    void *QueueData;    /*< The data to queue. */
}
qQueueStack_t;

typedef qUINT32_t qCoreFlags_t;

typedef qBool_t (*qNotificationSpreaderFcn_t)( qTask_t * const Task,
                                               void* eventData );

typedef struct _qNotificationSpreader_s {
    qNotificationSpreaderFcn_t mode;
    void *eventData;
}
qNotificationSpreader_t;

typedef struct _qKernelControlBlock_s { /*KCB(Kernel Control Block) definition*/
    qTaskFcn_t idleCallback;                            /*< The callback function that represents the idle-task activities. */
    qTask_t *currentTask;                               /*< Points to the current running task. */
    #if ( Q_ALLOW_YIELD_TO_TASK == 1 )
        qTask_t *yieldTask;
    #endif
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        qTaskFcn_t releaseSchedCallback;                /*< The callback function for the scheduler release action. */
    #endif
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        void *queueData;                                /*< Hold temporarily one item-data of the FIFO queue.*/
        volatile qBase_t queueIndex;                    /*< The current index of the FIFO priority queue. */
        qQueueStack_t queueStack[ Q_PRIO_QUEUE_SIZE ];  /*< The required stack to build the FIFO priority queue. */
    #endif
    _qEvent_t_ eventInfo;                               /*< Used to hold the event info for a task that will be changed to the qRunning state.*/
    volatile qCoreFlags_t flag;                         /*< The scheduler Core-Flags. */
    #if ( Q_NOTIFICATION_SPREADER == 1 )
        volatile qNotificationSpreader_t nSpreader;     /*< Notification spread request*/
    #endif
    #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
        size_t taskEntries;                             /*< Used to hold the number of task entries*/
    #endif
    qList_t coreLists[ Q_PRIORITY_LEVELS + 2 ];         /*< [ ReadyLists[...] WaitingList SuspendedList ]*/
}
qKernelControlBlock_t;
/*! @endcond  */

/*=========================== Kernel Control Block ===========================*/
static qKernelControlBlock_t kernel; // skipcq: CXX-W2009
static qList_t *const waitingList = &kernel.coreLists[ Q_PRIORITY_LEVELS ]; // skipcq: CXX-W2011
static qList_t *const suspendedList = &kernel.coreLists[ Q_PRIORITY_LEVELS + 1 ]; // skipcq: CXX-W2011
static qList_t *const readyList = &kernel.coreLists[ 0 ]; // skipcq: CXX-W2011
static _qEvent_t_ * const eventInfo = &kernel.eventInfo; // skipcq: CXX-W2011
static const qPriority_t maxPriorityValue = (qPriority_t)Q_PRIORITY_LEVELS - 1u;
/*=============================== Private Methods ============================*/
static qBool_t qOS_TaskDeadLineReached( qTask_t * const Task );

static qBool_t qOS_CheckForReadyTasks( void );
static void qOS_DispatchTasks( qList_t *xList );
static void qOS_DispatchIdleTask( void );
static void qOS_Dispatch_xTask_FillEventInfo( qTask_t *Task );

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
        if ( NULL != waitingList ) {
    #else
        /*cstat -CERT-FLP36-C*/
        if ( t > (qTimingBase_t)0 ) {
        /*cstat +CERT-FLP36-C*/
    #endif
        qIndex_t i;
        _qTrace_Kernel( "(*)Initializing QuarkTS kernel...", NULL, NULL );
        (void)qList_Initialize( suspendedList );
        (void)qList_Initialize( waitingList );
        for ( i = (qIndex_t)0 ; i < (qIndex_t)Q_PRIORITY_LEVELS ; ++i ) {
            (void)qList_Initialize( &readyList[ i ] );
        }
        #if ( Q_SETUP_TIME_CANONICAL != 1 )
            (void)qClock_SetTimeBase( t );
        #endif
        kernel.idleCallback = idleCallback;
        #if ( Q_PRIO_QUEUE_SIZE > 0 )
            qOS_PriorityQueue_Init();
        #endif
        #if ( Q_NOTIFICATION_SPREADER == 1 )
            kernel.nSpreader.mode = NULL;
            kernel.nSpreader.eventData = NULL;
        #endif
        kernel.flag = 0uL; /*clear all the core flags*/
        #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
            kernel.releaseSchedCallback = NULL;
        #endif
        #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
            kernel.taskEntries = (size_t)0u;
        #endif
        kernel.currentTask = NULL;
        (void)qClock_SetTickProvider( tFcn );
        retValue = qTrue;
    }
    else {
        _qTrace_Kernel( "(E)QuarkTS kernel can not be initialized", NULL, NULL );
    }
    return retValue;
}
/*========================== Shared Private Method ===========================*/
qTask_t* qOS_Get_TaskRunning( void )
{
    /*get the handle of the current running task*/
    return kernel.currentTask;
}
/*============================================================================*/
qBool_t qOS_Set_IdleTask( qTaskFcn_t callbackFcn )
{
    qBool_t retValue = qFalse;

    if ( callbackFcn != kernel.idleCallback ) {
        kernel.idleCallback = callbackFcn;
        retValue = qTrue;
        _qTrace_Kernel( "(>)Idle-task callback changed", NULL, NULL );
    }

    return retValue;
}
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
/*============================================================================*/
qBool_t qOS_Scheduler_Release( void )
{
    QKERNEL_CORE_FLAG_SET( kernel.flag, QKERNEL_BIT_RELEASE_SCHED );
    _qTrace_Kernel( "(>)Scheduler release has been requested", NULL, NULL );

    return qTrue; /*only for API compatibility*/
}
/*============================================================================*/
qBool_t qOS_Set_SchedulerReleaseCallback( qTaskFcn_t rCallback )
{
    qBool_t retValue = qFalse;

    if ( rCallback != kernel.releaseSchedCallback ) {
        kernel.releaseSchedCallback = rCallback;
        retValue = qTrue;
        _qTrace_Kernel( "(>)Scheduler-release callback changed", NULL, NULL );
    }

    return retValue;
}
#endif /* #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 ) */
/*============================================================================*/
/*cstat -MISRAC2012-Rule-8.13*/
qBool_t qOS_Notification_Spread( void *eventData,
                                 const qTask_NotifyMode_t mode )
{
    /*cstat +MISRAC2012-Rule-8.13*/
    qBool_t retValue = qFalse;

    #if ( Q_NOTIFICATION_SPREADER == 1 )
        /*do not proceed if any previous operation is in progress*/
        if ( NULL == kernel.nSpreader.mode ) {
            if ( ( qTask_NotifySimple == mode ) || ( qTask_NotifyQueued == mode ) ) {
                kernel.nSpreader.mode = ( qTask_NotifySimple == mode ) ?
                                        &qTask_Notification_Send :
                                        &qTask_Notification_Queue;
                kernel.nSpreader.eventData = eventData;
                retValue = qTrue;
                _qTrace_Kernel( "(>)Notification spread has been requested",
                                NULL,
                                NULL );
            }
        }
        else {
            _qTrace_Kernel( "(E)Another notification spread operation is in "
                            "progress. Request ignored",
                            NULL,
                            NULL );
        }

    #else
        Q_UNUSED( eventData );
        Q_UNUSED( mode );
        _qTrace_Kernel( "(E)Notification spread its disabled. Request ignored",
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
    _qTrace_Kernel( "(*)Performing priority-queue clean-up", NULL, NULL );
    for ( i = 1u ; ( i < (qIndex_t)Q_PRIO_QUEUE_SIZE ) ; ++i ) {
        if ( kernel.queueStack[ i ].Task == Task ) {
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
    kernel.queueStack[ indexToClear ].Task = NULL;
    queueIndex = (qBase_t)kernel.queueIndex; /*to avoid side effects*/
    for ( j = indexToClear ; (qBase_t)j < queueIndex ; ++j ) {
        /*shift the remaining items of the queue*/
        kernel.queueStack[ j ] = kernel.queueStack[ j + (qIndex_t)1u ];
    }
    --kernel.queueIndex; /*decrease the index*/
}
/*========================== Shared Private Method ===========================*/
/*cstat -MISRAC2012-Rule-8.13*/
qBool_t qOS_PriorityQueue_Insert( qTask_t * const Task,
                                  void *pData )
{
    /*cstat +MISRAC2012-Rule-8.13*/
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        qBool_t retValue = qFalse;
        const qBase_t queueMaxIndex = Q_PRIO_QUEUE_SIZE - 1;
        qBase_t currentQueueIndex;

        currentQueueIndex = kernel.queueIndex; /*to avoid side effects */
        /*check if data can be queued*/
        if ( ( NULL != Task )  && ( currentQueueIndex < queueMaxIndex ) ) {
            qQueueStack_t tmp;

            tmp.QueueData = pData;
            tmp.Task = Task;
            /*cstat -CERT-INT32-C_a*/
            /*insert task and the corresponding eventData to the queue*/
            /*CERT-INT32-C_a checked programmatically*/
            kernel.queueStack[ ++kernel.queueIndex ] = tmp;
            /*cstat +CERT-INT32-C_a*/
            retValue = qTrue;
            _qTrace_Kernel( "(>)Event inserted on priority queue for task ",
                            Task,
                            pData );
        }
        else {
            _qTrace_Kernel( "(E)Event not inserted on priority queue. Queue "
                            "full or invalid data.",
                            NULL,
                            NULL );
        }
        return retValue;
    #else
        Q_UNUSED( Task );
        Q_UNUSED( pData );
        _qTrace_Kernel( "(E)Event not inserted inserted on priority queue. "
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
        qBase_t currentQueueIndex;

        currentQueueIndex = kernel.queueIndex + 1;
        /*check first if the queue has items inside*/
        if ( currentQueueIndex > 0 ) {
            qBase_t i;

            qCritical_Enter();
            /*loop the queue slots to check if the Task is inside*/
            for ( i = 0 ; i < currentQueueIndex ; ++i ) {
                if ( Task == kernel.queueStack[ i ].Task ) {
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
    /*cstat -MISRAC2012-Rule-8.13*/
    qTask_t *xTask = NULL;
    /*cstat +MISRAC2012-Rule-8.13*/
    if ( kernel.queueIndex >= 0 ) { /*queue has elements*/
        qPriority_t maxPriority;
        qIndex_t indexTaskToExtract = 0u;
        qIndex_t i;

        _qTrace_Kernel( "(*)Checking priority-queue slots...", NULL, NULL );
        qCritical_Enter();
        maxPriority = kernel.queueStack[ 0 ].Task->qPrivate.priority;
        /*walk through the queue to find the task with the highest priority*/
        /*loop until all items are checked or if the tail is reached*/
        for ( i = 1u ; ( i < (qIndex_t)Q_PRIO_QUEUE_SIZE ) && ( NULL != kernel.queueStack[ i ].Task ) ; ++i ) {
            qPriority_t iPriorityValue = kernel.queueStack[ i ].Task->qPrivate.priority;
            /*check if the queued task has the max priority value*/
            if ( iPriorityValue > maxPriority ) {
                maxPriority = iPriorityValue; /*Reassign the max value*/
                indexTaskToExtract = i;  /*save the index*/
            }
        }
        /*get the data from the queue*/
        kernel.queueData = kernel.queueStack[ indexTaskToExtract ].QueueData;
        /*assign the task to the output*/
        xTask = kernel.queueStack[ indexTaskToExtract ].Task;
        _qTrace_Kernel( "(*)Priority-queue item obtained for task ", xTask, NULL );
        qOS_PriorityQueue_ClearIndex( indexTaskToExtract );
        qCritical_Exit();
    }

    return xTask;
}
/*========================== Shared Private Method ===========================*/
size_t qOS_PriorityQueue_GetCount( void )
{
    size_t retValue = (size_t)0u;

    if ( kernel.queueIndex >= 0 ) {
        retValue = (size_t)kernel.queueIndex + (size_t)1u;
    }

    return retValue;
}
/*========================== Shared Private Method ===========================*/
void qOS_PriorityQueue_Init( void )
{
    size_t i;
    qCritical_Enter();
    for ( i = 0u ; i < (qIndex_t)Q_PRIO_QUEUE_SIZE ; ++i ) {
        kernel.queueStack[ i ].Task = NULL;  /*set the priority queue as empty*/
    }
    kernel.queueIndex = -1;
    kernel.queueData = NULL;
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
        Task->qPrivate.callback = callbackFcn;
        (void)qSTimer_Set( &Task->qPrivate.timer, t );
        Task->qPrivate.taskData = arg;
        Task->qPrivate.priority = qFLM_ClipUpper( p, maxPriorityValue );
        /*cppcheck-suppress integerOverflow*/
        Task->qPrivate.iterations = ( qPeriodic == n ) ? qPeriodic : -n;
        Task->qPrivate.notification = 0uL;
        Task->qPrivate.trigger = qTriggerNULL;
        Task->qPrivate.flags = 0uL;
        qOS_Set_TaskFlags( Task,
                           QTASK_BIT_INIT | QTASK_BIT_QUEUE_RECEIVER |
                           QTASK_BIT_QUEUE_FULL | QTASK_BIT_QUEUE_COUNT |
                           QTASK_BIT_QUEUE_EMPTY | QTASK_BIT_REMOVE_REQUEST,
                           qFalse );
        /*task will be awaken and enabled*/
        qOS_Set_TaskFlags( Task,
                           QTASK_BIT_SHUTDOWN | QTASK_BIT_ENABLED,
                           qTrue );
        (void)qTask_Set_State( Task, init );

        #if ( Q_ALLOW_TASK_NAMING == 1 )
            Task->qPrivate.name = NULL;
        #endif
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->qPrivate.cycles = 0uL;
        #endif
        #if ( Q_QUEUES == 1 )
            Task->qPrivate.aQueue = NULL;
        #endif
        #if ( ( Q_FSM == 1 ) || ( Q_ATCLI == 1 ) )
            Task->qPrivate.aObj = NULL;
        #endif
        #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
            Task->qPrivate.entry = kernel.taskEntries++;
        #endif
        retValue = qList_Insert( waitingList, Task, QLIST_AT_BACK );
        _qTrace_Kernel( "(*)Insertion Performed to waiting-list for task ",
                        Task,
                        NULL );
    }
    else {
        _qTrace_Kernel( "(E)Bad arguments. Request ignored", NULL, NULL );
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
            m->qPrivate.owner = Task;
            #if ( Q_QUEUES == 1 )
                if ( NULL != m->qPrivate.sQueue ) {
                    /*bind the queue*/
                    retValue = qTask_Attach_Queue( Task,
                                                   m->qPrivate.sQueue,
                                                   qQueueMode_Count,
                                                   1u );
                }
            #endif
            _qTrace_Kernel( "(>)State-machine successfully attached to task ",
                            Task,
                            m );
        }
    }

    return retValue;
}
/*============================================================================*/
static void qOS_FSM_TaskCallback( qEvent_t e )
{
    const qTask_t * const xTask = qTask_Self();
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    /*cppcheck-suppress misra-c2012-11.5 */
    qSM_t *sm = (qSM_t *)xTask->qPrivate.aObj;
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    qSM_Signal_t sig = { QSM_SIGNAL_NONE, NULL };
    /*cstat -MISRAC2012-Rule-11.8*/
    /*cppcheck-suppress cert-EXP05-C */
    sm->qPrivate.handler.Data = (void*)e;
    /*cstat +MISRAC2012-Rule-11.8*/
    _qTrace_Kernel( "(^)Running state-machine from task ", xTask, sm );
    (void)qStateMachine_Run( sm, sig );
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
            cli->qPrivate.owner = Task;
            cli->qPrivate.xNotifyFcn = &qOS_ATCLI_NotifyFcn;
            _qTrace_Kernel( "(>)CLI successfully attached to task ", Task, cli );
            retValue = qTrue;
        }
    }
    return retValue;
}
/*============================================================================*/
static void qOS_ATCLI_TaskCallback( qEvent_t e )/*wrapper for the task callback */
{
    const qTask_t * const xTask = qTask_Self();
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    /*cppcheck-suppress misra-c2012-11.5 */
    qATCLI_t *cli = (qATCLI_t *)xTask->qPrivate.aObj;
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    /*cstat -MISRAC2012-Rule-11.8*/
    /*cppcheck-suppress cert-EXP05-C */
    cli->qPrivate.xPublic.Data = (void*)e;
    /*cstat +MISRAC2012-Rule-11.8*/
    _qTrace_Kernel( "(^)Running AT-CLI from task ", xTask, cli );
    (void)qATCLI_Run( cli ); /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
}
/*============================================================================*/
/*cstat -MISRAC2012-Rule-8.13*/
static void qOS_ATCLI_NotifyFcn( qATCLI_t * const cli )
{
    /*cstat +MISRAC2012-Rule-8.13*/
    qTask_t *xTask;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    /*cppcheck-suppress misra-c2012-11.5 */
    xTask = (qTask_t *)cli->qPrivate.owner; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
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
        _qTrace_Kernel( "(*)Scheduling scheme removal performed for task ",
                        Task,
                        NULL );
    }

    return retValue;
}
#if ( Q_QUEUES == 1 )
/*============================================================================*/
static qTrigger_t qOS_AttachedQueue_CheckEvents( const qTask_t * const Task )
{
    qTrigger_t retValue = qTriggerNULL;

    if ( NULL != Task->qPrivate.aQueue ) {
        qBool_t fullFlag, countFlag, receiverFlag, emptyFlag;
        size_t qCount; /*current queue count*/

        fullFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_FULL );
        countFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_COUNT );
        receiverFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_RECEIVER );
        emptyFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_EMPTY );

        qCount = qQueue_Count( Task->qPrivate.aQueue ); /*to avoid side effects*/
        /*check the queue events in the corresponding precedence order*/
        /*cstat -MISRAC2012-Rule-13.5 */
        /*qQueue_IsFull is known to have no side effects*/
        if ( fullFlag && qQueue_IsFull( Task->qPrivate.aQueue ) ) {
            _qTrace_Kernel( "(>)Event::IsFull on attached-queue for task ",
                            Task,
                            Task->qPrivate.aQueue );
            retValue = byQueueFull;
        }
        else if ( ( countFlag ) && ( qCount >= Task->qPrivate.aQueueCount ) ) {
            _qTrace_Kernel( "(>)Event::Count on attached-queue for task ",
                            Task,
                            Task->qPrivate.aQueue );
            retValue = byQueueCount;
        }
        else if ( receiverFlag && ( qCount > 0u ) ) {
            _qTrace_Kernel( "(>)Event::Receiver on attached-queue for task ",
                            Task,
                            Task->qPrivate.aQueue );
            retValue = byQueueReceiver;
        }
        else if ( emptyFlag && qQueue_IsEmpty( Task->qPrivate.aQueue ) ) {
            /*qQueue_IsEmpty is known to not have side effects*/
            _qTrace_Kernel( "(>)Event::IsEmpty on attached-queue for task ",
                            Task,
                            Task->qPrivate.aQueue );
            retValue = byQueueEmpty;
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
    _qTrace_Kernel( "(*)Dispatching scheduler release event...", NULL, NULL );
    QKERNEL_CORE_FLAG_CLEAR( kernel.flag, QKERNEL_BIT_INIT );
    QKERNEL_CORE_FLAG_CLEAR( kernel.flag, QKERNEL_BIT_RELEASE_SCHED );
    eventInfo->FirstCall = ( qFalse == QKERNEL_CORE_FLAG_GET( kernel.flag, QKERNEL_BIT_FCALL_RELEASED ) );
    eventInfo->Trigger = bySchedulingRelease;
    eventInfo->TaskData = NULL;
    if ( NULL != kernel.releaseSchedCallback ) {
        qTaskFcn_t callback = kernel.releaseSchedCallback;
        /*some low-end compilers cant deal with function-pointers inside structs*/
        callback( eventInfo );
    }
    QKERNEL_CORE_FLAG_SET( kernel.flag, QKERNEL_BIT_FCALL_IDLE ); /*MISRAC2012-Rule-11.3 allowed*/
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
        if ( qOS_CheckForReadyTasks() ) {
            qPriority_t xPriorityListIndex = maxPriorityValue;

            do { /*loop every ready-list in descending priority order*/
                /*get the target ready-list*/
                qList_t *xList = &readyList[ xPriorityListIndex ];
                if ( xList->size > (size_t)0u ) { /*check for a non-empty target list */
                    /*dispatch every task in the current ready-list*/
                    qOS_DispatchTasks( xList );
                }
            } while ( 0u != xPriorityListIndex-- ); /*move to the next ready-list*/
        }
        else { /*no task in the scheme is ready*/
            if ( NULL != kernel.idleCallback ) { /*check if idle-task is available*/
                qOS_DispatchIdleTask();
            }
        }
        /*check for a non-empty suspended-list*/
        if ( suspendedList->size > (size_t)0u ) {
            /*move the remaining suspended tasks to the waiting-list*/
            (void)qList_Move( waitingList, suspendedList, QLIST_AT_BACK );
            #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
                /*preseve the entry order by sorting the new waiting-list*/
                (void)qList_Sort( waitingList, qOS_TaskEntryOrderPreserver );
            #endif
        }
    }
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        while ( qFalse == QKERNEL_CORE_FLAG_GET( kernel.flag, QKERNEL_BIT_RELEASE_SCHED ) );
        qOS_TriggerReleaseSchedEvent(); /*check for a scheduling-release request*/
        retValue = qTrue;
    #else
        while ( qTrue == qTrue );
    #endif

    return retValue;
}
/*============================================================================*/
#if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
static qBool_t qOS_TaskEntryOrderPreserver( qList_CompareHandle_t h )
{
    const qTask_t *t1, *t2;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    t1 = (const qTask_t*)h->n1;
    t2 = (const qTask_t*)h->n2;
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    return (qBool_t)( t1->qPrivate.entry > t2->qPrivate.entry );
}
#endif
/*============================================================================*/
static qBool_t qOS_CheckForReadyTasks( void )
{
    qList_Iterator_t i;
    qTask_t *xTask;
    qBool_t xReady = qFalse;
    #if ( Q_QUEUES == 1 )
        qTrigger_t trg;
    #endif

    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        /*try to extract a task from the front of the priority queue*/
        xTask = qOS_PriorityQueue_Get();
        if ( NULL != xTask ) {  /*got a task from the priority queue?*/
            xTask->qPrivate.trigger = byNotificationQueued;
            /*wake-up the task!!*/
            qOS_Set_TaskFlags( xTask, QTASK_BIT_SHUTDOWN, qTrue );
        }
    #endif
    /*cstat -MISRAC2012-Rule-14.2*/
    for ( i = qList_Begin( waitingList) ; qListIterator_Until( &i, NULL ) ; qListIterator_Forward( &i ) ) {
    /*cstat +MISRAC2012-Rule-14.2*/
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /*cppcheck-suppress misra-c2012-11.5 */
        xTask = (qTask_t*)qListIterator_Get( &i );
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        #if ( Q_NOTIFICATION_SPREADER == 1 )
            if ( NULL != kernel.nSpreader.mode ) {
                /*cstat -MISRAC2012-Rule-8.13*/
                void * const eventData = kernel.nSpreader.eventData;
                /*cstat +MISRAC2012-Rule-8.13*/
                _qTrace_Kernel( "(*)Spreading notification on task ",
                                xTask,
                                kernel.nSpreader.eventData );
                kernel.nSpreader.mode( xTask, eventData );
                break;
            }
        #endif
        if ( qOS_Get_TaskFlag( xTask, QTASK_BIT_SHUTDOWN ) ) {
            #if ( Q_PRIO_QUEUE_SIZE > 0 )
            if ( byNotificationQueued == xTask->qPrivate.trigger ) {
                _qTrace_Kernel( "(<)Event {byNotificationQueued} detected on task ",
                                xTask,
                                NULL );
                xReady = qTrue;
            }
            else
            #endif
            if ( qOS_TaskDeadLineReached( xTask ) ) {
                _qTrace_Kernel( "(<)Event {byTimeElapsed} detected on task ",
                                xTask,
                                NULL );
                (void)qSTimer_Reload( &xTask->qPrivate.timer );
                xTask->qPrivate.trigger = byTimeElapsed;
                xReady = qTrue;
            }
            #if ( Q_QUEUES == 1 )
            else if ( qTriggerNULL != ( trg = qOS_AttachedQueue_CheckEvents( xTask ) ) ) {
                _qTrace_Kernel( "(<)Event {AttachedQueue} detected on task ",
                                xTask,
                                NULL );
                xTask->qPrivate.trigger = trg;
                xReady = qTrue;
            }
            #endif
            else if ( xTask->qPrivate.notification > (qNotifier_t)0u ) {
                _qTrace_Kernel( "(<)Event {byNotificationSimple} detected on task ",
                                xTask,
                                NULL );
                xTask->qPrivate.trigger = byNotificationSimple;
                xReady = qTrue;
            }
            #if ( Q_TASK_EVENT_FLAGS == 1 )
            else if ( 0uL != ( QTASK_EVENT_FLAGS_MASK & xTask->qPrivate.flags ) ) {
                _qTrace_Kernel( "(<)Event {byEventFlags} detected on task ",
                                xTask,
                                NULL );
                xTask->qPrivate.trigger = byEventFlags;
                xReady = qTrue;
            }
            #endif
            else {
                xTask->qPrivate.trigger = qTriggerNULL;
                /*task has no available events, put it into a suspended state*/
            }
        }
        (void)qList_Remove( waitingList, NULL, QLIST_AT_FRONT );
        /*check if the task has a removal request*/
        if ( qOS_Get_TaskFlag( xTask, QTASK_BIT_REMOVE_REQUEST ) ) {
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

            if ( qTriggerNULL != xTask->qPrivate.trigger ) {
                xList = &readyList[ xTask->qPrivate.priority ];
                _qTrace_Kernel( "(*)Moving to ready-list task ", xTask, NULL );
            }
            else {
                xList = suspendedList;
            }
            (void)qList_Insert( xList, xTask, QLIST_AT_BACK );
        }
    }

    #if ( Q_NOTIFICATION_SPREADER == 1 )
        /*spread operation done, clean-up*/
        kernel.nSpreader.mode = NULL;
        kernel.nSpreader.eventData = NULL;
    #endif

    return xReady;
}
/*============================================================================*/
static void qOS_Dispatch_xTask_FillEventInfo( qTask_t *Task )
{
    qTrigger_t xEvent;
    qIteration_t taskIteration;

    xEvent = Task->qPrivate.trigger;
    /*
    take the necessary actions before dispatching, depending on the event that
    triggered the task
    */
    switch ( xEvent ) {
        case byTimeElapsed:
            /*handle the iteration value and the FirstIteration flag*/
            taskIteration = Task->qPrivate.iterations;
            eventInfo->FirstIteration = ( ( qPeriodic != taskIteration )
                                                && ( taskIteration < 0 ) );
            Task->qPrivate.iterations = ( eventInfo->FirstIteration ) ?
                                        -Task->qPrivate.iterations :
                                        Task->qPrivate.iterations;
            if ( qPeriodic != Task->qPrivate.iterations ) {
                --Task->qPrivate.iterations;
            }
            eventInfo->LastIteration = ( 0 == Task->qPrivate.iterations );
            if ( eventInfo->LastIteration ) {
                /*When iteration value is reached, the task will be disabled*/
                qOS_Set_TaskFlags( Task, QTASK_BIT_ENABLED, qFalse );
            }
            eventInfo->StartDelay = qClock_GetTick() - Task->qPrivate.timer.tStart;
            break;
        case byNotificationSimple:
            /*Transfer async-data to the eventInfo structure*/
            eventInfo->EventData = Task->qPrivate.asyncData;
            --Task->qPrivate.notification;
            break;
        #if ( Q_QUEUES == 1 )
            case byQueueReceiver:
                /*the EventData will point to the queue front-data*/
                eventInfo->EventData = qQueue_Peek( Task->qPrivate.aQueue );
                break;
            case byQueueFull: case byQueueCount: case byQueueEmpty: // skipcq: CXX-C1001
                /*the EventData will point to the the linked queue*/
                eventInfo->EventData = (void*)Task->qPrivate.aQueue;
                break;
        #endif
        #if ( Q_PRIO_QUEUE_SIZE > 0 )
            case byNotificationQueued:
                /*get the extracted data from queue*/
                eventInfo->EventData = kernel.queueData;
                kernel.queueData = NULL;
                break;
        #endif
        #if ( Q_TASK_EVENT_FLAGS == 1 )
            case byEventFlags:
                break;
        #endif
            default: break;
    }
    /*Fill the event info structure: Trigger, FirstCall and TaskData */
    eventInfo->Trigger = Task->qPrivate.trigger;
    eventInfo->FirstCall = qFalse == qOS_Get_TaskFlag( Task, QTASK_BIT_INIT );
    eventInfo->TaskData = Task->qPrivate.taskData;
    kernel.currentTask = Task; /*needed for qTask_Self()*/
}
/*============================================================================*/
static void qOS_DispatchTasks( qList_t *xList )
{
    qList_Iterator_t i;
    qTaskFcn_t taskActivities;
    /*cstat -MISRAC2012-Rule-14.2*/
    for ( i = qList_Begin( xList) ; qListIterator_Until( &i, NULL ) ; qListIterator_Forward( &i ) ) {
    /*cstat +MISRAC2012-Rule-14.2*/
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        /*cppcheck-suppress misra-c2012-11.5 */
        qTask_t *xTask = (qTask_t*)qListIterator_Get( &i );
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        qOS_Dispatch_xTask_FillEventInfo( xTask );
        taskActivities = xTask->qPrivate.callback;
        #if ( Q_ALLOW_YIELD_TO_TASK == 1 )
            kernel.yieldTask = NULL;
        #endif
        if ( NULL != taskActivities ) {
            _qTrace_Kernel( "(^)Dispatching task ", xTask, NULL );
            taskActivities( eventInfo );
        }
        #if ( Q_ALLOW_YIELD_TO_TASK == 1 )
            while ( NULL != kernel.yieldTask ) {
                kernel.currentTask = kernel.yieldTask;
                taskActivities = kernel.currentTask->qPrivate.callback;
                kernel.yieldTask = NULL;
                if ( NULL != taskActivities ) {
                    _qTrace_Kernel( "(^)Control yielded to task ",
                                    kernel.currentTask,
                                    NULL );
                    /*yielded task inherits eventData*/
                    taskActivities( eventInfo );
                }
            }
        #endif
        kernel.currentTask = NULL;
        /*remove the task from the ready-list*/
        (void)qList_Remove( xList, NULL, QLIST_AT_FRONT );
        /*and insert the task back to the waiting-list*/
        (void)qList_Insert( waitingList, xTask, QLIST_AT_BACK );
        #if ( Q_QUEUES == 1 )
            if ( byQueueReceiver == xTask->qPrivate.trigger ) {
                /*remove the data from the attached Queue*/
                (void)qQueue_RemoveFront( xTask->qPrivate.aQueue );
            }
        #endif
        /*set the init flag*/
        qOS_Set_TaskFlags( xTask, QTASK_BIT_INIT, qTrue );
        eventInfo->FirstIteration = qFalse;
        eventInfo->LastIteration = qFalse;
        eventInfo->StartDelay = (qClock_t)0uL;
        eventInfo->EventData = NULL; /*clear the eventData*/
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            ++xTask->qPrivate.cycles; /*increase the task-cycles value*/
        #endif
        xTask->qPrivate.trigger = qTriggerNULL;
    }
}
/*============================================================================*/
static void qOS_DispatchIdleTask( void )
{
    qTaskFcn_t taskActivities = kernel.idleCallback;
    eventInfo->FirstCall = ( qFalse == QKERNEL_CORE_FLAG_GET( kernel.flag, QKERNEL_BIT_FCALL_IDLE ) );
    eventInfo->TaskData = NULL;
    eventInfo->Trigger = byNoReadyTasks;
    /*some compilers can not deal with function pointers inside structs*/
    taskActivities( eventInfo ); /*run the idle callback*/
    QKERNEL_CORE_FLAG_SET( kernel.flag, QKERNEL_BIT_FCALL_IDLE );
}
/*============================================================================*/
static qBool_t qOS_TaskDeadLineReached( qTask_t * const Task )
{
    qBool_t retValue = qFalse;

    if ( qOS_Get_TaskFlag( Task, QTASK_BIT_ENABLED ) ) {
        qIteration_t iters = Task->qPrivate.iterations;
        /*task should be periodic or must have available iters*/
        if ( ( QTASK_ITER_VALUE( iters ) > 0 ) || ( qPeriodic == iters ) ) {
            qClock_t interval = Task->qPrivate.timer.tv;
            qBool_t deadLineReached;

            deadLineReached = qSTimer_Expired( &Task->qPrivate.timer );
            /*check the time deadline*/
            if ( ( 0uL == interval ) || deadLineReached ) {
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
        /*cppcheck-suppress misra-c2012-11.5 */
        const qList_t *xList = (const qList_t *)Task->qPrivate.container; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        if ( kernel.currentTask == Task ) {
            retValue = qRunning;
        }
        else if ( waitingList == xList ) {
            retValue = qWaiting;
        }
        else if ( suspendedList == xList ) {
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

    xBit = Task->qPrivate.flags & flag;

    return ( ( 0uL != xBit ) ? qTrue : qFalse );
}
/*========================== Shared Private Method ===========================*/
void qOS_Set_TaskFlags( qTask_t * const Task,
                        const qUINT32_t flags,
                        const qBool_t value )
{
    if ( qTrue == value ) {
        qFLM_BitsSet( Task->qPrivate.flags, flags );
    }
    else {
        qFLM_BitsClear( Task->qPrivate.flags, flags );
    }
}
/*============================================================================*/
#if ( Q_ALLOW_TASK_NAMING == 1 )
/*cstat -MISRAC2012-Rule-8.13*/
static qBool_t qOS_TaskNameLookup( qList_ForEachHandle_t h )
{
    /*cstat +MISRAC2012-Rule-8.13*/
    qBool_t retValue = qFalse;

    if ( qList_WalkThrough == h->stage ) {
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        void **xLookupData = (void**)h->arg;
        /*cppcheck-suppress misra-c2012-11.5 */
        const char *name = (const char*)xLookupData[ 0 ];
        /*cppcheck-suppress misra-c2012-11.5 */
        qTask_t *xTask = (qTask_t*)h->node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */

        if ( NULL != xTask->qPrivate.name ) {
            /*cstat -CERT-STR32-C */
            if ( 0 == strncmp( name, xTask->qPrivate.name, 32u ) ) {
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
    /*cstat -MISRAC2012-Rule-8.13*/
    qTask_t *found = NULL;
    /*cstat +MISRAC2012-Rule-8.13*/
    if ( NULL != name ) {
        const void *xLookupData[ 2 ] = { (const void*)name, NULL };
        const size_t maxLists = qFLM_ArraySize( kernel.coreLists );
        size_t i;

        for ( i = 0u ; i < maxLists ; ++i ) {
            qBool_t r;
            /*cppcheck-suppress cert-EXP05-C */
            r = qList_ForEach( &kernel.coreLists[ i ],
                               qOS_TaskNameLookup,
                               &xLookupData,
                               QLIST_FORWARD,
                               NULL );
            if ( qTrue == r ) {
                /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b -MISRAC2012-Rule-11.8*/
                /*cppcheck-suppress [cert-EXP05-C, misra-c2012-11.5] */
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
/*cstat -MISRAC2012-Rule-8.13*/
qBool_t qOS_YieldToTask( qTask_t * const Task )
{
    /*cstat +MISRAC2012-Rule-8.13*/
    qBool_t retValue = qFalse;
    if ( ( NULL != kernel.currentTask ) && ( Task != kernel.currentTask ) ) {
        kernel.yieldTask = Task;
        retValue = qTrue;
    }
    return retValue;
}
/*============================================================================*/
#endif
