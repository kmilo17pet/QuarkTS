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
    typedef volatile unsigned long qClock_t;
    typedef unsigned char qPriority_t;
    typedef unsigned char qIteration_t;
    typedef unsigned char qState_t;
    typedef unsigned char qBool_t;
    

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
        qTrigger_t Trigger;
        void *UserData;
        void *EventData;
        qBool_t FirstCall;
    }qEvent_t;
    
    typedef void (*qTaskFcn_t)(qEvent_t);
    
    typedef struct{
    	volatile unsigned char TimedTaskRun;
        volatile unsigned char InitFlag;
        volatile unsigned char AsyncRun;
        volatile unsigned char State;
        volatile unsigned char IgnoreOveruns;
    }qTaskFlags_t;

    struct _qTask_t{
        void *UserData,*AsyncData;
        qClock_t Interval, TimeElapsed;
        qIteration_t Iterations;
        unsigned long Cycles;
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
    	unsigned char Init;
        unsigned char FCallIdle;
        unsigned char ReleaseSched;
        unsigned char FCallReleased;
    }qTaskCoreFlags_t;

    
    typedef struct{
        qTaskFcn_t IDLECallback;    
        qTaskFcn_t ReleaseSchedCallback;
        qTime_t Tick;
        qEvent_t EventInfo;
        qTask_t *First;
        volatile qTaskCoreFlags_t Flag;
        volatile qQueueStack_t *QueueStack;
        unsigned char QueueSize, QueueIndex;
        volatile unsigned char NotSafeQueue;
        #ifdef QSTIMER
        volatile qClock_t epochs;
        #endif
    }QuarkTSCoreData_t;
    extern volatile QuarkTSCoreData_t QUARKTS;

    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack);
    void _qISRHandler(void);
    int _qCreateTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    void _qStart(void);
    int _qEnqueueTaskEvent(qTask_t *TasktoQueue, void* eventdata);
    void _qSendEvent(qTask_t *Task, void* eventdata);
    void _qSetTime(qTask_t *Task, qTime_t Value);
    void _qSetIterations(qTask_t *Task, qIteration_t Value);
    void _qSetPriority(qTask_t *Task, qPriority_t Value);
    void _qSetCallback(qTask_t *Task, qTaskFcn_t CallbackFcn);
    void _qEnableDisable(qTask_t *Task, unsigned char Value);
    void _qSetUserData(qTask_t *Task, void* arg);
    void _qClearTimeElapse(qTask_t *Task);
    
    #define qSetup(ISRTick, IDLE_Callback, QueueSize)                                   volatile qQueueStack_t _qQueueStack[QueueSize]; _qInitScheduler(ISRTick, IDLE_Callback, _qQueueStack, QueueSize)
    #define qISRHandler()                                                               _qISRHandler()
    #define qCreateTask(TASK, CALLBACK, PRIORITY, TIME, NEXEC, INITSTATE, USERDATA)     _qCreateTask(&TASK, CALLBACK, (qPriority_t)PRIORITY, (qTime_t)TIME, (qIteration_t)NEXEC, INITSTATE, (void*)USERDATA)
    #define qCreateEventTask(TASK, CALLBACK, PRIORITY, USERDATA)                        _qCreateTask(&TASK, CALLBACK, (qPriority_t)PRIORITY, TIME_INMEDIATE, SINGLESHOT, 0, (void*)USERDATA)  
    #define qSchedule()                                                                 _qStart()
    #define qSendEvent(TASK, EVENTDATA)                                                 _qSendEvent(&TASK, (void*)EVENTDATA)
    #define qQueueEvent(TASK, EVENTDATA)                                                _qEnqueueTaskEvent(&TASK, (void*)EVENTDATA)//_qEnqueueTaskEvent(&TASK, (void*)EVENTDATA)

    #define qSetIdleTask(IDLE_Callback)                                                 QUARKTS.IDLECallback = IDLE_Callback

    #define qSetTime(TASK, VALUE)                                                       _qSetTime(&TASK,  (qTime_t)VALUE)  
    #define qSetIterations(TASK, VALUE)                                                 _qSetIterations(&TASK, (qIteration_t)VALUE) 
    #define qSetSpec(TASK, TVALUE, IVALUE)                                              _qSetTime(&TASK, (qTime_t)TVALUE); \
                                                                                        _qSetIterations(&TASK, (qIteration_t)IVALUE) 

    #define qSetPriority(TASK,VALUE)                                                    _qSetPriority(&TASK, (qPriority_t)VALUE)   
    #define qEnable(TASK)                                                               _qEnableDisable(&TASK, 1)  
    #define qDisable(TASK)                                                              _qEnableDisable(&TASK, 0) 
    #define qSetCallback(TASK, CALLBACK)                                                _qSetCallback(&TASK, CALLBACK) 
    #define qSetUserData(TASK, USERDATA)                                                _qSetUserData(&TASK, (void*)USERDATA)
    #define qClearTimeElapsed(TASK)                                                     _qClearTimeElapse(TASK)
    #define qIsEnabled(TASK)                                                            (TASK.Flag.State)
    #define qGetCycles(TASK)                                                            (TASK.Cycles)
    #define qIgnoreOverruns(TASK, _TF_)                                                 (TASK.Flag.IgnoreOveruns = _TF_!=0)            

    #define qReleaseSchedule()                                                          QUARKTS.Flag.ReleaseSched = 1
    #define qSetReleaseSchedCallback(RELEASE_Callback)                                  QUARKTS.ReleaseSchedCallback = RELEASE_Callback
    
    #if !defined(QPRIORITY_FIFO_QUEUE) && !defined(QSIMPLE_FIFO_QUEUE) 
        #define QPRIORITY_FIFO_QUEUE
    #endif

    
    typedef enum state {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;

    struct _qSM_t{
        qSM_Status_t (*NextState)(volatile struct _qSM_t*);
        qSM_Status_t (*PreviousState)(volatile struct _qSM_t*);
        qSM_Status_t PreviousReturnStatus;
        void *UserData;
    };

    #define qSM_t volatile struct _qSM_t
    typedef qSM_Status_t (*qSM_State_t)(qSM_t*);

    int _qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_State_t SuccessState, qSM_State_t FailureState, qSM_State_t UnexpectedState);
    void _qStateMachine_Run(qSM_t *obj, void *UserData);

    #define qStateMachine_Init(OBJ, INIT_STATE, SUCCESS_STATE, FAILURE_STATE, UNEXPECTED_STATE)   _qStateMachine_Init(&OBJ, INIT_STATE, SUCCESS_STATE, FAILURE_STATE, UNEXPECTED_STATE) 
    #define qStateMachine_Run(OBJ, USERDATA)   _qStateMachine_Run(&OBJ, USERDATA) 
    
    #ifdef _QUARKTS_CR_DEFS_    
        #define $qCRStart               $qPersistent  $qTaskInitState ;  $qTaskCheckPCJump($qTaskPCVar) $RestoreFromBegin ; $qCRKeep
        #define $qCRYield               { $qTaskSaveState ; $qTaskYield  $RestoreAfterYield; }
        #define $qCRRestart             { $qTaskInitState ; $qTaskYield }
        #define $qCR_wu_Assert(_cond_)  { $qTaskSaveState ; $RestoreAfterYield ; $qAssert(_cond_) $qTaskYield }

        #define qCoroutineBegin                         $qCRStart
        #define qCoroutineYield                         $qCRYield            
        #define qCoroutineEnd                           $qCRDispose
        #define qCoroutineRestart                       $qCRRestart        
        #define qCoroutineWaitUntil(_condition_)        $qCR_wu_Assert(_condition_)
    #endif
    #ifdef QSTIMER
        typedef struct{
            unsigned char SR;
            qClock_t Start, TV;
        }qSTimer_t;

        int _qSTimerSet(qSTimer_t *obj, qTime_t Time);
        unsigned char _qSTimerExpired(qSTimer_t *obj);
        #define qSTimerSet(OBJ, Time)   _qSTimerSet(&OBJ, (qTime_t)Time)
        #define qSTimerExpired(OBJ)   _qSTimerExpired(&OBJ)
        #define qSTimerDisarm(OBJ)      (OBJ.SR = 0)
    #endif
    
#ifdef	__cplusplus
}
#endif

#endif	/* H_QuarkTS */

