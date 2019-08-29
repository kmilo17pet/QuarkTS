/*This file is part of the QuarkTS distribution.*/
#ifndef QCONFIG_H
    #define QCONFIG_H

    /*==================================================  CONFIGURATION FLAGS  =======================================================*/
    #define Q_SETUP_TIME_CANONICAL      0       /*< If enabled, kernel asumes the timing Base to 1mS(1KHz). All time specifications for tasks and STimers must be set in mS*/
    #define Q_SETUP_TICK_IN_HERTZ       0       /*< If enabled, the timming base will be taken as frequency(Hz) instead of period(S)*/

    #define Q_BYTE_SIZED_BUFFERS        1       /*< Used to enable or disable the Byte-sized buffers*/
    #define Q_MEMORY_MANAGER            1       /*< Used to enable or disable the Memory Manager*/
    #define Q_BYTE_ALIGNMENT            8       /*< Byte alignment used for the memory manager*/
    #define Q_DEFAULT_HEAP_SIZE         2048    /*< The default heap size for the memory manager*/    
    #define Q_FSM                       1       /*< Used to enable or disable the Finite State Machine (FSM) module */
    #define Q_QUEUES                    1       /*< Used to enable or disable the qQueues*/
    #define Q_PRIORITY_QUEUE            1       /*< Used to enable or disable queued notifications*/
    #define Q_AUTO_CHAINREARRANGE       1       /*< If enabled, the task chain will be rearranged dynamically after run-time priority changes*/ 
    #define Q_TRACE_VARIABLES           1       /*< Used to enable or disable variable tracing and debuggin*/
    #define Q_DEBUGTRACE_BUFSIZE        36      /*< Size for the debug/trace buffer: 36 bytes should be enough*/
    #define Q_DEBUGTRACE_FULL           1       /*< Used to enable or disable a full trace output*/
    #define Q_ATCOMMAND_PARSER          1       /*< Used to enable or disable the AT Command parser module for CLI*/
    #define Q_TASK_COUNT_CYCLES         1       /*< Used to enable or disable the task cycles counter*/
    #define Q_MAX_FTOA_PRECISION        10u     /*< default qFtoA precision*/
    #define Q_ATOF_FULL                 0       /*< Used to enable or disablethe extended "e" notation parsing in qAtoF*/
    #define Q_LISTS                     1       /*< Used to enable or disable the generic lists APIs */
    #define Q_ALLOW_SCHEDULER_RELEASE   1       /*< Used to enable or disable the release of the scheduling */
    #define Q_RESPONSE_HANDLER          1       /*< Used to enable or disable the response handler*/
    #define Q_EDGE_CHECK_IOGROUPS       1       /*< Used to enable or disable the edge check for I/O groups*/


    /*================================================================================================================================*/  

#endif