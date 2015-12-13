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

#include "QuarkTS.h"

volatile qCoreData_t QuarkTS;
static void __qQueueInit(void);
static qTaskID_t __qDequeue(void);
static void __qTriggerEvent(qTaskID_t TaskID, qTrigger_t Trigger);
static qReturnValue_t __qEnqueue(qTaskID_t TaskIDtoQueue, void* userdata);
static void __qSortByPriority(void);
                                                                                
/*================================================================================================================================================*/
void __qSendEvent(qTaskID_t TaskID){
    if(TaskID!=qNoValidTask) QuarkTS.TaskStack[TaskID].Flags.AsyncRun = 1;
}
/*================================================================================================================================================*/
void __qSetTaskState(qTaskID_t TaskID, unsigned char state){
    if(TaskID==qNoValidTask) return;
    if((QuarkTS.TaskStack[TaskID].Flags.Enable = (state==ENABLE)) )
        QuarkTS.TaskStack[QuarkTS.TaskCnt].Iterations = QuarkTS.TaskStack[QuarkTS.TaskCnt].N;         
}
/*================================================================================================================================================*/
void __qSetIdleTask(qTask Idle_CallbackFcn){
    QuarkTS.IdleTaskCallback = Idle_CallbackFcn;
}
/*================================================================================================================================================*/
void __qInit( volatile qTaskStack_t *T_Stack, unsigned char Size_T_Stack, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack, qTime_t ISRTickPeriod, qTask IdleTask_CallbackFcn){
    unsigned char i;
    QuarkTS.QueueStack = Q_Stack;
    QuarkTS.TaskStack = T_Stack;
    QuarkTS.MaxTasks = Size_T_Stack;
    QuarkTS.QueueSize = Size_Q_Stack; 
    for(i=0; i< QuarkTS.MaxTasks; i++){
        QuarkTS.TaskStack[i].Function = NULL;
        QuarkTS.TaskStack[i].Flags.Enable = 0;
        QuarkTS.TaskStack[i].Priority = LOWEST_Priority;
        QuarkTS.TaskStack[i].Flags.TimedTaskRun = 0;
        QuarkTS.TaskStack[i].TimeElapsed = 0;
        QuarkTS.TaskStack[i].Flags.FcnInitFlag = 0;
        QuarkTS.TaskStack[i].Flags.AsyncRun = 0;
        QuarkTS.TaskStack[i].Period = 0; 
        QuarkTS.TaskStack[i].Iterations = 0; 
        QuarkTS.TaskStack[i].N = 0; 
        QuarkTS.TaskStack[i].idptr  = NULL;
    }
    QuarkTS.TaskCnt = 0;
    QuarkTS.IdleTaskCallback = IdleTask_CallbackFcn;
    QuarkTS.KernelTick = ISRTickPeriod;
    QuarkTS.Flag.Init = 0;
}
/*================================================================================================================================================*/
qReturnValue_t __qTaskAttach(volatile qTaskID_t *id, qTask Task_CallbackFcn, qPriorityValue_t Priority, qTime_t TimeInSec, qIter_t n, unsigned char Enable,  void* data){
    if (QuarkTS.TaskCnt>60 || QuarkTS.TaskCnt>=QuarkTS.MaxTasks || ((TimeInSec/2)<QuarkTS.KernelTick && TimeInSec>0)) return (qTaskID_t)qNoValidTask;
    Priority = (Priority>=60)? 60 : Priority;
    QuarkTS.TaskStack[QuarkTS.TaskCnt].Iterations = QuarkTS.TaskStack[QuarkTS.TaskCnt].N =  n;
    QuarkTS.TaskStack[QuarkTS.TaskCnt].Function = Task_CallbackFcn;
    QuarkTS.TaskStack[QuarkTS.TaskCnt].Flags.Enable = Enable;
    QuarkTS.TaskStack[QuarkTS.TaskCnt].Period = (qPeriod_t)(TimeInSec/QuarkTS.KernelTick);
    QuarkTS.TaskStack[QuarkTS.TaskCnt].Priority = Priority;
    QuarkTS.TaskStack[QuarkTS.TaskCnt].idptr = id;QuarkTS.TaskStack[QuarkTS.TaskCnt].TaskData = data;
    *id = QuarkTS.TaskCnt;
    QuarkTS.TaskCnt++;
    QuarkTS.Flag.Init = 0;
    return (qReturnValue_t)(QuarkTS.TaskCnt);
}
/*================================================================================================================================================*/
void __qISRHandler(void){
    if(!QuarkTS.Flag.Init) return;
    QuarkTS.Flag.OnISRCheck = 1;
    for(QuarkTS.iISR=0; QuarkTS.iISR< QuarkTS.TaskCnt ;QuarkTS.iISR++){
        if(QuarkTS.TaskStack[QuarkTS.iISR].Flags.Enable  && QuarkTS.TaskStack[QuarkTS.iISR].Period>0){
            QuarkTS.TaskStack[QuarkTS.iISR].TimeElapsed++; 
            if(QuarkTS.TaskStack[QuarkTS.iISR].TimeElapsed >= QuarkTS.TaskStack[QuarkTS.iISR].Period){ 
                QuarkTS.TaskStack[QuarkTS.iISR].Flags.TimedTaskRun++;
                QuarkTS.TaskStack[QuarkTS.iISR].TimeElapsed=0;
            }
        }
    }
    QuarkTS.Flag.OnISRCheck = 0;
}
/*================================================================================================================================================*/
static void __qSortByPriority(void){
    qTaskStack_t tmp;
    unsigned char i,j;
    for(i=0;i<QuarkTS.TaskCnt-1;i++){
        for(j=i+1;j<QuarkTS.TaskCnt;j++){ 
            if(QuarkTS.TaskStack[i].Priority < QuarkTS.TaskStack[j].Priority){
                *QuarkTS.TaskStack[i].idptr = j;
                *QuarkTS.TaskStack[j].idptr = i;
                tmp=QuarkTS.TaskStack[i];
                QuarkTS.TaskStack[i]=QuarkTS.TaskStack[j];
                QuarkTS.TaskStack[j]=tmp;
            }
        }
    }
}
/*================================================================================================================================================*/
static void __qQueueInit(void){
    unsigned char i;
    for(i=0;i<QuarkTS.QueueSize;i++) QuarkTS.QueueStack[i].TaskID = NULL; 
    QuarkTS.QueueIndex = 0;
}
/*================================================================================================================================================*/
qReturnValue_t __qQueueTaskEvent(volatile qTaskID_t *TaskIDtoQueue, void* userdata){
    if(QuarkTS.QueueIndex>QuarkTS.QueueSize-1 || *TaskIDtoQueue==qNoValidTask) return qQueueError;
    qPriority_t PriorityValue = QuarkTS.TaskStack[*TaskIDtoQueue].Priority;
    qQueueStack_t qtmp;
    volatile qTaskID_t *TaskID_FromQueue;
    qtmp.TaskID = TaskIDtoQueue;
    qtmp.UserData = userdata;
    if( (TaskID_FromQueue = QuarkTS.QueueStack[QuarkTS.QueueIndex].TaskID)!=NULL){
        if(PriorityValue<=QuarkTS.TaskStack[*TaskID_FromQueue].Priority){
        QuarkTS.QueueStack[QuarkTS.QueueIndex] = QuarkTS.QueueStack[QuarkTS.QueueIndex-1];
        QuarkTS.QueueStack[QuarkTS.QueueIndex-1] = qtmp;
        }
    }
    else QuarkTS.QueueStack[QuarkTS.QueueIndex] = qtmp;

    QuarkTS.QueueIndex++;
    if(QuarkTS.QueueIndex==1) return qQueueSuccess;
    qTaskID_t i;
    for(i=0; i<QuarkTS.QueueSize; i++){
        if( (TaskID_FromQueue = QuarkTS.QueueStack[i].TaskID)!=NULL){          
            if(PriorityValue<= QuarkTS.TaskStack[*TaskID_FromQueue].Priority){
                qtmp = QuarkTS.QueueStack[QuarkTS.QueueIndex-1];
                QuarkTS.QueueStack[QuarkTS.QueueIndex-1] = QuarkTS.QueueStack[i];
                QuarkTS.QueueStack[i] = qtmp;
            }
        }
    }
    return qQueueSuccess;
}
/*================================================================================================================================================*/
static qTaskID_t __qDequeue(void){
    int i;
    unsigned char TaskID;
    for( i=QuarkTS.QueueIndex-1; i>=0; i--){
        if( QuarkTS.QueueStack[i].TaskID != NULL){
            TaskID = *QuarkTS.QueueStack[i].TaskID;
            QuarkTS.QueueStack[i].TaskID = NULL;
            if( QuarkTS.QueueIndex>0) QuarkTS.QueueIndex--;
            QuarkTS.EventData.UserData = QuarkTS.QueueStack[i].UserData;
            return TaskID;
        }
    }
    return qQueueEND_Empty;
}
/*================================================================================================================================================*/
static void __qTriggerEvent(qTaskID_t TaskID, qTrigger_t Trigger){
    QuarkTS.EventData.Trigger = Trigger;
    QuarkTS.EventData.FirstCall = !QuarkTS.TaskStack[TaskID].Flags.FcnInitFlag;
    if(Trigger == byAsyncEvent) QuarkTS.TaskStack[TaskID].Flags.AsyncRun = 0;
    QuarkTS.EventData.TaskData = QuarkTS.TaskStack[TaskID].TaskData;
    (*QuarkTS.TaskStack[TaskID].Function)(QuarkTS.EventData);
    QuarkTS.TaskStack[TaskID].Flags.FcnInitFlag = 1;
    QuarkTS.EventData.UserData = QuarkTS.EventData.TaskData = NULL;
    QuarkTS.EventData.LastTaskID = TaskID;
}
/*================================================================================================================================================*/
void __qChangeParameter(qTaskID_t TaskID, qPriority_t NewPriority, qTime_t NewTimeInSec, qIter_t n){
    if(TaskID==qNoValidTask) return;
    if (QuarkTS.TaskStack[TaskID].Period > 0) QuarkTS.TaskStack[TaskID].Period=(qPeriod_t)(NewTimeInSec/QuarkTS.KernelTick);
    QuarkTS.TaskStack[QuarkTS.TaskCnt].Iterations = QuarkTS.TaskStack[QuarkTS.TaskCnt].N =  n;
    QuarkTS.TaskStack[TaskID].Priority = (NewPriority>=60)? 60 : NewPriority;     
    QuarkTS.Flag.Init= 0;   
}
/*================================================================================================================================================*/
void __qStartScheduler(void){
    qTaskID_t TaskID, dequeueTaskID;
    unsigned char fcal_idlefcn=0;
    __qQueueInit();
    
    QuarkTSLoop: if(!QuarkTS.Flag.Init){    
        __qSortByPriority();
        QuarkTS.Flag.Init= 1;
        QuarkTS.EventData.LastTaskID = qNoValidTask;
    }
    for( TaskID=0; TaskID< QuarkTS.TaskCnt; TaskID++){
        if ((dequeueTaskID = __qDequeue())!=qQueueEND_Empty) __qTriggerEvent(dequeueTaskID, byQueueEvent);
        if(QuarkTS.TaskStack[TaskID].Period == 0 && QuarkTS.TaskStack[TaskID].Flags.Enable) __qTriggerEvent(TaskID, byTimeElapse);
        
        if( QuarkTS.TaskStack[TaskID].Flags.TimedTaskRun && (QuarkTS.TaskStack[TaskID].Iterations>0 || QuarkTS.TaskStack[TaskID].Iterations==PERIODIC) && QuarkTS.TaskStack[TaskID].Flags.Enable){
            QuarkTS.TaskStack[TaskID].Flags.TimedTaskRun--;
            if(QuarkTS.TaskStack[TaskID].Iterations != PERIODIC) QuarkTS.TaskStack[TaskID].Iterations--;
            if(QuarkTS.TaskStack[TaskID].Iterations == 0) QuarkTS.TaskStack[TaskID].Flags.Enable = 0;
            __qTriggerEvent(TaskID, byTimeElapse);
        }
        else if( QuarkTS.TaskStack[TaskID].Flags.AsyncRun) __qTriggerEvent(TaskID, byAsyncEvent);
        else if( QuarkTS.IdleTaskCallback != NULL){
            QuarkTS.EventData.FirstCall = !fcal_idlefcn;
            QuarkTS.EventData.Trigger = byPriority;
            (*QuarkTS.IdleTaskCallback)(QuarkTS.EventData);
            fcal_idlefcn = 1;
            QuarkTS.EventData.LastTaskID = qNoValidTask;
        }
    }
    goto QuarkTSLoop;
}
/*================================================================================================================================================*/