#include "qkernel.h"

/*=========================== QuarkTS Private Data ===========================*/
static QuarkTSCoreData_t QUARKTS;
/*========================= QuarkTS Private Methods===========================*/
static qTaskState_t _qScheduler_Dispatch( qTask_t * const Task, const qTrigger_t Event );
static qTask_t* _qScheduler_GetNodeFromChain( void );
static qTask_t* _qScheduler_RearrangeChain( qTask_t *head );
static qTask_t* _qScheduler_PriorizedInsert( qTask_t *head, qTask_t * const Task );
static void _qScheduler_FindPlace( qTask_t * const head, qTask_t * const Task );
static qBool_t _qScheduler_TransitionTo( qTask_t * const task, const qTaskState_t state, const qTrigger_t trg );
static qBool_t _qScheduler_ReadyTasksAvailable( void );
static qBool_t _qTaskDeadLineReached( qTask_t * const task );

#define _qAbs( x )    ((((x)<0) && ((x)!=qPeriodic))? -(x) : (x))

#if ( Q_PRIORITY_QUEUE == 1 ) 
    static qTask_t* _qScheduler_PriorityQueueGet( void );
#endif

#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
    static void _qTriggerReleaseSchedEvent( void );
#endif

#if ( Q_QUEUES == 1)
    static qTrigger_t _qCheckQueueEvents( const qTask_t * const Task );
#endif

/*========================== QuarkTS Private Macros ==========================*/
#define __qChainInitializer     ((qTask_t*)&QUARKTS)/*point to something that is not some task in the chain */
#define __qFSMCallbackMode      ((qTaskFcn_t)1)
/*============================================================================*/
#if (Q_SETUP_TIME_CANONICAL == 1)
    void _qInitScheduler( const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback, qQueueStack_t *Q_Stack, const uint8_t Size_Q_Stack ){
#else
    void _qInitScheduler( const qGetTickFcn_t TickProvider, const qTimingBase_type BaseTimming, qTaskFcn_t IdleCallback, qQueueStack_t *Q_Stack, const uint8_t Size_Q_Stack ){
#endif
    #if ( Q_PRIORITY_QUEUE == 1 )  
        uint8_t i;
    #endif
    QUARKTS.Head = NULL;
    #if ( Q_SETUP_TIME_CANONICAL != 1 )
        qClock_SetTimeBase( BaseTimming );
    #endif
    QUARKTS.IDLECallback = IdleCallback;
    #if ( Q_PRIORITY_QUEUE == 1 )    
        QUARKTS.QueueStack = (qQueueStack_t*)Q_Stack;
        QUARKTS.QueueSize = Size_Q_Stack;
        for( i = 0u ; i < QUARKTS.QueueSize ; i++){
             QUARKTS.QueueStack[i].Task = NULL;  /*set the priority queue as empty*/  
        }
        QUARKTS.QueueIndex = -1;     
        QUARKTS.QueueData = NULL;
    #endif
    QUARKTS.Flag.Init = qFalse;
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        QUARKTS.ReleaseSchedCallback = NULL;
        QUARKTS.Flag.ReleaseSched = qFalse;
        QUARKTS.Flag.FCallReleased = qFalse;
    #endif
    QUARKTS.CurrentRunningTask = NULL;
    qClock_SetTickProvider( TickProvider );
}
/*============================================================================*/
/*qTask_t* qTaskSelf(void)

Get current running task handle.

Return value:

    A pointer to the current running task.
    NULL when the scheduler it's in a busy state or when IDLE Task is running.
*/
qTask_t* qTaskSelf( void ){
    return QUARKTS.CurrentRunningTask; /*get the handle of the current running task*/
}
/*============================================================================*/
/*void qSchedulerSetIdleTask(qTaskFcn_t Callback)

Establish the IDLE Task Callback

Parameters:

    - IDLE_Callback : A pointer to a void callback method with a qEvent_t 
                      parameter as input argument.
*/
void qSchedulerSetIdleTask( qTaskFcn_t Callback ){
    QUARKTS.IDLECallback = Callback;
}
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
/*============================================================================*/
/*void qSchedulerRelease(void)

Disables the kernel scheduling. The main thread will continue after the
qSchedule() call.
*/
void qSchedulerRelease( void ){
    QUARKTS.Flag.ReleaseSched = qTrue;
}
/*============================================================================*/
/*void qSchedulerSetReleaseCallback(qTaskFcn_t Callback)

Set/Change the scheduler release callback function

Parameters:
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
void qSchedulerSetReleaseCallback( qTaskFcn_t Callback ){
    QUARKTS.ReleaseSchedCallback = Callback;
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
    if( ( Q_NOTIFY_SIMPLE == mode ) || ( Q_NOTIFY_QUEUED == mode ) ){
        RetValue = qTrue;
        for( Task = QUARKTS.Head ; NULL != Task; Task = Task->private.Next){
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
    uint8_t i;
    int16_t j;
    uint8_t IndexTaskToExtract = 0u;
    qPriority_t MaxPriorityValue;
    
    if( QUARKTS.QueueIndex >= 0 ){ /*queue has elements*/
        qEnterCritical(); 
        MaxPriorityValue = QUARKTS.QueueStack[0].Task->private.Priority;
        for( i = 1u ; ( i < QUARKTS.QueueSize ) ; i++){  /*walk through the queue to find the task with the highest priority*/
            if( NULL != QUARKTS.QueueStack[i].Task ){ /* tail is reached */
                break;
            }
            if( QUARKTS.QueueStack[i].Task->private.Priority > MaxPriorityValue ){ /*check if the queued task has the max priority value*/
                MaxPriorityValue = QUARKTS.QueueStack[i].Task->private.Priority; /*Reassign the max value*/
                IndexTaskToExtract = i;  /*save the index*/
            }
        }   
        QUARKTS.QueueData = QUARKTS.QueueStack[IndexTaskToExtract].QueueData; /*get the data from the queue*/
        xTask = QUARKTS.QueueStack[IndexTaskToExtract].Task; /*assign the task to the output*/
        xTask->private.State = qReady; /*set the task as ready*/
        QUARKTS.QueueStack[IndexTaskToExtract].Task = NULL; /*set the position in the queue as empty*/  
        for( j = (int16_t)IndexTaskToExtract ; j < QUARKTS.QueueIndex ; j++){ 
            QUARKTS.QueueStack[j] = QUARKTS.QueueStack[j+1]; /*shift the remaining items of the queue*/
        }
        QUARKTS.QueueIndex--;    /*decrease the index*/
        qExitCritical();
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
    - InitialState : Specifies the initial state of the task (qEnabled or qDisabled).
    - arg : Represents the task arguments. All arguments must be passed by
            reference and cast to (void *). Only one argument is allowed, 
            so, for multiple arguments, create a structure that contains 
            all of the arguments and pass a pointer to that structure.

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qSchedulerAdd_Task( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg ){
    qBool_t RetValue = qFalse;
    if( ( NULL!=Task ) && ( NULL != CallbackFcn ) ) {
        qSchedulerRemoveTask( Task ); /*Remove the task if was previously added to the chain*/
        Task->private.Callback = CallbackFcn;
        Task->private.Interval = qTime2Clock( Time );
        Task->private.TaskData = arg;
        Task->private.Priority = Priority;
        Task->private.Iterations = ( qPeriodic == nExecutions )? qPeriodic : -nExecutions;    
        Task->private.Notification = 0u;
        Task->private.Flag[_qIndex_InitFlag] = qFalse;
        Task->private.Flag[_qIndex_QueueReceiver] = qFalse; 
        Task->private.Flag[_qIndex_QueueFull] = qFalse;
        Task->private.Flag[_qIndex_QueueCount] = qFalse;
        Task->private.Flag[_qIndex_QueueEmpty] = qFalse;
        Task->private.Flag[_qIndex_Enabled] = InitialState;
        Task->private.Next = NULL;  
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->private.Cycles = 0ul;
        #endif
        Task->private.ClockStart = qSchedulerGetTick();
        #if ( Q_QUEUES == 1)
            Task->private.Queue = NULL;
        #endif
        #if ( Q_FSM == 1)
            Task->private.StateMachine = NULL;
        #endif
        Task->private.State = qSuspended;
        QUARKTS.Head =  _qScheduler_PriorizedInsert( QUARKTS.Head, Task ); /*put the task on the list according to its priority*/
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
    - InitialTaskState : Specifies the initial state of the task (qEnabled or qDisabled).
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
            Task->private.StateMachine = StateMachine;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
#endif
/*============================================================================*/
/*qBool_t qSchedulerRemoveTask(qTask_t *Task)

Remove the task from the scheduling scheme.

Parameters:

    - Task : A pointer to the task node.
     
Return value:

    Returns qTrue if success, otherwise returns qFalse.;     
    */
qBool_t qSchedulerRemoveTask( qTask_t * const Task ){
    qTask_t *tmp = QUARKTS.Head;
    qTask_t *prev = NULL;
    qBool_t RetValue = qFalse;

    if( NULL != tmp ){
        while( ( tmp != Task ) && ( NULL != tmp->private.Next ) ){ /*find the task to remove*/
            prev = tmp; /*keep on track the previous node*/
            tmp = tmp->private.Next;
        }
        if( tmp == Task ){ /*remove the task if was found on the chain*/
            if( NULL != prev ){
                prev->private.Next = tmp->private.Next; /*make link between adjacent nodes, this cause that the task being removed from the chain*/
            }
            else{
                QUARKTS.Head = tmp->private.Next; /*if the task is the head of the chain, move the head to the next node*/
            }
            Task->private.Next = NULL; /*Just in case the deleted task needs to be added later to the scheduling scheme, otherwise, this would fuck the whole chain*/
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
        Task->private.Next = head; /*move the head and just add the task node on top*/
        RetValue =  Task; /*this task will be the new head*/
    }
    else{
        TaskPriority = Task->private.Priority; /*to avoid side effects*/
        HeadPriority = head->private.Priority; /*to avoid side effects*/
        if( TaskPriority > HeadPriority ){ /* the task has the highest priority over all */
            Task->private.Next = head; /*move the head and just add the task node on top*/
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
    PrioTask = Task->private.Priority; /*to avoid side effects*/
    tmp_node = head; /*start the head with the highest priority task*/
    while( ( NULL != tmp_node->private.Next ) && ( PrioTask <= tmp_node->private.Next->private.Priority ) ) { 
        tmp_node = tmp_node->private.Next; /*find the right place for this task according its priority*/
    }
    Task->private.Next = tmp_node->private.Next; /*the the new task  will be placed just after tmp*/
    tmp_node->private.Next = Task; /*assign the task*/    
}
#if ( Q_AUTO_CHAINREARRANGE == 1 )
/*============================================================================*/
static qTask_t* _qScheduler_RearrangeChain( qTask_t *head ){ /*this method rearrange the chain according the priority of all its nodes*/
    qTask_t *new_head = NULL, *tmp = head, *tmp1 = NULL;
    qEnterCritical();
    while( NULL != tmp ){ /*start with a new head and re-insert the entire chain*/
        tmp1 = tmp;
        tmp = tmp->private.Next;
        new_head = _qScheduler_PriorizedInsert( new_head, tmp1 );  
    }
    QUARKTS.Flag.Init = qTrue; /*set the initialization flag*/
    qExitCritical();
    return new_head; /*return the new head*/
}
#endif
#if ( Q_QUEUES == 1)
/*============================================================================*/
static qTrigger_t _qCheckQueueEvents( const qTask_t * const Task ){
    qTrigger_t RetValue = qTriggerNULL;
    uint8_t FullFlag, CountFlag, ReceiverFlag, EmptyFlag;
    qBool_t IsFull, IsEmpty;
    qSize_t CurrentQueueCount;
    if( NULL != Task ){
        if( NULL != Task->private.Queue){
            FullFlag = Task->private.Flag[_qIndex_QueueFull]; /*to avoid side effects*/
            CountFlag = Task->private.Flag[_qIndex_QueueCount]; /*to avoid side effects*/
            ReceiverFlag = Task->private.Flag[_qIndex_QueueReceiver]; /*to avoid side effects*/
            EmptyFlag = Task->private.Flag[_qIndex_QueueEmpty]; /*to avoid side effects*/
            CurrentQueueCount = qQueueCount( Task->private.Queue ); /*to avoid side effects*/
            IsFull = qQueueIsFull( Task->private.Queue ); /*to avoid side effects*/
            IsEmpty = qQueueIsEmpty( Task->private.Queue ); /*to avoid side effects*/
            /*check the queue events in the corresponding precedence order*/
            if( FullFlag && IsFull ){        
                RetValue =  byQueueFull;
            }
            else if( ( CountFlag > 0u ) && ( CurrentQueueCount >= CountFlag ) ){
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
    QUARKTS.Flag.Init = qFalse;
    QUARKTS.Flag.ReleaseSched = qFalse;   
    QUARKTS.EventInfo.FirstCall = ( qFalse == QUARKTS.Flag.FCallReleased )? qTrue : qFalse;    
    QUARKTS.EventInfo.Trigger = bySchedulingRelease;
    QUARKTS.EventInfo.TaskData = NULL;
    if( NULL != QUARKTS.ReleaseSchedCallback ){
        Callback = QUARKTS.ReleaseSchedCallback;
        Callback( (qEvent_t)&QUARKTS.EventInfo ); /*some compilers cant deal with function pointers inside structs*/
    }
    QUARKTS.Flag.FCallIdle = qTrue;      
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
    QUARKTS.Flag.Init = qTrue; 
    do{
        #if ( Q_AUTO_CHAINREARRANGE == 1 )
        if( qFalse == QUARKTS.Flag.Init){ /*if initial scheduling conditions changed*/
            QUARKTS.Head = _qScheduler_RearrangeChain( QUARKTS.Head ); /*sort the chain by priority (init flag internally set)*/
        } 
        #endif
        #if ( Q_PRIORITY_QUEUE == 1 )
        if( NULL != ( Task = _qScheduler_PriorityQueueGet() ) ){ /*extract a task from the front of the priority queue*/
            Task->private.State = _qScheduler_Dispatch( Task, byNotificationQueued );  /*Available queueded task will be dispatched in every scheduling cycle : the queue has the higher precedence*/
        }     
        #endif
        if( _qScheduler_ReadyTasksAvailable() ){  /*Check if all the tasks from the chain fulfill the conditions to get the qReady state, if at least one gained it,  enter here*/
            while( NULL != ( Task = _qScheduler_GetNodeFromChain() ) ){ /*Get node by node from the chain until no more available*/
                Task->private.State = (qTaskState_t) ( ( qReady == Task->private.State ) ? _qScheduler_Dispatch( Task, Task->private.Trigger ) : qWaiting);  /*Dispatch the qReady tasks, otherwise put it in qWaiting State*/
            }
        }
        else if( ( NULL==Task ) && ( NULL != QUARKTS.IDLECallback) ) {
             _qScheduler_Dispatch( NULL, byNoReadyTasks ); /*no tasks are available for execution, run the idle task*/
        }
        else{
            /*nothing to do*/
        }    
    }
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        while( qFalse == QUARKTS.Flag.ReleaseSched ); /*scheduling end-point*/ 
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
        ChainIterator = QUARKTS.Head; /*start from the head*/
    } 
    Node = ChainIterator; /*obtain the current node from the chain*/
    ChainIterator = ( ChainIterator )? ChainIterator->private.Next : QUARKTS.Head; /*Tail reached, reset the iterator to the head*/
    return Node; /*return the task node at current chain position*/
}
/*============================================================================*/
static qTaskState_t _qScheduler_Dispatch( qTask_t * const Task, const qTrigger_t Event ){
    qIteration_t TaskIteration;
    qTaskFcn_t TaskActivities = NULL;
    if( byNoReadyTasks == Event){
        QUARKTS.EventInfo.FirstCall = (qFalse == QUARKTS.Flag.FCallIdle)? qTrue : qFalse;
        QUARKTS.EventInfo.Trigger = Event;
        QUARKTS.EventInfo.TaskData = NULL;
        TaskActivities = QUARKTS.IDLECallback; /*some compilers can deal with function pointers inside structs*/
        TaskActivities( (qEvent_t)&QUARKTS.EventInfo ); /*run the idle callback*/
        QUARKTS.Flag.FCallIdle = qTrue;   
    }
    else{
        switch(Event){ /*take the necessary actions before dispatching, depending on the event that triggered the task*/
            case byTimeElapsed:
                /*handle the iteration value and the FirstIteration flag*/
                TaskIteration = Task->private.Iterations;
                QUARKTS.EventInfo.FirstIteration = ( ( TaskIteration != qPeriodic ) && ( TaskIteration < 0 ) )? qTrue : qFalse;
                Task->private.Iterations = ( QUARKTS.EventInfo.FirstIteration )? -Task->private.Iterations : Task->private.Iterations;
                if( qPeriodic != Task->private.Iterations){
                    Task->private.Iterations--; /*Decrease the iteration value*/
                }
                QUARKTS.EventInfo.LastIteration = (0 == Task->private.Iterations )? qTrue : qFalse; 
                if( QUARKTS.EventInfo.LastIteration ) {
                    Task->private.Flag[_qIndex_Enabled] = qFalse; /*When the iteration value is reached, the task will be disabled*/ 
                }           
                break;
            case byNotificationSimple:
                QUARKTS.EventInfo.EventData = Task->private.AsyncData; /*Transfer async-data to the eventinfo structure*/
                Task->private.Notification--; /* = qFalse */ /*Clear the async flag*/            
                break;
        #if ( Q_QUEUES == 1)    
            case byQueueReceiver:
                QUARKTS.EventInfo.EventData = qQueuePeek( Task->private.Queue ); /*the EventData will point to the RBuffer front-data*/
                break;
            case byQueueFull: case byQueueCount: case byQueueEmpty: 
                QUARKTS.EventInfo.EventData = (void*)Task->private.Queue;  /*the EventData will point to the the linked RingBuffer*/
                break;
        #endif
        #if ( Q_PRIORITY_QUEUE == 1 )
            case byNotificationQueued:
                QUARKTS.EventInfo.EventData = QUARKTS.QueueData; /*get the extracted data from queue*/
                QUARKTS.QueueData = NULL;
                break;
        #endif
            default: break;
        }
        Task->private.State = qRunning; /*put the task in running state*/
        /*Fill the event info structure: Trigger, FirstCall and TaskData */       
        QUARKTS.EventInfo.Trigger = Event;
        QUARKTS.EventInfo.FirstCall = ( qFalse == Task->private.Flag[_qIndex_InitFlag] )? qTrue : qFalse;
        QUARKTS.EventInfo.TaskData = Task->private.TaskData;
        
        QUARKTS.CurrentRunningTask = Task; /*needed for qTaskSelf()*/
        TaskActivities = Task->private.Callback;
        #if ( Q_FSM == 1)
            if ( ( NULL != Task->private.StateMachine ) && ( __qFSMCallbackMode == Task->private.Callback ) ){
                qStateMachine_Run( Task->private.StateMachine, (void*)&QUARKTS.EventInfo );  /*If the task has a FSM attached, just run it*/  
            }
            else if ( NULL != Task->private.Callback ) {
                TaskActivities( (qEvent_t)&QUARKTS.EventInfo ); /*else, just launch the callback function*/ 
            }       
            else{
                /*nothing to do*/
            }
        #else
            if ( NULL != Task->Callback ) {
                TaskActivities( (qEvent_t)&QUARKTS.EventInfo ); /*else, just launch the callback function*/ 
            }     
        #endif
        QUARKTS.CurrentRunningTask = NULL;
        #if ( Q_QUEUES == 1) 
            if( byQueueReceiver == Event){
                qQueueRemoveFront( Task->private.Queue );  /*remove the data from the Queue, if the event was byQueueDequeue*/
            } 
        #endif
        Task->private.Flag[_qIndex_InitFlag] = qTrue; /*clear the init flag*/
        QUARKTS.EventInfo.FirstIteration = qFalse;
        QUARKTS.EventInfo.LastIteration =  qFalse; 
        QUARKTS.EventInfo.EventData = NULL; /*clear the eventdata*/
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->private.Cycles++; /*increase the task cycles value*/
        #endif
    }
    return qSuspended;
}
/*============================================================================*/
static qBool_t _qScheduler_TransitionTo( qTask_t * const task, const qTaskState_t state, const qTrigger_t trg ){
    task->private.State = state;
    task->private.Trigger = trg;
    return qTrue;
}
/*============================================================================*/
static qBool_t _qTaskDeadLineReached( qTask_t * const task){
    qBool_t RetValue = qFalse;
    qBool_t EnabledFlag;
    qIteration_t TaskIterations;
    qClock_t TaskInterval;
    qBool_t DeadLineFlag;
    EnabledFlag = task->private.Flag[_qIndex_Enabled] ; /*avoid side efects in the next check*/
    if( EnabledFlag ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
        TaskIterations = task->private.Iterations; /*avoid side efects in the next check*/
        if( ( _qAbs( TaskIterations ) > 0 ) || ( qPeriodic == TaskIterations ) ){ /*then task should be periodic or must have available iters*/
            TaskInterval = task->private.Interval; /*avoid side efects in the next check*/
            DeadLineFlag = qClock_TimeDeadlineCheck( task->private.ClockStart, TaskInterval );
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
    for( Task = QUARKTS.Head ; NULL != Task ; Task = Task->private.Next ){ /*loop every task in the chain : only one event will be verified by node*/
        if( _qTaskDeadLineReached( Task ) ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
            Task->private.ClockStart = qSchedulerGetTick(); /*Restart the task time*/
            nTaskReady = _qScheduler_TransitionTo( Task, qReady, byTimeElapsed ); /*put the task in ready state with their corresponding trigger */                  
        }
        #if ( Q_QUEUES == 1)  
        else if( qTriggerNULL !=  ( trg = _qCheckQueueEvents( Task ) ) ){ /*If the deadline has not met, check if there is a queue event available*/
            nTaskReady = _qScheduler_TransitionTo( Task, qReady, trg ); /*put the task in ready state with their corresponding trigger */   
        }
        #endif
        else if( Task->private.Notification ){   /*The last check will be if the task has an async event*/
            nTaskReady = _qScheduler_TransitionTo( Task, qReady, byNotificationSimple ); /*put the task in ready state with their corresponding trigger */   
        }
        else{
            Task->private.State = qSuspended; /*If the task has no available events, put it in a suspended state*/        
        }
    }
    return nTaskReady;
}
/*============================================================================*/
/*void qTaskSendNotification(qTask_t * const Task, void* eventdata)

Sends a simple notification generating an asynchronous event. 
This method marks the task as 'qReady' for execution, therefore, the planner will launch the task 
immediately according to the scheduling rules (even if task is disabled) and 
setting the Trigger flag to "byNotificationSimple". Specific user-data can be passed 
through, and will be available in the respective callback inside the <EventData> 
field.

Parameters:

    - Task : Pointer to the task node.
    - eventdata : Specific event user-data.

Return value:

    qTrue on success. Otherwise qFalse.
*/ 
qBool_t qTaskSendNotification( qTask_t * const Task, void* eventdata){
    qBool_t RetValue = qFalse;
    if( NULL != Task ){
        if( Task->private.Notification < QMAX_NOTIFICATION_VALUE ){
            Task->private.Notification++;
            Task->private.AsyncData = eventdata;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qTaskQueueNotification(const qTask_t * const Task, void* eventdata)

Insert a notification in the FIFO priority queue. The scheduler get this notification
as asynchronous event, therefor, the task will be ready for execution according to 
the queue order (determined by priority), even if task is disabled. When extracted, 
the scheduler will set Trigger flag to  "byNotificationQueued". Specific user-data 
can be passed through, and will be available inside the EventData field, only in
corresponding launch.

Parameters:

    - Task : A pointer to the task node.
    - eventdata - Specific event user-data.

Return value:

    Returns qTrue if the event has been inserted in the queue, or qFalse if an error 
    occurred (The queue exceeds the size).
*/
qBool_t qTaskQueueNotification( qTask_t * const Task, void* eventdata ){
    #if ( Q_PRIORITY_QUEUE == 1 )
        qBool_t RetValue = qFalse;
        qQueueStack_t tmp;
        int16_t QueueMaxIndex;
        int16_t CurrentQueueIndex;
        QueueMaxIndex = ( (int16_t)QUARKTS.QueueSize ) - 1; /*to avoid side effects */
        CurrentQueueIndex = QUARKTS.QueueIndex; /*to avoid side effects */
        if( ( NULL != Task )  && ( CurrentQueueIndex < QueueMaxIndex) ) {/*check if data can be queued*/
            tmp.QueueData = eventdata;
            tmp.Task = Task;
            QUARKTS.QueueStack[ ++QUARKTS.QueueIndex ] = tmp; /*insert task and the corresponding eventdata to the queue*/
            RetValue = qTrue;
        }
        return RetValue;
    #else
        return qFalse;
    #endif
}
/*============================================================================*/
/*
qBool_t qTaskIsEnabled(const qTask_t *Task)

Retrieve the enabled/disabled state

Parameters:

    Pointer to the task node.

Return value:

    True if the task in on Enabled state, otherwise returns false.
*/    
qBool_t qTaskIsEnabled( const qTask_t * const Task ){
    qBool_t RetValue = qFalse;
    if( NULL != Task ){
        RetValue = (qBool_t)Task->private.Flag[_qIndex_Enabled];
    }
    return RetValue;
}
/*============================================================================*/
#if ( Q_TASK_COUNT_CYCLES == 1 )
/*uint32_t qTaskGetCycles(const qTask_t *Task)

Retrieve the number of task activations.

Parameters:

    - Task : Pointer to the task node.

Return value:

    A unsigned long value containing the number of task activations.
*/
uint32_t qTaskGetCycles( const qTask_t * const Task ){
    uint32_t RetValue = 0ul;
    if( NULL != Task ){
        RetValue = Task->private.Cycles;
    }
    return RetValue;
}
#endif
/*============================================================================*/
/*void qTaskSetTime(qTask_t * const Task, const qTime_t Value)

Set/Change the Task execution interval

Parameters:

    - Task : A pointer to the task node.
    - Value : Execution interval defined in seconds (floating-point format). 
              For immediate execution (tValue = qTimeImmediate).
*/
void qTaskSetTime( qTask_t * const Task, const qTime_t Value ){
    if( NULL != Task ){
        Task->private.Interval = qTime2Clock( Value );
    }
}
/*============================================================================*/
/*void qTaskSetIterations(qTask_t * const Task, qIteration_t Value)

Set/Change the number of task iterations

Parameters:

    - Task : A pointer to the task node.
    - Value : Number of task executions (Integer value). For indefinite 
              execution (iValue = qPeriodic or qIndefinite). Tasks do not remember
              the number of iteration set initially. After the iterations are 
              done, internal iteration counter is 0. If you need to perform
              another set of iterations, you need to set the number of 
              iterations again and resume.
*/
void qTaskSetIterations( qTask_t * const Task, const qIteration_t Value ){
    if( NULL != Task ){
        Task->private.Iterations = ( qPeriodic==Value )? qPeriodic : -Value;
    }      
}
/*============================================================================*/
/*void qTaskSetPriority(qTask_t * const Task, const qPriority_t Value)

Set/Change the task priority value

Parameters:

    - Task : A pointer to the task node.
    - Value : Priority Value. [0(min) - 255(max)]
*/
void qTaskSetPriority( qTask_t * const Task, const qPriority_t Value ){
    if( NULL != Task ){
        QUARKTS.Flag.Init = qFalse; 
        Task->private.Priority = Value; 
    }
}
/*============================================================================*/
/*void qTaskSetCallback(qTask_t * const Task, const qTaskFcn_t Callback)

Set/Change the task callback function

Parameters:

    - Task : A pointer to the task node.
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
void qTaskSetCallback( qTask_t * const Task, const qTaskFcn_t CallbackFcn ){
    if( NULL != Task ){
        Task->private.Callback = CallbackFcn;
    }    
}
/*============================================================================*/
/*void qTaskSetState(qTask_t * const Task, const qState_t State)

Set the task state (Enabled or Disabled)

Parameters:

    - Task : A pointer to the task node.
    - State : qEnabled or qDisabled 
*/
void qTaskSetState(qTask_t * const Task, const qState_t State){
    if( NULL != Task ){
        if( State != Task->private.Flag[_qIndex_Enabled] ){ 
            Task->private.Flag[_qIndex_Enabled] = State;
            Task->private.ClockStart = qSchedulerGetTick();
        }
    }
}
/*============================================================================*/
/*void qTaskSetData(qTask_t * const Task, void* UserData)

Set the task data

Parameters:

    - Task : A pointer to the task node.

Return value:

    A void pointer to the task data.
*/
void qTaskSetData( qTask_t * const Task, void* arg ){
    if( NULL != Task ){
        Task->private.TaskData = arg;
    }
}
/*============================================================================*/
/*void qTaskClearTimeElapsed(qTask_t *Task)

Clear the elapsed time of the task. Restart the internal task tick;

Parameters:

    - Task : A pointer to the task node.
*/
void qTaskClearTimeElapsed( qTask_t * const Task ){
    if( NULL != Task ){
        Task->private.ClockStart = qSchedulerGetTick();
    }    
}
#if ( Q_QUEUES == 1)
/*============================================================================*/
/*qBool_t qTaskAttachQueue(qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, uint8_t arg)

Attach a Queue to the Task. 

Parameters:

    - Task : A pointer to the task node.
    - Queue : A pointer to a Queue  object
    - Mode: Attach mode. This implies the event that will trigger the task according
            to one of the following modes:
                        > qQUEUE_DEQUEUE: The task will be triggered if there are elements 
                          in the Queue. Data will be extracted automatically in 
                          every trigger and will be available in the <EventData> field 
                          of the qEvent_t structure.
     
                        > qQUEUE_FULL: the task will be triggered if the Queue
                          is full. A pointer to the queue will be available in the
                          <EventData> field of the qEvent_t structure.

                        > qQUEUE_COUNT: the task will be triggered if the count of 
                          elements in the queue reach the specified value. 
                          A pointer to the queue will be available in the
                          <EventData> field of the qEvent_t structure.

                        > qQUEUE_EMPTY: the task will be triggered if the queue
                          is empty. A pointer to the queue will be available in the
                          <EventData> field of the qEvent_t structure.
    - arg: This argument defines if the queue will be attached (qATTACH) or 
           detached (qDETACH) from the task.
           If the qQUEUE_COUNT mode is specified, this value will be used to check
           the element count of the queue. A zero value will act as 
           an qDETACH action. 

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qTaskAttachQueue( qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const uint8_t arg ){
    qBool_t RetValue = qFalse;
    if( ( NULL != Queue ) && ( NULL != Task ) && ( Mode >= qQUEUE_RECEIVER ) && ( Mode <= qQUEUE_EMPTY)  ){
        if( NULL != Queue->pHead ) {
            if( Mode == qQUEUE_COUNT ){
                Task->private.Flag[Mode] = arg; /*if mode is qQUEUE_COUNT, use their arg value as count*/
            }
            else{
                Task->private.Flag[Mode] = ( arg != qFalse )? qATTACH :qDETACH ; 
            }
            Task->private.Queue = ( arg > 0u )? Queue : NULL; /*reject, no valid arg input*/
            RetValue = qTrue;
        }
    }
    return RetValue;
}
#endif /* #if ( Q_QUEUES == 1) */
#if ( Q_FSM == 1)
/*============================================================================*/
/*qBool_t qTaskAttachStateMachine( qTask_t * const Task, qSM_t * const StateMachine )

Attach a Finite State Machine(FSM) to the Task. 

Note: Task and state-machine should be previously initialized before the attach procedure.

Parameters:

    - Task : A pointer to the task node.
    - StateMachine : A pointer to the FSM object.

Return value:

    Returns qTrue on success, otherwise, returns qFalse.

*/
qBool_t qTaskAttachStateMachine( qTask_t * const Task, qSM_t * const StateMachine ){
    qBool_t RetValue = qFalse;
    if( ( NULL != Task ) && ( NULL != StateMachine ) ){
        Task->private.Callback = __qFSMCallbackMode;
        Task->private.StateMachine = StateMachine;
        RetValue = qTrue;
    }    
    return RetValue;
}
#endif /* #if ( Q_FSM == 1) */
/*============================================================================*/