#include "qkernel.h"

typedef struct{ /*Scheduler Core-Flags*/
 	volatile qBool_t Init;                              /*< The scheduler initialization flag. */
    qBool_t FCallIdle;                                  /*< The idle first-call flag. */
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )              
        volatile qBool_t ReleaseSched, FCallReleased;   /*< The scheduler release flags*/
    #endif  
}qCoreFlags_t;

typedef struct{ /*KCB(Kernel Control Block) definition*/
    #if ( Q_PRIORITY_QUEUE == 1 )
        volatile qIndex_t QueueIndex;                   /*< The current index of the FIFO priority queue. */
        qSize_t QueueSize;                              /*< The size of the FIFO priority queue. */
        qQueueStack_t *QueueStack;                      /*< Points to the storage area of the FIFO priority queue. */
        void *QueueData;                                /*< The FIFO priority queue item-data. */
    #endif 
        qTaskFcn_t IDLECallback;                        /*< The callback function that represents the idle-task activities. */
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        qTaskFcn_t ReleaseSchedCallback;                /*< The callback function for the scheduler release action. */
    #endif
    qTask_t *Head;                                      /*< Points to the first task of the list. */
    volatile qCoreFlags_t Flag;                         /*< The scheduler Core-Flags. */
    qTask_t *CurrentRunningTask;                        /*< Points to the current running task. */
    _qEvent_t_ EventInfo;                               /*< Used to hold the event info for a task that will be changed to the qRunning state.*/
}qKernelControlBlock_t;

/*=========================== Kernel Control Block ===========================*/
static qKernelControlBlock_t kernel;
/*=============================== Private Methods ============================*/
static qTaskState_t _qScheduler_Dispatch( qTask_t * const Task, const qTrigger_t Event );
static qTask_t* _qScheduler_GetNodeFromChain( void );
static qTask_t* _qScheduler_RearrangeChain( qTask_t *head );
static qTask_t* _qScheduler_PriorizedInsert( qTask_t *head, qTask_t * const Task );
static void _qScheduler_FindPlace( qTask_t * const head, qTask_t * const Task );
static qBool_t _qScheduler_TransitionTo( qTask_t * const task, const qTaskState_t state, const qTrigger_t trg );
static qBool_t _qScheduler_TaskDeadLineReached( qTask_t * const task);
static qBool_t _qScheduler_ReadyTasksAvailable( void );

#define _qAbs( x )    ((((x)<0) && ((x)!=qPeriodic))? -(x) : (x))

#if ( Q_PRIORITY_QUEUE == 1 ) 
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
/*========================== QuarkTS Private Macros ==========================*/
#define __qChainInitializer     ((qTask_t*)&kernel)/*point to something that is not some task in the chain */
/*============================================================================*/
#if (Q_SETUP_TIME_CANONICAL == 1)
    void _qInitScheduler( const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback, qQueueStack_t *Q_Stack, const qSize_t Size_Q_Stack ){
#else
    void _qInitScheduler( const qGetTickFcn_t TickProvider, const qTimingBase_type BaseTimming, qTaskFcn_t IdleCallback, qQueueStack_t *Q_Stack, const qSize_t Size_Q_Stack ){
#endif
    #if ( Q_PRIORITY_QUEUE == 1 )  
        qUIndex_t i;
    #endif
    kernel.Head = NULL;
    #if ( Q_SETUP_TIME_CANONICAL != 1 )
        qClock_SetTimeBase( BaseTimming );
    #endif
    kernel.IDLECallback = IdleCallback;
    #if ( Q_PRIORITY_QUEUE == 1 )    
        kernel.QueueStack = (qQueueStack_t*)Q_Stack;
        kernel.QueueSize = Size_Q_Stack;
        for( i = 0u ; i < kernel.QueueSize ; i++){
            kernel.QueueStack[i].Task = NULL;  /*set the priority queue as empty*/  
        }
        kernel.QueueIndex = -1;     
        kernel.QueueData = NULL;
    #endif
    kernel.Flag.Init = qFalse;
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        kernel.ReleaseSchedCallback = NULL;
        kernel.Flag.ReleaseSched = qFalse;
        kernel.Flag.FCallReleased = qFalse;
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
    kernel.Flag.ReleaseSched = qTrue;
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
/*qBool_t qSchedulerSpreadNotification(void *eventdata, qTaskNotifyMode_t mode)

Spread a notification event among all the tasks in the scheduling scheme

Parameters:

    - eventdata : Specific event user-data.
    - mode : the method used to spread the event:
              Q_NOTIFY_SIMPLE or Q_NOTIFY_QUEUED.

Return value:

    qTrue if the event could be spread in all tasks. Otherwise qFalse.              
*/ 
/*============================================================================*/
qBool_t qSchedulerSpreadNotification( void *eventdata, const qTaskNotifyMode_t mode ){
    qBool_t RetValue = qFalse;
    qTask_t *Task = NULL;
    if( mode != NULL ){
        RetValue = qTrue;
        for( Task = kernel.Head ; NULL != Task; Task = Task->qPrivate.Next){
            if( qFalse == mode( Task, eventdata ) ){
                RetValue = qFalse;
            }
        } 
    }
    return RetValue;
}
#if ( Q_PRIORITY_QUEUE == 1 )
/*============================================================================*/
static qTask_t* _qScheduler_PriorityQueueGet( void ){
    qTask_t *xTask = NULL;
    qUIndex_t i;
    qIndex_t j;
    qUIndex_t IndexTaskToExtract = 0u;
    qPriority_t MaxPriorityValue;
    
    if( kernel.QueueIndex >= 0 ){ /*queue has elements*/
        qCritical_Enter(); 
        MaxPriorityValue = kernel.QueueStack[0].Task->qPrivate.Priority;
        for( i = 1u ; ( i < kernel.QueueSize ) ; i++){  /*walk through the queue to find the task with the highest priority*/
            if( NULL != kernel.QueueStack[i].Task ){ /* tail is reached */
                break;
            }
            if( kernel.QueueStack[i].Task->qPrivate.Priority > MaxPriorityValue ){ /*check if the queued task has the max priority value*/
                MaxPriorityValue = kernel.QueueStack[i].Task->qPrivate.Priority; /*Reassign the max value*/
                IndexTaskToExtract = i;  /*save the index*/
            }
        }   
        kernel.QueueData = kernel.QueueStack[IndexTaskToExtract].QueueData; /*get the data from the queue*/
        xTask = kernel.QueueStack[IndexTaskToExtract].Task; /*assign the task to the output*/
        __qPrivate_TaskModifyFlags( xTask, __QTASK_BIT_SHUTDOWN, qTrue ); /*wake-up !!*/
        xTask->qPrivate.State = qReady; /*set the task as ready*/
        kernel.QueueStack[IndexTaskToExtract].Task = NULL; /*set the position in the queue as empty*/  
        for( j = (qIndex_t)IndexTaskToExtract ; j < kernel.QueueIndex ; j++){ 
            kernel.QueueStack[j] = kernel.QueueStack[j+1]; /*shift the remaining items of the queue*/
        }
        kernel.QueueIndex--;    /*decrease the index*/
        qCritical_Exit();
    }
    return xTask;
}
#endif /* #if ( Q_PRIORITY_QUEUE == 1 ) */
/*============================================================================*/
/*qBool_t qSchedulerAdd_Task(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg)

Add a task to the scheduling scheme. The task is scheduled to run every <Time> 
seconds, <nExecutions> times and executing <CallbackFcn> method on every pass.

Parameters:
    - Task : A pointer to the task node.
    - CallbackFcn : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
    - Priority : Task priority Value. [0(min) - 255(max)]
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
        qSchedulerRemoveTask( Task ); /*Remove the task if was previously added to the chain*/
        Task->qPrivate.Callback = CallbackFcn;
        Task->qPrivate.Interval = qTime2Clock( Time );
        Task->qPrivate.TaskData = arg;
        Task->qPrivate.Priority = Priority;
        Task->qPrivate.Iterations = ( qPeriodic == nExecutions )? qPeriodic : -nExecutions;    
        Task->qPrivate.Notification = 0u;

        __qPrivate_TaskModifyFlags( Task,
                                 __QTASK_BIT_INIT | __QTASK_BIT_QUEUE_RECEIVER | 
                                 __QTASK_BIT_QUEUE_FULL | __QTASK_BIT_QUEUE_COUNT | 
                                 __QTASK_BIT_QUEUE_EMPTY | __QTASK_BIT_RESERVED, 
                                 qFalse);
        __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_SHUTDOWN | __QTASK_BIT_ENABLED, qTrue );  /*task will be awaken and enabled*/ 
        qTaskSetState( Task, InitialState );
                             
        Task->qPrivate.Next = NULL;  
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->qPrivate.Cycles = 0ul;
        #endif
        Task->qPrivate.ClockStart = qClock_GetTick();
        #if ( Q_QUEUES == 1)
            Task->qPrivate.Queue = NULL;
        #endif
        #if ( Q_FSM == 1)
            Task->qPrivate.StateMachine = NULL;
        #endif
        Task->qPrivate.State = qSuspended;
        kernel.Head =  _qScheduler_PriorizedInsert( kernel.Head, Task ); /*put the task on the list according to its priority*/
        RetValue = qTrue;
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
    - Priority : Task priority Value. [0(min) - 255(max)]
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
    - Priority : Task priority Value. [0(min) - 255(max)]
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
            qStateMachine_Init( StateMachine, InitState, SuccessState, FailureState, UnexpectedState, BeforeAnyState );
            Task->qPrivate.StateMachine = StateMachine;
            RetValue = qTrue;
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
    - Priority : Task priority Value. [0(min) - 255(max)]

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qSchedulerAdd_ATParserTask( qTask_t * const Task, qATParser_t *Parser, qPriority_t Priority ){    
    qBool_t RetValue = qFalse;
    if( NULL != Parser ){
        Parser->UserData = Task;
        Parser->qPrivate.xNotifyFcn = qScheduler_ATParserNotifyFcn;
        RetValue =  qSchedulerAdd_Task( Task, qScheduler_ATParserTaskCallback, Priority, qTimeImmediate, qSingleShot, qDisabled, Parser );
    }
    return RetValue;
}
/*============================================================================*/
static void qScheduler_ATParserTaskCallback( qEvent_t  e ){ /*wrapper for the task callback */
    qATParser_Run( (qATParser_t*)e->TaskData );
}
/*============================================================================*/
static void qScheduler_ATParserNotifyFcn(struct _qATParser_s * const Parser){
    qTask_t *Task;
    Task = (qTask_t *)Parser->UserData;
    qTaskSendNotification( Task, NULL );
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
    qTask_t **ptonext = &kernel.Head; /*points to the list "next" pointer*/
    qBool_t RetValue = qFalse;

    if( NULL != kernel.Head ){ /*try the removal if we got tasks in the scheme*/
        while( ( *ptonext != Task ) && ( NULL != *ptonext ) ){ /*walk the tasks list, looking for the next-pointer that points to the target task*/
            ptonext = &(*ptonext)->qPrivate.Next;
        }
        if( *ptonext == Task ){ /*remove the task if was found on the chain*/
            *ptonext = Task->qPrivate.Next; /*remove the task*/
            Task->qPrivate.Next = NULL; /*Just in case the deleted task needs to be added later to the scheduling scheme, otherwise, this would fuck the whole chain*/
            RetValue =  qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
static qTask_t* _qScheduler_PriorizedInsert( qTask_t *head, qTask_t * const Task ){ /*return the new head if modified*/
    qTask_t *RetValue = head; /*if no change in the head, keep it*/
    qPriority_t TaskPriority;
    qPriority_t HeadPriority;
    if( NULL == head ){ /*Is the first task in the scheme? */
        Task->qPrivate.Next = head; /*move the head and just add the task node on top*/
        RetValue =  Task; /*this task will be the new head*/
    }
    else{
        TaskPriority = Task->qPrivate.Priority; /*to avoid side effects*/
        HeadPriority = head->qPrivate.Priority; /*to avoid side effects*/
        if( TaskPriority > HeadPriority ){ /* the task has the highest priority over all */
            Task->qPrivate.Next = head; /*move the head and just add the task node on top*/
            RetValue =  Task; /*this task will be the new head*/
        }
        else{
            _qScheduler_FindPlace( head, Task );
        }       
    }
    return RetValue; 
}
/*============================================================================*/
static void _qScheduler_FindPlace( qTask_t * const head, qTask_t * const Task ){ /*find a new position for the task in the chain, when finded, put the task there*/
    qTask_t *tmp_node = NULL;
    qPriority_t PrioTask;
    PrioTask = Task->qPrivate.Priority; /*to avoid side effects*/
    tmp_node = head; /*start the head with the highest priority task*/
    while( ( NULL != tmp_node->qPrivate.Next ) && ( PrioTask <= tmp_node->qPrivate.Next->qPrivate.Priority ) ) { 
        tmp_node = tmp_node->qPrivate.Next; /*find the right place for this task according its priority*/
    }
    Task->qPrivate.Next = tmp_node->qPrivate.Next; /*the the new task  will be placed just after tmp*/
    tmp_node->qPrivate.Next = Task; /*assign the task*/    
}
#if ( Q_AUTO_CHAINREARRANGE == 1 )
/*============================================================================*/
static qTask_t* _qScheduler_RearrangeChain( qTask_t *head ){ /*this method rearrange the chain according the priority of all its nodes*/
    qTask_t *new_head = NULL, *tmp = head, *tmp1 = NULL;
    qCritical_Enter();
    while( NULL != tmp ){ /*start with a new head and re-insert the entire chain*/
        tmp1 = tmp;
        tmp = tmp->qPrivate.Next;
        new_head = _qScheduler_PriorizedInsert( new_head, tmp1 );  
    }
    kernel.Flag.Init = qTrue; /*set the initialization flag*/
    qCritical_Exit();
    return new_head; /*return the new head*/
}
#endif
#if ( Q_QUEUES == 1)
/*============================================================================*/
static qTrigger_t _qScheduler_CheckQueueEvents( const qTask_t * const Task ){
    qTrigger_t RetValue = qTriggerNULL;
    qBool_t FullFlag, CountFlag, ReceiverFlag, EmptyFlag;
    qBool_t IsFull, IsEmpty;
    qSize_t CurrentQueueCount;
    if( NULL != Task ){
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
            else if( ( CountFlag > 0u ) && ( CurrentQueueCount >= Task->qPrivate.QueueCount ) ){
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
    }
    return RetValue;
}
#endif
/*============================================================================*/
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
static void _qTriggerReleaseSchedEvent( void ){
    qTaskFcn_t Callback;
    kernel.Flag.Init = qFalse;
    kernel.Flag.ReleaseSched = qFalse;   
    kernel.EventInfo.FirstCall = ( qFalse == kernel.Flag.FCallReleased )? qTrue : qFalse;    
    kernel.EventInfo.Trigger = bySchedulingRelease;
    kernel.EventInfo.TaskData = NULL;
    if( NULL != kernel.ReleaseSchedCallback ){
        Callback = kernel.ReleaseSchedCallback;
        Callback( (qEvent_t)&kernel.EventInfo ); /*some compilers cant deal with function pointers inside structs*/
    }
    kernel.Flag.FCallIdle = qTrue;      
}
#endif
/*============================================================================*/
/*void qSchedulerRun(void)
    
Executes the task-scheduler scheme. It must be called once after the task
pool has been defined.

  Note : qScheduleRun keeps the application in an endless loop
*/
void qSchedulerRun( void ){
    qTask_t *Task = NULL; /*this pointer will hold the current node from the chain and/or the top enqueue node if available*/
    kernel.Flag.Init = qTrue; 
    do{
        #if ( Q_AUTO_CHAINREARRANGE == 1 )
        if( qFalse == kernel.Flag.Init){ /*if initial scheduling conditions changed*/
            kernel.Head = _qScheduler_RearrangeChain( kernel.Head ); /*sort the chain by priority (init flag internally set)*/
        } 
        #endif
        #if ( Q_PRIORITY_QUEUE == 1 )
        if( NULL != ( Task = _qScheduler_PriorityQueueGet() ) ){ /*extract a task from the front of the priority queue*/
            Task->qPrivate.State = _qScheduler_Dispatch( Task, byNotificationQueued );  /*Available queueded task will be dispatched in every scheduling cycle : the queue has the higher precedence*/
        }     
        #endif
        if( _qScheduler_ReadyTasksAvailable() ){  /*Check if all the tasks from the chain fulfill the conditions to get the qReady state, if at least one gained it,  enter here*/
            while( NULL != ( Task = _qScheduler_GetNodeFromChain() ) ){ /*Get node by node from the chain until no more available*/
                Task->qPrivate.State = (qTaskState_t) ( ( qReady == Task->qPrivate.State ) ? _qScheduler_Dispatch( Task, Task->qPrivate.Trigger ) : qWaiting);  /*Dispatch the qReady tasks, otherwise put it in qWaiting State*/
            }
        }
        else if( ( NULL==Task ) && ( NULL != kernel.IDLECallback) ) {
             _qScheduler_Dispatch( NULL, byNoReadyTasks ); /*no tasks are available for execution, run the idle task*/
        }
        else{
            /*nothing to do*/
        }    
    }
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        while( qFalse == kernel.Flag.ReleaseSched ); /*scheduling end-point*/ 
        _qTriggerReleaseSchedEvent(); /*check for scheduling-release request*/
    #else
        while(1);
    #endif
}
/*============================================================================*/
static qTask_t* _qScheduler_GetNodeFromChain( void ){ 
    static qTask_t *ChainIterator = __qChainInitializer; /*used to keep on track the current chain position*/
    qTask_t *Node;  /*used the hold the node*/
    if( __qChainInitializer == ChainIterator ){ /*First call*/
        ChainIterator = kernel.Head; /*start from the head*/
    } 
    Node = ChainIterator; /*obtain the current node from the chain*/
    ChainIterator = ( ChainIterator )? ChainIterator->qPrivate.Next : kernel.Head; /*Tail reached, reset the iterator to the head*/
    return Node; /*return the task node at current chain position*/
}
/*============================================================================*/
static qTaskState_t _qScheduler_Dispatch( qTask_t * const Task, const qTrigger_t Event ){
    qIteration_t TaskIteration;
    qTaskFcn_t TaskActivities = NULL;
    if( byNoReadyTasks == Event){
        kernel.EventInfo.FirstCall = (qFalse == kernel.Flag.FCallIdle)? qTrue : qFalse;
        kernel.EventInfo.Trigger = Event;
        kernel.EventInfo.TaskData = NULL;
        TaskActivities = kernel.IDLECallback; /*some compilers can deal with function pointers inside structs*/
        TaskActivities( (qEvent_t)&kernel.EventInfo ); /*run the idle callback*/
        kernel.Flag.FCallIdle = qTrue;   
    }
    else{
        switch(Event){ /*take the necessary actions before dispatching, depending on the event that triggered the task*/
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
        #if ( Q_PRIORITY_QUEUE == 1 )
            case byNotificationQueued:
                kernel.EventInfo.EventData = kernel.QueueData; /*get the extracted data from queue*/
                kernel.QueueData = NULL;
                break;
        #endif
            case byEventFlags:
                kernel.QueueData = NULL;
                break;
            default: break;
        }
        Task->qPrivate.State = qRunning; /*put the task in running state*/
        /*Fill the event info structure: Trigger, FirstCall and TaskData */       
        kernel.EventInfo.Trigger = Event;
        kernel.EventInfo.FirstCall = ( qFalse == __qPrivate_TaskGetFlag( Task, __QTASK_BIT_INIT) )? qTrue : qFalse;
        kernel.EventInfo.TaskData = Task->qPrivate.TaskData;
        
        kernel.CurrentRunningTask = Task; /*needed for qTaskSelf()*/
        TaskActivities = Task->qPrivate.Callback;
        #if ( Q_FSM == 1)
            if ( ( NULL != Task->qPrivate.StateMachine ) && ( __qFSMCallbackMode == Task->qPrivate.Callback ) ){
                qStateMachine_Run( Task->qPrivate.StateMachine, (void*)&kernel.EventInfo );  /*If the task has a FSM attached, just run it*/  
            }
            else if ( NULL != TaskActivities ) {
                TaskActivities( (qEvent_t)&kernel.EventInfo ); /*else, just launch the callback function*/ 
            }       
            else{
                /*nothing to do*/
            }
        #else
            if ( NULL != TaskActivities ) {
                TaskActivities( (qEvent_t)&kernel.EventInfo ); /*else, just launch the callback function*/ 
            }     
        #endif
        kernel.CurrentRunningTask = NULL;
        #if ( Q_QUEUES == 1) 
            if( byQueueReceiver == Event){
                qQueueRemoveFront( Task->qPrivate.Queue );  /*remove the data from the Queue, if the event was byQueueDequeue*/
            } 
        #endif
        __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_INIT, qTrue ); /*set the init flag*/
        kernel.EventInfo.FirstIteration = qFalse;
        kernel.EventInfo.LastIteration =  qFalse; 
        kernel.EventInfo.EventData = NULL; /*clear the eventdata*/
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->qPrivate.Cycles++; /*increase the task cycles value*/
        #endif
    }
    return qSuspended;
}
/*============================================================================*/
static qBool_t _qScheduler_TransitionTo( qTask_t * const task, const qTaskState_t state, const qTrigger_t trg ){
    task->qPrivate.State = state;
    task->qPrivate.Trigger = trg;
    return qTrue;
}
/*============================================================================*/
static qBool_t _qScheduler_TaskDeadLineReached( qTask_t * const task){
    qBool_t RetValue = qFalse;
    qIteration_t TaskIterations;
    qClock_t TaskInterval;
    qBool_t DeadLineFlag;

    if( __qPrivate_TaskGetFlag( task, __QTASK_BIT_ENABLED ) ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
        TaskIterations = task->qPrivate.Iterations; /*avoid side efects in the next check*/
        if( ( _qAbs( TaskIterations ) > 0 ) || ( qPeriodic == TaskIterations ) ){ /*then task should be periodic or must have available iters*/
            TaskInterval = task->qPrivate.Interval; /*avoid side efects in the next check*/
            DeadLineFlag = qClock_TimeDeadlineCheck( task->qPrivate.ClockStart, TaskInterval );
            if( ( 0ul == TaskInterval ) || ( DeadLineFlag ) ){ /*finally, check the time deadline*/
                RetValue = qTrue;                
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
static qBool_t _qScheduler_ReadyTasksAvailable( void ){ /*this method checks for tasks that fulfill the conditions to get the qReady state*/
    qTask_t *Task = NULL;
    #if ( Q_QUEUES == 1) 
    qTrigger_t trg = qTriggerNULL;
    #endif
    qBool_t nTaskReady = qFalse; /*the return is to notify that at least one task gained the qReady state*/
    for( Task = kernel.Head ; NULL != Task ; Task = Task->qPrivate.Next ){ /*loop every task in the chain : only one event will be verified by node*/
        if( __qPrivate_TaskGetFlag( Task, __QTASK_BIT_SHUTDOWN) ){
            if( _qScheduler_TaskDeadLineReached( Task ) ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
                Task->qPrivate.ClockStart = qClock_GetTick(); /*Restart the task time*/
                nTaskReady = _qScheduler_TransitionTo( Task, qReady, byTimeElapsed ); /*put the task in ready state with their corresponding trigger */                  
            }
            #if ( Q_QUEUES == 1)  
            else if( qTriggerNULL !=  ( trg = _qScheduler_CheckQueueEvents( Task ) ) ){ /*If the deadline has not met, check if there is a queue event available*/
                nTaskReady = _qScheduler_TransitionTo( Task, qReady, trg ); /*put the task in ready state with their corresponding trigger */   
            }
            #endif
            else if( Task->qPrivate.Notification ){   /*The last check will be if the task has an async event*/
                nTaskReady = _qScheduler_TransitionTo( Task, qReady, byNotificationSimple ); /*put the task in ready state with their corresponding trigger */   
            }
            else if( (QTASK_EVENTFLAGS_RMASK & Task->qPrivate.Flags ) ){
                nTaskReady = _qScheduler_TransitionTo( Task, qReady, byEventFlags ); /*put the task in ready state with their corresponding trigger */  
            }
            else{
                Task->qPrivate.State = qSuspended; /*If the task has no available events, put it in a suspended state*/        
            }
        }
        else{
            Task->qPrivate.State = qSleeping;
        }
    }
    return nTaskReady;
}
/*============================================================================*/
qBool_t _qScheduler_PQueueInsert(qTask_t * const Task, void *data){
    #if ( Q_PRIORITY_QUEUE == 1 )
        qBool_t RetValue = qFalse;
        qQueueStack_t tmp;
        qIndex_t QueueMaxIndex;
        qIndex_t CurrentQueueIndex;
        QueueMaxIndex = ( (qIndex_t)kernel.QueueSize ) - 1; /*to avoid side effects */
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
void _qScheduler_ReloadScheme(void){
    kernel.Flag.Init = qFalse; 
}
/*============================================================================*/