/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Task Scheduler for low-range MCUs
 *  Version : 4.6.6
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

#ifndef H_QuarkTS
#define	H_QuarkTS

#ifdef	__cplusplus
extern "C" {
#endif
        
    #ifndef __ORDER_LITTLE_ENDIAN__  /*default endianess: little-endian*/
        #define __ORDER_LITTLE_ENDIAN__     1
    #endif
    #ifndef __BYTE_ORDER__
        #define __BYTE_ORDER__  __ORDER_LITTLE_ENDIAN__
    #endif
     
    
    #define Q_BYTE_SIZED_BUFFERS    /*remove this line if you will never use the Byte-sized buffers*/
    #define Q_MEMORY_MANAGER        /*remove this line if you will never use the Memory Manager*/
    #define Q_RINGBUFFERS           /*remove this line if you will never use Ring Buffers*/
    #define Q_PRIORITY_QUEUE        /*remove this line if you will never queue events*/
    #define Q_AUTO_CHAINREARRANGE   /*remove this line if you will never change the tasks priorities dynamically */ 
    #define Q_TRACE_VARIABLES       /*remove this line if you will never need to debug variables*/
    #define Q_DEBUGTRACE_BUFSIZE    32  /*Size for the debug/trace buffer: 32 bytes should be enough*/
    
    #undef QATOF_FULL
    
    #include <stdint.h>
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #define __QUARKTS__
    #define _QUARKTS_CR_DEFS_
    #define QUARTKTS_VERSION "4.6.6"
    #ifndef NULL
        #define NULL ((void*)0)
    #endif
   
    /*#define Q_TASK_INSERT_BEGINNING*/
    #define qTrue                   0x01u
    #define qFalse                  0x00u
    #define qEnabled                (qTrue)
    #define qDisabled               (qFalse)
    #define qLINK                   (qTrue)
    #define qUNLINK                 (qFalse)  
    #define qLink                   (qTrue)
    #define qUnLink                 (qFalse)
    #define qON                     (qTrue)
    #define qOFF                    (qFalse)
    #ifdef __XC8
        #define qConst
        #define qConstField_Set(TYPE, STRUCT_FIELD)    STRUCT_FIELD
    #else
        #define qConst const  
        #define qConstField_Set(TYPE, STRUCT_FIELD)    *((TYPE*)&(STRUCT_FIELD))
    #endif
    #define qBitsSet(Register, Bits)                    (Register) |= (Bits)
    #define qBitsClear(Register, Bits)                  (Register) &= ~(Bits)
    #define qBitSet(Register, Bit)                      (Register) |= (1 << (Bit))
    #define qBitClear(Register, Bit)                    (Register) &= (~(1<< (Bit)))
    #define qBitRead(Register,Bit)                      ((qFalse == ((Register)& (1<<(Bit))))? qFalse : qTrue)
    #define qBitToggle(Register,Bit)                    ((Register)^= (1<<(Bit)))
    #define qBitWrite(Register, Bit, Value)             ((Value) ? qBitSet(Register,Bit) : qBitClear(Register,Bit))
    #define qBitMakeByte(b7,b6,b5,b4,b3,b2,b1,b0)       (uint8_t)( ((b7)<<7) + ((b6)<<6) + ((b5)<<5) + ((b4)<<4) + ((b3)<<3) + ((b2)<<2) + ((b1)<<1) + ((b0)<<0) )
    #define qByteMakeFromBits(b7,b6,b5,b4,b3,b2,b1,b0)  qBitMakeByte(b7,b6,b5,b4,b3,b2,b1,b0) 
    #define qByteHighNibble(Register)                   ((uint8_t)((Register)>>4))
    #define qByteLowNibble(Register)                    ((uint8_t)((Register)&0x0F))
    #define qByteMergeNibbles(H,L)                      ((uint8_t)(((H)<<4)|(0x0F&(L))))    
    #define qWordHighByte(Register)                     ((uint8_t)((Register)>>8))
    #define qWordLowByte(Register)                      ((uint8_t)((Register)&0x00FF))
    #define qWordMergeBytes(H,L)                        ((uint16_t)(((H)<<8)|(L)))
    #define qDWordHighWord(Register)                    ((uint16_t)((Register) >> 16))
    #define qDWordLowWord(Register)                     ((uint16_t)((Register) & 0xFFFF))
    #define qDWordMergeWords(H,L)                       ((uint32_t)(((uint32_t)(H) << 16 ) | (L) ) )

    #define qClip(X, Max, Min)                          (((X) < (Min)) ? (Min) : (((X) > (Max)) ? (Max) : (X)))
    #define qClipUpper(X, Max)                          (((X) > (Max)) ? (Max) : (X))
    #define qClipLower(X, Min)                          (((X) < (Min)) ? (Min) : (X))
    #define qIsBetween(X, Low, High)                    ((qBool_t)((X) >= (Low) && (X) <= (High)))
    
    #ifdef _QUARKTS_CR_DEFS_
        typedef int32_t _qTaskPC_t;
        #define qCRPosition_t static _qTaskPC_t
        typedef struct {unsigned int head, tail;} qCoroutineSemaphore_t; 
        typedef qCoroutineSemaphore_t qCRSem_t;
        #define qCR_PCInitVal   (-0x7FFE)           
        #define __qCRKeep                _qCR_BEGIN_:
        #define __qCRCodeStartBlock      do
        #define __qCRCodeEndBlock        while(qFalse)
        #define __qPersistent            static _qTaskPC_t
        #define __qTaskProgress          __LINE__
        #define __qAssert(_COND_)        if(!(_COND_))
        #define __qTaskPCVar             _qCRTaskState_
        #define __qSetPC(_VAL_)          __qTaskPCVar = _VAL_
        #define __qTaskSaveState         __qSetPC(__qTaskProgress) 
        #define __qTaskInitState         __qSetPC(qCR_PCInitVal) 
        #define __qTaskCheckPCJump(_PC_) switch(_PC_){    
        #define __TagExitCCR             __qCRYield_ExitLabel
        #define __qExit                  goto __TagExitCCR
        #define __qTaskYield             __qExit;
        #define __qCRDispose             goto _qCR_BEGIN_;}__TagExitCCR:
        #define __qRestorator(_VAL_)     case (_qTaskPC_t)_VAL_:            
        #define __RestoreAfterYield      __qRestorator(__qTaskProgress)
        #define __RestoreFromBegin       __qRestorator(qCR_PCInitVal)
        #define __qCRSemInit(s, c)      __qCRCodeStartBlock{ (s)->tail = 0; (s)->head = (c); }__qCRCodeEndBlock
        #define __qCRSemCount(s)        ((s)->head - (s)->tail)
        #define __qCRSemLock(s)         (++(s)->tail)
        #define __qCRSemRelease(s)      (++(s)->head)
    #endif

    typedef enum {qTriggerNULL, byTimeElapsed, byQueueExtraction, byAsyncEvent, byRBufferPop, byRBufferFull, byRBufferCount, byRBufferEmpty, bySchedulingRelease, byNoReadyTasks} qTrigger_t;
    #define qTrigger_TimeElapsed        byTimeElapsed
    #define qTrigger_QueueExtraction    byQueueExtraction
    #define qTrigger_AsyncEvent         byAsyncEvent
    #define qTrigger_RBufferPop         byRBufferPop
    #define qTrigger_RBufferFull        byRBufferFull
    #define qTrigger_RBufferCount       byRBufferCount
    #define qTrigger_RBufferEmpty       byRBufferEmpty
    #define qTrigger_SchedulingRelease  bySchedulingRelease
    #define qTrigger_NoReadyTasks       byNoReadyTasks

    typedef float qTime_t;
    typedef uint32_t qClock_t;
    typedef uint8_t qPriority_t;
    typedef int16_t qIteration_t;
    typedef uint8_t qState_t;
    typedef uint8_t qBool_t;
    typedef uint16_t qSize_t;
    
    #define qLowest_Priority     ((qPriority_t)(0x00u))
    #define qMedium_Priority     ((qPriority_t)(0x7Fu))
    #define qHigh_Priority       ((qPriority_t)(0xFEu))
    #define qPeriodic            ((qIteration_t)(-32768))
    #define qIndefinite          qPeriodic
    #define qSingleShot          ((qIteration_t)(1))
    #define qTimeInmediate       ((qTime_t)(0))

    #define LOWEST_Priority     qLowest_Priority
    #define MEDIUM_Priority     qMedium_Priority
    #define HIGH_Priority       qHigh_Priority
    
    /*backward compatibility*/
    #ifndef PERIODIC 
        #define PERIODIC            qPeriodic
    #endif
    
    #ifndef INDEFINITE
        #define INDEFINITE          qIndefinite
    #endif
    
    #ifndef SINGLESHOT
        #define SINGLESHOT          qSingleShot
    #endif
    
    #ifndef TIME_INMEDIATE
        #define TIME_INMEDIATE      qTimeInmediate
    #endif      
          
    #define _QEVENTINFO_INITIALIZER     {_Q_NO_VALID_TRIGGER_, NULL, NULL, qFalse, qFalse, qFalse}  
    typedef struct{
        /* Trigger:
        This flag indicates the event source that triggers the task execution.
        
         
        This flag can only have the following values:        
        
        - byTimeElapsed : When the time specified for the task elapsed.
                
        - byQueueExtraction: When the scheduler performs extraction of 
                      task-associated data at the beginning of the 
                      priority-queue.
        
        - byAsyncEvent: When the execution chain does, according to a 
                        requirement of asynchronous event prompted by qSendEvent
        
        - byRBufferPop: When there is elements available in the linked ring-buffer,
                        the scheduler makes a data extraction (auto-pop) from the
                        head. A pointer to the extracted (popped) data will be 
                        available in the <EventData> field.
        
        - byRBufferFull: When the linked ring-buffer is full. A pointer to the 
                         RingBuffer will be available in the <EventData> field.
         
        - byRBufferCount: When the element-count of the linked ring-buffer reaches
                         the specified value. A pointer to the RingBuffer will 
                         be available in the <EventData> field.
        
        - byRBufferEmpty: When the linked ring-buffer is empty.  A pointer to the 
                         RingBuffer will be available in the <EventData> field.
        
        - byNoReadyTasks: Only when the Idle Task is triggered.
        */
        qTrigger_t Trigger;
        /* TaskData (Storage-Pointer):
        Task arguments defined at the time of its creation.
        */
        void *TaskData;
        /* EventData:
        Associated data of the event. Specific data will reside here according
        to the event source. This field will only have a NULL value when the 
        trigger is <byTimeElapsed> or <byPriority>.
         */
        void *EventData;
        /* FirstCall:
        This flag indicates that a task is running for the first time. 
        This flag can be used for data initialization purposes.
        */
        qBool_t FirstCall;
        /* FirstIteration:
        Indicates whether current pass is the first iteration of the task. 
        This flag will be only set when time-elapsed events occours and the
        Iteration counter has been parametrized. Asyncronous events never change
        the task iteration counter, consequently doesn't have effect in this flag 
        */
        qBool_t FirstIteration;
        /* LastIteration:
        Indicates whether current pass is the last iteration of the task. 
        This flag will be only set when time-elapsed events occours and the
        Iteration counter has been parametrized. Asyncronous events never change
        the task iteration counter, consequently doesn't have effect in this flag 
        */
        qBool_t LastIteration;
    }_qEvent_t_/*, *const qEvent_t*/;  
    typedef const _qEvent_t_ *qConst qEvent_t;
    typedef void (*qTaskFcn_t)(qEvent_t);  

    #define _qIndex_InitFlag        0
    #define _qIndex_AsyncRun        1
    #define _qIndex_Enabled         2
    #define _qIndex_RBAutoPop       3
    #define _qIndex_RBFull          4
    #define _qIndex_RBCount         5
    #define _qIndex_RBEmpty         6
    
    typedef uint8_t qTaskState_t;
    #define qWaiting    0u
    #define qReady      1u
    #define qRunning    2u
    #define qSuspended  3u

    #ifdef Q_RINGBUFFERS 
    typedef struct{
        volatile uint8_t *data; /* block of memory or array of data */
        volatile qSize_t ElementSize;      /* how many bytes for each chunk */
        volatile qSize_t Elementcount;     /* number of chunks of data */
        volatile qSize_t head; /* where the writes go */
        volatile qSize_t tail; /* where the reads come from */
    }qRBuffer_t;
    #endif
    
    typedef enum {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;
    #define qPrivate    _
    #define _qSMData_t struct _qSM_t * const 
    typedef struct _qSM_t{ 
        /* NextState: (Read/Write) 
        Next state to be performed after this state finish
        */
        qSM_Status_t (*NextState)(_qSMData_t);
        /* PreviousState: (Read Only)
        Last state seen in the flow chart
        */
        qSM_Status_t (* qConst PreviousState)(_qSMData_t);
        /* LastState: (Read Only) 
        The last state executed
        */        
        qSM_Status_t (* qConst LastState)(_qSMData_t);
        /* PreviousReturnStatus: (Read Only)
        The return status of <PreviusStateState>
        */
        qConst qSM_Status_t PreviousReturnStatus;
        /* StateFirstEntry: [== StateJustChanged] (Read Only)
        True when  <Previous State> !=  <Current State>
        */
        qConst qBool_t StateFirstEntry;
        /* Data: (Read Only)
        State-machine associated data.
        Note: If the FSM is running as a task, the asociated event data can be 
        queried throught the "Data" field. (cast to qEvent_t is mandatory)
         */
        void * qConst Data;
        /*Private members (DO NOT USE THEM)*/
        struct /**/{
            void (*qConst __Failure)(_qSMData_t);
            void (*qConst __Success)(_qSMData_t);
            void (*qConst __Unexpected)(_qSMData_t);  
            void (*qConst __BeforeAnyState)(_qSMData_t);/*only used when a task has a SM attached*/
        }qPrivate;
    }qSM_t;
    typedef qSM_t* const qSMData_t;    
    typedef qSM_Status_t (*qSM_State_t)(qSMData_t); 
    typedef void (*qSM_SubState_t)(qSMData_t); 
    #define StateJustChanged    StateFirstEntry /*backward compatibility*/
   
    typedef enum{ /*FSM Attribute Flags definition*/
        qSM_RESTART, /*Restart the FSM*/
        qSM_CLEAR_STATE_FIRST_ENTRY_FLAG, /*Clear the entry flag for the current state if the NextState field doesnt change*/
        qSM_FAILURE_STATE, /*Set the Failure State*/
        qSM_SUCCESS_STATE, /*Set the Success State*/
        qSM_UNEXPECTED_STATE, /*Set the Unexpected State*/
        qSM_BEFORE_ANY_STATE /*Set the state executed before any state*/              
    }qFSM_Attribute_t; 
          
    #define Q_TASK_EXTENDED_DATA
    struct _qTask_t{ /*Task node definition*/
        volatile struct _qTask_t *Next; /*pointer to the next node*/
        void *TaskData,*AsyncData; /*the storage pointers*/
        volatile qClock_t Interval, ClockStart; /*time-epochs registers*/
        qIteration_t Iterations; 
        uint32_t Cycles; 
        qPriority_t Priority; 
        qTaskFcn_t Callback; 
        volatile qBool_t Flag[7]; 
        /*volatile qTaskFlags_t Flag;*/
        #ifdef Q_RINGBUFFERS
        qRBuffer_t *RingBuff; /*pointer to the linked RBuffer*/
        #endif
        qSM_t *StateMachine; /*pointer to the linked FSM*/
        qTaskState_t State;
        qTrigger_t Trigger;
    };
    #define qTask_t volatile struct _qTask_t
    typedef qTask_t** qHeadPointer_t;         
    typedef struct{
        qTask_t *Task;
        void *QueueData;
    }qQueueStack_t;  

    typedef struct{ /*Scheduler Core-Flags*/
    	volatile uint8_t Init, FCallIdle, ReleaseSched, FCallReleased;
        volatile uint32_t IntFlags;
    }qTaskCoreFlags_t;
   
    typedef struct{ /*Main scheduler core data*/
        qTaskFcn_t IDLECallback;    
        qTaskFcn_t ReleaseSchedCallback;
        _qEvent_t_ EventInfo;
        qTime_t Tick;
        qTask_t *Head;
        uint32_t (*I_Disable)(void);
        void (*I_Restorer)(uint32_t);
        volatile qTaskCoreFlags_t Flag;
        #ifdef Q_PRIORITY_QUEUE
            volatile qQueueStack_t *volatile QueueStack;
            uint8_t QueueSize;
            volatile int16_t QueueIndex;
            void *QueueData;
        #endif 
        qTask_t *CurrentRunningTask;
    }QuarkTSCoreData_t;
    
    void qSchedulerSysTick(void);
    qTask_t* qTaskSelf(void);
    qBool_t qTaskIsEnabled(const qTask_t *Task);
    void qSchedulerSetIdleTask(qTaskFcn_t Callback);
    void qSchedulerRelease(void);
    void qSchedulerSetReleaseCallback(qTaskFcn_t Callback);
    
    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack);
    void qSchedulerSetInterruptsED(void (*Restorer)(uint32_t), uint32_t (*Disabler)(void));
    qBool_t qSchedulerAddxTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    qBool_t qSchedulerAddeTask(qTask_t *Task, qTaskFcn_t Callback, qPriority_t Priority, void* arg);
    qBool_t qSchedulerAddSMTask(qTask_t *Task, qPriority_t Priority, qTime_t Time,
                                qSM_t *StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                                qState_t InitialTaskState, void *arg);
    qBool_t qSchedulerRemoveTask(qTask_t *TasktoRemove);
    void qSchedulerRun(void);
    qBool_t qTaskQueueEvent(qTask_t *Task, void* eventdata);  
    void qTaskSendEvent(qTask_t *Task, void* eventdata);
          
    typedef enum{qRB_AUTOPOP=_qIndex_RBAutoPop, qRB_FULL=_qIndex_RBFull, qRB_COUNT=_qIndex_RBCount, qRB_EMPTY=_qIndex_RBEmpty}qRBLinkMode_t;
    #define    RB_AUTOPOP   qRB_AUTOPOP
    #define    RB_FULL      qRB_FULL
    #define    RB_COUNT     qRB_COUNT
    #define    RB_EMPTY     qRB_EMPTY
    
    #ifdef Q_RINGBUFFERS 
    qBool_t qTaskLinkRBuffer(qTask_t *Task, qRBuffer_t *RingBuffer, const qRBLinkMode_t Mode, uint8_t arg);
    #endif
    
    void qTaskSetTime(qTask_t *Task, const qTime_t Value);
    void qTaskSetIterations(qTask_t *Task, const qIteration_t Value);
    void qTaskSetPriority(qTask_t *Task, const qPriority_t Value);
    void qTaskSetCallback(qTask_t *Task, qTaskFcn_t CallbackFcn);
    void qTaskSetState(qTask_t *Task, const qState_t State);
    void qTaskSetData(qTask_t *Task, void* arg);
    void qTaskClearTimeElapsed(qTask_t *Task);
    uint32_t qTaskGetCycles(const qTask_t *Task);
    
    
/*void qTaskSuspend(qTask_t *Task)

Put the task into a disabled state.    

Parameters:

    - Task : A pointer to the task node.
*/
    #define qTaskSuspend(pTask_)    qTaskSetState(pTask_, qDisabled)
/*void qTaskResume(qTask_t *Task)

Put the task into a enabled state.    

Parameters:

    - Task : A pointer to the task node.
*/
    #define qTaskResume(pTask_)    qTaskSetState(pTask_, qEnabled)

    
    
/*void qSchedulerSetup(qTime_t ISRTick, qTaskFcn_t IDLE_Callback, unsigned char QueueSize)
    
Task Scheduler Setup. This function is required and must be called once in 
the application main thread before any tasks creation.

Parameters:

    - ISRTick : This parameter specifies the ISR background timer period in 
                seconds(Floating-point format).

    - IDLE_Callback : Callback function to the Idle Task. To disable the 
                      Idle Task functionality, pass NULL as argument.

    - QueueSize : Size of the priority queue. This argument should be an integer
                  number greater than zero
     */
    #ifdef Q_PRIORITY_QUEUE
        #define qSchedulerSetup(ISRTick, IDLE_Callback, QueueSize)                                   volatile qQueueStack_t _qQueueStack[QueueSize]; _qInitScheduler(ISRTick, IDLE_Callback, _qQueueStack, QueueSize)
    #else
        #define qSchedulerSetup(ISRTick, IDLE_Callback, QueueSize)                                   _qInitScheduler(ISRTick, IDLE_Callback, NULL, 0)
    #endif
    qBool_t qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState, qSM_SubState_t BeforeAnyState);
    void qStateMachine_Run(qSM_t *obj, void *Data);
    void qStateMachine_Attribute(qSM_t *obj, qFSM_Attribute_t Flag ,void *val);
    
    #ifdef _QUARKTS_CR_DEFS_    
        #define __qCRStart                          __qPersistent  __qTaskInitState ;  __qTaskCheckPCJump(__qTaskPCVar) __RestoreFromBegin ; __qCRKeep
        #define __qCRYield                          __qCRCodeStartBlock{ __qTaskSaveState ; __qTaskYield  __RestoreAfterYield; } __qCRCodeEndBlock
        #define __qCRRestart                        __qCRCodeStartBlock{ __qTaskInitState ; __qTaskYield } __qCRCodeEndBlock
        #define __qCR_wu_Assert(_cond_)             __qCRCodeStartBlock{ __qTaskSaveState ; __RestoreAfterYield ; __qAssert(_cond_) __qTaskYield }__qCRCodeEndBlock
        #define __qCR_GetPosition(_pos_)            __qCRCodeStartBlock{_pos_=__qTaskProgress; __RestoreAfterYield;}__qCRCodeEndBlock
        #define __qCR_RestoreFromPosition(_pos_)    __qCRCodeStartBlock{__qSetPC(_pos_); __qTaskYield} __qCRCodeEndBlock
        #define __qCR_PositionReset(_pos_)          _pos_ = qCR_PCInitVal
/*qCoroutineBegin{
  
}qCoroutineEnd;

qCRBegin{
  
}qCREnd;
 * 
Defines a Coroutine segment. Only one segment is allowed inside a task; 
The qCoroutineBegin statement is used to declare the starting point of 
a Coroutine. It should be placed at the start of the function in which the 
Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
It must always be used together with a matching qCoroutineBegin statement.
*/
        #define qCoroutineBegin                         __qCRStart
        #define qCRBegin                                __qCRStart
/*qCoroutineYield
qCRYield

This statement is only allowed inside a Coroutine segment. qCoroutineYield 
return the CPU control back to the scheduler but saving the execution progress. 
With the next task activation, the Coroutine will resume the execution after 
the last 'qCoroutineYield' statement.
*/
        #define qCoroutineYield                         __qCRYield          
        #define qCRYield                                __qCRYield
/*qCoroutineBegin{
  
}qCoroutineEnd;
qCRBegin{
  
}qCREnd;

Defines a Coroutine segment. Only one segment is allowed inside a task; 
The qCoroutineBegin statement is used to declare the starting point of 
a Coroutine. It should be placed at the start of the function in which the 
Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
It must always be used together with a matching qCoroutineBegin statement.
*/    
        #define qCoroutineEnd                           __qCRDispose
        #define qCREnd                                  __qCRDispose
/*qCoroutineRestart
qCRRestart

This statement cause the running Coroutine to restart its execution at the 
place of the qCoroutineBegin statement.
*/
        #define qCoroutineRestart                       __qCRRestart  
        #define qCRRestart                              __qCRRestart 
/*qCoroutineWaitUntil(_CONDITION_) 
qCRWaitUntil(_CONDITION_)

Yields until the logical condition being true
*/    
        #define qCoroutineWaitUntil(_condition_)        __qCR_wu_Assert(_condition_)
        #define qCRWaitUntil(_condition_)               __qCR_wu_Assert(_condition_)
/*qCoroutineSemaphoreInit(_qCRSemaphore_t_, _Value_) 
qCRSemInit(_qCRSemaphore_t_, _Value_)

Initializes a semaphore with a value for the counter. Internally, the semaphores
use an "unsigned int" to represent the counter, and therefore the "count" 
argument should be within range of an unsigned int.

Parameters:

    - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore

    - _Value_ : The initial count of the semaphore.
*/          
        #define qCoroutineSemaphoreInit(_qCRSemaphore_t_, _Value_)      __qCRSemInit(_qCRSemaphore_t_, _Value_)
        #define qCRSemInit(_qCRSemaphore_t_, _Value_)                   __qCRSemInit(_qCRSemaphore_t_, _Value_)  
/*qCoroutineSemaphoreWait(_qCRSemaphore_t_) 
qCRSemWait(_qCRSemaphore_t_)  

Carries out the "wait" operation on the semaphore. The wait operation causes 
the Co-routine to block while the counter is zero. When the counter reaches a 
value larger than zero, the protothread will continue.

Parameters:

    - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore
*/        
        #define qCoroutineSemaphoreWait(_qCRSemaphore_t_)               __qCRCodeStartBlock{ qCoroutineWaitUntil(__qCRSemCount(_qCRSemaphore_t_) > 0);  __qCRSemLock(_qCRSemaphore_t_); } __qCRCodeEndBlock    
        #define qCRSemWait(_qCRSemaphore_t_)                            qCoroutineSemaphoreWait(_qCRSemaphore_t_)
/*qCoroutineSemaphoreSignal(_qCRSemaphore_t_) 
qCRSemSignal(_qCRSemaphore_t_)

Carries out the "signal" operation on the semaphore. The signal operation increments
the counter inside the semaphore, which eventually will cause waiting Co-routines
to continue executing.

Parameters:

    - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore
*/     
        #define qCoroutineSemaphoreSignal(_qCRSemaphore_t_)             __qCRSemRelease(_qCRSemaphore_t_)
        #define qCRSemSignal(_qCRSemaphore_t_)                          __qCRSemRelease(_qCRSemaphore_t_)
/*qCoroutinePositionGet(qCRPosition_t _CRPos_)
qCRPositionGet(qCRPosition_t _CRPos_) 

Labels the current position and saves it to _CRPos_ so it can be later restored by qCoroutinePositionRestore
*/    
        #define qCoroutinePositionGet(_CRPos_)                          __qCR_GetPosition(_CRPos_)
        #define qCRPositionGet(_CRPos_)                                 __qCR_GetPosition(_CRPos_)
/*qCoroutinePositionRestore(qCRPosition_t _CRPos_)
qCRPositionRestore(qCRPosition_t _CRPos_) 

Restores the Co-Routine position saved in _CRPos_
*/   
        #define qCoroutinePositionRestore(_CRPos_)                      __qCR_RestoreFromPosition(_CRPos_)
        #define qCRPositionRestore(_CRPos_)                             __qCR_RestoreFromPosition(_CRPos_)
/*qCoroutinePositionReset(qCRPosition_t _CRPos_)
qCRPositionReset(qCRPosition_t _CRPos_) 

Resets the _CRPos_ variable to the begining of the Co-Routine
*/ 
        #define qCoroutinePositionReset(_CRPos_)                        __qCR_PositionReset(_CRPos_)
        #define qCRPositionReset(_CRPos_)                               __qCR_PositionReset(_CRPos_)
    
    #endif  
    
        typedef struct{ /*STimer defintion*/
            qConst qBool_t SR; /*The SET-RESET flag*/
            qConst qClock_t Start, TV; /*The time-epochs registers*/
        }qSTimer_t;
        qBool_t qSTimerSet(qSTimer_t *obj, const qTime_t Time);
        qBool_t qSTimerExpired(const qSTimer_t *obj);
        qBool_t qSTimerFreeRun(qSTimer_t *obj, const qTime_t Time);
        qClock_t qSTimerElapsed(const qSTimer_t *obj);
        qClock_t qSTimerRemaining(const qSTimer_t *obj);
        void qSTimerDisarm(qSTimer_t *obj);
        #define QSTIMER_INITIALIZER     {0, 0, 0}

     
        
#ifdef Q_MEMORY_MANAGER
/* This structure is the head of a memory pool. */
typedef struct {
    qSize_t BlockSize;	
    uint8_t NumberofBlocks;
    uint8_t *BlockDescriptors;
    uint8_t *Blocks;
}qMemoryPool_t;        
        
typedef enum {
    qMB_4B = 4, qMB_8B = 8, qMB_16B = 16, qMB_32B = 32, qMB_64B = 64, qMB_128B = 128,
    qMB_256B = 256, qMB_512B = 512, qMB_1024B = 1024, qMB_2048B = 2048, qMB_4096B = 4096, qMB_8192B = 8192 
}qMEM_size_t;



/*qMemoryHeapCreate(NAME, N, ALLOC_SIZE)

This macro creates and initialises a memory heap pool. The parameter alloc size
should be of type qMEM_size_t.

Parameters:

    - NAME : Name of the memory heap pool 
 
    - N : Number of memory blocks
 
    - ALLOC_SIZE: Size of each memory block
*/ 
#define qMemoryHeapCreate(NAME, N, ALLOC_SIZE)	uint32_t qMEM_AREA_##NAME[(N*ALLOC_SIZE)>>2]={0}; \
						uint8_t qMEM_BDES_##NAME[N]={0}; \
						qMemoryPool_t NAME; \
                                                NAME.BlockSize = ALLOC_SIZE; \
                                                NAME.NumberofBlocks =  N; \
                                                NAME.BlockDescriptors = &qMEM_BDES_##NAME[0]; \
                                                NAME.Blocks = (uint8_t*)&qMEM_AREA_##NAME[0] \
                                                


    void* qMemoryAlloc(qMemoryPool_t *obj, const qSize_t size);
    void qMemoryFree(qMemoryPool_t *obj, void* pmem);
#endif
    
#ifdef Q_RINGBUFFERS     
void qRBufferInit(qRBuffer_t *obj, void* DataBlock, const qSize_t ElementSize, const qSize_t ElementCount);
qBool_t qRBufferEmpty(qRBuffer_t *obj);
void* qRBufferGetFront(qRBuffer_t *obj);
qBool_t qRBufferPopFront(qRBuffer_t *obj, void *dest);
qBool_t qRBufferPush(qRBuffer_t *obj, void *data);
#endif

typedef volatile char qISR_Byte_t;
typedef volatile struct{
    qISR_Byte_t *pdata;
    volatile uint16_t index;
    volatile qBool_t ReadyFlag;
    qBool_t (*AcceptCheck)(const char);
    char (*PreChar)(const char);
    char EndByte;
    uint16_t MaxIndex;
}qISR_ByteBuffer_t;

#ifdef Q_TASK_DEV_TEST
void qSchedulePrintChain(void);
#endif

typedef struct{
    volatile uint16_t head;
    volatile uint16_t tail;
    volatile uint8_t *buffer;
    qSize_t length;
}qBSBuffer_t;

typedef void (*qPutChar_t)(void*, const char);
typedef char (*qGetChar_t)(void*);
void qSwapBytes(void *data, const qSize_t n);
void qOutputString(qPutChar_t fcn, void* storagep, const char *s, qBool_t AIP);
void qOutputRaw(qPutChar_t fcn, void* storagep, void *data, qSize_t n, qBool_t AIP);
void qInputRaw(qGetChar_t fcn, void* storagep, void *data, qSize_t n, qBool_t AIP);

/*qPrintString(fcn, storagep, s)
 
This macro is a Wrapper method to write a string througth fcn
  
Parameters:

    - fcn : The basic output byte function
    - storagep : The storage pointer passed to fcn
    - s: The string to be written
*/
#define qPrintString(fcn, storagep, s)          qOutputString(fcn, storagep, s, qFalse) 
#define qPrintRaw(fcn, storagep, data, n)       qOutputRaw(fcn, storagep, data, n, qFalse) 

/*Some utilities*/
char* qU32toX(uint32_t value, char *str, int8_t npos);
uint32_t qXtoU32(const char *s);
double qAtoF(const char *s);
int qAtoI(const char *s);
char* qItoA(int num, char* str, int base);
uint8_t qIsInf(float f);
qBool_t qIsNan(float f);
char* qFtoA(float num, char *str, uint8_t precision);

void qPrintXData(qPutChar_t fcn, void* storagep, void *data, qSize_t n);

/*qSetDebugFcn(fcn)

This macro set the output method for debug/trace messages.

Parameters:

    - fcn : The basic output byte function

*/ 
#define qSetDebugFcn(fcn)   __qDebugOutputFcn = fcn
extern qPutChar_t __qDebugOutputFcn;

#define __qSTRINGIFY(x) #x
#define __qTOSTRING(x) __qSTRINGIFY(x)
#define __qAT() "[" __FILE__ ":" __qTOSTRING(__LINE__) "] " 

#define QT_BIN   2
#define QT_OCT   8
#define QT_DEC   10
#define QT_HEX   16
#define QT_FPT   254

#ifdef Q_TRACE_VARIABLES
    extern char qDebugTrace_Buffer[Q_DEBUGTRACE_BUFSIZE];
    /*qTraceVar(Pointer, DISP_TYPE_MODE)

    Trace a variable (up to 32bit data)

    Parameters:

        - Var : The target variable
        - DISP_TYPE_MODE: Visualization mode. It must be one of the following parameters:
                        > QT_BIN : Binary       (value is always considered unsigned)
                        > QT_OCT : Octal        (value is always considered unsigned)
                        > QT_DEC : Decimal
                        > QT_HEX : Hexadecimal  (value is always considered unsigned)  
                        > QT_FTP : Floating-Point (Up to 10 digits of precision)    

    Note: the Debug/Trace function must be previously defined with qSetDebugFcn
    */
    

    #define qTraceVar(Var, DISP_TYPE_MODE)  if(__qDebugOutputFcn!=NULL){ \
                                                qPrintString(__qDebugOutputFcn, NULL, __qAT() __qTOSTRING(Var) "="); \
                                                qPrintString(__qDebugOutputFcn, NULL,  (DISP_TYPE_MODE==QT_FPT)? qFtoA(Var, qDebugTrace_Buffer, 10) : qItoA(Var, qDebugTrace_Buffer, DISP_TYPE_MODE) ); \
                                                qPrintString(__qDebugOutputFcn, NULL, "\r\n"); \
                                            }\
                                            
    #define qTraceVariable(Var, DISP_TYPE_MODE) qTraceVar(Var, DISP_TYPE_MODE)
#else
    #define qTraceVar(Var, DISP_TYPE_MODE)
    #define qTraceVariable(Var, DISP_TYPE_MODE)
#endif
/*qTraceMem(Pointer, BlockSize)
 
Trace memory from the specified address (HEX outptu)
  
Parameters:

    - Pointer : The target memory address
    - Size: Number of bytes

Note: the Debug/Trace function must be previously defined with qSetDebugFcn
*/
#define qTraceMem(Pointer, BlockSize)       if(__qDebugOutputFcn!=NULL){ \
                                                qPrintString(__qDebugOutputFcn, NULL, __qAT() __qTOSTRING(Pointer) "="); \
                                                qPrintXData(__qDebugOutputFcn, NULL, (void*)Pointer, BlockSize); \
                                            } \
                                            
#define qTraceMemory(Pointer, BlockSize)    qTraceMem(Pointer, BlockSize)

typedef struct{
    char *ptr2Match;
    qSize_t length2Match;
    volatile qSize_t contMatch;
    volatile qBool_t Flag;
}qResponseHandler_t; 
#define qRespHandler_t  qResponseHandler_t
#define QRESPONSE_INITIALIZER   {NULL, 0, 0, qFalse}
void qResponseInitialize(qResponseHandler_t *obj);   
qBool_t qResponseReceived(qResponseHandler_t *obj, const char *ptr, qSize_t n);
qBool_t qResponseISRHandler(qResponseHandler_t *obj, const char rxchar);

#ifdef Q_BYTE_SIZED_BUFFERS
    size_t qBSBuffer_Count(qBSBuffer_t const* obj);
    qBool_t qBSBuffer_IsFull(qBSBuffer_t const* obj);
    qBool_t qBSBuffer_Empty(qBSBuffer_t const *obj);
    uint8_t qBSBuffer_Peek(qBSBuffer_t const *obj);
    qBool_t qBSBuffer_Get(qBSBuffer_t *obj, uint8_t *dest);
    qBool_t qBSBuffer_Read(qBSBuffer_t *obj, void *dest, const qSize_t n);
    qBool_t qBSBuffer_Put(qBSBuffer_t *obj, const uint8_t data);
    void qBSBuffer_Init(qBSBuffer_t *obj, volatile uint8_t *buffer, const qSize_t length);
#endif
    
#ifdef Q_ISR_BUFFERS    
    qBool_t qISR_ByteBufferInit(qISR_ByteBuffer_t *obj, qISR_Byte_t *pData, qSize_t size, const char EndChar, qBool_t (*AcceptCheck)(const char), char (*PreChar)(const char));
    qBool_t qISR_ByteBufferFill(qISR_ByteBuffer_t *obj, const char newChar);
    qBool_t qISR_ByteBufferGet(qISR_ByteBuffer_t *obj, void *dest);
#endif
#ifdef	__cplusplus
}
#endif

#endif	/* H_QuarkTS */

