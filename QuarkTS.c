/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Task Scheduler for low-range MCUs
 *  Version : 4.6.6h
 *  Copyright (C) 2012 Eng. Juan Camilo Gomez C. MSc. (kmilo17pet@gmail.com)
 *
 *  QuarkTS is free software: you can redistribute it and/or modify it
 *  under the terms of the GNU Lesser General Public License (LGPL)as published
 *  by the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  QuarkTS is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*******************************************************************************/

/*
For documentation, read the wiki
https://github.com/kmilo17pet/QuarkTS/wiki
and the available API
https://github.com/kmilo17pet/QuarkTS/wiki/APIs
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
        //#pragma warning disable 373    /*disable warning: (2030) a data pointer cannot be used to hold the address of a function*/
        /*--MSGDISABLE=2029:off,2030:off,373:off */
    #endif
    /*--MSGDISABLE=2029:off,2030:off,373:off */
#endif
#ifdef __XC16
#endif
#ifdef __XC32
#endif
/*=========================== QuarkTS Private Data ===========================*/
static volatile QuarkTSCoreData_t QUARKTS;
static volatile qClock_t _qSysTick_Epochs_ = 0ul;
/*========================= QuarkTS Private Methods===========================*/
static qTaskState_t _qScheduler_Dispatch(qTask_t *Task, qTrigger_t Event);
static qTask_t* _qScheduler_GetNodeFromChain(void);
static void _qScheduler_RearrangeChain(qTask_t **head);
static void _qScheduler_PriorizedInsert(qTask_t **head, qTask_t *Task);
static qBool_t _qScheduler_ReadyTasksAvailable(void);
static qTask_t* _qScheduler_PriorityQueueGet(void);
static void _qTriggerReleaseSchedEvent(void);
static uint8_t __q_revuta(uint32_t num, char* str, uint8_t base);

#ifdef Q_RINGBUFFERS 
    static qTrigger_t _qCheckRBufferEvents(qTask_t *Task);
    static qSize_t _qRBufferValidPowerOfTwo(qSize_t k);
    static qSize_t _qRBufferCount(qRBuffer_t *obj);
    static qBool_t _qRBufferFull(qRBuffer_t *obj);
#endif

static char qNibbletoX(uint8_t value);    
qPutChar_t __qDebugOutputFcn = NULL;
#ifdef Q_TRACE_VARIABLES
    char qDebugTrace_Buffer[Q_DEBUGTRACE_BUFSIZE] = {0};
#endif
#define _qabs(x)    ((((x)<0) && ((x)!=qPeriodic))? -(x) : (x))
/*========================== QuarkTS Private Macros ==========================*/
#define qEnterCritical()                        if(QUARKTS.I_Disable != NULL) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable()
#define qExitCritical()                         if(QUARKTS.I_Restorer != NULL) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags)

#define __qChainInitializer     ((qTask_t*)&_qSysTick_Epochs_) /*point to something that is not some task in the chain */
#define __qFSMCallbackMode      ((qTaskFcn_t)1)
#define _qTaskDeadlineReached(_TASK_)            ( (qTimeInmediate == (_TASK_)->Interval) || ((_qSysTick_Epochs_ - (_TASK_)->ClockStart)>=(_TASK_)->Interval)  )
#define _qTaskHasPendingIterations(_TASK_)       (_qabs((_TASK_)->Iterations)>0 || qPeriodic == (_TASK_)->Iterations)
#define _qEvent_FillCommonFields(_eVar_, _Trigger_, _FirstCall_, _TaskData_)    (_eVar_).Trigger = _Trigger_; (_eVar_).FirstCall = _FirstCall_; (_eVar_).TaskData = _TaskData_

#define qSchedulerStartPoint                    QUARKTS.Flag.Init=qTrue; do
#define qSchedulerEndPoint                      while(!QUARKTS.Flag.ReleaseSched); _qTriggerReleaseSchedEvent()

/*============================================================================*/
/*qTime_t qClock2Time(const qClock_t t)

Convert the specified input time(epochs) to time(seconds)

Parameters:

    - t : time in epochs   

Return value:

    time (t) in seconds
*/
qTime_t qClock2Time(const qClock_t t){
    return (qTime_t)(QUARKTS.Tick*t);
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
    return (qClock_t)(t/QUARKTS.Tick);
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
qBool_t qTaskIsEnabled(qTask_t Identifier)

Retrieve the enabled/disabled state

Parameters:

    - Identifier : The task node identifier.

Return value:

    True if the task in on Enabled state, otherwise returns false.
*/    
qBool_t qTaskIsEnabled(const qTask_t *Task){
    if(NULL==Task) return qFalse;
    return (qBool_t)Task->Flag[_qIndex_Enabled];
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

Disables the QuarkTS scheduling. The main thread will continue after the
qSchedule() call.
*/
void qSchedulerRelease(void){
    QUARKTS.Flag.ReleaseSched = qTrue;
}
/*============================================================================*/
/*void qSchedulerSetReleaseCallback(qTaskFcn_t Callback)

Set/Change the scheduler release callback function

Parameters:
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
void qSchedulerSetReleaseCallback(qTaskFcn_t Callback){
    QUARKTS.ReleaseSchedCallback = Callback;
}
/*============================================================================*/
/*uint32_t qTaskGetCycles(qTask_t Identifier)

Retrieve the number of task activations.

Parameters:

    - Identifier : The task node identifier.

Return value:

    A unsigned long value containing the number of task activations.
*/
uint32_t qTaskGetCycles(const qTask_t *Task){
    if (NULL==Task) return 0ul;
    return Task->Cycles;
}
/*============================================================================*/
/*void qTaskSendEvent(qTask_t *Task, void* eventdata)

Sends a simple asyncrohous event. This method marks the task as ready for 
execution, therefore, the planner will launch the task immediately according to
the execution chain (even if task is disabled) and setting the Trigger flag to
"byAsyncEvent". Specific user-data can be passed through, and will be available
inside the EventData field, only in corresponding launch.

Parameters:

    - Task : Pointer to the task node.

    - eventdata : Specific event user-data.
*/ 
void qTaskSendEvent(qTask_t *Task, void* eventdata){
    if(NULL==Task) return;
    Task->Flag[_qIndex_AsyncRun] = qTrue;
    Task->AsyncData = eventdata;
}
/*============================================================================*/
/*void qTaskSetTime(qTask_t *Task, qTime_t Value)

Set/Change the Task execution interval

Parameters:

    - Task : A pointer to the task node.

    - Value : Execution interval defined in seconds (floating-point format). 
              For inmediate execution (tValue = qTimeInmediate).
*/
void qTaskSetTime(qTask_t *Task, const qTime_t Value){
    if(NULL==Task) return;
    Task->Interval = qTime2Clock(Value);
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
    if(NULL==Task) return;
    Task->Iterations = (qPeriodic==Value)? qPeriodic : -Value;  
}
/*============================================================================*/
/*void qTaskSetPriority(qTask_t *Task, qPriority_t Value)

Set/Change the task priority value

Parameters:

    - Task : A pointer to the task node.

    - Value : Priority Value. [0(min) - 255(max)]
*/
void qTaskSetPriority(qTask_t *Task, const qPriority_t Value){
    if(NULL==Task) return;
    QUARKTS.Flag.Init = qFalse; 
    Task->Priority = Value; 
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
    if(NULL==Task) return;
    Task->Callback = CallbackFcn;
}
/*============================================================================*/
/*void qTaskSetState(qTask_t *Task, qState_t State)

Set the task state (Enabled or Disabled)

Parameters:

    - Task : A pointer to the task node.
    - State : qEnabled or qDisabled 
*/
void qTaskSetState(qTask_t *Task, const qState_t State){
    if(NULL==Task) return;
    if(State && Task->Flag[_qIndex_Enabled]) return;
    Task->Flag[_qIndex_Enabled] = State;
    Task->ClockStart = _qSysTick_Epochs_;
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
    if(NULL==Task) return;
    Task->TaskData = arg;
}
/*============================================================================*/
/*void qTaskClearTimeElapsed(qTask_t *Task)

Clear the elapsed time of the task. Restart the internal task tick;

Parameters:

    - Task : A pointer to the task node.
*/
void qTaskClearTimeElapsed(qTask_t *Task){
    if(NULL==Task) return;
    Task->ClockStart = _qSysTick_Epochs_;
}
/*============================================================================*/
/*qBool_t qTaskQueueEvent(qTask_t *Task, void* eventdata)

Insert an asyncrohous event in the FIFO priority queue. The task will be ready 
for execution according to the queue order (determined by priority), even 
if task is disabled. When extracted, the scheduler will set Trigger flag to 
"byQueueExtraction". Specific user-data can be passed through, and will be
 available inside the EventData field, only in corresponding launch.

Parameters:

    - Task : A pointer to the task node.

    - eventdata - Specific event user-data.

Return value:

    Returns qTrue if the event has been inserted in the queue, or qFalse if an error 
    occurred (The queue exceeds the size).
*/
qBool_t qTaskQueueEvent(qTask_t *Task, void* eventdata){
    #ifdef Q_PRIORITY_QUEUE
        volatile qQueueStack_t tmp;
        if((NULL==Task) || (QUARKTS.QueueIndex>=QUARKTS.QueueSize-1) ) return qFalse;    /*check if data can be queued*/
        tmp.QueueData = eventdata;
        tmp.Task = Task;
        QUARKTS.QueueStack[++QUARKTS.QueueIndex] = tmp; /*insert task and the corresponding eventdata to the queue*/
    return qTrue;
    #else
        return qFalse;
    #endif
}
/*============================================================================*/
/*void qSchedulerSetInterruptsED(void (*Restorer)(void), void (*Disabler)(void))

Set the hardware-specific code for global interrupt enable/disable. 
Setting this allows you to push Interrupt-safe data in the priority queue 
with <qTaskQueueEvent>

Parameters:

    - Restorer : The function with hardware specific code that enables or 
                 restores interrupts.
    - Disabler : The function with hardware specific code that disables interrupts.
*/ 
void qSchedulerSetInterruptsED(void (*Restorer)(uint32_t), uint32_t (*Disabler)(void)){
    QUARKTS.I_Restorer = Restorer;
    QUARKTS.I_Disable = Disabler;
}
#ifdef Q_PRIORITY_QUEUE
/*============================================================================*/
static qTask_t* _qScheduler_PriorityQueueGet(void){
    qTask_t *Task = NULL;
    uint8_t i;
    uint8_t IndexTaskToExtract = 0;
    qPriority_t MaxpValue;
    if(QUARKTS.QueueIndex < 0) return NULL; /*Return if no elements available*/
    qEnterCritical(); 
    MaxpValue = QUARKTS.QueueStack[0].Task->Priority;
    for(i=1;i<QUARKTS.QueueSize;i++){ /*Find the task with the highest priority*/
        if(NULL == QUARKTS.QueueStack[i].Task ) break; /*break if the tail is reached*/
        if(QUARKTS.QueueStack[i].Task->Priority > MaxpValue){ /*check if the queueded task has the max priority value*/
            MaxpValue = QUARKTS.QueueStack[i].Task->Priority; /*reasign the max value*/
            IndexTaskToExtract = i;  /*save the index*/
        }
    }   
    QUARKTS.QueueData = QUARKTS.QueueStack[IndexTaskToExtract].QueueData; /*get the data from the queue*/
    Task = QUARKTS.QueueStack[IndexTaskToExtract].Task; /*assign the task to the output*/
    Task->State = qReady; /*set the task as ready*/
    QUARKTS.QueueStack[IndexTaskToExtract].Task = NULL; /*set the position in the queue as empty*/  
    for(i=IndexTaskToExtract; i<QUARKTS.QueueIndex; i++) QUARKTS.QueueStack[i] = QUARKTS.QueueStack[i+1]; /*shift the queue*/
    QUARKTS.QueueIndex--;    /*decrease the index*/
    qExitCritical();
    return Task;
}
#endif
/*============================================================================*/
void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack){
    uint8_t i;
    QUARKTS.Head = NULL;
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.ReleaseSchedCallback = NULL;
    #ifdef Q_PRIORITY_QUEUE    
        QUARKTS.QueueStack = (qQueueStack_t*)Q_Stack;
        QUARKTS.QueueSize = Size_Q_Stack;
        for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = NULL;  /*set the priority queue as empty*/  
        QUARKTS.QueueIndex = -1;     
        QUARKTS.QueueData = NULL;
    #endif
    QUARKTS.Flag.Init = qFalse;
    QUARKTS.Flag.ReleaseSched = qFalse;
    QUARKTS.Flag.FCallReleased = qFalse;
    QUARKTS.I_Restorer =  NULL;
    QUARKTS.I_Disable = NULL;
    QUARKTS.CurrentRunningTask = NULL;
    _qSysTick_Epochs_ = 0ul;
}
/*============================================================================*/
/*qBool_t qSchedulerAddxTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg)

Add a task to the scheduling scheme. The task is scheduled to run every <Time> 
seconds, <nExecutions> times and executing <CallbackFcn> method on every pass.

Parameters:
    - Task : A pointer to the task node.

    - CallbackFcn : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.

    - Priority : Task priority Value. [0(min) - 255(max)]

    - Time : Execution interval defined in seconds (floating-point format). 
               For inmediate execution (tValue = qTimeInmediate).

    - nExecutions : Number of task executions (Integer value). For indefinite 
               execution (nExecutions = qPeriodic or qIndefinite). Tasks do not 
               remember the number of iteration set initially. After the 
               iterations are done, internal iteration counter is 0. If you 
               need to perform another set of iterations, you need to set the 
               number of iterations again.
    >Note 1: Tasks which performed all their iterations put their own 
             state to qDisabled.
    >Note 2: Asynchronous triggers do not affect the iteration counter.

    - InitialState : Specifies the initial state of the task (qEnabled or qDisabled).

    - arg : Represents the task arguments. All arguments must be passed by
            reference and cast to (void *). Only one argument is allowed, 
            so, for multiple arguments, create a structure that contains 
            all of the arguments and pass a pointer to that structure.

Return value:

    Returns qTrue on successs, otherwise returns qFalse;
    */
qBool_t qSchedulerAddxTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg){
    if(NULL==Task) return qFalse;
    if (((Time/2)<QUARKTS.Tick && Time) || CallbackFcn == NULL) return qFalse;
    qSchedulerRemoveTask(Task); /*Remove the task if was previously added to the chain*/
    Task->Callback = CallbackFcn;
    Task->Interval = qTime2Clock(Time);
    Task->TaskData = arg;
    Task->Priority = Priority;
    Task->Iterations = (qPeriodic==nExecutions)? qPeriodic : -nExecutions;    
    Task->Flag[_qIndex_AsyncRun] = qFalse;
    Task->Flag[_qIndex_InitFlag] = qFalse;
    Task->Flag[_qIndex_RBAutoPop] = qFalse; 
    Task->Flag[_qIndex_RBCount] = qFalse;
    Task->Flag[_qIndex_RBCount] = qFalse;
    Task->Flag[_qIndex_RBEmpty] = qFalse;
    Task->Flag[_qIndex_Enabled] = (qBool_t)(InitialState != qFalse);
    Task->Next = NULL;  
    Task->Cycles = 0;
    Task->ClockStart = _qSysTick_Epochs_;
    #ifdef Q_RINGBUFFERS
    Task->RingBuff = NULL;
    #endif
    Task->StateMachine = NULL;
    Task->State = qSuspended;
    _qScheduler_PriorizedInsert((qTask_t**)&QUARKTS.Head, Task); /*put the task on the list according to its priority*/
    return qTrue;
}
/*============================================================================*/
/*qBool_t qSchedulerAddeTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg)

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

    Returns qTrue on successs, otherwise returns qFalse;     
     */
qBool_t qSchedulerAddeTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg){
    return qSchedulerAddxTask(Task, CallbackFcn, Priority, qTimeInmediate, qSingleShot, qDisabled, arg);
}
/*============================================================================*/
/*qBool_t qSchedulerAddSMTask(qTask_t *Task, qPriority_t Priority, qTime_t Time,
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
               For inmediate execution (tValue = qTimeInmediate).

    - StateMachine: A pointer to the Finite State-Machine (FSM) object
  
    - InitState : The first state to be performed. This argument is a pointer 
                  to a callback function, returning qSM_Status_t and with a 
                  qSM_t pointer as input argument.

    - BeforeAnyState : A state called before the normal state machine execution.
                  This argument is a pointer to a callback function,  with a 
                  qSM_t pointer as input argument.
 
    - SuccessState : State performed after a state finish with return status 
                     qSM_EXIT_SUCCESS. This argument is a pointer to a callback
                     function with a qSM_t pointer as input argument.

    - FailureState : State performed after a state finish with return status 
                     qSM_EXIT_FAILURE. This argument is a pointer to a callback
                     function with a qSM_t pointer as input argument.

    - UnexpectedState : State performed after a state finish with return status
                        value between -32766 and 32767. This argument is a 
                        pointer to a callback function with a qSM_t pointer
                        as input argument.
 
    - InitialTaskState : Specifies the initial state of the task (qEnabled or qDisabled).

    - arg : Represents the task arguments. All arguments must be passed by
                     reference and cast to (void *). Only one argument is allowed, 
                     so, for multiple arguments, create a structure that contains 
                     all of the arguments and pass a pointer to that structure.
    Note:
 
Return value:

    Returns qTrue on successs, otherwise returns qFalse;
    */
qBool_t qSchedulerAddSMTask(qTask_t *Task, qPriority_t Priority, qTime_t Time,
                            qSM_t *StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg){
    if(NULL==StateMachine || NULL==InitState) return qFalse;
    if (!qSchedulerAddxTask(Task, __qFSMCallbackMode, Priority, Time, qPeriodic, InitialTaskState, arg)) return qFalse;    
    qStateMachine_Init(StateMachine, InitState, SuccessState, FailureState, UnexpectedState, BeforeAnyState);
    Task->StateMachine = StateMachine;
    return qTrue;
}
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
    if(NULL == tmp) return qFalse;
    while(tmp != Task && tmp->Next != NULL){ /*find the task to remove*/
        prev = tmp; /*keep on track the previous node*/
        tmp = tmp->Next;
    }
    if(tmp == Task){ /*remove the task if was found on the chain*/
        if(prev) prev->Next = tmp->Next; /*make link between adjacent nodes, this cause that the task being removed from the chain*/
        else QUARKTS.Head = tmp->Next; /*if the task is the head of the chain, move the head to the next node*/
        Task->Next = NULL; /*Just in case the deleted task needs to be added later to the scheduling scheme, otherwise, this would fuck the whole chain*/
        return qTrue;
    }
    return qFalse;
}
/*============================================================================*/
static void _qScheduler_PriorizedInsert(qTask_t **head, qTask_t *Task){
    qTask_t *tmp_node = NULL;
    if( (NULL == *head ) || (Task->Priority>(*head)->Priority) ){ /*is the first task in the scheme or the task has the highest priority over all */
        Task->Next = *head; /*move the head and just add the task node on top*/
        *head = Task; /*this task will be the new head*/
        return;
    }
    tmp_node = *head; /*start the head with the highest priority task*/
    while(tmp_node->Next && (Task->Priority<=tmp_node->Next->Priority) )  tmp_node = tmp_node->Next; /*find the right place for this task according its priority*/
    Task->Next = tmp_node->Next; /*the the new task  will be placed just after tmp*/
    tmp_node->Next = Task; /*assign the task*/
}
#ifdef Q_AUTO_CHAINREARRANGE
/*============================================================================*/
static void _qScheduler_RearrangeChain(qTask_t **head){ /*this method rearrange the chain according the priority of all its nodes*/
    qTask_t *new_head = NULL;
    qTask_t *tmp = *head;
    qTask_t *tmp1 = NULL;
    qEnterCritical();
    while(tmp){ /*start with a new head and re-insert the entire chain*/
        tmp1 = tmp;
        tmp = tmp->Next;
        _qScheduler_PriorizedInsert(&new_head, tmp1);  
    }
    *head = new_head; /*a new head will be created after the rearrangement*/
    QUARKTS.Flag.Init= qTrue; /*set the initializtion flag*/
    qExitCritical();
}
#endif
/*============================================================================*/
/*qBool_t qTaskLinkRBuffer(qTask_t *Task, qRBuffer_t *RingBuffer, qRBLinkMode_t Mode, uint8_t arg)

Links the Task with a Ring Buffer. 

Parameters:

    - Task : A pointer to the task node.

    - RingBuffer : A pointer to a Ring Buffer object
 
    - Mode: Linking mode. This implies the event that will trigger the task according
            to one of the following modes:
                        > qRB_AUTOPOP: The task will be triggered if there is elements 
                          in the Ring Buffer. Data data will be popped
                          automatically in every trigger and will be available 
                          in the <EventData> field of qEvent_t structure.
     
                        > qRB_FULL: the task will be triggered if the Ring Buffer
                          is full. The pointer to the RingBuffer will be 
                          available in the <EventData> field of qEvent_t structure.

                        > qRB_COUNT: the task will be triggered if the count of 
                          elements in the Ring Buffer reach the specified value. 
                          The pointer to the RingBuffer will be available in the
                          <EventData> field of qEvent_t structure.

                        > qRB_EMPTY: the task will be triggered if the Ring Buffer
                          is empty. The pointer to the RingBuffer will be 
                          available in the <EventData> field of qEvent_t structure.
 
    - arg: This argument defines if the Ring buffer will be linked (qLINK) or 
           unlinked (qUNLINK) from the task.
           If the qRB_COUNT mode is specified, this value will be used to check
           the element count of the Ring Buffer. A zero value will act as 
           an unlink action. 

Return value:

    Returns qTrue on successs, otherwise returns qFalse;     
*/
#ifdef Q_RINGBUFFERS
qBool_t qTaskLinkRBuffer(qTask_t *Task, qRBuffer_t *RingBuffer, const qRBLinkMode_t Mode, uint8_t arg){
    if(NULL==RingBuffer || NULL==Task || Mode<qRB_AUTOPOP || Mode>qRB_EMPTY) return qFalse;   /*Validate*/
    if(NULL==RingBuffer->data) return qFalse;    
    Task->Flag[Mode] = (qBool_t)((Mode==qRB_COUNT)? arg : (arg!=qFalse)); /*if mode is qRB_COUNT, use their arg value as count*/
    Task->RingBuff = (arg>0)? RingBuffer : NULL; /*reject, no valid arg input*/
    return qTrue;
}
/*============================================================================*/
static qTrigger_t _qCheckRBufferEvents(qTask_t *Task){
    if(NULL==Task) return qTriggerNULL;
    if(NULL==Task->RingBuff) return qTriggerNULL;
    if(Task->Flag[_qIndex_RBFull])       if(_qRBufferFull(Task->RingBuff))                                      return byRBufferFull;           
    if(Task->Flag[_qIndex_RBCount]>0)    if(_qRBufferCount(Task->RingBuff) >= Task->Flag[_qIndex_RBCount] )     return byRBufferCount;            
    if(Task->Flag[_qIndex_RBAutoPop])    if(qRBufferGetFront(Task->RingBuff)!=NULL)                             return byRBufferPop;   
    if(Task->Flag[_qIndex_RBEmpty])      if(qRBufferEmpty(Task->RingBuff))                                      return byRBufferEmpty;       
    return qTriggerNULL;
}
#endif
/*============================================================================*/
static void _qTriggerReleaseSchedEvent(void){
    QUARKTS.Flag.Init = qFalse;
    QUARKTS.Flag.ReleaseSched = qFalse;   
    QUARKTS.EventInfo.FirstCall = (qBool_t)(!QUARKTS.Flag.FCallReleased);    
    QUARKTS.EventInfo.Trigger = bySchedulingRelease;
    QUARKTS.EventInfo.TaskData = NULL;
    if(QUARKTS.ReleaseSchedCallback!=NULL) QUARKTS.ReleaseSchedCallback((qEvent_t)&QUARKTS.EventInfo);
    QUARKTS.Flag.FCallIdle = qTrue;      
}
/*============================================================================*/
/*
void qSchedulerSysTick(void)

Feed the scheduler system tick. This call is mandatory and must be called once
inside the dedicated timer interrupt service routine (ISR). 
*/    
void qSchedulerSysTick(void){_qSysTick_Epochs_++;}
/*============================================================================*/
/*void qSchedule(void)
    
Executes the task-scheduler scheme. It must be called once after the task
pool has been defined.

  Note : qScheduleRun keeps the application in an endless loop
*/
void qSchedulerRun(void){
    qTask_t *Task = NULL; /*this pointer will hold the current node from the chain and/or the top enqueue node if available*/
    qSchedulerStartPoint{
        #ifdef Q_AUTO_CHAINREARRANGE
        if(!QUARKTS.Flag.Init) _qScheduler_RearrangeChain((qTask_t**)&QUARKTS.Head); /*if initial scheduling conditions changed, sort the chain by priority (init flag internally set)*/
        #endif
        #ifdef Q_PRIORITY_QUEUE
        if((Task = _qScheduler_PriorityQueueGet())) Task->State = _qScheduler_Dispatch(Task, byQueueExtraction);  /*Available queueded task will be dispatched in every scheduling cycle : the queue has the higher precedence*/    
        #endif
        if(_qScheduler_ReadyTasksAvailable()){  /*Check if all the tasks from the chain fulfill the conditions to get the qReady state, if at least one gained it,  enter here*/
            while((Task = _qScheduler_GetNodeFromChain())) /*Get node by node from the chain until no more available*/
                Task->State = (qTaskState_t) ((qReady == Task->State) ? _qScheduler_Dispatch(Task, Task->Trigger) : qWaiting);  /*Dispatch the qReady tasks, otherwise put it in qWaiting State*/
        }
        else if(NULL==Task && QUARKTS.IDLECallback) _qScheduler_Dispatch(NULL, byNoReadyTasks); /*no tasks are available for execution, run the idle task*/
    }qSchedulerEndPoint; /*scheduling end-point (also check for scheduling-release request)*/
}
/*============================================================================*/
static qTask_t* _qScheduler_GetNodeFromChain(void){ 
    static qTask_t *ChainIterator = __qChainInitializer; /*used to keep on track the current chain position*/
    qTask_t *Node;  /*used the hold the node*/
    if(__qChainInitializer == ChainIterator) ChainIterator = QUARKTS.Head; /*First call, start from the head*/
    Node = ChainIterator; /*obtain the current node from the chain*/
    ChainIterator = (ChainIterator)? ChainIterator->Next : QUARKTS.Head; /*Tail reached, reset the iterator to the head*/
    return Node; /*return the task node at current chain position*/
}
/*============================================================================*/
static qTaskState_t _qScheduler_Dispatch(qTask_t *Task, const qTrigger_t Event){
    switch(Event){ /*take the necessary actions before dispatching, depending on the event that triggered the task*/
        case byTimeElapsed:
            /*handle the iteration value and the FirstIteration flag*/
            Task->Iterations = (QUARKTS.EventInfo.FirstIteration = (qBool_t)((Task->Iterations!=qPeriodic) && (Task->Iterations<0)))? -Task->Iterations : Task->Iterations;
            if(Task->Iterations!= qPeriodic) Task->Iterations--; /*Decrease the iteration value*/
            if((QUARKTS.EventInfo.LastIteration = (qBool_t)(Task->Iterations == 0))) Task->Flag[_qIndex_Enabled] = qFalse; /*When the iteration value is reached, the task will be disabled*/            
            break;
        case byAsyncEvent:
            QUARKTS.EventInfo.EventData = Task->AsyncData; /*Transfer async-data to the eventinfo structure*/
            Task->Flag[_qIndex_AsyncRun] = qFalse; /*Clear the async flag*/            
            break;
        #ifdef Q_RINGBUFFERS    
        case byRBufferPop:
            QUARKTS.EventInfo.EventData = qRBufferGetFront(Task->RingBuff); /*the EventData will point to the RBuffer front-data*/
            break;
        case byRBufferFull: case byRBufferCount: case byRBufferEmpty: 
            QUARKTS.EventInfo.EventData = (void*)Task->RingBuff;  /*the EventData will point to the the linked RingBuffer*/
            break;
        #endif
        #ifdef Q_PRIORITY_QUEUE
        case byQueueExtraction:
            QUARKTS.EventInfo.EventData = QUARKTS.QueueData; /*get the extracted data from queue*/
            QUARKTS.QueueData = NULL;
            break;
        #endif
        case byNoReadyTasks: /*only used for the idle task*/
            QUARKTS.EventInfo.FirstCall = (qBool_t)(!QUARKTS.Flag.FCallIdle);
            QUARKTS.EventInfo.Trigger = Event;
            QUARKTS.EventInfo.TaskData = NULL;
            QUARKTS.IDLECallback((qEvent_t)&QUARKTS.EventInfo); /*run the idle callback*/
            QUARKTS.Flag.FCallIdle = qTrue;      
            return qSuspended; /*No more things to do*/
        default: break;
    }
    Task->State = qRunning; /*put the task in running state*/
    /*Fill the event info structure*/
    _qEvent_FillCommonFields(QUARKTS.EventInfo, Event, (qBool_t)(!Task->Flag[_qIndex_InitFlag]), Task->TaskData); /*Fill common fields of EventInfo: Trigger, FirstCall and TaskData*/ 
    QUARKTS.CurrentRunningTask = Task; /*needed for qTaskSelf()*/
    if (Task->StateMachine != NULL && __qFSMCallbackMode==Task->Callback) qStateMachine_Run(Task->StateMachine, (void*)&QUARKTS.EventInfo);  /*If the task has a FSM attached, just run it*/  
    else if (Task->Callback != NULL) Task->Callback((qEvent_t)&QUARKTS.EventInfo); /*else, just launch the callback function*/        
    QUARKTS.CurrentRunningTask = NULL;
    #ifdef Q_RINGBUFFERS 
    if(Event==byRBufferPop) Task->RingBuff->tail++;  /*remove the data from the RBuffer, if the event was byRBufferPop*/
    #endif
    Task->Flag[_qIndex_InitFlag] = qTrue; /*clear the init flag*/
    QUARKTS.EventInfo.FirstIteration = qFalse;
    QUARKTS.EventInfo.LastIteration =  qFalse; 
    QUARKTS.EventInfo.EventData = NULL; /*clear the eventdata*/
    Task->Cycles++; /*increase the task cycles value*/
    return qSuspended;
}
/*============================================================================*/
static qBool_t _qScheduler_ReadyTasksAvailable(void){ /*this method checks for tasks that fullfill the conditions to get the qReady state*/
    qTask_t *Task = NULL;
    #ifdef Q_RINGBUFFERS 
    qTrigger_t trg = qTriggerNULL;
    #endif
    qBool_t nTaskReady = qFalse; /*this flag will let me know if at least one task is in qReady state*/
    for(Task = QUARKTS.Head; Task; Task = Task->Next){ /*loop every task in the chain : only one event will be verified by node*/
        if(Task->Flag[_qIndex_Enabled]){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
            if(_qTaskHasPendingIterations(Task)){ /*then task should be periodic or must have pending iters*/
                if(_qTaskDeadlineReached(Task)){ /*finally, check the time deadline*/
                    Task->ClockStart = _qSysTick_Epochs_; /*Restart the task time*/
                    Task->State = qReady; /*Put the task in ready state*/
                    Task->Trigger = byTimeElapsed; /*Set the corresponding trigger*/
                    nTaskReady = qTrue; /*at least one task in the chain is ready to run*/
                    continue; /*check the next task*/                   
                }
            }
        }
        #ifdef Q_RINGBUFFERS 
        if((trg=_qCheckRBufferEvents(Task)) != qTriggerNULL){ /*If the deadline has not met, check if there is a RBuffer event available*/
            Task->State = qReady; /*Put the task in ready state*/
            Task->Trigger = trg; /*If a RBuffer event exist, the flag will be available in the <trg> variable*/
            nTaskReady = qTrue;  /*at least one task in the chain is ready to run*/
            continue; /*check the next task*/
        }
        #endif
        if( Task->Flag[_qIndex_AsyncRun]){   /*The last check will be if the task has an async event*/
            Task->State = qReady; /*Put the task in ready state*/
            Task->Trigger = byAsyncEvent; /*Set the corresponding trigger*/
            nTaskReady = qTrue;  /*at least one task in the chain is ready to run*/
            continue; /*check the next task*/
        }
        Task->State = qSuspended; /*If the task has no pending events, put it in a suspended state*/
    }
    return nTaskReady;
}
/*============================================================================*/
/*qBool_t qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);

Initializes a finite state machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.

    - InitState : The first state to be performed. This argument is a pointer 
                  to a callback function, returning qSM_Status_t and with a 
                  qFSM_t pointer as input argument.

    - SuccessState : State performed after a state finish with return status 
                     qSM_EXIT_SUCCESS. This argument is a pointer to a callback
                     function with a qFSM_t pointer as input argument.

    - FailureState : State performed after a state finish with return status 
                     qSM_EXIT_FAILURE. This argument is a pointer to a callback
                     function with a qFSM_t pointer as input argument.

    - UnexpectedState : State performed after a state finish with return status
                        value between -32766 and 32767. This argument is a 
                        pointer to a callback function with a qFSM_t pointer
                        as input argument.

Return value:

    Returns 0 on successs, otherwise returns -1;
*/
qBool_t qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState, qSM_SubState_t BeforeAnyState){
    if(NULL==obj || NULL==InitState) return qFalse;
    obj->NextState = InitState;
    qConstField_Set(qSM_State_t, obj->PreviousState)/*obj->PreviousState*/ = NULL;
    qConstField_Set(qBool_t, obj->StateFirstEntry)/*obj->StateFirstEntry*/ = 0;
    qConstField_Set(qSM_Status_t, obj->PreviousReturnStatus)/*obj->PreviousReturnStatus*/ = qSM_EXIT_SUCCESS;
    qConstField_Set(qSM_SubState_t, obj->qPrivate.__Failure)/*obj->qPrivate.__Failure*/ = FailureState;
    qConstField_Set(qSM_SubState_t, obj->qPrivate.__Success)/*obj->qPrivate.__Success*/ = SuccessState;
    qConstField_Set(qSM_SubState_t, obj->qPrivate.__Unexpected)/*obj->qPrivate.__Unexpected*/ = UnexpectedState;
    qConstField_Set(qSM_SubState_t, obj->qPrivate.__BeforeAnyState)/*obj->qPrivate.__BeforeAnyState*/ = BeforeAnyState;
    qConstField_Set(qSM_State_t, obj->LastState)/*obj->LastState*/ = NULL;
    return qTrue;
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
    if(NULL==obj) return;
    qConstField_Set(void* ,obj->Data)/*obj->Data*/ = Data;   /*pass the data through the fsm*/
    if(obj->qPrivate.__BeforeAnyState != NULL) obj->qPrivate.__BeforeAnyState(obj); /*eval the BeforeAnyState if available*/
    if(obj->NextState!=NULL){ /*eval nextState if available*/
        qConstField_Set(qBool_t, obj->StateFirstEntry)/*obj->StateFirstEntry*/ = (qBool_t)(obj->LastState != obj->NextState);  /*Get the StateFirstEntry flag*/
        if(obj->StateFirstEntry) qConstField_Set(qSM_State_t, obj->PreviousState)/*obj->PreviousState*/ = obj->LastState ; /*if StateFistEntry is set, update the PreviousState*/
        prev = obj->NextState; /*keep the next state in prev for LastState update*/
        qConstField_Set(qSM_Status_t, obj->PreviousReturnStatus)/*obj->PreviousReturnStatus*/ = obj->NextState(obj); /*Eval the current state, and get their return status*/
        qConstField_Set(qSM_State_t, obj->LastState)/*obj->LastState*/ = prev; /*update the LastState*/
    }
    else    qConstField_Set(qSM_Status_t, obj->PreviousReturnStatus)/*obj->PreviousReturnStatus*/ = qSM_EXIT_FAILURE; /*otherwise jump to the failure state*/
    
    switch(obj->PreviousReturnStatus){ /*Check return status to eval extra states*/
        case qSM_EXIT_FAILURE:  if(obj->qPrivate.__Failure != NULL) obj->qPrivate.__Failure(obj);  /*Run failure state if available*/
            break;
        case qSM_EXIT_SUCCESS:  if(obj->qPrivate.__Success != NULL) obj->qPrivate.__Success(obj);  /*Run success state if available*/
            break;
        default:                if(obj->qPrivate.__Unexpected != NULL) obj->qPrivate.__Unexpected(obj); /*Run unexpected state if available*/
            break;
    }
 }
/*============================================================================*/
/*void qStateMachine_Attribute(qSM_t *obj, qFSM_Attribute_t Flag ,void *val)

Change attributes or set actions to the Finite State Machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
 
    - Flag: The attribute/action to be taken
         > qSM_RESTART : Restart the FSM (val argument must correspond to the init state)
         > qSM_CLEAR_STATE_FIRST_ENTRY_FLAG: clear the entry flag for the 
                current state if the NextState field doesnt change.
         > qSM_FAILURE_STATE: Set the Failure State
         > qSM_SUCCESS_STATE: Set the Success State
         > qSM_UNEXPECTED_STATE: Set the Unexpected State
         > qSM_BEFORE_ANY_STATE: Set the state executed before any state.
 
    - Data : Specific attribute Data or Value.
*/    
void qStateMachine_Attribute(qSM_t *obj, qFSM_Attribute_t Flag ,void *val){
    switch(Flag){
        case qSM_RESTART:
            obj->NextState = (qSM_State_t)val;
            qConstField_Set(qSM_State_t, obj->PreviousState)/*obj->PreviousState*/ = NULL;
            qConstField_Set(qSM_State_t, obj->LastState)/*obj->LastState*/ = NULL;
            qConstField_Set(qBool_t, obj->StateFirstEntry)/*obj->StateFirstEntry*/ = 0;
            qConstField_Set(qSM_Status_t, obj->PreviousReturnStatus)/*obj->PreviousReturnStatus*/ = qSM_EXIT_SUCCESS;            
            return;
        case qSM_CLEAR_STATE_FIRST_ENTRY_FLAG:
            qConstField_Set(qSM_State_t, obj->PreviousState)/*obj->PreviousState*/  = NULL;
            qConstField_Set(qSM_State_t, obj->LastState)/*obj->LastState*/ = NULL;
            return;
        case qSM_FAILURE_STATE:
            qConstField_Set(qSM_SubState_t, obj->qPrivate.__Failure)/*obj->qPrivate.__Failure*/ = (qSM_SubState_t)val;
            return;
        case qSM_SUCCESS_STATE:
            qConstField_Set(qSM_SubState_t, obj->qPrivate.__Success)/*obj->qPrivate.__Success*/ = (qSM_SubState_t)val;
            return;    
        case qSM_UNEXPECTED_STATE:
            qConstField_Set(qSM_SubState_t, obj->qPrivate.__Unexpected)/*obj->qPrivate.__Unexpected*/ = (qSM_SubState_t)val;
            return;   
        case qSM_BEFORE_ANY_STATE:
            qConstField_Set(qSM_SubState_t, obj->qPrivate.__BeforeAnyState)/*obj->qPrivate.__BeforeAnyState*/ = (qSM_SubState_t)val;
            return;              
        default:
            return;
    }
}
/*============================================================================*/
/*qBool_t qSTimerSet(qSTimer_t OBJ, qTime_t Time)
 
Set the expiration time for a STimer. On success, the Stimer gets 
armed immediately

Parameters:

    - obj : A pointer to the STimer object.

    - Time : The expiration time(Must be specified in seconds).

    > Note 1: The scheduler must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greather than 
              the scheduler-Tick.

Return value:

    Returns qTrue on success, otherwise, returns qFalse.
*/
qBool_t qSTimerSet(qSTimer_t *obj, const qTime_t Time){
    if(NULL==obj) return qFalse;
    if ( (Time/2.0)<QUARKTS.Tick ) return qFalse; /*check if the input time is higher than half of the system tick*/
    qConstField_Set(qClock_t, obj->TV)/*obj->TV*/ = qTime2Clock(Time); /*set the stimer time in epochs*/
    qConstField_Set(qClock_t, obj->Start)/*obj->Start*/ = _qSysTick_Epochs_; /*set the init time of the stimer with the current system epoch value*/
    qConstField_Set(qBool_t, obj->SR)/*obj->SR*/ = qTrue; /*enable the stimer*/
    return qTrue;
}
/*============================================================================*/
/*qBool_t qSTimerFreeRun(qSTimer_t *obj, qTime_t Time)

Non-Blocking STimer check with automatic arming. 
Behavior:
If disarmed, it gets armed inmediatly with the specified time. 
If armed, the time argument is ignored and the API only checks for expiration.
When the time expires, the STimer gets armed inmediatly taking the specified time.

Parameters:

    - obj : A pointer to the STimer object.
  
    - Time : The expiration time(Must be specified in seconds). 
 
    > Note 1: The scheduler must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greather than  
              the scheduler-Tick.
    > Note 3: Time parameter is only taken when the STimer is re-armed
  
Return value:

    Returns qTrue when STimer expires, otherwise, returns qFalse.
    > Note 4: A disarmed STimer also returns qFalse.
    > Note 5: After the STimer expiration,  qSTimerFreeRun re-arms the STimer
*/
qBool_t qSTimerFreeRun(qSTimer_t *obj, const qTime_t Time){
    if(NULL==obj) return qFalse;
    if(obj->SR){  /*if the stimer is enabled*/
        if (qSTimerExpired(obj)){ /*check for expiration*/
            qSTimerDisarm(obj); /*if expired, disarm the stimer*/
            return qTrue; 
        }
        else return qFalse;
    }
    qSTimerSet(obj, Time); /*if stimer not enabled, rearm the timer*/
    return qFalse;    
}
/*============================================================================*/
/*qBool_t qSTimerExpired(qSTimer_t *obj)

Non-Blocking Stimer check

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    Returns qTrue when STimer expires, otherwise, returns qFalse.
    > Note 1: A disarmed STimer also returns false.

*/
qBool_t qSTimerExpired(const qSTimer_t *obj){
    if(NULL==obj) return qFalse;
    if(!obj->SR) return qFalse; 
    return (qBool_t)(qSTimerElapsed(obj)>=obj->TV); 
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
    if(NULL==obj) return 0ul;
    if(!obj->SR) return 0;
    return (_qSysTick_Epochs_- obj->Start);
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
    qClock_t elapsed;
    if(NULL==obj) return 0;
    elapsed = qSTimerElapsed(obj);
    return (obj->TV <= 0 || elapsed>obj->TV)? obj->TV : obj->TV-elapsed;
}
/*============================================================================*/
/*void qSTimerDisarm(qSTimer_t *obj)

Disarms the STimer

Parameters:

    - obj : A pointer to the STimer object.  
*/
void qSTimerDisarm(qSTimer_t *obj){
    if(NULL==obj) return;
    qConstField_Set(qBool_t, obj->SR) /*obj->SR*/ = qFalse;
    qConstField_Set(qClock_t, obj->Start) /*obj->Start*/ = 0ul;
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
    if(NULL==obj) return qFalse;
    return obj->SR;
}
/*============================================================================*/
/*void qSTimerChangeTime(qSTimer_t *obj, const qTime_t Time)

Change the time value for the STimer

Parameters:

    - obj : A pointer to the STimer object.  
    - Time : The new expiration time(Must be specified in seconds).
*/
void qSTimerChangeTime(qSTimer_t *obj, const qTime_t Time){
    if(NULL==obj) return;
    qConstField_Set(qClock_t, obj->TV)/*obj->TV*/ = qTime2Clock(Time);
}
#ifdef Q_MEMORY_MANAGER
/*============================================================================*/
/*void* qMemoryAlloc(qMemoryPool_t *obj, uint16_t size)
 
Allocate the required memory from the specified memory heap. The allocation 
is rounded to the memory block size.
 
Parameters:

    - obj : a pointer to the memory pool object
 
    - size : amount of memory to allocate
 
Return value:

    A pointer to allocated memory or null if there is not available memory
 */
void* qMemoryAlloc(qMemoryPool_t *obj, const qSize_t size){
    uint8_t i, j, k, c;
    uint16_t sum;		
    uint8_t *offset = obj->Blocks;
    if(NULL==obj) return NULL;			
    j = 0;	
    qEnterCritical();
    while( j < obj->NumberofBlocks ) {	/*loop until we find a free memory block*/		
        sum  = 0;
        i = j;
	while( i < obj->NumberofBlocks ) {		
            if( *(obj->BlockDescriptors+i) ) {
                offset += (*(obj->BlockDescriptors+i)) * (obj->BlockSize);
		        i += *(obj->BlockDescriptors+i);				 
		        continue;
            }
            break;				
	}
	
        j = i;	/*<j> should be the index of the first free mem block and <offset> is the offset in the buffer*/
	for(k = 1, i = j; i < obj->NumberofBlocks; k++, i++) {
            if( *(obj->BlockDescriptors+i) ) {	 /*We haven't found the required amount of mem blocks. Continue with the next free memory block.*/		
                j = (uint8_t)(i + *(obj->BlockDescriptors+i)); /*Increment j for the number of used memory blocks*/
                    offset = obj->Blocks;
                    offset += j * (obj->BlockSize);
                    break;
            }
            sum += obj->BlockSize;
            if( sum >= size ) { /*memory area found*/
                *(obj->BlockDescriptors+j) = k; /*leave the record*/
		for(c=0;c<size;c++) offset[i] = 0x00u; /*zero-initialized memory block*/ 
                qExitCritical();
		return (void*)offset; /*return the pointer to the free memory block*/
            }						
	}
	if( i == obj->NumberofBlocks ) break;
    }
    qExitCritical();
    return NULL; /*memory not available*/
}
/*============================================================================*/
/*void* qMemoryFree(qMemoryPool_t *obj, void* pmem)
 
Free the previously allocated memory by returning it to the specified memory pool.
 
Parameters:

    - obj : a pointer to the memory pool object
 
    - pmem : pointer to the previously allocated memory
 
Note: The memory must be returned to the pool from where was allocated
 */
void qMemoryFree(qMemoryPool_t *obj, void* pmem){
    uint8_t i, *p;
    if(NULL==obj || NULL==pmem) return;
    qEnterCritical();	
    p = obj->Blocks;
    for(i = 0; i < obj->NumberofBlocks; i++) {
        if( p == pmem ){
            *(obj->BlockDescriptors + i) = 0;
            break;
	}
	p += obj->BlockSize;
    }
    qExitCritical();
}
/*============================================================================*/
#endif

#ifdef Q_RINGBUFFERS
/*============================================================================*/
static qSize_t _qRBufferValidPowerOfTwo(qSize_t k){
    uint16_t i;
    if ( ((k-1) & k) != 0) {
        k--;
        for (i = 1; i<sizeof(uint16_t)*8; i= (uint16_t) (i * 2)) k = k | k >> i;
        k = (qSize_t) ((k + 1) >> 1);
    }
    return k;
}
/*============================================================================*/
static qSize_t _qRBufferCount(qRBuffer_t *obj){
    return (qSize_t)(obj ? (obj->head - obj->tail) : 0);
}
/*============================================================================*/
static qBool_t _qRBufferFull(qRBuffer_t *obj){
    return (qBool_t)(obj ? (qBool_t)(_qRBufferCount(obj) == obj->Elementcount) : qTrue);
}
/*============================================================================*/
/*void qRBufferInit(qRBuffer_t *obj, void* DataBlock, uint16_t ElementSize, uint16_t ElementCount)
 
Configures the ring buffer
 
Parameters:

    - obj : a pointer to the Ring Buffer object
 
    - DataBlock :  data block or array of data

    - ElementSize : size of one element in the data block
 
    - ElementCount : Max number of elements in the bufffer
 
Note: Element_count should be a power of two, or it will only use the next 
      lower power of two
 */
void qRBufferInit(qRBuffer_t *obj, void* DataBlock, const qSize_t ElementSize, const qSize_t ElementCount){
    if(NULL==obj || NULL==DataBlock) return;
    obj->head = 0;
    obj->tail = 0;
    obj->data = DataBlock;
    obj->ElementSize = ElementSize;
    obj->Elementcount = _qRBufferValidPowerOfTwo(ElementCount); /*limit to a power of two, this allos a bit to be used to count the final slot*/
}
/*============================================================================*/
/*qBool_t qRBufferEmpty(qRBuffer_t *obj)
 
Returns the empty/full status of the ring buffer
 
Parameters:

    - obj : a pointer to the Ring Buffer object
  
Return value:

    qTrue if the ring buffer is empty, qFalse if it is not.
 */
qBool_t qRBufferEmpty(qRBuffer_t *obj){
    return (qBool_t)(obj ? (qBool_t)(0==_qRBufferCount(obj)) : qTrue);    
}
/*============================================================================*/
/*void* qRBufferGetFront(qRBuffer_t *obj)
 
Looks at the data from the head of the list without removing it
 
Parameters:

    - obj : a pointer to the Ring Buffer object
  
Return value:

    Pointer to the data, or NULL if nothing in the list
 */
void* qRBufferGetFront(qRBuffer_t *obj){
    if (NULL==obj) return NULL;
    return (void*)(!qRBufferEmpty(obj) ? &(obj->data[(obj->tail % obj->Elementcount) * obj->ElementSize]) : NULL);    
}
/*============================================================================*/
/*void* qRBufferPopFront(qRBuffer_t *obj)
 
Extract the data from the front of the list, and removes it
 
Parameters:

    - obj : a pointer to the Ring Buffer object
    - dest: pointer to where the data will be written
  
Return value:

    qTrue if data was retrived from Rbuffer, otherwise returns qFalse
*/
qBool_t qRBufferPopFront(qRBuffer_t *obj, void *dest){
    void *data = NULL;
    if(NULL==obj) return qFalse;
    if (!qRBufferEmpty(obj)) {
        data = (void*)(&(obj->data[(obj->tail % obj->Elementcount) * obj->ElementSize]));
        memcpy(dest, data, obj->ElementSize);
        obj->tail++;
        return qTrue;
    }
    return qFalse;    
}
/*============================================================================*/
/*qBool_t qRBufferPush(qRBuffer_t *obj, void *data)
 
Adds an element of data to the ring buffer
 
Parameters:

    - obj : a pointer to the Ring Buffer object
    - data : a pointer to the element who needs to be added to the ring-buffer
  
Return value:

    qTrue on succesful add, qFalse if not added
*/
qBool_t qRBufferPush(qRBuffer_t *obj, void *data){
    qBool_t status = qFalse;
    uint8_t *data_element = (uint8_t*)data;
    volatile uint8_t *ring_data = NULL;
    uint16_t i;

    if(NULL==obj) return qFalse;
    if(data_element){
        if(!_qRBufferFull(obj)){ /*Limit the amount of elements to accpet*/
            ring_data = obj->data + ((obj->head % obj->Elementcount) * obj->ElementSize);
            for (i = 0; i < obj->ElementSize; i++) ring_data[i] = data_element[i];            
            obj->head++;
            status = qTrue;
        }
    }
    return status;    
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
    for(lo=0, hi=n-1; hi>lo; lo++, hi--){
        tmp=p[lo];
        p[lo] = p[hi];
        p[hi] = tmp;
    }
}
/*============================================================================*/
/*qBool_t qCheckEndianness(void)
 
Check the system endianess
  
Return value:

    qTrue if Little-Endian, otherwise returns qFalse
*/
qBool_t qCheckEndianness(void){
    uint16_t i = 1;
    return (qBool_t)( *( (uint8_t*)&i ) );
}
/*============================================================================*/
/*void qOutputRaw(qPutChar_t fcn, void* storagep, void *data, size_t n, qBool_t AIP)
 
Wrapper method to write n RAW data througth fcn
  
Parameters:

    - fcn : The basic output byte function
    - storagep : The storage pointer passed to fcn
    - data: Buffer to read data from
    - n: The size of "data"
    - AIP : Auto-Increment the storage-pointer
*/
void qOutputRaw(qPutChar_t fcn, void* storagep, void *data, qSize_t n, qBool_t AIP){
    size_t i = 0;
    char *cdata = data;
    for(i=0;i<n;i++) fcn( ((AIP)? (char*)storagep+i : storagep), cdata[i]);
}
/*============================================================================*/
/*void qInputRaw(qGetChar_t fcn, void* storagep, void *data, size_t n, qBool_t AIP)

Wrapper method to get n RAW data througth fcn
  
Parameters:

    - fcn : The basic input byte function
    - storagep : The storage pointer passed to fcn
    - data: Buffer to read data from
    - n: Number of bytes to get
    - AIP : Auto-Increment the storage-pointer
*/
void qInputRaw(qGetChar_t fcn, void* storagep, void *data, qSize_t n, qBool_t AIP){
    size_t i = 0;
    char *cdata = data;
    for(i=0;i<n;i++) cdata[i] = fcn( ((AIP)? (char*)storagep+i : storagep));
}
/*============================================================================*/
/*void qOutputString(qPutChar_t fcn, const char *s, qBool_t AIP)
 
Wrapper method to write a string througth fcn
  
Parameters:

    - fcn : The basic output byte function
    - storagep : The storage pointer passed to fcn
    - s: The string to be written
    - AIP : Auto-Increment the storage-pointer
*/
void qOutputString(qPutChar_t fcn, void* storagep, const char *s, qBool_t AIP){
    size_t i = 0;
    while(*s)  fcn(((AIP)? (char*)storagep+(i++): storagep), *s++);
}
/*============================================================================*/
static char qNibbletoX(uint8_t value){
    char ch;
    ch = (char)(value & 0x0F) + '0';
    return (char) ((ch > '9') ? ch + 7u : ch);
}
/*============================================================================*/
void qPrintXData(qPutChar_t fcn, void* storagep, void *data, qSize_t n){
    uint8_t *pdat =(uint8_t*)data; 
    int i;
    for(i=0;i<n;i++, fcn(storagep, ' ')){
        fcn(storagep, qNibbletoX( qByteHighNibble(pdat[i]) ) );
        fcn(storagep, qNibbletoX( qByteLowNibble(pdat[i]) ) );
    }
    fcn(storagep, '\r' );
    fcn(storagep, '\n' );
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
    int i;
    str[n]='\0';
    for(i=n-1; i>=0; value>>=4, i--) str[i] = qNibbletoX((uint8_t)value);
    return str;
}
/*============================================================================*/
/*uint32_t qXtoU32(const char *s)
  
Converts the input string s consisting of hexadecimal digits into an unsigned 
integer value. The input parameter s should consist exclusively of hexadecimal 
digits, with optional whitespaces. The string will be processed one character at
a time, until the function reaches a character which it doesn’t recognize 
(including a null character).
  
Parameters:

    - s : The hex string to be converted

Return value:

  The numeric value uint32_t
*/
uint32_t qXtoU32(const char *s) {
    uint32_t val = 0;
    uint8_t byte;
    uint8_t nparsed = 0;
    while (*s != '\0' && nparsed<8) { /*loop ultil the end of the string or the number of parsed chars exceeds the 32bit notation*/
        byte = toupper(*s++); /*get the hex char, considerate only upper case*/
        if( isxdigit(byte) ){ /*if is a valid hex digit*/
            nparsed++; /*increase the parsed char count*/
            if (byte >= '0' && byte <= '9') byte = byte - '0'; /*make the conversion in the 0-9 range*/ 
            else if (byte >= 'A' && byte <='F') byte = byte - 'A' + 10;  /*make the conversion in the A-F range*/         
            val = (uint32_t)((val << 4u) | (byte & 0xFu));  /*add the corresponding nibble to the output*/                
        }
        else if(isspace(byte)) continue; /*discard any white-space char*/
        else break;  /*not valid chars break the conversion*/       
    }
    return val;
}
/*============================================================================*/
/* double qAtoF(const char *s)
Parses the C string s, interpreting its content as a floating point number and 
returns its value as a double. The function first discards as many whitespace 
characters (as in isspace) as necessary until the first non-whitespace character
is found. Then, starting from this character, takes as many characters as possible 
that are valid following a syntax resembling that of floating point literals 
(see below), and interprets them as a numerical value. The rest of the string after 
the last valid character is ignored and has no effect on the behavior of this function.
 
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
    int i, sign;
    double value, power;
    #ifdef QATOF_FULL
        int powersign; 
        double power2;
    #endif    
    for(i = 0; isspace(s[i]); ++i); /*discard whitespaces*/
    sign = ('-' == s[i])? -1 : 1; /*set the sign*/
    if('-' == s[i] || '+' == s[i]) ++i; /*discards any other sign chars*/
  
    for(value = 0.0; isdigit(s[i]); ++i) value = value * 10.0 + (s[i] - '0');  /*compute the integer part until a non-digit char is found*/
    if('.' == s[i] ) ++i; /*if the next char is a dot, move to the next char to process the floating point*/
    for(power = 1.0; isdigit(s[i]); ++i, power *= 10.0)    value = value * 10.0 + (s[i] - '0'); /*loop until a non-digit char is found*/
    #ifdef SATOF_FULL /*handle the sci-notation*/
        if('e'  == s[i] || 'E' == s[i]) ++i; /*if sci notation char is found, move to the next char and process it*/
        else return sign * value/power;

        powersign = ('-' == s[i])? -1 : 1;
        if('-' == s[i] || '+' == s[i]) ++i;

        for(power2 = 0; isdigit(s[i]); ++i)  power2 = power2 * 10 + (s[i] - '0');

        if(-1 == powersign ){
            while(0 != power2){
                power *= 10;
                --power2;
            }
        }
        else{
            while(0 != power2 ){
                power /= 10;
                --power2;
            }
        }
        return sign * value/power;
    #else
        return sign * value/power; 
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

    for (; isspace(*s); ++s); /*discard whitespaces*/

    if ('-' == *s){ /*if negative found*/
        sgn = -1; /*set the sign*/
        ++s; /*move to next*/
    } 
    else if ('+' == *s) ++s; /*plus sign ignored, move to next*/
   
    for (; *s != 0; ++s){ /*iterate until null char is found*/
        if (*s < '0' || *s > '9')  return sgn * res; /*if the char is not a digit, return the computed integer with sign*/
        res = res * 10 + *s - '0'; /*if the char is digit, compute the resulting integer*/
    }
    return sgn * res; /*return the computed integer with sign*/
}
/*============================================================================*/
/*this method makes the basic conversion of unsigned integer to ascii
NULL Terminator not included
*/
static uint8_t __q_revuta(uint32_t num, char* str, uint8_t base){
    uint8_t i = 0;
    int rem;
    if (0 == num){ /* Handle 0 explicitely, otherwise empty string is printed for 0 */
        str[i++] = '0';        
        return i;
    }

    while (0 != num){ /*Process individual digits*/
        rem = num % base;
        str[i++] = (rem > 9)? (char)(rem-10) + 'A' : (char)rem + '0';
        num = num/base;
    }
    qSwapBytes(str, (qSize_t)i);/*Reverse the string*/
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
    uint8_t i = 0;
    if(NULL == str) return str;
    i = __q_revuta(num, str, base); /*make the unsigned conversion without the null terminator*/
    str[i] = '\0'; /*add the null terminator*/
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
    uint8_t i = 0;
    if(NULL == str) return str;
    if( num < 0 ){ 
        if(10 == base){ /*handle negative numbers only with 10-base*/
            str[i++]='-';/*put the sign at the begining*/
        } 
        num = -num;
    }
    i += __q_revuta((uint32_t)num, str+i, base); /*make the unsigned conversion without the null terminator*/   
    str[i] = '\0'; /*Append string terminator*/
    return str;
}
/*============================================================================*/
/* char* qBtoA(qBool_t num, char *str)

Converts a boolean value to a null-terminated string. Input is considered true
with any value diferent to zero (0).

str should be an array long enough to contain the output

Parameters:

    - num : Value to be converted to a string.
    - str : Array in memory where to store the resulting null-terminated string.

Return value:

  A pointer to the resulting null-terminated string, same as parameter str
*/
char* qBtoA(qBool_t num, char *str){
    if(NULL == str) return str;
    if(num){
        str[0]='t'; str[1]='r'; str[2]='u'; str[3]='e'; str[4]='\0';
    }
    else{
        str[0]='f'; str[1]='a'; str[2]='l'; str[3]='s'; str[4]='e'; str[5]='\0';  
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
qBool_t qIsNan(float f){
    uint32_t u;
    void *p;
    p = &f;
    u = *(uint32_t*)p;
    /*u = *(uint32_t*)&f;*/ /*warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]*/
    return (qBool_t)((qBool_t) ((u & 0x7F800000) == 0x7F800000 && (u & 0x7FFFFF)));
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
    /*u = *(uint32_t*)&f;*/ /*warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]*/
    if(0x7f800000ul == u ) return qTrue;
    if(0xff800000ul == u ) return qTrue;
    return qFalse;
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
    uint8_t i = 0;
    uint32_t intPart;
    if(NULL == str) return str;
    if(0.0f == num){ /*handle the 0.0f*/
        _qsetfstringto_0(str);      
        return str;
    }
    if((c = qIsInf(num))){ /*handle the infinity*/
        str[0]=(c==1)?'+':'-';
        _qsetfstringto_inf(str);
        return str;        
    }
    if(qIsNan(num)){ /*handle the NAN*/
        _qsetfstringto_nan(str);
        return str;
    }
    
    if(precision > Q_MAX_FTOA_PRECISION) precision = Q_MAX_FTOA_PRECISION; /*clip the precision*/
    
    if(num < 0){ /*handle the negative numbers*/
        num = -num; /*leave it positive for the __q_revuta method*/
        str[i++] = '-'; /*add the negative sign*/
    }
    
    intPart = (uint32_t)num; /*get the integer parts*/
    num -= intPart; /*get the floating-point part substracting the integer part from the original value*/
    i += __q_revuta(intPart, str+i, 10); /*convert the integer part in decimal form*/
    if (precision){ /*decimal part*/
        str[i++] = '.'; /*place decimal point*/
        while (precision--){ /*convert until precision reached*/
            num *= 10.0;  /*start moving the floating-point part one by one multipliying by 10*/
            c = (char)num; /*get the bcd byte*/
            str[i++] = c + '0'; /*convert to ascii and put it inside the buffer*/
            num -= c; /*substract the procesed floating-point digit*/
        }
    }
    str[i] = '\0'; /*put the null char*/
    return str;
}
#ifdef Q_ISR_BUFFERS 
/*============================================================================*/
qBool_t qISR_ByteBufferInit(qISR_ByteBuffer_t *obj, qISR_Byte_t *pData, qSize_t size, const char EndChar, qBool_t (*AcceptCheck)(const char), char (*PreChar)(const char)){
    if(NULL == pData || size<2) return qFalse;
    obj->AcceptCheck = AcceptCheck;
    obj->PreChar = PreChar;
    obj->EndByte = EndChar;
    obj->MaxIndex = (uint16_t)(size - 1);
    obj->pdata = pData;
    obj->index = 0;
    return qTrue;
}
/*============================================================================*/
qBool_t qISR_ByteBufferFill(qISR_ByteBuffer_t *obj, const char newChar){
    if (!obj->ReadyFlag ){
        if(obj->AcceptCheck){
            if(!obj->AcceptCheck(newChar)) return qFalse;
        }
        obj->pdata[obj->index++] = (qISR_Byte_t)((obj->PreChar)? obj->PreChar(newChar) : newChar);
        obj->pdata[obj->index] = 0x0u;
        if (obj->index>=(obj->MaxIndex)) obj->index = 0;
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
    if(obj->ReadyFlag){
        memcpy(dest, (void*)obj->pdata, obj->index);
        obj->ReadyFlag = qFalse;
        return qTrue;
    }
    return qFalse;
}
#endif
#ifdef Q_BYTE_SIZED_BUFFERS
/*============================================================================*/
/*size_t qBSBuffer_Count(qBSBuffer_t const* obj)
 
Query the number of elements in the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    Number of elements in the BSBuffer(Byte-sized Buffer)
*/
qSize_t qBSBuffer_Count(qBSBuffer_t const* obj){
    return (qSize_t)(obj ? (obj->head - obj->tail) : 0);
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
    return (qBool_t)(obj ? (qBool_t)(qBSBuffer_Count(obj) == obj->length) : qTrue);
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
    return (qBool_t)(obj ? (qBool_t)(0 == qBSBuffer_Count(obj)) : qTrue);
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
    return (uint8_t)(obj ? (qBool_t)(obj->buffer[obj->tail % obj->length]) : 0x0u);
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
    if (!qBSBuffer_Empty(obj)) {
        *dest = obj->buffer[obj->tail % obj->length];
        obj->tail++;
        return qTrue;
    }
    return qFalse;
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
    if(n<=0) return qFalse;
    for(i=0;i<n;i++){
        if (!qBSBuffer_Get(obj, data+i)) return qFalse;
    }
    return qTrue;
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
    if(obj){ 
        if(!qBSBuffer_IsFull(obj)) {/* limit the ring to prevent overwriting */
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
    if(obj){
        obj->head = 0;
        obj->tail = 0;
        obj->buffer = buffer;
        #ifdef Q_RINGBUFFERS
            obj->length = _qRBufferValidPowerOfTwo(length);
        #else
            obj->length = length;
        #endif      
    }
}
#endif

/*============================================================================*/
/*void qResponseInitialize(qResponseHandler_t *obj)

Initialize the Response Handler

Parameters:

    - obj : A pointer to the Response Handler object
  
*/
void qResponseInitialize(qResponseHandler_t *obj){
    obj->ptr2Match = NULL;
    obj->length2Match = 0;
    obj->contMatch = 0;
    obj->Flag = qFalse;
}   
/*============================================================================*/
/*qBool_t qResponseReceived(qResponseHandler_t *obj, const char *ptr, qSize_t n)
 
Non-Blocking Response check

Parameters:

    - obj : A pointer to the Response Handler object
    - ptr: The data checked in the receiver ISR
    - n : The length of the data pointer by ptr
  
Return value:

    qTrue if there is a response acknowledge, otherwise returns qFalse
*/
qBool_t qResponseReceived(qResponseHandler_t *obj, const char *ptr, qSize_t n){
    if(qFalse == obj->Flag && NULL == obj->ptr2Match){ /*handler no configured yet*/
        obj->length2Match = n; /*set the number of chars to match*/
        obj->contMatch = 0; /*reinitialize the chars match count*/
        obj->Flag = qFalse; /*clear the ready flag*/
        obj->ptr2Match = (char*)ptr; /*set the expected response*/
        return qFalse; 
    }
    if(obj->Flag){ /*if response received from ISR match the expected*/
        qResponseInitialize(obj); /*re-initialize the response handler*/
        return qTrue; /*let it know to the caller that expected response was received*/
    } 
    else return qFalse;
}
/*============================================================================*/
/*qBool_t qResponseISRHandler(qResponseHandler_t *obj, const char rxchar)

ISR receiver handler for the response for "qResponseReceived"

Parameters:

    - obj : A pointer to the Response Handler object
    - rxchar: The byte-data from the receiver 

Return value:

    qTrue when the Response handler match the request from "qResponseReceived"
*/
qBool_t qResponseISRHandler(qResponseHandler_t *obj, const char rxchar){
    if(qTrue == obj->Flag || NULL == obj->ptr2Match) return qFalse; /*wait until the qResponseReceived release the flag*/
    
    if(obj->ptr2Match[obj->contMatch] == rxchar){ /*if the received char match with the expected*/
        obj->contMatch++; /*move to the next char in the expected buffer*/
        if(obj->contMatch == obj->length2Match)  obj->Flag = qTrue; /*if all the requested chars match, set the ready flag */
    }
    return obj->Flag; /*return the ready flag*/
}
/*============================================================================*/
#ifdef Q_TRACE_VARIABLES
void __qtrace_func(const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, qSize_t BlockSize){
    if(NULL !=__qDebugOutputFcn){ /*trace only if the output-function is defined*/
        qPrintString(__qDebugOutputFcn, NULL, loc); /*print out the line location*/
        if(fcn){ /*print out the function if available*/
            __qDebugOutputFcn(NULL, '@');
            qPrintString(__qDebugOutputFcn, NULL, fcn); 
            __qDebugOutputFcn(NULL, ' ');
        }
        qPrintString(__qDebugOutputFcn, NULL, varname);
        if(NULL == varvalue){ /*if the varvalue is not defined, the call must correspond to memory tracing*/
            qPrintXData(__qDebugOutputFcn, NULL, Pointer, BlockSize); /*print out the memory in hex format*/
        }
        else{ /*print out the variable value*/
            qPrintString(__qDebugOutputFcn, NULL, varvalue);
            __qDebugOutputFcn(NULL, '\r');
            __qDebugOutputFcn(NULL, '\n');
        }       
    }      
}
/*============================================================================*/
#endif
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