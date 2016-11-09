# 1 "QuarkTS.c"
# 1 "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "QuarkTS.c"
# 20 "QuarkTS.c"
# 1 "QuarkTS.h" 1
# 31 "QuarkTS.h"
# 1 "/usr/include/string.h" 1 3 4
# 10 "/usr/include/string.h" 3 4
# 1 "/usr/include/_ansi.h" 1 3 4
# 15 "/usr/include/_ansi.h" 3 4
# 1 "/usr/include/newlib.h" 1 3 4
# 16 "/usr/include/_ansi.h" 2 3 4
# 1 "/usr/include/sys/config.h" 1 3 4



# 1 "/usr/include/machine/ieeefp.h" 1 3 4
# 5 "/usr/include/sys/config.h" 2 3 4
# 1 "/usr/include/sys/features.h" 1 3 4
# 6 "/usr/include/sys/config.h" 2 3 4
# 234 "/usr/include/sys/config.h" 3 4
# 1 "/usr/include/cygwin/config.h" 1 3 4
# 235 "/usr/include/sys/config.h" 2 3 4
# 17 "/usr/include/_ansi.h" 2 3 4
# 11 "/usr/include/string.h" 2 3 4
# 1 "/usr/include/sys/reent.h" 1 3 4
# 13 "/usr/include/sys/reent.h" 3 4
# 1 "/usr/include/_ansi.h" 1 3 4
# 14 "/usr/include/sys/reent.h" 2 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 147 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef long int ptrdiff_t;
# 212 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 324 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef short unsigned int wchar_t;
# 15 "/usr/include/sys/reent.h" 2 3 4
# 1 "/usr/include/sys/_types.h" 1 3 4
# 12 "/usr/include/sys/_types.h" 3 4
# 1 "/usr/include/machine/_types.h" 1 3 4






# 1 "/usr/include/machine/_default_types.h" 1 3 4
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
# 8 "/usr/include/machine/_types.h" 2 3 4
# 13 "/usr/include/sys/_types.h" 2 3 4
# 1 "/usr/include/sys/lock.h" 1 3 4
# 14 "/usr/include/sys/lock.h" 3 4
typedef void *_LOCK_T;
# 44 "/usr/include/sys/lock.h" 3 4
void __cygwin_lock_init(_LOCK_T *);
void __cygwin_lock_init_recursive(_LOCK_T *);
void __cygwin_lock_fini(_LOCK_T *);
void __cygwin_lock_lock(_LOCK_T *);
int __cygwin_lock_trylock(_LOCK_T *);
void __cygwin_lock_unlock(_LOCK_T *);
# 14 "/usr/include/sys/_types.h" 2 3 4


typedef long _off_t;



typedef short __dev_t;



typedef unsigned short __uid_t;


typedef unsigned short __gid_t;



__extension__ typedef long long _off64_t;







typedef long _fpos_t;





typedef _off64_t _fpos64_t;
# 55 "/usr/include/sys/_types.h" 3 4
typedef long signed int _ssize_t;
# 67 "/usr/include/sys/_types.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 353 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef unsigned int wint_t;
# 68 "/usr/include/sys/_types.h" 2 3 4



typedef struct
{
  int __count;
  union
  {
    wint_t __wch;
    unsigned char __wchb[4];
  } __value;
} _mbstate_t;



typedef _LOCK_T _flock_t;




typedef void *_iconv_t;
# 16 "/usr/include/sys/reent.h" 2 3 4
# 25 "/usr/include/sys/reent.h" 3 4
typedef unsigned int __ULong;
# 38 "/usr/include/sys/reent.h" 3 4
struct _reent;






struct _Bigint
{
  struct _Bigint *_next;
  int _k, _maxwds, _sign, _wds;
  __ULong _x[1];
};


struct __tm
{
  int __tm_sec;
  int __tm_min;
  int __tm_hour;
  int __tm_mday;
  int __tm_mon;
  int __tm_year;
  int __tm_wday;
  int __tm_yday;
  int __tm_isdst;
};







struct _on_exit_args {
 void * _fnargs[32];
 void * _dso_handle[32];

 __ULong _fntypes;


 __ULong _is_cxa;
};
# 91 "/usr/include/sys/reent.h" 3 4
struct _atexit {
 struct _atexit *_next;
 int _ind;

 void (*_fns[32])(void);
        struct _on_exit_args _on_exit_args;
};
# 115 "/usr/include/sys/reent.h" 3 4
struct __sbuf {
 unsigned char *_base;
 int _size;
};
# 179 "/usr/include/sys/reent.h" 3 4
struct __sFILE {
  unsigned char *_p;
  int _r;
  int _w;
  short _flags;
  short _file;
  struct __sbuf _bf;
  int _lbfsize;






  void * _cookie;

  _ssize_t (__attribute__((__cdecl__)) * _read) (struct _reent *, void *, char *, size_t)
                                          ;
  _ssize_t (__attribute__((__cdecl__)) * _write) (struct _reent *, void *, const char *, size_t)

                                   ;
  _fpos_t (__attribute__((__cdecl__)) * _seek) (struct _reent *, void *, _fpos_t, int);
  int (__attribute__((__cdecl__)) * _close) (struct _reent *, void *);


  struct __sbuf _ub;
  unsigned char *_up;
  int _ur;


  unsigned char _ubuf[3];
  unsigned char _nbuf[1];


  struct __sbuf _lb;


  int _blksize;
  _off_t _offset;


  struct _reent *_data;



  _flock_t _lock;

  _mbstate_t _mbstate;
  int _flags2;
};
# 237 "/usr/include/sys/reent.h" 3 4
struct __sFILE64 {
  unsigned char *_p;
  int _r;
  int _w;
  short _flags;
  short _file;
  struct __sbuf _bf;
  int _lbfsize;

  struct _reent *_data;


  void * _cookie;

  _ssize_t (__attribute__((__cdecl__)) * _read) (struct _reent *, void *, char *, size_t)
                                          ;
  _ssize_t (__attribute__((__cdecl__)) * _write) (struct _reent *, void *, const char *, size_t)

                                   ;
  _fpos_t (__attribute__((__cdecl__)) * _seek) (struct _reent *, void *, _fpos_t, int);
  int (__attribute__((__cdecl__)) * _close) (struct _reent *, void *);


  struct __sbuf _ub;
  unsigned char *_up;
  int _ur;


  unsigned char _ubuf[3];
  unsigned char _nbuf[1];


  struct __sbuf _lb;


  int _blksize;
  int _flags2;

  _off64_t _offset;
  _fpos64_t (__attribute__((__cdecl__)) * _seek64) (struct _reent *, void *, _fpos64_t, int);


  _flock_t _lock;

  _mbstate_t _mbstate;
};
typedef struct __sFILE64 __FILE;





struct _glue
{
  struct _glue *_next;
  int _niobs;
  __FILE *_iobs;
};
# 317 "/usr/include/sys/reent.h" 3 4
struct _rand48 {
  unsigned short _seed[3];
  unsigned short _mult[3];
  unsigned short _add;




};
# 569 "/usr/include/sys/reent.h" 3 4
struct _reent
{
  int _errno;




  __FILE *_stdin, *_stdout, *_stderr;

  int _inc;
  char _emergency[25];

  int _current_category;
  const char *_current_locale;

  int __sdidinit;

  void (__attribute__((__cdecl__)) * __cleanup) (struct _reent *);


  struct _Bigint *_result;
  int _result_k;
  struct _Bigint *_p5s;
  struct _Bigint **_freelist;


  int _cvtlen;
  char *_cvtbuf;

  union
    {
      struct
        {
          unsigned int _unused_rand;
          char * _strtok_last;
          char _asctime_buf[26];
          struct __tm _localtime_buf;
          int _gamma_signgam;
          __extension__ unsigned long long _rand_next;
          struct _rand48 _r48;
          _mbstate_t _mblen_state;
          _mbstate_t _mbtowc_state;
          _mbstate_t _wctomb_state;
          char _l64a_buf[8];
          char _signal_buf[24];
          int _getdate_err;
          _mbstate_t _mbrlen_state;
          _mbstate_t _mbrtowc_state;
          _mbstate_t _mbsrtowcs_state;
          _mbstate_t _wcrtomb_state;
          _mbstate_t _wcsrtombs_state;
   int _h_errno;
        } _reent;



      struct
        {

          unsigned char * _nextf[30];
          unsigned int _nmalloc[30];
        } _unused;
    } _new;



  struct _atexit *_atexit;
  struct _atexit _atexit0;



  void (**(_sig_func))(int);




  struct _glue __sglue;
  __FILE __sf[3];
};
# 762 "/usr/include/sys/reent.h" 3 4
extern struct _reent *_impure_ptr ;
extern struct _reent *const _global_impure_ptr ;

void _reclaim_reent (struct _reent *);





  struct _reent * __attribute__((__cdecl__)) __getreent (void);
# 12 "/usr/include/string.h" 2 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 45 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 46 "/usr/include/sys/cdefs.h" 2 3 4
# 13 "/usr/include/string.h" 2 3 4




# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 18 "/usr/include/string.h" 2 3 4



void * __attribute__((__cdecl__)) memchr (const void *, int, size_t);
int __attribute__((__cdecl__)) memcmp (const void *, const void *, size_t);
void * __attribute__((__cdecl__)) memcpy (void * , const void * , size_t);
void * __attribute__((__cdecl__)) memmove (void *, const void *, size_t);
void * __attribute__((__cdecl__)) memset (void *, int, size_t);
char *__attribute__((__cdecl__)) strcat (char *, const char *);
char *__attribute__((__cdecl__)) strchr (const char *, int);
int __attribute__((__cdecl__)) strcmp (const char *, const char *);
int __attribute__((__cdecl__)) strcoll (const char *, const char *);
char *__attribute__((__cdecl__)) strcpy (char *, const char *);
size_t __attribute__((__cdecl__)) strcspn (const char *, const char *);
char *__attribute__((__cdecl__)) strerror (int);
size_t __attribute__((__cdecl__)) strlen (const char *);
char *__attribute__((__cdecl__)) strncat (char *, const char *, size_t);
int __attribute__((__cdecl__)) strncmp (const char *, const char *, size_t);
char *__attribute__((__cdecl__)) strncpy (char *, const char *, size_t);
char *__attribute__((__cdecl__)) strpbrk (const char *, const char *);
char *__attribute__((__cdecl__)) strrchr (const char *, int);
size_t __attribute__((__cdecl__)) strspn (const char *, const char *);
char *__attribute__((__cdecl__)) strstr (const char *, const char *);

char *__attribute__((__cdecl__)) strtok (char *, const char *);

size_t __attribute__((__cdecl__)) strxfrm (char *, const char *, size_t);


char *__attribute__((__cdecl__)) strtok_r (char *, const char *, char **);


int __attribute__((__cdecl__)) bcmp (const void *, const void *, size_t);
void __attribute__((__cdecl__)) bcopy (const void *, void *, size_t);
void __attribute__((__cdecl__)) bzero (void *, size_t);
int __attribute__((__cdecl__)) ffs (int);
char *__attribute__((__cdecl__)) index (const char *, int);


void * __attribute__((__cdecl__)) memccpy (void * , const void * , int, size_t);





void * __attribute__((__cdecl__)) memrchr (const void *, int, size_t);




char *__attribute__((__cdecl__)) rindex (const char *, int);

char *__attribute__((__cdecl__)) stpcpy (char *, const char *);
char *__attribute__((__cdecl__)) stpncpy (char *, const char *, size_t);

int __attribute__((__cdecl__)) strcasecmp (const char *, const char *);






char *__attribute__((__cdecl__)) strdup (const char *);


char *__attribute__((__cdecl__)) _strdup_r (struct _reent *, const char *);


char *__attribute__((__cdecl__)) strndup (const char *, size_t);



char *__attribute__((__cdecl__)) _strndup_r (struct _reent *, const char *, size_t);
# 106 "/usr/include/string.h" 3 4
int __attribute__((__cdecl__)) strerror_r (int, char *, size_t)

             __asm__ ("" "__xpg_strerror_r")

  ;







char * __attribute__((__cdecl__)) _strerror_r (struct _reent *, int, int, int *);


size_t __attribute__((__cdecl__)) strlcat (char *, const char *, size_t);
size_t __attribute__((__cdecl__)) strlcpy (char *, const char *, size_t);


int __attribute__((__cdecl__)) strncasecmp (const char *, const char *, size_t);



size_t __attribute__((__cdecl__)) strnlen (const char *, size_t);


char *__attribute__((__cdecl__)) strsep (char **, const char *);







char *__attribute__((__cdecl__)) strlwr (char *);
char *__attribute__((__cdecl__)) strupr (char *);



char *__attribute__((__cdecl__)) strsignal (int __signo);



int __attribute__((__cdecl__)) strtosigno (const char *__name);
# 182 "/usr/include/string.h" 3 4
# 1 "/usr/include/sys/string.h" 1 3 4
# 183 "/usr/include/string.h" 2 3 4


# 32 "QuarkTS.h" 2

    typedef enum {byTimeElapsed, byPriority, byQueueExtraction, byAsyncEvent} qTrigger_t;
    typedef float qTime_t;
    typedef volatile unsigned long qClock_t;
    typedef unsigned char qPriority_t;
    typedef unsigned char qIteration_t;
    typedef unsigned char qState_t;
    typedef unsigned char qBool_t;
# 52 "QuarkTS.h"
    typedef struct{
        qTrigger_t Trigger;
        void *UserData;
        void *EventData;
        qBool_t FirstCall;
    }qEvent_t;

    typedef void (*qTaskFcn_t)(qEvent_t);

    typedef struct{
     volatile unsigned char TimedTaskRun;
        volatile unsigned char InitFlag;
        volatile unsigned char AsyncRun;
        volatile unsigned char State;
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
     unsigned char Init;
        unsigned char FCallIdle;
    }qTaskCoreFlags_t;

    typedef struct{
        qTaskFcn_t IDLECallback;
        qTime_t Tick;
        qEvent_t EventInfo;
        volatile struct _qTask_t *First;
        volatile qTaskCoreFlags_t Flag;
        volatile qQueueStack_t *QueueStack;
        unsigned char QueueSize, QueueIndex;
        volatile unsigned char NotSafeQueue;
    }QuarkTSCoreData_t;
    extern volatile QuarkTSCoreData_t QUARKTS;

    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack);
    void _qISRHandler(void);
    int _qCreateTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    void _qStart(void);
    int _qEnqueueTaskEvent(volatile struct _qTask_t *TasktoQueue, void* eventdata);
    void _qSendEvent(volatile struct _qTask_t *Task, void* eventdata);
    void _qSetTime(volatile struct _qTask_t *Task, qTime_t Value);
    void _qSetIterations(volatile struct _qTask_t *Task, qIteration_t Value);
    void _qSetPriority(volatile struct _qTask_t *Task, qPriority_t Value);
    void _qSetCallback(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn);
    void _qEnableDisable(volatile struct _qTask_t *Task, unsigned char Value);
    void _qSetUserData(volatile struct _qTask_t *Task, void* arg);
    void _qClearTimeElapse(volatile struct _qTask_t *Task);
# 21 "QuarkTS.c" 2

volatile QuarkTSCoreData_t QUARKTS;
static void _qTriggerEvent(volatile struct _qTask_t *Task, qTrigger_t Event);
static void _qTaskChainbyPriority(void);
static volatile struct _qTask_t* _qDequeueTaskEvent(void);



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

void _qEnableDisable(volatile struct _qTask_t *Task, unsigned char Value){
    if(Value) Task->TimeElapsed = 0;
    Task->Flag.State = Value;
    if(!Value) Task->TimeElapsed = 0;
}

void _qSetUserData(volatile struct _qTask_t *Task, void* arg){
    Task->UserData = arg;
}

void _qClearTimeElapse(volatile struct _qTask_t *Task){
    Task->TimeElapsed = 0;
}

int _qEnqueueTaskEvent(volatile struct _qTask_t *TasktoQueue, void* eventdata){
    if(QUARKTS.QueueIndex>QUARKTS.QueueSize-1 ) return -1;
    while (QUARKTS.NotSafeQueue){}
    QUARKTS.NotSafeQueue = 1;
    qQueueStack_t qtmp;
    qtmp.Task = TasktoQueue;
    qtmp.QueueData = eventdata;
# 83 "QuarkTS.c"
    QUARKTS.QueueStack[QUARKTS.QueueIndex] = qtmp;


    QUARKTS.QueueIndex++;
    if(QUARKTS.QueueIndex==1){
        QUARKTS.NotSafeQueue = 0;
        return 0;
    }
# 104 "QuarkTS.c"
    QUARKTS.NotSafeQueue = 0;
    return 0;
}
# 126 "QuarkTS.c"
static volatile struct _qTask_t* _qDequeueTaskEvent(void){
    volatile struct _qTask_t *Task;
    if( QUARKTS.QueueStack[0].Task != ((void *)0)){
        while (QUARKTS.NotSafeQueue){}
        Task = QUARKTS.QueueStack[0].Task;
        QUARKTS.EventInfo.EventData = QUARKTS.QueueStack[0].QueueData;
        QUARKTS.QueueStack[0].Task = ((void *)0);
        if( QUARKTS.QueueIndex>0) QUARKTS.QueueIndex--;
        memmove((void*)QUARKTS.QueueStack, (const void*)(QUARKTS.QueueStack+1), QUARKTS.QueueSize*sizeof(qQueueStack_t));
        return Task;
    }
    return ((void *)0);
}


void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, unsigned char Size_Q_Stack){
    unsigned char i;
    QUARKTS.First = ((void *)0);
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.QueueStack = Q_Stack;
    QUARKTS.QueueSize = Size_Q_Stack;
    for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = ((void *)0);
    QUARKTS.QueueIndex = 0;
    QUARKTS.Flag.Init = 0;
    QUARKTS.NotSafeQueue = 0;
}

void _qISRHandler(void){
    if(!QUARKTS.Flag.Init) return;
    volatile struct _qTask_t *Task = QUARKTS.First;
    while(Task != ((void *)0)){
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
    if (((Time/2)<QUARKTS.Tick && Time) || CallbackFcn == ((void *)0)) return -1;
    Task->Callback = CallbackFcn;
    Task->TimeElapsed = 0;
    Task->Interval = (qClock_t)(Time/QUARKTS.Tick);
    Task->UserData = arg;
    Task->Priority = Priority;
    Task->Iterations = nExecutions;
    Task->Flag.AsyncRun = Task->Flag.InitFlag = Task->Flag.TimedTaskRun = 0;
    Task->Flag.State = (unsigned char)(InitialState != 0);
    Task->Next = QUARKTS.First;
    QUARKTS.First = Task;
    return 0;
}

static void _qTriggerEvent(volatile struct _qTask_t *Task, qTrigger_t Event){
    QUARKTS.EventInfo.Trigger = Event;
    QUARKTS.EventInfo.FirstCall = (unsigned char)(!Task->Flag.InitFlag);
    QUARKTS.EventInfo.UserData = Task->UserData;
    if (Task->Callback != ((void *)0)) Task->Callback(QUARKTS.EventInfo);
    Task->Flag.InitFlag = 1;
    QUARKTS.EventInfo.EventData = ((void *)0);
}

static void _qTaskChainbyPriority(void){
    volatile struct _qTask_t *a = ((void *)0), *b = ((void *)0), *c = ((void *)0), *e = ((void *)0), *tmp = ((void *)0);
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
    while(Task != ((void *)0)){
        if ((qTask = _qDequeueTaskEvent())!=((void *)0)) _qTriggerEvent(qTask, byQueueExtraction);
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
        else if( QUARKTS.IDLECallback!= ((void *)0)){
            QUARKTS.EventInfo.FirstCall = (unsigned char)(!QUARKTS.Flag.FCallIdle);
            QUARKTS.EventInfo.Trigger = byPriority;
            QUARKTS.IDLECallback(QUARKTS.EventInfo);
            QUARKTS.Flag.FCallIdle = 1;
        }
        Task = Task->Next;
    }
    goto pMainSchedule;
}
