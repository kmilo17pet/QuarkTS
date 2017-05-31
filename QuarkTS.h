/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Task Scheduler for low-range MCUs
 *  Version : 4.2
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

    #define qTrue   0x01u
    #define qFalse  0x00u
    #define qError  0xFFu
    #define qEnabled              (qTrue)
    #define qDisabled             (qFalse)
    #define qLINK                 (qTrue)
    #define qUNLINK               (qFalse)  
    
    #ifdef _QUARKTS_CR_DEFS_
        typedef int32_t _qTaskPC_t;
        #define qCR_PCInitVal   (-0x7FFE)           
        #define __qCRKeep                _qCR_BEGIN_:   
        #define __qPersistent            static _qTaskPC_t
        #define __qTaskProgress          __LINE__
        #define __qAssert(_COND_)        if(!(_COND_))
        #define __qTaskPCVar             _qCRTaskState_
        #define __qSetPC(_VAL_)          __qTaskPCVar = _VAL_
        #define __qTaskSaveState         __qSetPC(__qTaskProgress) 
        #define __qTaskInitState         __qSetPC(qCR_PCInitVal) 
        #define __qTaskCheckPCJump(_PC_) switch(_PC_){      
        #define __qExit                  return
        #define __qTaskYield             __qExit;
        #define __qCRDispose             goto _qCR_BEGIN_;}__qExit
        #define __qRestorator(_VAL_)     case (_qTaskPC_t)_VAL_:            
        #define __RestoreAfterYield      __qRestorator(__qTaskProgress)
        #define __RestoreFromBegin       __qRestorator(qCR_PCInitVal)
    #endif

    typedef enum {_Q_NO_VALID_TRIGGER_, byTimeElapsed, byPriority, byQueueExtraction, byAsyncEvent, byRBufferPop, byRBufferFull, byRBufferCount} qTrigger_t;
    typedef float qTime_t;
    typedef uint32_t qClock_t;
    typedef uint8_t qPriority_t;
    typedef uint8_t qIteration_t;
    typedef uint8_t qState_t;
    typedef uint8_t qBool_t;
    

    #define LOWEST_Priority     (qPriority_t)(0x00u)
    #define MEDIUM_Priority     (qPriority_t)(0x7Fu)
    #define HIGH_Priority       (qPriority_t)(0xFEu)
    #define PERIODIC            ((qIteration_t)-1)
    #define INDEFINITE          ((qIteration_t)-1)
    #define SINGLESHOT          ((qIteration_t)1)
    #define TIME_INMEDIATE      ((qTime_t)(0))
          
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
    	volatile uint8_t InitFlag, AsyncRun, Enabled, RBAutoPop, RBFull, RBCount;
    }qTaskFlags_t;
       
    typedef enum {qWaiting = 0, qReady = 1, qRunning = 2} qTaskState_t;

    typedef struct{
        volatile uint8_t *data; /* block of memory or array of data */
        volatile uint16_t ElementSize;      /* how many bytes for each chunk */
        volatile uint16_t Elementcount;     /* number of chunks of data */
        volatile uint16_t head; /* where the writes go */
        volatile uint16_t tail; /* where the reads come from */
    }qRBuffer_t;
    
    struct _qTask_t{
        void *UserData,*AsyncData;
        volatile qClock_t Interval, ClockStart;
        qIteration_t Iterations;
        uint32_t Cycles;
        qPriority_t Priority;
        qTaskFcn_t Callback;
        volatile qTaskFlags_t Flag;
        volatile struct _qTask_t *Next;
        qRBuffer_t *RingBuff;
    };
    #define qTask_t volatile struct _qTask_t
             
    typedef struct{
        qTask_t *Task;
        void *QueueData;
    }qQueueStack_t;

    typedef struct{
    	uint8_t Init, FCallIdle, ReleaseSched, FCallReleased;
        uint32_t IntFlags;
    }qTaskCoreFlags_t;
   
    typedef struct{
        qTaskFcn_t IDLECallback;    
        qTaskFcn_t ReleaseSchedCallback;
        qTime_t Tick;
        qEvent_t EventInfo;
        qTask_t *First;
        uint32_t (*I_Disable)(void);
        void (*I_Restorer)(uint32_t);
        volatile qTaskCoreFlags_t Flag;
        volatile qQueueStack_t *QueueStack;
        uint8_t QueueSize;
        int16_t QueueIndex;
    }QuarkTSCoreData_t;
    extern volatile QuarkTSCoreData_t QUARKTS;
    extern volatile qClock_t _qSysTick_Epochs_;
    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack);
    void qSchedulerSetInterruptsED(void (*Restorer)(uint32_t), uint32_t (*Disabler)(void));
    int qSchedulerAddxTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    int qSchedulerAddeTask(qTask_t *Task, qTaskFcn_t Callback, qPriority_t Priority, void* arg);
    void qSchedulerRun(void);
    int qTaskQueueEvent(qTask_t *Task, void* eventdata);  
    void qTaskSendEvent(qTask_t *Task, void* eventdata);
    
    typedef enum{RB_AUTOPOP, RB_FULL, RB_COUNT}qRBLinkMode_t;
    
    int qTaskLinkRBuffer(qTask_t *Task, qRBuffer_t *RingBuffer, qRBLinkMode_t Mode, uint8_t arg);
    
    void qTaskSetTime(qTask_t *Task, qTime_t Value);
    void qTaskSetIterations(qTask_t *Task, qIteration_t Value);
    void qTaskSetPriority(qTask_t *Task, qPriority_t Value);
    void qTaskSetCallback(qTask_t *Task, qTaskFcn_t CallbackFcn);
    void qTaskSetState(qTask_t *Task, qState_t State);
    void qTaskSetUserData(qTask_t *Task, void* arg);
    void qTaskClearTimeElapsed(qTask_t *Task);

    uint32_t qTaskGetCycles(qTask_t *Task);
    
    #define _Q_ENTER_CRITICAL()                                                          if(QUARKTS.I_Disable != NULL) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable()
    #define _Q_EXIT_CRITICAL()                                                           if(QUARKTS.I_Restorer != NULL) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags)
    #define _Q_TASK_DEADLINE_REACHED(_TASK_)                                             ( ((_qSysTick_Epochs_ - _TASK_->ClockStart)>=_TASK_->Interval) || _TASK_->Interval == TIME_INMEDIATE)
    #define _Q_TASK_HAS_PENDING_ITERS(_TASK_)                                           (_TASK_->Iterations>0 || _TASK_->Iterations==PERIODIC)
    
/*void qSetup(qTime_t ISRTick, qTaskFcn_t IDLE_Callback, unsigned char QueueSize)
    
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
    #define qSchedulerSetup(ISRTick, IDLE_Callback, QueueSize)                                   volatile qQueueStack_t _qQueueStack[QueueSize]; _qInitScheduler(ISRTick, IDLE_Callback, _qQueueStack, QueueSize)
    /*
void qSchedulerSysTick(void)

Feed the scheduler system tick. This call is mandatory and must be called once
inside the dedicated timer interrupt service routine (ISR). 
*/    
    #define qSchedulerSysTick()                                                               (_qSysTick_Epochs_++)


/*void qSchedulerSetIdleTask(qTask_t Identifier, qTaskFcn_t IDLE_Callback)

Establish the IDLE Task Callback

Parameters:

    - IDLE_Callback : A pointer to a void callback method with a qEvent_t 
                      parameter as input argument.
*/
    #define qSchedulerSetIdleTask(IDLE_Callback)                                                 (QUARKTS.IDLECallback = IDLE_Callback)

/*
unsigned char qTaskIsEnabled(qTask_t Identifier)

Retrieve the enabled/disabled state

Parameters:

    - Identifier : The task node identifier.

Return value:

    True if the task in on Enabled state, otherwise returns false.
*/    
    #define qTaskIsEnabled(TASK)                                                            ((qBool_t)((TASK)->Flag.Enabled))

/*void qReleaseSchedule(void)

Disables the QuarkTS scheduling. The main thread will continue after the
qSchedule() call.
*/
    #define qSchedulerRelease()                                                          QUARKTS.Flag.ReleaseSched = qTrue
/*void qSetReleaseSchedCallback(qTaskFcn_t Callback)

Set/Change the scheduler release callback function

Parameters:
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
    #define qSchedulerSetReleaseCallback(RELEASE_Callback)                                  QUARKTS.ReleaseSchedCallback = RELEASE_Callback
      
    typedef enum {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;
     
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
        True when  <Previous State> !=  <Current State>
        */
        qBool_t StateJustChanged;
        /* Data:
        State-machine associated data
         */
        void *Data;
        struct { /*hide this members*/
            void (*__Failure)(qSM_t*);
            void (*__Success)(qSM_t*);
            void (*__Unexpected)(qSM_t*);  
        }_;
    };    
    typedef qSM_Status_t (*qSM_State_t)(qSM_t*);
    typedef void (*qSM_ExState_t)(qSM_t*);
    int qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);
    void qStateMachine_Run(qSM_t *obj, void *Data);

    
    #ifdef _QUARKTS_CR_DEFS_    
        #define __qCRStart                               __qPersistent  __qTaskInitState ;  __qTaskCheckPCJump(__qTaskPCVar) __RestoreFromBegin ; __qCRKeep
        #define __qCRYield                               { __qTaskSaveState ; __qTaskYield  __RestoreAfterYield; }
        #define __qCRRestart                             { __qTaskInitState ; __qTaskYield }
        #define __qCR_wu_Assert(_cond_)                  { __qTaskSaveState ; __RestoreAfterYield ; __qAssert(_cond_) __qTaskYield }
/*qCoroutineBegin{
  
}qCoroutineEnd;

Defines a Coroutine segment. Only one segment is allowed inside a task; 
The qCoroutineBegin statement is used to declare the starting point of 
a Coroutine. It should be placed at the start of the function in which the 
Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
It must always be used together with a matching qCoroutineBegin statement.
*/
        #define qCoroutineBegin                         __qCRStart
/*
This statement is only allowed inside a Coroutine segment. qCoroutineYield 
return the CPU control back to the scheduler but saving the execution progress. 
With the next task activation, the Coroutine will resume the execution after 
the last 'qCoroutineYield' statement.
*/
        #define qCoroutineYield                         __qCRYield          
/*qCoroutineBegin{
  
}qCoroutineEnd;

Defines a Coroutine segment. Only one segment is allowed inside a task; 
The qCoroutineBegin statement is used to declare the starting point of 
a Coroutine. It should be placed at the start of the function in which the 
Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
It must always be used together with a matching qCoroutineBegin statement.
*/    
        #define qCoroutineEnd                           __qCRDispose
/*This statement cause the running Coroutine to restart its execution at the 
place of the qCoroutineBegin statement.
*/
        #define qCoroutineRestart                       __qCRRestart  
/*qCoroutineWaitUntil(_CONDITION_)

Yields until the logical condition being true
*/    
        #define qCoroutineWaitUntil(_condition_)        __qCR_wu_Assert(_condition_)
    #endif
    
    
        typedef struct{
            qBool_t SR;
            qClock_t Start, TV;
        }qSTimer_t;
        qBool_t qSTimerSet(qSTimer_t *obj, qTime_t Time);
        qBool_t qSTimerExpired(qSTimer_t *obj);
        qBool_t qSTimerFreeRun(qSTimer_t *obj, qTime_t Time);
        qClock_t qSTimerElapsed(qSTimer_t *obj);
        qClock_t qSTimerRemaining(qSTimer_t *obj);
        void qSTimerDisarm(qSTimer_t *obj);
        #define QSTIMER_INITIALIZER     {0, 0, 0}




#define QMEMORY_MANAGER       
        
#ifdef QMEMORY_MANAGER
/* This structure is the head of a memory pool. */
typedef struct {
    uint16_t BlockSize;	
    uint8_t NumberofBlocks;
    uint8_t *BlockDescriptors;
    uint8_t *Blocks;
}qMemoryPool_t;        
        
typedef enum {		/*ported from uSmartX*/
    MEMBLOCK_4_BYTE	= (1 << 2),	/*!< Memory block contains 4 bytes */
    MEMBLOCK_8_BYTE	= (1 << 3),	/*!< Memory block contains 8 bytes */
    MEMBLOCK_16_BYTE	= (1 << 4),	/*!< Memory block contains 16 bytes */
    MEMBLOCK_32_BYTE	= (1 << 5),	/*!< Memory block contains 32 bytes */
    MEMBLOCK_64_BYTE	= (1 << 6),	/*!< Memory block contains 64 bytes */
    MEMBLOCK_128_BYTE	= (1 << 7),	/*!< Memory block contains 128 bytes */
    MEMBLOCK_256_BYTE	= (1 << 8),	/*!< Memory block contains 256 bytes */
    MEMBLOCK_512_BYTE	= (1 << 9),	/*!< Memory block contains 512 bytes */
    MEMBLOCK_1024_BYTE	= (1 << 10),	/*!< Memory block contains 1024 bytes */
    MEMBLOCK_2048_BYTE	= (1 << 11),    /*!< Memory block contains 2048 bytes */
    MEMBLOCK_4096_BYTE	= (1 << 12),    /*!< Memory block contains 4096 bytes */
    MEMBLOCK_8192_BYTE	= (1 << 13)     /*!< Memory block contains 8192 bytes */
}qMEM_size_t;



/*qMemoryHeapCreate(NAME, N, ALLOC_SIZE)

This macro creates and initilises a memory heap pool. The parameter alloc size
should be of type qMEM_size_t.

Parameters:

    - NAME : Name of the memory heap pool 
 
    - N : Number of memory blocks
 
    - ALLOC_SIZE: Size of each memory block
*/ 
#define qMemoryHeapCreate(NAME, N, ALLOC_SIZE)	uint32_t qMEM_AREA_##NAME[(N*ALLOC_SIZE)>>2]={0}; \
						uint8_t qMEM_DES##NAME[N]={0}; \
						qMemoryPool_t NAME; \
                                                NAME.BlockSize = ALLOC_SIZE; \
                                                NAME.NumberofBlocks =  N; \
                                                NAME.BlockDescriptors = &qMEM_DES##NAME[0]; \
                                                NAME.Blocks = (uint8_t*)&qMEM_AREA_##NAME[0] \
                                                


    void* qMemoryAlloc(qMemoryPool_t *obj, uint16_t size);
    void qMemoryFree(qMemoryPool_t *obj, void* pmem);
#endif
    
    


void qRBufferInit(qRBuffer_t *obj, void* DataBlock, uint16_t ElementSize, uint16_t ElementCount);
qBool_t qRBufferEmpty(qRBuffer_t *obj);
void* qRBufferGetFront(qRBuffer_t *obj);
void* qRBufferPopFront(qRBuffer_t *obj);
qBool_t qRBufferPush(qRBuffer_t *obj, void *data);

    #ifdef __XC8
        #pragma warning disable 1471   //disable warning: (1471) indirect function call via a NULL pointer ignored
    #endif


#ifdef	__cplusplus
}
#endif

#endif	/* H_QuarkTS */

