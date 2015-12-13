# 1 "QuarkTS.c"
# 1 "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "QuarkTS.c"
# 20 "QuarkTS.c"
# 1 "QuarkTS.h" 1
# 31 "QuarkTS.h"
typedef enum {LOWEST_Priority=0, MEDIUM_Priority=30, HIGH_Priority=61} qPriorityValue_t;
typedef enum {byPriority, byTimeElapse, byAsyncEvent, byQueueEvent} qTrigger_t;
typedef enum {qQueueSuccess, qQueueError, qNoValidTask=0xFF} qReturnValue_t;
typedef enum {qQueueEND_Empty=0xFF} qCoreValue_t;
typedef unsigned int qIter_t;
# 50 "QuarkTS.h"
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
# 21 "QuarkTS.c" 2

volatile qCoreData_t QuarkTS;
static void __qQueueInit(void);
static qTaskID_t __qDequeue(void);
static void __qTriggerEvent(qTaskID_t TaskID, qTrigger_t Trigger);
static qReturnValue_t __qEnqueue(qTaskID_t TaskIDtoQueue, void* userdata);
static void __qSortByPriority(void);


void __qSendEvent(qTaskID_t TaskID){
    if(TaskID!=qNoValidTask) QuarkTS.TaskStack[TaskID].Flags.AsyncRun = 1;
}

void __qSetTaskState(qTaskID_t TaskID, unsigned char state){
    if(TaskID==qNoValidTask) return;
    if((QuarkTS.TaskStack[TaskID].Flags.Enable = (state==1)) )
        QuarkTS.TaskStack[QuarkTS.TaskCnt].Iterations = QuarkTS.TaskStack[QuarkTS.TaskCnt].N;
}

void __qSetIdleTask(qTask Idle_CallbackFcn){
    QuarkTS.IdleTaskCallback = Idle_CallbackFcn;
}

void __qInit( volatile qTaskStack_t *T_Stack, unsigned char Size_T_Stack, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack, qTime_t ISRTickPeriod, qTask IdleTask_CallbackFcn){
    unsigned char i;
    QuarkTS.QueueStack = Q_Stack;
    QuarkTS.TaskStack = T_Stack;
    QuarkTS.MaxTasks = Size_T_Stack;
    QuarkTS.QueueSize = Size_Q_Stack;
    for(i=0; i< QuarkTS.MaxTasks; i++){
        QuarkTS.TaskStack[i].Function = ((void *)0);
        QuarkTS.TaskStack[i].Flags.Enable = 0;
        QuarkTS.TaskStack[i].Priority = LOWEST_Priority;
        QuarkTS.TaskStack[i].Flags.TimedTaskRun = 0;
        QuarkTS.TaskStack[i].TimeElapsed = 0;
        QuarkTS.TaskStack[i].Flags.FcnInitFlag = 0;
        QuarkTS.TaskStack[i].Flags.AsyncRun = 0;
        QuarkTS.TaskStack[i].Period = 0;
        QuarkTS.TaskStack[i].Iterations = 0;
        QuarkTS.TaskStack[i].N = 0;
        QuarkTS.TaskStack[i].idptr = ((void *)0);
    }
    QuarkTS.TaskCnt = 0;
    QuarkTS.IdleTaskCallback = IdleTask_CallbackFcn;
    QuarkTS.KernelTick = ISRTickPeriod;
    QuarkTS.Flag.Init = 0;
}

qReturnValue_t __qTaskAttach(volatile qTaskID_t *id, qTask Task_CallbackFcn, qPriorityValue_t Priority, qTime_t TimeInSec, qIter_t n, unsigned char Enable, void* data){
    if (QuarkTS.TaskCnt>60 || QuarkTS.TaskCnt>=QuarkTS.MaxTasks || ((TimeInSec/2)<QuarkTS.KernelTick && TimeInSec>0)) return (qTaskID_t)qNoValidTask;
    Priority = (Priority>=60)? 60 : Priority;
    QuarkTS.TaskStack[QuarkTS.TaskCnt].Iterations = QuarkTS.TaskStack[QuarkTS.TaskCnt].N = n;
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

void __qISRHandler(void){
    if(!QuarkTS.Flag.Init) return;
    QuarkTS.Flag.OnISRCheck = 1;
    for(QuarkTS.iISR=0; QuarkTS.iISR< QuarkTS.TaskCnt ;QuarkTS.iISR++){
        if(QuarkTS.TaskStack[QuarkTS.iISR].Flags.Enable && QuarkTS.TaskStack[QuarkTS.iISR].Period>0){
            QuarkTS.TaskStack[QuarkTS.iISR].TimeElapsed++;
            if(QuarkTS.TaskStack[QuarkTS.iISR].TimeElapsed >= QuarkTS.TaskStack[QuarkTS.iISR].Period){
                QuarkTS.TaskStack[QuarkTS.iISR].Flags.TimedTaskRun++;
                QuarkTS.TaskStack[QuarkTS.iISR].TimeElapsed=0;
            }
        }
    }
    QuarkTS.Flag.OnISRCheck = 0;
}

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

static void __qQueueInit(void){
    unsigned char i;
    for(i=0;i<QuarkTS.QueueSize;i++) QuarkTS.QueueStack[i].TaskID = ((void *)0);
    QuarkTS.QueueIndex = 0;
}

qReturnValue_t __qQueueTaskEvent(volatile qTaskID_t *TaskIDtoQueue, void* userdata){
    if(QuarkTS.QueueIndex>QuarkTS.QueueSize-1 || *TaskIDtoQueue==qNoValidTask) return qQueueError;
    qPriority_t PriorityValue = QuarkTS.TaskStack[*TaskIDtoQueue].Priority;
    qQueueStack_t qtmp;
    volatile qTaskID_t *TaskID_FromQueue;
    qtmp.TaskID = TaskIDtoQueue;
    qtmp.UserData = userdata;
    if( (TaskID_FromQueue = QuarkTS.QueueStack[QuarkTS.QueueIndex].TaskID)!=((void *)0)){
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
        if( (TaskID_FromQueue = QuarkTS.QueueStack[i].TaskID)!=((void *)0)){
            if(PriorityValue<= QuarkTS.TaskStack[*TaskID_FromQueue].Priority){
                qtmp = QuarkTS.QueueStack[QuarkTS.QueueIndex-1];
                QuarkTS.QueueStack[QuarkTS.QueueIndex-1] = QuarkTS.QueueStack[i];
                QuarkTS.QueueStack[i] = qtmp;
            }
        }
    }
    return qQueueSuccess;
}

static qTaskID_t __qDequeue(void){
    int i;
    unsigned char TaskID;
    for( i=QuarkTS.QueueIndex-1; i>=0; i--){
        if( QuarkTS.QueueStack[i].TaskID != ((void *)0)){
            TaskID = *QuarkTS.QueueStack[i].TaskID;
            QuarkTS.QueueStack[i].TaskID = ((void *)0);
            if( QuarkTS.QueueIndex>0) QuarkTS.QueueIndex--;
            QuarkTS.EventData.UserData = QuarkTS.QueueStack[i].UserData;
            return TaskID;
        }
    }
    return qQueueEND_Empty;
}

static void __qTriggerEvent(qTaskID_t TaskID, qTrigger_t Trigger){
    QuarkTS.EventData.Trigger = Trigger;
    QuarkTS.EventData.FirstCall = !QuarkTS.TaskStack[TaskID].Flags.FcnInitFlag;
    if(Trigger == byAsyncEvent) QuarkTS.TaskStack[TaskID].Flags.AsyncRun = 0;
    QuarkTS.EventData.TaskData = QuarkTS.TaskStack[TaskID].TaskData;
    (*QuarkTS.TaskStack[TaskID].Function)(QuarkTS.EventData);
    QuarkTS.TaskStack[TaskID].Flags.FcnInitFlag = 1;
    QuarkTS.EventData.UserData = QuarkTS.EventData.TaskData = ((void *)0);
    QuarkTS.EventData.LastTaskID = TaskID;
}

void __qChangeParameter(qTaskID_t TaskID, qPriority_t NewPriority, qTime_t NewTimeInSec, qIter_t n){
    if(TaskID==qNoValidTask) return;
    if (QuarkTS.TaskStack[TaskID].Period > 0) QuarkTS.TaskStack[TaskID].Period=(qPeriod_t)(NewTimeInSec/QuarkTS.KernelTick);
    QuarkTS.TaskStack[QuarkTS.TaskCnt].Iterations = QuarkTS.TaskStack[QuarkTS.TaskCnt].N = n;
    QuarkTS.TaskStack[TaskID].Priority = (NewPriority>=60)? 60 : NewPriority;
    QuarkTS.Flag.Init= 0;
}

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

        if( QuarkTS.TaskStack[TaskID].Flags.TimedTaskRun && (QuarkTS.TaskStack[TaskID].Iterations>0 || QuarkTS.TaskStack[TaskID].Iterations==((qIter_t)-1)) && QuarkTS.TaskStack[TaskID].Flags.Enable){
            QuarkTS.TaskStack[TaskID].Flags.TimedTaskRun--;
            if(QuarkTS.TaskStack[TaskID].Iterations != ((qIter_t)-1)) QuarkTS.TaskStack[TaskID].Iterations--;
            if(QuarkTS.TaskStack[TaskID].Iterations == 0) QuarkTS.TaskStack[TaskID].Flags.Enable = 0;
            __qTriggerEvent(TaskID, byTimeElapse);
        }
        else if( QuarkTS.TaskStack[TaskID].Flags.AsyncRun) __qTriggerEvent(TaskID, byAsyncEvent);
        else if( QuarkTS.IdleTaskCallback != ((void *)0)){
            QuarkTS.EventData.FirstCall = !fcal_idlefcn;
            QuarkTS.EventData.Trigger = byPriority;
            (*QuarkTS.IdleTaskCallback)(QuarkTS.EventData);
            fcal_idlefcn = 1;
            QuarkTS.EventData.LastTaskID = qNoValidTask;
        }
    }
    goto QuarkTSLoop;
}
