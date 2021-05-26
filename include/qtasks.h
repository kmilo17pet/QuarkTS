/*!
 * @file qtasks.h
 * @author J. Camilo Gomez C.
 * @version 3.26
 * @note This file is part of the QuarkTS distribution.
 * @brief API interface to manage tasks.
 **/
#ifndef QTASKS_H
    #define QTASKS_H

    #include "qtypes.h"
    #include "qstimers.h"
    #include "qlists.h"
    
    #if (Q_QUEUES == 1)
        #include "qqueues.h"
    #endif

    #if ( Q_FSM == 1 )
        #include "qfsm.h"
    #endif  

    #if ( Q_ATCLI == 1 )
        #include "qatcli.h"
    #endif

    #ifdef __cplusplus
    extern "C" {
    #endif

    /** @addtogroup qtaskmanip
    * @brief API interface to manage tasks.
    *  @{
    */

    /**
    * @brief An enum with all the possible values for the Trigger member of qEvent_t task argument
    */
    typedef enum {  
        /**
        * @brief To indicate the abscense of trigger.
        */         
        qTriggerNULL,
        /**
        * @brief When the time specified for the task elapsed.
        */                     
        byTimeElapsed, 
        /**
        * @brief When there is a queued notification in the FIFO
        * priority queue. For this trigger, the dispacher performs 
        * a dequeue operation automatically. A pointer to the 
        * extracted event data will be available in the <b>EventData</b> field. 
        */ 
        byNotificationQueued,
        /**
        * @brief When the execution chain does, according to a 
        * requirement of asynchronous notification event prompted 
        * by <b>qTask_SendEvent</b>. A pointer to the dequeued data will be 
        * available in the <b>EventData</b> field.
        */                     
        byNotificationSimple, 
        /**
        * @brief When there are elements available in the attached qQueue,
        * the scheduler make a data dequeue (auto-receive) from the
        * front. A pointer to the received data will be available in 
        * the <b>EventData</b> field.
        */                     
        byQueueReceiver, 
        /**
        * @brief When the time specified for the task elapsed.
        */                     
        byQueueFull, 
        /**
        * @brief When the  attached qQueue is full. A pointer to the 
        * queue will be available in the <b>EventData</b> field.
        */                     
        byQueueCount, 
        /**
        * @brief When the element-count of the  attached qQueue reaches
        * the specified value. A pointer to the queue will 
        * be available in the <b>EventData</b> field.
        */                     
        byQueueEmpty, 
        /**
        * @brief When the time specified for the task elapsed.
        */                     
        byEventFlags,
        /**
        * @brief When any event-flag is set.
        */                     
        bySchedulingRelease, 
        /**
        * @brief Only available when the Idle Task is triggered.
        */                     
        byNoReadyTasks
    }qTrigger_t;

    /** @brief A 32-bit unsigned integer type to hold a notification value.*/
    typedef qUINT32_t qNotifier_t;       

    /** @brief A 32-bit unsigned integer type to hold the task flags.*/
    typedef qUINT32_t qTask_Flag_t; 

    /** @brief Max allowed notification value*/
    #define QMAX_NOTIFICATION_VALUE         ( 0xFFFFFFFFuL )

    /**
    * @brief An enum to describe the task global state.
    */
    typedef enum{
        qUndefinedGlobalState,  /**< A task should never reach this state(only used internally) */
        qReady,                 /**< The task has completed preparations for running, but cannot run because a task with a higher precedence is running. */
        qWaiting,               /**< The task cannot run because the conditions for running are not in place. */
        qSuspended,             /**< The task doesn't take part in what is going on. Normally this state is taken after the qRunning state or when the task doesn't reach the qReady state*/
        qRunning                /**< The task is currently being executed. */
    }qTask_GlobalState_t;

    #if ( Q_TASK_EVENT_FLAGS == 1 )
        /*! @cond PRIVATE */
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
        /*! @endcond PRIVATE */
        /** @brief A macro directive to indicate if the eventflags should be cleared. */
        #define QEVENTFLAG_CLEAR            ( qFalse )

        /** @brief A macro directive to indicate if the eventflags should be set. */
        #define QEVENTFLAG_SET              ( qTrue )
    #endif

    /** 
    * @brief The task argument with all the regarding information of the task execution.
    * @note Should be used only in task-callbacks as the only input argument. 
    * @note The members of this structure must be read as if it were a pointer.
    */
    typedef struct _qEvent_s{
        /** 
        * @brief Task arguments defined at the time of its creation. (Storage-Pointer) 
        */
        void *TaskData;
        /** 
        * @brief Associated data of the event. Specific data will reside here according to 
        * the event source. This field will only have a NULL value when the trigger 
        * is <b>byTimeElapsed</b> or <b>byPriority</b>.
        */
        void *EventData;
        /** 
        * @brief This member indicates the event source that triggers the task execution. 
        * Possible values are described in the qTrigger_t enum typedef.
        */        
        qTrigger_t Trigger;  
        /** 
        * @brief This field indicates that a task is running for the first time. Can be used
        * for data initialization purposes.
        */              
        qBool_t FirstCall;
        /** 
        * @brief Indicates whether current pass is the first iteration of the task. 
        * This flag will be only set when time-elapsed events occurs and the
        * Iteration counter has been parameterized. Asynchronous events never change
        * the task iteration counter, consequently doesn't have effect in this flag 
        */            
        qBool_t FirstIteration; 
        /** 
        * @brief Indicates whether current pass is the last iteration of the task. 
        * This flag will be only set when time-elapsed events occurs and the
        * Iteration counter has been parameterized. Asynchronous events never change
        * the task iteration counter, consequently doesn't have effect in this flag 
        */            
        qBool_t LastIteration;
        /** 
        * @brief The number of epochs between current system time and point in time when the 
        * task was marked as Ready.
        * Can be used to keep track when current task's execution took place relative 
        * to when it was scheduled
        * A value of 0 (zero) indicates that task started right on time per schedule.
        * This parameter will be only available on timed tasks. when Trigger == byTimeElapsed
        */              
        qClock_t StartDelay;
    #ifdef DOXYGEN
    }qEvent_t;
    #else
    }_qEvent_t_/*, *const qEvent_t*/;  
    typedef const _qEvent_t_ *qEvent_t;
    #endif    

    /**
    * @brief Pointer to a task callback.
    */
    typedef void (*qTaskFcn_t)( qEvent_t arg );  

    /** 
    * @brief A task node object
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qTask_s{ /*Task node definition*/
        /*! @cond PRIVATE */
        struct _qTask_Private_s{    /*Task control block - TCB*/
            qNode_MinimalFields;
            void *TaskData, *AsyncData;             /**< internalThe task storage pointers. */
            qTaskFcn_t Callback;                    /**< The callback function representing the task activities. */
            #if ( Q_FSM == 1 )
                qSM_t *StateMachine;                /**< The pointer to the attached state-machine. */
            #endif
            #if ( Q_QUEUES == 1 )
                qQueue_t *Queue;                    /**< The pointer to the attached queue. */
                qUINT32_t QueueCount;               /**< The item-count threshold */
            #endif
            qSTimer_t timer;                        /**< To handle the task timming*/
            #if ( Q_TASK_COUNT_CYCLES == 1 )
                qCycles_t Cycles;                   /**< The current number of executions performed by the task. */
            #endif
            #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
                size_t Entry;                       /*< To allow the OS maintain the task entry order. */
            #endif
            qIteration_t Iterations;                /**< Hold the number of iterations. */
            volatile qNotifier_t Notification;      /**< The notification value. */          
            volatile qTask_Flag_t Flags;            /**< Task flags (core and eventflags)*/
            qTrigger_t Trigger;                     /**< The event source that put the task in a qReady state. */
            qPriority_t Priority;                   /**< The task priority. */
        }qPrivate;
        /*! @endcond PRIVATE */
    }qTask_t;

    #if ( Q_QUEUES == 1 )
        /**
        * @brief An enum to define the task link modes for a queue.
        */
        typedef enum {
            qQueueMode_Receiver  = 4,   /**< This mode will trigger the task if there are elements in the queue. Data will be extracted automatically in every trigger and will be available in the <b>EventData</b> field of the qEvent_t structure.*/
            qQueueMode_Full = 8,        /**< This mode will trigger the task if the queue is full. A pointer to the queue will be available in the <b>EventData</b> field of the qEvent_t structure.*/
            qQueueMode_Count = 16,      /**< This mode will trigger the task if the count of elements in the queue reach the specified value. A pointer to the queue will be available in the <b>EventData</b> field of the qEvent_t structure.*/
            qQueueMode_Empty = 32,      /**< This mode will trigger the task if the queue is empty. A pointer to the queue will be available in the <b>EventData</b> field of the qEvent_t structure.*/
        }qQueueLinkMode_t;
    #endif

    /** @addtogroup qnot
    * @brief API interface for task notifications
    *  @{
    */

    /**
    * @brief An enum to define the notification modes for a task.
    */
    typedef enum{
        qTask_NotifyNULL,               /**< Do not use this value. Used only internally.*/
        qTask_NotifySimple,             /**< To notify a task using the simple approach. */
        qTask_NotifyQueued,             /**< To notify a task using the FIFO priority queue. */
    }
    qTask_NotifyMode_t;
    
    /**
    * @brief Sends a simple notification generating an asynchronous event. 
    * This method marks the task as 'qReady' for execution, therefore, the planner will 
    * launch the task immediately according to the scheduling rules (even if task is disabled) and 
    * setting the Trigger flag to <b>byNotificationSimple</b>. Specific user-data can be passed 
    * through, and will be available in the respective callback inside the <b>EventData</b> 
    * field.
    * @param Task Pointer to the task node.
    * @param eventdata Specific event user-data.
    * @return qTrue on success. Otherwise qFalse.
    */       
    qBool_t qTask_Notification_Send( qTask_t * const Task, void* eventdata );

    /**
    * @brief Insert a notification in the FIFO priority queue. The scheduler get this notification
    * as an asynchronous event, therefor, the task will be ready for execution according to 
    * the queue order (determined by priority), even if task is in a disabled or sleep 
    * operational state. When extracted, the scheduler will set Trigger flag to  
    * <b>byNotificationQueued</b>. Specific user-data can be passed through, and will be 
    * available inside the EventData field, only in corresponding launch.
    * If the task is in a qSleep operation state, the scheduler will change the operational 
    * state to qAwaken setting the SHUTDOWN bit.
    * @param Task Pointer to the task node.
    * @param eventdata Specific event user-data.
    * @return Returns qTrue if the event has been inserted in the queue, or qFalse if an error 
    * occurred (The queue exceeds the size).
    */        
    qBool_t qTask_Notification_Queue( qTask_t * const Task, void* eventdata );

    /**
    * @brief Check if the task has pending notifications.
    * @param Task Pointer to the task node.
    * @return qTrue if the function asserts, otherwise returns qFalse.
    */  
    qBool_t qTask_HasPendingNotifications( const qTask_t * const Task  );

    /** @}*/

    /**
    * @brief Retrieve the task operational state.
    * @param Task Pointer to the task node.
    * @return Enabled or qDisabled if the task is qAwaken. qAsleep if the task is 
    * in a Sleep operational state.
    */     
    qState_t qTask_Get_State( const qTask_t * const Task);
    #if ( Q_TASK_COUNT_CYCLES == 1 )
        /**
        * @brief Retrieve the number of task activations.
        * @param Task Pointer to the task node.
        * @return An unsigned long value containing the number of task activations.
        */      
        qCycles_t qTask_Get_Cycles( const qTask_t * const Task );   
    #endif

    /**
    * @brief Retrieve the task global-state.
    * @param Task Pointer to the task node.
    * @return One of the available global states : qWaiting, qSuspended, qRunning, qReady.
    * Return <b>qUndefinedGlobalState</b> if the current task its passing through a 
    * current kernel transaction
    */       
    qTask_GlobalState_t qTask_Get_GlobalState( const qTask_t * const Task );

    /**
    * @brief Set/Change the Task execution interval
    * @param Task Pointer to the task node.
    * @param Value Execution interval defined in seconds (floating-point format). 
    * For immediate execution (tValue = <b>qTimeImmediate</b>).
    * @return none.
    */  
    void qTask_Set_Time( qTask_t * const Task, const qTime_t Value );

    /**
    * @brief Set/Change the number of task iterations
    * @param Task Pointer to the task node.
    * @param Value Number of task executions (Integer value). For indefinite 
    * execution (iValue = <b>qPeriodic</b> or <b>qIndefinite</b>). Tasks do not remember 
    * the number of iteration set initially. After the iterations are 
    * done, internal iteration counter is 0. If you need to perform
    * another set of iterations, you need to set the number of 
    * iterations again and resume.
    * @return none.
    */     
    void qTask_Set_Iterations( qTask_t * const Task, const qIteration_t Value );

    /**
    * @brief Set/Change the task priority value
    * @param Task Pointer to the task node.
    * @param Value Priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
    * @return none.
    */    
    void qTask_Set_Priority( qTask_t * const Task, const qPriority_t Value );

    /**
    * @brief Set/Change the task callback function.
    * @note his function can be used to detach a state-machine from a task
    * @param Task Pointer to the task node.
    * @param CallbackFcn A pointer to a void callback method with a qEvent_t parameter 
    * as input argument.
    * @return none.
    */       
    void qTask_Set_Callback( qTask_t * const Task, const qTaskFcn_t CallbackFcn );

    /**
    * @brief Set the task operational state (Enabled or Disabled)
    * @param Task Pointer to the task node.
    * @param State Use one of the following values:
    * 
    * qEnabled : Task will be able to catch all the events. (ENABLE Bit = 1 )
    * 
    * qDisabled : Time events will be discarded. The task can catch asynchronous events.
    * (ENABLE Bit = 0)
    * 
    * qAsleep : Put the task into a qSLEEP operability state. The task can't be triggered
    * by the lower precedence events. ( SHUTDOWN Bit = 0)
    * 
    * qAwake : Put the task into the previous state before it was put in the sleep state.
    * ( SHUTDOWN Bit = 1 )
    * @return none.
    */      
    void qTask_Set_State( qTask_t * const Task, const qState_t State );

    /**
    * @brief Set the task data
    * @param Task Pointer to the task node.
    * @param arg The task storage pointer. User data.
    * @return none.
    */  
    void qTask_Set_Data( qTask_t * const Task, void* arg );

    /**
    * @brief Clear the elapsed time of the task. Restart the internal task tick;
    * @param Task Pointer to the task node.
    * @return none.
    */      
    void qTask_ClearTimeElapsed( qTask_t * const Task );

    /**
    * @brief Get the current running-task handle.
    * @return A pointer to the current running task.
    * NULL when the OS scheduler it's in a busy state or when IDLE Task is running.
    */      
    qTask_t* qTask_Self( void );

    /**
    * @brief Put the task into a disabled state.    
    * @param Task Pointer to the task node.
    * @return none.
    */     
    #define qTask_Suspend( Task )     qTask_Set_State( (Task), qDisabled )

    /**
    * @brief Put the task into a disabled state.    
    * @param Task Pointer to the task node.
    * @return none.
    */        
    #define qTask_Disable( Task )     qTask_Set_State( (Task), qDisabled )

    /**
    * @brief Put the task into an enabled state.    
    * @param Task Pointer to the task node.
    * @return none.
    */    
    #define qTask_Resume( Task )      qTask_Set_State( (Task), qEnabled )

    /**
    * @brief Put the task into an enabled state.    
    * @param Task Pointer to the task node.
    * @return none.
    */     
    #define qTask_Enable( Task )      qTask_Set_State( (Task), qEnabled )
 
    /**
    * @brief Put the task into a qSLEEP state. The task can't be triggered
    * by the lower precedence events.    
    * @note Only the higher precedence events (Queued Notifications) can
    * wake up the task.
    * @param Task Pointer to the task node.
    * @return none.
    */    
    #define qTask_ASleep( Task )      qTask_Set_State( (Task), qAsleep )
  
    /**
    * @brief Put the task into a normal operation state. Here the task
    * will be able to catch any kind of events.   
    * @param Task Pointer to the task node.
    * @return none.
    */      
    #define qTask_Awake( Task )       qTask_Set_State( (Task), qAwake )

    /**
    * @brief Retrieve the enabled/disabled state 
    * @param Task Pointer to the task node.
    * @return True if the task in on Enabled state, otherwise returns false.
    */       
    #define qTask_IsEnabled( Task )   ( qEnabled == qTask_Get_State( (Task) ) )

    #if ( Q_QUEUES == 1 )

        /**
        * @brief Attach a Queue to the Task.    
        * @param Task Pointer to the task node.
        * @param Queue A pointer to a Queue  object
        * @param Mode Attach mode. This implies the event that will trigger the task according
        * to one of the following modes:
        * 
        * <b>qQUEUE_DEQUEUE</b>: The task will be triggered if there are elements 
        * in the Queue. Data will be extracted automatically in 
        * every trigger and will be available in the <b>EventData</b> field 
        * of the qEvent_t structure.
        * 
        * <b>qQUEUE_FULL</b>: the task will be triggered if the Queue
        * is full. A pointer to the queue will be available in the
        * <b>EventData</b> field of the qEvent_t structure.
        * 
        * <b>qQUEUE_COUNT</b>: the task will be triggered if the count of 
        * elements in the queue reach the specified value. 
        * A pointer to the queue will be available in the
        * <b>EventData</b> field of the qEvent_t structure.
        * 
        * <b>qQUEUE_EMPTY</b>: the task will be triggered if the queue
        * is empty. A pointer to the queue will be available in the
        * <b>EventData</b> field of the qEvent_t structure.
        * @param arg This argument defines if the queue will be attached (qATTACH) or 
        * detached (qDETACH) from the task.
        * If the <b>qQUEUE_COUNT</b> mode is specified, this value will be used to check
        * the element count of the queue. A zero value will act as a qDETACH action. 
        * @return Returns qTrue on success, otherwise returns qFalse.
        */       
        qBool_t qTask_Attach_Queue( qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const qUINT16_t arg );
    #endif 

    #if ( Q_TASK_EVENT_FLAGS == 1 )
        /** @addtogroup qeventflags
        * @brief API interface for the built-in-task Event-Flags.
        *  @{
        */

        /**
        * @brief Modify the EventFlags for the provided task.  
        * @note Any EventFlag set will cause a task activation.
        * @param Task Pointer to the task node.
        * @param flags The flags to modify. Can be combined with a bitwise OR. 
        * QEVENTFLAG_01 | QEVENTFLAG_02 | QEVENTFLAG_03 | ... | QEVENTFLAG_20  
        * @param action QEVENTFLAG_SET or QEVENTFLAG_CLEAR 
        * @return none.
        */     
        void qTask_EventFlags_Modify( qTask_t * const Task, qTask_Flag_t flags, qBool_t action );

        /**
        * @brief Returns the current value of the task's EventFlags. 
        * @param Task Pointer to the task node.
        * @return The EventFlag value of the task.
        */          
        qTask_Flag_t qTask_EventFlags_Read( const qTask_t * const Task ); 

        /**
        * @brief Check for flags set to qTrue inside the task Event-Flags.
        * @param Task Pointer to the task node.
        * @param FlagsToCheck A bitwise value that indicates the flags to test inside the EventFlags.
        * Can be combined with a bitwise OR.
        * QEVENTFLAG_01 | QEVENTFLAG_02 | QEVENTFLAG_03 | ... | QEVENTFLAG_20   
        * @param ClearOnExit If is set to qTrue then any flags set in the value passed as the 
        * <b>FlagsToCheck</b> parameter will be cleared in the event group before this
        * function returns only when the condition is meet.
        * @param CheckForAll Used to create either a logical AND test (where all flags must be set)
        * or a logical OR test (where one or more flags must be set) as follows:
        * 
        * If is set to qTrue this API will return qTrue when either all the flags 
        * set in  the value passed as the <b>FlagsToCheck</b> parameter are set in 
        * the task's EventFlags.
        * 
        * If is set to qFalse this API will return qTrue when any of the flags set in 
        * the value passed as the <b>FlagsToCheck</b> parameter are set in the task's
        * EventFlags.
        * @return qTrue if the condition is meet, otherwise return qFalse.
        */           
        qBool_t qTask_EventFlags_Check( qTask_t * const Task, qTask_Flag_t FlagsToCheck, qBool_t ClearOnExit, qBool_t CheckForAll );

        /** @}*/
    #endif
    
    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif /* QTASKS_H */
