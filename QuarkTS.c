/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Task Scheduler for low-range MCUs
 *  Version : 3.4
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
static qTask_t* _qPrioQueueExtract(void);
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
void _qEnableDisable(qTask_t *Task, qBool_t Value){
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
int _qPrioQueueInsert(qTask_t *TasktoQueue, void* eventdata){
    if(QUARKTS.QueueIndex>=QUARKTS.QueueSize-1 ) return -1;
    qQueueStack_t qtmp;
    qtmp.Task = TasktoQueue,
    qtmp.QueueData = eventdata;
    QUARKTS.QueueStack[++QUARKTS.QueueIndex] = qtmp;
    return 0;
}
/*============================================================================*/
static qTask_t* _qPrioQueueExtract(void){
    qTask_t *Task = NULL;
    uint8_t i;
    uint8_t IndexTaskToExtract = 0;
    if(QUARKTS.QueueIndex < 0) return NULL;
    _Q_ENTER_CRITICAL();
    qPriority_t MaxpValue = QUARKTS.QueueStack[0].Task->Priority;
    for(i=1;i<QUARKTS.QueueSize;i++){
        if(QUARKTS.QueueStack[i].Task == NULL) break;
        if(QUARKTS.QueueStack[i].Task->Priority > MaxpValue){
            MaxpValue = QUARKTS.QueueStack[i].Task->Priority;
            IndexTaskToExtract = i;
        }
    }   
    QUARKTS.EventInfo.EventData = QUARKTS.QueueStack[IndexTaskToExtract].QueueData;
    Task = QUARKTS.QueueStack[IndexTaskToExtract].Task;
    QUARKTS.QueueStack[IndexTaskToExtract].Task = NULL;  
    for(i=IndexTaskToExtract; i<QUARKTS.QueueIndex; i++) QUARKTS.QueueStack[i] = QUARKTS.QueueStack[i+1];    
    QUARKTS.QueueIndex--;    
    _Q_EXIT_CRITICAL();
    return Task;
}
/*============================================================================*/
void _qSetInterruptsED(void(*Enabler)(void), void(*Disabler)(void)){
    QUARKTS.I_Enabler = Enabler;
    QUARKTS.I_Disable = Disabler;
}
/*============================================================================*/
void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack){
    uint8_t i;
    QUARKTS.First = NULL;
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.ReleaseSchedCallback = NULL;
    QUARKTS.QueueStack = Q_Stack;
    QUARKTS.QueueSize = Size_Q_Stack;
    for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = NULL;    
    QUARKTS.QueueIndex = -1;    
    QUARKTS.Flag.Init = 0;
    QUARKTS.Flag.ReleaseSched = 0;
    QUARKTS.Flag.FCallReleased = 0;
    QUARKTS.I_Enabler =  QUARKTS.I_Disable = NULL;
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
        if ((qTask = _qPrioQueueExtract())!=NULL) _qTriggerEvent(qTask, byQueueExtraction);          
        
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
int _qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState){
    if(InitState == NULL) return -1;
    obj->NextState = InitState;
    obj->PreviousState = NULL;
    obj->_.__Failure = FailureState;
    obj->_.__Success = SuccessState;
    obj->_.__Unexpected = UnexpectedState;
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
            if(obj->_.__Failure != NULL) obj->_.__Failure(obj);
            break;
        case qSM_EXIT_SUCCESS:
            if(obj->_.__Success != NULL) obj->_.__Success(obj);
            break;
        default:
            if(obj->_.__Unexpected != NULL) obj->_.__Unexpected(obj);
            break;
    }
 }
#ifdef QSTIMER
/*============================================================================*/
int _qSTimerSet(qSTimer_t *obj, qTime_t Time, qBool_t fr){
    if(fr && obj->SR){
        if (_qSTimerExpired(obj)){
            obj->SR = 0;
            return 1;
        }
        else return 0;
    }
    if ( (Time/2.0)<QUARKTS.Tick ) return -1;    
    obj->TV = (qClock_t)(Time/QUARKTS.Tick);
    obj->Start = QUARKTS.epochs;
    obj->SR = 1;
    return 0;
}
/*============================================================================*/
qBool_t _qSTimerExpired(qSTimer_t *obj){
    if(!obj->SR) return 0; 
    return ((QUARKTS.epochs - obj->Start)>=obj->TV);
}
/*============================================================================*/
qClock_t _qSTimerElapsed(qSTimer_t *obj){
    return QUARKTS.epochs-obj->Start;
}
/*============================================================================*/
qClock_t _qSTimerRemaining(qSTimer_t *obj){
    qClock_t elapsed = _qSTimerElapsed(obj);
    return (obj->TV <= 0 || elapsed>obj->TV)? obj->TV : obj->TV-elapsed;
}
/*============================================================================*/
#endif
