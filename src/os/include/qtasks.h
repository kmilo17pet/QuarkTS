/*This file is part of the QuarkTS distribution.*/
#ifndef QTASKS_H
    #define QTASKS_H

    #include "qtypes.h"
    #include "qstimers.h"
    #include "qlists.h"
    
    #if (Q_QUEUES == 1)
        #include "qqueues.h"
    #endif

    #if ( Q_FSM == 1)
        #include "qfsm.h"
    #endif  

    #if ( Q_ATCOMMAND_PARSER == 1)
        #include "qatparser.h"
    #endif

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef enum {  qTriggerNULL, 
                    byTimeElapsed, 
                    byNotificationQueued, 
                    byNotificationSimple, 
                    byQueueReceiver, 
                    byQueueFull, 
                    byQueueCount, 
                    byQueueEmpty, 
                    byEventFlags,
                    bySchedulingRelease, 
                    byNoReadyTasks
                }qTrigger_t;

    #define qTrigger_NotificationSimple     ( byNotificationSimple )
    #define qTrigger_NotificationQueued     ( byNotificationQueued )
    #define qTrigger_TimeElapsed            ( byTimeElapsed )
    #define qTrigger_QueueReceiver          ( byQueueReceiver )
    #define qTrigger_QueueFull              ( byQueueFull )
    #define qTrigger_QueueCount             ( byQueueCount )
    #define qTrigger_QueueEmpty             ( byQueueEmpty )
    #define qTrigger_byEventFlags           ( byEventFlags )
    #define qTrigger_SchedulingRelease      ( bySchedulingRelease )
    #define qTrigger_NoReadyTasks           ( byNoReadyTasks )

    typedef qUINT32_t qNotifier_t;       
    typedef qUINT32_t qTaskFlag_t; 
    #define QMAX_NOTIFICATION_VALUE         ( 0xFFFFFFFFuL )

    /*typedef qUINT8_t qTaskState_t;
    #define qWaiting    ( 0u )
    #define qReady      ( 1u )
    #define qRunning    ( 2u )
    #define qSuspended  ( 3u )
    #define qSleeping   ( 4u )
    */


    /* Task flags
    MSB_________________________________________________________________________________________________________________________________________________________LSB
    31                  |                 |            |            |               |               |              |                  |             |           0
    |(31..11)EVENTFLAGS |  (10..8)-STATE  | 7-REM.REQ  | 6-SHUTDOWN | 5-QUEUE_EMPTY | 4-QUEUE_COUNT | 3-QUEUE_FULL | 2-QUEUE_RECEIVER |  1-ENABLED  |  0-INIT   |
    |___________________|_________________|____________|____________|_______________|_______________|______________|__________________|_____________|___________|
    */
    #define QTASK_COREBITS_RSMASK       ( 0x000000FFuL )	 
    #define QTASK_COREBITS_WMASK        ( 0xFFFFFF00uL )
    #define QTASK_COREBITS_OFFSET       ( 0 )

    #define QTASK_STATEBITS_RMASK	    ( 0x00000F00uL )
    #define QTASK_STATEBITS_WMASK	    ( 0xFFFFF0FFuL )
    #define QTASK_STATEBITS_OFFSET      ( 8 )

    #define QTASK_EVENTFLAGS_RMASK	    ( 0xFFFFF000uL )
    #define QTASK_EVENTFLAGS_WMASK	    ( 0x00000FFFuL )
    #define QTASK_EVENTFLAGS_OFFSET     ( 12 )
    
    #define __QTASK_QUEUEFLAGS_MASK     ( 0x0000003CuL )
    #define __QTASK_BIT_INIT            ( 0x00000001uL )  
    #define __QTASK_BIT_ENABLED         ( 0x00000002uL )
    #define __QTASK_BIT_QUEUE_RECEIVER  ( 0x00000004uL )
    #define __QTASK_BIT_QUEUE_FULL      ( 0x00000008uL )
    #define __QTASK_BIT_QUEUE_COUNT     ( 0x00000010uL )
    #define __QTASK_BIT_QUEUE_EMPTY     ( 0x00000020uL )
    #define __QTASK_BIT_SHUTDOWN        ( 0x00000040uL )
    #define __QTASK_BIT_REMOVE_REQUEST  ( 0x00000080uL )

    /*The task Bit-Flag definitions*/
    #define QEVENTFLAG_01               ( 0x00001000uL )
    #define QEVENTFLAG_02               ( 0x00002000uL )
    #define QEVENTFLAG_03               ( 0x00004000uL )
    #define QEVENTFLAG_04               ( 0x00008000uL )
    #define QEVENTFLAG_05               ( 0x00010000uL )
    #define QEVENTFLAG_06               ( 0x00020000uL )
    #define QEVENTFLAG_07               ( 0x00040000uL )
    #define QEVENTFLAG_08               ( 0x00080000uL )
    #define QEVENTFLAG_09               ( 0x00100000uL )
    #define QEVENTFLAG_10               ( 0x00200000uL )
    #define QEVENTFLAG_11               ( 0x00400000uL )
    #define QEVENTFLAG_12               ( 0x00800000uL )
    #define QEVENTFLAG_13               ( 0x01000000uL )
    #define QEVENTFLAG_14               ( 0x02000000uL )
    #define QEVENTFLAG_15               ( 0x04000000uL )
    #define QEVENTFLAG_16               ( 0x08000000uL )
    #define QEVENTFLAG_17               ( 0x10000000uL )
    #define QEVENTFLAG_18               ( 0x20000000uL )
    #define QEVENTFLAG_19               ( 0x40000000uL )
    #define QEVENTFLAG_20               ( 0x80000000uL )

    #define QEVENTFLAG_CLEAR            ( qFalse )
    #define QEVENTFLAG_SET              ( qTrue )

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
    typedef const _qEvent_t_ *qEvent_t;

    typedef void (*qTaskFcn_t)(qEvent_t arg);  

    typedef struct _qTask_t{ /*Task node definition*/
        private_start{
            qNode_MinimalFields;
            void *TaskData, *AsyncData;             /*< The task storage pointers. */
            qTaskFcn_t Callback;                    /*< The callback function representing the task activities. */
            #if ( Q_FSM == 1)
                qSM_t *StateMachine;                /*< The pointer to the attached state-machine. */
            #endif
            #if ( Q_QUEUES == 1)
                qQueue_t *Queue;                    /*< The pointer to the attached queue. */
                qUINT32_t QueueCount;
            #endif
            qSTimer_t timer;                        /*< To handle the task timming*/
            #if ( Q_TASK_COUNT_CYCLES == 1 )
                qCycles_t Cycles;                   /*< The current number of executions performed by the task. */
            #endif
            #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
                size_t Entry;
            #endif
            qIteration_t Iterations;                /*< Holds the number of iterations. */
            volatile qNotifier_t Notification;      /*< The notification value. */          
            volatile qTaskFlag_t Flags;             /*< Task flags (core and eventflags)*/
            qTrigger_t Trigger;                     /*< The event source that put the task in a qReady state. */
            qPriority_t Priority;                   /*< The task priority. */
        }private_end;
    }qTask_t;

   
    #if ( Q_QUEUES == 1 )
        typedef qUINT32_t qQueueLinkMode_t;
        #define qQUEUE_RECEIVER         ( __QTASK_BIT_QUEUE_RECEIVER )
        #define qQUEUE_FULL             ( __QTASK_BIT_QUEUE_FULL )
        #define qQUEUE_COUNT            ( __QTASK_BIT_QUEUE_COUNT )
        #define qQUEUE_EMPTY            ( __QTASK_BIT_QUEUE_EMPTY )

        #define QUEUE_RECEIVER          ( qQUEUE_RECEIVER )  
        #define QUEUE_FULL              ( qQUEUE_FULL )
        #define QUEUE_COUNT             ( qQUEUE_COUNT )
        #define QUEUE_EMPTY             ( qQUEUE_EMPTY )
    #endif

    #define Q_NOTIFY_SIMPLE             ( &qTaskSendNotification )
    #define Q_NOTIFY_QUEUED             ( &qTaskQueueNotification )

    qBool_t qTaskSendNotification( qTask_t * const Task, void* eventdata);
    qBool_t qTaskQueueNotification( qTask_t * const Task, void* eventdata );
    qState_t qTaskGetState( const qTask_t * const Task);
    #if ( Q_TASK_COUNT_CYCLES == 1 )
        qCycles_t qTaskGetCycles( const qTask_t * const Task );   
    #endif
    void qTaskSetTime( qTask_t * const Task, const qTime_t Value );
    void qTaskSetIterations( qTask_t * const Task, const qIteration_t Value );
    void qTaskSetPriority( qTask_t * const Task, const qPriority_t Value );
    void qTaskSetCallback( qTask_t * const Task, const qTaskFcn_t CallbackFcn );
    void qTaskSetState( qTask_t * const Task, const qState_t State );
    void qTaskSetData( qTask_t * const Task, void* arg );
    void qTaskClearTimeElapsed( qTask_t * const Task );

    /*void qTaskSuspend(qTask_t *Task)

    Put the task into a disabled state.    

    Parameters:

        - Task : A pointer to the task node.
    */
    #define qTaskSuspend(pTask_)    qTaskSetState((pTask_), qDisabled)
    #define qTaskDisable(pTask_)    qTaskSetState((pTask_), qDisabled)
    /*void qTaskResume(qTask_t *Task)

    Put the task into a enabled state.    

    Parameters:

    - Task : A pointer to the task node.
    */
    #define qTaskResume(pTask_)    qTaskSetState((pTask_), qEnabled)
    #define qTaskEnable(pTask_)    qTaskSetState((pTask_), qEnabled)
        /*qTask_t* qTaskSelf(void)

    Get current running task handle.

    Return value:

        A pointer to the current running task.
        NULL when the scheduler it's in a busy state or when IDLE Task is running.
    */
    #define qTaskSelf               _qScheduler_GetTaskRunning
    /*void qTaskASleep(qTask_t *Task)

    Put the task into a qSLEEP state. The task can't be triggered
    by the lower precedence events.    
 
    Note: Only the higher precedence events (Queued Notifications) can
          wake up the task.

    Parameters:

    - Task : A pointer to the task node.
    */
    #define qTaskASleep(pTask_)         qTaskSetState((pTask_), qAsleep)
    /*void qTaskAwake(qTask_t *Task)

    Put the task into a normal operation state. Here the task
    will be able to catch any kind of events.
 
    Parameters:

    - Task : A pointer to the task node.
    */    
    #define qTaskAwake(pTask_)          qTaskSetState((pTask_), qAwake)
    /*qBool_t qTaskIsEnabled(const qTask_t *Task)

    Retrieve the enabled/disabled state

    Parameters:

        Pointer to the task node.

    Return value:

        True if the task in on Enabled state, otherwise returns false.
    */  
    #define qTaskIsEnabled(pTask_)      ( qEnabled == qTaskGetState((pTask_) ) )

    #if ( Q_QUEUES == 1 )
        qBool_t qTaskAttachQueue( qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const qUINT16_t arg );
    #endif 

    #if ( Q_FSM == 1 ) 
        qBool_t qTaskAttachStateMachine( qTask_t * const Task, qSM_t * const StateMachine );
    #endif

    void qTaskModifyEventFlags( qTask_t * const Task, qTaskFlag_t flags, qBool_t action );
    qTaskFlag_t qTaskReadEventFlags( const qTask_t * const Task ); 
    qBool_t qTaskCheckEventFlags( qTask_t * const Task, qTaskFlag_t FlagsToCheck, qBool_t ClearOnExit, qBool_t CheckForAll );

    /*============================================================================*/
    /*
        PRIVATE : THIS FUNCTIONS ARE NOT INTENDED FOR THE USER USAGE
    */
    /*============================================================================*/
    qBool_t __qPrivate_TaskGetFlag( const qTask_t * const Task, qUINT32_t flag);
    void __qPrivate_TaskModifyFlags( qTask_t * const Task, qUINT32_t flags, qBool_t value);
    /*============================================================================*/
    
    #ifdef __cplusplus
    }
    #endif

#endif /* QTASKS_H */