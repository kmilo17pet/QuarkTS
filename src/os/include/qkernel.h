#ifndef QKERNEL_H
    #define QKERNEL_H

    #include "qtypes.h"
    #include "qcritical.h"
    #include "qclock.h"
    #if (Q_QUEUES == 1)
        #include "qqueues.h"
    #endif
    #if ( Q_FSM == 1)
        #include "qfsm.h"
    #endif

    typedef enum {qTriggerNULL, byTimeElapsed, byNotificationQueued, byNotificationSimple, byQueueReceiver, byQueueFull, byQueueCount, byQueueEmpty, bySchedulingRelease, byNoReadyTasks} qTrigger_t;

    #define qTrigger_NotificationSimple byNotificationSimple
    #define qTrigger_NotificationQueued byNotificationQueued
    #define qTrigger_TimeElapsed        byTimeElapsed
    #define qTrigger_QueueReceiver      byQueueReceiver
    #define qTrigger_QueueFull          byQueueFull
    #define qTrigger_QueueCount         byQueueCount
    #define qTrigger_QueueEmpty         byQueueEmpty
    #define qTrigger_SchedulingRelease  bySchedulingRelease
    #define qTrigger_NoReadyTasks       byNoReadyTasks
    
    /*backward compatibility*/
    #ifndef PERIODIC 
        #define PERIODIC            qPeriodic
    #endif
    
    #ifndef INDEFINITE
        #define INDEFINITE          qIndefinite
    #endif
    
    #ifndef SINGLESHOT
        #define SINGLESHOT          qSingleShot
    #endif
    
    #ifndef TIME_IMMEDIATE
        #define TIME_IMMEDIATE      qTimeImmediate
    #endif 


    typedef struct{
        /* TaskData (Storage-Pointer):
        Task arguments defined at the time of its creation.
        */
        void *TaskData;
        /* EventData:
        Associated data of the event. Specific data will reside here according
        to the event source. This field will only have a NULL value when the 
        trigger is <byTimeElapsed> or <byPriority>.
         */
        void *EventData;
        /* Trigger:
        This flag indicates the event source that triggers the task execution.
        
         
        This flag can only have the following values:        
        
        - byTimeElapsed : When the time specified for the task elapsed.
                
        - byNotificationQueued: When there is a queued notification in the FIFO
                                priority queue. For this trigger, the dispacher 
                                performs a dequeue operation automatically. A 
                                pointer to the extracted event data will be available 
                                in the <EventData> field.
        
        - byNotificationSimple: When the execution chain does, according to a 
                        requirement of asynchronous notification event prompted 
                        by qSendEvent. A pointer to the dequeued data will be 
                        available in the <EventData> field.
        
        - byQueueReceiver: When there are elements available in the attached qQueue,
                        the scheduler make a data dequeue (auto-receive) from the
                        front. A pointer to the received data will be 
                        available in the <EventData> field.
        
        - byQueueFull: When the  attached qQueue is full. A pointer to the 
                         queue will be available in the <EventData> field.
         
        - byQueueCount: When the element-count of the  attached qQueue reaches
                         the specified value. A pointer to the queue will 
                         be available in the <EventData> field.
        
        - byQueueEmpty: When the  attached qQueue is empty.  A pointer to the 
                        queue will be available in the <EventData> field.
        
        - byNoReadyTasks: Only when the Idle Task is triggered.
        */
        qTrigger_t Trigger;
        /* FirstCall:
        This flag indicates that a task is running for the first time. 
        This flag can be used for data initialization purposes.
        */
        qBool_t FirstCall;
        /* FirstIteration:
        Indicates whether current pass is the first iteration of the task. 
        This flag will be only set when time-elapsed events occurs and the
        Iteration counter has been parameterized. Asynchronous events never change
        the task iteration counter, consequently doesn't have effect in this flag 
        */
        qBool_t FirstIteration;
        /* LastIteration:
        Indicates whether current pass is the last iteration of the task. 
        This flag will be only set when time-elapsed events occurs and the
        Iteration counter has been parameterized. Asynchronous events never change
        the task iteration counter, consequently doesn't have effect in this flag 
        */
        qBool_t LastIteration;
    }_qEvent_t_/*, *const qEvent_t*/;  
    typedef const _qEvent_t_ *qConst qEvent_t;

typedef void (*qTaskFcn_t)(qEvent_t);  

    typedef uint8_t qNotifier_t;
    #define QMAX_NOTIFICATION_VALUE     ( 0xFFu )

    typedef uint8_t qTaskState_t;
    #define qWaiting    ( 0u )
    #define qReady      ( 1u )
    #define qRunning    ( 2u )
    #define qSuspended  ( 3u )

    typedef struct _qTask_t{ /*Task node definition*/
        struct _qTask_t *Next; /*pointer to the next node*/
        void *TaskData,*AsyncData; /*the storage pointers*/
        qTaskFcn_t Callback; 
        #if ( Q_FSM == 1)
            qSM_t *StateMachine; /*pointer to the linked FSM*/
        #endif
        #if ( Q_QUEUES == 1)
            qQueue_t *Queue; /*pointer to the attached queue RBuffer*/
        #endif
        volatile qClock_t Interval, ClockStart; /*time-epochs registers*/
        #if ( Q_TASK_COUNT_CYCLES == 1 )
            uint32_t Cycles; 
        #endif
        qTrigger_t Trigger; 
        qIteration_t Iterations; 
        qPriority_t Priority; 
        qTaskState_t State;
        volatile qNotifier_t Notification;
        volatile qBool_t Flag[6]; /*task related flags*/
    }qTask_t;

    typedef struct{
        qTask_t *Task; /*the pointed task*/
        void *QueueData; 
    }qQueueStack_t;  

    #define qLowest_Priority        ((qPriority_t)(0x00u))
    #define qMedium_Priority        ((qPriority_t)(0x7Fu))
    #define qHigh_Priority          ((qPriority_t)(0xFEu))
    #define qPeriodic               ((qIteration_t)(-32768))
    #define qIndefinite             qPeriodic
    #define qSingleShot             ((qIteration_t)(1))

    #define LOWEST_Priority         qLowest_Priority
    #define MEDIUM_Priority         qMedium_Priority
    #define HIGH_Priority           qHigh_Priority

    #define _qIndex_InitFlag        ( 0 )
    #define _qIndex_Enabled         ( 1 )
    #define _qIndex_QueueReceiver   ( 2 )
    #define _qIndex_QueueFull       ( 3 )
    #define _qIndex_QueueCount      ( 4 )
    #define _qIndex_QueueEmpty      ( 5 )


    typedef qTask_t** qHeadPointer_t;         

    typedef struct{ /*Scheduler Core-Flags*/
    	volatile qBool_t Init;
        qBool_t FCallIdle;
        #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
            volatile qBool_t ReleaseSched, FCallReleased;
        #endif
    }qTaskCoreFlags_t;

    typedef struct{ /*Main scheduler core data*/
        #if ( Q_PRIORITY_QUEUE == 1 )
            volatile int16_t QueueIndex; /*holds the current queue index*/
            uint8_t QueueSize;
            qQueueStack_t *QueueStack; /*a pointer to the queue stack*/
            void *QueueData;                 
        #endif 
            qTaskFcn_t IDLECallback;    
        #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
            qTaskFcn_t ReleaseSchedCallback;
        #endif
        qTask_t *Head;
        volatile qTaskCoreFlags_t Flag;
        qTask_t *CurrentRunningTask;
        _qEvent_t_ EventInfo;
    }QuarkTSCoreData_t;

    #if ( Q_PRIORITY_QUEUE == 1 )    
        #define _qQueueStackName                    _qQueueStack
        #define _qQueueStackCreate(QueueSize)       volatile qQueueStack_t _qQueueStackName[(QueueSize)];
        #define _qQueueLength(QueueSize)            (QueueSize)
    #else
        #define _qQueueStackName                    NULL           
        #define _qQueueStackCreate(QueueSize)       
        #define _qQueueLength(QueueSize)            ( 0 )                             
    #endif

    typedef qBool_t (*qTaskNotifyMode_t)(qTask_t*, void*);
    #define Q_NOTIFY_SIMPLE      qTaskSendNotification
    #define Q_NOTIFY_QUEUED      qTaskQueueNotification

    #if (Q_SETUP_TIME_CANONICAL == 1)
        void _qInitScheduler( const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, const uint8_t Size_Q_Stack );
    #else
        void _qInitScheduler( const qGetTickFcn_t TickProvider, const qTimingBase_type BaseTimming, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, const uint8_t Size_Q_Stack );
    #endif

    qTask_t* qTaskSelf( void );

    void qSchedulerSetIdleTask( qTaskFcn_t Callback );
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        void qSchedulerRelease( void );
        void qSchedulerSetReleaseCallback( qTaskFcn_t Callback );
    #endif    
    qBool_t qSchedulerSpreadNotification( void *eventdata, const qTaskNotifyMode_t mode );
    
    qBool_t qSchedulerAdd_Task( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg );
    qBool_t qSchedulerAdd_EventTask( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg );
    #if ( Q_FSM == 1)
        qBool_t qSchedulerAdd_StateMachineTask( qTask_t * const Task, qPriority_t Priority, qTime_t Time,
                            qSM_t * const StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg );
    #endif

    qBool_t qSchedulerRemoveTask( qTask_t *Task );
    void qSchedulerRun( void );

    /*void qSchedulerSetup(qGetTickFcn_t TickProviderFcn,  qTime_t ISRTick, qTaskFcn_t IDLE_Callback, unsigned char QueueSize)
        
    Task Scheduler Setup. This function is required and must be called once in 
    the application main thread before any tasks creation.

    Parameters:

        - TickProviderFcn :  The function that provides the tick value. If the user application 
                            uses the qSchedulerSysTick from the ISR, this parameter can be NULL.
                            Note: Function should take void and return a 32bit value. 

        - TimmingBase : This parameter specifies the ISR background timer base time.
                        This can be the period in seconds(Floating-point format) or frequency 
                        in Herzt(Only if Q_SETUP_TICK_IN_HERTZ is enabled).

        - IDLE_Callback : Callback function to the Idle Task. To disable the 
                        Idle Task functionality, pass NULL as argument.

        - QueueSize : Size of the priority queue for notifications. This argument should be an integer
                    number greater than zero
        */
    #if (Q_SETUP_TIME_CANONICAL == 1)
        #define qSchedulerSetup( TickProviderFcn, TimmingBase, IDLE_Callback, QueueSize )                                   _qQueueStackCreate(QueueSize) _qInitScheduler((qGetTickFcn_t)(TickProviderFcn), (IDLE_Callback), _qQueueStackName, _qQueueLength(QueueSize) )
    #else 
        #define qSchedulerSetup( TickProviderFcn, TimmingBase, IDLE_Callback, QueueSize )                                   _qQueueStackCreate(QueueSize) _qInitScheduler((qGetTickFcn_t)(TickProviderFcn), (TimmingBase), (IDLE_Callback), _qQueueStackName, _qQueueLength(QueueSize) )
    #endif


    #if ( Q_QUEUES == 1 )
        typedef enum{
            qQUEUE_RECEIVER =   _qIndex_QueueReceiver, 
            qQUEUE_FULL     =   _qIndex_QueueFull, 
            qQUEUE_COUNT    =   _qIndex_QueueCount, 
            qQUEUE_EMPTY    =   _qIndex_QueueEmpty
        }qQueueLinkMode_t;

        #define QUEUE_RECEIVER          ( qQUEUE_RECEIVER )  
        #define QUEUE_FULL              ( qQUEUE_FULL )
        #define QUEUE_COUNT             ( qQUEUE_COUNT )
        #define QUEUE_EMPTY             ( qQUEUE_EMPTY )
        qBool_t qTaskAttachQueue( qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const uint8_t arg );
    #endif

    qBool_t qTaskSendNotification( qTask_t * const Task, void* eventdata);
    qBool_t qTaskQueueNotification( qTask_t * const Task, void* eventdata );
    qBool_t qTaskIsEnabled( const qTask_t *const Task );
    #if ( Q_TASK_COUNT_CYCLES == 1 )
        uint32_t qTaskGetCycles( const qTask_t * const Task );   
    #endif
    void qTaskSetTime( qTask_t * const Task, const qTime_t Value );
    void qTaskSetIterations( qTask_t * const Task, const qIteration_t Value );
    void qTaskSetPriority( qTask_t * const Task, const qPriority_t Value );
    void qTaskSetCallback( qTask_t * const Task, const qTaskFcn_t CallbackFcn );
    void qTaskSetState(qTask_t * const Task, const qState_t State);
    void qTaskSetData( qTask_t * const Task, void* arg );
    void qTaskClearTimeElapsed( qTask_t * const Task );

    #if ( Q_FSM == 1 ) 
        qBool_t qTaskAttachStateMachine( qTask_t * const Task, qSM_t * const StateMachine );
    #endif

    /*void qTaskSuspend(qTask_t *Task)

    Put the task into a disabled state.    

    Parameters:

        - Task : A pointer to the task node.
    */
    #define qTaskSuspend(pTask_)    qTaskSetState((pTask_), qDisabled)
    /*void qTaskResume(qTask_t *Task)

    Put the task into a enabled state.    

    Parameters:

    - Task : A pointer to the task node.
    */
    #define qTaskResume(pTask_)    qTaskSetState((pTask_), qEnabled)



#endif /*QKERNEL_H*/