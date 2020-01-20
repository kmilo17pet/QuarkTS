#include "qkernel.h"

#define __QKERNEL_BIT_INIT          ( 0x00000001uL )  
#define __QKERNEL_BIT_FCALLIDLE     ( 0x00000002uL )
#define __QKERNEL_BIT_RELEASESCHED  ( 0x00000004uL )
#define __QKERNEL_BIT_FCALLRELEASED ( 0x00000008uL )

#define __QKERNEL_COREFLAG_SET(FLAG, BIT)       ( FLAG ) |= (  BIT )     
#define __QKERNEL_COREFLAG_CLEAR(FLAG, BIT)     ( FLAG ) &= ( ~BIT ) 
#define __QKERNEL_COREFLAG_GET(FLAG, BIT)       ( ( 0uL != (( FLAG ) & ( BIT )) )? qTrue : qFalse )

/*an item of the priority-queue*/
typedef struct{
    qTask_t *Task;      /*< A pointer to the task. */
    void *QueueData;    /*< The data to queue. */
}qQueueStack_t;  

typedef qUINT32_t qCoreFlags_t;

typedef struct{
    qTaskNotifyMode_t mode;
    void *eventdata;
}qNotificationSpreader_t;

typedef struct{ /*KCB(Kernel Control Block) definition*/
    qList_t CoreLists[ Q_PRIORITY_LEVELS + 2 ];
    qTaskFcn_t IDLECallback;                            /*< The callback function that represents the idle-task activities. */
    qTask_t *CurrentRunningTask;                        /*< Points to the current running task. */    
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        qTaskFcn_t ReleaseSchedCallback;                /*< The callback function for the scheduler release action. */
    #endif    
    #if ( Q_PRIO_QUEUE_SIZE > 0 ) 
        void *QueueData;                                /*< The FIFO priority queue item-data. */
        qQueueStack_t QueueStack[ Q_PRIO_QUEUE_SIZE ];  /*< Points to the storage area of the FIFO priority queue. */
        volatile qBase_t QueueIndex;                    /*< The current index of the FIFO priority queue. */
    #endif 
    _qEvent_t_ EventInfo;                               /*< Used to hold the event info for a task that will be changed to the qRunning state.*/
    volatile qCoreFlags_t Flag;                         /*< The scheduler Core-Flags. */
    #if ( Q_NOTIFICATION_SPREADER == 1 )
        qNotificationSpreader_t NotificationSpreadRequest;
    #endif
    #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
        size_t TaskEntries;
    #endif
}qKernelControlBlock_t;

/*=========================== Kernel Control Block ===========================*/
static qKernelControlBlock_t kernel;
static qList_t *WaitingList = &kernel.CoreLists[ Q_PRIORITY_LEVELS ];
static qList_t *SuspendedList = &kernel.CoreLists[ Q_PRIORITY_LEVELS + 1 ];
static qList_t *ReadyList = &kernel.CoreLists[ 0 ];

/*=============================== Private Methods ============================*/
static qBool_t _qScheduler_TaskDeadLineReached( qTask_t * const task);
static qBool_t qOS_CheckIfReady( void *node, void *arg, qList_WalkStage_t stage );
static qBool_t qOS_Dispatch( void *node, void *arg, qList_WalkStage_t stage );    

#define _qAbs( x )    ((((x)<0) && ((x)!=qPeriodic))? -(x) : (x))

#if ( Q_PRIO_QUEUE_SIZE > 0 )  
    static void _qScheduler_PriorityQueue_ClearIndex( qIndex_t IndexToClear );
    static void _qScheduler_PriorityQueue_CleanUp( const qTask_t * task );
    static qTask_t* _qScheduler_PriorityQueueGet( void );
#endif

#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
    static void _qTriggerReleaseSchedEvent( void );
#endif

#if ( Q_QUEUES == 1)
    static qTrigger_t _qScheduler_CheckQueueEvents( const qTask_t * const Task );
#endif

#if ( Q_ATCOMMAND_PARSER == 1)
    static void qScheduler_ATParserTaskCallback( qEvent_t  e );
    static void qScheduler_ATParserNotifyFcn(struct _qATParser_s * const Parser);
#endif

#if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
static qBool_t _qOS_EntryOrderPreserver(const void *n1, const void *n2);
#endif

/*========================== QuarkTS Private Macros ==========================*/
#define __qChainInitializer     ((qTask_t*)&kernel)/*point to something that is not some task in the chain */
void __qFSMCallbackMode( qEvent_t e ){}
/*============================================================================*/
/*void qSchedulerSetup(const qGetTickFcn_t TickProviderFcn,  qTime_t ISRTick, qTaskFcn_t IDLE_Callback)
        
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
#if (Q_SETUP_TIME_CANONICAL == 1)
    void qSchedulerSetup( const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback ){
#else
    void qSchedulerSetup( const qGetTickFcn_t TickProvider, const qTimingBase_type BaseTimming, qTaskFcn_t IdleCallback ){
#endif
    qIndex_t i;
    qList_Initialize( SuspendedList );
    qList_Initialize( WaitingList );
    for( i = (qIndex_t)0; i< (qIndex_t)Q_PRIORITY_LEVELS; i++ ){
        qList_Initialize( &ReadyList[ i ] );
    }
    #if ( Q_SETUP_TIME_CANONICAL != 1 )
        qClock_SetTimeBase( BaseTimming );
    #endif
    kernel.IDLECallback = IdleCallback;
    #if ( Q_PRIO_QUEUE_SIZE > 0 )    
        for( i = 0u ; i < (qIndex_t)Q_PRIO_QUEUE_SIZE ; i++){
            kernel.QueueStack[i].Task = NULL;  /*set the priority queue as empty*/  
        }
        kernel.QueueIndex = -1;     
        kernel.QueueData = NULL;
    #endif
    #if ( Q_NOTIFICATION_SPREADER == 1 )
        kernel.NotificationSpreadRequest.mode = NULL;
        kernel.NotificationSpreadRequest.eventdata = NULL;
    #endif    
    kernel.Flag = 0uL; /*clear all the core flags*/
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        kernel.ReleaseSchedCallback = NULL;
    #endif
    #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
        kernel.TaskEntries = (size_t)0;
    #endif
    kernel.CurrentRunningTask = NULL;
    qClock_SetTickProvider( TickProvider );
}
/*============================================================================*/
/*qTask_t* qScheduler_GetTaskRunning(void)

Get current running task handle.

Return value:

    A pointer to the current running task.
    NULL when the scheduler it's in a busy state or when IDLE Task is running.
*/
qTask_t* _qScheduler_GetTaskRunning( void ){
    return kernel.CurrentRunningTask; /*get the handle of the current running task*/
}
/*============================================================================*/
/*void qSchedulerSetIdleTask(qTaskFcn_t Callback)

Establish the IDLE Task Callback

Parameters:

    - IDLE_Callback : A pointer to a void callback method with a qEvent_t 
                      parameter as input argument.
*/
void qSchedulerSetIdleTask( qTaskFcn_t Callback ){
    kernel.IDLECallback = Callback;
}
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
/*============================================================================*/
/*void qSchedulerRelease(void)

Disables the kernel scheduling. The main thread will continue after the
qSchedule() call.
*/
void qSchedulerRelease( void ){
    __QKERNEL_COREFLAG_SET( kernel.Flag, __QKERNEL_BIT_RELEASESCHED );
}
/*============================================================================*/
/*void qSchedulerSetReleaseCallback(qTaskFcn_t Callback)

Set/Change the scheduler release callback function

Parameters:

    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
void qSchedulerSetReleaseCallback( qTaskFcn_t Callback ){
    kernel.ReleaseSchedCallback = Callback;
}
#endif /* #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 ) */
/*============================================================================*/
/*qBool_t qSchedulerSpreadNotification( const void *eventdata, const qTaskNotifyMode_t mode)

Try to spread a notification among all the tasks in the scheduling scheme
Note: Operation will be performed in the next scheduling cycle. 

Parameters:

    - eventdata : Specific event user-data.
    - mode : the method used to spread the event:
              Q_NOTIFY_SIMPLE or Q_NOTIFY_QUEUED.

Return value:

    qTrue if success. Otherwise qFalse.              
*/ 
/*============================================================================*/
qBool_t qSchedulerSpreadNotification( void *eventdata, const qTaskNotifyMode_t mode ){
    qBool_t RetValue = qFalse;
    #if ( Q_NOTIFICATION_SPREADER == 1 )
        if( ( mode ==  Q_NOTIFY_SIMPLE ) || ( mode == Q_NOTIFY_QUEUED ) ){
            kernel.NotificationSpreadRequest.mode = mode;
            kernel.NotificationSpreadRequest.eventdata = eventdata;
            RetValue = qTrue;
        }
    #endif
    return RetValue;    
}
/*============================================================================*/
#if ( Q_PRIO_QUEUE_SIZE > 0 )  
static void _qScheduler_PriorityQueue_CleanUp( const qTask_t * task ){
    qIndex_t i;
    for( i = 1u ; ( i < (qIndex_t)Q_PRIO_QUEUE_SIZE ) ; i++){ 
        if( kernel.QueueStack[ i ].Task == task ){
            _qScheduler_PriorityQueue_ClearIndex( i );
        }
    }
}
/*============================================================================*/
static void _qScheduler_PriorityQueue_ClearIndex( qIndex_t IndexToClear ){
    qIndex_t j;
    qBase_t QueueIndex;

    kernel.QueueStack[IndexToClear].Task = NULL; /*set the position in the queue as empty*/  
    QueueIndex = (qBase_t)kernel.QueueIndex; /*to avoid side effects*/
    for( j = IndexToClear ; (qBase_t)j < QueueIndex ; j++){ 
        kernel.QueueStack[j] = kernel.QueueStack[ j + (qIndex_t)1 ]; /*shift the remaining items of the queue*/
    }
    kernel.QueueIndex--;    /*decrease the index*/    
}
/*============================================================================*/
qBool_t _qScheduler_PriorityQueue_Insert(qTask_t * const Task, void *data){
    #if ( Q_PRIO_QUEUE_SIZE > 0 )  
        qBool_t RetValue = qFalse;
        qQueueStack_t tmp;
        qBase_t QueueMaxIndex;
        qBase_t CurrentQueueIndex;
        QueueMaxIndex = Q_PRIO_QUEUE_SIZE - 1; /*to avoid side effects */
        CurrentQueueIndex = kernel.QueueIndex; /*to avoid side effects */
        if( ( NULL != Task )  && ( CurrentQueueIndex < QueueMaxIndex) ) {/*check if data can be queued*/
            tmp.QueueData = data;
            tmp.Task = Task;
            kernel.QueueStack[ ++kernel.QueueIndex ] = tmp; /*insert task and the corresponding eventdata to the queue*/
            RetValue = qTrue;
        }
        return RetValue;
    #else
        return qFalse;
    #endif   
}
/*============================================================================*/
qBool_t _qScheduler_PriorityQueue_IsTaskInside( const qTask_t * const Task ){
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        qBool_t RetValue = qFalse;
        qBase_t CurrentQueueIndex, i;
        CurrentQueueIndex = kernel.QueueIndex + 1;
        if( CurrentQueueIndex > 0 ){
            qCritical_Enter();
            for( i = 0 ; i < CurrentQueueIndex; i++ ){
                if( Task == kernel.QueueStack[i].Task ){
                    RetValue = qTrue;
                    break;
                }
            }
            qCritical_Exit();
        }
        return RetValue;
    #else
        return qFalse;
    #endif   
}
/*============================================================================*/
static qTask_t* _qScheduler_PriorityQueueGet( void ){
    qTask_t *xTask = NULL;
    qIndex_t i;
    qIndex_t IndexTaskToExtract = 0u;
    qPriority_t MaxPriorityValue;
    
    if( kernel.QueueIndex >= 0 ){ /*queue has elements*/
        qCritical_Enter(); 
        MaxPriorityValue = kernel.QueueStack[0].Task->qPrivate.Priority;
        for( i = 1u ; ( i < (qIndex_t)Q_PRIO_QUEUE_SIZE ) ; i++){  /*walk through the queue to find the task with the highest priority*/
            if( NULL == kernel.QueueStack[i].Task ){ /* tail is reached */
                break;
            }
            if( kernel.QueueStack[i].Task->qPrivate.Priority > MaxPriorityValue ){ /*check if the queued task has the max priority value*/
                MaxPriorityValue = kernel.QueueStack[i].Task->qPrivate.Priority; /*Reassign the max value*/
                IndexTaskToExtract = i;  /*save the index*/
            }
        }   
        kernel.QueueData = kernel.QueueStack[IndexTaskToExtract].QueueData; /*get the data from the queue*/
        xTask = kernel.QueueStack[IndexTaskToExtract].Task; /*assign the task to the output*/
        _qScheduler_PriorityQueue_ClearIndex( IndexTaskToExtract );
        qCritical_Exit();
    }
    return xTask;
}
/*============================================================================*/
size_t qOS_Get_PriorityQueueCount( void ){
    if( kernel.QueueIndex >= 0 ){ 
        return (size_t)kernel.QueueIndex + (size_t)1;
    }
    else{
        return 0;
    }
}
/*============================================================================*/
#endif /* #if ( Q_PRIORITY_QUEUE == 1 ) */
/*============================================================================*/
/*qBool_t qSchedulerAdd_Task(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg)

Add a task to the scheduling scheme. The task is scheduled to run every <Time> 
seconds, <nExecutions> times and executing <CallbackFcn> method on every pass.

Parameters:
    - Task : A pointer to the task node.
    - CallbackFcn : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
    - Priority : Task priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
    - Time : Execution interval defined in seconds (floating-point format). 
               For immediate execution (tValue = qTimeImmediate).
    - nExecutions : Number of task executions (Integer value). For indefinite 
               execution (nExecutions = qPeriodic or qIndefinite). Tasks do not 
               remember the number of iteration set initially. After the 
               iterations are done, internal iteration counter is 0. To perform 
               another set of iterations, set the number of iterations again.
                >Note 1: Tasks which performed all their iterations put their own 
                        state to qDisabled.
                >Note 2: Asynchronous triggers do not affect the iteration counter.
    - InitialState : Specifies the initial operational state of the task 
                    (qEnabled, qDisabled, qASleep or qAwake(implies qEnabled)).
    - arg : Represents the task arguments. All arguments must be passed by
            reference and cast to (void *). Only one argument is allowed, 
            so, for multiple arguments, create a structure that contains 
            all of the arguments and pass a pointer to that structure.

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qSchedulerAdd_Task( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg ){
    qBool_t RetValue = qFalse;
    if( ( NULL != Task ) ) {
        Task->qPrivate.Callback = CallbackFcn;
        (void)qSTimerSet( &Task->qPrivate.timer, Time );/*Task->qPrivate.Interval = qTime2Clock( Time );*/
        Task->qPrivate.TaskData = arg;
        Task->qPrivate.Priority = ( Priority > ((qPriority_t)Q_PRIORITY_LEVELS - (qPriority_t)1u) )? 
                                  ( (qPriority_t)Q_PRIORITY_LEVELS - (qPriority_t)1u ) : 
                                  Priority;
        Task->qPrivate.Iterations = ( qPeriodic == nExecutions )? qPeriodic : -nExecutions;    
        Task->qPrivate.Notification = 0uL;
        Task->qPrivate.Trigger = qTriggerNULL;
        __qPrivate_TaskModifyFlags( Task,
                                 __QTASK_BIT_INIT | __QTASK_BIT_QUEUE_RECEIVER | 
                                 __QTASK_BIT_QUEUE_FULL | __QTASK_BIT_QUEUE_COUNT | 
                                 __QTASK_BIT_QUEUE_EMPTY | __QTASK_BIT_REMOVE_REQUEST, 
                                 qFalse);
        __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_SHUTDOWN | __QTASK_BIT_ENABLED, qTrue );  /*task will be awaken and enabled*/ 
        qTaskSetState( Task, InitialState );

        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->qPrivate.Cycles = 0uL;
        #endif
        #if ( Q_QUEUES == 1)
            Task->qPrivate.Queue = NULL;
        #endif
        #if ( Q_FSM == 1)
            Task->qPrivate.StateMachine = NULL;
        #endif
        #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
            Task->qPrivate.Entry = kernel.TaskEntries++;
        #endif
        RetValue = qList_Insert( WaitingList, Task, qList_AtBack ); 
    }
    return RetValue;  
}
/*============================================================================*/
/*qBool_t qSchedulerAdd_EventTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg)

Add a task to the scheduling scheme.  This API creates a task with qDisabled 
state by default , so this task will be oriented to be executed only, when 
asynchronous events occurs. However, this behavior can be changed in execution
time using qTaskSetTime or qTaskSetIterations.

Parameters:

    - Task : A pointer to the task node.
    - CallbackFcn : A pointer to a void callback method with a qEvent_t parameter
                 as input argument.
    - Priority : Task priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
    - arg :      Represents the task arguments. All arguments must be passed by
                 reference and cast to (void *). Only one argument is allowed, 
                 so, for multiple arguments, create a structure that contains 
                 all of the arguments and pass a pointer to that structure.
     
Return value:

    Returns qTrue on success, otherwise returns qFalse;
     */
qBool_t qSchedulerAdd_EventTask( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg ){
    return qSchedulerAdd_Task( Task, CallbackFcn, Priority, qTimeImmediate, qSingleShot, qDisabled, arg );
}
/*============================================================================*/
#if ( Q_FSM == 1)
/*qBool_t qSchedulerAdd_StateMachineTask(qTask_t *Task, qPriority_t Priority, qTime_t Time,
                         qSM_t *StateMachine, qSM_State_t InitState, 
                         qSM_ExState_t BeforeAnyState, qSM_ExState_t SuccessState,
                         qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState,
                         qState_t InitialTaskState, void *arg)

Add a task to the scheduling scheme running a dedicated state-machine. 
The task is scheduled to run every <Time> seconds in qPeriodic mode. The event info
will be available as a generic pointer inside the <Data> field of the qSM_t pointer
passed as input argument inside every state.

Parameters:
    - Task : A pointer to the task node.
    - Priority : Task priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
    - Time : Execution interval defined in seconds (floating-point format). 
               For immediate execution (tValue = qTimeImmediate).
    - StateMachine: A pointer to the Finite State-Machine (FSM) object
    - InitState : The first state to be performed. This argument is a pointer 
                  to a callback function, returning qSM_Status_t and with a 
                  qSM_t pointer as input argument.
    - BeforeAnyState : A state called before the normal state machine execution.
                  This argument is a pointer to a callback function,  with a 
                  qSM_t pointer as input argument.
    - SuccessState : State performed after the current state finish with return status 
                     qSM_EXIT_SUCCESS. This argument is a pointer to a callback
                     function with a qSM_t pointer as input argument.
    - FailureState : State performed after the current state finish with return status 
                     qSM_EXIT_FAILURE. This argument is a pointer to a callback
                     function with a qSM_t pointer as input argument.
    - UnexpectedState : State performed after the current state finish with return status
                        value between -32766 and 32767. This argument is a 
                        pointer to a callback function with a qSM_t pointer
                        as input argument.
    - InitialTaskState : Specifies the initial operational state of the task 
                        (qEnabled, qDisabled, qASleep, qAwake).
    - arg : Represents the task arguments. All arguments must be passed by
                     reference and cast to (void *). Only one argument is allowed, 
                     so, for multiple arguments, create a structure that contains 
                     all of the arguments and pass a pointer to that structure.
 
Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qSchedulerAdd_StateMachineTask( qTask_t * const Task, qPriority_t Priority, qTime_t Time,
                            qSM_t * const StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg ){
    qBool_t RetValue = qFalse;
    if( ( NULL != StateMachine ) && ( NULL != InitState ) ){
        if ( qTrue == qSchedulerAdd_Task( Task, __qFSMCallbackMode, Priority, Time, qPeriodic, InitialTaskState, arg ) ){
            RetValue = qStateMachine_Init( StateMachine, InitState, SuccessState, FailureState, UnexpectedState, BeforeAnyState );
            Task->qPrivate.StateMachine = StateMachine;
            StateMachine->qPrivate.Owner = Task;
        }
    }
    return RetValue;
}
/*============================================================================*/
/* qBool_t qScheduler_StateMachineTask_AttachTranstitionQueue( qTask_t * const Task )

Improve the state-machine-task responsiveness by connecting the incoming signals 
from a transition-table to the task's event flow.

Parameters:
    - Task : A pointer to the task node.

Return value :

    Returns qTrue on success, otherwise returns qFalse;

*/ 
qBool_t qScheduler_StateMachineTask_SignalConnect( qTask_t * const Task ){
    qBool_t RetValue = qFalse;
    qSM_t *StateMachine;
    qSM_TransitionTable_t *tTableFSM;
    if( NULL != Task){
        StateMachine = Task->qPrivate.StateMachine;
        if( NULL != StateMachine ){
            tTableFSM = (qSM_TransitionTable_t*)StateMachine->qPrivate.TransitionTable; /*MISRAC2012-Rule-11.5 deviation allowed*/
            if( NULL != tTableFSM ){
                RetValue = qTaskAttachQueue( Task, &tTableFSM->SignalQueue, qQUEUE_COUNT, 1u ); 
            }
        }
    }
    return RetValue;
}
#endif /* #if ( Q_FSM == 1) */
/*============================================================================*/
#if ( Q_ATCOMMAND_PARSER == 1 )
/*qBool_t qSchedulerAdd_ATParserTask(qTask_t *Task, qATParser_t *Parser, qPriority_t Priority)

Add a task to the scheduling scheme running an AT Command Parser. Task will be scheduled
as an event-triggered task. The parser address will be stored in the TaskData storage-Pointer.

Parameters:

    - Task : A pointer to the task node.
    - Parser: A pointer to the AT Command Parser
    - Priority : Task priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qSchedulerAdd_ATParserTask( qTask_t * const Task, qATParser_t *Parser, qPriority_t Priority ){    
    qBool_t RetValue = qFalse;
    if( NULL != Parser ){
        Parser->UserData = Task;
        Parser->qPrivate.xNotifyFcn = &qScheduler_ATParserNotifyFcn;
        RetValue =  qSchedulerAdd_Task( Task, qScheduler_ATParserTaskCallback, Priority, qTimeImmediate, qSingleShot, qDisabled, Parser );
    }
    return RetValue;
}
/*============================================================================*/
static void qScheduler_ATParserTaskCallback( qEvent_t  e ){ /*wrapper for the task callback */
    (void)qATParser_Run( (qATParser_t*)e->TaskData ); /* MISRAC2012-Rule-11.5 deviation allowed */
}
/*============================================================================*/
static void qScheduler_ATParserNotifyFcn(struct _qATParser_s * const Parser){
    qTask_t *Task;
    Task = (qTask_t *)Parser->UserData; /* MISRAC2012-Rule-11.5 deviation allowed */
    (void)qTaskSendNotification( Task, NULL );
}
#endif /* #if ( Q_ATCOMMAND_PARSER == 1) */
/*============================================================================*/
/*qBool_t qSchedulerRemoveTask(qTask_t *Task)

Remove the task from the scheduling scheme.

Parameters:

    - Task : A pointer to the task node.
     
Return value:

    Returns qTrue if success, otherwise returns qFalse.;     
    */
qBool_t qSchedulerRemoveTask( qTask_t * const Task ){
    qBool_t RetValue = qFalse;
    if( NULL != Task ){
        __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_REMOVE_REQUEST, qTrue );
        RetValue = qTrue;
    }
    return RetValue;
}
#if ( Q_QUEUES == 1)
/*============================================================================*/
static qTrigger_t _qScheduler_CheckQueueEvents( const qTask_t * const Task ){
    qTrigger_t RetValue = qTriggerNULL;
    qBool_t FullFlag, CountFlag, ReceiverFlag, EmptyFlag;
    qBool_t IsFull, IsEmpty;
    size_t CurrentQueueCount;

    if( NULL != Task->qPrivate.Queue){
        FullFlag = __qPrivate_TaskGetFlag( Task, __QTASK_BIT_QUEUE_FULL );
        CountFlag = __qPrivate_TaskGetFlag( Task, __QTASK_BIT_QUEUE_COUNT );
        ReceiverFlag = __qPrivate_TaskGetFlag( Task, __QTASK_BIT_QUEUE_RECEIVER );
        EmptyFlag = __qPrivate_TaskGetFlag( Task, __QTASK_BIT_QUEUE_EMPTY );
        
        CurrentQueueCount = qQueueCount( Task->qPrivate.Queue ); /*to avoid side effects*/
        IsFull = qQueueIsFull( Task->qPrivate.Queue ); /*to avoid side effects*/
        IsEmpty = qQueueIsEmpty( Task->qPrivate.Queue ); /*to avoid side effects*/
        /*check the queue events in the corresponding precedence order*/
        if( FullFlag && IsFull ){        
            RetValue =  byQueueFull;
        }
        else if( ( CountFlag ) && ( CurrentQueueCount >= Task->qPrivate.QueueCount ) ){
            RetValue =  byQueueCount;
        }
        else if( ReceiverFlag && ( CurrentQueueCount > 0u ) ){    
            RetValue = byQueueReceiver; 
        }
        else if( EmptyFlag && IsEmpty ){
            RetValue =  byQueueEmpty;
        }
        else{
            /*nothing to do*/
        }
    }
    
    return RetValue;
}
#endif
/*============================================================================*/
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
static void _qTriggerReleaseSchedEvent( void ){
    qTaskFcn_t Callback;

    __QKERNEL_COREFLAG_CLEAR( kernel.Flag, __QKERNEL_BIT_INIT ); 
    __QKERNEL_COREFLAG_CLEAR( kernel.Flag, __QKERNEL_BIT_RELEASESCHED );  
    kernel.EventInfo.FirstCall = ( qFalse == __QKERNEL_COREFLAG_GET( kernel.Flag, __QKERNEL_BIT_FCALLRELEASED ) )? qTrue : qFalse;    
    kernel.EventInfo.Trigger = bySchedulingRelease;
    kernel.EventInfo.TaskData = NULL;
    if( NULL != kernel.ReleaseSchedCallback ){
        Callback = kernel.ReleaseSchedCallback;
        Callback( &kernel.EventInfo ); /*some compilers cant deal with function pointers inside structs*/
    }    
    __QKERNEL_COREFLAG_SET( kernel.Flag, __QKERNEL_BIT_FCALLIDLE ); /*MISRAC2012-Rule-11.3 allowed*/
}
#endif
/*============================================================================*/
/*void qSchedulerRun(void)
    
Executes the task-scheduler scheme. It must be called once after the task
pool has been defined.

  Note : qScheduleRun keeps the application in an endless loop
*/
void qSchedulerRun( void ){
    qIndex_t xPriorityListIndex; 
    qList_t *xList;

    do{           
        if( qList_ForEach( WaitingList, qOS_CheckIfReady, NULL, QLIST_FORWARD, NULL ) ){ /*check for ready tasks in the waiting list*/
            xPriorityListIndex = (qIndex_t)Q_PRIORITY_LEVELS - (qIndex_t)1;
            do{ /*loop every ready-list in descending priority order*/
                xList = &ReadyList[ xPriorityListIndex ]; /*get the target ready-list*/
                if( xList->size > (size_t)0 ){ /*check if the target list has items*/
                    (void)qList_ForEach( xList, qOS_Dispatch, xList, QLIST_FORWARD, NULL ); /*dispatch every task in this list*/
                }
            }while( (qIndex_t)0 != xPriorityListIndex-- );
        }
        else{ /*no task in the scheme is ready*/
            if( NULL != kernel.IDLECallback ){ /*check if the idle-task is available*/
                (void)qOS_Dispatch( NULL, NULL, QLIST_WALKTHROUGH );
            }
        }
        if( SuspendedList->size > (size_t)0 ){  /*check if the suspended list has items*/
            qList_Move( WaitingList, SuspendedList, qList_AtBack ); /*move the remaining suspended tasks to the waiting list*/
            #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
                qList_Sort( WaitingList, _qOS_EntryOrderPreserver );
            #endif
        }
    }
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        while( qFalse == __QKERNEL_COREFLAG_GET( kernel.Flag, __QKERNEL_BIT_RELEASESCHED ) ); /*scheduling end-point*/ 
        _qTriggerReleaseSchedEvent(); /*check for scheduling-release request*/
    #else
        while(1);
    #endif
}
/*============================================================================*/
#if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
static qBool_t _qOS_EntryOrderPreserver(const void *n1, const void *n2){
    qTask_t *t1, *t2;
    t1 = (qTask_t*)n1;
    t2 = (qTask_t*)n1;
    return (qBool_t)(t1->qPrivate.Entry > t2->qPrivate.Entry);
}
#endif
/*============================================================================*/
static qBool_t qOS_CheckIfReady( void *node, void *arg, qList_WalkStage_t stage ){
    qTask_t *xTask;
    qList_t *xList;
    qTrigger_t trg;
    static qBool_t xReady = qFalse;
    qBool_t RetValue = qFalse;

    if( QLIST_WALKINIT == stage ){
        xReady = qFalse;

        #if ( Q_PRIO_QUEUE_SIZE > 0 )  
            xTask = _qScheduler_PriorityQueueGet(); /*try to extract a task from the front of the priority queue*/
            if( NULL != xTask ){  /*if we got a task from the priority queue,*/
                xTask->qPrivate.Trigger = byNotificationQueued;
                __qPrivate_TaskModifyFlags( xTask, __QTASK_BIT_SHUTDOWN, qTrue ); /*wake-up the task!!*/
            }     
        #endif          
    }
    else if( QLIST_WALKTHROUGH == stage ){
        xTask = (qTask_t*)node; /* MISRAC2012-Rule-11.5 deviation allowed */

        #if ( Q_NOTIFICATION_SPREADER == 1 )
            if( NULL != kernel.NotificationSpreadRequest.mode ){
                kernel.NotificationSpreadRequest.mode( xTask, kernel.NotificationSpreadRequest.eventdata );
                kernel.NotificationSpreadRequest.mode = NULL;
                kernel.NotificationSpreadRequest.eventdata = NULL;
                RetValue = qTrue;
            }
        #endif


        if( __qPrivate_TaskGetFlag( xTask, __QTASK_BIT_SHUTDOWN) ){
            #if ( Q_PRIO_QUEUE_SIZE > 0 )  
            if( byNotificationQueued == xTask->qPrivate.Trigger ){
                xReady = qTrue;
            }
            else
            #endif 
            if( _qScheduler_TaskDeadLineReached( xTask ) ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
                (void)qSTimerReload( &xTask->qPrivate.timer );
                xTask->qPrivate.Trigger = byTimeElapsed;      
                xReady = qTrue;            
            }
            #if ( Q_QUEUES == 1)  
            else if( qTriggerNULL !=  ( trg = _qScheduler_CheckQueueEvents( xTask ) ) ){ /*If the deadline has not met, check if there is a queue event available*/
                xTask->qPrivate.Trigger = trg;      
                xReady = qTrue;
            }
            #endif
            else if( xTask->qPrivate.Notification > (qNotifier_t)0 ){   /*The last check will be if the task has an async event*/
                xTask->qPrivate.Trigger = byNotificationSimple;  
                xReady = qTrue;            
            }
            else if( 0uL != (QTASK_EVENTFLAGS_RMASK & xTask->qPrivate.Flags ) ){
                xTask->qPrivate.Trigger = byEventFlags;          
                xReady = qTrue;        
            }
            else{
                xTask->qPrivate.Trigger = qTriggerNULL;
                /*the task has no available events, put it in a suspended state*/        
            }
        }
        (void)qList_Remove( WaitingList, NULL, QLIST_ATFRONT ); 

        if( __qPrivate_TaskGetFlag( xTask, __QTASK_BIT_REMOVE_REQUEST) ){ /*check if the task get a removal request*/
            #if ( Q_PRIO_QUEUE_SIZE > 0 )  
                qCritical_Enter(); 
                _qScheduler_PriorityQueue_CleanUp( xTask ); /*clean any entry of this task from the priority queue */
                qCritical_Exit();
            #endif
            __qPrivate_TaskModifyFlags( xTask, __QTASK_BIT_REMOVE_REQUEST, qFalse );  /*clear the removal request*/
        }
        else{
            xList = ( qTriggerNULL != xTask->qPrivate.Trigger )? &ReadyList[ xTask->qPrivate.Priority ] : SuspendedList;
            (void)qList_Insert( xList, xTask, QLIST_ATBACK );
        }
    }
    else if( QLIST_WALKEND == stage ){ 
        RetValue = xReady;
    }
    else{
        /*this should never enter here*/
    }
    return RetValue;
}
/*============================================================================*/
static qBool_t qOS_Dispatch( void *node, void *arg, qList_WalkStage_t stage ){
    qTask_t *Task; /*#!ok*/
    qList_t *xList;
    qTrigger_t Event = byNoReadyTasks;
    qIteration_t TaskIteration;
    qTaskFcn_t TaskActivities;
 
    xList = (qList_t*)arg; /* MISRAC2012-Rule-11.5 deviation allowed */
    
    if( QLIST_WALKTHROUGH == stage ){ /*#!ok*/
        if( NULL != xList){ /*#!ok*/
            Task = (qTask_t*)node; /* MISRAC2012-Rule-11.5 deviation allowed */

            Event = Task->qPrivate.Trigger;
            switch( Event ){ /*take the necessary actions before dispatching, depending on the event that triggered the task*/
                case byTimeElapsed:
                    /*handle the iteration value and the FirstIteration flag*/
                    TaskIteration = Task->qPrivate.Iterations;
                    kernel.EventInfo.FirstIteration = ( ( TaskIteration != qPeriodic ) && ( TaskIteration < 0 ) )? qTrue : qFalse;
                    Task->qPrivate.Iterations = ( kernel.EventInfo.FirstIteration )? -Task->qPrivate.Iterations : Task->qPrivate.Iterations;
                    if( qPeriodic != Task->qPrivate.Iterations){
                        Task->qPrivate.Iterations--; /*Decrease the iteration value*/
                    }
                    kernel.EventInfo.LastIteration = (0 == Task->qPrivate.Iterations )? qTrue : qFalse; 
                    if( kernel.EventInfo.LastIteration ) {
                        __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_ENABLED, qFalse ); /*When the iteration value is reached, the task will be disabled*/ 
                    }           
                    break;
                case byNotificationSimple:
                    kernel.EventInfo.EventData = Task->qPrivate.AsyncData; /*Transfer async-data to the eventinfo structure*/
                    Task->qPrivate.Notification--; /* = qFalse */ /*Clear the async flag*/            
                    break;
                #if ( Q_QUEUES == 1)    
                    case byQueueReceiver:
                        kernel.EventInfo.EventData = qQueuePeek( Task->qPrivate.Queue ); /*the EventData will point to the RBuffer front-data*/
                        break;
                    case byQueueFull: case byQueueCount: case byQueueEmpty: 
                        kernel.EventInfo.EventData = (void*)Task->qPrivate.Queue;  /*the EventData will point to the the linked RingBuffer*/
                        break;
                #endif
                #if ( Q_PRIO_QUEUE_SIZE > 0 )  
                    case byNotificationQueued:
                        kernel.EventInfo.EventData = kernel.QueueData; /*get the extracted data from queue*/
                        kernel.QueueData = NULL;
                        break;
                #endif
                    case byEventFlags:
                        break;
                    default: break;
            }

            
            /*Fill the event info structure: Trigger, FirstCall and TaskData */       
            kernel.EventInfo.Trigger = Task->qPrivate.Trigger;
            kernel.EventInfo.FirstCall = ( qFalse == __qPrivate_TaskGetFlag( Task, __QTASK_BIT_INIT) )? qTrue : qFalse;
            kernel.EventInfo.TaskData = Task->qPrivate.TaskData;
            kernel.CurrentRunningTask = Task; /*needed for qTaskSelf()*/
            TaskActivities = Task->qPrivate.Callback;
            (void)qList_Remove( xList, NULL, qList_AtFront );
            (void)qList_Insert( WaitingList, Task, QLIST_ATBACK );  

            #if ( Q_FSM == 1)
                if ( ( NULL != Task->qPrivate.StateMachine ) && ( __qFSMCallbackMode == Task->qPrivate.Callback ) ){
                    qStateMachine_Run( Task->qPrivate.StateMachine, (void*)&kernel.EventInfo );  /*If the task has a FSM attached, just run it*/  
                }
                else if ( NULL != TaskActivities ) {
                    TaskActivities( &kernel.EventInfo ); /*else, just launch the callback function*/ 
                }       
                else{
                    /*nothing to do*/
                }
            #else
                if ( NULL != TaskActivities ) {
                    TaskActivities( &kernel.EventInfo ); /*else, just launch the callback function*/ 
                }     
            #endif
            kernel.CurrentRunningTask = NULL;
            #if ( Q_QUEUES == 1) 
                if( byQueueReceiver == Event){
                    (void)qQueueRemoveFront( Task->qPrivate.Queue );  /*remove the data from the Queue, if the event was byQueueDequeue*/
                } 
            #endif
            __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_INIT, qTrue ); /*set the init flag*/
            kernel.EventInfo.FirstIteration = qFalse;
            kernel.EventInfo.LastIteration =  qFalse; 
            kernel.EventInfo.EventData = NULL; /*clear the eventdata*/
            #if ( Q_TASK_COUNT_CYCLES == 1 )
                Task->qPrivate.Cycles++; /*increase the task cycles value*/
            #endif
            Task->qPrivate.Trigger = qTriggerNULL;
        }
        else{ /*run the idle*/
            kernel.EventInfo.FirstCall = (qFalse == __QKERNEL_COREFLAG_GET( kernel.Flag, __QKERNEL_BIT_FCALLIDLE ) )? qTrue : qFalse;
            kernel.EventInfo.TaskData = NULL;
            kernel.EventInfo.Trigger = Event;
            TaskActivities = kernel.IDLECallback; /*some compilers can deal with function pointers inside structs*/
            TaskActivities( &kernel.EventInfo ); /*run the idle callback*/ 
            __QKERNEL_COREFLAG_SET( kernel.Flag, __QKERNEL_BIT_FCALLIDLE );
        }
    }
    return qFalse;
}
/*============================================================================*/
static qBool_t _qScheduler_TaskDeadLineReached( qTask_t * const task){
    qBool_t RetValue = qFalse;
    qIteration_t TaskIterations;
    qClock_t TaskInterval;
    qBool_t DeadLineReached;

    if( __qPrivate_TaskGetFlag( task, __QTASK_BIT_ENABLED ) ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
        TaskIterations = task->qPrivate.Iterations; /*avoid side efects in the next check*/
        if( ( _qAbs( TaskIterations ) > 0 ) || ( qPeriodic == TaskIterations ) ){ /*then task should be periodic or must have available iters*/
            TaskInterval = task->qPrivate.timer.qPrivate.TV;
            DeadLineReached = qSTimerExpired( &task->qPrivate.timer );
            if( ( 0uL == TaskInterval ) || DeadLineReached ){ /*finally, check the time deadline*/
                RetValue = qTrue;                
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
qStateGlobal_t qScheduler_GetTaskGlobalState( const qTask_t * const Task){
    qStateGlobal_t RetValue = qUndefinedGlobalState;
    qList_t *xList;
    if( NULL != Task ){
        xList = Task->qPrivate.container; /* MISRAC2012-Rule-11.5 deviation allowed */
        if( kernel.CurrentRunningTask == Task ){
            RetValue = qRunning;
        }
        else if( WaitingList == xList ){
            RetValue = qWaiting;
        }
        else if( SuspendedList == xList ){
            RetValue = qSuspended;
        }
        else if( NULL == xList ){
            /*undefined*/  
        }
        else{
            RetValue = qReady;      /*by discard it must be ready*/
        }
    }
    return RetValue;
}
/*============================================================================*/