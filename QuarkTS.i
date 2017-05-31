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
# 43 "QuarkTS.h"
        typedef int32_t _qTaskPC_t;
# 62 "QuarkTS.h"
    typedef enum {_Q_NO_VALID_TRIGGER_, byTimeElapsed, byPriority, byQueueExtraction, byAsyncEvent, byRBufferPop, byRBufferFull, byRBufferCount} qTrigger_t;
    typedef float qTime_t;
    typedef uint32_t qClock_t;
    typedef uint8_t qPriority_t;
    typedef uint8_t qIteration_t;
    typedef uint8_t qState_t;
    typedef uint8_t qBool_t;
# 79 "QuarkTS.h"
    typedef struct{
# 98 "QuarkTS.h"
        qTrigger_t Trigger;



        void *UserData;



        void *EventData;




        qBool_t FirstCall;
    }qEvent_t;

    typedef void (*qTaskFcn_t)(qEvent_t);
    typedef struct{
     volatile uint8_t InitFlag, AsyncRun, Enabled, RBAutoPop, RBFull, RBCount;
    }qTaskFlags_t;

    typedef enum {qWaiting = 0, qReady = 1, qRunning = 2} qTaskState_t;

    typedef struct{
        volatile uint8_t *data;
        volatile uint16_t ElementSize;
        volatile uint16_t Elementcount;
        volatile uint16_t head;
        volatile uint16_t tail;
    }qRBuffer_t;

    struct _qTask_t{
        void *UserData,*AsyncData;
        volatile qClock_t Interval, ClockStart;
        qIteration_t Iterations;
        uint32_t Cycles;
        qPriority_t Priority;
        qTaskFcn_t Callback;
        volatile qTaskFlags_t Flag;
        volatile struct _qTask_t *Next;
        qRBuffer_t *RingBuff;
    };


    typedef struct{
        volatile struct _qTask_t *Task;
        void *QueueData;
    }qQueueStack_t;

    typedef struct{
     uint8_t Init, FCallIdle, ReleaseSched, FCallReleased;
        uint32_t IntFlags;
    }qTaskCoreFlags_t;

    typedef struct{
        qTaskFcn_t IDLECallback;
        qTaskFcn_t ReleaseSchedCallback;
        qTime_t Tick;
        qEvent_t EventInfo;
        volatile struct _qTask_t *First;
        uint32_t (*I_Disable)(void);
        void (*I_Restorer)(uint32_t);
        volatile qTaskCoreFlags_t Flag;
        volatile qQueueStack_t *QueueStack;
        uint8_t QueueSize;
        int16_t QueueIndex;
    }QuarkTSCoreData_t;
    extern volatile QuarkTSCoreData_t QUARKTS;
    extern volatile qClock_t _qSysTick_Epochs_;
    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack);
    void qSchedulerSetInterruptsED(void (*Restorer)(uint32_t), uint32_t (*Disabler)(void));
    int qSchedulerAddxTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    int qSchedulerAddeTask(volatile struct _qTask_t *Task, qTaskFcn_t Callback, qPriority_t Priority, void* arg);
    void qSchedulerRun(void);
    int qTaskQueueEvent(volatile struct _qTask_t *Task, void* eventdata);
    void qTaskSendEvent(volatile struct _qTask_t *Task, void* eventdata);

    typedef enum{RB_AUTOPOP, RB_FULL, RB_COUNT}qRBLinkMode_t;

    int qTaskLinkRBuffer(volatile struct _qTask_t *Task, qRBuffer_t *RingBuffer, qRBLinkMode_t Mode, uint8_t arg);

    void qTaskSetTime(volatile struct _qTask_t *Task, qTime_t Value);
    void qTaskSetIterations(volatile struct _qTask_t *Task, qIteration_t Value);
    void qTaskSetPriority(volatile struct _qTask_t *Task, qPriority_t Value);
    void qTaskSetCallback(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn);
    void qTaskSetState(volatile struct _qTask_t *Task, qState_t State);
    void qTaskSetUserData(volatile struct _qTask_t *Task, void* arg);
    void qTaskClearTimeElapsed(volatile struct _qTask_t *Task);

    uint32_t qTaskGetCycles(volatile struct _qTask_t *Task);
# 262 "QuarkTS.h"
    typedef enum {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;



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
    int qStateMachine_Init(volatile struct _qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState);
    void qStateMachine_Run(volatile struct _qSM_t *obj, void *Data);
# 345 "QuarkTS.h"
        typedef struct{
            qBool_t SR;
            qClock_t Start, TV;
        }qSTimer_t;
        qBool_t qSTimerSet(qSTimer_t *obj, qTime_t Time);
        qBool_t qSTimerExpired(qSTimer_t *obj);
        qBool_t qSTimerFreeRun(qSTimer_t *obj, qTime_t Time);
        qClock_t qSTimerElapsed(qSTimer_t *obj);
        qClock_t qSTimerRemaining(qSTimer_t *obj);
        void qSTimerDisarm(qSTimer_t *obj);
# 364 "QuarkTS.h"
typedef struct {
    uint16_t BlockSize;
    uint8_t NumberofBlocks;
    uint8_t *BlockDescriptors;
    uint8_t *Blocks;
}qMemoryPool_t;

typedef enum {
    MEMBLOCK_4_BYTE = (1 << 2),
    MEMBLOCK_8_BYTE = (1 << 3),
    MEMBLOCK_16_BYTE = (1 << 4),
    MEMBLOCK_32_BYTE = (1 << 5),
    MEMBLOCK_64_BYTE = (1 << 6),
    MEMBLOCK_128_BYTE = (1 << 7),
    MEMBLOCK_256_BYTE = (1 << 8),
    MEMBLOCK_512_BYTE = (1 << 9),
    MEMBLOCK_1024_BYTE = (1 << 10),
    MEMBLOCK_2048_BYTE = (1 << 11),
    MEMBLOCK_4096_BYTE = (1 << 12),
    MEMBLOCK_8192_BYTE = (1 << 13)
}qMEM_size_t;
# 411 "QuarkTS.h"
    void* qMemoryAlloc(qMemoryPool_t *obj, uint16_t size);
    void qMemoryFree(qMemoryPool_t *obj, void* pmem);





void qRBufferInit(qRBuffer_t *obj, void* DataBlock, uint16_t ElementSize, uint16_t ElementCount);
qBool_t qRBufferEmpty(qRBuffer_t *obj);
void* qRBufferGetFront(qRBuffer_t *obj);
void* qRBufferPopFront(qRBuffer_t *obj);
qBool_t qRBufferPush(qRBuffer_t *obj, void *data);
# 20 "QuarkTS.c" 2

volatile QuarkTSCoreData_t QUARKTS;
volatile qClock_t _qSysTick_Epochs_ = 0;
static void _qTriggerEvent(volatile struct _qTask_t *Task, qTrigger_t Event);
static void _qTaskChainbyPriority(void);
static volatile struct _qTask_t* _qPrioQueueExtract(void);
static void _qTriggerIdleTask(void);
static void _qTriggerReleaseSchedEvent(void);

static uint16_t _qRBufferValidPowerOfTwo(uint16_t k);
static uint16_t _qRBufferCount(qRBuffer_t *obj);
static qBool_t _qRBufferFull(qRBuffer_t *obj);

static qTrigger_t _qCheckRBufferEvents(volatile struct _qTask_t *Task);
# 48 "QuarkTS.c"
uint32_t qTaskGetCycles(volatile struct _qTask_t *Task){
    return Task->Cycles;
}
# 66 "QuarkTS.c"
void qTaskSendEvent(volatile struct _qTask_t *Task, void* eventdata){
    Task->Flag.AsyncRun = 1;
    Task->AsyncData = eventdata;
}
# 82 "QuarkTS.c"
void qTaskSetTime(volatile struct _qTask_t *Task, qTime_t Value){
    Task->Interval = (qClock_t)(Value/QUARKTS.Tick);
}
# 101 "QuarkTS.c"
void qTaskSetIterations(volatile struct _qTask_t *Task, qIteration_t Value){
    Task->Iterations = Value;
}
# 115 "QuarkTS.c"
void qTaskSetPriority(volatile struct _qTask_t *Task, qPriority_t Value){
    QUARKTS.Flag.Init = 0;
    Task->Priority = Value;
}
# 131 "QuarkTS.c"
void qTaskSetCallback(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn){
    Task->Callback = CallbackFcn;
}
# 144 "QuarkTS.c"
void qTaskSetState(volatile struct _qTask_t *Task, qState_t State){
    if(State && Task->Flag.Enabled) return;
    Task->Flag.Enabled = State;
    Task->ClockStart = _qSysTick_Epochs_;
}
# 162 "QuarkTS.c"
void qTaskSetUserData(volatile struct _qTask_t *Task, void* arg){
    Task->UserData = arg;
}
# 174 "QuarkTS.c"
void qTaskClearTimeElapsed(volatile struct _qTask_t *Task){
    Task->ClockStart = _qSysTick_Epochs_;
}
# 197 "QuarkTS.c"
int qTaskQueueEvent(volatile struct _qTask_t *Task, void* eventdata){
    if(QUARKTS.QueueIndex>=QUARKTS.QueueSize-1 ) return -1;
    qQueueStack_t qtmp;
    qtmp.Task = Task,
    qtmp.QueueData = eventdata;
    QUARKTS.QueueStack[++QUARKTS.QueueIndex] = qtmp;
    return 0;
}
# 218 "QuarkTS.c"
void qSchedulerSetInterruptsED(void (*Restorer)(uint32_t), uint32_t (*Disabler)(void)){
    QUARKTS.I_Restorer = Restorer;
    QUARKTS.I_Disable = Disabler;
}

static volatile struct _qTask_t* _qPrioQueueExtract(void){
    volatile struct _qTask_t *Task = ((void*)0);
    uint8_t i;
    uint8_t IndexTaskToExtract = 0;
    if(QUARKTS.QueueIndex < 0) return ((void*)0);
    if(QUARKTS.I_Disable != ((void*)0)) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
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
    if(QUARKTS.I_Restorer != ((void*)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
    return Task;
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
    QUARKTS.Flag.Init = 0x00u;
    QUARKTS.Flag.ReleaseSched = 0x00u;
    QUARKTS.Flag.FCallReleased = 0x00u;
    QUARKTS.I_Restorer = ((void*)0);
    QUARKTS.I_Disable = ((void*)0);
    _qSysTick_Epochs_ = 0;
}
# 302 "QuarkTS.c"
int qSchedulerAddxTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg){
    if (((Time/2)<QUARKTS.Tick && Time) || CallbackFcn == ((void*)0)) return -1;
    Task->Callback = CallbackFcn;
    Task->Interval = (qClock_t)(Time/QUARKTS.Tick);
    Task->UserData = arg;
    Task->Priority = Priority;
    Task->Iterations = nExecutions;
    Task->Flag.AsyncRun = Task->Flag.InitFlag = Task->Flag.RBAutoPop = Task->Flag.RBCount = Task->Flag.RBCount = 0x00u;
    Task->Flag.Enabled = (uint8_t)(InitialState != 0x00u);
    Task->Next = QUARKTS.First;
    QUARKTS.First = Task;
    Task->Cycles = 0;
    Task->ClockStart = _qSysTick_Epochs_;
    QUARKTS.Flag.Init = 0;
    Task->RingBuff = ((void*)0);
    return 0;
}
# 346 "QuarkTS.c"
int qSchedulerAddeTask(volatile struct _qTask_t *Task, qTaskFcn_t Callback, qPriority_t Priority, void* arg){
    return qSchedulerAddxTask(Task, Callback, Priority, ((qTime_t)(0)), ((qIteration_t)1), 0, arg);
}

static void _qTriggerEvent(volatile struct _qTask_t *Task, qTrigger_t Event){
    QUARKTS.EventInfo.Trigger = Event;
    QUARKTS.EventInfo.FirstCall = (uint8_t)(!Task->Flag.InitFlag);
    QUARKTS.EventInfo.UserData = Task->UserData;
    if (Task->Callback != ((void*)0)) Task->Callback(QUARKTS.EventInfo);
    Task->Flag.InitFlag = 0x01u;
    QUARKTS.EventInfo.EventData = ((void*)0);
    Task->Cycles++;
}

static void _qTaskChainbyPriority(void){
    volatile struct _qTask_t *a = ((void*)0), *b = ((void*)0), *c = ((void*)0), *e = ((void*)0), *tmp = ((void*)0);
    volatile struct _qTask_t *head = QUARKTS.First;
    if(QUARKTS.I_Disable != ((void*)0)) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
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
    if(QUARKTS.I_Restorer != ((void*)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
}
# 423 "QuarkTS.c"
int qTaskLinkRBuffer(volatile struct _qTask_t *Task, qRBuffer_t *RingBuffer, qRBLinkMode_t Mode, uint8_t arg){
    if(RingBuffer == ((void*)0)) return -1;
    if(RingBuffer->data == ((void*)0)) return -1;
    switch(Mode){
        case RB_AUTOPOP:
            Task->Flag.RBAutoPop = (qBool_t)arg;
            break;
        case RB_FULL:
            Task->Flag.RBFull = (qBool_t)arg;
            break;
        case RB_COUNT:
            Task->Flag.RBCount = arg;
            break;
        default: return -1;
    }
    Task->RingBuff = (arg>0)? RingBuffer : ((void*)0);
    return 0;
}

static qTrigger_t _qCheckRBufferEvents(volatile struct _qTask_t *Task){
    qRBuffer_t *rb = Task->RingBuff;
    void* popdata = ((void*)0);
    if(rb == ((void*)0)) return _Q_NO_VALID_TRIGGER_;
    if(Task->Flag.RBFull && _qRBufferFull(rb)){
        QUARKTS.EventInfo.EventData = (void*)rb;
        return byRBufferFull;
    }
    if( (Task->Flag.RBCount>0) && (Task->Flag.RBCount >= _qRBufferCount(rb)) ){
        QUARKTS.EventInfo.EventData = (void*)rb;
        return byRBufferCount;
    }
    if(Task->Flag.RBAutoPop){
        if((popdata = qRBufferPopFront(rb))!=((void*)0)){
            QUARKTS.EventInfo.EventData = popdata;
            return byRBufferPop;
        }
    }
    return _Q_NO_VALID_TRIGGER_;
}

static void _qTriggerReleaseSchedEvent(void){
    QUARKTS.Flag.Init = 0x00u;
    QUARKTS.Flag.ReleaseSched = 0x00u;
    QUARKTS.EventInfo.FirstCall = (uint8_t)(!QUARKTS.Flag.FCallReleased);
    QUARKTS.EventInfo.Trigger = byAsyncEvent;
    if(QUARKTS.ReleaseSchedCallback!=((void*)0)) QUARKTS.ReleaseSchedCallback(QUARKTS.EventInfo);
    QUARKTS.Flag.FCallIdle = 0x01u;
}

static void _qTriggerIdleTask(void){
    QUARKTS.EventInfo.FirstCall = (uint8_t)(!QUARKTS.Flag.FCallIdle);
    QUARKTS.EventInfo.Trigger = byPriority;
    QUARKTS.IDLECallback(QUARKTS.EventInfo);
    QUARKTS.Flag.FCallIdle = 0x01u;
}
# 486 "QuarkTS.c"
void qSchedulerRun(void){
    volatile struct _qTask_t *Task, *qTask;
    qTrigger_t trg = _Q_NO_VALID_TRIGGER_;
    qMainSchedule:
    if(QUARKTS.Flag.ReleaseSched) goto qReleasedSchedule;
    if(!QUARKTS.Flag.Init){
        _qTaskChainbyPriority();
        QUARKTS.Flag.Init= 1;
    }
    Task = QUARKTS.First;
    while(Task != ((void*)0)){
        if ((qTask = _qPrioQueueExtract())!=((void*)0)) _qTriggerEvent(qTask, byQueueExtraction);
        if( ( ((_qSysTick_Epochs_ - Task->ClockStart)>=Task->Interval) || Task->Interval == ((qTime_t)(0))) && (Task->Iterations>0 || Task->Iterations==((qIteration_t)-1)) && ((qBool_t)((Task)->Flag.Enabled))){
            Task->ClockStart = _qSysTick_Epochs_;
            if(Task->Iterations!= ((qIteration_t)-1)) Task->Iterations--;
            if(Task->Iterations == 0) Task->Flag.Enabled = 0x00u;
            _qTriggerEvent(Task, byTimeElapsed);
        }
        else if((trg=_qCheckRBufferEvents(Task)) != _Q_NO_VALID_TRIGGER_) _qTriggerEvent(Task, trg);
        else if( Task->Flag.AsyncRun){
            QUARKTS.EventInfo.EventData = Task->AsyncData;
            Task->Flag.AsyncRun = 0x00u;
            _qTriggerEvent(Task, byAsyncEvent);
        }
        else if( QUARKTS.IDLECallback!= ((void*)0)) _qTriggerIdleTask();
        Task = Task->Next;
    }
    goto qMainSchedule;
    qReleasedSchedule: _qTriggerReleaseSchedEvent();
}
# 546 "QuarkTS.c"
int qStateMachine_Init(volatile struct _qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState){
    if(InitState == ((void*)0)) return -1;
    obj->NextState = InitState;
    obj->PreviousState = ((void*)0);
    obj->_.__Failure = FailureState;
    obj->_.__Success = SuccessState;
    obj->_.__Unexpected = UnexpectedState;
    return 0;
}
# 569 "QuarkTS.c"
void qStateMachine_Run(volatile struct _qSM_t *obj, void *Data){
    qSM_State_t prev = ((void*)0);
    obj->Data = Data;
    if(obj->NextState!=((void*)0)){
        obj->StateJustChanged = (qBool_t)(obj->PreviousState != obj->NextState);
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
# 612 "QuarkTS.c"
qBool_t qSTimerSet(qSTimer_t *obj, qTime_t Time){
    if ( (Time/2.0)<QUARKTS.Tick ) return 0xFFu;
    obj->TV = (qClock_t)(Time/QUARKTS.Tick);
    obj->Start = _qSysTick_Epochs_;
    obj->SR = 0x01u;
    return 0x00u;
}
# 641 "QuarkTS.c"
qBool_t qSTimerFreeRun(qSTimer_t *obj, qTime_t Time){
    if(obj->SR){
        if (qSTimerExpired(obj)){
            qSTimerDisarm(obj);
            return 0x01u;
        }
        else return 0x00u;
    }
    return qSTimerSet(obj, Time);
}
# 666 "QuarkTS.c"
qBool_t qSTimerExpired(qSTimer_t *obj){
    if(!obj->SR) return 0x00u;
    return (qBool_t)((_qSysTick_Epochs_ - obj->Start)>=obj->TV);
}
# 683 "QuarkTS.c"
qClock_t qSTimerElapsed(qSTimer_t *obj){
    return (_qSysTick_Epochs_-obj->Start);
}
# 699 "QuarkTS.c"
qClock_t qSTimerRemaining(qSTimer_t *obj){
    qClock_t elapsed = qSTimerElapsed(obj);
    return (obj->TV <= 0 || elapsed>obj->TV)? obj->TV : obj->TV-elapsed;
}
# 712 "QuarkTS.c"
void qSTimerDisarm(qSTimer_t *obj){
    obj->SR = 0x00u;
    obj->Start = 0;
}
# 733 "QuarkTS.c"
void* qMemoryAlloc(qMemoryPool_t *obj, uint16_t size){
    uint8_t i, j, k;
    uint16_t sum;
    uint8_t *offset = obj->Blocks;
    j = 0;
    if(QUARKTS.I_Disable != ((void*)0)) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
    while( j < obj->NumberofBlocks ) {
        sum = 0;
 i = j;
 while( i < obj->NumberofBlocks ) {
            if( *(obj->BlockDescriptors+i) ) {
                offset += (*(obj->BlockDescriptors+i)) * (obj->BlockSize);
  i += *(obj->BlockDescriptors+i);
  continue;
            }
            break;
 }
 j = i;
 for(k = 1, i = j; i < obj->NumberofBlocks; k++, i++) {
            if( *(obj->BlockDescriptors+i) ) {
                j = i + *(obj->BlockDescriptors+i);
  offset = (uint8_t*) obj->Blocks;
  offset += j * (obj->BlockSize);
  break;
            }
            sum += obj->BlockSize;
            if( sum >= size ) {
                *(obj->BlockDescriptors+j) = k;
  if(QUARKTS.I_Restorer != ((void*)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
  return (void*)offset;
            }
 }
 if( i == obj->NumberofBlocks ) break;
    }
    if(QUARKTS.I_Restorer != ((void*)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
    return ((void*)0);
}
# 783 "QuarkTS.c"
void qMemoryFree(qMemoryPool_t *obj, void* pmem){
    uint8_t i, *p;
    if(QUARKTS.I_Disable != ((void*)0)) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
    p = (uint8_t*) obj->Blocks;
    for(i = 0; i < obj->NumberofBlocks; i++) {
        if( p == pmem ) {
            *(obj->BlockDescriptors + i) = 0;
            break;
 }
 p += obj->BlockSize;
    }
    if(QUARKTS.I_Restorer != ((void*)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
}




static uint16_t _qRBufferValidPowerOfTwo(uint16_t k){
    uint16_t i;
    if ( ((k-1) & k) != 0) {
        k--;
        for (i = 1; i < sizeof(uint16_t) * 8; i = i * 2) k = k | k >> i;
        k = (k+1) >> 1;
    }
    return k;
}

static uint16_t _qRBufferCount(qRBuffer_t *obj){
    return (obj ? (obj->head - obj->tail) : 0);
}

static qBool_t _qRBufferFull(qRBuffer_t *obj){
    return (qBool_t)(obj ? (_qRBufferCount(obj) == obj->Elementcount) : 0x01u);
}
# 835 "QuarkTS.c"
void qRBufferInit(qRBuffer_t *obj, void* DataBlock, uint16_t ElementSize, uint16_t ElementCount){
    if (obj) {
        obj->head = 0;
        obj->tail = 0;
        obj->data = DataBlock;
        obj->ElementSize = ElementSize;
        obj->Elementcount = _qRBufferValidPowerOfTwo(ElementCount);
    }
}
# 857 "QuarkTS.c"
qBool_t qRBufferEmpty(qRBuffer_t *obj){
    return (qBool_t)(obj ? (_qRBufferCount(obj) == 0) : 0x01u);
}
# 873 "QuarkTS.c"
void* qRBufferGetFront(qRBuffer_t *obj){
    if (obj) {
        return (void*)(!qRBufferEmpty(obj) ? &(obj->data[(obj->tail % obj->Elementcount) * obj->ElementSize]) : ((void*)0));
    }
    return ((void*)0);
}
# 892 "QuarkTS.c"
void* qRBufferPopFront(qRBuffer_t *obj){
    if(obj == ((void*)0)) return ((void*)0);
    void *data = ((void*)0);
    if (!qRBufferEmpty(obj)) {
        data = (void*)(&(obj->data[(obj->tail % obj->Elementcount) * obj->ElementSize]));
        obj->tail++;
    }
    return data;
}
# 915 "QuarkTS.c"
qBool_t qRBufferPush(qRBuffer_t *obj, void *data){
    qBool_t status = 0x00u;
    uint8_t *data_element = (uint8_t*)data;
    volatile uint8_t *ring_data = ((void*)0);
    uint16_t i;

    if (obj && data_element) {
        if (!_qRBufferFull(obj)) {
            ring_data = obj->data + ((obj->head % obj->Elementcount) * obj->ElementSize);
            for (i = 0; i < obj->ElementSize; i++) ring_data[i] = data_element[i];
            obj->head++;
            status = 0x01u;
        }
    }
    return status;
}
