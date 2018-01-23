/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Task Scheduler for low-range MCUs
 *  Version : 4.5.0
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

#include <ctype.h>

#include "QuarkTS.h"

#ifdef __XC8
    #pragma warning push
    #pragma warning disable 1471   /*disable warning: (1471) indirect function call via a NULL pointer ignored*/
    #pragma warning disable 1498   /*disable warning: (1498) pointer (x@y) in expression may have no targets*/
    #pragma warning disable 520    /*disable warning: (520) function "x" is never called*/
    #pragma warning disable 759    /*disable warning: (759) expression generates no code*/
    #pragma warning disable 751    /*disable warning: (751) arithmetic overflow in constant expression*/
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
static qSize_t _qRBufferValidPowerOfTwo(qSize_t k);
static qSize_t _qRBufferCount(qRBuffer_t *obj);
static qBool_t _qRBufferFull(qRBuffer_t *obj);
static qTrigger_t _qCheckRBufferEvents(qTask_t *Task);


#define _qabs(x)    (((x<0) && (x!=qPeriodic))? -x : x) 
/*========================== QuarkTS Private Macros ==========================*/
#define qEnterCritical()                        if(QUARKTS.I_Disable != NULL) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable()
#define qExitCritical()                         if(QUARKTS.I_Restorer != NULL) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags)

#define __qChainInitializer     ((qTask_t*)-1)
#define __qFSMCallbackMode      ((qTaskFcn_t)1)
#define _qTaskDeadlineReached(_TASK_)            ( _TASK_->Interval == qTimeInmediate || ((_qSysTick_Epochs_ - _TASK_->ClockStart)>=_TASK_->Interval)  )
#define _qTaskHasPendingIterations(_TASK_)       (_qabs(_TASK_->Iterations)>0 || _TASK_->Iterations==qPeriodic)
#define _qEvent_FillCommonFields(_eVar_, _Trigger_, _FirstCall_, _TaskData_)    _eVar_.Trigger = _Trigger_; _eVar_.FirstCall = _FirstCall_; _eVar_.TaskData = _TaskData_ 

#define qSchedulerStartPoint                    QUARKTS.Flag.Init=qTrue; do
#define qSchedulerEndPoint                      while(!QUARKTS.Flag.ReleaseSched); _qTriggerReleaseSchedEvent()
/*============================================================================*/
/*
qTask_t* qTaskSelf(void)

Get current running task handle.

Return value:

    A pointer to the current running task.
    NULL when the scheduler it's in a busy state or when IDLE Task is running.
*/
qTask_t* qTaskSelf(void){
    return QUARKTS.CurrentRunningTask;
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
qBool_t qTaskIsEnabled(qTask_t *Task){
    if(Task==NULL) return qFalse;
    return (qBool_t)Task->Flag.Enabled;
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
uint32_t qTaskGetCycles(qTask_t *Task){
    if (Task==NULL) return 0ul;
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
    if(Task==NULL) return;
    Task->Flag.AsyncRun = qTrue;
    Task->AsyncData = eventdata;
}
/*============================================================================*/
/*void qTaskSetTime(qTask_t *Task, qTime_t Value)

Set/Change the Task execution interval

Parameters:

    - Task : A pointer to the task node.

    - Value : Execution interval defined in seconds (floating-point format). 
              For inmediate execution (tValue = TIME_INMEDIATE).
*/
void qTaskSetTime(qTask_t *Task, qTime_t Value){
    if(Task==NULL) return;
    Task->Interval = (qClock_t)(Value/QUARKTS.Tick);
}
/*============================================================================*/
/*void qTaskSetIterations(qTask_t *Task, qIteration_t Value)

Set/Change the number of task iterations

Parameters:

    - Task : A pointer to the task node.

    - Value : Number of task executions (Integer value). For indefinite 
              execution (iValue = PERIODIC or INDEFINITE). Tasks do not remember
              the number of iteration set initially. After the iterations are 
              done, internal iteration counter is 0. If you need to perform
              another set of iterations, you need to set the number of 
              iterations again and resume.
*/
void qTaskSetIterations(qTask_t *Task, qIteration_t Value){
    if(Task==NULL) return;
    Task->Iterations = (Value==qPeriodic)? qPeriodic : -Value;  
}
/*============================================================================*/
/*void qTaskSetPriority(qTask_t *Task, qPriority_t Value)

Set/Change the task priority value

Parameters:

    - Task : A pointer to the task node.

    - Value : Priority Value. [0(min) - 255(max)]
*/
void qTaskSetPriority(qTask_t *Task, qPriority_t Value){
    if(Task==NULL) return;
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
    if(Task==NULL) return;
    Task->Callback = CallbackFcn;
}
/*============================================================================*/
/*void qTaskSetState(qTask_t *Task, qState_t State)

Set the task state (Enabled or Disabled)

Parameters:

    - Task : A pointer to the task node.
    - State : qEnabled or qDisabled 
*/
void qTaskSetState(qTask_t *Task, qState_t State){
    if(Task==NULL) return;
    if(State && Task->Flag.Enabled) return;
    Task->Flag.Enabled = State;
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
    if(Task==NULL) return;
    Task->TaskData = arg;
}
/*============================================================================*/
/*void qTaskClearTimeElapsed(qTask_t *Task)

Clear the elapsed time of the task. Restart the internal task tick;

Parameters:

    - Task : A pointer to the task node.
*/
void qTaskClearTimeElapsed(qTask_t *Task){
    if(Task==NULL) return;
    Task->ClockStart = _qSysTick_Epochs_;
}
/*============================================================================*/
/*qBool_t qTaskQueueEvent(qTask_t *Task, void* eventdata)

Insert an asyncrohous event in the FIFO priority queue. The task will be ready 
for execution according to the queue extraction (determined by priority), even 
if task is disabled (More info here). When extracted, the scheduler will set 
Trigger flag to "byQueueExtraction". Specific user-data can be passed through, 
and will be available inside the EventData field, only in corresponding launch.

Parameters:

    - Task : A pointer to the task node.

    - eventdata - Specific event user-data.

Return value:

    Returns qTrue if the event has been inserted in the queue, or qFalse if an error 
    occurred (The queue exceeds the size).
*/
qBool_t qTaskQueueEvent(qTask_t *Task, void* eventdata){
    if((Task==NULL) || (QUARKTS.QueueIndex>=QUARKTS.QueueSize-1) ) return qFalse;
    qQueueStack_t qtmp;
    qtmp.Task = Task,
    qtmp.QueueData = eventdata;
    QUARKTS.QueueStack[++QUARKTS.QueueIndex] = qtmp;
    return qTrue;
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
/*============================================================================*/
static qTask_t* _qScheduler_PriorityQueueGet(void){
    qTask_t *Task = NULL;
    uint8_t i;
    uint8_t IndexTaskToExtract = 0;
    if(QUARKTS.QueueIndex < 0) return NULL;
    qEnterCritical();
    qPriority_t MaxpValue = QUARKTS.QueueStack[0].Task->Priority;
    for(i=1;i<QUARKTS.QueueSize;i++){
        if(QUARKTS.QueueStack[i].Task == NULL) break;
        if(QUARKTS.QueueStack[i].Task->Priority > MaxpValue){
            MaxpValue = QUARKTS.QueueStack[i].Task->Priority;
            IndexTaskToExtract = i;
        }
    }   
    QUARKTS.QueueData = QUARKTS.QueueStack[IndexTaskToExtract].QueueData;
    Task = QUARKTS.QueueStack[IndexTaskToExtract].Task;
    Task->State = qReady;
    QUARKTS.QueueStack[IndexTaskToExtract].Task = NULL;  
    for(i=IndexTaskToExtract; i<QUARKTS.QueueIndex; i++) QUARKTS.QueueStack[i] = QUARKTS.QueueStack[i+1];    
    QUARKTS.QueueIndex--;    
    qExitCritical();
    return Task;
}
/*============================================================================*/
void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack){
    uint8_t i;
    QUARKTS.Head = NULL;
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.ReleaseSchedCallback = NULL;
    QUARKTS.QueueStack = Q_Stack;
    QUARKTS.QueueSize = Size_Q_Stack;
    for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = NULL;    
    QUARKTS.QueueIndex = -1;    
    QUARKTS.Flag.Init = qFalse;
    QUARKTS.Flag.ReleaseSched = qFalse;
    QUARKTS.Flag.FCallReleased = qFalse;
    QUARKTS.I_Restorer =  NULL;
    QUARKTS.I_Disable = NULL;
    QUARKTS.CurrentRunningTask = NULL;
    QUARKTS.QueueData = NULL;
    _qSysTick_Epochs_ = 0ul;
}
/*============================================================================*/
/*qBool_t qSchedulerAddxTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg)

Add a task to the scheduling scheme. The task is scheduled to run every <Time> 
seconds, <nExecutions> times and executing <CallbackFcb> method on every pass.

Parameters:
    - Task : A pointer to the task node.

    - CallbackFcn : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.

    - Priority : Task priority Value. [0(min) - 255(max)]

    - Time : Execution interval defined in seconds (floating-point format). 
               For inmediate execution (tValue = TIME_INMEDIATE).

    - nExecutions : Number of task executions (Integer value). For indefinite 
               execution (nExecutions = PERIODIC or INDEFINITE). Tasks do not 
               remember the number of iteration set initially. After the 
               iterations are done, internal iteration counter is 0. If you 
               need to perform another set of iterations, you need to set the 
               number of iterations again.
    >Note 1: Tasks which performed all their iterations put their own 
             state to DISABLED.
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
    if(Task==NULL) return qFalse;
    if (((Time/2)<QUARKTS.Tick && Time) || CallbackFcn == NULL) return qFalse;
    qSchedulerRemoveTask(Task); /*Remove the task if was previously added to the chain*/
    Task->Callback = CallbackFcn;
    Task->Interval = (qClock_t)(Time/QUARKTS.Tick);
    Task->TaskData = arg;
    Task->Priority = Priority;
    Task->Iterations = (nExecutions==qPeriodic)? qPeriodic : -nExecutions;    
    Task->Flag.AsyncRun = Task->Flag.InitFlag =  Task->Flag.RBAutoPop = Task->Flag.RBCount = Task->Flag.RBCount = Task->Flag.RBEmpty = qFalse ;
    Task->Flag.Enabled = (qBool_t)(InitialState != qFalse);
    Task->Next = NULL;  
    Task->Cycles = 0;
    Task->ClockStart = _qSysTick_Epochs_;
    Task->RingBuff = NULL;
    Task->StateMachine = NULL;
    Task->State = qSuspended;
    _qScheduler_PriorizedInsert((qTask_t**)&QUARKTS.Head, Task);
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
The task is scheduled to run every <Time> seconds in PERIODIC mode. The event info
will be available as a generic pointer inside the <Data> field of the qSM_t pointer
passed as input argument inside every state.

Parameters:
    - Task : A pointer to the task node.

    - Priority : Task priority Value. [0(min) - 255(max)]

    - Time : Execution interval defined in seconds (floating-point format). 
               For inmediate execution (tValue = TIME_INMEDIATE).

    - StateMachine: A pointer to Finite State-Machine (FSM) object
  
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
                            qSM_t *StateMachine, qSM_State_t InitState, qSM_ExState_t BeforeAnyState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg){
    if(StateMachine==NULL || InitState == NULL) return qFalse;
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
    if(tmp == NULL) return qFalse;
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
    if( (*head == NULL) || (Task->Priority>(*head)->Priority) ){ /*is the first task in the scheme or the task has the highest priority over all */
        Task->Next = *head; /*move the head and just add the task node on top*/
        *head = Task; /*this task will be the new head*/
        return;
    }
    tmp_node = *head; 
    while(tmp_node->Next && (Task->Priority<=tmp_node->Next->Priority) )  tmp_node = tmp_node->Next; /*find the righ place for this task acoording its priority*/
    Task->Next = tmp_node->Next; /*the the new task  will be placed just after tmp*/
    tmp_node->Next = Task;
}
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
    *head = new_head;
    QUARKTS.Flag.Init= qTrue; /*set the initializtion flag*/
    qExitCritical();
}
/*============================================================================*/
/*qBool_t qTaskLinkRBuffer(qTask_t *Task, qRBuffer_t *RingBuffer, qRBLinkMode_t Mode, uint8_t arg)

Links the Task with a Ring Buffer. 

Parameters:

    - Task : A pointer to the task node.

    - RingBuffer : A pointer to a Ring Buffer object
 
    - Mode: Linking mode. This implies the event that will trigger the task according
            to one of the following modes:
                        > RB_AUTOPOP: The task will be triggered if there is elements 
                          in the Ring Buffer. Data data will be popped
                          automatically in every trigger and will be available 
                          in the <EventData> field of qEvent_t structure.
     
                        > RB_FULL: the task will be triggered if the Ring Buffer
                          is full. The pointer to the RingBuffer will be 
                          available in the <EventData> field of qEvent_t structure.

                        > RB_COUNT: the task will be triggered if the count of 
                          elements in the Ring Buffer reach the specified value. 
                          The pointer to the RingBuffer will be available in the
                          <EventData> field of qEvent_t structure.

                        > RB_EMPTY: the task will be triggered if the Ring Buffer
                          is empty. The pointer to the RingBuffer will be 
                          available in the <EventData> field of qEvent_t structure.
 
    - arg: This argument defines if the Ring buffer will be linked (qLINK) or 
           unlinked (qUNLINK) from the task.
           If the RB_COUNT mode is specified, this value will be used to check
           the element count of the Ring Buffer. A zero value will act as 
           an unlink action. 

Return value:

    Returns qTrue on successs, otherwise returns qFalse;     
*/
qBool_t qTaskLinkRBuffer(qTask_t *Task, qRBuffer_t *RingBuffer, qRBLinkMode_t Mode, uint8_t arg){
    if(RingBuffer == NULL || Task==NULL || Mode<qRB_AUTOPOP || Mode>qRB_EMPTY) return qFalse;
    if(RingBuffer->data == NULL) return qFalse;    
    Task->Flag.FlagatIndex[Mode] = (qBool_t)((Mode==qRB_COUNT)? arg : (arg!=qFalse));
    Task->RingBuff = (arg>0)? RingBuffer : NULL;
    return qTrue;
}
/*============================================================================*/
static qTrigger_t _qCheckRBufferEvents(qTask_t *Task){
    if(Task==NULL) return qTriggerNULL;
    if(Task->RingBuff == NULL) return qTriggerNULL;
    if(Task->Flag.RBFull)       if(_qRBufferFull(Task->RingBuff))                           return byRBufferFull;           
    if(Task->Flag.RBCount>0)    if(_qRBufferCount(Task->RingBuff) >= Task->Flag.RBCount )   return byRBufferCount;            
    if(Task->Flag.RBAutoPop)    if(qRBufferGetFront(Task->RingBuff)!=NULL)                  return byRBufferPop;   
    if(Task->Flag.RBEmpty)      if(qRBufferEmpty(Task->RingBuff))                           return byRBufferEmpty;       
    return qTriggerNULL;
}
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
        if(!QUARKTS.Flag.Init) _qScheduler_RearrangeChain((qTask_t**)&QUARKTS.Head); /*if initial scheduling conditions changed, sort the chain by priority (init flag internally set)*/        
        if((Task = _qScheduler_PriorityQueueGet()))  Task->State = _qScheduler_Dispatch(Task, byQueueExtraction);  /*Available queueded task will be dispatched in every scheduling cycle*/                        
        if(_qScheduler_ReadyTasksAvailable()){  /*Check if all the tasks from the chain fulfill the conditions to get the qReady state, if at least one gained it,  enter here*/
            while((Task = _qScheduler_GetNodeFromChain())) /*Get node by node from the chain until no more available*/
                Task->State = (Task->State == qReady)? _qScheduler_Dispatch(Task, Task->Trigger) : qWaiting;  /*Dispatch the task if is qReady, otherwise put it in a qWaiting State*/
        }
        else if(Task==NULL && QUARKTS.IDLECallback) _qScheduler_Dispatch(NULL, byNoReadyTasks); /*no tasks are available for execution, run the idle task*/
    }qSchedulerEndPoint; /*scheduling end-point (also check for scheduling-release request)*/
}
/*============================================================================*/
static qTask_t* _qScheduler_GetNodeFromChain(void){ 
    static qTask_t *ChainIterator = __qChainInitializer; /*used to keep on track the current chain position*/
    qTask_t *Node;  /*used the hold the node*/
    if(ChainIterator == __qChainInitializer) ChainIterator = QUARKTS.Head; /*First call, start from the head*/
    Node = ChainIterator; /*obtain the current node from the chain*/
    ChainIterator = (ChainIterator)? ChainIterator->Next : QUARKTS.Head; /*Tail reached, reset the iterator to the head*/
    return Node; /*return the task node at current chain position*/
}
/*============================================================================*/
static qTaskState_t _qScheduler_Dispatch(qTask_t *Task, qTrigger_t Event){
    switch(Event){ /*take the necessary actions before dispatching depending on the event that triggered the task*/
        case byTimeElapsed:
            Task->Iterations = (QUARKTS.EventInfo.FirstIteration = (qBool_t)((Task->Iterations!=qPeriodic) && (Task->Iterations<0)))? -Task->Iterations : Task->Iterations;
            if(Task->Iterations!= qPeriodic) Task->Iterations--; /*Decrease the iteration value*/
            if((QUARKTS.EventInfo.LastIteration = (qBool_t)(Task->Iterations == 0))) Task->Flag.Enabled = qFalse; /*When the iteration value is reached, the task will be disabled*/            
            break;
        case byAsyncEvent:
            QUARKTS.EventInfo.EventData = Task->AsyncData; /*Transfer async data to the eventinfo structure*/
            Task->Flag.AsyncRun = qFalse; /*Clear the async flag*/            
            break;
        case  byRBufferPop:
            QUARKTS.EventInfo.EventData = qRBufferGetFront(Task->RingBuff); /*the EventData will point to the front data of the RBuffer*/
            break;
        case byRBufferFull: case byRBufferCount: case byRBufferEmpty:
            QUARKTS.EventInfo.EventData = (void*)Task->RingBuff;  /*the EventData will point to the the linked RingBuffer*/
            break;
        case byQueueExtraction:
            QUARKTS.EventInfo.EventData = QUARKTS.QueueData;
            QUARKTS.QueueData = NULL;
        case byNoReadyTasks:
            QUARKTS.EventInfo.FirstCall = (qBool_t)(!QUARKTS.Flag.FCallIdle);
            QUARKTS.EventInfo.Trigger = Event;
            QUARKTS.EventInfo.TaskData = NULL;
            QUARKTS.IDLECallback((qEvent_t)&QUARKTS.EventInfo); /*run the idle callback*/
            QUARKTS.Flag.FCallIdle = qTrue;      
            return qSuspended; /*No more thing to do*/
        default: break;
    }
    Task->State = qRunning; 
    /*Fill the event info structure*/
    _qEvent_FillCommonFields(QUARKTS.EventInfo, Event, (qBool_t)(!Task->Flag.InitFlag), Task->TaskData); /*Fill commond field of EventInfo: Trigger, FirstCall and TaskData*/ 
    QUARKTS.CurrentRunningTask = Task; /*needed for qTaskSelf()*/
    if (Task->StateMachine != NULL && Task->Callback==__qFSMCallbackMode) qStateMachine_Run(Task->StateMachine, (void*)&QUARKTS.EventInfo);  /*If the task has a FSM attached, just run it*/  
    else if (Task->Callback != NULL) Task->Callback((qEvent_t)&QUARKTS.EventInfo); /*else, just launch the callback function*/        
    QUARKTS.CurrentRunningTask = NULL;
    if(Event==byRBufferPop) Task->RingBuff->tail++;  /*remove the data from the RBuffer, if the event wask byRBufferPop*/
    Task->Flag.InitFlag = qTrue; /*clear the init flag*/
    
    QUARKTS.EventInfo.FirstIteration = QUARKTS.EventInfo.LastIteration =  qFalse;;
    QUARKTS.EventInfo.EventData = NULL; /*clear the eventdata*/
    
    Task->Cycles++; /*increase the task cycles*/
    return qSuspended;
}
/*============================================================================*/
static qBool_t _qScheduler_ReadyTasksAvailable(void){ /*this method if the tasks fullfill the conditions to get the qReady state*/
    qTask_t *Task = NULL;
    qTrigger_t trg = qTriggerNULL;
    qBool_t nTaskReady = qFalse; 
    for(Task = QUARKTS.Head; Task; Task = Task->Next){ /*loop every task in the chain*/
        if(Task->Flag.Enabled){ /*nested check for timed task, check the first requirement*/
            if(_qTaskHasPendingIterations(Task)){ /*then task should be periodic or must have pending iters*/
                if(_qTaskDeadlineReached(Task)){ /*finally, check the deadline*/
                    Task->ClockStart = _qSysTick_Epochs_; /*Restart the task time*/
                    Task->State = qReady; 
                    Task->Trigger = byTimeElapsed;
                    nTaskReady = qTrue;
                    continue;                    
                }
            } 
        }
        else if((trg=_qCheckRBufferEvents(Task)) != qTriggerNULL){ /*If the deadline has not met, check if there is a RBuffer event available*/
            Task->State = qReady;
            Task->Trigger = trg; /*If a RBuffer event exist, the flag will be available in the <trg> variable*/
            nTaskReady = qTrue;
            continue;
        }
        else if( Task->Flag.AsyncRun){   /*The last check will be if the task has an async event*/
            Task->State = qReady;
            Task->Trigger = byAsyncEvent;
            nTaskReady = qTrue;
            continue;
        }
        Task->State = qSuspended;
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
qBool_t qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState, qSM_ExState_t BeforeAnyState){
    if(obj==NULL || InitState == NULL) return qFalse;
    obj->NextState = InitState;
    obj->PreviousState = NULL;
    obj->StateFirstEntry = 0;
    obj->PreviousReturnStatus = qSM_EXIT_SUCCESS;
    obj->qPrivate.__Failure = FailureState;
    obj->qPrivate.__Success = SuccessState;
    obj->qPrivate.__Unexpected = UnexpectedState;
    obj->qPrivate.__BeforeAnyState = BeforeAnyState;
    obj->qPrivate.Prev = NULL;
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
    if(obj == NULL) return;
    qSM_State_t prev  = NULL;
    obj->Data = Data;
    if(obj->qPrivate.__BeforeAnyState != NULL) obj->qPrivate.__BeforeAnyState(obj);
    if(obj->NextState!=NULL){
        obj->StateFirstEntry = (qBool_t)(obj->qPrivate.Prev != obj->NextState);
        if(obj->StateFirstEntry) obj->PreviousState = obj->qPrivate.Prev ;
        prev = obj->NextState;
        obj->PreviousReturnStatus = obj->NextState(obj);
        obj->qPrivate.Prev = prev;
    }
    else    obj->PreviousReturnStatus = qSM_EXIT_FAILURE;
    
    switch(obj->PreviousReturnStatus){
        case qSM_EXIT_FAILURE:           
            if(obj->qPrivate.__Failure != NULL) obj->qPrivate.__Failure(obj);
            break;
        case qSM_EXIT_SUCCESS:
            if(obj->qPrivate.__Success != NULL) obj->qPrivate.__Success(obj);
            break;
        default:
            if(obj->qPrivate.__Unexpected != NULL) obj->qPrivate.__Unexpected(obj);
            break;
    }
 }
/*============================================================================*/
/*void qStateMachine_Attribute(qSM_t *obj, qFSM_Attribute_t Flag ,void *val)

Change attributes or set actions to the Finite State Machine (FSM).

Parameters:

    - obj : a pointer to the FSM object.
 
    - Flag: The attribute/action to be taken
         > qSM_RESTART : Restart the FSM
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
            obj->PreviousState = NULL;
            obj->qPrivate.Prev = NULL;
            obj->StateFirstEntry = 0;
            obj->PreviousReturnStatus = qSM_EXIT_SUCCESS;            
            return;
        case qSM_CLEAR_STATE_FIRST_ENTRY_FLAG:
            obj->PreviousState  = NULL;
            obj->qPrivate.Prev = NULL;
            return;
        case qSM_FAILURE_STATE:
            obj->qPrivate.__Failure = (qSM_ExState_t)val;
            return;
        case qSM_SUCCESS_STATE:
            obj->qPrivate.__Success = (qSM_ExState_t)val;
            return;    
        case qSM_UNEXPECTED_STATE:
            obj->qPrivate.__Unexpected = (qSM_ExState_t)val;
            return;   
        case qSM_BEFORE_ANY_STATE:
            obj->qPrivate.__BeforeAnyState = (qSM_ExState_t)val;
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
qBool_t qSTimerSet(qSTimer_t *obj, qTime_t Time){
    if(obj==NULL) return qFalse;
    if ( (Time/2.0)<QUARKTS.Tick ) return qFalse;
    obj->TV = (qClock_t)(Time/QUARKTS.Tick);
    obj->Start = _qSysTick_Epochs_;
    obj->SR = qTrue;
    return qTrue;
}
/*============================================================================*/
/*qBool_t qSTimerFreeRun(qSTimer_t *obj, qTime_t Time)

Non-Blocking STimer check with automatic arming

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
qBool_t qSTimerFreeRun(qSTimer_t *obj, qTime_t Time){
    if(obj==NULL) return qFalse;
    if(obj->SR){
        if (qSTimerExpired(obj)){
            qSTimerDisarm(obj);
            return qTrue;
        }
        else return qFalse;
    }
    qSTimerSet(obj, Time);
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
qBool_t qSTimerExpired(qSTimer_t *obj){
    if(obj==NULL) return qFalse;
    if(!obj->SR) return qFalse; 
    return (qBool_t)((_qSysTick_Epochs_ - obj->Start)>=obj->TV);
}
/*============================================================================*/
/*qTime_t qSTimerElapsed(qSTimer_t *obj)

Query the elapsed time

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    The Elapsed time specified in epochs
*/
qClock_t qSTimerElapsed(qSTimer_t *obj){
    if(obj==NULL) return 0ul;
    return (_qSysTick_Epochs_-obj->Start);
}
/*============================================================================*/
/*qClock_t qSTimerRemainingEpochs(qSTimer_t *obj)

Query the remaining epochs

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    The remaining time specified in epochs
*/
qClock_t qSTimerRemaining(qSTimer_t *obj){
    if(obj==NULL) return 0;
    qClock_t elapsed = qSTimerElapsed(obj);
    return (obj->TV <= 0 || elapsed>obj->TV)? obj->TV : obj->TV-elapsed;
}
/*============================================================================*/
/*void qSTimerDisarm(qSTimer_t *obj)

Disarms the STimer

Parameters:

    - obj : A pointer to the STimer object.  
*/
void qSTimerDisarm(qSTimer_t *obj){
    if(obj==NULL) return;
    obj->SR = qFalse;
    obj->Start = 0ul;
}
#ifdef QMEMORY_MANAGER
/*============================================================================*/
/*void* qMemoryAlloc(qMemoryPool_t *obj, uint16_t size)
 
Allocate the required memory from the specified memory heap. The allocation 
is rounded to the memory block size.
 
Parameters:

    - obj : a pointer to the memory pool object
 
    - size : amount of memory to allocate
 
Return value:

    A pointer to allocated memory or null in there is no avaible memory
 */
void* qMemoryAlloc(qMemoryPool_t *obj, qSize_t size){
    if(obj==NULL) return NULL;
    uint8_t i, j, k, c;
    uint16_t sum;		
    uint8_t *offset = obj->Blocks;			
    j = 0;	
    qEnterCritical();
    while( j < obj->NumberofBlocks ) {			
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
	j = i;	
	for(k = 1, i = j; i < obj->NumberofBlocks; k++, i++) {
            if( *(obj->BlockDescriptors+i) ) {				
                j = (uint8_t)(i + *(obj->BlockDescriptors+i));
		offset = (uint8_t*) obj->Blocks;
		offset += j * (obj->BlockSize);
		break;
            }
            sum += obj->BlockSize;
            if( sum >= size ) {
                *(obj->BlockDescriptors+j) = k;
		for(c=0;c<size;c++) offset[i] = 0x00u;/*zero-initialized memory block*/ 
                qExitCritical();
		return (void*)offset;
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
    if(obj==NULL || pmem==NULL) return;
    uint8_t i, *p;
    qEnterCritical();	
    p = (uint8_t*)obj->Blocks;
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

/*============================================================================*/
static qSize_t _qRBufferValidPowerOfTwo(qSize_t k){
    uint16_t i;
    if ( ((k-1) & k) != 0) {
        k--;
        for (i = 1; i<sizeof(uint16_t)*8; i=i*2)  k = k|k>>i;
        k = (k+1)>>1;
    }
    return k;
}
/*============================================================================*/
static qSize_t _qRBufferCount(qRBuffer_t *obj){
    return (obj ? (obj->head - obj->tail) : 0);
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
void qRBufferInit(qRBuffer_t *obj, void* DataBlock, qSize_t ElementSize, qSize_t ElementCount){
    if(obj==NULL || DataBlock==NULL) return;
    obj->head = 0;
    obj->tail = 0;
    obj->data = DataBlock;
    obj->ElementSize = ElementSize;
    obj->Elementcount = _qRBufferValidPowerOfTwo(ElementCount);
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
    return (qBool_t)(obj ? (qBool_t)(_qRBufferCount(obj) == 0) : qTrue);    
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
    if (obj==NULL) return NULL;
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
    if(obj == NULL) return qFalse;
    void *data = NULL;
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
    if(obj==NULL) return qFalse;
    qBool_t status = qFalse;
    uint8_t *data_element = (uint8_t*)data;
    volatile uint8_t *ring_data = NULL;
    uint16_t i;

    if(obj && data_element){
        if(!_qRBufferFull(obj)){
            ring_data = obj->data + ((obj->head % obj->Elementcount) * obj->ElementSize);
            for (i = 0; i < obj->ElementSize; i++) ring_data[i] = data_element[i];            
            obj->head++;
            status = qTrue;
        }
    }
    return status;    
}
/*============================================================================*/
/*void qSwapBytes(void *data, size_t n)
 
Invert the endianess for n bytes of the specified memory location
 
Parameters:

    - data : a pointer to block of data
    - n : the number of bytes to swap
*/
/*============================================================================*/
void qSwapBytes(void *data, qSize_t n){
    uint8_t *p = data;
    size_t lo, hi;
    for(lo=0, hi=n-1; hi>lo; lo++, hi--){
        char tmp=p[lo];
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
/*void qPrintRaw(qPutChar_t fcn, void* storagep, void *data, size_t n)
 
Wrapper method to write n RAW data througth fcn
  
Parameters:

    - fcn : The basic output byte function
    - storagep : The storage pointer passed to fcn
    - data: The data to be written
    - n: The size of "data"
  
*/
/*============================================================================*/
void qPrintRaw(qPutChar_t fcn, void* storagep, void *data, qSize_t n){
    size_t i = 0;
    char *cdata = data;
    for(i=0;i<n;i++) fcn(storagep, cdata[i]);
}
/*============================================================================*/
/*void qPrintString(qPutChar_t fcn, const char *s)
 
Wrapper method to write a string througth fcn
  
Parameters:

    - fcn : The basic output byte function
    - storagep : The storage pointer passed to fcn
    - s: The string to be written
*/
void qPrintString(qPutChar_t fcn, void* storagep, const char *s){
    while(*s) fcn(storagep, *s++);
}
/*============================================================================*/
qBool_t qISR_ByteBufferInit(qISR_ByteBuffer_t *obj, qISR_Byte_t *pData, qSize_t size, const char EndChar, qBool_t (*AcceptCheck)(const char), char (*PreChar)(const char)){
    if(pData == NULL || size<2) return qFalse;
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
        obj->pdata[obj->index++] = (obj->PreChar)? obj->PreChar(newChar) : newChar;
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
/*============================================================================*/
/*size_t qBSBuffer_Count(qBSBuffer_t const* obj)
 
Query the number of elements in the BSBuffer
 
Parameters:

    - obj : a pointer to the qBSBuffer object
  
Return value:

    Number of elements in the BSBuffer
*/
size_t qBSBuffer_Count(qBSBuffer_t const* obj){
    return (obj ? (obj->head - obj->tail) : 0);
}
/*============================================================================*/
/*size_t qBSBuffer_IsFull(qBSBuffer_t const* obj)
 
Query the the full status of the BSBuffer
 
Parameters:

    - obj : a pointer to the qBSBuffer object
  
Return value:

    qTrue if the BSBuffer is full, qFalse if it is not.
*/
qBool_t qBSBuffer_IsFull(qBSBuffer_t const* obj){
    return (obj ? (qBSBuffer_Count(obj) == obj->length) : qTrue);
}
/*============================================================================*/
/*size_t qBSBuffer_Empty(qBSBuffer_t const* obj)
 
Query the the empty status of the BSBuffer
 
Parameters:

    - obj : a pointer to the qBSBuffer object
  
Return value:

    qTrue if the BSBuffer is empty, qFalse if it is not.
*/
qBool_t qBSBuffer_Empty(qBSBuffer_t const *obj){
    return (obj ? (qBSBuffer_Count(obj) == 0) : qTrue);
}
/*============================================================================*/
/*size_t qBSBuffer_Peek(qBSBuffer_t const* obj)
 
Looks for one byte from the head of the BSBuffer without removing it
 
Parameters:

    - obj : a pointer to the qBSBuffer object
  
Return value:

    byte of data, or zero if nothing in the list
*/
uint8_t qBSBuffer_Peek(qBSBuffer_t const *obj){
    return (obj ? (obj->buffer[obj->tail % obj->length]) : 0);
}
/*============================================================================*/
/*size_t qBSBuffer_Get(qBSBuffer_t *obj, uint8_t *dest)
 
Gets one data-byte from the front of the BSBuffer, and removes it
 
Parameters:

    - obj : a pointer to the qBSBuffer object
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
 
Gets n data from the BSBuffer and removes them
 
Parameters:

    - obj : a pointer to the qBSBuffer object
    - dest: the location where the data will be written
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Read(qBSBuffer_t *obj, void *dest, qSize_t n){
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
 
Adds an element of data to the BSBuffer
 
Parameters:

    - obj : a pointer to the qBSBuffer object
    - data: the data to be added
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Put(qBSBuffer_t *obj, uint8_t data){
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
 
Initialize the BSBuffer
 
Parameters:

    - obj : a pointer to the qBSBuffer object
    - buffer: block of memory or array of data
    - length: The size of the buffer(Must be a power of two)
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
void qBSBuffer_Init(qBSBuffer_t *obj, volatile uint8_t *buffer, qSize_t length){
    if(obj){
        obj->head = 0;
        obj->tail = 0;
        obj->buffer = buffer;
        obj->length = _qRBufferValidPowerOfTwo(length);
    }
}
/*============================================================================*/
#ifdef Q_TASK_DEV_TEST
void qSchedulePrintChain(void){
    qTask_t *Task;
    puts("--------------------------------------------------------------------");
    puts("TaskData\tPriority\tInterval\tIterations");
    puts("--------------------------------------------------------------------");
    for(Task = QUARKTS.Head; Task != NULL; Task = Task->Next){
        printf("%s\t\t%d\t\t%d\t\t", (char*)Task->TaskData,Task->Priority, Task->Interval);
        if(Task->Iterations == qPeriodic) puts("qPeriodic");
        else printf("%d\r\n",-Task->Iterations);    
        
    }
    puts("--------------------------------------------------------------------");
}
#endif

#ifdef __XC8
    #pragma warning pop
#endif