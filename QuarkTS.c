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
#include "QuarkTS.h"

volatile QuarkTSCoreData_t QUARKTS;
static void _qTriggerEvent(qTask_t *Task, qTrigger_t Event);
static void _qTaskChainbyPriority(void);
static qTask_t* _qDequeueTaskEvent(void);
/*============================================================================*/
void _qSendEvent(qTask_t *Task, void* eventdata){
    Task->Flag.AsyncRun = 1;
    Task->AsyncData = eventdata;
}
/*============================================================================*/
void _qSetTime(qTask_t *Task, qTime_t Value){
    Task->Interval = (qClock_t)(Value/QUARKTS.Tick);
}
/*============================================================================*/
void _qSetIterations(qTask_t *Task, qIteration_t Value){
    Task->Iterations = Value;
}
/*============================================================================*/
void _qSetPriority(qTask_t *Task, qPriority_t Value){
    QUARKTS.Flag.Init = 0; 
    Task->Priority = Value; 
}
/*============================================================================*/
void _qSetCallback(qTask_t *Task, qTaskFcn_t CallbackFcn){
    Task->Callback = CallbackFcn;
}
/*============================================================================*/
void _qEnableDisable(qTask_t *Task, unsigned char Value){
    if(Value) Task->TimeElapsed = 0;
    Task->Flag.Enabled = Value;
    if(!Value) Task->TimeElapsed = 0;
}
/*============================================================================*/
void _qSetUserData(qTask_t *Task, void* arg){
    Task->UserData = arg;
}
/*============================================================================*/
void _qClearTimeElapse(qTask_t *Task){
    Task->TimeElapsed = 0;
}
/*============================================================================*/
int _qEnqueueTaskEvent(qTask_t *TasktoQueue, void* eventdata){
    if(QUARKTS.QueueIndex>QUARKTS.QueueSize-1 ) return -1;
    while (QUARKTS.NotSafeQueue){} 
    QUARKTS.NotSafeQueue = 1;
    qQueueStack_t qtmp;
    qtmp.Task = TasktoQueue;
    qtmp.QueueData = eventdata;
#ifdef QPRIORITY_FIFO_QUEUE
    qTask_t *TaskFromQueue;
    qPriority_t PriorityValue = TasktoQueue->Priority;
    if( (TaskFromQueue = QUARKTS.QueueStack[QUARKTS.QueueIndex].Task)!=NULL){
        if(PriorityValue<=TaskFromQueue->Priority){
        QUARKTS.QueueStack[QUARKTS.QueueIndex] = QUARKTS.QueueStack[QUARKTS.QueueIndex-1];
        QUARKTS.QueueStack[QUARKTS.QueueIndex-1] = qtmp;
        }
    }
    else QUARKTS.QueueStack[QUARKTS.QueueIndex] = qtmp;
#else
    QUARKTS.QueueStack[QUARKTS.QueueIndex] = qtmp;
#endif    
    QUARKTS.QueueIndex++;
    if(QUARKTS.QueueIndex==1){ 
        QUARKTS.NotSafeQueue = 0;
        return 0;
    }   
#ifdef QPRIORITY_FIFO_QUEUE
    unsigned char i;
    for(i=0; i<QUARKTS.QueueSize; i++){
        if( (TaskFromQueue = QUARKTS.QueueStack[i].Task)!=NULL){          
            if(PriorityValue<= TaskFromQueue->Priority){
                qtmp = QUARKTS.QueueStack[QUARKTS.QueueIndex-1];
                QUARKTS.QueueStack[QUARKTS.QueueIndex-1] = QUARKTS.QueueStack[i];
                QUARKTS.QueueStack[i] = qtmp;
            }
        }
    }
#endif
    QUARKTS.NotSafeQueue = 0;
    return 0;
}
/*============================================================================*/
#if defined(QPRIORITY_FIFO_QUEUE)
static qTask_t* _qDequeueTaskEvent(void){
    int i;
    qTask_t *Task;
    for( i=QUARKTS.QueueIndex-1; i>=0; i--){
        if( QUARKTS.QueueStack[i].Task != NULL){
            while (QUARKTS.NotSafeQueue){} 
            Task = QUARKTS.QueueStack[i].Task;
            QUARKTS.EventInfo.EventData = QUARKTS.QueueStack[i].QueueData;
            QUARKTS.QueueStack[i].Task = NULL;
            if( QUARKTS.QueueIndex>0) QUARKTS.QueueIndex--;
            return Task;
        }
    }
    return NULL;
}
#endif
#if defined(QSIMPLE_FIFO_QUEUE)
static qTask_t* _qDequeueTaskEvent(void){
    qTask_t *Task;
    if( QUARKTS.QueueStack[0].Task != NULL){
        while (QUARKTS.NotSafeQueue){} 
        Task = QUARKTS.QueueStack[0].Task;
        QUARKTS.EventInfo.EventData = QUARKTS.QueueStack[0].QueueData;
        QUARKTS.QueueStack[0].Task = NULL;
        if( QUARKTS.QueueIndex>0) QUARKTS.QueueIndex--;
        memmove((void*)QUARKTS.QueueStack, (const void*)(QUARKTS.QueueStack+1), QUARKTS.QueueSize*sizeof(qQueueStack_t));
        return Task;
    }
    return NULL;
}
#endif
/*============================================================================*/
void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack){
    unsigned char i;
    QUARKTS.First = NULL;
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.ReleaseSchedCallback = NULL;
    QUARKTS.QueueStack = Q_Stack;
    QUARKTS.QueueSize = Size_Q_Stack;
    for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = NULL; 
    QUARKTS.QueueIndex = 0;    
    QUARKTS.Flag.Init = 0;
    QUARKTS.NotSafeQueue = 0;
    QUARKTS.Flag.ReleaseSched = 0;
    QUARKTS.Flag.FCallReleased = 0;
    #ifdef QSTIMER
        QUARKTS.epochs++;
    #endif
}
/*============================================================================*/
void _qISRHandler(void){
    if(!QUARKTS.Flag.Init) return;  
    qTask_t *Task =  QUARKTS.First;
    while(Task != NULL){
        if( Task->Flag.Enabled  && Task->Interval>0){
            Task->TimeElapsed++;
            if(Task->TimeElapsed >= Task->Interval){ 
                Task->Flag.TimedTaskRun = (Task->Flag.IgnoreOveruns)? 1 : Task->Flag.TimedTaskRun+1;              
                Task->TimeElapsed = 0; 
            }
        }
        Task = Task->Next;
    }
    #ifdef QSTIMER
        QUARKTS.epochs++;
    #endif
}
/*============================================================================*/
int _qCreateTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg){
    if (((Time/2)<QUARKTS.Tick && Time) || CallbackFcn == NULL) return -1;    
    Task->Callback = CallbackFcn;
    Task->TimeElapsed = 0;
    Task->Interval = (qClock_t)(Time/QUARKTS.Tick);
    Task->UserData = arg;
    Task->Priority = Priority;
    Task->Iterations = nExecutions;    
    Task->Flag.AsyncRun = Task->Flag.InitFlag = Task->Flag.TimedTaskRun = 0;
    Task->Flag.Enabled = (uint8_t)(InitialState != 0);
    Task->Next = QUARKTS.First;
    QUARKTS.First = Task;
    Task->Cycles = 0;
    return 0;
}
/*============================================================================*/
static void _qTriggerEvent(qTask_t *Task, qTrigger_t Event){
    QUARKTS.EventInfo.Trigger =  Event;
    QUARKTS.EventInfo.FirstCall = (uint8_t)(!Task->Flag.InitFlag);   
    QUARKTS.EventInfo.UserData = Task->UserData;
    if (Task->Callback != NULL) Task->Callback(QUARKTS.EventInfo);
    Task->Flag.InitFlag = 1;
    QUARKTS.EventInfo.EventData = NULL;
    Task->Cycles++;
}
/*============================================================================*/
static void _qTaskChainbyPriority(void){
    qTask_t *a = NULL, *b = NULL, *c = NULL, *e = NULL, *tmp = NULL; 
    qTask_t *head = QUARKTS.First;
    while(e != head->Next) {
        c = a = head;
        b = a->Next;
        while(a != e) {
            if(a->Priority < b->Priority) {
                tmp = b->Next;
                b->Next = a;
                if(a == head)  QUARKTS.First = head = b;
                else  c->Next = b;
                c = b;
                a->Next = tmp;
            } 
            else {
                c = a;
                a = a->Next;
            }
            b = a->Next;
            if(b == e) e = a;
        }
    }
}
/*============================================================================*/
void _qStart(void){
    qTask_t *Task, *qTask;
    qMainSchedule:
    if(QUARKTS.Flag.ReleaseSched) goto qReleasedSchedule;
    if(!QUARKTS.Flag.Init){    
        _qTaskChainbyPriority();
        QUARKTS.Flag.Init= 1;
    }
    Task = QUARKTS.First;
    while(Task != NULL){
        if ((qTask = _qDequeueTaskEvent())!=NULL) _qTriggerEvent(qTask, byQueueExtraction);          
        
        if((Task->Flag.TimedTaskRun || Task->Interval == TIME_INMEDIATE) && (Task->Iterations>0 || Task->Iterations==PERIODIC) && Task->Flag.Enabled){
            Task->Flag.TimedTaskRun--;
            if(Task->Iterations!= PERIODIC) Task->Iterations--;
            if(Task->Iterations == 0) Task->Flag.Enabled = 0;
            _qTriggerEvent(Task, byTimeElapsed);
        }
        else if( Task->Flag.AsyncRun){
            QUARKTS.EventInfo.EventData = Task->AsyncData;
            Task->Flag.AsyncRun = 0;
            _qTriggerEvent(Task, byAsyncEvent);
        }
        else if( QUARKTS.IDLECallback!= NULL){
            QUARKTS.EventInfo.FirstCall = (uint8_t)(!QUARKTS.Flag.FCallIdle);
            QUARKTS.EventInfo.Trigger = byPriority;
            QUARKTS.IDLECallback(QUARKTS.EventInfo);
            QUARKTS.Flag.FCallIdle = 1;        
        }
        Task = Task->Next;
    }
    goto qMainSchedule;
    qReleasedSchedule:
    QUARKTS.Flag.Init = 0;
    QUARKTS.Flag.ReleaseSched = 0;
    QUARKTS.EventInfo.FirstCall = (uint8_t)(!QUARKTS.Flag.FCallReleased);
    QUARKTS.EventInfo.Trigger = byAsyncEvent;
    if(QUARKTS.ReleaseSchedCallback!=NULL) QUARKTS.ReleaseSchedCallback(QUARKTS.EventInfo);
    QUARKTS.Flag.FCallIdle = 1;  
}
/*============================================================================*/
int _qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_State_t SuccessState, qSM_State_t FailureState, qSM_State_t UnexpectedState){
    if(InitState == NULL) return -1;
    obj->NextState = InitState;
    obj->PreviousState = NULL;
    obj->__Failure = FailureState;
    obj->__Success = SuccessState;
    obj->__Unexpected = UnexpectedState;
    return 0;
}
/*============================================================================*/
void _qStateMachine_Run(qSM_t *obj, void *Data){
    qSM_State_t prev  = NULL;
    obj->Data = Data;
    if(obj->NextState!=NULL){
        obj->StateJustChanged = obj->PreviousState != obj->NextState;
        prev = obj->NextState;
        obj->PreviousReturnStatus = obj->NextState(obj);
        obj->PreviousState = prev;
    }
    else    obj->PreviousReturnStatus = qSM_EXIT_FAILURE;
    
    switch(obj->PreviousReturnStatus){
        case qSM_EXIT_FAILURE:           
            if(obj->__Failure != NULL) obj->__Failure(obj);
            break;
        case qSM_EXIT_SUCCESS:
            if(obj->__Success != NULL) obj->__Success(obj);
            break;
        default:
            if(obj->__Unexpected != NULL) obj->__Unexpected(obj);
            break;
    }
 }
#ifdef QSTIMER
/*============================================================================*/
int _qSTimerSet(qSTimer_t *obj, qTime_t Time){    
    if ( (Time/2)<QUARKTS.Tick ) return -1;    
    obj->TV = (qClock_t)(Time/QUARKTS.Tick);
    obj->Start = QUARKTS.epochs;
    obj->SR = 1;
    return 0;
}
/*============================================================================*/
unsigned char _qSTimerExpired(qSTimer_t *obj){
    if(!obj->SR) return 0; 
    return ((QUARKTS.epochs - obj->Start)>=obj->TV);
}
/*============================================================================*/
#endif