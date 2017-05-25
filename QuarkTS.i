# 1 "QuarkTS.c"
# 1 "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "QuarkTS.c"
# 19 "QuarkTS.c"
# 1 "QuarkTS.h" 1
# 27 "QuarkTS.h"
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdint.h" 1 3 4
# 9 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdint.h" 3 4
# 1 "/usr/include/stdint.h" 1 3 4
# 12 "/usr/include/stdint.h" 3 4
# 1 "/usr/include/machine/_default_types.h" 1 3 4







# 1 "/usr/include/sys/features.h" 1 3 4
# 9 "/usr/include/machine/_default_types.h" 2 3 4
# 27 "/usr/include/machine/_default_types.h" 3 4
typedef signed char __int8_t;

typedef unsigned char __uint8_t;
# 41 "/usr/include/machine/_default_types.h" 3 4
typedef short int __int16_t;

typedef short unsigned int __uint16_t;
# 63 "/usr/include/machine/_default_types.h" 3 4
typedef int __int32_t;

typedef unsigned int __uint32_t;
# 89 "/usr/include/machine/_default_types.h" 3 4
typedef long int __int64_t;

typedef long unsigned int __uint64_t;
# 120 "/usr/include/machine/_default_types.h" 3 4
typedef signed char __int_least8_t;

typedef unsigned char __uint_least8_t;
# 146 "/usr/include/machine/_default_types.h" 3 4
typedef short int __int_least16_t;

typedef short unsigned int __uint_least16_t;
# 168 "/usr/include/machine/_default_types.h" 3 4
typedef int __int_least32_t;

typedef unsigned int __uint_least32_t;
# 186 "/usr/include/machine/_default_types.h" 3 4
typedef long int __int_least64_t;

typedef long unsigned int __uint_least64_t;
# 200 "/usr/include/machine/_default_types.h" 3 4
typedef long int __intptr_t;

typedef long unsigned int __uintptr_t;
# 13 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/sys/_intsup.h" 1 3 4
# 39 "/usr/include/sys/_intsup.h" 3 4
       
       
       
# 67 "/usr/include/sys/_intsup.h" 3 4
       
       
       
# 14 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/sys/_stdint.h" 1 3 4
# 19 "/usr/include/sys/_stdint.h" 3 4
typedef __int8_t int8_t ;
typedef __uint8_t uint8_t ;




typedef __int16_t int16_t ;
typedef __uint16_t uint16_t ;




typedef __int32_t int32_t ;
typedef __uint32_t uint32_t ;




typedef __int64_t int64_t ;
typedef __uint64_t uint64_t ;



typedef __intptr_t intptr_t;
typedef __uintptr_t uintptr_t;
# 15 "/usr/include/stdint.h" 2 3 4






typedef __int_least8_t int_least8_t;
typedef __uint_least8_t uint_least8_t;




typedef __int_least16_t int_least16_t;
typedef __uint_least16_t uint_least16_t;




typedef __int_least32_t int_least32_t;
typedef __uint_least32_t uint_least32_t;




typedef __int_least64_t int_least64_t;
typedef __uint_least64_t uint_least64_t;
# 51 "/usr/include/stdint.h" 3 4
  typedef signed char int_fast8_t;
  typedef unsigned char uint_fast8_t;
# 61 "/usr/include/stdint.h" 3 4
  typedef long int int_fast16_t;
  typedef long unsigned int uint_fast16_t;
# 71 "/usr/include/stdint.h" 3 4
  typedef long int int_fast32_t;
  typedef long unsigned int uint_fast32_t;
# 81 "/usr/include/stdint.h" 3 4
  typedef long int int_fast64_t;
  typedef long unsigned int uint_fast64_t;
# 130 "/usr/include/stdint.h" 3 4
  typedef long int intmax_t;
# 139 "/usr/include/stdint.h" 3 4
  typedef long unsigned int uintmax_t;
# 10 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdint.h" 2 3 4
# 28 "QuarkTS.h" 2
# 37 "QuarkTS.h"
        typedef enum qTaskPC_t_ {qCR_PCInitVal = -0x7FFE} _qTaskPC_t;
# 55 "QuarkTS.h"
    typedef enum {byTimeElapsed, byPriority, byQueueExtraction, byAsyncEvent} qTrigger_t;
    typedef float qTime_t;
    typedef uint32_t qClock_t;
    typedef uint8_t qPriority_t;
    typedef uint8_t qIteration_t;
    typedef uint8_t qState_t;
    typedef uint8_t qBool_t;
# 75 "QuarkTS.h"
    typedef struct{
# 94 "QuarkTS.h"
        qTrigger_t Trigger;



        void *UserData;



        void *EventData;




        qBool_t FirstCall;
    }qEvent_t;

    typedef void (*qTaskFcn_t)(qEvent_t);
    typedef struct{
     volatile uint8_t TimedTaskRun, InitFlag, AsyncRun, IgnoreOveruns, Enabled;
    }qTaskFlags_t;

    typedef enum {qWaiting = 0, qReady = 1, qRunning = 2} qTaskState_t;

    struct _qTask_t{
        void *UserData,*AsyncData;
        volatile qClock_t Interval, TimeElapsed;
        qIteration_t Iterations;
        uint32_t Cycles;
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
     uint8_t Init, FCallIdle, ReleaseSched, FCallReleased;
    }qTaskCoreFlags_t;

    typedef struct{
        qTaskFcn_t IDLECallback;
        qTaskFcn_t ReleaseSchedCallback;
        qTime_t Tick;
        qEvent_t EventInfo;
        volatile struct _qTask_t *First;
        void (*I_Disable)(void);
        void (*I_Enabler)(void);
        volatile qTaskCoreFlags_t Flag;
        volatile qQueueStack_t *QueueStack;
        uint8_t QueueSize;
        int16_t QueueIndex;

        volatile qClock_t epochs;

    }QuarkTSCoreData_t;
    extern volatile QuarkTSCoreData_t QUARKTS;

    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack);
    void _qISRHandler(void);
    int _qCreateTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    void _qStart(void);
    int _qEnqueueTaskEvent(volatile struct _qTask_t *TasktoQueue, void* eventdata);
    void _qSendEvent(volatile struct _qTask_t *Task, void* eventdata);
    void _qSetTime(volatile struct _qTask_t *Task, qTime_t Value);
    void _qSetIterations(volatile struct _qTask_t *Task, qIteration_t Value);
    void _qSetPriority(volatile struct _qTask_t *Task, qPriority_t Value);
    void _qSetCallback(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn);
    void _qEnableDisable(volatile struct _qTask_t *Task, qBool_t Value);
    void _qSetUserData(volatile struct _qTask_t *Task, void* arg);
    void _qClearTimeElapse(volatile struct _qTask_t *Task);
    void _qSetInterruptsED(void(*Enabler)(void), void(*Disabler)(void));
# 488 "QuarkTS.h"
    typedef enum state {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;



    struct _qSM_t{



        qSM_Status_t (*NextState)(volatile struct _qSM_t*);



        qSM_Status_t (*PreviousState)(volatile struct _qSM_t*);



        qSM_Status_t PreviousReturnStatus;



        qBool_t StateJustChanged;



        void *Data;
        struct {
            void (*__Failure)(volatile struct _qSM_t*);
            void (*__Success)(volatile struct _qSM_t*);
            void (*__Unexpected)(volatile struct _qSM_t*);
        }_;
    };
    typedef qSM_Status_t (*qSM_State_t)(volatile struct _qSM_t*);
    typedef void (*qSM_ExState_t)(volatile struct _qSM_t*);
    int _qStateMachine_Init(volatile struct _qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);
    void _qStateMachine_Run(volatile struct _qSM_t *obj, void *Data);
# 614 "QuarkTS.h"
        typedef struct{
            uint8_t SR;
            qClock_t Start, TV;
        }qSTimer_t;
        int _qSTimerSet(qSTimer_t *obj, qTime_t Time, qBool_t fr);
        qBool_t _qSTimerExpired(qSTimer_t *obj);
        qClock_t _qSTimerElapsed(qSTimer_t *obj);
        qClock_t _qSTimerRemaining(qSTimer_t *obj);
# 20 "QuarkTS.c" 2

volatile QuarkTSCoreData_t QUARKTS;
static void _qTriggerEvent(volatile struct _qTask_t *Task, qTrigger_t Event);
static void _qTaskChainbyPriority(void);
static volatile struct _qTask_t* _qPrioQueueExtract(void);

void _qSendEvent(volatile struct _qTask_t *Task, void* eventdata){
    Task->Flag.AsyncRun = 1;
    Task->AsyncData = eventdata;
}

void _qSetTime(volatile struct _qTask_t *Task, qTime_t Value){
    Task->Interval = (qClock_t)(Value/QUARKTS.Tick);
}

void _qSetIterations(volatile struct _qTask_t *Task, qIteration_t Value){
    Task->Iterations = Value;
}

void _qSetPriority(volatile struct _qTask_t *Task, qPriority_t Value){
    QUARKTS.Flag.Init = 0;
    Task->Priority = Value;
}

void _qSetCallback(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn){
    Task->Callback = CallbackFcn;
}

void _qEnableDisable(volatile struct _qTask_t *Task, qBool_t Value){
    if(Value) Task->TimeElapsed = 0;
    Task->Flag.Enabled = Value;
    if(!Value) Task->TimeElapsed = 0;
}

void _qSetUserData(volatile struct _qTask_t *Task, void* arg){
    Task->UserData = arg;
}

void _qClearTimeElapse(volatile struct _qTask_t *Task){
    Task->TimeElapsed = 0;
}

int _qPrioQueueInsert(volatile struct _qTask_t *TasktoQueue, void* eventdata){
    if(QUARKTS.QueueIndex>=QUARKTS.QueueSize-1 ) return -1;
    qQueueStack_t qtmp;
    qtmp.Task = TasktoQueue,
    qtmp.QueueData = eventdata;
    QUARKTS.QueueStack[++QUARKTS.QueueIndex] = qtmp;
    return 0;
}

static volatile struct _qTask_t* _qPrioQueueExtract(void){
    volatile struct _qTask_t *Task = ((void*)0);
    uint8_t i;
    uint8_t IndexTaskToExtract = 0;
    if(QUARKTS.QueueIndex < 0) return ((void*)0);
    if(QUARKTS.I_Disable != ((void*)0)) QUARKTS.I_Disable();
    qPriority_t MaxpValue = QUARKTS.QueueStack[0].Task->Priority;
    for(i=1;i<QUARKTS.QueueSize;i++){
        if(QUARKTS.QueueStack[i].Task == ((void*)0)) break;
        if(QUARKTS.QueueStack[i].Task->Priority > MaxpValue){
            MaxpValue = QUARKTS.QueueStack[i].Task->Priority;
            IndexTaskToExtract = i;
        }
    }
    QUARKTS.EventInfo.EventData = QUARKTS.QueueStack[IndexTaskToExtract].QueueData;
    Task = QUARKTS.QueueStack[IndexTaskToExtract].Task;
    QUARKTS.QueueStack[IndexTaskToExtract].Task = ((void*)0);
    for(i=IndexTaskToExtract; i<QUARKTS.QueueIndex; i++) QUARKTS.QueueStack[i] = QUARKTS.QueueStack[i+1];
    QUARKTS.QueueIndex--;
    if(QUARKTS.I_Enabler != ((void*)0)) QUARKTS.I_Enabler();
    return Task;
}

void _qSetInterruptsED(void(*Enabler)(void), void(*Disabler)(void)){
    QUARKTS.I_Enabler = Enabler;
    QUARKTS.I_Disable = Disabler;
}

void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack){
    uint8_t i;
    QUARKTS.First = ((void*)0);
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.ReleaseSchedCallback = ((void*)0);
    QUARKTS.QueueStack = Q_Stack;
    QUARKTS.QueueSize = Size_Q_Stack;
    for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = ((void*)0);
    QUARKTS.QueueIndex = -1;
    QUARKTS.Flag.Init = 0;
    QUARKTS.Flag.ReleaseSched = 0;
    QUARKTS.Flag.FCallReleased = 0;
    QUARKTS.I_Enabler = QUARKTS.I_Disable = ((void*)0);

        QUARKTS.epochs++;

}

void _qISRHandler(void){
    if(!QUARKTS.Flag.Init) return;
    volatile struct _qTask_t *Task = QUARKTS.First;
    while(Task != ((void*)0)){
        if( Task->Flag.Enabled && Task->Interval>0){
            Task->TimeElapsed++;
            if(Task->TimeElapsed >= Task->Interval){
                Task->Flag.TimedTaskRun = (Task->Flag.IgnoreOveruns)? 1 : Task->Flag.TimedTaskRun+1;
                Task->TimeElapsed = 0;
            }
        }
        Task = Task->Next;
    }

        QUARKTS.epochs++;

}

int _qCreateTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg){
    if (((Time/2)<QUARKTS.Tick && Time) || CallbackFcn == ((void*)0)) return -1;
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

static void _qTriggerEvent(volatile struct _qTask_t *Task, qTrigger_t Event){
    QUARKTS.EventInfo.Trigger = Event;
    QUARKTS.EventInfo.FirstCall = (uint8_t)(!Task->Flag.InitFlag);
    QUARKTS.EventInfo.UserData = Task->UserData;
    if (Task->Callback != ((void*)0)) Task->Callback(QUARKTS.EventInfo);
    Task->Flag.InitFlag = 1;
    QUARKTS.EventInfo.EventData = ((void*)0);
    Task->Cycles++;
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
    qMainSchedule:
    if(QUARKTS.Flag.ReleaseSched) goto qReleasedSchedule;
    if(!QUARKTS.Flag.Init){
        _qTaskChainbyPriority();
        QUARKTS.Flag.Init= 1;
    }
    Task = QUARKTS.First;
    while(Task != ((void*)0)){
        if ((qTask = _qPrioQueueExtract())!=((void*)0)) _qTriggerEvent(qTask, byQueueExtraction);

        if((Task->Flag.TimedTaskRun || Task->Interval == ((qTime_t)(0))) && (Task->Iterations>0 || Task->Iterations==((qIteration_t)-1)) && Task->Flag.Enabled){
            Task->Flag.TimedTaskRun--;
            if(Task->Iterations!= ((qIteration_t)-1)) Task->Iterations--;
            if(Task->Iterations == 0) Task->Flag.Enabled = 0;
            _qTriggerEvent(Task, byTimeElapsed);
        }
        else if( Task->Flag.AsyncRun){
            QUARKTS.EventInfo.EventData = Task->AsyncData;
            Task->Flag.AsyncRun = 0;
            _qTriggerEvent(Task, byAsyncEvent);
        }
        else if( QUARKTS.IDLECallback!= ((void*)0)){
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
    if(QUARKTS.ReleaseSchedCallback!=((void*)0)) QUARKTS.ReleaseSchedCallback(QUARKTS.EventInfo);
    QUARKTS.Flag.FCallIdle = 1;
}

int _qStateMachine_Init(volatile struct _qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState){
    if(InitState == ((void*)0)) return -1;
    obj->NextState = InitState;
    obj->PreviousState = ((void*)0);
    obj->_.__Failure = FailureState;
    obj->_.__Success = SuccessState;
    obj->_.__Unexpected = UnexpectedState;
    return 0;
}

void _qStateMachine_Run(volatile struct _qSM_t *obj, void *Data){
    qSM_State_t prev = ((void*)0);
    obj->Data = Data;
    if(obj->NextState!=((void*)0)){
        obj->StateJustChanged = obj->PreviousState != obj->NextState;
        prev = obj->NextState;
        obj->PreviousReturnStatus = obj->NextState(obj);
        obj->PreviousState = prev;
    }
    else obj->PreviousReturnStatus = qSM_EXIT_FAILURE;

    switch(obj->PreviousReturnStatus){
        case qSM_EXIT_FAILURE:
            if(obj->_.__Failure != ((void*)0)) obj->_.__Failure(obj);
            break;
        case qSM_EXIT_SUCCESS:
            if(obj->_.__Success != ((void*)0)) obj->_.__Success(obj);
            break;
        default:
            if(obj->_.__Unexpected != ((void*)0)) obj->_.__Unexpected(obj);
            break;
    }
 }


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

qBool_t _qSTimerExpired(qSTimer_t *obj){
    if(!obj->SR) return 0;
    return ((QUARKTS.epochs - obj->Start)>=obj->TV);
}

qClock_t _qSTimerElapsed(qSTimer_t *obj){
    return QUARKTS.epochs-obj->Start;
}

qClock_t _qSTimerRemaining(qSTimer_t *obj){
    qClock_t elapsed = _qSTimerElapsed(obj);
    return (obj->TV <= 0 || elapsed>obj->TV)? obj->TV : obj->TV-elapsed;
}
