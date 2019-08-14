/*
    QuarkTS V4.9.3 - Copyright (C) 2012 Eng. Juan Camilo Gomez C. MSc.
    A Non-Preemptive RTOS for small embedded systems
    GNU Lesser General Public License (LGPL)
    C99 and MISRA-C 2004 Compliant
*/

#include "QuarkTS.h"

#ifdef __CC_ARM
#endif
#ifdef __arm__
#endif
#ifdef __MWERKS__
#endif
#ifdef __CWCC__
#endif
#ifdef __AVR_ARCH__
#endif
#ifdef __XC8
    #pragma warning push
    #pragma warning disable 1471   /*disable warning: (1471) indirect function call via a NULL pointer ignored*/
    #pragma warning disable 1498   /*disable warning: (1498) pointer (x@y) in expression may have no targets*/
    #pragma warning disable 520    /*disable warning: (520) function "x" is never called*/
    #pragma warning disable 759    /*disable warning: (759) expression generates no code*/
    #pragma warning disable 751    /*disable warning: (751) arithmetic overflow in constant expression*/
    #pragma warning disable 373    /*disable warning: (373) implicit signed to unsigned conversion*/
    #if __XC8_VERSION > 1380     
        #pragma warning disable 1510    /*disable warning: (1510)  non-reentrant function @f appears in multiple call graphs and has been duplicated by the compiler*/
        #pragma warning disable 2029    /*disable warning: (2029)  a function pointer cannot be used to hold the address of data*/
        #pragma warning disable 2030    /*disable warning: (2030) a data pointer cannot be used to hold the address of a function*/
        #pragma warning disable 1090   /*disable warning: (1090) variable "x" is not used*/
        //#pragma warning disable 373    /*disable warning: (2030) a data pointer cannot be used to hold the address of a function*/
        /*--MSGDISABLE=2029:off,2030:off,373:off */
    #endif
    /*--MSGDISABLE=2029:off,2030:off,373:off */
#endif
#ifdef __XC16
#endif
#ifdef __XC32
#endif
#ifdef __IAR_SYSTEMS_ICC__
  #ifdef __ICC8051__
    #pragma diag_suppress=Pa082
  #endif
#endif
/*=========================== QuarkTS Private Data ===========================*/
static QuarkTSCoreData_t QUARKTS;
static volatile qClock_t _qSysTick_Epochs_ = 0ul;
/*========================= QuarkTS Private Methods===========================*/
static qTaskState_t _qScheduler_Dispatch(qTask_t *Task, const qTrigger_t Event);
static qTask_t* _qScheduler_GetNodeFromChain(void);
static qTask_t* _qScheduler_RearrangeChain(qTask_t *head);
static qTask_t* _qScheduler_PriorizedInsert(qTask_t *head, qTask_t *Task);
static void _qScheduler_FindPlace(qTask_t *head, qTask_t *Task);
static qBool_t _qScheduler_TransitionTo(qTask_t *task, qTaskState_t state, qTrigger_t trg);
static qBool_t _qScheduler_ReadyTasksAvailable(void);
static qBool_t _qTaskDeadLineReached(qTask_t *task);

#if ( Q_PRIORITY_QUEUE == 1 ) 
    static qTask_t* _qScheduler_PriorityQueueGet(void);
#endif

#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
    static void _qTriggerReleaseSchedEvent(void);
#endif
static uint8_t __q_revuta(uint32_t num, char* str, uint8_t base);
#if ( Q_FSM == 1)
    static void qStatemachine_ExecSubStateIfAvailable(qSM_SubState_t substate, qSM_t* obj);
#endif
#if ( Q_QUEUES == 1)
    static qTrigger_t _qCheckQueueEvents(const qTask_t *Task);
    static qSize_t _qQueueValidPowerOfTwo(qSize_t k);
    static void qQueueCopyDataToQueue(qQueue_t *obj, const void *pvItemToQueue, qBool_t xPosition);
    static void qQueueMoveReader(qQueue_t *obj);
    static void qQueueCopyDataFromQueue(qQueue_t *obj, const void *pvBuffer );
#endif

#if ( Q_LISTS == 1 )
    static qNode_t* qList_NodeInit(void *node);
    static void qList_InsertAtFront(qList_t *list, qNode_t *node);
    static void qList_InserAtBack(qList_t *list, qNode_t *node);
    static qNode_t* qList_RemoveFront(qList_t *list);
    static qNode_t* qList_RemoveBack(qList_t *list);
#endif    
    
static char qNibbleToX(uint8_t value);    
qPutChar_t __qDebugOutputFcn = NULL;
#if ( Q_TRACE_VARIABLES == 1 )
    char qDebugTrace_Buffer[Q_DEBUGTRACE_BUFSIZE] = {0};
#endif
#define _qAbs(x)    ((((x)<0) && ((x)!=qPeriodic))? -(x) : (x))
/*========================== QuarkTS Private Macros ==========================*/
#define __qChainInitializer     ((qTask_t*)&_qSysTick_Epochs_)/*point to something that is not some task in the chain */
#define __qFSMCallbackMode      ((qTaskFcn_t)1)
#define _qTaskDeadlineReached(_TASK_)            ( ( 0ul == (_TASK_)->Interval ) || ( _qScheduler_TimeDeadlineCheck( (_TASK_)->ClockStart, (_TASK_)->Interval ) )  )
#define _qTaskHasPendingIterations(_TASK_)       ( (_qAbs((_TASK_)->Iterations)>0 ) || ( qPeriodic == (_TASK_)->Iterations) )

/*============================================================================*/
/*void qEnterCritical(void)

Enter a critical section. This function invokes the <Disabler> if available.
Please see <qSchedulerSetInterruptsED>

*/  
void qEnterCritical(void){
    if( NULL != QUARKTS.I_Disable ){
        QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
    }
}
/*============================================================================*/
/*void qEnterCritical(void)

Enter a critical section. This function invokes the <Enabler> if available.
Please see <qSchedulerSetInterruptsED>

*/ 
void qExitCritical(void){
    if( NULL != QUARKTS.I_Restorer ){
        QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
    }
}
/*============================================================================*/
/*qTime_t qClock2Time(const qClock_t t)

Convert the specified input time(epochs) to time(seconds)

Parameters:

    - t : time in epochs   

Return value:

    time (t) in seconds
*/
qTime_t qClock2Time(const qClock_t t){
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        return (qTime_t)t;
    #else
        #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
            return (qTime_t)(t/QUARKTS.TimmingBase);
        #else
            return (qTime_t)(QUARKTS.TimmingBase*((qTime_t)t));
        #endif      
    #endif      
}
/*============================================================================*/
/*qCLock_t qTime2Clock(const qTime_t t)

Convert the specified input time(seconds) to time(epochs)

Parameters:

    - t : time in seconds   

Return value:

    time (t) in epochs
*/
qClock_t qTime2Clock(const qTime_t t){
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        return (qClock_t)t;
    #else 
        #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
            return (qClock_t)(t*QUARKTS.TimmingBase);
        #else
            qTime_t epochs;
            epochs = t/QUARKTS.TimmingBase;
            return (qClock_t)epochs;
        #endif    
    #endif
}
/*============================================================================*/
/*
qTask_t* qTaskSelf(void)

Get current running task handle.

Return value:

    A pointer to the current running task.
    NULL when the scheduler it's in a busy state or when IDLE Task is running.
*/
qTask_t* qTaskSelf(void){
    return QUARKTS.CurrentRunningTask; /*get the handle of the current running task*/
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
qBool_t qTaskIsEnabled(const qTask_t *Task){
    qBool_t RetValue = qFalse;
    if( NULL != Task){
        RetValue = (qBool_t)Task->Flag[_qIndex_Enabled];
    }
    return RetValue;
}
/*============================================================================*/
/*void qSchedulerSetIdleTask(qTaskFcn_t Callback)

Establish the IDLE Task Callback

Parameters:

    - IDLE_Callback : A pointer to a void callback method with a qEvent_t 
                      parameter as input argument.
*/
void qSchedulerSetIdleTask(qTaskFcn_t Callback){
    QUARKTS.IDLECallback = Callback;
}
/*============================================================================*/
/*void qSchedulerRelease(void)

Disables the kernel scheduling. The main thread will continue after the
qSchedule() call.
*/
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
void qSchedulerRelease(void){
    QUARKTS.Flag.ReleaseSched = qTrue;
}
#endif
/*============================================================================*/
/*void qSchedulerSetReleaseCallback(qTaskFcn_t Callback)

Set/Change the scheduler release callback function

Parameters:
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
void qSchedulerSetReleaseCallback(qTaskFcn_t Callback){
    QUARKTS.ReleaseSchedCallback = Callback;
}
#endif
/*============================================================================*/
/*uint32_t qTaskGetCycles(const qTask_t *Task)

Retrieve the number of task activations.

Parameters:

    - Task : Pointer to the task node.

Return value:

    A unsigned long value containing the number of task activations.
*/
#if ( Q_TASK_COUNT_CYCLES == 1 )
uint32_t qTaskGetCycles(const qTask_t *Task){
    uint32_t RetValue = 0ul;
    if( NULL != Task ){
        RetValue = Task->Cycles;
    }
    return RetValue;
}
#endif
/*============================================================================*/
/*void qTaskSendNotification(qTask_t *Task, void* eventdata)

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
qBool_t qTaskSendNotification(qTask_t *Task, void* eventdata){
    qBool_t RetValue = qFalse;
    if( NULL != Task ){
        if( Task->Notification < QMAX_NOTIFICATION_VALUE ){
            Task->Notification++;
            Task->AsyncData = eventdata;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
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
qBool_t qSchedulerSpreadNotification(void *eventdata, const qTaskNotifyMode_t mode){
    qBool_t RetValue = qFalse;
    qTask_t *Task = NULL;
    if( ( Q_NOTIFY_SIMPLE == mode ) || ( Q_NOTIFY_QUEUED == mode ) ){
        RetValue = qTrue;
        for( Task = QUARKTS.Head ; NULL != Task; Task = Task->Next){
            if( qFalse == mode(Task, eventdata) ){
                RetValue = qFalse;
            }
        } 
    }
    return RetValue;
}
/*============================================================================*/
/*void qTaskSetTime(qTask_t *Task, qTime_t Value)

Set/Change the Task execution interval

Parameters:

    - Task : A pointer to the task node.
    - Value : Execution interval defined in seconds (floating-point format). 
              For immediate execution (tValue = qTimeImmediate).
*/
void qTaskSetTime(qTask_t *Task, const qTime_t Value){
    if( NULL != Task ){
        Task->Interval = qTime2Clock(Value);
    }
}
/*============================================================================*/
/*void qTaskSetIterations(qTask_t *Task, qIteration_t Value)

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
void qTaskSetIterations(qTask_t *Task, const qIteration_t Value){
    if( NULL != Task ){
        Task->Iterations = (qPeriodic==Value)? qPeriodic : -Value;
    }      
}
/*============================================================================*/
/*void qTaskSetPriority(qTask_t *Task, qPriority_t Value)

Set/Change the task priority value

Parameters:

    - Task : A pointer to the task node.
    - Value : Priority Value. [0(min) - 255(max)]
*/
void qTaskSetPriority(qTask_t *Task, const qPriority_t Value){
    if( NULL != Task ){
        QUARKTS.Flag.Init = qFalse; 
        Task->Priority = Value; 
    }
}
/*============================================================================*/
/*void qTaskSetCallback(qTask_t *Task, qTaskFcn_t Callback)

Set/Change the task callback function

Parameters:

    - Task : A pointer to the task node.
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
void qTaskSetCallback(qTask_t *Task, qTaskFcn_t CallbackFcn){
    if( NULL != Task ){
        Task->Callback = CallbackFcn;
    }    
}
/*============================================================================*/
/*void qTaskSetState(qTask_t *Task, qState_t State)

Set the task state (Enabled or Disabled)

Parameters:

    - Task : A pointer to the task node.
    - State : qEnabled or qDisabled 
*/
void qTaskSetState(qTask_t *Task, const qState_t State){
    if( NULL != Task ){
        if( State != Task->Flag[_qIndex_Enabled]){ 
            Task->Flag[_qIndex_Enabled] = State;
            Task->ClockStart = qSchedulerGetTick();
        }
    }
}
/*============================================================================*/
/*void qTaskSetData(qTask_t *Task, void* UserData)

Set the task data

Parameters:

    - Task : A pointer to the task node.

Return value:

    A void pointer to the task data.
*/
void qTaskSetData(qTask_t *Task, void* arg){
    if( NULL != Task ){
        Task->TaskData = arg;
    }
}
/*============================================================================*/
/*void qTaskClearTimeElapsed(qTask_t *Task)

Clear the elapsed time of the task. Restart the internal task tick;

Parameters:

    - Task : A pointer to the task node.
*/
void qTaskClearTimeElapsed(qTask_t *Task){
    if( NULL != Task ){
        Task->ClockStart = qSchedulerGetTick();
    }    
}
/*============================================================================*/
/*qBool_t qTaskQueueNotification(const qTask_t *Task, void* eventdata)

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
qBool_t qTaskQueueNotification(qTask_t *Task, void* eventdata){
    #if ( Q_PRIORITY_QUEUE == 1 )
        qBool_t RetValue = qFalse;
        volatile qQueueStack_t tmp;
        int16_t QueueMaxIndex;
        int16_t CurrentQueueIndex;
        QueueMaxIndex = ((int16_t)QUARKTS.QueueSize) - 1; /*to avoid side effects */
        CurrentQueueIndex = QUARKTS.QueueIndex; /*to avoid side effects */
        if( ( NULL != Task )  && ( CurrentQueueIndex < QueueMaxIndex) ) {/*check if data can be queued*/
            tmp.QueueData = eventdata;
            tmp.Task = Task;
            QUARKTS.QueueStack[++QUARKTS.QueueIndex] = tmp; /*insert task and the corresponding eventdata to the queue*/
            RetValue = qTrue;
        }
        return RetValue;
    #else
        return qFalse;
    #endif
}
/*============================================================================*/
/*void qSchedulerSetInterruptsED(void (*Restorer)(void), void (*Disabler)(void))

Set the hardware-specific code for global interrupt enable/disable. 
Setting this allows you to comunicate safely from Interrupts using queued notifications
or qQueues.

Parameters:

    - Restorer : The function with hardware specific code that enables or 
                 restores interrupts.
    - Disabler : The function with hardware specific code that disables interrupts.
*/ 
void qSchedulerSetInterruptsED(const qInt_Restorer_t Restorer, const qInt_Disabler_t Disabler){
    QUARKTS.I_Restorer = Restorer;
    QUARKTS.I_Disable = Disabler;
}
#if ( Q_PRIORITY_QUEUE == 1 )
/*============================================================================*/
static qTask_t* _qScheduler_PriorityQueueGet(void){
    qTask_t *xTask = NULL;
    uint8_t i;
    int16_t j;
    uint8_t IndexTaskToExtract = 0u;
    qPriority_t MaxPriorityValue;
    
    if( QUARKTS.QueueIndex >= 0 ){ /*queue has elements*/
        qEnterCritical(); 
        MaxPriorityValue = QUARKTS.QueueStack[0].Task->Priority;
        for( i = 1u ; ( i < QUARKTS.QueueSize ) ; i++){  /*walk through the queue to find the task with the highest priority*/
            if( NULL != QUARKTS.QueueStack[i].Task ){ /* tail is reached */
                break;
            }
            if( QUARKTS.QueueStack[i].Task->Priority > MaxPriorityValue ){ /*check if the queued task has the max priority value*/
                MaxPriorityValue = QUARKTS.QueueStack[i].Task->Priority; /*Reassign the max value*/
                IndexTaskToExtract = i;  /*save the index*/
            }
        }   
        QUARKTS.QueueData = QUARKTS.QueueStack[IndexTaskToExtract].QueueData; /*get the data from the queue*/
        xTask = QUARKTS.QueueStack[IndexTaskToExtract].Task; /*assign the task to the output*/
        xTask->State = qReady; /*set the task as ready*/
        QUARKTS.QueueStack[IndexTaskToExtract].Task = NULL; /*set the position in the queue as empty*/  
        for( j = (int16_t)IndexTaskToExtract ; j < QUARKTS.QueueIndex ; j++){ 
            QUARKTS.QueueStack[j] = QUARKTS.QueueStack[j+1]; /*shift the remaining items of the queue*/
        }
        QUARKTS.QueueIndex--;    /*decrease the index*/
        qExitCritical();
    }
    return xTask;
}
#endif
/*============================================================================*/
#if (Q_SETUP_TIME_CANONICAL == 1)
    void _qInitScheduler(const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, const uint8_t Size_Q_Stack){
#else
    void _qInitScheduler(const qGetTickFcn_t TickProvider, const qTimingBase_type BaseTimming, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, const uint8_t Size_Q_Stack){
#endif
    #if ( Q_PRIORITY_QUEUE == 1 )  
        uint8_t i;
    #endif
    QUARKTS.Head = NULL;
    #if ( Q_SETUP_TIME_CANONICAL != 1 )
        QUARKTS.TimmingBase = BaseTimming;
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
    QUARKTS.I_Restorer =  NULL;
    QUARKTS.I_Disable = NULL;
    QUARKTS.CurrentRunningTask = NULL;
    QUARKTS.GetSysTick = TickProvider;
    _qSysTick_Epochs_ = 0ul;
}
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
qBool_t qSchedulerAdd_Task(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg){
    qBool_t RetValue = qFalse;
    if( ( NULL!=Task ) && ( NULL != CallbackFcn ) ) {
        qSchedulerRemoveTask(Task); /*Remove the task if was previously added to the chain*/
        Task->Callback = CallbackFcn;
        Task->Interval = qTime2Clock(Time);
        Task->TaskData = arg;
        Task->Priority = Priority;
        Task->Iterations = ( qPeriodic == nExecutions )? qPeriodic : -nExecutions;    
        Task->Notification = 0u;
        Task->Flag[_qIndex_InitFlag] = qFalse;
        Task->Flag[_qIndex_QueueReceiver] = qFalse; 
        Task->Flag[_qIndex_QueueFull] = qFalse;
        Task->Flag[_qIndex_QueueCount] = qFalse;
        Task->Flag[_qIndex_QueueEmpty] = qFalse;
        Task->Flag[_qIndex_Enabled] = InitialState;
        Task->Next = NULL;  
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->Cycles = 0ul;
        #endif
        Task->ClockStart = qSchedulerGetTick();
        #if ( Q_QUEUES == 1)
            Task->Queue = NULL;
        #endif
        #if ( Q_FSM == 1)
            Task->StateMachine = NULL;
        #endif
        Task->State = qSuspended;
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
qBool_t qSchedulerAdd_EventTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg){
    return qSchedulerAdd_Task(Task, CallbackFcn, Priority, qTimeImmediate, qSingleShot, qDisabled, arg);
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
qBool_t qSchedulerAdd_StateMachineTask(qTask_t *Task, qPriority_t Priority, qTime_t Time,
                            qSM_t *StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg){
    qBool_t RetValue = qFalse;
    if( ( NULL != StateMachine ) && ( NULL != InitState ) ){
        if ( qTrue == qSchedulerAdd_Task(Task, __qFSMCallbackMode, Priority, Time, qPeriodic, InitialTaskState, arg) ){
            qStateMachine_Init(StateMachine, InitState, SuccessState, FailureState, UnexpectedState, BeforeAnyState);
            Task->StateMachine = StateMachine;
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
qBool_t qSchedulerRemoveTask(qTask_t *Task){
    qTask_t *tmp = QUARKTS.Head;
    qTask_t *prev = NULL;
    qBool_t RetValue = qFalse;

    if( NULL != tmp){
        while( ( tmp != Task ) && ( NULL != tmp->Next ) ){ /*find the task to remove*/
            prev = tmp; /*keep on track the previous node*/
            tmp = tmp->Next;
        }
        if( tmp == Task ){ /*remove the task if was found on the chain*/
            if( NULL != prev){
                prev->Next = tmp->Next; /*make link between adjacent nodes, this cause that the task being removed from the chain*/
            }
            else{
                QUARKTS.Head = tmp->Next; /*if the task is the head of the chain, move the head to the next node*/
            }
            Task->Next = NULL; /*Just in case the deleted task needs to be added later to the scheduling scheme, otherwise, this would fuck the whole chain*/
            RetValue =  qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
static qTask_t* _qScheduler_PriorizedInsert(qTask_t *head, qTask_t *Task){ /*return the new head if modified*/
    qTask_t *RetValue = head; /*if no change in the head, keep it*/
    qPriority_t TaskPriority;
    qPriority_t HeadPriority;
    if( NULL == head){ /*Is the first task in the scheme? */
        Task->Next = head; /*move the head and just add the task node on top*/
        RetValue =  Task; /*this task will be the new head*/
    }
    else{
        TaskPriority = Task->Priority; /*to avoid side effects*/
        HeadPriority = head->Priority; /*to avoid side effects*/
        if( TaskPriority > HeadPriority ){ /* the task has the highest priority over all */
            Task->Next = head; /*move the head and just add the task node on top*/
            RetValue =  Task; /*this task will be the new head*/
        }
        else{
            _qScheduler_FindPlace( head, Task);
        }       
    }
    return RetValue; 
}
/*============================================================================*/
static void _qScheduler_FindPlace(qTask_t *head, qTask_t *Task){ /*find a new position for the task in the chain, when finded, put the task there*/
    qTask_t *tmp_node = NULL;
    qPriority_t PrioTask;
    PrioTask = Task->Priority; /*to avoid side effects*/
    tmp_node = head; /*start the head with the highest priority task*/
    while( ( NULL != tmp_node->Next ) && ( PrioTask <= tmp_node->Next->Priority ) ) { 
        tmp_node = tmp_node->Next; /*find the right place for this task according its priority*/
    }
    Task->Next = tmp_node->Next; /*the the new task  will be placed just after tmp*/
    tmp_node->Next = Task; /*assign the task*/    
}
#if ( Q_AUTO_CHAINREARRANGE == 1 )
/*============================================================================*/
static qTask_t* _qScheduler_RearrangeChain(qTask_t *head){ /*this method rearrange the chain according the priority of all its nodes*/
    qTask_t *new_head = NULL, *tmp = head, *tmp1 = NULL;
    qEnterCritical();
    while( NULL != tmp ){ /*start with a new head and re-insert the entire chain*/
        tmp1 = tmp;
        tmp = tmp->Next;
        new_head = _qScheduler_PriorizedInsert( new_head, tmp1);  
    }
    QUARKTS.Flag.Init = qTrue; /*set the initialization flag*/
    qExitCritical();
    return new_head; /*return the new head*/
}
#endif
/*============================================================================*/
/*qBool_t qTaskAttachQueue(qTask_t *Task, qQueue_t *Queue, const qRBLinkMode_t Mode, uint8_t arg)

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
#if ( Q_QUEUES == 1)
qBool_t qTaskAttachQueue(qTask_t *Task, qQueue_t *Queue, const qRBLinkMode_t Mode, uint8_t arg){
    qBool_t RetValue = qFalse;
    if( ( NULL != Queue ) && ( NULL != Task ) && ( Mode >= qQUEUE_RECEIVER ) && ( Mode <= qQUEUE_EMPTY)  ){
        if( NULL != Queue->pHead ) {
            if( Mode == qQUEUE_COUNT ){
                Task->Flag[Mode] = arg; /*if mode is qQUEUE_COUNT, use their arg value as count*/
            }
            else{
                Task->Flag[Mode] = ( arg != qFalse )? qATTACH :qDETACH ; 
            }
            Task->Queue = ( arg > 0u )? Queue : NULL; /*reject, no valid arg input*/
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
static qTrigger_t _qCheckQueueEvents(const qTask_t *Task){
    qTrigger_t RetValue = qTriggerNULL;
    uint8_t FullFlag, CountFlag, ReceiverFlag, EmptyFlag;
    qBool_t IsFull, IsEmpty;
    qSize_t CurrentQueueCount;
    if( NULL != Task ){
        if( NULL != Task->Queue){
            FullFlag = Task->Flag[_qIndex_QueueFull]; /*to avoid side effects*/
            CountFlag = Task->Flag[_qIndex_QueueCount]; /*to avoid side effects*/
            ReceiverFlag = Task->Flag[_qIndex_QueueReceiver]; /*to avoid side effects*/
            EmptyFlag = Task->Flag[_qIndex_QueueEmpty]; /*to avoid side effects*/
            CurrentQueueCount = qQueueCount(Task->Queue); /*to avoid side effects*/
            IsFull = qQueueIsFull(Task->Queue); /*to avoid side effects*/
            IsEmpty = qQueueIsEmpty(Task->Queue); /*to avoid side effects*/
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
static void _qTriggerReleaseSchedEvent(void){
    QUARKTS.Flag.Init = qFalse;
    QUARKTS.Flag.ReleaseSched = qFalse;   
    QUARKTS.EventInfo.FirstCall = (qFalse == QUARKTS.Flag.FCallReleased)? qTrue : qFalse;    
    QUARKTS.EventInfo.Trigger = bySchedulingRelease;
    QUARKTS.EventInfo.TaskData = NULL;
    if( NULL != QUARKTS.ReleaseSchedCallback ){
        QUARKTS.ReleaseSchedCallback((qEvent_t)&QUARKTS.EventInfo);
    }
    QUARKTS.Flag.FCallIdle = qTrue;      
}
#endif
/*============================================================================*/
/*
void qSchedulerSysTick(void)

Feed the scheduler system tick. If TickProviderFcn is not provided in qSchedulerSetup, this 
call is mandatory and must be called once inside the dedicated timer interrupt service routine (ISR). 
*/    
void qSchedulerSysTick(void){_qSysTick_Epochs_++;}
/*============================================================================*/
qClock_t qSchedulerGetTick(void){   
	return ( NULL != QUARKTS.GetSysTick )? QUARKTS.GetSysTick() : _qSysTick_Epochs_;
}
/*============================================================================*/
/*void qSchedule(void)
    
Executes the task-scheduler scheme. It must be called once after the task
pool has been defined.

  Note : qScheduleRun keeps the application in an endless loop
*/
void qSchedulerRun(void){
    qTask_t *Task = NULL; /*this pointer will hold the current node from the chain and/or the top enqueue node if available*/
    QUARKTS.Flag.Init = qTrue; 
    do{
        #if ( Q_AUTO_CHAINREARRANGE == 1 )
        if( qFalse == QUARKTS.Flag.Init){ /*if initial scheduling conditions changed*/
            QUARKTS.Head = _qScheduler_RearrangeChain(QUARKTS.Head); /*sort the chain by priority (init flag internally set)*/
        } 
        #endif
        #if ( Q_PRIORITY_QUEUE == 1 )
        if( NULL != ( Task = _qScheduler_PriorityQueueGet() ) ){ /*extract a task from the front of the priority queue*/
            Task->State = _qScheduler_Dispatch(Task, byNotificationQueued);  /*Available queueded task will be dispatched in every scheduling cycle : the queue has the higher precedence*/
        }     
        #endif
        if( _qScheduler_ReadyTasksAvailable() ){  /*Check if all the tasks from the chain fulfill the conditions to get the qReady state, if at least one gained it,  enter here*/
            while( NULL != (Task = _qScheduler_GetNodeFromChain()) ){ /*Get node by node from the chain until no more available*/
                Task->State = (qTaskState_t) ((qReady == Task->State) ? _qScheduler_Dispatch(Task, Task->Trigger) : qWaiting);  /*Dispatch the qReady tasks, otherwise put it in qWaiting State*/
            }
        }
        else if( ( NULL==Task ) && ( NULL != QUARKTS.IDLECallback) ) {
             _qScheduler_Dispatch(NULL, byNoReadyTasks); /*no tasks are available for execution, run the idle task*/
        }
        else{
            /*nothing to do*/
        }    
    }
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        while(qFalse == QUARKTS.Flag.ReleaseSched); /*scheduling end-point*/ 
        _qTriggerReleaseSchedEvent(); /*check for scheduling-release request*/
    #else
        while(1);
    #endif
}
/*============================================================================*/
static qTask_t* _qScheduler_GetNodeFromChain(void){ 
    static qTask_t *ChainIterator = __qChainInitializer; /*used to keep on track the current chain position*/
    qTask_t *Node;  /*used the hold the node*/
    if( __qChainInitializer == ChainIterator ){ /*First call*/
        ChainIterator = QUARKTS.Head; /*start from the head*/
    } 
    Node = ChainIterator; /*obtain the current node from the chain*/
    ChainIterator = (ChainIterator)? ChainIterator->Next : QUARKTS.Head; /*Tail reached, reset the iterator to the head*/
    return Node; /*return the task node at current chain position*/
}
/*============================================================================*/
static qTaskState_t _qScheduler_Dispatch(qTask_t *Task, const qTrigger_t Event){
    qIteration_t TaskIteration;
    if( byNoReadyTasks == Event){
        QUARKTS.EventInfo.FirstCall = (qFalse == QUARKTS.Flag.FCallIdle)? qTrue : qFalse;
        QUARKTS.EventInfo.Trigger = Event;
        QUARKTS.EventInfo.TaskData = NULL;
        QUARKTS.IDLECallback( (qEvent_t)&QUARKTS.EventInfo ); /*run the idle callback*/
        QUARKTS.Flag.FCallIdle = qTrue;   
    }
    else{
        switch(Event){ /*take the necessary actions before dispatching, depending on the event that triggered the task*/
            case byTimeElapsed:
                /*handle the iteration value and the FirstIteration flag*/
                TaskIteration = Task->Iterations;
                QUARKTS.EventInfo.FirstIteration = ( ( TaskIteration != qPeriodic ) && ( TaskIteration < 0 ) )? qTrue : qFalse;
                Task->Iterations = ( QUARKTS.EventInfo.FirstIteration )? -Task->Iterations : Task->Iterations;
                if( qPeriodic != Task->Iterations){
                    Task->Iterations--; /*Decrease the iteration value*/
                }
                QUARKTS.EventInfo.LastIteration = (0 == Task->Iterations )? qTrue : qFalse; 
                if( QUARKTS.EventInfo.LastIteration ) {
                    Task->Flag[_qIndex_Enabled] = qFalse; /*When the iteration value is reached, the task will be disabled*/ 
                }           
                break;
            case byNotificationSimple:
                QUARKTS.EventInfo.EventData = Task->AsyncData; /*Transfer async-data to the eventinfo structure*/
                Task->Notification--; /* = qFalse */ /*Clear the async flag*/            
                break;
        #if ( Q_QUEUES == 1)    
            case byQueueReceiver:
                QUARKTS.EventInfo.EventData = qQueuePeek(Task->Queue); /*the EventData will point to the RBuffer front-data*/
                break;
            case byQueueFull: case byQueueCount: case byQueueEmpty: 
                QUARKTS.EventInfo.EventData = (void*)Task->Queue;  /*the EventData will point to the the linked RingBuffer*/
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
        Task->State = qRunning; /*put the task in running state*/
        /*Fill the event info structure: Trigger, FirstCall and TaskData */       
        QUARKTS.EventInfo.Trigger = Event;
        QUARKTS.EventInfo.FirstCall = ( qFalse == Task->Flag[_qIndex_InitFlag] )? qTrue : qFalse;
        QUARKTS.EventInfo.TaskData = Task->TaskData;
        
        QUARKTS.CurrentRunningTask = Task; /*needed for qTaskSelf()*/
        #if ( Q_FSM == 1)
            if ( ( NULL != Task->StateMachine ) && ( __qFSMCallbackMode == Task->Callback ) ){
                qStateMachine_Run(Task->StateMachine, (void*)&QUARKTS.EventInfo);  /*If the task has a FSM attached, just run it*/  
            }
            else if ( NULL != Task->Callback ) {
                Task->Callback((qEvent_t)&QUARKTS.EventInfo); /*else, just launch the callback function*/ 
            }       
            else{
                /*nothing to do*/
            }
        #else
            if ( NULL != Task->Callback ) {
                Task->Callback((qEvent_t)&QUARKTS.EventInfo); /*else, just launch the callback function*/ 
            }     
        #endif
        QUARKTS.CurrentRunningTask = NULL;
        #if ( Q_QUEUES == 1) 
            if( byQueueReceiver == Event){
                qQueueRemoveFront(Task->Queue);  /*remove the data from the Queue, if the event was byQueueDequeue*/
            } 
        #endif
        Task->Flag[_qIndex_InitFlag] = qTrue; /*clear the init flag*/
        QUARKTS.EventInfo.FirstIteration = qFalse;
        QUARKTS.EventInfo.LastIteration =  qFalse; 
        QUARKTS.EventInfo.EventData = NULL; /*clear the eventdata*/
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->Cycles++; /*increase the task cycles value*/
        #endif
    }
    return qSuspended;
}
/*============================================================================*/
static qBool_t _qScheduler_TransitionTo(qTask_t *task, qTaskState_t state, qTrigger_t trg){
    task->State = state;
    task->Trigger = trg;
    return qTrue;
}
/*============================================================================*/
qBool_t _qScheduler_TimeDeadlineCheck(qClock_t ti, qClock_t td){
    qBool_t RetValue = qFalse;
    if( (qSchedulerGetTick() - ti) >= td ){
        RetValue = qTrue;
    }
    return RetValue; 
}
/*============================================================================*/
static qBool_t _qTaskDeadLineReached(qTask_t *task){
    qBool_t RetValue = qFalse;
    qBool_t EnabledFlag;
    qIteration_t TaskIterations;
    qClock_t TaskInterval;
    qBool_t DeadLineFlag;
    EnabledFlag = task->Flag[_qIndex_Enabled] ; /*avoid side efects in the next check*/
    if( EnabledFlag ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
        TaskIterations = task->Iterations; /*avoid side efects in the next check*/
        if( ( _qAbs( TaskIterations ) > 0 ) || ( qPeriodic == TaskIterations ) ){ /*then task should be periodic or must have available iters*/
            TaskInterval = task->Interval; /*avoid side efects in the next check*/
            DeadLineFlag = _qScheduler_TimeDeadlineCheck( task->ClockStart, TaskInterval );
            if( ( 0ul == TaskInterval ) || ( DeadLineFlag ) ){ /*finally, check the time deadline*/
                RetValue = qTrue;                
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
static qBool_t _qScheduler_ReadyTasksAvailable(void){ /*this method checks for tasks that fulfill the conditions to get the qReady state*/
    qTask_t *Task = NULL;
    #if ( Q_QUEUES == 1) 
    qTrigger_t trg = qTriggerNULL;
    #endif
    qBool_t nTaskReady = qFalse; /*the return is to notify that at least one task gained the qReady state*/
    for( Task = QUARKTS.Head ; NULL != Task ; Task = Task->Next){ /*loop every task in the chain : only one event will be verified by node*/
        if( _qTaskDeadLineReached(Task) ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
            Task->ClockStart = qSchedulerGetTick(); /*Restart the task time*/
            nTaskReady = _qScheduler_TransitionTo( Task, qReady, byTimeElapsed); /*put the task in ready state with their corresponding trigger */                  
        }
        #if ( Q_QUEUES == 1)  
        else if( qTriggerNULL !=  (trg = _qCheckQueueEvents( Task ) ) ){ /*If the deadline has not met, check if there is a queue event available*/
            nTaskReady = _qScheduler_TransitionTo( Task, qReady, trg ); /*put the task in ready state with their corresponding trigger */   
        }
        #endif
        else if( Task->Notification ){   /*The last check will be if the task has an async event*/
            nTaskReady = _qScheduler_TransitionTo( Task, qReady, byNotificationSimple); /*put the task in ready state with their corresponding trigger */   
        }
        else{
            Task->State = qSuspended; /*If the task has no available events, put it in a suspended state*/        
        }
    }
    return nTaskReady;
}
#if (Q_FSM == 1)
/*============================================================================*/
/*qBool_t qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);

Initializes a finite state machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - InitState : The first state to be performed. This argument is a pointer 
                  to a callback function, returning qSM_Status_t and with a 
                  qFSM_t pointer as input argument.
    - SuccessState : Sub-State performed after a state finish with return status 
                     qSM_EXIT_SUCCESS. This argument is a pointer to a callback
                     function with a qFSM_t pointer as input argument.
    - FailureState : Sub-State performed after a state finish with return status 
                     qSM_EXIT_FAILURE. This argument is a pointer to a callback
                     function with a qFSM_t pointer as input argument.
    - UnexpectedState : Sub-State performed after a state finish with return status
                        value between -32766 and 32767. This argument is a 
                        pointer to a callback function with a qFSM_t pointer
                        as input argument.

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState, qSM_SubState_t BeforeAnyState){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( NULL != InitState) ){
        obj->NextState = InitState;
        qConstField_Set(qSM_State_t, obj->PreviousState)/*obj->PreviousState*/ = NULL;
        qConstField_Set(qBool_t, obj->StateFirstEntry)/*obj->StateFirstEntry*/ = 0u;
        qConstField_Set(qSM_Status_t, obj->PreviousReturnStatus)/*obj->PreviousReturnStatus*/ = qSM_EXIT_SUCCESS;
        qConstField_Set(qSM_SubState_t, obj->qPrivate.__Failure)/*obj->qPrivate.__Failure*/ = FailureState;
        qConstField_Set(qSM_SubState_t, obj->qPrivate.__Success)/*obj->qPrivate.__Success*/ = SuccessState;
        qConstField_Set(qSM_SubState_t, obj->qPrivate.__Unexpected)/*obj->qPrivate.__Unexpected*/ = UnexpectedState;
        qConstField_Set(qSM_SubState_t, obj->qPrivate.__BeforeAnyState)/*obj->qPrivate.__BeforeAnyState*/ = BeforeAnyState;
        qConstField_Set(qSM_State_t, obj->LastState)/*obj->LastState*/ = NULL;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
static void qStatemachine_ExecSubStateIfAvailable(qSM_SubState_t substate, qSM_t* obj){
    if( NULL != substate ){
        substate(obj);
    }
}
/*============================================================================*/
/*void qStateMachine_Run(qSM_t *obj, void* Data)

Execute the Finite State Machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - Data : Represents the FSM arguments. All arguments must be passed by 
             reference and cast to (void *). Only one argument is allowed, so,
             for multiple arguments, create a structure that contains all of 
             the arguments and pass a pointer to that structure.
*/    
void qStateMachine_Run(qSM_t *obj, void *Data){
    qSM_State_t prev  = NULL; /*used to hold the previous state*/
    if( NULL != obj ){
        qConstField_Set(void* ,obj->Data)/*obj->Data*/ = Data;   /*pass the data through the fsm*/
        qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.__BeforeAnyState , obj); /*eval the BeforeAnyState if available*/
        if( NULL != obj->NextState ){ /*eval nextState if available*/
            qConstField_Set(qBool_t, obj->StateFirstEntry)/*obj->StateFirstEntry*/ = (obj->LastState != obj->NextState)? qTrue : qFalse;  /*Get the StateFirstEntry flag*/
            if( obj->StateFirstEntry ){ /*if StateFistEntry is set, update the PreviousState*/
                qConstField_Set(qSM_State_t, obj->PreviousState)/*obj->PreviousState*/ = obj->LastState ; 
            }
            prev = obj->NextState; /*keep the next state in prev for LastState update*/
            qConstField_Set(qSM_Status_t, obj->PreviousReturnStatus)/*obj->PreviousReturnStatus*/ = obj->NextState(obj); /*Eval the current state, and get their return status*/
            qConstField_Set(qSM_State_t, obj->LastState)/*obj->LastState*/ = prev; /*update the LastState*/
        }
        else{
            qConstField_Set(qSM_Status_t, obj->PreviousReturnStatus)/*obj->PreviousReturnStatus*/ = qSM_EXIT_FAILURE; /*otherwise jump to the failure state*/
        }
        /*Check return status to eval extra states*/
        if( qSM_EXIT_FAILURE == obj->PreviousReturnStatus ){
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.__Failure, obj); /*Run failure state if available*/
        }
        else if (qSM_EXIT_SUCCESS == obj->PreviousReturnStatus){
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.__Success, obj); /*Run success state if available*/
        } 
        else{
            qStatemachine_ExecSubStateIfAvailable( obj->qPrivate.__Unexpected, obj ); /*Run unexpected state if available*/
        }
    }
 }
/*============================================================================*/
/*void qStateMachine_Attribute(qSM_t *obj, qFSM_Attribute_t Flag , qSM_State_t  s, qSM_SubState_t subs)

Change attributes or set actions to the Finite State Machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
    - Flag: The attribute/action to be taken
         > qSM_RESTART : Restart the FSM (val argument must correspond to the init state)
         > qSM_CLEAR_STATE_FIRST_ENTRY_FLAG: clear the entry flag for the 
                current state if the NextState field doesn't change.
         > qSM_FAILURE_STATE: Set the Failure State
         > qSM_SUCCESS_STATE: Set the Success State
         > qSM_UNEXPECTED_STATE: Set the Unexpected State
         > qSM_BEFORE_ANY_STATE: Set the state executed before any state.
    - s : The new value for state (only apply in qSM_RESTART). If not used, pass NULL.
    - subs : The new value for SubState (only apply in qSM_FAILURE_STATE, qSM_SUCCESS_STATE, 
             qSM_UNEXPECTED_STATE, qSM_BEFORE_ANY_STATE). If not used, pass NULL.
*/    
void qStateMachine_Attribute(qSM_t *obj, qFSM_Attribute_t Flag , qSM_State_t  s, qSM_SubState_t subs){
    switch(Flag){
        case qSM_RESTART:
            obj->NextState = (qSM_State_t)s;
            qConstField_Set(qSM_State_t, obj->PreviousState)/*obj->PreviousState*/ = NULL;
            qConstField_Set(qSM_State_t, obj->LastState)/*obj->LastState*/ = NULL;
            qConstField_Set(qBool_t, obj->StateFirstEntry)/*obj->StateFirstEntry*/ = 0u;
            qConstField_Set(qSM_Status_t, obj->PreviousReturnStatus)/*obj->PreviousReturnStatus*/ = qSM_EXIT_SUCCESS;            
            break;
        case qSM_CLEAR_STATE_FIRST_ENTRY_FLAG:
            qConstField_Set(qSM_State_t, obj->PreviousState)/*obj->PreviousState*/  = NULL;
            qConstField_Set(qSM_State_t, obj->LastState)/*obj->LastState*/ = NULL;
            break;
        case qSM_FAILURE_STATE:
            qConstField_Set(qSM_SubState_t, obj->qPrivate.__Failure)/*obj->qPrivate.__Failure*/ = (qSM_SubState_t)subs;
            break;
        case qSM_SUCCESS_STATE:
            qConstField_Set(qSM_SubState_t, obj->qPrivate.__Success)/*obj->qPrivate.__Success*/ = (qSM_SubState_t)subs;
            break;    
        case qSM_UNEXPECTED_STATE:
            qConstField_Set(qSM_SubState_t, obj->qPrivate.__Unexpected)/*obj->qPrivate.__Unexpected*/ = (qSM_SubState_t)subs;
            break;   
        case qSM_BEFORE_ANY_STATE:
            qConstField_Set(qSM_SubState_t, obj->qPrivate.__BeforeAnyState)/*obj->qPrivate.__BeforeAnyState*/ = (qSM_SubState_t)subs;
            break;              
        default:
            break;
    }
}
#endif /* Q_FSM */
#ifdef __IAR_SYSTEMS_ICC__
#else
#endif
/*============================================================================*/
/*qBool_t qSTimerSet(qSTimer_t obj, const qTime_t Time)
 
Set the expiration time for a STimer. On success, the STimer gets
armed immediately

Parameters:

    - obj : A pointer to the STimer object.
    - Time : The expiration time(Must be specified in seconds).

    > Note 1: The scheduler must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greater than
              the scheduler-Tick.

Return value:

    Returns qTrue on success, otherwise, returns qFalse.
*/
qBool_t qSTimerSet(qSTimer_t *obj, const qTime_t Time){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        qConstField_Set(qClock_t, obj->TV)/*obj->TV*/ = qTime2Clock(Time); /*set the STimer time in epochs*/
        qConstField_Set(qClock_t, obj->Start)/*obj->Start*/ = qSchedulerGetTick(); /*set the init time of the STimer with the current system epoch value*/
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qSTimerFreeRun(qSTimer_t *obj, const qTime_t Time)

Non-Blocking STimer check with automatic arming. 
Behavior:
If disarmed, it gets armed immediately with the specified time.
If armed, the time argument is ignored and the API only checks for expiration.
When the time expires, the STimer gets armed immediately taking the specified time.

Parameters:

    - obj : A pointer to the STimer object.
    - Time : The expiration time(Must be specified in seconds). 
 
    > Note 1: The scheduler must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greater than
              the scheduler-Tick.
    > Note 3: Time parameter is only taken when the STimer is re-armed
  
Return value:

    Returns qTrue when STimer expires, otherwise, returns qFalse.
    > Note 4: A disarmed STimer also returns qFalse.
    > Note 5: After the STimer expiration,  qSTimerFreeRun re-arms the STimer
*/
qBool_t qSTimerFreeRun(qSTimer_t *obj, const qTime_t Time){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){ 
        if( QSTIMER_ARMED == qSTimerStatus(obj) ){ 
            if( qSTimerExpired(obj) ){
                qSTimerDisarm(obj); 
                RetValue = qTrue;
            }
        }
        else{
            qSTimerSet(obj, Time); 
        }
    }
    return RetValue;   
}
/*============================================================================*/
/*qBool_t qSTimerExpired(qSTimer_t *obj)

Non-Blocking STimer check

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    Returns qTrue when STimer expires, otherwise, returns qFalse.
    > Note 1: A disarmed STimer also returns false.

*/
qBool_t qSTimerExpired(const qSTimer_t *obj){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimerStatus(obj) ){
            RetValue = ( qSTimerElapsed(obj) >= obj->TV )? qTrue : qFalse; 
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qTime_t qSTimerElapsed(qSTimer_t *obj)

Query the elapsed time

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    The Elapsed time specified in epochs
*/
qClock_t qSTimerElapsed(const qSTimer_t *obj){
    qClock_t RetValue = 0ul;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimerStatus(obj) ) {
            RetValue = qSchedulerGetTick() - obj->Start;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qClock_t qSTimerRemainingEpochs(qSTimer_t *obj)

Query the remaining epochs

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    The remaining time specified in epochs
*/
qClock_t qSTimerRemaining(const qSTimer_t *obj){
    qClock_t RetValue = 0xFFFFFFFFul;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimerStatus(obj) ) {
            RetValue = obj->TV - qSTimerElapsed(obj);
        }
    }
    return RetValue;
}
/*============================================================================*/
/*void qSTimerDisarm(qSTimer_t *obj)

Disarms the STimer

Parameters:

    - obj : A pointer to the STimer object.  
*/
void qSTimerDisarm(qSTimer_t *obj){
    if( NULL != obj ){
        qConstField_Set(qClock_t, obj->TV) = QSTIMER_DISARM_VALUE;
        qConstField_Set(qClock_t, obj->Start) /*obj->Start*/ = QSTIMER_DISARM_VALUE;
    }
}
/*============================================================================*/
/*qBool_t qSTimerStatus(qSTimer_t *obj)

Get the current status of the STimer (Armed or Disarmed)

Parameters:

    - obj : A pointer to the STimer object.  

Return value:

    qTrue when armed, otherwise qFalse when disarmed
*/
qBool_t qSTimerStatus(const qSTimer_t *obj){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        RetValue =  ( obj->TV != QSTIMER_DISARM_VALUE )? qTrue : qFalse;
    } 
    return RetValue;
}

#if ( Q_QUEUES == 1)
/*============================================================================*/
static qSize_t _qQueueValidPowerOfTwo(qSize_t k){
    uint16_t i;
    qSize_t r = k;
    if( ((k-1u) & k) != 0u ){
        k--;
        for( i = 1u; i<sizeof(uint16_t)*8u; i= (uint16_t) (i * 2u)){
            k = k | (qSize_t)( k >> i );
        }
        k = (qSize_t) ((k + 1u) >> 1u);
    }
    return (k<r)? k*2u : k;
}
/*============================================================================*/
/*qBool_t qQueueCreate(qQueue_t *obj, void* DataBlock, const qSize_t ElementSize, const qSize_t ElementCount)
 
Create and configures a Queue. Here, the RAM used to hold the queue data <DataBlock>
is statically allocated at compile time by the application writer.
 
Parameters:

    - obj : a pointer to the Queue object
    - DataBlock :  data block or array of data
    - ElementSize : size of one element in the data block
    - ElementCount : size of one element in the data block
 
Note: Element_count should be a power of two, or it will only use the next 
      higher power of two

    Return value:

    qTrue on success, otherwise returns qFalse.

 */
qBool_t qQueueCreate(qQueue_t *obj, void* DataArea, qSize_t ItemSize, qSize_t ItemsCount ){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( NULL != DataArea ) && ( ItemSize > 0u ) && ( ItemsCount > 0u) ){
        obj->ItemsCount = ItemsCount;   /* Initialise the queue members*/
        obj->ItemSize = ItemSize;
        obj->pHead = DataArea;
        obj->pTail = obj->pHead + (obj->ItemsCount * obj->ItemSize); 
        qQueueReset(obj);
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qQueueReset(qQueue_t *obj)
 
Resets a queue to its original empty state.
 
Parameters:

    - obj : a pointer to the Queue object
*/
void qQueueReset(qQueue_t *obj){
    if (NULL != obj ){
        qEnterCritical();
        obj->ItemsWaiting = 0u;
        obj->pcWriteTo = obj->pHead;
        obj->pcReadFrom = obj->pHead + ( ( obj->ItemsCount - 1u ) * obj->ItemSize );
        qExitCritical();
    }
}
/*============================================================================*/
/*qBool_t qQueueIsEmpty(qQueue_t *obj)
 
Returns the empty status of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if the Queue is empty, qFalse if it is not.
 */
qBool_t qQueueIsEmpty(const qQueue_t *obj){
    qBool_t RetValue = qTrue;
    if( NULL != obj){
        if( obj->ItemsWaiting == 0u ){
            RetValue = qTrue;
        }
        else{
            RetValue = qFalse;
        }  
    }
    return RetValue;   
}
/*============================================================================*/
/*qSize_t qQueueCount(qQueue_t *obj)
 
Returns the number of items in the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    The number of elements in the queue
 */
qSize_t qQueueCount(const qQueue_t *obj){
    qSize_t RetValue = 0u;
    if ( NULL != obj ){
        RetValue = obj->ItemsWaiting;
    } 
    return RetValue;
}
/*============================================================================*/
/*qBool_t qQueueIsFull(qQueue_t *obj)
 
Returns the full status of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if the Queue is full, qFalse if it is not.
 */
/*============================================================================*/
qBool_t qQueueIsFull(const qQueue_t *obj){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( obj->ItemsWaiting == obj->ItemsCount ){
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*void* qQueuePeek(qQueue_t *obj)
 
Looks at the data from the front of the Queue without removing it. 
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    Pointer to the data, or NULL if there is nothing in the queue
 */
void* qQueuePeek(const qQueue_t *obj){
    uint8_t *RetValue = NULL;
    if( NULL != obj ){
        if( obj->ItemsWaiting > 0u ){
            qEnterCritical();
            RetValue = (void*)(obj->pcReadFrom + obj->ItemSize);
            if( RetValue >= obj->pTail ){
                RetValue = obj->pHead;
            }
            qExitCritical();
        }
    }
    return (void*)RetValue;
}
/*============================================================================*/
/*qBool_t qQueueRemoveFront(qQueue_t *obj)
 
Remove the data located at the front of the Queue
 
Parameters:

    - obj : a pointer to the Queue object
  
Return value:

    qTrue if data was removed from the Queue, otherwise returns qFalse
 */
qBool_t qQueueRemoveFront(qQueue_t *obj){
    qBool_t RetValue = qFalse;
    if( NULL != obj){
        if( obj->ItemsWaiting > 0u ){
            qEnterCritical();
            qQueueMoveReader(obj);
            --( obj->ItemsWaiting ); /* remove the data. */
            qExitCritical();
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
static void qQueueCopyDataToQueue(qQueue_t *obj, const void *pvItemToQueue, qBool_t xPosition){
    if( QUEUE_SEND_TO_BACK == xPosition ){
        memcpy( (void*) obj->pcWriteTo, pvItemToQueue, (unsigned)obj->ItemSize );
        obj->pcWriteTo += obj->ItemSize;
        if( obj->pcWriteTo >= obj->pTail ){
            obj->pcWriteTo = obj->pHead;
        }
              
    }
    else{
        memcpy( (void*) obj->pcReadFrom, pvItemToQueue, (unsigned)obj->ItemSize );
        obj->pcReadFrom -= obj->ItemSize;
        if( obj->pcReadFrom < obj->pHead ){
            obj->pcReadFrom = ( obj->pTail - obj->ItemSize ); 
        }   
    }
    ++( obj->ItemsWaiting );
}
/*==================================================================================*/
static void qQueueMoveReader(qQueue_t *obj){
    obj->pcReadFrom += obj->ItemSize;
    if( obj->pcReadFrom >= obj->pTail ){
        obj->pcReadFrom = obj->pHead;
    }
}
/*==================================================================================*/
static void qQueueCopyDataFromQueue(qQueue_t *obj, const void *pvBuffer ){
    qQueueMoveReader(obj);
    memcpy( (void*) pvBuffer, (void*)obj->pcReadFrom, (unsigned)obj->ItemSize );
}
/*============================================================================*/
/*void* qQueueReceive(qQueue_t *obj, void *dest)
 
Receive an item from a queue (and removes it). The item is received by copy so a 
buffer of adequate size must be provided. The number of bytes copied into the buffer 
was defined when the queue was created.
 
Parameters:

    - obj : a pointer to the Queue object
    - dest: Pointer to the buffer into which the received item will be copied.
  
Return value:

    qTrue if data was retrieved from the Queue, otherwise returns qFalse
*/
qBool_t qQueueReceive(qQueue_t *obj, void *dest){
    qBool_t RetValue = qFalse;
    if( obj->ItemsWaiting > 0u ){
        qEnterCritical();
        qQueueCopyDataFromQueue( obj, dest );
        --( obj->ItemsWaiting ); /* remove the data. */
        qExitCritical();
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qQueueGenericSend(qQueue_t *obj, void *ItemToQueue, qBool_t InsertMode)
 
Post an item to the back of the queue. The item is queued by copy, not by reference
 
Parameters:

    - obj : a pointer to the Queue object
    - ItemToQueue : A pointer to the item that is to be placed on the queue. The size of 
            the items the queue will hold was defined when the queue was created, 
            so this many bytes will be copied from ItemToQueue into the queue storage
            area.
    - InsertMode : Can take the value QUEUE_SEND_TO_BACK to place the item at the back 
                  of the queue, or QUEUE_SEND_TO_FRONT to place the item at the front of 
                  the queue (for high priority messages).
  
Return value:

    qTrue on successful add, qFalse if not added
*/
qBool_t qQueueGenericSend(qQueue_t *obj, void *ItemToQueue, uint8_t InsertMode){
    qBool_t RetValue = qFalse;
    if( ( NULL != obj ) && ( InsertMode <= 1u ) ){
        if( obj->ItemsWaiting < obj->ItemsCount ){ /* Is there room on the queue?*/
            qEnterCritical();
            qQueueCopyDataToQueue( obj, ItemToQueue, InsertMode );
            qExitCritical();
            RetValue = qTrue;
        }
    }
    return RetValue;   
}
#endif
/*============================================================================*/
/*void qSwapBytes(void *data, size_t n)
 
Invert the endianess for n bytes of the specified memory location
 
Parameters:

    - data : a pointer to block of data
    - n : the number of bytes to swap
*/
/*============================================================================*/
void qSwapBytes(void *data, const qSize_t n){
    uint8_t *p = data, tmp;
    qSize_t lo, hi;
    hi = n - 1u;
    for( lo = 0u ; hi > lo ; lo++ ){
        tmp = p[lo];
        p[lo] = p[hi];
        p[hi] = tmp;
        hi--;
    }
}
/*============================================================================*/
/*qBool_t qCheckEndianness(void)
 
Check the system endianess
  
Return value:

    qTrue if Little-Endian, otherwise returns qFalse
*/
qBool_t qCheckEndianness(void){
    uint16_t i = 1u;
    return (qBool_t)( *( (uint8_t*)&i ) );
}
/*============================================================================*/
/*void qOutputRaw(qPutChar_t fcn, void* pStorage, void *data, size_t n, qBool_t AIP)
 
Wrapper method to write n RAW data through fcn
  
Parameters:

    - fcn : The basic output byte function
    - pStorage : The storage pointer passed to fcn
    - data: Buffer to read data from
    - n: The size of "data"
    - AIP : Auto-Increment the storage-pointer
*/
void qOutputRaw(qPutChar_t fcn, void* pStorage, void *data, const qSize_t n, qBool_t AIP){
    qSize_t i = 0u;
    char *cdata = data;
    if( qTrue == AIP){
        for( i = 0u ; i < n ; i++ ){
            fcn( (char*)pStorage+i , cdata[i] );
        }
    }
    else{
        for( i = 0u ; i < n ; i++ ){
            fcn( pStorage, cdata[i] );
        }
    }
}
/*============================================================================*/
/*void qInputRaw(qGetChar_t fcn, void* pStorage, void *data, size_t n, qBool_t AIP)

Wrapper method to get n RAW data through fcn
  
Parameters:

    - fcn : The basic input byte function
    - pStorage : The storage pointer passed to fcn
    - data: Buffer to read data from
    - n: Number of bytes to get
    - AIP : Auto-Increment the storage-pointer
*/
void qInputRaw(const qGetChar_t fcn, void* pStorage, void *data, const qSize_t n, qBool_t AIP){
    qSize_t i = 0u;
    char *cdata = data;
    if( qTrue == AIP){
        for( i = 0u ; i < n ; i++ ){
            cdata[i] = fcn( (char*)pStorage+i );
        }
    }
    else{
        for( i = 0u ; i < n ; i++ ){
            cdata[i] = fcn( pStorage );
        }
    }
}

/*============================================================================*/
/*void qOutputString(qPutChar_t fcn, void* pStorage, const char *s, qBool_t AIP)
 
Wrapper method to write a string through fcn
  
Parameters:

    - fcn : The basic output byte function
    - pStorage : The storage pointer passed to fcn
    - s: The string to be written
    - AIP : Auto-Increment the storage-pointer
*/
void qOutputString(qPutChar_t fcn, void* pStorage, const char *s, qBool_t AIP){
    qSize_t i = 0u;
    if( qTrue == AIP){
        while(*s){
            fcn( (char*)pStorage+i ,  *s++ );
            i++;
        }
    }
    else{
        while(*s){
            fcn( pStorage, *s++ );
        }
    }
}
/*============================================================================*/
static char qNibbleToX(uint8_t value){
    char ch;
    ch = (char)(value & 0x0Fu) + '0';
    return (char) ((ch > '9') ? ch + 7u : ch);
}
/*============================================================================*/
void qPrintXData(qPutChar_t fcn, void* pStorage, void *data, qSize_t n){
    uint8_t *pdat =(uint8_t*)data; 
    qSize_t i;
    for( i = 0u ; i < n ; i++ ){
        fcn(pStorage, qNibbleToX( pdat[i] >> 4u ) );
        fcn(pStorage, qNibbleToX( pdat[i] & 0x0Fu ) );
        fcn(pStorage, ' ');
    }
    fcn(pStorage, '\r' );
    fcn(pStorage, '\n' );
}
/*============================================================================*/
/*void qU32toX(uint32_t value, char *str, int8_t n)
 
Converts an unsigned integer value to a null-terminated string using the 16 base
and stores the result in the array given by str parameter.
str should be an array long enough to contain any possible value.
  
Parameters:

    - value : Value to be converted to a string.
    - str : Array in memory where to store the resulting null-terminated string.
    - n: The number of chars used to represent the value in 'str' 

Return value:

  A pointer to the resulting null-terminated string, same as parameter str
*/
char* qU32toX(uint32_t value, char *str, int8_t n){ 
    int8_t i;
    str[n] = '\0';
    for( i = ( n - 1) ; i >= 0 ; i-- ){
        str[i] = qNibbleToX((uint8_t)value);
        value >>= 4ul;
    }
    return str;
}
/*============================================================================*/
/*uint32_t qXtoU32(const char *s)
  
Converts the input string s consisting of hexadecimal digits into an unsigned 
integer value. The input parameter s should consist exclusively of hexadecimal 
digits, with optional whitespaces. The string will be processed one character at
a time, until the function reaches a character which it doesn't recognize
(including a null character).
  
Parameters:

    - s : The hex string to be converted

Return value:

  The numeric value uint32_t
*/
uint32_t qXtoU32(const char *s) {
    uint32_t val = 0ul;
    uint8_t byte;
    uint8_t nparsed = 0u;
    if( NULL != s ){
        while ( ( *s != '\0' ) && ( nparsed < 8u) ) { /*loop until the end of the string or the number of parsed chars exceeds the 32bit notation*/
            byte = (uint8_t)toupper( (int)*s++ ); /*get the hex char, considerate only upper case*/
            if( isxdigit( (int)byte ) ){ /*if is a valid hex digit*/
                nparsed++; /*increase the parsed char count*/
                if ( ( byte >= '0' ) && ( byte <= '9') ){
                    byte = byte - '0'; /*make the conversion in the 0-9 range*/ 
                } 
                else if ( ( byte >= 'A' ) && ( byte <='F') ){
                    byte = byte - 'A' + 10u;  /*make the conversion in the A-F range*/        
                }     
                else{
                    /*nothing to do */
                }     
                val = ((val << 4ul) | ((uint32_t)byte & 0xFul));  /*add the corresponding nibble to the output*/                
            }
            else if( isspace( (int)byte ) ){
                /*discard any white-space char*/
            } 
            else{
                break;  /*not valid chars break the conversion*/       
            }
        }
    }
    return val;
}
/*============================================================================*/
/* double qAtoF(const char *s)
Parses the C string s, interpreting its content as a floating point number and 
returns its value as a double. The function first discards as many whitespace 
characters (as in isspace) as necessary until the first non-whitespace character
is found. Then, starting from this character, takes as many characters as possible 
that are valid following a syntax resembling that of floating point literals, and 
interprets them as a numerical value. The rest of the string after the last valid 
character is ignored and has no effect on the behavior of this function.
 
Parameters:

    - s : The string beginning with the representation of a floating-point number.

Return value:

    On success, the function returns the converted floating point number as 
    a double value.
    If no valid conversion could be performed, the function returns zero (0.0).
    If the converted value would be out of the range of representable values by
    a double, it causes undefined behavior
*/
double qAtoF(const char *s){
    double rez = 0.0, fact ;
    int point_seen;
    char c;
    #if ( Q_ATOF_FULL == 1 )
        int power2, powersign = 1;
        double power = 1.0, efactor;
    #endif
   
    while( isspace( (int)*s) ){
        s++; /*discard whitespaces*/
    }
    fact = ('-' == *s)? -1.0 : 1.0; /*set the sign*/
    if ( ( '-' == *s ) || ( '+' == *s) ){
        s++; /*move to the next sign*/
    }

    for (point_seen = 0; '\0' != (c=*s); s++){
        if (c == '.'){
            point_seen = 1; 
        }
        else if ( isdigit( (int)c ) ){
            if ( 1 == point_seen ){
                fact *= 0.1;
            }
            rez = rez * 10.0 + ( (double)c ) - ( (double)'0' );
        }
        else{
            break;
        }
    }
    
    #if ( Q_ATOF_FULL == 1 )
    if( ( 'e'  == *s ) || ( 'E' == *s) ){
	    s++;
	    if( ( '-' == *s ) || ( '+' == *s ) ){
		    powersign = ('-' == *s)? -1 : 1;
            s++;    
        } 
        for(power2 = 0; isdigit(*s); s++){
            power2 = power2 * 10 + (*s - '0');
        }
        if( power2 > 0){
 		    efactor = (-1 == powersign)? 0.1 : 10.0;
        	for(power=1; 0 != power2; power2--){
            	power *= efactor;
            }	
	    }
    }    
    return power * rez * fact;   
    #else
        return rez * fact;
    #endif      
}
/*============================================================================*/
/*int qAtoI(const char *s)
Parses the C-string s interpreting its content as an integral number, which is 
returned as a value of type int. The function first discards as many whitespace
characters (as in isspace) as necessary until the first non-whitespace character 
is found. Then, starting from this character, takes an optional initial plus or
minus sign followed by as many base-10 digits as possible, and interprets them 
as a numerical value.
The string can contain additional characters after those that form the integral
number, which are ignored and have no effect on the behavior of this function.
If the first sequence of non-whitespace characters in str is not a valid integral 
number, or if no such sequence exists because either str is empty or it contains 
only whitespace characters, no conversion is performed and zero is returned.

Parameters:

    - s : The string beginning with the representation of a integer number.

Return value:

On success, the function returns the converted integral number as an int value.
If the converted value would be out of the range of representable values by 
an int, it causes undefined behavior.
*/
int qAtoI(const char *s){
	int res = 0; /*holds the resulting integer*/
    int sgn = 1; /*only to hold the sign*/
    int RetValue = 0;

    if( NULL != s ){
        while( isspace( (int)*s ) ){
            ++s;
        }

        if ('-' == *s){ /*if negative found*/
            sgn = -1; /*set the sign*/
            ++s; /*move to next*/
        } 
        else if ('+' == *s){
            ++s; /*plus sign ignored, move to next*/ 
        } 
        else{
            /*nothing to do*/
        }
    
        while( *s != 0u ){ /*iterate until null char is found*/
            if ( ( *s < '0' ) || ( *s > '9' ) ){
                break; 
            }
            res = res * 10 + ((int)*s)- ((int)'0'); /*if the char is digit, compute the resulting integer*/
            ++s;
        }
        RetValue =  sgn * res; /*return the computed integer with sign*/
    }
    return RetValue;
}
/*============================================================================*/
/*this method makes the basic conversion of unsigned integer to ASCII
NULL Terminator not included
*/
static uint8_t __q_revuta(uint32_t num, char* str, uint8_t base){
    uint8_t i = 0u;
    uint32_t rem;
    if( 0ul == num ){ /* Handle 0 explicitly, otherwise empty string is printed for 0 */
        str[i++] = '0';        
    }
    else{
        while( 0ul != num ){ /*Process individual digits*/
            rem = num % (uint32_t)base;
            str[i++] = (rem > 9ul)? (char)(rem-10ul) + 'A' : (char)rem + '0';
            num = num/base;
        }
        qSwapBytes(str, (qSize_t)i);/*Reverse the string*/
    }
    return i;       
}
/*============================================================================*/
/* char* qUtoA(int num, char* str, uint8_t base)

Converts an unsigned value to a null-terminated string using the specified base 
and stores the result in the array given by str parameter. 

str should be an array long enough to contain any possible value: 
(sizeof(int)*8+1) for radix=2, i.e. 17 bytes in 16-bits platforms and 33 in 
32-bits platforms.

Parameters:

    - num : Value to be converted to a string.
    - str : Array in memory where to store the resulting null-terminated string.
    - base: Numerical base used to represent the value as a string, between 2 
            and 36, where 10 means decimal base, 16 hexadecimal, 8 octal, and 2 binary. 

Return value:

  A pointer to the resulting null-terminated string, same as parameter str
*/
char* qUtoA(uint32_t num, char* str, uint8_t base){
    uint8_t i = 0u;
    if( NULL != str ){
        i = __q_revuta(num, str, base); /*make the unsigned conversion without the null terminator*/
        str[i] = '\0'; /*add the null terminator*/
    }
    return str;
}
/*============================================================================*/
/* char* qItoA(int num, char* str, uint8_t base)

Converts an integer value to a null-terminated string using the specified base 
and stores the result in the array given by str parameter. If base is 10 and 
value is negative, the resulting string is preceded with a minus sign (-). 
With any other base, value is always considered unsigned.

str should be an array long enough to contain any possible value: 
(sizeof(int)*8+1) for radix=2, i.e. 17 bytes in 16-bits platforms and 33 in 
32-bits platforms.

Parameters:

    - num : Value to be converted to a string.
    - str : Array in memory where to store the resulting null-terminated string.
    - base: Numerical base used to represent the value as a string, between 2 
            and 36, where 10 means decimal base, 16 hexadecimal, 8 octal, and 2 binary. 

Return value:

  A pointer to the resulting null-terminated string, same as parameter str
*/
char* qItoA(int32_t num, char* str, uint8_t base){
    uint8_t i = 0u;
    if( NULL != str ){
        if( num < 0 ){ 
            if( 10u == base ){ /*handle negative numbers only with 10-base*/
                str[i++] = '-';/*put the sign at the begining*/
            } 
            num = -num;
        }
        i += __q_revuta((uint32_t)num, str+i, base); /*make the unsigned conversion without the null terminator*/   
        str[i] = '\0'; /*Append string terminator*/
    }
    return str;
}
/*============================================================================*/
/* char* qBtoA(qBool_t num, char *str)

Converts a boolean value to a null-terminated string. Input is considered true
with any value different to zero (0).

str should be an array long enough to contain the output

Parameters:

    - num : Value to be converted to a string.
    - str : Array in memory where to store the resulting null-terminated string.

Return value:

  A pointer to the resulting null-terminated string, same as parameter str
*/
char* qBtoA(qBool_t num, char *str){
    if( NULL != str ){
        if( qTrue == num ){
            str[0]='t'; str[1]='r'; str[2]='u'; str[3]='e'; str[4]='\0';
        }
        else{
            str[0]='f'; str[1]='a'; str[2]='l'; str[3]='s'; str[4]='e'; str[5]='\0';  
        }
    }
    return str;
}
/*============================================================================*/
/* char* qQBtoA(qBool_t num, char *str)

Converts a qBool_t value to a null-terminated string. Input is considered true
with any value different to zero (0).

str should be an array long enough to contain the output

Parameters:

    - num : Value to be converted to a string.
    - str : Array in memory where to store the resulting null-terminated string.

Return value:

  A pointer to the resulting null-terminated string, same as parameter str
*/
char* qQBtoA(qBool_t num, char *str){
    if( NULL != str ){
        switch( num ){
            case qTrue:
                str[0]='t'; str[1]='r'; str[2]='u'; str[3]='e'; str[4]='\0';
                break;
            case qFalse:
                str[0]='f'; str[1]='a'; str[2]='l'; str[3]='s'; str[4]='e'; str[5]='\0'; 
                break;
            case qRESPONSETIMEOUT:
                str[0]='t'; str[1]='i'; str[2]='m'; str[3]='e'; str[4]='o'; str[5]='u';str[6]='t';str[7]='\0';
                break;
            case qRISING:
                str[0]='r'; str[1]='i'; str[2]='s'; str[3]='i'; str[4]='n'; str[5]='g';str[6]='\0';
                break;
            case qFALLING:
                str[0]='f'; str[1]='a'; str[2]='l'; str[3]='l'; str[4]='i'; str[5]='n';str[6]='g';str[7]='\0';
                break;
            default:
                str[0]='u'; str[1]='n'; str[2]='k'; str[3]='n'; str[4]='o'; str[5]='w';str[6]='n';str[7]='\0';
                break;            
        }
    }
    return str;
}
/*============================================================================*/
/*qBool_t qIsNan(float f)
Determines if the given floating point number arg is a not-a-number (NaN) value. 

Parameters:

    - f : Floating point value(32bits).

Return value:

    qTrue is argument is NaN, otherwise qFalse
*/
qBool_t qIsNan( float f ){
    uint32_t u;
    void *p;
    p = &f;
    u = *(uint32_t*)p;
    return ( ( ( u & 0x7F800000ul ) ==  0x7F800000ul ) && ( u & 0x7FFFFFul ) )? qTrue : qFalse;
}
/*============================================================================*/
/*qBool_t qIsInf(float f)
Determines if the given floating point number arg is positive or negative infinity

Parameters:

    - f : Floating point value(32bits).

Return value:
 
    qTrue is argument has an infinite value, otherwise qFalse
*/
qBool_t qIsInf(float f){
    uint32_t u;
    void *p;
    p = &f;
    u = *(uint32_t*)p;
    return ( ( 0x7f800000ul == u ) || ( 0xff800000ul == u ) )? qTrue : qFalse;
}
/*============================================================================*/
/* char* qFtoA(float f, char *str, uint8_t precision)

Converts a float value to a formatted string.

Parameters:

    - num : Value to be converted to a string.
    - str : Array in memory where to store the resulting null-terminated string.
    - precision: Desired number of significant fractional digits in the string.
                 (The max allowed precision is MAX_FTOA_PRECISION=10)

Return value:

  A pointer to the resulting null-terminated string, same as parameter str
*/
char* qFtoA(float num, char *str, uint8_t precision){ /*limited to precision=10*/
    char c;
    uint8_t i = 0u;
    uint32_t intPart;
    if( NULL != str ){
        if( ( num >= 0.0f ) && ( num < 1.0E-38 ) ){ /*handle the 0.0f*/
            str[0]='0';
            str[1]='.';
            str[2]='0';
            str[3]='\0';       
        }
        else if( qTrue == (c = qIsInf(num)) ){ /*handle the infinity*/
            str[0] = ( 1u == c )? '+' : '-';
            str[1]='i'; 
            str[2]='n'; 
            str[3]='f'; 
            str[4]='\0';   
        }
        else if( qTrue == qIsNan(num) ){ /*handle the NAN*/
            str[0]='n'; 
            str[1]='a'; 
            str[2]='n'; 
            str[3]='\0';
        }
        else{
            if( precision > Q_MAX_FTOA_PRECISION ){
                precision = Q_MAX_FTOA_PRECISION; /*clip the precision*/
            }
            
            if( num < 0.0f ){ /*handle the negative numbers*/
                num = -num; /*leave it positive for the __q_revuta method*/
                str[i++] = '-'; /*add the negative sign*/
            }
            
            intPart = (uint32_t)num; /*get the integer parts*/
            num -= (float)intPart; /*get the floating-point part subtracting the integer part from the original value*/
            i += __q_revuta(intPart, str+i, 10u); /*convert the integer part in decimal form*/
            if( precision > 0u ){ /*decimal part*/
                str[i++] = '.'; /*place decimal point*/
                while( precision-- ){ /*convert until precision reached*/
                    num *= 10.0f;  /*start moving the floating-point part one by one multiplying by 10*/
                    c = (char)num; /*get the bcd byte*/
                    str[i++] = c + '0'; /*convert to ASCII and put it inside the buffer*/
                    num -= (float)c; /*Subtract the processed floating-point digit*/
                }
            }
            str[i] = '\0'; /*put the null char*/
        }
    }
    return str;
}
#ifdef Q_ISR_BUFFERS 
/*============================================================================*/
/*
 * TODO: Describe method
*/
qBool_t qISR_ByteBufferInit(qISR_ByteBuffer_t *obj, qISR_Byte_t *pData, qSize_t size, const char EndChar, qBool_t (*AcceptCheck)(const char), char (*PreChar)(const char)){
    if( (NULL == pData ) || ( size<2 ) ) return qFalse;
    obj->AcceptCheck = AcceptCheck;
    obj->PreChar = PreChar;
    obj->EndByte = EndChar;
    obj->MaxIndex = (uint16_t)(size - 1);
    obj->pData = pData;
    obj->index = 0;
    return qTrue;
}
/*============================================================================*/
/*
 * TODO: Describe method
 */
qBool_t qISR_ByteBufferFill(qISR_ByteBuffer_t *obj, const char newChar){
    if (!obj->ReadyFlag ){
        if(obj->AcceptCheck){
            if(!obj->AcceptCheck(newChar)){
                return qFalse;
            }
        }
        obj->pData[obj->index++] = (qISR_Byte_t)((obj->PreChar)? obj->PreChar(newChar) : newChar);
        obj->pData[obj->index] = 0x0u;
        if (obj->index>=(obj->MaxIndex)){
            obj->index = 0;
        }
        if(newChar == obj->EndByte){
            obj->ReadyFlag = qTrue;
            obj->index=0;
            return qTrue;
        }
    }
    return qFalse;
}
/*============================================================================*/
qBool_t qISR_ByteBufferGet(qISR_ByteBuffer_t *obj, void *dest){
    qBool_t RetValue = qFalse;
    if( obj->ReadyFlag ){
        memcpy(dest, (void*)obj->pData, obj->index);
        obj->ReadyFlag = qFalse;
        RetValue = qTrue;
    }
    return RetValue;
}
#endif
#if ( Q_BYTE_SIZED_BUFFERS == 1 )
/*============================================================================*/
/*size_t qBSBuffer_Count(qBSBuffer_t const* obj)
 
Query the number of elements in the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    Number of elements in the BSBuffer(Byte-sized Buffer)
*/
qSize_t qBSBuffer_Count(qBSBuffer_t const* obj){
    qSize_t RetValue = 0u;
    if( NULL != obj ){
        RetValue = (qSize_t)( obj->head - obj->tail );
    }

    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_IsFull(qBSBuffer_t const* obj)
 
Query the the full status of the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    qTrue if the BSBuffer(Byte-sized Buffer) is full, qFalse if it is not.
*/
qBool_t qBSBuffer_IsFull(qBSBuffer_t const* obj){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        RetValue = ( obj->length == qBSBuffer_Count(obj) )? qTrue : qFalse;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Empty(qBSBuffer_t const* obj)
 
Query the the empty status of the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    qTrue if the BSBuffer(Byte-sized Buffer) is empty, qFalse if it is not.
*/
qBool_t qBSBuffer_Empty(qBSBuffer_t const *obj){
    qBool_t RetValue = qTrue;
    if( NULL != obj ){
        RetValue = ( 0u == qBSBuffer_Count(obj) )? qTrue : qFalse;
    }
    return RetValue;
}
/*============================================================================*/
/*uint8_t qBSBuffer_Peek(qBSBuffer_t const* obj)
 
Looks for one byte from the head of the BSBuffer(Byte-sized Buffer) without removing it
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    byte of data, or zero if nothing in the list
*/
uint8_t qBSBuffer_Peek(qBSBuffer_t const *obj){
    uint8_t RetValue = 0x0u;
    if( NULL != obj ){
        RetValue = (uint8_t) (obj->buffer[obj->tail % obj->length]);
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Get(qBSBuffer_t *obj, uint8_t *dest)
 
Gets one data-byte from the front of the BSBuffer(Byte-sized Buffer), and removes it
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
    - dest: the location where the data-byte will be written
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Get(qBSBuffer_t *obj, uint8_t *dest){
    qBool_t RetValue = qFalse;
    if ( qFalse == qBSBuffer_Empty(obj) ) {
        *dest = obj->buffer[obj->tail % obj->length];
        obj->tail++;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Read(qBSBuffer_t *obj, void *dest, size_t n)
 
Gets n data from the BSBuffer(Byte-sized Buffer) and removes them
 
Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - dest: The location where the data will be written
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Read(qBSBuffer_t *obj, void *dest, const qSize_t n){
    qSize_t i;
    uint8_t *data = (uint8_t*)dest;
    qBool_t RetValue = qFalse;
    if( n > 0u ){
        RetValue = qTrue;
        for( i = 0u ; i < n ; i++){
            RetValue = qBSBuffer_Get(obj, data+i);
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Put(qBSBuffer_t *obj, uint8_t data){
 
Adds an element of data to the BSBuffer(Byte-sized Buffer)

Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - data: The data to be added
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Put(qBSBuffer_t *obj, const uint8_t data){
    qBool_t status = qFalse;
    if( NULL != obj ){ 
        if( qFalse == qBSBuffer_IsFull(obj) ) {/* limit the ring to prevent overwriting */
            obj->buffer[obj->head % obj->length] = data;
            obj->head++;
            status = qTrue;
        }
    }
    return status;
}
/*============================================================================*/
/*void qBSBuffer_Init(qBSBuffer_t *obj, volatile uint8_t *buffer, size_t length){
 
Initialize the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - buffer: Block of memory or array of data
    - length: The size of the buffer(Must be a power of two)
  
*/
void qBSBuffer_Init(qBSBuffer_t *obj, volatile uint8_t *buffer, const qSize_t length){
    if( NULL != obj ){
        obj->head = 0u;
        obj->tail = 0u;
        obj->buffer = buffer;
        #if ( Q_QUEUES == 1 )
            obj->length = _qQueueValidPowerOfTwo(length);
        #else
            obj->length = length;
        #endif      
    }
}
#endif

/*============================================================================*/
/*void qResponseInitialize(qResponseHandler_t *obj, char *xLocBuff, qSize_t nMax)

Initialize the instance of the response handler object

Parameters:

    - obj : A pointer to the Response Handler object
    - xLocBuff : A pointer to the memory block where the desired response
                 will remain.
    - nMax : The size of <xLocBuff>
  
*/
void qResponseInitialize(qResponseHandler_t *obj, char *xLocBuff, qSize_t nMax){
    if( NULL != obj){
        obj->Pattern2Match = xLocBuff;
        obj->MaxStrLength = nMax; 
        qResponseReset( obj );
    }
}   
/*============================================================================*/
/*void qResponseInitialize(qResponseHandler_t *obj)

Reset the Response Handler

Parameters:

    - obj : A pointer to the Response Handler object
  
*/
void qResponseReset(qResponseHandler_t *obj){
    if(obj != NULL){
        obj->PatternLength = 0u;
        obj->MatchedCount = 0u;
        obj->ResponseReceived = qFalse;
        qSTimerDisarm( &obj->timeout );
    }
}
/*============================================================================*/
/*qBool_t qResponseReceived(qResponseHandler_t *obj, const char *Pattern, qSize_t n)
 
Non-Blocking Response check

Parameters:

    - obj : A pointer to the Response Handler object
    - Pattern: The data checked in the receiver ISR
    - n : The length of the data pointer by Pattern 
          (if Pattern is string, set n to 0 to auto-compute the length)
  
Return value:

    qTrue if there is a response acknowledge, otherwise returns qFalse
*/
qBool_t qResponseReceived(qResponseHandler_t *obj, const char *Pattern, qSize_t n){
    return qResponseReceivedWithTimeout(obj, Pattern, n, 0.0f);
}
/*============================================================================*/
/*qBool_t qResponseReceivedWithTimeout(qResponseHandler_t *obj, const char *Pattern, qSize_t n, qTime_t t)
 
Non-Blocking Response check with timeout

Parameters:

    - obj : A pointer to the Response Handler object
    - Pattern: The data checked in the receiver ISR
    - n : The length of the data pointed by Pattern 
          (if Pattern is string, set n to 0 to auto-compute the length)
    - timeout : A pointer to the qSTimer object
    - t : The timeout value
  
Return value:

    qTrue if there is a response acknowledge,
    qTimeoutReached if timeout t expires
    otherwise returns qFalse
*/
qBool_t qResponseReceivedWithTimeout(qResponseHandler_t *obj, const char *Pattern, qSize_t n, qTime_t t){
    qBool_t RetValue = qFalse;
    if( ( qFalse == obj->ResponseReceived ) && ( 0u == obj->PatternLength ) ){ /*handler no configured yet*/
        strncpy( obj->Pattern2Match, (const char*)Pattern, (size_t)obj->MaxStrLength - (size_t)1 ) ; /*set the expected response pattern*/
        obj->PatternLength = (qSize_t)((0u == n)? strlen(Pattern) : n); /*set the number of chars to match*/
        obj->MatchedCount = 0u; /*reinitialize the chars match count*/
        obj->ResponseReceived = qFalse; /*clear the ready flag*/
        if( t > qTimeImmediate){
            qSTimerSet( &obj->timeout, t);
        }
    }
    else if( qSTimerExpired( &obj->timeout) ){
        qResponseReset(obj); /*re-initialize the response handler*/
        RetValue = qResponseTimeout;
    }        
    else if( obj->ResponseReceived ){ /*if response received from ISR match the expected*/
        qResponseReset(obj); /*re-initialize the response handler*/
        RetValue = qTrue; /*let it know to the caller that expected response was received*/
    } 
    else{
      /*nothing to do*/
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qResponseISRHandler(qResponseHandler_t *obj, const char rxchar)

ISR receiver for the response handler

Parameters:

    - obj : A pointer to the Response Handler object
    - rxchar: The byte-data from the receiver 

Return value:

    qTrue when the Response handler match the request from "qResponseReceived"
*/
qBool_t qResponseISRHandler(qResponseHandler_t *obj, const char rxchar){
    qBool_t RetValue = qFalse;
    if( ( qFalse == obj->ResponseReceived ) && ( obj->PatternLength > 0u ) ) {
        if( obj->Pattern2Match[obj->MatchedCount] == rxchar ){ /*if the received char match with the expected*/
            obj->MatchedCount++; /*move to the next char in the expected buffer*/
            if( obj->MatchedCount == obj->PatternLength ){
                obj->ResponseReceived = qTrue; /*if all the requested chars match, set the ready flag */
                RetValue = obj->ResponseReceived;
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
uint32_t qStringHash(const char* s, uint8_t mode){
    uint32_t hash = 0ul;
    switch( mode ){
        case 0: /*D. J. Bernstein */
            for(hash = 5381ul; *s; hash = 33ul*hash^((uint8_t)*s) ){
                s++;
            }
            break;
        case 1: /*Fowler/Noll/Vo (FNV) */
            for(hash = 0x811c9dc5u; *s; hash *= 0x01000193u){
                hash ^= ((uint8_t)*s++);
            }
            break;
        case 2: /*Jenkins' One-at-a-Time*/
            for( hash = 0ul; *s; hash ^= (hash >> 6)){
                hash += (*s++) + (hash << 10);
            }
            hash += (hash << 3);
            hash ^= (hash >> 11);
            hash += (hash << 15);
            break;
        case 3: /*sdbm*/
            for( hash=0ul ; *s; hash = (*s) + (hash<<6) + (hash<<16) - hash ){
                s++;
            }
            break; 
        default : break;
    }    
    return hash;
}
/*============================================================================*/
#if ( Q_TRACE_VARIABLES == 1 )
void __qtrace_func(const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, qSize_t BlockSize){
    if( NULL != __qDebugOutputFcn ){ /*trace only if the output-function is defined*/
        qPrintString(__qDebugOutputFcn, NULL, loc); /*print out the line location*/
        if( NULL != fcn ){ /*print out the function if available*/
            __qDebugOutputFcn(NULL, '@');
            qPrintString(__qDebugOutputFcn, NULL, fcn); 
            __qDebugOutputFcn(NULL, ' ');
        }
        qPrintString(__qDebugOutputFcn, NULL, varname);
        if( NULL == varvalue ){ /*if varvalue is not defined, the call must correspond to memory tracing*/
            qPrintXData(__qDebugOutputFcn, NULL, Pointer, BlockSize); /*print out the memory in hex format*/
        }
        else{ /*print out the variable value*/
            qPrintString(__qDebugOutputFcn, NULL, varvalue);
            __qDebugOutputFcn(NULL, '\r');
            __qDebugOutputFcn(NULL, '\n');
        }
    }
}
#endif
/*============================================================================*/
qBool_t __qReg_32Bits(void *Address, qBool_t PinNumber){
    uint32_t Register = 0ul;
    Register = *((uint32_t*)Address);    
    return (Register & (1ul << PinNumber))? qFalse : qTrue;
}
/*============================================================================*/
qBool_t __qReg_16Bits(void *Address, qBool_t PinNumber){
    uint16_t Register = 0u;
    uint16_t Mask;
    Mask = (uint16_t)1u << (uint16_t)PinNumber;
    Register = *((uint16_t*)Address);
    return ( Register & Mask )? qFalse : qTrue;
}
/*============================================================================*/
qBool_t __qReg_08Bits(void *Address, qBool_t PinNumber){
    uint8_t Register = 0u;
    Register = *((uint8_t*)Address);
    return (Register & (1u << PinNumber))? qFalse : qTrue;
}
/*============================================================================*/
/*qBool_t qEdgeCheck_Initialize(qIOEdgeCheck_t *Instance, qCoreRegSize_t RegisterSize, qClock_t DebounceTime)
 
Initialize a I/O Edge-Check instance 

Parameters:

    - Instance : A pointer to the I/O Edge-Check object
    - RegisterSize: The specific-core register size: QREG_8BIT, QREG_16BIT or QREG_32BIT(Default)
    - DebounceTime : The specified time to bypass the bounce of the input nodes
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qEdgeCheck_Initialize(qIOEdgeCheck_t *Instance, const qCoreRegSize_t RegisterSize, qClock_t DebounceTime){
    qBool_t RetValue = qFalse;
    if( NULL != Instance ){
        Instance->Head = NULL;
        Instance->DebounceTime = DebounceTime;
        Instance->Reader = (NULL==RegisterSize)? QREG_32BIT  : RegisterSize;
        Instance->State = QEDGECHECK_CHECK;
        Instance->Start = qSchedulerGetTick();
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qEdgeCheck_InsertNode(qIOEdgeCheck_t *Instance, qIONode_t *Node, void *PortAddress, qBool_t PinNumber)
 
Initialize an I/O Edge-Check instance 

Parameters:

    - Instance : A pointer to the I/O Edge-Check object
    - Node: A pointer to the Input-Node object
    - PortAddress : The address of the core PORTx-register to read the levels of the specified PinNumber
    - PinNumber : The specified Pin to read from PortAddress 
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qEdgeCheck_InsertNode(qIOEdgeCheck_t *Instance, qIONode_t *Node, void *PortAddress, qBool_t PinNumber){
    qBool_t RetValue = qFalse;
    if( ( NULL != Node ) && ( NULL != Instance ) ){
        Node->Port = PortAddress;
        Node->Pin = PinNumber;
        Node->Next = Instance->Head;
        Node->PreviousPinValue = Instance->Reader( Node->Port, Node->Pin );
        Instance->Head = Node;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qEdgeCheck_Update(qIOEdgeCheck_t *Instance)
 
Update the status of all nodes inside the I/O Edge-Check instance (Non-Blocking call).

Parameters:

    - Instance : A pointer to the I/O Edge-Check object
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
/*============================================================================*/
qBool_t qEdgeCheck_Update(qIOEdgeCheck_t *Instance){
    qIONode_t *Node;
    qBool_t CurrentPinValue;
    qBool_t RetValue = qFalse;   
    if( NULL != Instance ){
        if( QEDGECHECK_WAIT == Instance->State ){ /*de-bounce wait state*/
            if( ( qSchedulerGetTick() - Instance->Start ) >= Instance->DebounceTime ){
                Instance->State = QEDGECHECK_UPDATE; /*debounce time reached, update the inputlevel*/ 
            }      
            RetValue = qTrue;
        }
        else{
            for( Node = Instance->Head ; NULL != Node ; Node = Node->Next ){ /*iterate through all the input-nodes*/
                CurrentPinValue = Instance->Reader( Node->Port, Node->Pin ); /*read the pin level*/        
                if( Instance->State >= QEDGECHECK_CHECK ){ /*check state*/
                    if( Node->PreviousPinValue != CurrentPinValue ){ /*check if the input level change since the last inputs-sweep*/
                        Node->Status = qUNKNOWN; /*change detected, put the node on unknown status until the debounce wait finish*/
                        Instance->State++; /* just to know that at least one node changed its state(count of nodes subject to the range of uint8_t)*/
                    }
                    else{
                        Node->Status = CurrentPinValue; /*if there is no change, let the state of the pin be equal to its own level*/
                    } 
                }
                else if( QEDGECHECK_UPDATE == Instance->State ){ /*update state*/
                    if( Node->PreviousPinValue != CurrentPinValue ){ /*if the level change is effective*/
                        Node->Status = (CurrentPinValue)? qRISING : qFALLING; /*set the edge status*/
                    }      
                    Node->PreviousPinValue = CurrentPinValue; /*keep the previous level*/
                }
                else{
                    /*nothing to do*/
                }
            }       
        
            if( QEDGECHECK_UPDATE == Instance->State ){ /*reload the instance to a full check*/
                Instance->State = QEDGECHECK_CHECK; /*reload the init state*/
                Instance->Start = qSchedulerGetTick(); /*reload the time*/
            }
            if( Instance->State > QEDGECHECK_CHECK ){
                Instance->State = QEDGECHECK_WAIT; /*at least one pin change detected, do the de-bounce wait*/
            }
            RetValue = qTrue;  
        }  
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qEdgeCheck_GetNodeStatus(qIONode_t *Node)
 
Query the status of the specified input-node.

Parameters:

    - Node : Node: A pointer to the Input-Node object
  
Return value:

    The status of the input node : qTrue, qFalse, qRising, qFalling or qUnknown
*/
qBool_t qEdgeCheck_GetNodeStatus(const qIONode_t *Node){
    return Node->Status;
}

#if ( Q_ATCOMMAND_PARSER == 1 )

static void qATParser_TaskCallback(qEvent_t e);
static  qPutChar_t ATOutCharFcn = NULL;
static void _qATPutc_Wrapper(const char c);
static void _qATPuts_Wrapper(const char *s);
static qSize_t qATParser_NumOfArgs(const char *str);
static char* _qATParser_FixInput(char *s);
static void _qATParser_HandleCommandResponse(const qATParser_t *Parser, qATResponse_t retval);
static qBool_t _qATParser_PreProcessing(qATCommand_t *Command, volatile char *InputBuffer, qATParser_PreCmd_t *params);
/*============================================================================*/
static void _qATPutc_Wrapper(const char c){
	ATOutCharFcn(NULL, c);
}
/*============================================================================*/
static void _qATPuts_Wrapper(const char *s){
	uint16_t i = 0u;
	while( s[i] ){
        ATOutCharFcn( NULL, s[i++]);
    }
}
/*============================================================================*/
/*qBool_t qATParser_Setup(qATParser_t *Parser, qPutChar_t OutputFcn, 
                                char *Input, qSize_t SizeInput, char *Output, qSize_t SizeOutput, 
                                const char *Identifier, const char *OK_Response, const char *ERROR_Response, 
                                const char *NOTFOUND_Response, const char *term_EOL)
 
Setup an instance of the AT Command parser.

Parameters:

    - Parser : A pointer to the AT Command Parser instance
    - OutputFcn : The basic output-char wrapper function. All the parser responses 
                   will be printed-out through this function.
    - Input : A memory location to store the parser input (Mandatory)
    - SizeInput: The size of the memory allocated in <Input> 
    - Output: A memory location to store the parser output
    - SizeOutput : The size of the memory allocated in <Output> 
    - Identifier: The device identifier string. This string will be printed-out
                  after a call to the AT_DEFAULT_ID_COMMAND
    - OK_Response: The output message when a command callback returns QAT_OK.  
    - ERROR_Response: The output message when a command callback returns QAT_ERROR or any
                      QAT_ERRORCODE(#)
    - NOTFOUND_Response: The output message when input doesn't match with any of 
                         the available commands
    - term_EOL: The End Of Line string printed out after any of the parser messages 
  
Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qATParser_Setup(qATParser_t *Parser, qPutChar_t OutputFcn, char *Input, qSize_t SizeInput, char *Output, qSize_t SizeOutput, const char *Identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL){
    qBool_t RetValue = qFalse;
    if(  ( NULL != Parser ) && ( NULL != OutputFcn) ) {
        Parser->First  = NULL;
        Parser->OutputFcn = OutputFcn;
        Parser->putch = _qATPutc_Wrapper;
        Parser->puts = _qATPuts_Wrapper;
        Parser->Identifier = (char*)Identifier;
        Parser->OK_Response = (char*)OK_Response;
        Parser->ERROR_Response = (char*)ERROR_Response;
        Parser->NOTFOUND_Response = (char*)NOTFOUND_Response;
        Parser->term_EOL = (char*)term_EOL;
        memset((void*)Parser->Input.Buffer, 0, (size_t)Parser->Input.Size);
        memset((void*)Parser->Output, 0, (size_t)Parser->SizeOutput);
        Parser->Output = Output;
        Parser->SizeOutput = SizeOutput;

        Parser->Input.Buffer = (volatile char*)Input;
        Parser->Input.Size = SizeInput;
        Parser->Input.Ready = qFalse;
        Parser->Input.index = 0u;
        Parser->Task = NULL;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qATParser_CmdSubscribe(qATParser_t *Parser, qATCommand_t *Command, const char *TextCommand, qATCommandCallback_t Callback, uint16_t CmdOpt)
 
This function subscribes the parser to a specific command with an associated callback function,
so that next time the required command is sent to the parser input, the callback function will be
executed. 
The parser only analyze commands that follows the extended AT-Commands syntax (+ can be ignored).

Parameters:

    - Parser : A pointer to the ATParser instance
    - Command : A pointer to the AT command object.
    - TextCommand: The string (name) of the command we want to subscribe to. 
                    Since this service only handles AT commands, this string has 
                    to begin by the "at" characters and should be in lower case.
    - Callback: The handler of the callback function associated to the command.
    			Prototype: qATResponse_t xCallback(qATParser_t* parser, qATParser_PreCmd_t* param)
    - CmdOpt : This flag combines with a bitwise ‘OR’ (‘|’) the following information:
                
                > QATCMDTYPE_PARA  : "AT+cmd=x,y" is allowed. The execution of the callback
                                     function also depends on whether the number of argument 
                                     is valid or not. Information about number of arguments is
                                     combined with a bitwise 'OR' : QATCMDTYPE_PARA | 0xXY , 
                                     where X which defines maximum argument number for incoming
                                     command and Y which defines minimum argument number for 
                                     incoming command
                > QATCMDTYPE_TEST  : "AT+cmd=?" is allowed. 
                > QATCMDTYPE_READ  : "AT+cmd?" is allowed.  
                > QATCMDTYPE_ACT   : "AT+cmd" is allowed.   

Return value:

    qTrue on success, otherwise return qFalse
*/
qBool_t qATParser_CmdSubscribe(qATParser_t *Parser, qATCommand_t *Command, const char *TextCommand, qATCommandCallback_t Callback, uint16_t CmdOpt){
    qBool_t RetValue = qFalse;
    if( ( NULL != Parser ) && ( NULL != Command ) && ( NULL != TextCommand ) && ( NULL != Callback ) ){
        Command->CmdLen = (qSize_t)strlen(TextCommand);
        if( Command->CmdLen >= 2u ){
            if( ( 'a' == TextCommand[0] ) && ( 't' == TextCommand[1] ) ) { /*command should start with an <at> at the beginning */
                Command->Text = (char*)TextCommand;
                Command->CommandCallback = Callback;
                Command->CmdOpt = 0x0FFFu & CmdOpt; /*high nibble not used yet*/
                Command->Next = Parser->First;
                Parser->First = Command;
                RetValue = qTrue;  
            }
        }
    } 
    return RetValue;
}
/*============================================================================*/
/*void qATCommandParser_ISRHandler(qATParser_t *Parser, char c)
 
Feed the parser input with a single character. This call is mandatory 
from an interrupt context. Put it inside the desired peripheral's ISR.
If your ISR get a block of data, use instead qATParser_ISRHandlerBlock

Note: This API assumes that the respective ISR catch a single byte at a time.

Parameters:

    - Parser : A pointer to the ATParser instance
    - c : The incoming byte/char to the input. 

Return value:

    qTrue when the Parser is ready to process the input, otherwise return qFalse

*/
qBool_t qATParser_ISRHandler(qATParser_t *Parser, char c){
    qBool_t RetValue = qFalse;
    qBool_t ReadyInput;
    
    ReadyInput = Parser->Input.Ready;
    if( ( isgraph( (int)c ) ) && ( qFalse == ReadyInput ) ){
        Parser->Input.Buffer[Parser->Input.index++] = (char)tolower( (int)c );
        Parser->Input.Buffer[Parser->Input.index] = 0x00u;
        if( Parser->Input.index >= (Parser->Input.Size - 1u )){
            Parser->Input.index = 0u;
        }
    }
    if ( c == '\r' ){
        Parser->Input.Ready = qTrue;
        Parser->Input.index = 0u;
        if( NULL != Parser->Task ){
            qTaskSendNotification(Parser->Task, NULL);
        }
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*
Feed the parser input with a string. This call is mandatory 
from an interrupt context. Put it inside the desired peripheral's ISR.
If your ISR only get a single char, use instead qATParser_ISRHandler

Parameters:

    - Parser : A pointer to the ATParser instance
    - data : The incoming string.
    - n : The length of the string

Return value:

    qTrue when the Parser is ready to process the input, otherwise return qFalse

*/
qBool_t qATParser_ISRHandlerBlock(qATParser_t *Parser, char *data, qSize_t n){
    qBool_t RetValue = qFalse;
    qBool_t ReadyInput;
    qSize_t CurrentInputIndex;
    
    ReadyInput = Parser->Input.Ready;
    CurrentInputIndex = Parser->Input.Size-1u;
    if( ( n > 0u ) && ( n < CurrentInputIndex ) &&  ( qFalse == ReadyInput ) ) {
        if( 1u == n ){
            RetValue = qATParser_ISRHandler(Parser, data[0]);
        }
        else{
            if( isgraph( (int)data[0] ) ){
                if( NULL != strchr(data, (int)'\r') ){ 
                    strncpy((char*)Parser->Input.Buffer, data, (size_t)n);
                    _qATParser_FixInput( (char*)Parser->Input.Buffer );
                    Parser->Input.Ready = qTrue;
                    Parser->Input.index = 0u;
                    if( NULL != Parser->Task ){
                        qTaskSendNotification(Parser->Task, NULL);
                    } 
                    RetValue = qTrue;
                }
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
/*
modifies the input string removing non-graph chars 
*/
static char* _qATParser_FixInput(char *s){
    int i,j;
    j = 0;
    for( i = 0; '\0' != s[i] ; i++ ){
        if( '\r' == s[i] ){
            s[i] = '\0';
            break;    
        } 
        if( isgraph( (int)s[i]) ){
            s[j++] = (char)tolower( (int)s[i] );
        }
    }
    s[j] = '\0';
    return s;
}
/*============================================================================*/
/*qBool_t qATParser_Raise(qATParser_t *Parser, char *cmd)

Sends a command to the specified Parser.

Parameters:

    - Parser : A pointer to the ATParser instance
    - cmd : The command string, including arguments if required.

Return value:

    qTrue when the Parser accepts the input. If busy, return qFalse

*/
qBool_t qATParser_Raise(qATParser_t *Parser, const char *cmd){
    qBool_t RetValue = qFalse;
    qSize_t CurrentInputIndex;
    qBool_t ReadyInput;           
    size_t CmdLen;
    
    if( ( NULL != Parser ) && ( NULL != cmd ) ){
        ReadyInput = Parser->Input.Ready;        
        CurrentInputIndex = Parser->Input.Size - 1u;
        CmdLen = strlen(cmd);
        if( ( qFalse == ReadyInput ) && ( CmdLen <= CurrentInputIndex ) ){ 
            Parser->Input.Ready = qTrue;
            Parser->Input.index = 0u;
            strncpy((char*)Parser->Input.Buffer, cmd, (size_t)Parser->Input.Size );
            _qATParser_FixInput( (char*)Parser->Input.Buffer );
            if( NULL != Parser->Task ){
                qTaskSendNotification(Parser->Task, NULL);
            }
            RetValue =  qTrue;
        }
    } 
    return RetValue;
}
/*============================================================================*/
/*qATResponse_t qATParser_Exec(qATParser_t *Parser, const char *cmd)

Try to execute the requested command.

Parameters:

    - Parser : A pointer to the ATParser instance
    - cmd : The command string, including arguments if required.

Return value:

    The response output for the requested command

*/
/*============================================================================*/
qATResponse_t qATParser_Exec(qATParser_t *Parser, const char *cmd){
    qATResponse_t RetValue = QAT_NOTFOUND;
    qATCommand_t *Command = NULL;
    qATParser_PreCmd_t params;
    if( ( NULL != Parser ) && ( NULL != cmd ) ){
        for( Command = (qATCommand_t*)Parser->First ; NULL != Command ; Command = Command->Next ){ /*loop over the subscribed commands*/
            if( strstr( cmd, Command->Text ) == cmd ){ /*check if the input match the subscribed command starting from the beginning*/
            	RetValue = qAT_NOTALLOWED;
                if( _qATParser_PreProcessing(Command, (volatile char*)cmd, &params) ){ /*if success, proceed with the user pos-processing*/
                    RetValue = (qATCMDTYPE_UNDEF == params.Type )? QAT_ERROR : Command->CommandCallback(Parser, &params); /*invoke the callback*/
                }
                break;
            }
        }
    }
    return RetValue;
}
/*============================================================================*/
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
qBool_t qSchedulerAdd_ATParserTask(qTask_t *Task, qATParser_t *Parser, qPriority_t Priority){    
    qBool_t RetValue = qFalse;
    if( NULL != Parser ){
        Parser->Task = Task;
        RetValue =  qSchedulerAdd_Task(Task, qATParser_TaskCallback, Priority, qTimeImmediate, qSingleShot, qDisabled, Parser);
    }
    return RetValue;
}
/*============================================================================*/
static void qATParser_TaskCallback(qEvent_t e){ /*wrapper for the task callback */
    qATParser_Run( (qATParser_t*)e->TaskData );
}
/*============================================================================*/
static qBool_t _qATParser_PreProcessing(qATCommand_t *Command, volatile char *InputBuffer, qATParser_PreCmd_t *params){
    qBool_t RetValue = qFalse;
    params->Type = qATCMDTYPE_UNDEF;
    params->Command = Command;
    params->StrLen = (qSize_t)strlen((const char*)InputBuffer) - Command->CmdLen;
    params->StrData = (char*)(InputBuffer+Command->CmdLen);
    params->NumArgs = 0u;

    if( 0u == params->StrLen ){ /*command should be an ACT command */
        if( Command->CmdOpt & (uint16_t)qATCMDTYPE_ACT ){ /*check if is allowed*/
            params->Type = qATCMDTYPE_ACT;  /*set the type to ACT*/
            RetValue = qTrue;
        }
    } 
    else if ( params->StrLen > 0u){
        if( '?' == params->StrData[0] ){ /*command should be READ command */
            if( Command->CmdOpt & (uint16_t)qATCMDTYPE_READ ){ /*check if is allowed*/
                params->Type = qATCMDTYPE_READ; /*set the type to READ*/
                params->StrData++; /*move string pointer once*/
                params->StrLen--;  /*decrease the len one*/
                RetValue = qTrue;
            }
        } 
        else if( params->StrLen >= 2u ){ /*can be at+xx=? or at+xx=...*/
            if( '=' == params->StrData[0] ){ /*could be a TEST or PARA command*/
                if( '?' == params->StrData[1] ){ 
                    if(2u == params->StrLen){ /*command should be a TEST Command*/
                        if(Command->CmdOpt & (uint16_t)qATCMDTYPE_TEST){ /*check if is allowed*/
                            params->Type = qATCMDTYPE_TEST; /*set the type to TEXT*/
                            params->StrData+=2; /*move string two positions ahead*/
                            params->StrLen-=2u;  /*decrease the len*/
                            RetValue = qTrue;
                        }
                    }
                }
                else{ /*definitely is a PARA command*/
                    if( Command->CmdOpt & (uint16_t)qATCMDTYPE_PARA ){ /*check if is allowed*/
                        params->NumArgs = qATParser_NumOfArgs(params->StrData); /*get the args count using the default delimiter*/
                        if( ( params->NumArgs >= QATCMDMASK_ARG_MINNUM(Command->CmdOpt) ) && ( params->NumArgs <= QATCMDMASK_ARG_MAXNUM(Command->CmdOpt) ) ){
                            params->Type = qATCMDTYPE_PARA; /*set the type to PARA*/
                            params->StrData++; /*move string pointer once*/
                            params->StrLen--; /*decrease the len one*/
                            RetValue = qTrue;
                        }
                    }
                }
            }
        }
        else{
          /*nothing to do*/
        }
    }
    else{
        /*nothing to do*/
    }
    return RetValue;
}
/*============================================================================*/
void qATCommandParser_FlushInput(qATParser_t *Parser){
	qATParserInput_t *Input;
    if( NULL != Parser ){
        Input = &Parser->Input;
        Input->Ready = qFalse;
        Input->index = 0u;
        Input->Buffer[0] = 0x00u;
    }
}
/*============================================================================*/
/*qBool_t qATCommandParser_Run(qATParser_t *Parser)
 
Run the AT Command Parser when the input is ready.

Parameters:

    - Parser : A pointer to the ATParser instance

Return value:

    qTrue on success, otherwise return qFalse

*/
qBool_t qATParser_Run(qATParser_t *Parser){
    qATResponse_t OutputRetval = QAT_NORESPONSE;
    qATResponse_t ParserRetVal;
    qATParserInput_t *Input;
    qBool_t RetValue = qFalse;
    if( NULL != Parser){
		Input =  &Parser->Input;
		ATOutCharFcn = Parser->OutputFcn;

		if( Input->Ready ){ /*a new input has arrived*/
			/*Validation : set the value for the response lookup table*/
			if 	( 0 == strcmp((const char*)Input->Buffer, QAT_DEFAULT_AT_COMMAND) ){
            	OutputRetval = QAT_OK;			/*check if the input its the simple AT command*/
            }
			else if	( QAT_NOTFOUND != (ParserRetVal = qATParser_Exec(Parser, (const char*)Input->Buffer)) ){
                OutputRetval = ParserRetVal;	/*check if the input is one of the subscribed commands*/
            }
			else if ( 0 == strcmp((const char*)Input->Buffer, QAT_DEFAULT_ID_COMMAND) ){
                OutputRetval = QAT_DEVID;		/*check if the input its an ID request using the ATID command*/
            }
			else if	( strlen((const char*)Input->Buffer) >= QAT_MIN_INPUT_LENGTH ){
                OutputRetval = QAT_NOTFOUND;	/*check if it is pertinent to show the error*/
            }
			else{
                OutputRetval = QAT_NORESPONSE;  /*nothing to do*/
            }

			if( NULL != Parser->Output ){ /*show the user output if available*/
				if( Parser->Output[0] ){
                    _qATParser_HandleCommandResponse(Parser, QAT_OUTPUT);
                }
			}
			_qATParser_HandleCommandResponse( Parser, OutputRetval ); /*print out the command output*/
			/*flush buffers*/
			qATCommandParser_FlushInput( Parser );
			Parser->Output[0] = '\0';
			RetValue = qTrue;
		}
    }
    return RetValue;
}
/*============================================================================*/
static void _qATParser_HandleCommandResponse(const qATParser_t *Parser, qATResponse_t retval){
    int32_t ErrorCode;
	if( QAT_NORESPONSE != retval ){
        switch( retval ){ /*handle the command-callback response*/
            case qAT_ERROR:
                Parser->puts( (Parser->ERROR_Response)? Parser->ERROR_Response : QAT_DEFAULT_ERROR_RSP_STRING);
                break;
            case qAT_OK:
                Parser->puts( (Parser->OK_Response)? Parser->OK_Response: QAT_DEFAULT_OK_RSP_STRING );
                break;
            case qAT_NOTALLOWED:   
                Parser->puts( (Parser->ERROR_Response)? Parser->ERROR_Response : QAT_DEFAULT_ERROR_RSP_STRING);
                Parser->puts(QAT_DEAFULT_NOTALLOWED_RSP_STRING);
                break; 
            case qAT_DEVID:
                Parser->puts( (Parser->Identifier)? Parser->Identifier: QAT_DEFAULT_DEVID_STRING );
                break;
            case qAT_NOTFOUND:
                Parser->puts( (Parser->NOTFOUND_Response)? Parser->NOTFOUND_Response: QAT_DEFAULT_NOTFOUND_RSP_STRING );
                break;        
            case qAT_OUTPUT:
                Parser->puts( Parser->Output );
                break;
            default: /*AT_ERRORCODE(#) */
                if( retval < 0 ){
                    ErrorCode = QAT_ERRORCODE( (int32_t)retval );
                    qItoA(ErrorCode, Parser->Output, 10u);
                    Parser->puts( (Parser->ERROR_Response)? Parser->ERROR_Response : QAT_DEFAULT_ERROR_RSP_STRING);
                    Parser->putch(':');
                    Parser->puts(Parser->Output);
                    Parser->Output[0] = '\0';
                }                            
                break;
        }
        Parser->puts( (Parser->term_EOL)? Parser->term_EOL : QAT_DEFAULT_EOL_STRING );
    }
}
/*============================================================================*/
/*char* qATParser_GetArgString(qATParser_PreCmd_t *param, int8_t n, char* out)

This function get the <n> argument parsed as <String> from the incoming AT command.
This function should be only invoked from the callback context of the  recognized command.

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument
    - out: Array in memory where to store the resulting null-terminated string.

Return value:

    Same as <out>  on success, otherwise returns NULL.
*/
char* qATParser_GetArgString(const qATParser_PreCmd_t *param, int8_t n, char* out){
	int8_t i,j, argc = 0;
	char *RetPtr = NULL;

    if( ( NULL != param ) && ( NULL != out ) && ( n > 0 ) ){
        if( QATCMDTYPE_SET ==  param->Type ){
            n--;
            j = 0;
            for( i=0 ; '\0' != param->StrData[i]; i++){
                if(argc == n){
                    RetPtr = out;
                    if( ( argc > n ) || ( QAT_DEFAULT_ATSET_DELIM == param->StrData[i] ) ){
                        break;
                    } 
                    out[j++] = param->StrData[i];
                    out[j] = '\0';
                }
                if( QAT_DEFAULT_ATSET_DELIM == param->StrData[i] ){
                    argc++;
                }
            }
        }
    }
	return RetPtr;
}
/*============================================================================*/
static qSize_t qATParser_NumOfArgs(const char *str){
	qSize_t count = 0u;
	while( *str ){
        if ( QAT_DEFAULT_ATSET_DELIM == *str++ ){
            ++count;
        }
    }
	return ( count + 1u );
}
/*============================================================================*/
/*char* qATParser_GetArgPtr(qATParser_PreCmd_t *param, int8_t n)

Get the pointer where the desired argument starts.
This function should be only invoked from the callback context of the  recognized command.

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument

Return value:

    A pointer to the desired argument. NULL  pointer if the argument is not present.
*/
char* qATParser_GetArgPtr(const qATParser_PreCmd_t *param, int8_t n){
	int16_t i, argc = 0;
    char *RetPtr = NULL;
	if( ( NULL != param ) && ( n > 0 ) ) {
        if( QATCMDTYPE_SET == param->Type) {
            if( 1 == n ){
                RetPtr = param->StrData;
            } 
            else{
                n--;
	            for( i = 0 ; '\0' != param->StrData[i] ; i++){
		            if( QAT_DEFAULT_ATSET_DELIM == param->StrData[i] ){
			            if( ++argc >= n ){
                            RetPtr = param->StrData+i+1;        
                            break;
                        }
		            }
	            }
            }
        }
    }
    return RetPtr;
}

/*============================================================================*/
/*int qATParser_GetArgInt(qATParser_PreCmd_t *param, int8_t n)

This function get the <n> argument parsed as <Integer> from the incoming AT command.
This function should be only invoked from the callback context of the recognized command.
Note: see qAtoI


Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the at-command callback)
    - n : The number of the argument

Return value:

    The argument parsed as integer. Same behavior of qAtoI. If argument not found returns 0
*/
int qATParser_GetArgInt(const qATParser_PreCmd_t *param, int8_t n){
	return (int) qAtoI( qATParser_GetArgPtr(param, n) );
}
/*============================================================================*/
/*float qATParser_GetArgFlt(qATParser_PreCmd_t *param, int8_t n)

This function get the <n> argument parsed as <Float> from the incoming AT command.
This function should be only invoked from the callback context of the  recognized command.
Note: see qAtoF

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the at-command callback)
    - n : The number of the argument

Return value:

    The argument parsed as Float. Same behavior of qAtoF. If argument not found returns 0
*/
float qATParser_GetArgFlt(const qATParser_PreCmd_t *param, int8_t n){
	return (float) qAtoF( qATParser_GetArgPtr(param, n) );
}
/*============================================================================*/
/*float qATParser_GetArgFlt(qATParser_PreCmd_t *param, int8_t n)

This function get the <n> HEX argument parsed <uint32_t> from the
incoming AT command.
This function should be only invoked from the callback context of the recognized command.
Note: see qXtoU32

Parameters:

    - param : A pointer to the pre-parser instance
    		  (only available from the AT-Command callback)
    - n : The number of the argument

Return value:

    The HEX argument parsed as uint32_t. Same behavior of qXtoU32. If argument not found returns 0
*/
uint32_t qATParser_GetArgHex(const qATParser_PreCmd_t *param, int8_t n){
	return (uint32_t) qXtoU32( qATParser_GetArgPtr(param, n) );
}
#endif /*Q_ATCOMMAND_PARSER*/
/*============================================================================*/
#if ( Q_MEMORY_MANAGER  == 1 ) 
    static uint8_t DefaultHeap[Q_DEFAULT_HEAP_SIZE] = {0};
static qMemoryPool_t DefaultMemPool = {NULL, DefaultHeap, Q_DEFAULT_HEAP_SIZE, Q_DEFAULT_HEAP_SIZE, 0, {NULL, 0}};
    static qMemoryPool_t *MemPool = &DefaultMemPool;

    static void qHeapInit( void );
    static void qInsertBlockIntoFreeList( qMemBlockConnect_t *BlockToInsert );

    static const size_t ByteAlignmentMask   = ((size_t)Q_BYTE_ALIGNMENT - (size_t)1);
    static const size_t HeapStructSize	= ( ( sizeof( qMemBlockConnect_t ) + ( ( ( size_t ) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) - ( size_t ) 1 ) ) & ~( ( size_t ) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) );
    static const size_t MinBlockSize	= ( ( sizeof( qMemBlockConnect_t ) + ( ( ( size_t ) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) - ( size_t ) 1 ) ) & ~( ( size_t ) ((size_t)Q_BYTE_ALIGNMENT - (size_t)1) ) )*(size_t)2;
/*============================================================================*/
/*qBool_t qMemoryPool_Init(qMemoryPool_t *mPool, void* Area, size_t size)

Initializes a memory pool instance.
This function should be called once before any heap memory request.

Parameters:

    - mPool : A pointer to the memory pool instance
    - Area : A pointer to a memory block (uint8_t) statically allocated 
            to act as Heap of the memory pool. The size of this block
            should match the <size> argument.
    - size: The size of the memory block pointed by <Area>. 

Return value:

    qTrue on success, otherwise returns qFalse

*/
qBool_t qMemoryPool_Init(qMemoryPool_t *mPool, void* Area, size_t size){
    qBool_t RetValue = qFalse;
    if( NULL != mPool ){
        mPool->Heap = Area;
        mPool->HeapSize = size;
        mPool->End = NULL;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*void qMemoryPool_Select(qMemoryPool_t *mPool)

Select the memory pool to perform heap memory requests with qMalloc and qFree.

Parameters:

    - mPool : A pointer to the memory pool instance

*/
void qMemoryPool_Select(qMemoryPool_t *mPool){
    if( NULL != mPool ){
        MemPool = mPool;
    }
}
/*============================================================================*/
/*void qFree(void *ptr)

Deallocates the space previously allocated by qMalloc(). Deallocation will 
be performed in the selected memory pool.
If ptr is a null pointer, the function does nothing.
The behavior is undefined if selected memory pool has not been initialized.
The behavior is undefined if the value of ptr does not equal a value returned 
earlier by qMalloc.
The behavior is undefined if the memory area referred to by ptr has already been
deallocated, that is, qFree() has already been called with ptr as the argument 
and no calls to qMalloc() resulted in a pointer equal to ptr afterwards.
The behavior is undefined if after qFree() returns, an access is made through 
the pointer ptr.

Note: qFree its NOT interrupt-safe. 

Parameters:

    - ptr : Pointer to the memory to deallocate

*/
void qFree(void *ptr){
    uint8_t *pToFree;
    qMemBlockConnect_t *Connect;
    
    if( NULL == MemPool ){ /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    pToFree = (uint8_t*) ptr;
    
    if( NULL != ptr){
        pToFree -= HeapStructSize; /* memory being freed will have an qMemBlockConnect_t immediately before it. */
        Connect = (void*)pToFree;
        if( (size_t)0 != (Connect->BlockSize & MemPool->BlockAllocatedBit) ){
            Connect->BlockSize &= ~MemPool->BlockAllocatedBit; /* The block is being returned to the heap - it is no longer allocated. */
            MemPool->FreeBytesRemaining += Connect->BlockSize; /* Add this block to the list of free blocks. */
            qInsertBlockIntoFreeList( Connect );
        }
    }
}
/*============================================================================*/
static void qHeapInit( void ){
    qMemBlockConnect_t *FirstFreeBlock;
    uint8_t *Aligned;
    qAddress_t Address;
    size_t TotalHeapSize;
    
    if( NULL == MemPool ){ /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    
    if( MemPool == &DefaultMemPool ){ /*initialize the default memory pool */
        qMemoryPool_Init(MemPool, DefaultHeap, (size_t)Q_DEFAULT_HEAP_SIZE);
    }

    TotalHeapSize = MemPool->HeapSize;
    MemPool->Start.BlockSize = (size_t)0;
    MemPool->Start.Next = NULL;
    MemPool->FreeBytesRemaining = (size_t)0;
    
    Address = (qAddress_t)MemPool->Heap;
    if( ( Address & ByteAlignmentMask ) != 0ul ){
        Address += ( (size_t)Q_BYTE_ALIGNMENT - (size_t)1 );
        Address &= ~ByteAlignmentMask;
        TotalHeapSize -= Address - (qAddress_t)MemPool->Heap;
    }
    Aligned = (uint8_t*) Address;
    
    MemPool->Start.Next = ( void * ) Aligned; /* Start is used to hold a pointer to the first item in the list of free blocks*/
    MemPool->Start.BlockSize = (size_t)0;
    Address = ( (qAddress_t) Aligned ) + TotalHeapSize;
    Address -= HeapStructSize;
    Address &= ~ByteAlignmentMask;
    
    MemPool->End = (void*) Address; /* End is used to mark the end of the list of free blocks and is inserted at the end of the heap space. */
    MemPool->End->Next = NULL;
    MemPool->End->BlockSize = (size_t)0;
    FirstFreeBlock = (void*) Aligned; /* To start with there is a single free block that is sized to take up the entire heap space, minus the space taken by End. */
    FirstFreeBlock->BlockSize = Address - (qAddress_t)FirstFreeBlock;
    FirstFreeBlock->Next = MemPool->End;

    MemPool->FreeBytesRemaining = FirstFreeBlock->BlockSize;
    MemPool->BlockAllocatedBit = ( (size_t)1 ) << ( (sizeof(size_t)*(size_t)8) - (size_t)1 ); /* Work out the position of the top bit in a size_t variable. */
}
/*============================================================================*/
static void qInsertBlockIntoFreeList( qMemBlockConnect_t *BlockToInsert ){
    qMemBlockConnect_t *Iterator;
    uint8_t *ptr;
    
    if( NULL == MemPool ){  /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    /* Iterate through the list until a block is found that has a higher address than the block being inserted. */
    for( Iterator = &MemPool->Start ; Iterator->Next < BlockToInsert ; Iterator = Iterator->Next ){}
    
    ptr = ( uint8_t * ) Iterator; /* Do the block being inserted, and the block it is being inserted after make a contiguous block of memory? */
    if( ( ptr + Iterator->BlockSize ) == ( uint8_t * ) BlockToInsert ){ /*check if the block that its being inserted after make a contiguous block of memory*/
	    Iterator->BlockSize += BlockToInsert->BlockSize;
	    BlockToInsert = Iterator;
    }
	
    ptr = ( uint8_t * ) BlockToInsert;
    if( ( ptr + BlockToInsert->BlockSize ) == ( uint8_t * ) Iterator->Next ){ /* check if the block being inserted, and the block it is being inserted before make a contiguous block of memory? */
        if( Iterator->Next != MemPool->End ){ 
            BlockToInsert->BlockSize += Iterator->Next->BlockSize; /* Form one big block from the two blocks. */
            BlockToInsert->Next = Iterator->Next->Next;
        }
        else{
            BlockToInsert->Next = MemPool->End;
        }
    }
    else{
        BlockToInsert->Next = Iterator->Next;
    }

    if( Iterator != BlockToInsert ){
	    Iterator->Next = BlockToInsert;
    }
}
/*============================================================================*/
/*void* qMalloc( size_t size )

Allocate a block of memory that is <size> bytes large. Allocation will be performed
in the selected memory pool. If the requested memory can be allocated, a pointer 
is returned to the beginning of the memory block.

The behavior is undefined if selected memory pool has not been initialized.

Note: qMalloc its NOT interrupt-safe. 

Parameters:

    - size : Size of the memory block in bytes.

Return value:

    If the request is successful then a pointer to the memory block is returned.
    If the function failed to allocate the requested block of memory, a NULL
    pointer is returned.
*/
void* qMalloc( size_t size ){
    qMemBlockConnect_t *Block, *PreviousBlock, *NewBlockLink;
    void *Allocated = NULL;
    
    if( NULL == MemPool ){ /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    
    if( NULL == MemPool->End ){ /*First call,*/
	    qHeapInit(); /*initialize the heap to setup the list of free blocks*/
    }
    if( ( size & MemPool->BlockAllocatedBit ) == (size_t)0 ){
	    if( size > (size_t)0 ){ /* The requested size is increased so it can contain a qMemBlockConnect_t in addition to the requested amount of bytes. */
            size += HeapStructSize;
            if( ( size & ByteAlignmentMask ) != 0x00u ){ /*Ensure blocks are always aligned to the required number of bytes. */
		        size += ( (size_t)Q_BYTE_ALIGNMENT - ( size & ByteAlignmentMask ) ); /* byte-alignment */
            }
	    }
        if( ( size > (size_t)0 ) && ( size <= MemPool->FreeBytesRemaining ) ){
            PreviousBlock = &MemPool->Start; /* check list from the start (lowest address) block until one of adequate size is found. */
            Block = MemPool->Start.Next;
            while( ( Block->BlockSize < size ) && ( Block->Next != NULL ) ){
                PreviousBlock = Block;
                Block = Block->Next;
            }
            if( Block != MemPool->End ){ /* If the end marker was reached then a block of adequate size was	not found. */
                /* Return the memory space pointed to - jumping over the qMemBlockConnect_t node at its start. */
                Allocated = (void*) ( ( (uint8_t*)PreviousBlock->Next ) + HeapStructSize ); /* This block is being returned for use so must be. */
                PreviousBlock->Next = Block->Next; /* Allocated must be removed from the list of free blocks  */
                if( ( Block->BlockSize - size ) > MinBlockSize ){ /* If the block is larger than required it can be split into two. */
                    NewBlockLink = (void*) ( ( (uint8_t*)Block ) + size ); /* Create a new block following the number of bytes requested. */
                    NewBlockLink->BlockSize = Block->BlockSize - size; /* compute the sizes of two blocks split from the single block. */
                    Block->BlockSize = size;
                    qInsertBlockIntoFreeList( ( NewBlockLink ) ); /* Insert the new block into the list of free blocks. */
                }

                MemPool->FreeBytesRemaining -= Block->BlockSize;
                Block->BlockSize |= MemPool->BlockAllocatedBit; /* The block is being returned - it is allocated and owned by the application and has no "next" block*/
                Block->Next = NULL;
            }
        }
    }
    return Allocated;
}
/*============================================================================*/
/*size_t qHeapGetFreeSize(void)

Returns the total amount of heap space that remains unallocated for the selected
memory pool.

Return value:

    The size of the unallocated heap*

*/
size_t qHeapGetFreeSize(void){
    size_t RetValue = (size_t)0;
    
    if( NULL == MemPool ){ /*use the default memory pool if select*/
        MemPool = &DefaultMemPool;
    }
    RetValue = MemPool->HeapSize;
    
    if( MemPool->End ){
        RetValue =  MemPool->FreeBytesRemaining;
    }
    return RetValue;
}
/*============================================================================*/
#endif /*Q_MEMORY_MANAGER */

#if ( Q_LISTS == 1 )

static qNode_t* qList_RemoveFront(qList_t *list);
static qNode_t* qList_RemoveBack(qList_t *list);
static void qList_InsertAtFront(qList_t *list, qNode_t *node);
static void qList_InserAtBack(qList_t *list, qNode_t *node);

/*============================================================================*/
/*void qList_Initialize(qList_t *list)
 
Must be called before a list is used!  This initialises all the members of the 
list structure.

Parameters:

    - list : Pointer to the list being initialised.   

*/
void qList_Initialize(qList_t *list){
    if( NULL != list ){
        list->head = NULL;
        list->tail = NULL;
        list->size = 0u;
    }
}
/*=========================================================*/
static qNode_t* qList_NodeInit(void *node){
    qNode_t *xNode = (qNode_t*)node;
    xNode->prev = NULL;
    xNode->next = NULL;
    return xNode;
}
/*=========================================================*/
static void qList_InsertAtFront(qList_t *list, qNode_t *node){
    node->next = list->head;
    list->head->prev = node;
    list->head = node;
}
/*=========================================================*/
static void qList_InserAtBack(qList_t *list, qNode_t *node){
    list->tail->next = node;
    node->prev = list->tail;
    list->tail = node;
}
/*=========================================================*/
static qNode_t* qList_RemoveFront(qList_t *list){
    qNode_t *removed;
    
    removed = list->head;
    list->head = removed->next;
    if( NULL == list->head){
        list->tail = list->head;
    }
    else{
        list->head->prev = NULL;    
    }
    return removed;
}
/*=========================================================*/
static qNode_t* qList_RemoveBack(qList_t *list){
    qNode_t *removed;
    
    removed = list->tail;
    list->tail = removed->prev;
    if( NULL == list->tail){
        list->head = list->tail;
    }
    else{
        list->tail->next = NULL;    
    }
    
    return removed;
}
/*=========================================================*/
/*qBool_t qList_Insert(qList_t *list, void *node, qListPosition_t position)
 
Insert an item into the list.

Parameters:

    - list : Pointer to the list.
    - node : A pointer to the node to be inserted
    - position :  The position where the node will be inserted. Could be 
                 qList_AtFront, qList_AtBack or any other index number 
                 where the node will be inserted after.

Return value:

    qTrue if the item was successfully added tot he list, othewise returns qFalse   

*/
qBool_t qList_Insert(qList_t *list, void *node, qListPosition_t position){
    qBool_t RetValue = qFalse;
    qNode_t *newnode;
    qNode_t *iNode;
    int iPos;
 
    if( ( NULL != list ) && ( NULL != node ) && ( position >= -1 ) && ( position <= qList_AtBack )) {    
        if( qFalse == qList_IsMember(list, node)){
            newnode = qList_NodeInit(node);
            RetValue = qTrue;
            if( NULL == list->head ){ /*list is empty*/
                list->head = newnode; 
                list->tail = newnode;
            }
            else if( qList_AtFront == position){
                qList_InsertAtFront(list, node);
            }
            else if( ( qList_AtBack == position ) || ( position >= ( (qListPosition_t)list->size - 1 ) ) ){
                qList_InserAtBack(list, node);
            }
            else{ /*insert the new node after the position*/
                iPos = 0;
                for( iNode = list->head ; ( iPos < position ) && ( NULL != iNode->next ) ; iNode = iNode->next ){
                    iPos++;
                }
                newnode->next = iNode->next;  /*  NEW -> (i+1)NODE */
                newnode->prev = iNode;        /*  iNODE <- NEW */
                iNode->next->prev = newnode;  /*  NEW <- (i+1)NODE  */
                iNode->next = newnode;        /*  iNODE -> NEW */  
            }                                 /*  result: iNODE <-> NEW <-> (i+1)NODE    */
            list->size++;
        }
    }
    return RetValue;  
}
/*=========================================================*/           
/*void* qList_Remove(qList_t *list, void *node, qListPosition_t position)
 
Remove an item from the list.

Parameters:

    - list : Pointer to the list.
    - node : A pointer to the node to be deleted (to ignore pass NULL )
    - position : The position of the node that will be removed. Could be 
                 qList_AtFront, qList_AtBack or any other index number.

Return value:

    A pointer to the removed node. NULL if removal can be performed.  

*/ 
void* qList_Remove(qList_t *list, void *node, qListPosition_t position){
    qNode_t *removed = NULL;
    int iPos = 0;
    qNode_t *iNode;
    qNode_t *toRemove;
    if( ( NULL != list->head ) && ( position >= -1 ) ){
        if ( qList_IsMember(list, node) ){
            toRemove = (qNode_t*)node;
            if( toRemove == list->head ){
                removed = qList_RemoveFront(list);          
            }
            else{
                removed = toRemove;
                removed->prev->next = removed->next;
                if( NULL != removed->next){
                    removed->next->prev = removed->prev;
                }
            }
            list->size--;
        }
        else if( position <= 0 ){
            removed = qList_RemoveFront(list);     
            list->size--;
        }
        else if( ( qList_AtBack == position ) || ( position > ( (qListPosition_t)list->size - 1 ) ) ){
            removed = qList_RemoveBack(list);  
            list->size--;
        }
        else{
            for( iNode = list->head ; iPos < ( position - 1 ) ; iNode = iNode->next ){ 
                iPos++;
            }
            removed = iNode->next;       /*  <-> (inode0) <-> inode1 <-> inode2 */
            iNode->next = removed->next;
            if( NULL != removed->next ){
                iNode->next->prev = iNode;
            }
            list->size--;
        }                
    }
    return removed;
}
/*=========================================================*/
/*qBool_t qList_IsMember(qList_t *list, void *node)
 
Check if the node is member of the list.

Parameters:

    - list : Pointer to the list.
    - node : A pointer to the node

Return value:

    qTrue if the node belongs to the list, qFalse if it is not.  

*/ 
qBool_t qList_IsMember(const qList_t *list, void *node){
    qBool_t RetValue = qFalse;
    qNode_t *iNode;
    qNode_t *xNode = (qNode_t*)node;
    
    if( NULL != node ){
        for( iNode = list->head ; NULL != iNode ; iNode = iNode->next ){
            if( iNode == xNode){
                RetValue = qTrue;
                break;
            }
        }
    }
    return RetValue;
}
/*=========================================================*/
/*void qList_View(qList_t *list, qListVisualizer_t visualizer)
 
List visualization. The application writer should provide the
function to print out the corresponding node data.

Parameters:

    - list : Pointer to the list.
    - visualizer : The function for node data visualization.

*/ 
void qList_View(const qList_t *list, const qListVisualizer_t visualizer){
    qNode_t *iNode;
    for( iNode = list->head ; NULL != iNode ; iNode = iNode->next ){
        visualizer(iNode);
    }
}
/*=========================================================*/
/*void* qList_GetFront(qList_t *list)
 
Get a pointer to the front item of the list

Parameters:

    - list : Pointer to the list.

Return value:

    A pointer to the front node. NULL if the list is empty  

*/ 
void* qList_GetFront(const qList_t *list){
    void *RetValue = NULL;
    if( NULL != list ){
        RetValue = (void*)list->head;
    }
    return RetValue;
}
/*=========================================================*/
/*void* qList_GetBack(qList_t *list)
 
Get a pointer to the back item of the list

Parameters:

    - list : Pointer to the list.

Return value:

    A pointer to the back node. NULL if the list is empty  

*/ 
void* qList_GetBack(const qList_t *list){
    void *RetValue = NULL;
    if( NULL != list ){
        RetValue = (void*)list->tail;
    }
    return RetValue;
}
/*=========================================================*/
/*qBool_t qList_IsEmpty(qList_t *list)
 
Check if the list is empty.

Parameters:

    - list : Pointer to the list.

Return value:

    qTrue if the list is empty, qFalse if it is not.  

*/ 
qBool_t qList_IsEmpty(const qList_t *list){
    qBool_t RetValue = qTrue;
    if( NULL != list ){
        RetValue = (NULL == list->head)? qTrue : qFalse;
    }
    return RetValue;
}
/*=========================================================*/
/*void* qList_Length(qList_t *list)
 
Get the number of items inside the list

Parameters:

    - list : Pointer to the list.

Return value:

    The number of items of the list. 

*/ 
qSize_t qList_Length(const qList_t *list){
    qSize_t RetValue = 0u;
    if( NULL != list ){
        RetValue = list->size;
    }
    return RetValue;
}
/*=========================================================*/
#endif /*Q_LISTS */

#ifdef Q_TASK_DEV_TEST
#endif


#ifdef __CC_ARM
#endif
#ifdef __arm__
#endif
#ifdef __MWERKS__
#endif
#ifdef __CWCC__
#endif
#ifdef __AVR_ARCH__
#endif
#ifdef __XC8
    #pragma warning pop
#endif
#ifdef __XC16
#endif
#ifdef __XC32
#endif
#ifdef __IAR_SYSTEMS_ICC__
  #ifdef __ICC8051__
    #pragma diag_warning=Pa082
  #endif
#endif