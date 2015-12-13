/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Scheduler for low-range MCUs
 *  Version : 1.8
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
        #define NULL ((void *)0)
#endif       
    
typedef enum {LOWEST_Priority=0, MEDIUM_Priority=30, HIGH_Priority=61} qPriorityValue_t;
typedef enum {byPriority, byTimeElapse, byAsyncEvent, byQueueEvent} qTrigger_t;
typedef enum {qQueueSuccess, qQueueError, qNoValidTask=0xFF} qReturnValue_t;
typedef enum {qQueueEND_Empty=0xFF} qCoreValue_t;
typedef unsigned int  qIter_t;

#define PERIODIC            ((qIter_t)-1)
#define SINGLESHOT          ((qIter_t)1)

#define TIME_INMEDIATE      ((qTime_t)(0))

#ifndef ENABLE
#define ENABLE 1
#endif
#ifndef DISABLE
#define DISABLE 0
#endif


typedef unsigned char qTaskID_t;
typedef unsigned char qPriority_t;
typedef unsigned long qPeriod_t;
typedef unsigned long qClock_t;
typedef unsigned char qFlag_t;
typedef float qTime_t;

typedef struct{
    unsigned char FirstCall, LastTaskID, Trigger;
    void *UserData, *TaskData;
}qEventInfo_t;

typedef void (*qTask)(qEventInfo_t);

typedef struct{
    volatile qTaskID_t *TaskID;
    void *UserData;
}qQueueStack_t;

typedef struct{
    unsigned Enable:1;
    unsigned TimedTaskRun:8;
    unsigned AsyncRun:1;
    unsigned FcnInitFlag:1;
}qTaskFlags_t;

typedef struct{
    qTask Function;
    qPeriod_t Period;
    volatile qClock_t TimeElapsed; 
    qPriority_t Priority;
    volatile qTaskFlags_t Flags;
    volatile qTaskID_t *idptr;
    volatile qIter_t Iterations, N;
    void* TaskData;
}qTaskStack_t;

typedef struct{
    unsigned Init:1;
    unsigned OnISRCheck:1;
}qCoreFlags_t;

typedef struct{
    volatile qTaskStack_t *TaskStack;
    volatile qQueueStack_t *QueueStack;
    qTask IdleTaskCallback;
    qTime_t KernelTick;
    unsigned char QueueIndex;
    unsigned char MaxTasks;
    unsigned char QueueSize;
    unsigned char TaskCnt;
    qCoreFlags_t Flag;
    volatile unsigned char iISR;
    volatile qEventInfo_t EventData;
}qCoreData_t;
extern volatile qCoreData_t QuarkTS;


void __qInit(volatile qTaskStack_t *T_Stack, unsigned char Size_T_Stack, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack, qTime_t ISRTickPeriod, qTask IdleTask_CallbackFcn);
void __qISRHandler(void);
void __qStartScheduler(void);
qReturnValue_t __qQueueTaskEvent(volatile qTaskID_t *TaskID, void* Userdata);
void __qSendEvent(qTaskID_t TaskID);
void __qSetTaskState(qTaskID_t TaskID, unsigned char state);
void __qChangeParameter(qTaskID_t TaskID, qPriority_t NewPriority, qTime_t NewTimeInSec, qIter_t n);
void __qSetIdleTask(qTask Idle_CallbackFcn);
qReturnValue_t __qTaskAttach(volatile qTaskID_t *id, qTask Task_CallbackFcn, qPriorityValue_t Priority, qTime_t TimeInSec, qIter_t n, unsigned char Enable, void* data);

#define qNewTaskID(TASK_FCN)                                                                volatile qTaskID_t qID_##TASK_FCN
#define qSetup(TSIZE, QSIZE, ISRTickPeriod, IdleTaskFcn)                                    volatile qTaskStack_t __qTSTACK[TSIZE]; \
                                                                                            volatile qQueueStack_t __qQSTACK[QSIZE]; \
                                                                                            __qInit(__qTSTACK, TSIZE, __qQSTACK, QSIZE, (qTime_t)ISRTickPeriod, IdleTaskFcn) \
                                                                
#define qISRHandler()                                                                       __qISRHandler()
#define qSchedule()                                                                         __qStartScheduler()
#define qSetIdleTask(IdleCallback_)                                                         __qSetIdleTask(IdleCallback_)
#define qCreateTask(TaskCallback_, Priority_, TimeInSec_, Iterations_, Enable_, Data_)      __qTaskAttach(&qID_##TaskCallback_, TaskCallback_, (qPriorityValue_t)Priority_, (qTime_t)TimeInSec_, Iterations_, Enable_, Data_)
#define qCreateEventTask(TaskCallback_, Priority_, Data_)                                   __qTaskAttach(&qID_##TaskCallback_, TaskCallback_, (qPriorityValue_t)Priority_, TIME_INMEDIATE, SINGLESHOT, DISABLE, Data_)   
#define qQueueEvent(Task_, UserDataptr_)                                                    __qQueueTaskEvent(&qID_##Task_, (void*)UserDataptr_)
#define qSendEvent(Task_)                                                                   __qSendEvent(qID_##Task_)
#define qEnableTask(Task_)                                                                  __qSetTaskState(qID_##Task_, 1)
#define qDisableTask(Task_)                                                                 __qSetTaskState(qID_##Task_, 0)
#define qChangeTime(Task_, NewTime_)                                                        __qChangeParameter(qID_##Task_, QuarkTS.TaskStack[qID_##Task_].Priority, NewTime_, QuarkTS.TaskStack[qID_##Task_].N)                           
#define qChangePriority(Task_, NewPriority_)                                                __qChangeParameter(qID_##Task_, NewPriority_, QuarkTS.TaskStack[qID_##Task_].Period, QuarkTS.TaskStack[qID_##Task_].N)                           
#define qChangeIterations(Task_, NewIter_)                                                  __qChangeParameter(qID_##Task_, QuarkTS.TaskStack[qID_##Task_].Priority, QuarkTS.TaskStack[qID_##Task_].Period, NewIter_) 
#define qChangeParameters(Task_,  NewPriority_, NewTime_, NewIter_)                         __qChangeParameter(qID_##Task_, NewPriority_, NewTime_, NewIter_)                           


#ifdef	__cplusplus
}
#endif

#endif	/* UKERNEL_H */

