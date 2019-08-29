/*This file is part of the QuarkTS distribution.*/
#ifndef QTASKS_H
    #define QTASKS_H

    #include "qtypes.h"
    #include "qclock.h"
    
    #if (Q_QUEUES == 1)
        #include "qqueues.h"
    #endif

    #if ( Q_FSM == 1)
        #include "qfsm.h"
    #endif  

    #if ( Q_ATCOMMAND_PARSER == 1)
        #include "qatparser.h"
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

    typedef uint8_t qNotifier_t;        
    #define QMAX_NOTIFICATION_VALUE     ( 0xFFu )

    typedef uint8_t qTaskState_t;
    #define qWaiting    ( 0u )
    #define qReady      ( 1u )
    #define qRunning    ( 2u )
    #define qSuspended  ( 3u )

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
            struct _qTask_t *Next;                  /*< Points to the next node of the task list. */
            void *TaskData,*AsyncData;              /*< The task Storate pointers. */
            qTaskFcn_t Callback;                    /*< The callback function representing the task activities. */
            #if ( Q_FSM == 1)
                qSM_t *StateMachine;                /*< The pointer to the attached state-machine. */
            #endif
            #if ( Q_QUEUES == 1)
                qQueue_t *Queue;                    /*< The pointer to the attached queue. */
            #endif
            volatile qClock_t Interval, ClockStart; /*< The timestamps of the task in epochs. */
            #if ( Q_TASK_COUNT_CYCLES == 1 )
                uint32_t Cycles;                    /*< The current number of executions performed by the task. */
            #endif
            qTrigger_t Trigger;                     /*< The event source that put the task in a qReady state. */
            qIteration_t Iterations;                /*< Holds the number of iterations. */
            qPriority_t Priority;                   /*< The task priority. */
            qTaskState_t State;                     /*< The task state (set by the scheduler). */
            volatile qNotifier_t Notification;      /*< The notification value. */
            volatile qBool_t Flag[6];               /*< Task related flags (used by the scheduler). */            
        }private_end;
    }qTask_t;

    #define _qIndex_InitFlag        ( 0 )
    #define _qIndex_Enabled         ( 1 )
    #define _qIndex_QueueReceiver   ( 2 )
    #define _qIndex_QueueFull       ( 3 )
    #define _qIndex_QueueCount      ( 4 )
    #define _qIndex_QueueEmpty      ( 5 )

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
    #endif

    #define Q_NOTIFY_SIMPLE      qTaskSendNotification
    #define Q_NOTIFY_QUEUED      qTaskQueueNotification

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
    /*qTask_t* qTaskSelf(void)

    Get current running task handle.

    Return value:

        A pointer to the current running task.
        NULL when the scheduler it's in a busy state or when IDLE Task is running.
    */
    #define qTaskSelf               _qScheduler_GetTaskRunning

    #if ( Q_QUEUES == 1 )
        qBool_t qTaskAttachQueue( qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const uint8_t arg );
    #endif 

    #if ( Q_FSM == 1 ) 
        qBool_t qTaskAttachStateMachine( qTask_t * const Task, qSM_t * const StateMachine );
    #endif


#endif /* QTASKS_H */