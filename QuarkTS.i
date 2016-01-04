# 1 "QuarkTS.c"
# 1 "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "QuarkTS.c"
# 20 "QuarkTS.c"
# 1 "QuarkTS.h" 1
# 31 "QuarkTS.h"
    typedef enum {byTimeElapsed, byPriority, byQueueExtraction, byAsyncEvent} qTrigger_t;
    typedef float qTime_t;
    typedef volatile unsigned long qClock_t;
    typedef unsigned char qPriority_t;
    typedef unsigned char qIteration_t;
    typedef unsigned char qState_t;
    typedef unsigned char qBool_t;
# 49 "QuarkTS.h"
    typedef struct{
        qTrigger_t Trigger;
        void *UserData;
        void *EventData;
        qBool_t FirstCall;
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


    typedef struct{
        volatile struct _qTask_t *Task;
        void *QueueData;
    }qQueueStack_t;

    typedef struct{
        unsigned Init:1;
        unsigned FCallIdle:1;
    }qTaskCoreFlags_t;

    typedef struct{
        qTaskFcn_t IDLECallback;
        qTime_t Tick;
        qEvent_t EventInfo;
        volatile struct _qTask_t *First;
        qTaskCoreFlags_t Flag;
        volatile qQueueStack_t *QueueStack;
        unsigned char QueueSize, QueueIndex;
    }QuarkTSCoreData_t;
    extern volatile QuarkTSCoreData_t QUARKTS;

    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack);
    void _qISRHandler(void);
    int _qCreateTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    void _qStart(void);
    int _qEnqueueTaskEvent(volatile struct _qTask_t *TasktoQueue, void* eventdata);
# 21 "QuarkTS.c" 2

volatile QuarkTSCoreData_t QUARKTS;
static void _qTriggerEvent(volatile struct _qTask_t *Task, qTrigger_t Event);
static void _qTaskChainbyPriority(void);
static volatile struct _qTask_t* _qDequeueTaskEvent(void);


int _qEnqueueTaskEvent(volatile struct _qTask_t *TasktoQueue, void* eventdata){
    if(QUARKTS.QueueIndex>QUARKTS.QueueSize-1 ) return -1;
    qPriority_t PriorityValue = TasktoQueue->Priority;
    qQueueStack_t qtmp;
    volatile struct _qTask_t *TaskFromQueue;
    qtmp.Task = TasktoQueue;
    qtmp.QueueData = eventdata;
    if( (TaskFromQueue = QUARKTS.QueueStack[QUARKTS.QueueIndex].Task)!=((void*)0)){
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
        if( (TaskFromQueue = QUARKTS.QueueStack[i].Task)!=((void*)0)){
            if(PriorityValue<= TaskFromQueue->Priority){
                qtmp = QUARKTS.QueueStack[QUARKTS.QueueIndex-1];
                QUARKTS.QueueStack[QUARKTS.QueueIndex-1] = QUARKTS.QueueStack[i];
                QUARKTS.QueueStack[i] = qtmp;
            }
        }
    }
    return 0;
}

static volatile struct _qTask_t* _qDequeueTaskEvent(void){
    int i;
    volatile struct _qTask_t *Task;
    for( i=QUARKTS.QueueIndex-1; i>=0; i--){
        if( QUARKTS.QueueStack[i].Task != ((void*)0)){
            Task = QUARKTS.QueueStack[i].Task;
            QUARKTS.EventInfo.EventData = QUARKTS.QueueStack[i].QueueData;
            QUARKTS.QueueStack[i].Task = ((void*)0);
            if( QUARKTS.QueueIndex>0) QUARKTS.QueueIndex--;
            return Task;
        }
    }
    return ((void*)0);
}

void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack){
    unsigned char i;
    QUARKTS.First = ((void*)0);
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.QueueStack = Q_Stack;
    QUARKTS.QueueSize = Size_Q_Stack;
    for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = ((void*)0);
    QUARKTS.QueueIndex = 0;
    QUARKTS.Flag.Init = 0;
}

void _qISRHandler(void){
    if(!QUARKTS.Flag.Init) return;
    volatile struct _qTask_t *Task = QUARKTS.First;
    while(Task != ((void*)0)){
        if( Task->Flag.State && Task->Interval>0){
            Task->TimeElapsed++;
            if(Task->TimeElapsed >= Task->Interval){
                Task->Flag.TimedTaskRun++;
                Task->TimeElapsed = 0;
            }
        }
        Task = Task->Next;
    }
}

int _qCreateTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg){
    if ((Time/2)<QUARKTS.Tick && Time || CallbackFcn == ((void*)0)) return -1;
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

static void _qTriggerEvent(volatile struct _qTask_t *Task, qTrigger_t Event){
    QUARKTS.EventInfo.Trigger = Event;
    QUARKTS.EventInfo.FirstCall = !Task->Flag.InitFlag;
    QUARKTS.EventInfo.UserData = Task->UserData;
    if (Task->Callback != ((void*)0)) Task->Callback(QUARKTS.EventInfo);
    Task->Flag.InitFlag = 1;
    QUARKTS.EventInfo.EventData = ((void*)0);
}

static void _qTaskChainbyPriority(void){
    volatile struct _qTask_t *a = ((void*)0), *b = ((void*)0), *c = ((void*)0), *e = ((void*)0), *tmp = ((void*)0);
    volatile struct _qTask_t *head = QUARKTS.First;
    while(e != head->Next) {
        c = a = head;
        b = a->Next;
        while(a != e) {
            if(a->Priority < b->Priority) {
                tmp = b->Next;
                b->Next = a;
                if(a == head) QUARKTS.First = head = b;
                else c->Next = b;
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

void _qStart(void){
    volatile struct _qTask_t *Task, *qTask;
    pMainSchedule:
    if(!QUARKTS.Flag.Init){
        _qTaskChainbyPriority();
        QUARKTS.Flag.Init= 1;
    }
    Task = QUARKTS.First;
    while(Task != ((void*)0)){
        if ((qTask = _qDequeueTaskEvent())!=((void*)0)) _qTriggerEvent(qTask, byQueueExtraction);
        if((Task->Flag.TimedTaskRun || Task->Interval == ((qTime_t)(0))) && (Task->Iterations>0 || Task->Iterations==((qIteration_t)-1)) && Task->Flag.State){
            Task->Flag.TimedTaskRun--;
            if(Task->Iterations!= ((qIteration_t)-1)) Task->Iterations--;
            if(Task->Iterations == 0) Task->Flag.State = 0;
            _qTriggerEvent(Task, byTimeElapsed);
        }
        else if( Task->Flag.AsyncRun){
            QUARKTS.EventInfo.EventData = Task->AsyncData;
            Task->Flag.AsyncRun = 0;
            _qTriggerEvent(Task, byAsyncEvent);
        }
        else if( QUARKTS.IDLECallback!= ((void*)0)){
            QUARKTS.EventInfo.FirstCall = !QUARKTS.Flag.FCallIdle;
            QUARKTS.EventInfo.Trigger = byPriority;
            QUARKTS.IDLECallback(QUARKTS.EventInfo);
            QUARKTS.Flag.Init = 1;
        }
        Task = Task->Next;
    }
    goto pMainSchedule;
}
