/*!
 * @file qconfig.h
 * @author J. Camilo Gomez C.
 * @version 1.09
 * @note This file is part of the QuarkTS distribution.
 * @brief OS Configuration file
 **/

#ifndef QCONFIG_H
    #define QCONFIG_H

    /*==================================================  CONFIGURATION FLAGS  =======================================================*/
    #define Q_PRIORITY_LEVELS           ( 3 )       /**< The number of priorities available to the application tasks*/
    #define Q_SETUP_TIME_CANONICAL      ( 0 )       /**< If enabled, kernel assumes the timing Base to 1mS(1KHz). All time specifications for tasks and STimers must be set in mS*/
    #define Q_SETUP_TICK_IN_HERTZ       ( 0 )       /**< If enabled, the timing base will be taken as frequency(Hz) instead of period(S)*/
    #define Q_PRIO_QUEUE_SIZE           ( 10 )      /**< The size of the priority queue (use a 0(zero) value to disable it)*/
    #define Q_PRESERVE_TASK_ENTRY_ORDER ( 0 )       /**< If enabled, kernel will preserve the tasks entry order every OS scheduling cycle*/
    #define Q_MEMORY_MANAGER            ( 1 )       /**< Used to enable or disable the Memory Manager*/
    #define Q_BYTE_ALIGNMENT            ( 8 )       /**< Byte alignment used by the memory manager*/
    #define Q_DEFAULT_HEAP_SIZE         ( 512 )     /**< The default heap size for the memory manager*/
    #define Q_NOTIFICATION_SPREADER     ( 1 )       /**< Used to enable or disable the spread notification functionality*/
    #define Q_FSM                       ( 1 )       /**< Used to enable or disable the Finite State Machine (FSM) module */
    #define Q_FSM_MAX_NEST_DEPTH        ( 5 )       /**< The max depth of nesting for the Finite State Machines (FSM) module*/
    #define Q_FSM_MAX_TIMEOUTS          ( 3 )       /**< Max number of timeouts inside a timeout specification for the Finite State machine (FSM) module*/
    #define Q_FSM_PS_SIGNALS_MAX        ( 8 )       /**< Max number of signals to subscribe for a Finite State Machine (FSM)*/
    #define Q_FSM_PS_SUB_PER_SIGNAL_MAX ( 4 )       /**< Max number of FSM subscribers per signal*/
    #define Q_QUEUES                    ( 1 )       /**< Used to enable or disable the qQueues*/
    #define Q_TRACE_VARIABLES           ( 1 )       /**< Used to enable or disable variable tracing and debugging*/
    #define Q_DEBUGTRACE_BUFSIZE        ( 36 )      /**< Size for the debug/trace buffer: 36 bytes should be enough*/
    #define Q_DEBUGTRACE_FULL           ( 1 )       /**< Used to enable or disable a full trace output*/
    #define Q_ATCLI                     ( 1 )       /**< Used to enable or disable the AT Command Line Interface(CLI)*/
    #define Q_TASK_COUNT_CYCLES         ( 1 )       /**< Used to enable or disable the task cycles counter*/
    #define Q_TASK_EVENT_FLAGS          ( 1 )       /**< Used to enable or disable the task event flags*/
    #define Q_MAX_FTOA_PRECISION        ( 10u )     /**< default qFtoA precision*/
    #define Q_ATOF_FULL                 ( 0 )       /**< Used to enable or disable the extended "e" notation parsing in qAtoF*/
    #define Q_ALLOW_SCHEDULER_RELEASE   ( 1 )       /**< Used to enable or disable the release of the scheduling */
    #define Q_RESPONSE_HANDLER          ( 1 )       /**< Used to enable or disable the response handler*/
    #define Q_EDGE_CHECK_IOGROUPS       ( 1 )       /**< Used to enable or disable the edge check for I/O groups*/
    #define Q_BYTE_SIZED_BUFFERS        ( 1 )       /**< Used to enable or disable the Byte-sized buffers*/
    #define Q_USE_STDINT_H              ( 1 )       /**< Use the stdint.h header to define kernel data-types */
    #define Q_ALLOW_TASK_NAMING         ( 1 )       /**< Tag and locate tasks by using a name string*/
    #define Q_ALLOW_YIELD_TO_TASK       ( 1 )       /**< Allows you to transfer the current CPU usage to another task without having to wait for another cycle of the scheduler*/
    #define Q_TRACE_KERNEL_AND_MODULES  ( 0 )       /**< Experimental*/
 
    /*================================================================================================================================*/  
#endif
