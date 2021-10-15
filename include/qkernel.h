/*!
 * @file qkernel.h
 * @author J. Camilo Gomez C.
 * @version 3.35
 * @note This file is part of the QuarkTS distribution.
 * @brief Kernel API interface to create/remove tasks and perform special OS operations.
 **/
#ifndef QKERNEL_H
    #define QKERNEL_H

    #include "qtypes.h"
    #include "qcritical.h"
    #include "qtasks.h"

    #if ( Q_ATCLI == 1)
        #include "qatcli.h"
    #endif
   
    #ifdef __cplusplus
    extern "C" {
    #endif

    #ifndef Q_PRIORITY_LEVELS
        #define Q_PRIORITY_LEVELS           ( 3 )
    #endif
    
    #ifndef Q_SETUP_TIME_CANONICAL
        #define Q_SETUP_TIME_CANONICAL      ( 0 )
    #endif
    
    #ifndef Q_SETUP_TICK_IN_HERTZ
        #define Q_SETUP_TICK_IN_HERTZ       ( 0 )
    #endif
    
    #ifndef Q_PRIO_QUEUE_SIZE
        #define Q_PRIO_QUEUE_SIZE           ( 3 )
    #endif

    #ifndef Q_PRESERVE_TASK_ENTRY_ORDER
        #define Q_PRESERVE_TASK_ENTRY_ORDER ( 0 )
    #endif

    #ifndef Q_NOTIFICATION_SPREADER
        #define Q_NOTIFICATION_SPREADER     ( 1 )
    #endif

    #ifndef Q_ALLOW_SCHEDULER_RELEASE
        #define Q_ALLOW_SCHEDULER_RELEASE   ( 1 )
    #endif

    #if ( Q_PRIORITY_LEVELS < 1 )
        #error Q_PRIORITY_LEVELS must be defined to be greater than or equal to 1.
    #endif    

    /** @addtogroup qtaskcreation
     * @brief Kernel API interface to create/remove tasks and perform special OS operations.
     *  @{
     */

    /*Default priority levels*/

    /** @brief A macro directive to indicate the lowest priority level. */
    #define qLowest_Priority        ( (qPriority_t)( 0u ) )

    /** @brief A macro directive to indicate the medium priority level. */
    #define qMedium_Priority        ( (qPriority_t)( Q_PRIORITY_LEVELS >> 1 ) )

    /** @brief A macro directive to indicate the highest priority level. */
    #define qHigh_Priority          ( (qPriority_t)( Q_PRIORITY_LEVELS - 1u ) )

    /** @brief A directive indicating that the task will run every time its timeout has expired. */
    #define qPeriodic               ( (qIteration_t)(INT32_MIN) )

    /** @brief Same as #qPeriodic. A directive indicating that the task will run every time its timeout has expired.*/
    #define qIndefinite             ( qPeriodic )

    /** @brief A directive that indicates that the task will be executed only once after its time has expired.*/
    #define qSingleShot             ( (qIteration_t)(1) )

    #if (Q_SETUP_TIME_CANONICAL == 1)
        qBool_t qOS_Setup( const qGetTickFcn_t tFcn, qTaskFcn_t idleCallback );
    #else
        /**
        * @brief Task Scheduler Setup. This function is required and must be called once in 
        * the application main thread before any task is being added to the OS.
        * @param[in] tFcn The function that provides the tick value. If the user application 
        * uses the qClock_SysTick() from the ISR, this parameter can be NULL.
        * @note Function should take void and return a 32bit value. 
        * @param[in] t (Optional) This parameter specifies the ISR background timer base time.
        * This can be the period in seconds(Floating-point format) or frequency 
        * in Herzt(Only if Q_SETUP_TICK_IN_HERTZ is enabled).
        * @param[in] idleCallback  Callback function to the Idle Task. To disable the 
        * Idle Task activities, pass NULL as argument.
        * @return #qTrue on success. Otherwise return #qFalse.
        * 
        * Example : When tick is already provided 
        * @code{.c}
        * #include "QuarkTS.h"
        * #include "HAL.h"
        * 
        * #define TIMER_TICK   0.001 
        * 
        * void main( void ){
        *     HAL_Init(); 
        *     qOS_Setup( HAL_GetTick, TIMER_TICK, IdleTask_Callback );
        * }
        * @endcode
        *
        * Example : When the tick is not provided
        * @code{.c}
        * #include "QuarkTS.h"
        * #include "DeviceHeader.h"
        * 
        * #define TIMER_TICK   0.001
        * 
        * void Interrupt_Timer0( void ){
        *     qClock_SysTick();
        * }
        * 
        * void main( void ){
        *     MCU_Init();
        *     BSP_Setup_Timer0(); 
        *     qOS_Setup( NULL, TIMER_TICK, IdleTask_Callback ); 
        *     
        * } 
        * @endcode
        */      
        qBool_t qOS_Setup( const qGetTickFcn_t tFcn, const qTimingBase_t t, qTaskFcn_t idleCallback );
    #endif

    /**
    * @brief Set/Change the callback for the Idle-task
    * @param[in] callbackFcn A pointer to a void callback method with a qEvent_t parameter 
    * as input argument. To disable pass NULL as argument.
    * @return #qTrue on success. Otherwise return #qFalse.
    */
    qBool_t qOS_Set_IdleTask( qTaskFcn_t callbackFcn );

    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        /**
        * @brief Disables the kernel scheduling. The main thread will continue after the
        * qOS_Run() call.
        * @return none.
        */          
        qBool_t qOS_Scheduler_Release( void );

        /**
        * @brief Set/Change the scheduler release callback function
        * @param[in] rCallback A pointer to a void callback method with a qEvent_t parameter 
        * as input argument.
        * @return #qTrue on success. Otherwise return #qFalse.
        */     
        qBool_t qOS_Set_SchedulerReleaseCallback( qTaskFcn_t rCallback );
    #endif       

    /** @}*/

    /** @addtogroup qnot
    *  @{
    */

    /**
    * @brief Try to spread a notification among all the tasks in the scheduling scheme
    * @note Operation will be performed in the next scheduling cycle. 
    * @see qTask_Notification_Send(), qTask_Notification_Queue()
    * @param[in] eventdata Specific event user-data.
    * @param[in] mode the method used to spread the event: ::qTask_NotifySimple or ::qTask_NotifyQueued.
    * @return #qTrue if success. #qFalse if any other spread operation is in progress.
    */
    qBool_t qOS_Notification_Spread( void *eventdata, const qTask_NotifyMode_t mode );
    /** @}*/

    /** @addtogroup qtaskcreation
     * @brief Kernel API interface to create/remove tasks and perform special OS operations.
     *  @{
     */

    /**
    * @brief Add a task to the scheduling scheme. The task is scheduled to run every @a t 
    * seconds, @a n times and executing @a callbackFcn method on every pass.
    * @param[in] Task  A pointer to the task node.
    * @param[in] callbackFcn A pointer to a void callback method with a qEvent_t parameter 
    * as input argument.
    * @param[in] p Task priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
    * @param[in] t Execution interval defined in seconds (floating-point format). 
    * For immediate execution (tValue = #qTimeImmediate).
    * @param[in] n Number of task executions (Integer value). For indefinite 
    * execution ( @a n = #qPeriodic or #qIndefinite ). Tasks do not 
    * remember the number of iteration set initially. After the 
    * iterations are done, internal iteration counter is 0. To perform 
    * another set of iterations, set the number of iterations again.
    * @note Tasks which performed all their iterations put their own state to #qDisabled.
    * @note Asynchronous triggers do not affect the iteration counter.
    * @param[in] init Specifies the initial operational state of the task 
    * (#qEnabled, #qDisabled, #qAsleep or #qAwake(implies #qEnabled)).
    * @param[in] arg Represents the task arguments. All arguments must be passed by
    * reference and cast to (void *). Only one argument is allowed, 
    * so, for multiple arguments, create a structure that contains 
    * all of the arguments and pass a pointer to that structure.
    * @return Returns #qTrue on success, otherwise returns #qFalse.
    */    
    qBool_t qOS_Add_Task( qTask_t * const Task, qTaskFcn_t callbackFcn, qPriority_t p, qTime_t t, qIteration_t n, qState_t init, void* arg );

    /**
    * @brief Add a task to the scheduling scheme.  This API creates a task with a #qDisabled 
    * state by default, so this task will be executed only, when asynchronous events occurs.
    * However, this behavior can be changed in execution time using qTask_Set_Time() 
    * or qTask_Set_Iterations().
    * @param[in] Task  A pointer to the task node.
    * @param[in] callbackFcn A pointer to a the task callback method with a qEvent_t parameter 
    * as input argument.
    * @param[in] p Task priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
    * @param[in] arg Represents the task arguments. All arguments must be passed by
    * reference and cast to (void *). Only one argument is allowed, 
    * so, for multiple arguments, create a structure that contains 
    * all of the arguments and pass a pointer to that structure.
    * @return Returns #qTrue on success, otherwise returns #qFalse.
    */       
    qBool_t qOS_Add_EventTask( qTask_t * const Task, qTaskFcn_t callbackFcn, qPriority_t p, void* arg );
    #if ( Q_FSM == 1)
        /**
        * @brief Add a task to the scheduling scheme running a dedicated state-machine. 
        * The task is scheduled to run every @a t seconds in #qPeriodic mode. The event info
        * will be available as a generic pointer inside the qSM_Handler_t::Data field.
        * @note The State-machine object should be previously configured
        * @see qStateMachine_Setup()
        * @param[in] Task  A pointer to the task node.
        * @param[in] m  A pointer to the Finite State-Machine (FSM) object.    
        * @param[in] p Task priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
        * @param[in] t Execution interval defined in seconds (floating-point format). 
        * For immediate execution (tValue = #qTimeImmediate).
        * @param[in] init Specifies the initial operational state of the task 
        * (#qEnabled, #qDisabled, #qAsleep or #qAwake(implies #qEnabled)).
        * @param[in] arg Represents the task arguments. All arguments must be passed by
        * reference and cast to (void *). Only one argument is allowed, 
        * so, for multiple arguments, create a structure that contains 
        * all of the arguments and pass a pointer to that structure.
        * @return Returns #qTrue on success, otherwise returns #qFalse.
        */     
        qBool_t qOS_Add_StateMachineTask( qTask_t * const Task, qSM_t *m, qPriority_t p, qTime_t t, qState_t init, void *arg );                  
    #endif

    #if ( Q_ATCLI == 1)
        /**
        * @brief Add a task to the scheduling scheme running an AT Command Line Interface.
        * Task will be scheduled as an event-triggered task. The parser address will be 
        * stored in the qEvent_t::TaskData storage-Pointer.
        * @note The AT-CLI object should be previously configured.
        * @see qATCLI_Setup()
        * @param[in] Task A pointer to the task node.
        * @param[in] cli A pointer to the AT Command Line Inteface instance.
        * @param[in] p Task priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
        * @param[in] arg Represents the task arguments. All arguments must be passed by
        * reference and cast to (void *). Only one argument is allowed, 
        * so, for multiple arguments, create a structure that contains 
        * all of the arguments and pass a pointer to that structure.
        * @return Returns #qTrue on success, otherwise returns #qFalse.
        */       
        qBool_t qOS_Add_ATCLITask( qTask_t * const Task, qATCLI_t *cli, qPriority_t p, void *arg );
    #endif

    /**
    * @brief Remove the task from the scheduling scheme.
    * @param[in] Task A pointer to the task node.
    * @return Returns #qTrue if success, otherwise returns #qFalse.
    */  
    qBool_t qOS_Remove_Task( qTask_t * const Task );

    /**
    * @brief Executes the scheduling scheme. It must be called once after the task
    * pool has been defined.
    * @note This call keeps the application in an endless loop.
    * @return #qTrue if a release action its performed. In a normal scenario, 
    * this function never returns.
    */      
    qBool_t qOS_Run( void );

    #if ( Q_ALLOW_YIELD_TO_TASK == 1 )
        /**
        * @brief Yield the control of the current running task to another task.
        * @note This API can only be invoked from the context of a task.
        * @note Target task will inherit the event data.
        * @warning Yielding from the IDLE task is not allowed.
        * @param[in] Task A pointer to the task to which current control will 
        * be yielded.
        * @return Returns #qTrue if success, otherwise returns #qFalse.
        */  
        qBool_t qOS_YieldToTask( qTask_t * const Task );
    #endif    

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif /*QKERNEL_H*/
