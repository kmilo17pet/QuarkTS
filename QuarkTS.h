/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Scheduler for low-range MCUs
 *  Version : 2.1
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
    
    
    #ifndef NULL
    #define NULL ((void*)0)
    #endif
    

    typedef enum {byTimeElapsed, byPriority, byQueueExtraction, byAsyncEvent} qTrigger_t;
    typedef float qTime_t;
    typedef volatile unsigned long qClock_t;
    typedef unsigned char qPriority_t;
    typedef unsigned char qIteration_t;
    typedef unsigned char qState_t;
    
    #define LOWEST_Priority     (qPriority_t)(0)
    #define MEDIUM_Priority     (qPriority_t)(127)
    #define HIGH_Priority       (qPriority_t)(255)
    #define PERIODIC            ((qIteration_t)-1)
    #define SINGLESHOT          ((qIteration_t)1)
    #define TIME_INMEDIATE      ((qTime_t)(0))
    
    #define ENABLE              0x01
    #define DISABLE             0x00
    
    typedef struct{
        qTrigger_t Trigger;
        void *UserData;
        void *EventData;
        unsigned char FirstCall;
    }qEvent_t;
    
    typedef void (*qTaskFcn_t)(qEvent_t);
    
    typedef struct{
        unsigned TimedTaskRun:8;
        unsigned InitFlag:1;
        unsigned AsyncRun:1;
        unsigned State:1;
    }qTaskFlags_t;
    
    struct _qTask_t{
        void *UserData,*AsyncData;
        qClock_t Interval, TimeElapsed;
        qIteration_t Iterations;
        qPriority_t Priority;
        qTaskFcn_t Callback;
        volatile qTaskFlags_t Flag;
        volatile struct _qTask_t *Next;
    };
    #define qTask_t     volatile struct _qTask_t

    typedef struct{
        qTask_t *Task;
        void *QueueData;
    }qQueueStack_t;
    
    typedef volatile struct{
        qTaskFcn_t IDLECallback;    
        qTime_t Tick;
        qEvent_t EventInfo;
        qTask_t *First;
        unsigned char Init;
        volatile qQueueStack_t *QueueStack;
        unsigned char QueueSize;
        unsigned char QueueIndex;
    }QuarkTSCoreData_t;
   
    extern QuarkTSCoreData_t QUARKTS;

    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack);
    void _qISRHandler(void);
    int _qCreateTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    void _qStart(void);
    int _qEnqueueTaskEvent(qTask_t *TasktoQueue, void* eventdata);
    
    #define qSetup(ISRTick, IDLE_Callback, QueueSize)                                    volatile qQueueStack_t _qQueueStack[QueueSize]; _qInitScheduler(ISRTick, IDLE_Callback, _qQueueStack, QueueSize)
    #define qISRHandler()                                                               _qISRHandler()
    #define qCreateTask(TASK, CALLBACK, PRIORITY, TIME, NEXEC, INITSTATE, USERDATA)     _qCreateTask(&TASK, CALLBACK, (qPriority_t)PRIORITY, (qTime_t)TIME, (qIteration_t)NEXEC, INITSTATE, (void*)USERDATA)
    #define qCreateEventTask(TASK, CALLBACK, PRIORITY, USERDATA)                        _qCreateTask(&TASK, CALLBACK, (qPriority_t)PRIORITY, TIME_INMEDIATE, SINGLESHOT, 0, (void*)USERDATA)  
    #define qSchedule()                                                                 _qStart()
    #define qSendEvent(TASK, EVENTDATA)                                                 TASK.Flag.AsyncRun = 1; TASK.AsyncData = (void*)EVENTDATA  
    #define qQueueEvent(TASK, EVENTDATA)                                                _qEnqueueTaskEvent(&TASK, (void*)EVENTDATA)
    #define qSetIdleTask(IDLE_Callback)                                                 QUARKTS.IDLECallback = IDLE_Callback
    #define qChangePeriod(TASK, VALUE)                                                  TASK.Interval = (qClock_t)(VALUE/QUARKTS.Tick)
    #define qChangeIterations(TASK, VALUE)                                              TASK.Iterations = VALUE
    #define qChangePriority(TASK,VALUE)                                                 QUARKTS.Init = 0; TASK.Priority = VALUE 
    #define qEnable(TASK)                                                               TASK.Flag.State = 1
    #define qDisable(TASK)                                                              TASK.Flag.State = 0   
#ifdef	__cplusplus
}
#endif

#endif	/* PTASKSCHEDULER_H */

