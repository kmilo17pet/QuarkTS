/*******************************************************************************
 *  QuarkTS - A Non-Preemptive Task Scheduler for low-range MCUs
 *  Version : 2.8.6
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

/*================================================================================================================================================*/
int _qEnqueueTaskEvent(qTask_t *TasktoQueue, void* eventdata){
    if(QUARKTS.QueueIndex>QUARKTS.QueueSize-1 ) return -1;
    qPriority_t PriorityValue = TasktoQueue->Priority;
    qQueueStack_t qtmp;
    qTask_t *TaskFromQueue;
    qtmp.Task = TasktoQueue;
    qtmp.QueueData = eventdata;
    if( (TaskFromQueue = QUARKTS.QueueStack[QUARKTS.QueueIndex].Task)!=NULL){
        if(PriorityValue<=TaskFromQueue->Priority){
        QUARKTS.QueueStack[QUARKTS.QueueIndex] = QUARKTS.QueueStack[QUARKTS.QueueIndex-1];
        QUARKTS.QueueStack[QUARKTS.QueueIndex-1] = qtmp;
        }
    }
    else QUARKTS.QueueStack[QUARKTS.QueueIndex] = qtmp;

    QUARKTS.QueueIndex++;
    if(QUARKTS.QueueIndex==1) return 0;
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
    return 0;
}
/*================================================================================================================================================*/
static qTask_t* _qDequeueTaskEvent(void){
    int i;
    qTask_t *Task;
    for( i=QUARKTS.QueueIndex-1; i>=0; i--){
        if( QUARKTS.QueueStack[i].Task != NULL){
            Task = QUARKTS.QueueStack[i].Task;
            QUARKTS.EventInfo.EventData = QUARKTS.QueueStack[i].QueueData;
            QUARKTS.QueueStack[i].Task = NULL;
            if( QUARKTS.QueueIndex>0) QUARKTS.QueueIndex--;
            return Task;
        }
    }
    return NULL;
}
/*============================================================================*/
void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack){
    unsigned char i;
    QUARKTS.First = NULL;
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.QueueStack = Q_Stack;
    QUARKTS.QueueSize = Size_Q_Stack;
    for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = NULL; 
    QUARKTS.QueueIndex = 0;    
    QUARKTS.Flag.Init = 0;
}
/*============================================================================*/
void _qISRHandler(void){
    if(!QUARKTS.Flag.Init) return;  
    qTask_t *Task =  QUARKTS.First;
    while(Task != NULL){
        if( Task->Flag.State  && Task->Interval>0){
            Task->TimeElapsed++;
            if(Task->TimeElapsed >= Task->Interval){ 
                Task->Flag.TimedTaskRun++;
                Task->TimeElapsed = 0; 
            }
        }
        Task = Task->Next;
    }
}
/*============================================================================*/
int _qCreateTask(qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg){
    if ((Time/2)<QUARKTS.Tick && Time || CallbackFcn == NULL) return -1;    
    Task->Callback = CallbackFcn;
    Task->TimeElapsed = 0;
    Task->Interval = (qClock_t)(Time/QUARKTS.Tick);
    Task->UserData = arg;
    Task->Priority = Priority;
    Task->Iterations = nExecutions;
    Task->Flag.AsyncRun = Task->Flag.InitFlag = Task->Flag.TimedTaskRun = 0;
    Task->Flag.State = InitialState != 0;
    Task->Next = QUARKTS.First;
    QUARKTS.First = Task;
    return 0;
}
/*================================================================================================================================================*/
static void _qTriggerEvent(qTask_t *Task, qTrigger_t Event){
    QUARKTS.EventInfo.Trigger =  Event;
    QUARKTS.EventInfo.FirstCall = !Task->Flag.InitFlag;
    QUARKTS.EventInfo.UserData = Task->UserData;
    if (Task->Callback != NULL) Task->Callback(QUARKTS.EventInfo);
    Task->Flag.InitFlag = 1;
    QUARKTS.EventInfo.EventData = NULL;
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
    pMainSchedule:
    if(!QUARKTS.Flag.Init){    
        _qTaskChainbyPriority();
        QUARKTS.Flag.Init= 1;
    }
    Task = QUARKTS.First;
    while(Task != NULL){
        if ((qTask = _qDequeueTaskEvent())!=NULL) _qTriggerEvent(qTask, byQueueExtraction);         
        if((Task->Flag.TimedTaskRun || Task->Interval == TIME_INMEDIATE) && (Task->Iterations>0 || Task->Iterations==PERIODIC) && Task->Flag.State){
            Task->Flag.TimedTaskRun--;
            if(Task->Iterations!= PERIODIC) Task->Iterations--;
            if(Task->Iterations == 0) Task->Flag.State = 0;
            _qTriggerEvent(Task, byTimeElapsed);
        }
        else if( Task->Flag.AsyncRun){
            QUARKTS.EventInfo.EventData = Task->AsyncData;
            Task->Flag.AsyncRun = 0;
            _qTriggerEvent(Task, byAsyncEvent);
        }
        else if( QUARKTS.IDLECallback!= NULL){
            QUARKTS.EventInfo.FirstCall = !QUARKTS.Flag.FCallIdle;
            QUARKTS.EventInfo.Trigger = byPriority;
            QUARKTS.IDLECallback(QUARKTS.EventInfo);
            QUARKTS.Flag.Init = 1;        
        }
        Task = Task->Next;
    }
    goto pMainSchedule;
}
