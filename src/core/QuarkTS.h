/*
    QuarkTS V4.9.3 - Copyright (C) 2012 Eng. Juan Camilo Gomez C. MSc.
    A Non-Preemptive RTOS for small embedded systems
    GNU Lesser General Public License (LGPL)
    C99 and MISRA-C 2004 Compliant
*/
#ifndef H_QuarkTS
#define	H_QuarkTS

#ifdef	__cplusplus
extern "C" {
#endif
    
  
    /*==================================================  CONFIGURATION FLAGS  =======================================================*/
    #define Q_SETUP_TIME_CANONICAL      0       /*If enabled, kernel asumes the timing Base to 1mS(1KHz). All time specifications for tasks and STimers must be set in mS*/
    #define Q_SETUP_TICK_IN_HERTZ       0       /*If enabled, the timming base will be taken as frequency(Hz) instead of period(S)*/

    #define Q_BYTE_SIZED_BUFFERS        1       /*Used to enable or disable the Byte-sized buffers*/
    #define Q_MEMORY_MANAGER            1       /*Used to enable or disable the Memory Manager*/
    #define Q_BYTE_ALIGNMENT            8       /*Byte alignment used for the memory manager*/
    #define Q_FSM                       1       /*Used to enable or disable the Finite State Machine (FSM) module */
    #define Q_DEFAULT_HEAP_SIZE         2048    /*The default heap size for the memory manager*/    
    #define Q_QUEUES                    1       /*Used to enable or disable the qQueues*/
    #define Q_PRIORITY_QUEUE            1       /*Used to enable or disable queued notifications*/
    #define Q_AUTO_CHAINREARRANGE       1       /*If enabled, the task chain will be rearranged dynamically after run-time priority changes*/ 
    #define Q_TRACE_VARIABLES           1       /*Used to enable or disable variable tracing and debuggin*/
    #define Q_DEBUGTRACE_BUFSIZE        36      /*Size for the debug/trace buffer: 36 bytes should be enough*/
    #define Q_DEBUGTRACE_FULL           1       /*Used to enable or disable a full trace output*/
    #define Q_ATCOMMAND_PARSER          1       /*Used to enable or disable the AT Command parser module for CLI*/
    #define Q_TASK_COUNT_CYCLES         1       /*Used to enable or disable the task cycles counter*/

    #define Q_MAX_FTOA_PRECISION        10u     /*default qFtoA precision*/
    #define Q_ATOF_FULL                 0       /*Used to enable or disablethe extended "e" notation parsing in qAtoF*/
    #define Q_LISTS                     1       /*Used to enable or disable the generic lists APIs */
    #define Q_ALLOW_SCHEDULER_RELEASE   1       /*Used to enable or disable the release of the scheduling */
    /*================================================================================================================================*/    
  
    #ifndef __ORDER_LITTLE_ENDIAN__  /*default endianess: little-endian*/
        #define __ORDER_LITTLE_ENDIAN__     1
    #endif
    #ifndef __BYTE_ORDER__
        #define __BYTE_ORDER__  __ORDER_LITTLE_ENDIAN__
    #endif

    #ifdef __IAR_SYSTEMS_ICC__ /*stdint.h missing for some stupid reason*/
        #if defined( __ICC8051__ ) || defined ( __ICCARM__)
          #ifndef STDINT_H
              #define STDINT_H
              typedef unsigned char uint8_t;
              typedef unsigned short uint16_t;
              typedef unsigned long uint32_t;
              typedef uint32_t uint64_t[2];

              typedef signed char int8_t;
              typedef short int16_t;
              typedef long int32_t;
              typedef int32_t int64_t[2];
          #endif
        #endif      
    #else
        #include <stdint.h>
    #endif    
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>

    #define __QUARKTS__
    #define _QUARKTS_CR_DEFS_
    #define QUARKTS_VERSION     "4.9.3"
    #define QUARKTS_CAPTION     "QuarkTS " QUARKTS_VERSION
    #ifndef NULL
        #define NULL ((void*)0)
    #endif
   
    #define _UNUSED_(x)             (void)(x)

    #define qFalse                  ( 0x00u )
    #define qTrue                   ( 0x01u )
    #define qRESPONSETIMEOUT        ( 0x02u )
    #define qRISING                 ( 0x03u )
    #define qFALLING                ( 0x04u )
    #define qUNKNOWN                ( 0xFFu )
    
    #define QREG_8BIT               __qReg_08Bits
    #define QREG_16BIT              __qReg_16Bits
    #define QREG_32BIT              __qReg_32Bits
    
    #define QEDGECHECK_WAIT         ( 0u )
    #define QEDGECHECK_UPDATE       ( 1u )
    #define QEDGECHECK_CHECK        ( 2u )

    #define qEnabled                ( qTrue )
    #define qDisabled               ( qFalse )
    #define qLINK                   ( qTrue )
    #define qUNLINK                 ( qFalse )  
    #define qLink                   ( qTrue )
    #define qATTACH                 ( qTrue )
    #define qDETACH                 ( qFalse )
    #define qAttach                 ( qTrue )
    #define qDetach                 ( qFalse )    
    #define qUnLink                 ( qFalse )
    #define qON                     ( qTrue )
    #define qOFF                    ( qFalse )
    
    typedef enum{
        qOff                = qOFF,
        qOn                 = qON,
        qResponseTimeout    = qRESPONSETIMEOUT,           
        qRising             = qRISING,
        qFalling            = qFALLING,  
        qUnknown            = qUNKNOWN     
    }qIOStatus_t;
    
    #ifdef __XC8
        #define qConst
        #define qConstField_Set(TYPE, STRUCT_FIELD)    STRUCT_FIELD
    #else
        #define qConst const  
        /*MISRA deviation rule 19.10 in the definition of  "qConstField_Set", TYPE parameter is not enclosed in parenthesis*/
        #define qConstField_Set(TYPE, STRUCT_FIELD)    *((TYPE*)&(STRUCT_FIELD)) 
    #endif
    
    #define qBitsSet(Register, Bits)                    (Register) |= (Bits)
    #define qBitsClear(Register, Bits)                  (Register) &= ~(Bits)
    #define qBitSet(Register, Bit)                      (Register) |= (1 << (Bit))
    #define qBitClear(Register, Bit)                    (Register) &= (~(1<< (Bit)))
    #define qBitRead(Register,Bit)                      ((qFalse == ((Register)& (1<<(Bit))))? qFalse : qTrue)
    #define qBitToggle(Register,Bit)                    ((Register)^= (1<<(Bit)))
    #define qBitWrite(Register, Bit, Value)             ((Value) ? qBitSet((Register),(Bit)) : qBitClear((Register),(Bit)))
    #define qBitMakeByte(b7,b6,b5,b4,b3,b2,b1,b0)       (uint8_t)( ((b7)<<7) + ((b6)<<6) + ((b5)<<5) + ((b4)<<4) + ((b3)<<3) + ((b2)<<2) + ((b1)<<1) + ((b0)<<0) )
    #define qByteMakeFromBits(b7,b6,b5,b4,b3,b2,b1,b0)  (qBitMakeByte((b7),(b6),(b5),(b4),(b3),(b2),(b1),(b0)))
    #define qByteHighNibble(Register)                   ((uint8_t)((Register)>>4))
    #define qByteLowNibble(Register)                    ((uint8_t)((Register)&0x0F))
    #define qByteMergeNibbles(H,L)                      ((uint8_t)(((H)<<4)|(0x0F&(L))))    
    #define qWordHighByte(Register)                     ((uint8_t)((Register)>>8))
    #define qWordLowByte(Register)                      ((uint8_t)((Register)&0x00FF))
    #define qWordMergeBytes(H,L)                        ((uint16_t)(((H)<<8)|(L)))
    #define qDWordHighWord(Register)                    ((uint16_t)((Register) >> 16))
    #define qDWordLowWord(Register)                     ((uint16_t)((Register) & 0xFFFF))
    #define qDWordMergeWords(H,L)                       ((uint32_t)(((uint32_t)(H) << 16 ) | (L) ) )

    #define qClip(X, Max, Min)                          (((X) < (Min)) ? (Min) : (((X) > (Max)) ? (Max) : (X)))
    #define qClipUpper(X, Max)                          (((X) > (Max)) ? (Max) : (X))
    #define qClipLower(X, Min)                          (((X) < (Min)) ? (Min) : (X))
    #define qIsBetween(X, Low, High)                    ((qBool_t)((X) >= (Low) && (X) <= (High)))
    #define qMin(a,b)                                   (((a)<(b))?(a):(b))
    #define qMax(a,b)                                   (((a)>(b))?(a):(b))
    
    #ifdef _QUARKTS_CR_DEFS_
        typedef int32_t _qTaskPC_t;
        #define qCRPosition_t static _qTaskPC_t
        typedef struct {uint16_t head, tail;} qCoroutineSemaphore_t; 
        typedef qCoroutineSemaphore_t qCRSem_t;
        #define qCR_PCInitVal           ( -1 )            
        #define __qCRKeep
        #define __qCRCodeStartBlock      do
        #define __qCRCodeEndBlock        while(qFalse)
        #define __qPersistent            static qCoroutineInstance_t/*static _qTaskPC_t*/
        #define __qTaskProgress          __LINE__
        #define __qAssert(_COND_)        if(!(_COND_))
        #define __qTaskPCVar             _qCRTaskState_.instr /*_qCRTaskState_*/
        #define __qCRDelayVar            _qCRTaskState_.crdelay           
        #define __qCRDelayPrepare        __qCRDelayVar = qSchedulerGetTick()
        #define __qSetPC(_VAL_)          __qTaskPCVar = (_VAL_)
        #define __qTaskSaveState         __qSetPC(__qTaskProgress) 
        #define __qTaskInitState         _qCRTaskState_ = {qCR_PCInitVal}/*__qSetPC({qCR_PCInitVal}) */
        #define __qTaskCheckPCJump(_PC_) switch(_PC_){    
        #define __TagExitCCR             __qCRYield_ExitLabel
        #define __qExit                  goto __TagExitCCR /*MISRA deviation*/
        #define __qTaskYield             __qExit;
        #define __qCRDispose            __qSetPC(qCR_PCInitVal);} __TagExitCCR:/*__qTaskInitState;} __TagExitCCR:*/
        #define __qRestorator(_VAL_)     case (_qTaskPC_t)(_VAL_):            
        #define __RestoreAfterYield      __qRestorator(__qTaskProgress)
        #define __RestoreFromBegin       __qRestorator(qCR_PCInitVal)
        #define __qCRSemInit(s, c)      __qCRCodeStartBlock{ (s)->tail = 0; (s)->head = (c); }__qCRCodeEndBlock
        #define __qCRSemCount(s)        ((s)->head - (s)->tail)
        #define __qCRSemLock(s)         (++(s)->tail)
        #define __qCRSemRelease(s)      (++(s)->head)
    #endif


    typedef enum {qTriggerNULL, byTimeElapsed, byNotificationQueued, byNotificationSimple, byQueueReceiver, byQueueFull, byQueueCount, byQueueEmpty, bySchedulingRelease, byNoReadyTasks} qTrigger_t;
    #define byAsyncEvent                byNotificationSimple
    #define byQueueExtraction           byNotificationQueued

    /*BACKWARD COMPATIBILITY: START*/
    #define byRBufferPop                byQueueReceiver
    #define byRBufferFull               byQueueFull
    #define byRBufferCount              byQueueCount
    #define byRBufferEmpty              byQueueEmpty
    #define qTrigger_RBufferPop         byQueueReceiver
    #define qTrigger_RBufferFull        byQueueFull
    #define qTrigger_RBufferCount       byQueueCount
    #define qTrigger_RBufferEmpty       byQueueEmpty
    /*BACKWARD COMPATIBILITY: END*/

    #define qTrigger_NotificationSimple byNotificationSimple
    #define qTrigger_NotificationQueued byNotificationQueued
    #define qTrigger_TimeElapsed        byTimeElapsed
    #define qTrigger_QueueExtraction    byQueueExtraction
    #define qTrigger_AsyncEvent         byAsyncEvent
    #define qTrigger_QueueReceiver      byQueueReceiver
    #define qTrigger_QueueFull          byQueueFull
    #define qTrigger_QueueCount         byQueueCount
    #define qTrigger_QueueEmpty         byQueueEmpty
    #define qTrigger_SchedulingRelease  bySchedulingRelease
    #define qTrigger_NoReadyTasks       byNoReadyTasks

    #if (Q_SETUP_TIME_CANONICAL == 1)
        typedef uint32_t qTime_t;
        #define qTimeImmediate       ((qTime_t)(0ul))
    #else
        typedef float qTime_t;
        #define qTimeImmediate       ((qTime_t)(0.0f))
    #endif
    typedef uint32_t qClock_t;
    typedef uint8_t qPriority_t;
    typedef int16_t qIteration_t;
    typedef uint8_t qState_t;
    typedef uint8_t qBool_t;
    typedef uint16_t qSize_t;
    
    #define qLowest_Priority     ((qPriority_t)(0x00u))
    #define qMedium_Priority     ((qPriority_t)(0x7Fu))
    #define qHigh_Priority       ((qPriority_t)(0xFEu))
    #define qPeriodic            ((qIteration_t)(-32768))
    #define qIndefinite          qPeriodic
    #define qSingleShot          ((qIteration_t)(1))
    
    
  
    
    #define LOWEST_Priority     qLowest_Priority
    #define MEDIUM_Priority     qMedium_Priority
    #define HIGH_Priority       qHigh_Priority
    
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
          
    #define _QEVENTINFO_INITIALIZER     {_Q_NO_VALID_TRIGGER_, NULL, NULL, qFalse, qFalse, qFalse}  
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

    #define _qIndex_InitFlag            ( 0 )
    #define _qIndex_Enabled             ( 1 )
    #define _qIndex_QueueReceiver       ( 2 )
    #define _qIndex_QueueFull           ( 3 )
    #define _qIndex_QueueCount          ( 4 )
    #define _qIndex_QueueEmpty          ( 5 )

    typedef uint8_t qTaskState_t;
    #define qWaiting    ( 0u )
    #define qReady      ( 1u )
    #define qRunning    ( 2u )
    #define qSuspended  ( 3u )

    #if ( Q_QUEUES == 1)
        typedef struct {
            uint8_t *pHead;			        /*< Points to the beginning of the queue storage area. */
            uint8_t *pTail;			        /*< Points to the byte at the end of the queue storage area.  Once more byte is allocated than necessary to store the queue items, this is used as a marker. */
            volatile uint8_t *pcWriteTo;	/*< Points to the free next place in the storage area. */
            volatile uint8_t *pcReadFrom;	/*< Points to the last place that a queued item was read from. */
            volatile qSize_t ItemsWaiting;  /*< The number of items currently in the queue. */
            qSize_t ItemsCount;		        /*< The length of the queue defined as the number of items it will hold, not the number of bytes. */
            qSize_t ItemSize;		        /*< The size of each items that the queue will hold. */
        }qQueue_t;
        /*qRBuffer_t is deprecated, insted use qQueue_t*/
        #define qRBuffer_t qQueue_t  /*Backward compatibility*/
        #define QUEUE_SEND_TO_BACK     ( 0u )
        #define QUEUE_SEND_TO_FRONT    ( 1u )
        /*qBool_t qQueueSendToBack(qQueue_t *obj, void *ItemToQueue)
 
        Post an item to the back of the queue. The item is queued by copy, not by reference
        
        Parameters:

            - obj : a pointer to the Queue object
            - ItemToQueue : A pointer to the item that is to be placed on the queue. The size of 
                    the items the queue will hold was defined when the queue was created, 
                    so this many bytes will be copied from ItemToQueue into the queue storage
                    area.
        
        Return value:

            qTrue on successful add, qFalse if not added
        */
        #define qQueueSendToBack(_qQueue_t_, _ItemToQueue_)     qQueueGenericSend((_qQueue_t_), (_ItemToQueue_), QUEUE_SEND_TO_BACK)
        /*qBool_t qQueueSend(qQueue_t *obj, void *ItemToQueue)
 
        Post an item to the back of the queue. The item is queued by copy, not by reference
        
        Parameters:

            - obj : a pointer to the Queue object
            - ItemToQueue : A pointer to the item that is to be placed on the queue. The size of 
                    the items the queue will hold was defined when the queue was created, 
                    so this many bytes will be copied from ItemToQueue into the queue storage
                    area.
        
        Return value:

            qTrue on successful add, qFalse if not added
        */
        #define qQueueSend(_qQueue_t_, _ItemToQueue_)           qQueueGenericSend((_qQueue_t_), (_ItemToQueue_), QUEUE_SEND_TO_BACK)
        /*qBool_t qQueueSendToFront(qQueue_t *obj, void *ItemToQueue)
        
        Post an item in the front of the queue. The item is queued by copy, not by reference
        
        Parameters:

            - obj : a pointer to the Queue object
            - item : A pointer to the item that is to be placed on the queue. The size of 
                    the items the queue will hold was defined when the queue was created, 
                    so this many bytes will be copied from ItemToQueue into the queue storage
                    area.
        
        Return value:

            qTrue on successful add, qFalse if not added
        */        
        #define qQueueSendToFront(_qQueue_t_, _ItemToQueue_)    qQueueGenericSend((_qQueue_t_), (_ItemToQueue_), QUEUE_SEND_TO_FRONT)
    #endif
    
    #if ( Q_FSM == 1)
        typedef enum {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;
        #define qPrivate    _
        #define _qSMData_t struct _qSM_t * const 
        #define CurrentState    NextState

        typedef struct _qSM_t{ 
            /* NextState: (Read/Write) 
            Next state to be performed after this state finish
            */
            qSM_Status_t (*NextState)(_qSMData_t);
            /* PreviousState: (Read Only)
            Last state seen in the flow chart
            */
            qSM_Status_t (* qConst PreviousState)(_qSMData_t);
            /* LastState: (Read Only) 
            The last state executed
            */        
            qSM_Status_t (* qConst LastState)(_qSMData_t);
            /* PreviousReturnStatus: (Read Only)
            The return status of <PreviousState>
            */
            qConst qSM_Status_t PreviousReturnStatus;
            /* StateFirstEntry: [== StateJustChanged] (Read Only)
            True when  <Previous State> !=  <Current State>
            */
            qConst qBool_t StateFirstEntry;
            /* Data: (Read Only)
            State-machine associated data.
            Note: If the FSM is running as a task, the associated event data can be 
            queried throught the "Data" field. (cast to qEvent_t is mandatory)
            */
            void * qConst Data;
            /*Private members (DO NOT USE THEM)*/
            struct /**/{
                void (*qConst __Failure)(_qSMData_t);
                void (*qConst __Success)(_qSMData_t);
                void (*qConst __Unexpected)(_qSMData_t);  
                void (*qConst __BeforeAnyState)(_qSMData_t);/*only used when a task has a SM attached*/
            }qPrivate;
        }qSM_t;
        typedef qSM_t* const qSMData_t;    
        typedef qSM_Status_t (*qSM_State_t)(qSMData_t); 
        typedef void (*qSM_SubState_t)(qSMData_t); 
        #define StateJustChanged    StateFirstEntry /*backward compatibility*/
    
        typedef enum{ /*FSM Attribute Flags definition*/
            qSM_RESTART, /*Restart the FSM*/
            qSM_CLEAR_STATE_FIRST_ENTRY_FLAG, /*Clear the entry flag for the current state if the NextState field doesn't change*/
            qSM_FAILURE_STATE, /*Set the Failure State*/
            qSM_SUCCESS_STATE, /*Set the Success State*/
            qSM_UNEXPECTED_STATE, /*Set the Unexpected State*/
            qSM_BEFORE_ANY_STATE /*Set the state executed before any state*/              
        }qFSM_Attribute_t; 
    #endif

    #define Q_TASK_EXTENDED_DATA

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
    typedef qTask_t** qHeadPointer_t;         
    typedef struct{
        qTask_t *Task; /*the pointed task*/
        void *QueueData; 
    }qQueueStack_t;  

    typedef struct{ /*Scheduler Core-Flags*/
        volatile uint32_t IntFlags;
    	volatile qBool_t Init;
        qBool_t FCallIdle;
        #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
            volatile qBool_t ReleaseSched, FCallReleased;
        #endif
    }qTaskCoreFlags_t;
   
    typedef qClock_t (*qGetTickFcn_t)(void);

    #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
            #define qTimingBase_type qClock_t
    #else
            #define qTimingBase_type qTime_t
    #endif 

    typedef void (*qInt_Restorer_t)(uint32_t);
    typedef uint32_t (*qInt_Disabler_t)(void);

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
        #if (Q_SETUP_TIME_CANONICAL != 1)
            qTimingBase_type TimmingBase;
        #endif
        qTask_t *Head;
        qInt_Disabler_t I_Disable;
        qInt_Restorer_t I_Restorer;
        volatile qTaskCoreFlags_t Flag;
        qTask_t *CurrentRunningTask;
        qGetTickFcn_t GetSysTick;
        _qEvent_t_ EventInfo;
    }QuarkTSCoreData_t;

    void qEnterCritical( void );
    void qExitCritical( void );

    qTime_t qClock2Time( const qClock_t t );
    qClock_t qTime2Clock( const qTime_t t );
    void qSchedulerSysTick( void );
    qClock_t qSchedulerGetTick( void );
    qTask_t* qTaskSelf( void );
    qBool_t qTaskIsEnabled( const qTask_t *Task );
    void qSchedulerSetIdleTask( qTaskFcn_t Callback );
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        void qSchedulerRelease( void );
        void qSchedulerSetReleaseCallback( qTaskFcn_t Callback );
    #endif
    #if (Q_SETUP_TIME_CANONICAL == 1)
        void _qInitScheduler( const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, const uint8_t Size_Q_Stack );
    #else
        void _qInitScheduler( const qGetTickFcn_t TickProvider, const qTimingBase_type BaseTimming, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, const uint8_t Size_Q_Stack );
    #endif

    void qSchedulerSetInterruptsED( const qInt_Restorer_t Restorer, const qInt_Disabler_t Disabler );
   
    /*only for backward compatibility*/
    /*qSchedulerAddxTask is deprecated, instead use qSchedulerAdd_Task*/
    #define qSchedulerAddxTask      qSchedulerAdd_Task
    /*qSchedulerAddeTask is deprecated, instead use qSchedulerAdd_EventTask*/
    #define qSchedulerAddeTask      qSchedulerAdd_EventTask
    /*qSchedulerAddSMTask is deprecated, instead use qSchedulerAdd_StateMachineTask*/
    #define qSchedulerAddSMTask     qSchedulerAdd_StateMachineTask

    qBool_t _qScheduler_TimeDeadlineCheck( qClock_t ti, qClock_t td );
    qBool_t qSchedulerAdd_Task( qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg );
    qBool_t qSchedulerAdd_EventTask( qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg );

    #if ( Q_FSM == 1)    
    qBool_t qSchedulerAdd_StateMachineTask( qTask_t *Task, qPriority_t Priority, qTime_t Time,
                                qSM_t *StateMachine, qSM_State_t InitState, qSM_SubState_t BeforeAnyState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState,
                                qState_t InitialTaskState, void *arg );
    #endif
    qBool_t qSchedulerRemoveTask( qTask_t *Task );
    void qSchedulerRun( void) ;

    typedef qBool_t (*qTaskNotifyMode_t)(qTask_t*, void*);
    #define Q_NOTIFY_SIMPLE      qTaskSendNotification
    #define Q_NOTIFY_QUEUED      qTaskQueueNotification
    
    #define qTaskSendEvent	        qTaskSendNotification
    #define qTaskQueueEvent		    qTaskQueueNotification
    #define qSchedulerSpreadEvent   qSchedulerSpreadNotification
    qBool_t qTaskQueueNotification( qTask_t *Task, void* eventdata );  
    qBool_t qTaskSendNotification( qTask_t *Task, void* eventdata );
    qBool_t qSchedulerSpreadNotification( void *eventdata, const qTaskNotifyMode_t mode );


    typedef enum{qQUEUE_RECEIVER=_qIndex_QueueReceiver, qQUEUE_FULL=_qIndex_QueueFull, qQUEUE_COUNT=_qIndex_QueueCount, qQUEUE_EMPTY=_qIndex_QueueEmpty}qQueueLinkMode_t;
    /*backward compatibility*/
    #define     qRBLinkMode_t   qQueueLinkMode_t
    #define     qRB_AUTOPOP	    ( qQUEUE_RECEIVER )
    #define	    qRB_FULL	    ( qQUEUE_FULL )
    #define     qRB_COUNT	    ( qQUEUE_COUNT )
    #define     qRB_EMPTY	    ( qQUEUE_EMPTY )

    #define     QUEUE_RECEIVER  ( qQUEUE_RECEIVER )  
    #define     QUEUE_FULL      ( qQUEUE_FULL )
    #define     QUEUE_COUNT     ( qQUEUE_COUNT )
    #define     QUEUE_EMPTY     ( qQUEUE_EMPTY )
    
    #if ( Q_QUEUES == 1) 
        qBool_t qTaskAttachQueue( qTask_t *Task, qQueue_t *Queue, const qQueueLinkMode_t Mode, uint8_t arg );

        qBool_t qQueueCreate( qQueue_t *obj, void* DataArea, qSize_t ItemSize, qSize_t ItemsCount );
        void qQueueReset( qQueue_t *obj );
        qSize_t qQueueCount( const qQueue_t *obj );
        qBool_t qQueueIsFull( const qQueue_t *obj );
        qBool_t qQueueIsEmpty( const qQueue_t *obj );
        void* qQueuePeek( const qQueue_t *obj );
        qBool_t qQueueRemoveFront( qQueue_t *obj );
        qBool_t qQueueGenericSend( qQueue_t *obj, void *ItemToQueue, uint8_t InsertMode );
        qBool_t qQueueReceive (qQueue_t *obj, void *dest );

        /*BACKWARD COMPATIBILITY: Start */
        /*qTaskLinkBuffer is deprecated, instead use qTaskAttachQueue */
        #define qTaskLinkRBuffer		qTaskAttachQueue
        /*qRBufferInit is deprecated, instead use qQueueCreate */
        #define qRBufferInit		    qQueueCreate
        /*qRBufferEmpty is deprecated, instead use qQueueIsEmpty */
        #define	qRBufferEmpty		    qQueueIsEmpty
        /*qRBufferGetFront is deprecated, instead use qQueuePeek */
        #define qRBufferGetFront	    qQueuePeek
        /*qRBufferRemoveFront is deprecated, instead use qQueueRemoveFront */
        #define qRBufferRemoveFront 	qQueueRemoveFront
        /*qRBufferPopFront is deprecated, instead use qQueueReceive */
        #define qRBufferPopFront	    qQueueReceive
        /*qRBufferPush is deprecated, instead use qQueueSendToBack */
        #define qRBufferPush		    qQueueSendToBack
        /*BACKWARD COMPATIBILITY: End */
    #endif
    
    void qTaskSetTime( qTask_t *Task, const qTime_t Value );
    void qTaskSetIterations( qTask_t *Task, const qIteration_t Value );
    void qTaskSetPriority( qTask_t *Task, const qPriority_t Value );
    void qTaskSetCallback( qTask_t *Task, qTaskFcn_t CallbackFcn );
    void qTaskSetState( qTask_t *Task, const qState_t State );
    void qTaskSetData( qTask_t *Task, void* arg );
    void qTaskClearTimeElapsed( qTask_t *Task );
    #if ( Q_TASK_COUNT_CYCLES == 1 )
        uint32_t qTaskGetCycles( const qTask_t *Task );
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

    #if ( Q_PRIORITY_QUEUE == 1 )    
        #define _qQueueStackName                    _qQueueStack
        #define _qQueueStackCreate(QueueSize)       volatile qQueueStack_t _qQueueStackName[(QueueSize)];
        #define _qQueueLength(QueueSize)            (QueueSize)
    #else
        #define _qQueueStackName                    NULL           
        #define _qQueueStackCreate(QueueSize)       
        #define _qQueueLength(QueueSize)            ( 0 )                             
    #endif
    
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
    

    #if ( Q_FSM == 1)
        qBool_t qStateMachine_Init( qSM_t *obj, qSM_State_t InitState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState, qSM_SubState_t BeforeAnyState );
        qBool_t qTaskAttachStateMachine( qTask_t *Task, qSM_t *StateMachine );
        void qStateMachine_Run( qSM_t *obj, void *Data );
        void qStateMachine_Attribute( qSM_t *obj, qFSM_Attribute_t Flag , qSM_State_t  s, qSM_SubState_t subs );
    #endif

    typedef struct{
        _qTaskPC_t instr;
        qClock_t crdelay;
    }qCoroutineInstance_t;
    #ifdef _QUARKTS_CR_DEFS_    
        #define __qCRStart                          __qPersistent  __qTaskInitState ;  __qTaskCheckPCJump(__qTaskPCVar) __RestoreFromBegin
        #define __qCRYield                          __qCRCodeStartBlock{  __qTaskSaveState      ; __qTaskYield  __RestoreAfterYield; }                      __qCRCodeEndBlock
        #define __qCRRestart                        __qCRCodeStartBlock{  __qSetPC(qCR_PCInitVal)      ; __qTaskYield }                                            __qCRCodeEndBlock
        #define __qCR_wu_Assert(_cond_)             __qCRCodeStartBlock{  __qTaskSaveState      ; __RestoreAfterYield   ; __qAssert(_cond_) __qTaskYield }  __qCRCodeEndBlock
        
        #define __qCR_do                            __qCRCodeStartBlock{  __qTaskSaveState      ; __RestoreAfterYield;
        #define __qCR_until( _cond_ )               __qAssert(_cond_) __qTaskYield }  __qCRCodeEndBlock           
        
        #define __qCR_wu_preAssert(_pre_ , _cond_)  __qCR_do{ (_pre_); }__qCR_until((_cond_)) \


        #define __qCR_GetPosition(_pos_)            __qCRCodeStartBlock{  (_pos_) =__qTaskProgress ; __RestoreAfterYield   ;_UNUSED_((_pos_));}                                  __qCRCodeEndBlock
        #define __qCR_RestoreFromPosition(_pos_)    __qCRCodeStartBlock{  __qSetPC(_pos_)       ; __qTaskYield}                                             __qCRCodeEndBlock
        #define __qCR_Delay(_time_)                 __qCRCodeStartBlock{  __qCRDelayPrepare     ; __qTaskSaveState;  __RestoreAfterYield;   __qAssert( _qScheduler_TimeDeadlineCheck(_qCRTaskState_.crdelay, qTime2Clock(_time_))  ) __qTaskYield } __qCRCodeEndBlock
        #define __qCR_PositionReset(_pos_)          (_pos_) = qCR_PCInitVal

        /*qCoroutineBegin{
        
        }qCoroutineEnd;

        qCRBegin{
        
        }qCREnd;
        * 
        Defines a Coroutine segment. Only one segment is allowed inside a task; 
        The qCoroutineBegin statement is used to declare the starting point of 
        a Coroutine. It should be placed at the start of the function in which the 
        Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
        It must always be used together with a matching qCoroutineBegin statement.
        */
        #define qCoroutineBegin                         __qCRStart
        #define qCRBegin                                __qCRStart
        /*qCoroutineYield
        qCRYield

        This statement is only allowed inside a Coroutine segment. qCoroutineYield 
        return the CPU control back to the scheduler but saving the execution progress. 
        With the next task activation, the Coroutine will resume the execution after 
        the last 'qCoroutineYield' statement.

        Action sequence : [Save progress] then [Yield]

        */
        #define qCoroutineYield                         __qCRYield          
        #define qCRYield                                __qCRYield
        /*qCoroutineBegin{
        
        }qCoroutineEnd;
        qCRBegin{
        
        }qCREnd;

        Defines a Coroutine segment. Only one segment is allowed inside a task; 
        The qCoroutineBegin statement is used to declare the starting point of 
        a Coroutine. It should be placed at the start of the function in which the 
        Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
        It must always be used together with a matching qCoroutineBegin statement.
        */    
        #define qCoroutineEnd                           __qCRDispose
        #define qCREnd                                  __qCRDispose
        /*qCoroutineRestart
        qCRRestart

        This statement cause the running Coroutine to restart its execution at the 
        place of the qCoroutineBegin statement.

        Action sequence : [Reload progress] then [Yield]

        */
        #define qCoroutineRestart                       __qCRRestart  
        #define qCRRestart                              __qCRRestart 
        /*qCoroutineWaitUntil(_CONDITION_) 
        qCRWaitUntil(_CONDITION_)

        Yields until the logical condition being true

        Action sequence : [Save progress] 
                        IF (Condition == False){
                            [Yield]      
                        }  

        */    
        #define qCoroutineWaitUntil(_condition_)        __qCR_wu_Assert(_condition_)
        #define qCRWaitUntil(_condition_)               __qCR_wu_Assert(_condition_)

        /*qCoroutineDo 
        qCRDo

        This statement tart a blocking Job segment. 
        Must be used together with a matching qCoroutineDo statement.   
        */    
        #define qCoroutineDo                        __qCR_do
        #define qCRDo                               __qCR_do
        /*qCoroutineUntil( _condition_ )
        qCRUntil( _condition_ )

        This statement ends a qCoroutineDo statement for a blocking Job.   
        The condition determines if the blocking job ends (if condition is True)
        or continue yielding (if false)
        */         
        #define qCoroutineUntil( _condition_ )           __qCR_until( _condition_ )
        #define qCRUntil( _condition_ )                  __qCR_until( _condition_ )

        /*qCoroutineSemaphoreInit(_qCRSemaphore_t_, _Value_) 
        qCRSemInit(_qCRSemaphore_t_, _Value_)

        Initializes a semaphore with a value for the counter. Internally, the semaphores
        use an "unsigned int" to represent the counter,  therefore the "count" 
        argument should be within range of an unsigned int.

        Parameters:

            - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore

            - _Value_ : The initial count of the semaphore.
        */          
        #define qCoroutineSemaphoreInit(_qCRSemaphore_t_, _Value_)      __qCRSemInit((_qCRSemaphore_t_), (_Value_))
        #define qCRSemInit(_qCRSemaphore_t_, _Value_)                   __qCRSemInit((_qCRSemaphore_t_), (_Value_))  
        /*qCoroutineSemaphoreWait(_qCRSemaphore_t_) 
        qCRSemWait(_qCRSemaphore_t_)  

        Carries out the "wait" operation on the semaphore. The wait operation causes 
        the Co-routine to block while the counter is zero. When the counter reaches a 
        value larger than zero, the Co-routine  will continue.

        Parameters:

            - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore
        */        
        #define qCoroutineSemaphoreWait(_qCRSemaphore_t_)               __qCRCodeStartBlock{ qCoroutineWaitUntil(__qCRSemCount(_qCRSemaphore_t_) > 0);  __qCRSemLock(_qCRSemaphore_t_); } __qCRCodeEndBlock    
        #define qCRSemWait(_qCRSemaphore_t_)                            qCoroutineSemaphoreWait(_qCRSemaphore_t_)

        /*qCoroutineSemaphoreSignal(_qCRSemaphore_t_) 
        qCRSemSignal(_qCRSemaphore_t_)

        Carries out the "signal" operation on the semaphore. The signal operation increments
        the counter inside the semaphore, which eventually will cause waiting Co-routines
        to continue executing.

        Parameters:

            - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore
        */     
        #define qCoroutineSemaphoreSignal(_qCRSemaphore_t_)             __qCRSemRelease(_qCRSemaphore_t_)
        #define qCRSemSignal(_qCRSemaphore_t_)                          __qCRSemRelease(_qCRSemaphore_t_)
        /*qCoroutinePositionGet(qCRPosition_t _CRPos_)
        qCRPositionGet(qCRPosition_t _CRPos_) 

        Labels the current position and saves it to _CRPos_ so it can be later restored by qCoroutinePositionRestore
        */    
        #define qCoroutinePositionGet(_CRPos_)                          __qCR_GetPosition(_CRPos_)
        #define qCRPositionGet(_CRPos_)                                 __qCR_GetPosition(_CRPos_)
        /*qCoroutinePositionRestore(qCRPosition_t _CRPos_)
        qCRPositionRestore(qCRPosition_t _CRPos_) 

        Restores the Co-Routine position saved in _CRPos_
        */   
        #define qCoroutinePositionRestore(_CRPos_)                      __qCR_RestoreFromPosition(_CRPos_)
        #define qCRPositionRestore(_CRPos_)                             __qCR_RestoreFromPosition(_CRPos_)
        /*qCoroutinePositionReset(qCRPosition_t _CRPos_)
        qCRPositionReset(qCRPosition_t _CRPos_) 

        Resets the _CRPos_ variable to the begining of the Co-Routine
        */ 
        #define qCoroutinePositionReset(_CRPos_)                        __qCR_PositionReset(_CRPos_)
        #define qCRPositionReset(_CRPos_)                               __qCR_PositionReset(_CRPos_)

        /*qCoroutineDelay(_qTime_t_) 
        qCRDelay(_qTime_t_)  

        Delay a coroutine for a given number of time

        Parameters:

            - _qTime_t_ :  The amount of time (In seconds), that the calling coroutine should yield.
        */        
        #define qCoroutineDelay(_qTime_t_)                              __qCR_Delay(_qTime_t_)
        #define qCRDelay(_qTime_t_)                                     __qCR_Delay(_qTime_t_)
    #endif  
    
    typedef struct{ /*STimer defintion*/
        qConst qClock_t Start, TV; /*The time-epochs registers*/
    }qSTimer_t;
    
    #define QSTIMER_ARMED           ( qTrue )
    #define QSTIMER_DISARMED        ( qFalse )
    #define QSTIMER_DISARM_VALUE    ( 0ul )

    #define _qSTimerIsArmed(_pObj_)     ( (_pObj_)->TV)
    qBool_t qSTimerSet( qSTimer_t *obj, const qTime_t Time );
    qBool_t qSTimerExpired( const qSTimer_t *obj );
    qBool_t qSTimerFreeRun( qSTimer_t *obj, const qTime_t Time );
    qClock_t qSTimerElapsed( const qSTimer_t *obj );
    qClock_t qSTimerRemaining( const qSTimer_t *obj );
    void qSTimerDisarm( qSTimer_t *obj );
    qBool_t qSTimerStatus( const qSTimer_t *obj );
    #define QSTIMER_INITIALIZER     {0ul, 0ul}
    
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        #define qMins2Time(t)    ( ((qTime_t)(t))*60.0 )    
        #define qHours2Time(t)   ( ((qTime_t)(t))*3600.0 )
        #define qDays2Time(t)    ( ((qTime_t)(t))*86400.0 )
        #define qWeeks2Time(t)   ( ((qTime_t)(t))*604800.0 )
    #endif 

    typedef volatile char qISR_Byte_t;
    typedef volatile struct{
        qISR_Byte_t *pData;
        qBool_t (*AcceptCheck)(const char);
        char (*PreChar)(const char);    
        volatile uint16_t index;
        uint16_t MaxIndex;
        volatile qBool_t ReadyFlag;
        char EndByte;
    }qISR_ByteBuffer_t;

    #ifdef Q_TASK_DEV_TEST
    void qSchedulePrintChain( void );
    #endif

    #if ( Q_BYTE_SIZED_BUFFERS == 1 )
        typedef struct{
            volatile uint16_t head;
            volatile uint16_t tail;
            qSize_t length;
            volatile uint8_t *buffer;
        }qBSBuffer_t;
    #endif

    typedef void (*qPutChar_t)(void*, const char);
    typedef void (*qPutString_t)(void*, const char*);
    typedef char (*qGetChar_t)(void*);
    void qSwapBytes( void *data, const qSize_t n );
    qBool_t qCheckEndianness( void);
    void qOutputString( qPutChar_t fcn, void* pStorage, const char *s, qBool_t AIP );
    void qOutputRaw( qPutChar_t fcn, void* pStorage, void *data, const qSize_t n, qBool_t AIP );
    void qInputRaw( const qGetChar_t fcn, void* pStorage, void *data, const qSize_t n, qBool_t AIP );

    /*qPrintString(fcn, pStorage, s)
    
    This macro is a Wrapper method to write a string through fcn
    
    Parameters:

        - fcn : The basic output byte function
        - pStorage : The storage pointer passed to fcn
        - s: The string to be written
    */
    #define qPrintString(fcn, pStorage, s)          qOutputString((fcn), (void*)(pStorage), (const char *)(s), qFalse) 
    #define qPrintRaw(fcn, pStorage, data, n)       qOutputRaw((fcn), (void*)(pStorage), (void*)(data), (n), qFalse) 

    /*Some utilities*/
    char* qU32toX( uint32_t value, char *str, int8_t n );
    uint32_t qXtoU32( const char *s );
    double qAtoF( const char *s );
    int qAtoI( const char *s );
    char* qUtoA( uint32_t num, char* str, uint8_t base );
    char* qItoA( int32_t num, char* str, uint8_t base );
    char* qBtoA( qBool_t num, char *str );
    char* qQBtoA (qBool_t num, char *str );
    qBool_t qIsInf( float f );
    qBool_t qIsNan( float f );
    char* qFtoA( float num, char *str, uint8_t precision );
    uint32_t qStringHash( const char* s, uint8_t mode );
    void qPrintXData( qPutChar_t fcn, void* pStorage, void *data, qSize_t n );

    /*qSetDebugFcn(fcn)

    This macro set the output method for debug/trace messages.

    Parameters:

        - fcn : The basic output byte function

    */ 
    #define qSetDebugFcn(fcn)           __qDebugOutputFcn = (fcn)
    extern qPutChar_t __qDebugOutputFcn;
    extern qPutString_t __qDebugOutputStringFcn;

    # ifndef __QTRACE_FUNC
    #  if defined __cplusplus && defined __GNUC__ /* Use g++'s demangled names in C++.  */
      #if  __GNUC__ >= 2
        #define __QTRACE_FUNC __PRETTY_FUNCTION__
      #else
        #define __QTRACE_FUNC   __func__
      #endif       

    #  elif __STDC_VERSION__ >= 199901L /* C99 requires the use of __func__.  */
    #   define __QTRACE_FUNC __func__
    #  else /* failed to detect __func__ support.  */
    #   define __QTRACE_FUNC ((char *) 0)
    #  endif
    # endif

    #define __qSTRINGIFY(x) #x
    #define __qTOSTRING(x) __qSTRINGIFY(x)

    #if ( Q_DEBUGTRACE_FULL == 1 )
        #ifndef __QTRACE_FUNC
            #if defined __cplusplus && defined __GNUC__ /* Use g++'s demangled names in C++.  */
                #define __QTRACE_FUNC __PRETTY_FUNCTION__
            #elif __STDC_VERSION__ >= 199901L /* C99 requires the use of __func__.  */
                #define __QTRACE_FUNC __func__
            #elif __GNUC__ >= 2 /* Older versions of gcc don't have __func__ but can use __FUNCTION__.  */
                #define __QTRACE_FUNC __FUNCTION__
            #else /* failed to detect __func__ support.  */
                #define __QTRACE_FUNC ((char *) 0)
            #  endif
        # endif

        #define __qAT() "[" __FILE__ ":" __qTOSTRING(__LINE__) "] " 
    #else
        #define __qAT()         ""
        #define __QTRACE_FUNC    ((char *) 0)
    #endif

    #ifndef Message
        #define Message
    #endif
    #ifndef String
        #define String
    #endif
    #ifndef Bool
        #define Bool
    #endif
    #ifndef qBool
        #define qBool
    #endif
    #ifndef Float
        #define Float 
    #endif
    #ifndef Binary
        #define Binary 
    #endif
    #ifndef Octal
        #define Octal 
    #endif
    #ifndef Decimal
        #define Decimal 
    #endif
    #ifndef Hexadecimal
        #define Hexadecimal 
    #endif
    #ifndef UnsignedBinary
        #define UnsignedBinary 
    #endif
    #ifndef UnsignedOctal
        #define UnsignedOctal 
    #endif
    #ifndef UnsignedDecimal
        #define UnsignedDecimal 
    #endif
    #ifndef UnsignedHexadecimal
        #define UnsignedHexadecimal 
    #endif

    #if ( Q_TRACE_VARIABLES == 1 )
        extern char qDebugTrace_Buffer[Q_DEBUGTRACE_BUFSIZE];
        void __qtrace_func( const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, qSize_t BlockSize );
        
        /*On-demand debug/trace macros*/
        #define qTrace()                        __qtrace_func (__qAT(), __QTRACE_FUNC, "", "", NULL, 0)      
        #define qDebugCaller()                  __qtrace_func ("",__QTRACE_FUNC, "", "", NULL, 0)   

        #define qDebugMessage(Var)              __qtrace_func ("", NULL, "", (char*)(Var), NULL, 0)
        #define qDebugString(Var)               __qtrace_func ("", NULL, #Var "="  , (char*)(Var), NULL, 0)
        #define qDebugBool(Var)                 __qtrace_func ("", NULL, #Var "="  , qBtoA(( qBool_t)(Var), qDebugTrace_Buffer    ), NULL, 0)
        #define qDebugqBool(Var)                __qtrace_func ("", NULL, #Var "="  , qQBtoA(( qBool_t)(Var), qDebugTrace_Buffer   ), NULL, 0)
        #define qDebugBinary(Var)               __qtrace_func ("", NULL, #Var "=0b", qItoA(( int32_t)(Var), qDebugTrace_Buffer,  2), NULL, 0)
        #define qDebugOctal(Var)                __qtrace_func ("", NULL, #Var "=0" , qItoA(( int32_t)(Var), qDebugTrace_Buffer,  8), NULL, 0)
        #define qDebugHexadecimal(Var)          __qtrace_func ("", NULL, #Var "=0x", qItoA(( int32_t)(Var), qDebugTrace_Buffer, 16), NULL, 0)
        #define qDebugDecimal(Var)              __qtrace_func ("", NULL, #Var "="  , qItoA(( int32_t)(Var), qDebugTrace_Buffer, 10), NULL, 0)
        #define qDebugFloat(Var)                __qtrace_func ("", NULL, #Var "="  , qFtoA(( float  )(Var), qDebugTrace_Buffer, 10), NULL, 0)
        #define qDebugFloatPrec(Var, Pc)        __qtrace_func ("", NULL, #Var "="  , qFtoA(( float  )(Var), qDebugTrace_Buffer, (Pc)), NULL, 0)
        #define qDebugUnsignedBinary(Var)       __qtrace_func ("", NULL, #Var "=0b", qUtoA((uint32_t)(Var), qDebugTrace_Buffer,  2), NULL, 0)
        #define qDebugUnsignedOctal(Var)        __qtrace_func ("", NULL, #Var "=0" , qUtoA((uint32_t)(Var), qDebugTrace_Buffer,  8), NULL, 0)
        #define qDebugUnsignedHexadecimal(Var)  __qtrace_func ("", NULL, #Var "=0x", qUtoA((uint32_t)(Var), qDebugTrace_Buffer, 16), NULL, 0)
        #define qDebugUnsignedDecimal(Var)      __qtrace_func ("", NULL, #Var "="  , qUtoA((uint32_t)(Var), qDebugTrace_Buffer, 10), NULL, 0)
        

        #define qTraceMessage(Var)              __qtrace_func (__qAT(), __QTRACE_FUNC, "", (char*)(Var), NULL, 0)
        #define qTraceString(Var)               __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , (char*)(Var), NULL, 0)
        #define qTraceBool(Var)                 __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qBtoA(( qBool_t)(Var), qDebugTrace_Buffer    ), NULL, 0)
        #define qTraceqBool(Var)                __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qQBtoA(( qBool_t)(Var), qDebugTrace_Buffer   ), NULL, 0)
        #define qTraceBinary(Var)               __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0b", qItoA(( int32_t)(Var), qDebugTrace_Buffer,  2), NULL, 0)
        #define qTraceOctal(Var)                __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0" , qItoA(( int32_t)(Var), qDebugTrace_Buffer,  8), NULL, 0)
        #define qTraceHexadecimal(Var)          __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0x", qItoA(( int32_t)(Var), qDebugTrace_Buffer, 16), NULL, 0)
        #define qTraceDecimal(Var)              __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qItoA(( int32_t)(Var), qDebugTrace_Buffer, 10), NULL, 0)
        #define qTraceFloat(Var)                __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qFtoA(( float  )(Var), qDebugTrace_Buffer, 10), NULL, 0)
        #define qTraceFloatPrec(Var, Pc)        __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qFtoA(( float  )(Var), qDebugTrace_Buffer, (Pc)), NULL, 0)
        #define qTraceUnsignedBinary(Var)       __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0b", qUtoA((uint32_t)(Var), qDebugTrace_Buffer,  2), NULL, 0)
        #define qTraceUnsignedOctal(Var)        __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0" , qUtoA((uint32_t)(Var), qDebugTrace_Buffer,  8), NULL, 0)
        #define qTraceUnsignedHexadecimal(Var)  __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "=0x", qUtoA((uint32_t)(Var), qDebugTrace_Buffer, 16), NULL, 0)
        #define qTraceUnsignedDecimal(Var)      __qtrace_func (__qAT(), __QTRACE_FUNC, #Var "="  , qUtoA((uint32_t)(Var), qDebugTrace_Buffer, 10), NULL, 0)
        /*qTraceMem/qTraceMemory(Pointer, BlockSize)

        Trace memory from the specified address (HEX output)

        Parameters:

            - Pointer : The target memory address
            - Size: Number of bytes

        Note: the Debug/Trace function must be previously defined with qSetDebugFcn
        */
        #define qTraceMemory(Pointer, BlockSize)    __qtrace_func (__qAT(), __QTRACE_FUNC, __qTOSTRING(Var) "=", NULL, (Pointer), (BlockSize))
        #define qTraceMem(Pointer, BlockSize)       qTraceMemory((Pointer), (BlockSize))
        #define qDebugMemory(Pointer, BlockSize)    __qtrace_func ("", NULL, __qTOSTRING(Var) "=", NULL, (Pointer), (BlockSize))
        #define qDebugMem(Pointer, BlockSize)       qDebugMemory((Pointer), (BlockSize)) 
        /*qTraceVar/qTraceVariable(Pointer, DISP_TYPE_MODE)
        Trace a variable (up to 32bit data) 

        Parameters:

            - Var : The target variable
            - DISP_TYPE_MODE: Visualization mode. It must be one of the following parameters:
                            Bool, Float, Binary, Octal, Decimal, Hexadecimal, UnsignedBinary, 
                            UnsignedOctal, UnsignedDecimal, UnsignedHexadecimal.
        
        Note: the Debug/Trace function must be previously defined with qSetDebugFcn
        */
        #define qTraceVariable(Var, DISP_TYPE_MODE) qTrace##DISP_TYPE_MODE(Var)
        #define qTraceVar(Var, DISP_TYPE_MODE)      qTrace##DISP_TYPE_MODE(Var)
        #define qDebugVar(Var, DISP_TYPE_MODE)      qDebug##DISP_TYPE_MODE(Var)    
        #define qDebugVariable(Var, DISP_TYPE_MODE) qDebug##DISP_TYPE_MODE(Var)  
    #else
        #define qTrace()
        #define qTraceMessage(Var)
        #define qTraceString(Var)
        #define qTraceVar(Var, DISP_TYPE_MODE)
        #define qTraceVariable(Var, DISP_TYPE_MODE)
        #define qTraceBool(Var) 
        #define qTraceqBool(Var) 
        #define qTraceBinary(Var)
        #define qTraceOctal(Var)
        #define qTraceHexadecimal(Var)
        #define qTraceDecimal(Var) 
        #define qTraceFloat(Var)
        #define qTraceUnsignedBinary(Var)
        #define qTraceUnsignedOctal(Var)
        #define qTraceUnsignedHexadecimal(Var)
        #define qTraceUnsignedDecimal(Var)
        #define qTraceUnsignedDecimal(Var)
        #define qTraceMemory(Pointer, BlockSize)
        #define qTraceMem(Pointer, BlockSize)
        #define qTraceVariable(Var, DISP_TYPE_MODE)
        #define qTraceVar(Var, DISP_TYPE_MODE)

        #define qDebugCaller()               
        #define qDebugMessage(Var)
        #define qDebugString(Var)
        #define qDebugBool(Var)
        #define qDebugqBool(Var)
        #define qDebugBinary(Var) 
        #define qDebugOctal(Var)
        #define qDebugHexadecimal(Var)
        #define qDebugDecimal(Var)
        #define qDebugFloat(Var)
        #define qDebugFloatPrec(Var, Pc)
        #define qDebugUnsignedBinary(Var)
        #define qDebugUnsignedOctal(Var)
        #define qDebugUnsignedHexadecimal(Var)
        #define qDebugUnsignedDecimal(Var)
        #define qDebugMemory(Pointer, BlockSize)
        #define qDebugMem(Pointer, BlockSize)   
        #define qDebugVar(Var, DISP_TYPE_MODE)   
        #define qDebugVariable(Var, DISP_TYPE_MODE)    
    #endif

    typedef struct{
        char *Pattern2Match;
        qSize_t MaxStrLength;
        qSize_t PatternLength;
        volatile qSize_t MatchedCount;
        volatile qBool_t ResponseReceived;
        qSTimer_t timeout;
    }qResponseHandler_t; 
    #define QRESPONSE_INITIALIZER   {NULL, 0u, 0u, 0u, qFalse, {0u, 0u}}
    void qResponseInitialize( qResponseHandler_t *obj, char *xLocBuff, qSize_t nMax ); 
    void qResponseReset( qResponseHandler_t *obj );
    qBool_t qResponseReceived( qResponseHandler_t *obj, const char *Pattern, qSize_t n );
    qBool_t qResponseReceivedWithTimeout( qResponseHandler_t *obj, const char *Pattern, qSize_t n, qTime_t t );
    qBool_t qResponseISRHandler( qResponseHandler_t *obj, const char rxchar );

    #if ( Q_BYTE_SIZED_BUFFERS == 1 )
        qSize_t qBSBuffer_Count( qBSBuffer_t const* obj );
        qBool_t qBSBuffer_IsFull( qBSBuffer_t const* obj );
        qBool_t qBSBuffer_Empty( qBSBuffer_t const *obj );
        uint8_t qBSBuffer_Peek( qBSBuffer_t const *obj );
        qBool_t qBSBuffer_Get( qBSBuffer_t *obj, uint8_t *dest );
        qBool_t qBSBuffer_Read( qBSBuffer_t *obj, void *dest, const qSize_t n );
        qBool_t qBSBuffer_Put( qBSBuffer_t *obj, const uint8_t data );
        void qBSBuffer_Init( qBSBuffer_t *obj, volatile uint8_t *buffer, const qSize_t length );
    #endif
       
    typedef struct _qIONode_t{
        qBool_t Pin, PreviousPinValue, Status;
        struct _qIONode_t *Next;
        void *Port;
    }qIONode_t;

    typedef qBool_t (*qCoreRegSize_t)(void*, qBool_t);
    typedef struct{
        qIONode_t *Head;
        qClock_t Start, DebounceTime;
        qCoreRegSize_t Reader;
        qBool_t State;
    }qIOEdgeCheck_t;
    qBool_t __qReg_08Bits( void *Address, qBool_t PinNumber );
    qBool_t __qReg_16Bits( void *Address, qBool_t PinNumber );
    qBool_t __qReg_32Bits( void *Address, qBool_t PinNumber );
    qBool_t qEdgeCheck_Initialize( qIOEdgeCheck_t *Instance, const qCoreRegSize_t RegisterSize, qClock_t DebounceTime );
    qBool_t qEdgeCheck_InsertNode( qIOEdgeCheck_t *Instance, qIONode_t *Node, void *PortAddress, qBool_t PinNumber );    
    qBool_t qEdgeCheck_Update( qIOEdgeCheck_t *Instance );
    qBool_t qEdgeCheck_GetNodeStatus( const qIONode_t *Node );

    #if ( Q_ATCOMMAND_PARSER == 1 )
        #define		QAT_DEFAULT_AT_COMMAND	            "at"
        #define		QAT_DEFAULT_ID_COMMAND	            "atid"
        #define		QAT_DEFAULT_ATSET_DELIM	            ','
        #define     QAT_DEFAULT_ERROR_RSP_STRING        "ERROR"
        #define     QAT_DEFAULT_OK_RSP_STRING           "OK"
        #define     QAT_DEFAULT_NOTFOUND_RSP_STRING     "UNKNOWN"
        #define     QAT_DEAFULT_NOTALLOWED_RSP_STRING   ":NOT ALLOWED"
        #define     QAT_DEFAULT_DEVID_STRING            QUARKTS_CAPTION
        #define     QAT_DEFAULT_EOL_STRING              "\r\n"              

        #define     QAT_MIN_INPUT_LENGTH                ( 3u )

        typedef enum{
            qAT_ERROR = -32768,
            qAT_NOTALLOWED = -32767,
            qAT_NORESPONSE = 0,
            qAT_OK = 1,
            qAT_DEVID = 32765,
            qAT_NOTFOUND = 32766,
            qAT_OUTPUT = 32767
        }qATResponse_t; 

        #define     qAT_ERRORCODE(ecode)     (-(ecode))
        #define     QAT_ERROR                ( qAT_ERROR )
        #define     QAT_NORESPONSE           ( qAT_NORESPONSE )
        #define     QAT_OK                   ( qAT_OK )
        #define     QAT_ERRORCODE(_num_)     ( qAT_ERRORCODE(_num_) )
        #define     QAT_DEVID                ( qAT_DEVID )
        #define     QAT_NOTFOUND             ( qAT_NOTFOUND )    
        #define     QAT_OUTPUT               ( qAT_OUTPUT )

        typedef volatile struct{
            volatile uint8_t Ready;
            volatile uint16_t index;
            qSize_t Size;
            volatile char *Buffer;
        }qATParserInput_t;

        typedef void (*qPutchFcn_t)(const char);
        typedef void (*qPutsFcn_t)(const char*);

        typedef struct{
            void *First;
            char *OK_Response;
            char *ERROR_Response;
            char *NOTFOUND_Response;
            char *Identifier;
            char *term_EOL;
            qPutChar_t OutputFcn;
            qPutchFcn_t putch;
            qPutsFcn_t puts;
            qTask_t *Task;
            char *Output;
            qSize_t SizeOutput;
            qATParserInput_t Input;
        }qATParser_t;   
        
        #define QATCMDTYPE_UNDEF    ( 0x0000 )
        #define QATCMDTYPE_PARA     ( 0x0100 )
        #define QATCMDTYPE_TEST     ( 0x0200 )  
        #define QATCMDTYPE_READ     ( 0x0400 )
        #define QATCMDTYPE_ACT      ( 0x0800 )

        #define QATCMDTYPE_SET      ( QATCMDTYPE_PARA )
        #define QATCMDTYPE_CHECK    ( QATCMDTYPE_ACT )

        #define QATCMDMASK_ARG_MAXNUM(opt)   (((opt)>>4)&0x000Fu)
        #define QATCMDMASK_ARG_MINNUM(opt)   ((opt)&0x000Fu)

        typedef enum{
            qATCMDTYPE_UNDEF    = QATCMDTYPE_UNDEF, /* None of the above */
            qATCMDTYPE_PARA     = QATCMDTYPE_PARA,  /* AT+cmd=x,y */
            qATCMDTYPE_TEST     = QATCMDTYPE_TEST,  /* AT+cmd=? */
            qATCMDTYPE_READ     = QATCMDTYPE_READ,  /* AT+cmd? */
            qATCMDTYPE_ACT      = QATCMDTYPE_ACT    /* AT+cmd */     
        }qATCommandType_t;

        typedef struct{
            void *Command; /*a pointer to the calling AT Command object*/
            char *StrData; /*the string data*/
            qATCommandType_t Type; /*The command type*/
            qSize_t StrLen; /*the length of StrData*/
            qSize_t NumArgs; /*Number of arguments, only available if Type = QATCMDTYPE_SET*/
        }qATParser_PreCmd_t;

        typedef qATResponse_t (*qATCommandCallback_t)(qATParser_t*, qATParser_PreCmd_t*);
        
        typedef struct _qATCommand_t{
            char *Text;
            qATCommandCallback_t CommandCallback;
            struct _qATCommand_t *Next;
            uint16_t CmdOpt;
            qSize_t CmdLen;
        }qATCommand_t;

        qBool_t qATParser_Setup( qATParser_t *Parser, qPutChar_t OutputFcn, char *Input, qSize_t SizeInput, char *Output, qSize_t SizeOutput, const char *Identifier, const char *OK_Response, const char *ERROR_Response, const char *NOTFOUND_Response, const char *term_EOL );
        qBool_t qATParser_CmdSubscribe( qATParser_t *Parser, qATCommand_t *Command, const char *TextCommand, qATCommandCallback_t Callback, uint16_t CmdOpt );
        qBool_t qATParser_ISRHandler( qATParser_t *Parser, char c );
        qBool_t qATParser_ISRHandlerBlock( qATParser_t *Parser, char *data, qSize_t n );
        qBool_t qATParser_Raise( qATParser_t *Parser, const char *cmd );
        qATResponse_t qATParser_Exec( qATParser_t *Parser, const char *cmd );
        qBool_t qSchedulerAdd_ATParserTask( qTask_t *Task, qATParser_t *Parser, qPriority_t Priority );
        void qATCommandParser_FlushInput( qATParser_t *Parser );
        qBool_t qATParser_Run( qATParser_t *Parser );

        char* qATParser_GetArgString( const qATParser_PreCmd_t *param, int8_t n, char* out );
        char* qATParser_GetArgPtr( const qATParser_PreCmd_t *param, int8_t n );
        int qATParser_GetArgInt( const qATParser_PreCmd_t *param, int8_t n );
        float qATParser_GetArgFlt( const qATParser_PreCmd_t *param, int8_t n );
        uint32_t qATParser_GetArgHex( const qATParser_PreCmd_t *param, int8_t n );

    #endif

    #if ( Q_MEMORY_MANAGER  == 1 )     
        #ifndef Q_BYTE_ALIGNMENT    
            #define Q_BYTE_ALIGNMENT    ( 8 )
        #endif

        #ifdef __GNUC__
            #ifdef __x86_64__
                typedef uint64_t qAddress_t; 
            #else
                typedef uint32_t qAddress_t;
            #endif
        #else
            typedef uint32_t qAddress_t;
        #endif

        /* Linked list structure to connect the free blocks in order of their memory address. */
        typedef struct qMemBlockConnect_s{
            struct qMemBlockConnect_s *Next; /*used to point the next free block*/
            size_t BlockSize;	
        }qMemBlockConnect_t;

        typedef struct{
            qMemBlockConnect_t *End; 
            uint8_t *Heap;
            size_t HeapSize; 
            size_t FreeBytesRemaining;
            size_t BlockAllocatedBit;
            qMemBlockConnect_t Start;
        }qMemoryPool_t;
        
        void* qMalloc(size_t size);
        void qFree(void *ptr);
        size_t qHeapGetFreeSize( void );

        void qMemoryPool_Select( qMemoryPool_t *mPool );
        qBool_t qMemoryPool_Init (qMemoryPool_t *mPool, void* Area, size_t size );
    #endif /* MEMORY MANAGER */


    #if ( Q_LISTS == 1 )
        typedef struct node_s{
            struct node_s *next, *prev;
        }qNode_t;

        typedef struct{
            qNode_t *head, *tail;
            qSize_t size;
        }qList_t;
        #define qNode_MinimalFields                  void *next, *prev, *data

        typedef void(*qListVisualizer_t)(void*);
        typedef enum{qList_AtFront =-1 , qList_AtBack = 32766}qListPosition_t;
        #define QLIST_ATFRONT             ( qList_AtFront )
        #define QLIST_ATBACK              ( qList_AtBack  )

        void qList_Initialize( qList_t *list );
        qBool_t qList_Insert( qList_t *list, void *node, qListPosition_t position );
        void* qList_Remove( qList_t *list, void *node, qListPosition_t position );
        qBool_t qList_IsMember( const qList_t *list, void *node );
        void qList_View( const qList_t *list, const qListVisualizer_t visualizer );
        void* qList_GetFront( const qList_t *list );
        void* qList_GetBack( const qList_t *list );
        qBool_t qList_IsEmpty( const qList_t *list );
        qSize_t qList_Length( const qList_t *list );

    #endif /* Q_LIST */

#ifdef	__cplusplus
}
#endif

#endif	/* H_QuarkTS */
