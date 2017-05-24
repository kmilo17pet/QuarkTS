/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Task Scheduler for low-range MCUs
 *  Version : 3.3
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

#ifndef H_QuarkTS
#define	H_QuarkTS

#ifdef	__cplusplus
extern "C" {
#endif
        
    
    #include <stdint.h>

    #define _QUARKTS_CR_DEFS_
    #ifndef NULL
        #define NULL ((void*)0)
    #endif

    #define QSTIMER

    #ifdef _QUARKTS_CR_DEFS_
        typedef enum qTaskPC_t_ {qCR_PCInitVal = -0x7FFE} _qTaskPC_t;        
        #define $qCRKeep                _qCR_BEGIN_:   
        #define $qPersistent            static _qTaskPC_t
        #define $qTaskProgress          __LINE__
        #define $qAssert(_COND_)        if(!(_COND_))
        #define $qTaskPCVar             _qCRTaskState_
        #define $qSetPC(_VAL_)          $qTaskPCVar = _VAL_
        #define $qTaskSaveState         $qSetPC($qTaskProgress) 
        #define $qTaskInitState         $qSetPC(qCR_PCInitVal) 
        #define $qTaskCheckPCJump(_PC_) switch(_PC_){      
        #define $qExit                  return
        #define $qTaskYield             $qExit;
        #define $qCRDispose             goto _qCR_BEGIN_;}$qExit
        #define $qRestorator(_VAL_)     case (_qTaskPC_t)_VAL_:            
        #define $RestoreAfterYield      $qRestorator($qTaskProgress)
        #define $RestoreFromBegin       $qRestorator(qCR_PCInitVal)
    #endif

    typedef enum {byTimeElapsed, byPriority, byQueueExtraction, byAsyncEvent} qTrigger_t;
    typedef float qTime_t;
    typedef volatile uint32_t qClock_t;
    typedef uint8_t qPriority_t;
    typedef uint8_t qIteration_t;
    typedef uint8_t qState_t;
    typedef uint8_t qBool_t;
    

    #define LOWEST_Priority     (qPriority_t)(0)
    #define MEDIUM_Priority     (qPriority_t)(0x7F)
    #define HIGH_Priority       (qPriority_t)(0xFE)
    #define PERIODIC            ((qIteration_t)-1)
    #define INDEFINITE          ((qIteration_t)-1)
    #define SINGLESHOT          ((qIteration_t)1)
    #define TIME_INMEDIATE      ((qTime_t)(0))
    
    #define ENABLE              (1)
    #define DISABLE             (0)
       
    typedef struct{
        /* Trigger:
        This flag indicates the event source that triggers the task execution.
        
         
        This flag can only have 4 possible values:        
        
        - byTimeElapsed : When the time specified for the task elapsed.
        
        - byPriority: When the execution chain does, according to the 
                      priority value
        
        - byQueueExtraction: When the scheduler performs extraction of 
                      task-associated data at the beginning of the 
                      priority-queue.
        
        - byAsyncEvent: When the execution chain does, according to a 
                        requirement of asynchronous event prompted by qSendEvent
        */
        qTrigger_t Trigger;
        /* UserData:
        Task arguments defined at the time of its creation.
        */
        void *UserData;
        /* EventData:
        Associated data of the event. Only available when the trigger is 
        <byQueueExtraction> or <byAsyncEvent>, Otherwise, this field is NULL.*/
        void *EventData;
        /* FirstCall:
        This flag indicates that a task is running for the first time. 
        This flag can be used for data initialization purposes.
        */
        qBool_t FirstCall;
    }qEvent_t;
    
    typedef void (*qTaskFcn_t)(qEvent_t);  
    typedef struct{
    	volatile uint8_t TimedTaskRun, InitFlag, AsyncRun, IgnoreOveruns, Enabled;
    }qTaskFlags_t;
       
    typedef enum {qWaiting = 0, qReady = 1, qRunning = 2} qTaskState_t;
   
    struct _qTask_t{
        void *UserData,*AsyncData;
        qClock_t Interval, TimeElapsed;
        qIteration_t Iterations;
        uint32_t Cycles;
        qPriority_t Priority;
        qTaskFcn_t Callback;
        volatile qTaskFlags_t Flag;
        volatile struct _qTask_t *Next;
    };
    #define qTask_t volatile struct _qTask_t
             
    typedef struct{
        qTask_t *Task;
        void *QueueData;
    }qQueueStack_t;

    typedef struct{
    	uint8_t Init, FCallIdle, ReleaseSched, FCallReleased;
    }qTaskCoreFlags_t;
   
    typedef struct{
        qTaskFcn_t IDLECallback;    
        qTaskFcn_t ReleaseSchedCallback;
        qTime_t Tick;
        qEvent_t EventInfo;
        qTask_t *First;
        void (*I_Disable)(void);
        void (*I_Enabler)(void);
        volatile qTaskCoreFlags_t Flag;
        volatile qQueueStack_t *QueueStack;
        uint8_t QueueSize, QueueIndex;
        volatile uint8_t NotSafeQueue;
        #ifdef QSTIMER
        volatile qClock_t epochs;
        #endif
    }QuarkTSCoreData_t;
    extern volatile QuarkTSCoreData_t QUARKTS;

    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack);
    void _qISRHandler(void);
    int _qCreateTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    void _qStart(void);
    int _qEnqueueTaskEvent(qTask_t *TasktoQueue, void* eventdata);
    void _qSendEvent(qTask_t *Task, void* eventdata);
    void _qSetTime(qTask_t *Task, qTime_t Value);
    void _qSetIterations(qTask_t *Task, qIteration_t Value);
    void _qSetPriority(qTask_t *Task, qPriority_t Value);
    void _qSetCallback(qTask_t *Task, qTaskFcn_t CallbackFcn);
    void _qEnableDisable(qTask_t *Task, qBool_t Value);
    void _qSetUserData(qTask_t *Task, void* arg);
    void _qClearTimeElapse(qTask_t *Task);
    void _qSetInterruptsED(void(*Enabler)(void), void(*Disabler)(void));
#define qSetInterruptsED(ENABLER, DISABLER)                                            _qSetInterruptsED(ENABLER, DISABLER)  
/*void qSetup(qTime_t ISRTick, qTaskFcn_t IDLE_Callback, unsigned char QueueSize)
    
Task Scheduler Setup. This function is required and must be called once in 
the application main thread befone any tasks creation.

Parameters:

    - ISRTick : This parameter specifies the ISR background timer period in 
                seconds(Floating-point format).

    - IDLE_Callback : Callback function to the Idle Task. To disable the 
                      Idle Task functionality, pass NULL as argument.

    - QueueSize : Size of the priority queue. This argument should be an integer
                  number greater than zero
     */
    #define qSetup(ISRTick, IDLE_Callback, QueueSize)                                   volatile qQueueStack_t _qQueueStack[QueueSize]; _qInitScheduler(ISRTick, IDLE_Callback, _qQueueStack, QueueSize)
    /*
void qISRHandler(void)

Feed the scheduler tick and triggers time-elapsed tasks. This function is 
required, and must be called once inside the dedicated timer interrupt
service routine. 
*/    
    #define qISRHandler()                                                               _qISRHandler()
/*int qCreateTask(qTask_t Identifier, qTaskFcn_t Callback, qPriority_t pValue, qTime_t tValue, qIteration_t iValue, qState_t  InitValue, void* USERDATA)

Creates a task defined by Identifier, that is scheduled to run every tValue 
seconds, iValue times and executing Callback method on every pass with 
pValue Priority.

Parameters:

    - Identifier : The task node identifier.

    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.

    - pValue : Task priority Value. [0(min) - 255(max)]

    - tValue : Execution interval defined in seconds (floating-point format). 
               For inmediate execution (tValue = TIME_INMEDIATE).

    - iValue : Number of task executions (Integer value). For indefinite 
               execution (iValue = PERIODIC or INDEFINITE). Tasks do not 
               remember the number of iteration set initially. After the 
               iterations are done, internal iteration counter is 0. If you 
               need to perform another set of iterations, you need to set the 
               number of iterations again.
    >Note 1: Tasks which performed all their iterations put their own 
             state to DISABLED.
    >Note 2: Asynchronous triggers do not affect the iteration counter.

    - InitValue : Specifies the initial state of the task (ENABLED or DISABLED).

    - USERDATA : Represents the task arguments. All arguments must be passed by
                 reference and cast to (void *). Only one argument is allowed, 
                 so, for multiple arguments, create a structure that contains 
                 all of the arguments and pass a pointer to that structure.

Return value:

    Returns 0 on successs, otherwise returns -1;
*/
    #define qCreateTask(TASK, CALLBACK, PRIORITY, TIME, NEXEC, INITSTATE, USERDATA)     _qCreateTask(&TASK, CALLBACK, (qPriority_t)PRIORITY, (qTime_t)TIME, (qIteration_t)NEXEC, INITSTATE, (void*)USERDATA)
/*int qCreateEventTask(qTask_t Identifier, qTaskFcn_t Callback, qPriority_t pValue, void* USERDATA)

Creates a task defined by Identifier that is scheduled with pValue Priority, 
executing Callback method on every pass. This API creates a task with DISABLED 
state by default , so this task will be oriented to be executed only, when 
asynchronous events occurs. However, this behavior can be changed in execution
time using qSetTime or qSetIterations.

Parameters:

    - Identifier : The task node identifier.

    - Callback : A pointer to a void callback method with a qEvent_t parameter
                 as input argument.

    - pValue : Task priority Value. [0(min) - 255(max)]

    - USERDATA : Represents the task arguments. All arguments must be passed by
                 reference and cast to (void *). Only one argument is allowed, 
                 so, for multiple arguments, create a structure that contains 
                 all of the arguments and pass a pointer to that structure.
     
Return value:

    Returns 0 on successs, otherwise returns -1;     
     */
    #define qCreateEventTask(TASK, CALLBACK, PRIORITY, USERDATA)                        _qCreateTask(&TASK, CALLBACK, (qPriority_t)PRIORITY, TIME_INMEDIATE, SINGLESHOT, 0, (void*)USERDATA)  
    /*
    void qSchedule(void)
    
    Execute the task-scheduler algorithm. It must be called once, after all 
    tasks are created.
    */
    #define qSchedule()                                                                 _qStart()
/*void qSendEvent(qTask_t Identifier, void* eventdata)

Sends a simple asyncrohous event. This method marks the task as ready for 
execution, therefore, the planner will launch the task immediately according to
the execution chain (even if task is disabled) and setting the Trigger flag to
"byAsyncEvent". Specific user-data can be passed through, and will be available
inside the EventData field, only in corresponding launch.

Parameters:

    - Identifier : The task node identifier.

    - eventdata : Specific event user-data.
*/
    #define qSendEvent(TASK, EVENTDATA)                                                 _qSendEvent(&TASK, (void*)EVENTDATA)
/*int qQueueEvent(qTask_t Identifier, void* eventdata)

Insert an asyncrohous event in the FIFO priority queue. The task will be ready 
for execution according to the queue extraction (determined by priority), even 
if task is disabled (More info here). When extracted, the scheduler will set 
Trigger flag to "byQueueExtraction". Specific user-data can be passed through, 
and will be available inside the EventData field, only in corresponding launch.

Parameters:

    - Identifier - The task node identifier.

    - eventdata - Specific event user-data.

Return value:

    Return 0 if the event has been inserted in the queue, or -1 if an error 
    occurred (The queue exceeds the size).
*/
    #define qQueueEvent(TASK, EVENTDATA)                                                _qEnqueueTaskEvent(&TASK, (void*)EVENTDATA)//_qEnqueueTaskEvent(&TASK, (void*)EVENTDATA)
/*void qSetIdleTask(qTask_t Identifier, qTaskFcn_t IDLE_Callback)

Establish the IDLE Task Callback

Parameters:

    - IDLE_Callback : A pointer to a void callback method with a qEvent_t 
                      parameter as input argument.
*/
    #define qSetIdleTask(IDLE_Callback)                                                 QUARKTS.IDLECallback = IDLE_Callback
/*void qSetTime(qTask_t Identifier, qTime_t Value)

Set/Change the Task execution interval

Parameters:

    - Identifier : The task node identifier.

    - Value : Execution interval defined in seconds (floating-point format). 
              For inmediate execution (tValue = TIME_INMEDIATE).
*/
    #define qSetTime(TASK, VALUE)                                                       _qSetTime(&TASK,  (qTime_t)VALUE)  
/*void qSetIterations(qTask_t Identifier, qIteration_t Value)

Set/Change the number of task iterations

Parameters:

    - Identifier : The task node identifier.

    - Value : Number of task executions (Integer value). For indefinite 
              execution (iValue = PERIODIC or INDEFINITE). Tasks do not remember
              the number of iteration set initially. After the iterations are 
              done, internal iteration counter is 0. If you need to perform
              another set of iterations, you need to set the number of 
              iterations again.
*/
    #define qSetIterations(TASK, VALUE)                                                 _qSetIterations(&TASK, (qIteration_t)VALUE) 
/*void qSetSpec(qTask_t Identifier, qTime_t tValue, qIteration_t iValue)

Set/Change the task time-interval and the number of task iterations.

Parameters:

    - Identifier : The task node identifier.

    - tValue : Execution interval defined in seconds (floating-point format). 
               For inmediate execution (tValue = TIME_INMEDIATE).

    - iValue : Number of task executions (Integer value). For indefinite 
               execution (iValue = PERIODIC or INDEFINITE). Tasks do not 
               remember the number of iteration set initially. After the 
               iterations are done, internal iteration counter is 0. If you need
               to perform another set of iterations, you need to set the number 
               of iterations again.
*/
    #define qSetSpec(TASK, TVALUE, IVALUE)                                              _qSetTime(&TASK, (qTime_t)TVALUE); \
                                                                                        _qSetIterations(&TASK, (qIteration_t)IVALUE) 

    
/*void qSetPriority(qTask_t Identifier, qPriority_t Value)

Set/Change the task priority value

Parameters:

    - Identifier : The task node identifier.

    - Value : Priority Value. [0(min) - 255(max)]
*/    
    #define qSetPriority(TASK,VALUE)                                                    _qSetPriority(&TASK, (qPriority_t)VALUE)   
/*void qEnable(qTask_t Identifier)

Enable the task

Parameters:

    - Identifier : The task node identifier.
*/
    #define qEnable(TASK)                                                               _qEnableDisable(&TASK, 1)  
/*void qDisable(qTask_t Identifier)

qDisable the task

Parameters:

    - Identifier : The task node identifier.
*/
    #define qDisable(TASK)                                                              _qEnableDisable(&TASK, 0) 
/*void qSetCallback(qTask_t Identifier, qTaskFcn_t Callback)

Set/Change the task callback function

Parameters:

    - Identifier : The task node identifier.

    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
    #define qSetCallback(TASK, CALLBACK)                                                _qSetCallback(&TASK, CALLBACK) 
/*void qSetUserData(qTask_t Identifier, void* UserData)

Retrieve the task user data

Parameters:

    - Identifier : The task node identifier.

Return value:

    A void pointer to the task user data.
*/
    #define qSetUserData(TASK, USERDATA)                                                _qSetUserData(&TASK, (void*)USERDATA)
/*void qClearTimeElapsed(qTask_t Identifier)

Clear the elapsed time of the task. Restart the internal task tick;

Parameters:

    - Identifier : The task node identifier.
*/
    #define qClearTimeElapsed(TASK)                                                     _qClearTimeElapse(TASK)
/*
unsigned char qIsEnabled(qTask_t Identifier)

Retrieve the enabled/disabled state

Parameters:

    - Identifier : The task node identifier.

Return value:

    True if the task in on Enabled state, otherwise returns false.
*/
    #define qIsEnabled(TASK)                                                            (TASK.Flag.State)
/*unsigned long qGetCycles(qTask_t Identifier)

Retrieve the number of task activations.

Parameters:

    - Identifier : The task node identifier.

Return value:

    A unsigned long value containing the number of task activations.
*/
    #define qGetCycles(TASK)                                                            (TASK.Cycles)
/*void qIgnoreOverruns(qTask_t Identifier)
 
Disable delayed activations when the task is behind the schedule.

Parameters:

    - Identifier : The task node identifier.
*/
    #define qIgnoreOverruns(TASK, _TF_)                                                 (TASK.Flag.IgnoreOveruns = _TF_!=0)            
/*void qReleaseSchedule(void)

Disables the QuarkTS scheduling. The main thread will continue after the
qSchedule() call.
*/
    #define qReleaseSchedule()                                                          QUARKTS.Flag.ReleaseSched = 1
/*void qSetReleaseSchedCallback(qTaskFcn_t Callback)

Set/Change the scheduler release callback function

Parameters:
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
    #define qSetReleaseSchedCallback(RELEASE_Callback)                                  QUARKTS.ReleaseSchedCallback = RELEASE_Callback
    
    #if !defined(QPRIORITY_FIFO_QUEUE) && !defined(QSIMPLE_FIFO_QUEUE) 
        #define QPRIORITY_FIFO_QUEUE
    #endif
   
    typedef enum state {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;
     
    #define qSM_t volatile struct _qSM_t

    struct _qSM_t{ 
        /* NextState:
        Next state to be performed after this state finish
        */
        qSM_Status_t (*NextState)(qSM_t*);
        /* PreviousState:
        State executed before this state
        */
        qSM_Status_t (*PreviousState)(qSM_t*);
        /* PreviousReturnStatus:
        The return status of <PreviusStateState>
        */
        qSM_Status_t PreviousReturnStatus;
        /* StateJustChanged:
        True when  <PreviousState> !=  <NextState>
        */
        qBool_t StateJustChanged;
        /* Data:
        State-machine associated data
         */
        void *Data;
        struct { //hide this members
            void (*__Failure)(qSM_t*);
            void (*__Success)(qSM_t*);
            void (*__Unexpected)(qSM_t*);  
        }_;
    };    
    typedef qSM_Status_t (*qSM_State_t)(qSM_t*);
    typedef void (*qSM_ExState_t)(qSM_t*);
    int _qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);
    void _qStateMachine_Run(qSM_t *obj, void *Data);
/*int qStateMachine_Init(qSM_t FSM, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);

Initializes a finite state machine (FSM).

Parameters:

    - OBJ : The FSM object.

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
    #define qStateMachine_Init(OBJ, INIT_STATE, SUCCESS_STATE, FAILURE_STATE, UNEXPECTED_STATE)   _qStateMachine_Init(&OBJ, INIT_STATE, SUCCESS_STATE, FAILURE_STATE, UNEXPECTED_STATE) 
/*void qStateMachine_Run(qSM_t FSM, void* Data)

Execute the Finite State Machine (FSM).

Parameters:

    - FSM : The FSM object.

    - Data : Represents the FSM arguments. All arguments must be passed by 
             reference and cast to (void *). Only one argument is allowed, so,
             for multiple arguments, create a structure that contains all of 
             the arguments and pass a pointer to that structure.
*/    
    #define qStateMachine_Run(OBJ, USERDATA)   _qStateMachine_Run(&OBJ, USERDATA) 
    
    #ifdef _QUARKTS_CR_DEFS_    
        #define $qCRStart                               $qPersistent  $qTaskInitState ;  $qTaskCheckPCJump($qTaskPCVar) $RestoreFromBegin ; $qCRKeep
        #define $qCRYield                               { $qTaskSaveState ; $qTaskYield  $RestoreAfterYield; }
        #define $qCRRestart                             { $qTaskInitState ; $qTaskYield }
        #define $qCR_wu_Assert(_cond_)                  { $qTaskSaveState ; $RestoreAfterYield ; $qAssert(_cond_) $qTaskYield }
/*qCoroutineBegin{
  
}qCoroutineEnd;

Defines a Coroutine segment. Only one segment is allowed inside a task; 
The qCoroutineBegin statement is used to declare the starting point of 
a Coroutine. It should be placed at the start of the function in which the 
Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
It must always be used together with a matching qCoroutineBegin statement.
*/
        #define qCoroutineBegin                         $qCRStart
/*
This statement is only allowed inside a Coroutine segment. qCoroutineYield 
return the CPU control back to the scheduler but saving the execution progress. 
With the next task activation, the Coroutine will resume the execution after 
the last 'qCoroutineYield' statement.
*/
        #define qCoroutineYield                         $qCRYield          
/*qCoroutineBegin{
  
}qCoroutineEnd;

Defines a Coroutine segment. Only one segment is allowed inside a task; 
The qCoroutineBegin statement is used to declare the starting point of 
a Coroutine. It should be placed at the start of the function in which the 
Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
It must always be used together with a matching qCoroutineBegin statement.
*/    
        #define qCoroutineEnd                           $qCRDispose
/*This statement cause the running Coroutine to restart its execution at the 
place of the qCoroutineBegin statement.
*/
        #define qCoroutineRestart                       $qCRRestart  
/*qCoroutineWaitUntil(_CONDITION_)

Yields until the logical condition being true
*/    
        #define qCoroutineWaitUntil(_condition_)        $qCR_wu_Assert(_condition_)
    #endif
    
    #ifdef QSTIMER
        typedef struct{
            uint8_t SR;
            qClock_t Start, TV;
        }qSTimer_t;
        int _qSTimerSet(qSTimer_t *obj, qTime_t Time, qBool_t fr);
        qBool_t _qSTimerExpired(qSTimer_t *obj);
        qClock_t _qSTimerElapsed(qSTimer_t *obj);
        qClock_t _qSTimerRemaining(qSTimer_t *obj);
        #define QSTIMER_INITIALIZER     {0, 0, 0}
/*int qSTimerSet(qSTimer_t OBJ, qTime_t Time)
 
Set the expiration time for a STimer. On success, the Stimer gets 
armed immediately

Parameters:

    - OBJ : The STimer object.

    - Time : The expiration time(Must be specified in seconds).

    > Note 1: The scheduler must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greather than 
              the scheduler-Tick.

Return value:

    Returns 0 on success, otherwise, returns -1.
*/        
        #define qSTimerSet(OBJ, Time)   _qSTimerSet(&OBJ, (qTime_t)Time, 0)
/*unsigned char qSTimerExpired(qSTimer_t OBJ)

Non-Blocking Stimer check

Parameters:

    - OBJ : The STimer object.

Return value:

    Returns true when STimer expires, otherwise, returns false.
    > Note 1: A disarmed STimer also returns false.

*/
        #define qSTimerExpired(OBJ)   _qSTimerExpired(&OBJ)
/*void qSTimerDisarm(qSTimer_t OBJ)

Disarms the STimer

Parameters:

    - OBJ : The STimer object.
*/
        #define qSTimerDisarm(OBJ)      (OBJ.SR = 0)
/*unsigned char qSTimerFreeRun(qSTimer_t OBJ, qTime_t Time)

Non-Blocking STimer check with automatic arming

Parameters:

    - OBJ : The STimer object.
  
    - Time : The expiration time(Must be specified in seconds).
 
    > Note 1: The scheduler must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greather than  
              the scheduler-Tick.
    > Note 3: Time parameter is only taken when the STimer is re-armed
  
Return value:

    Returns true when STimer expires, otherwise, returns false.
    > Note 4: A disarmed STimer also returns false.
    > Note 5: After the STimer expiration,  qSTimerFreeRun re-arms the STimer
*/
        #define qSTimerFreeRun(OBJ, Time)  _qSTimerSet(&OBJ, (qTime_t)Time, 1)
/*qClock_t qSTimerRemainingEpochs(qSTimer_t OBJ)

Query the remaining epochs

Parameters:

    - OBJ : The STimer object.

Return value:

    The remaining epochs. 
*/
        #define qSTimerRemainingEpochs(OBJ)     _qSTimerRemaining(&OBJ)
/*qTime_t qSTimerRemainingTime(qSTimer_t OBJ)

Query the remaining time

Parameters:

    - OBJ : The STimer object.

Return value:

    The remaining time. 
*/
        #define qSTimerRemainingTime(OBJ)       (QUARKTS.Tick*_qSTimerRemaining(&OBJ))
/*qClock_t qSTimerElapsedEpochs(qSTimer_t OBJ)

Query the elapsed epochs

Parameters:

    - OBJ : The STimer object.

Return value:

    The elapsed epochs. 
*/
        #define qSTimerElapsedEpochs(OBJ)       _qSTimerElapsed(&OBJ)
/*qTime_t qSTimerElapsedTime(qSTimer_t OBJ)

Query the elapsed time

Parameters:

    - OBJ : The STimer object.

Return value:

    The elapsed time. 
*/
        #define qSTimerElapsedTime(OBJ)         (QUARKTS.Tick*_qSTimerElapsed(&OBJ))
        
    #endif
        
#ifdef	__cplusplus
}
#endif

#endif	/* H_QuarkTS */

