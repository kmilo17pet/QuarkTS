/*!
 * @file qkernel.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qkernel.h"
#include "qkshared.h" /*kernel shared methods*/

#define QKERNEL_BIT_INIT          ( 0x00000001uL )  
#define QKERNEL_BIT_FCALLIDLE     ( 0x00000002uL )
#define QKERNEL_BIT_RELEASESCHED  ( 0x00000004uL )
#define QKERNEL_BIT_FCALLRELEASED ( 0x00000008uL )

#define QKERNEL_COREFLAG_SET( FLAG, BIT )       ( FLAG ) |= (qCoreFlags_t)(  BIT )     
#define QKERNEL_COREFLAG_CLEAR( FLAG, BIT )     ( FLAG ) &= (qCoreFlags_t)( ~BIT ) 
#define QKERNEL_COREFLAG_GET( FLAG, BIT )       ( ( 0uL != (( FLAG ) & ( BIT )) )? qTrue : qFalse )

/*an item of the priority-queue*/
/*! @cond  */
typedef struct _qQueueStack_s{
    qTask_t *Task;      /*< A pointer to the task. */
    void *QueueData;    /*< The data to queue. */
}qQueueStack_t;  

typedef qUINT32_t qCoreFlags_t;

typedef qBool_t (*qNotificationSpreaderFcn_t)( qTask_t * const Task, void* eventdata );

typedef struct _qNotificationSpreader_s{
    qNotificationSpreaderFcn_t mode;
    void *eventdata;
}qNotificationSpreader_t;

typedef struct _qKernelControlBlock_s{ /*KCB(Kernel Control Block) definition*/
    qList_t CoreLists[ Q_PRIORITY_LEVELS + 2 ];
    qTaskFcn_t IDLECallback;                            /*< The callback function that represents the idle-task activities. */
    qTask_t *CurrentRunningTask;                        /*< Points to the current running task. */    
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        qTaskFcn_t ReleaseSchedCallback;                /*< The callback function for the scheduler release action. */
    #endif    
    #if ( Q_PRIO_QUEUE_SIZE > 0 ) 
        void *QueueData;                                /*< Hold temporarily one item-data of the FIFO queue.*/
        qQueueStack_t QueueStack[ Q_PRIO_QUEUE_SIZE ];  /*< The required stack to build the FIFO priority queue. */
        volatile qBase_t QueueIndex;                    /*< The current index of the FIFO priority queue. */
    #endif 
    _qEvent_t_ EventInfo;                               /*< Used to hold the event info for a task that will be changed to the qRunning state.*/
    volatile qCoreFlags_t Flag;                         /*< The scheduler Core-Flags. */
    #if ( Q_NOTIFICATION_SPREADER == 1 )
        volatile qNotificationSpreader_t NotificationSpreadRequest;
    #endif
    #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
        size_t TaskEntries;                             /*< Used to hold the number of task entries*/
    #endif
}qKernelControlBlock_t;
/*! @endcond  */

/*=========================== Kernel Control Block ===========================*/
static qKernelControlBlock_t kernel;
static qList_t *const WaitingList = &kernel.CoreLists[ Q_PRIORITY_LEVELS ];
static qList_t *const SuspendedList = &kernel.CoreLists[ Q_PRIORITY_LEVELS + 1 ];
static qList_t *const ReadyList = &kernel.CoreLists[ 0 ];
/*=============================== Private Methods ============================*/
static qBool_t qOS_TaskDeadLineReached( qTask_t * const Task );
static qBool_t qOS_CheckIfReady( qList_ForEachHandle_t h );
static qBool_t qOS_Dispatch( qList_ForEachHandle_t h );    
static qTrigger_t qOS_Dispatch_xTask_FillEventInfo( qTask_t *Task );

#define _qAbs( x )    ((((x)<0) && ((x)!=qPeriodic))? -(x) : (x))

#if ( Q_PRIO_QUEUE_SIZE > 0 )  
    static void qOS_PriorityQueue_ClearIndex( qIndex_t IndexToClear );
    static void qOS_PriorityQueue_CleanUp( const qTask_t * task );
    static qTask_t* qOS_PriorityQueue_Get( void );
#endif

#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
    static void qOS_TriggerReleaseSchedEvent( void );
#endif

#if ( Q_QUEUES == 1)
    static qTrigger_t qOS_AttachedQueue_CheckEvents( const qTask_t * const Task );
#endif

#if ( Q_ATCLI == 1)
    static void qOS_ATCLI_TaskCallback( qEvent_t  e );
    static void qOS_ATCLI_NotifyFcn( qATCLI_t * const cli );
#endif

#if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
    static qBool_t qOS_TaskEntryOrderPreserver( qList_CompareHandle_t h );
#endif

/*========================== Shared Private Method ===========================*/
void qOS_DummyTask_Callback( qEvent_t e ){
    Q_UNUSED( e ); 
}
/*============================================================================*/
#if (Q_SETUP_TIME_CANONICAL == 1)
    void qOS_Setup( const qGetTickFcn_t TickProvider, qTaskFcn_t IdleCallback ){
#else
    void qOS_Setup( const qGetTickFcn_t TickProvider, const qTimingBase_t BaseTimming, qTaskFcn_t IdleCallback ){
#endif
    qIndex_t i;
    qList_Initialize( SuspendedList );
    qList_Initialize( WaitingList );
    for( i = (qIndex_t)0; i < (qIndex_t)Q_PRIORITY_LEVELS; i++ ){
        qList_Initialize( &ReadyList[ i ] );
    }
    #if ( Q_SETUP_TIME_CANONICAL != 1 )
        qClock_SetTimeBase( BaseTimming );
    #endif
    kernel.IDLECallback = IdleCallback;
    #if ( Q_PRIO_QUEUE_SIZE > 0 )    
        /*init the priority queue*/
        for( i = 0u ; i < (qIndex_t)Q_PRIO_QUEUE_SIZE ; i++ ){
            kernel.QueueStack[ i ].Task = NULL;  /*set the priority queue as empty*/  
        }
        kernel.QueueIndex = -1;     
        kernel.QueueData = NULL;
    #endif
    #if ( Q_NOTIFICATION_SPREADER == 1 )
        kernel.NotificationSpreadRequest.mode = NULL;
        kernel.NotificationSpreadRequest.eventdata = NULL;
    #endif    
    kernel.Flag = 0uL; /*clear all the core flags*/
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        kernel.ReleaseSchedCallback = NULL;
    #endif
    #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
        kernel.TaskEntries = (size_t)0;
    #endif
    kernel.CurrentRunningTask = NULL;
    qClock_SetTickProvider( TickProvider );
}
/*========================== Shared Private Method ===========================*/
qTask_t* qOS_Get_TaskRunning( void ){
    return kernel.CurrentRunningTask; /*get the handle of the current running task*/
}
/*============================================================================*/
void qOS_Set_IdleTask( qTaskFcn_t Callback ){
    kernel.IDLECallback = Callback;
}
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
/*============================================================================*/
void qOS_Scheduler_Release( void ){
    QKERNEL_COREFLAG_SET( kernel.Flag, QKERNEL_BIT_RELEASESCHED );
}
/*============================================================================*/
void qOS_Set_SchedulerReleaseCallback( qTaskFcn_t Callback ){
    kernel.ReleaseSchedCallback = Callback;
}
#endif /* #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 ) */
/*============================================================================*/
qBool_t qOS_Notification_Spread( void *eventdata, const qTask_NotifyMode_t mode ){
    qBool_t RetValue = qFalse;
    
    #if ( Q_NOTIFICATION_SPREADER == 1 )
        /*do not proceed if any previous operation is in progress*/
        if( NULL ==  kernel.NotificationSpreadRequest.mode ){ 
            if( ( qTask_NotifySimple == mode ) || ( qTask_NotifyQueued == mode ) ){
                kernel.NotificationSpreadRequest.mode = ( qTask_NotifySimple == mode )? &qTask_Notification_Send : &qTask_Notification_Queue;
                kernel.NotificationSpreadRequest.eventdata = eventdata;
                RetValue = qTrue;
            }
        }
    #else
        Q_UNUSED( eventdata );
        Q_UNUSED( mode );    
    #endif
    return RetValue;    
}
/*============================================================================*/
#if ( Q_PRIO_QUEUE_SIZE > 0 )  
static void qOS_PriorityQueue_CleanUp( const qTask_t * task ){
    qIndex_t i;
    for( i = 1u ; ( i < (qIndex_t)Q_PRIO_QUEUE_SIZE ) ; ++i ){ 
        if( kernel.QueueStack[ i ].Task == task ){
            qOS_PriorityQueue_ClearIndex( i );
        }
    }
}
/*============================================================================*/
static void qOS_PriorityQueue_ClearIndex( qIndex_t IndexToClear ){
    qIndex_t j;
    qBase_t QueueIndex;

    kernel.QueueStack[ IndexToClear ].Task = NULL; /*set the position in the queue as empty*/  
    QueueIndex = (qBase_t)kernel.QueueIndex; /*to avoid side effects*/
    for( j = IndexToClear ; (qBase_t)j < QueueIndex ; ++j ){ 
        kernel.QueueStack[ j ] = kernel.QueueStack[ j + (qIndex_t)1 ]; /*shift the remaining items of the queue*/
    }
    --kernel.QueueIndex;    /*decrease the index*/    
}
/*========================== Shared Private Method ===========================*/
qBool_t qOS_PriorityQueue_Insert( qTask_t * const Task, void *Data ){
    #if ( Q_PRIO_QUEUE_SIZE > 0 )  
        qBool_t RetValue = qFalse;
        qBase_t QueueMaxIndex, CurrentQueueIndex;

        QueueMaxIndex = Q_PRIO_QUEUE_SIZE - 1; /*to avoid side effects */
        CurrentQueueIndex = kernel.QueueIndex; /*to avoid side effects */
        if( ( NULL != Task )  && ( CurrentQueueIndex < QueueMaxIndex) ) {/*check if data can be queued*/
            qQueueStack_t tmp;

            tmp.QueueData = Data;
            tmp.Task = Task;
            /*cstat -CERT-INT32-C_a*/
            kernel.QueueStack[ ++kernel.QueueIndex ] = tmp; /*insert task and the corresponding eventdata to the queue*/ /*CERT-INT32-C_a checked programatically*/
            /*cstat +CERT-INT32-C_a*/
            RetValue = qTrue;
        }
        return RetValue;
    #else
        Q_UNUSED( Task );
        Q_UNUSED( Data );
        return qFalse;
    #endif   
}
/*========================== Shared Private Method ===========================*/
qBool_t qOS_PriorityQueue_IsTaskInside( const qTask_t * const Task ){
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        qBool_t RetValue = qFalse;
        qBase_t CurrentQueueIndex, i;

        CurrentQueueIndex = kernel.QueueIndex + 1;
        if( CurrentQueueIndex > 0 ){ /*check first if the queue has items inside*/
            qCritical_Enter();
            for( i = 0 ; i < CurrentQueueIndex; ++i ){ /*loop the queue slots to check if the Task is inside*/
                if( Task == kernel.QueueStack[ i ].Task ){
                    RetValue = qTrue;
                    break;
                }
            }
            qCritical_Exit();
        }
        return RetValue;
    #else
        Q_UNUSED( Task );
        return qFalse;
    #endif   
}
/*============================================================================*/
static qTask_t* qOS_PriorityQueue_Get( void ){
    qTask_t *xTask = NULL;

    if( kernel.QueueIndex >= 0 ){ /*queue has elements*/
        qPriority_t MaxPriorityValue, iPriorityValue;
        qIndex_t IndexTaskToExtract = 0u;
        qIndex_t i;

        qCritical_Enter();
        MaxPriorityValue = kernel.QueueStack[ 0 ].Task->qPrivate.Priority;
        /*walk through the queue to find the task with the highest priority*/
        /*loop until all items are checked or if the tail is reached*/
        for( i = 1u ; ( i < (qIndex_t)Q_PRIO_QUEUE_SIZE ) && ( NULL != kernel.QueueStack[i].Task ); ++i ){  
            iPriorityValue = kernel.QueueStack[i].Task->qPrivate.Priority;
            if( iPriorityValue > MaxPriorityValue ){ /*check if the queued task has the max priority value*/
                MaxPriorityValue = iPriorityValue; /*Reassign the max value*/
                IndexTaskToExtract = i;  /*save the index*/
            }
        }   
        kernel.QueueData = kernel.QueueStack[ IndexTaskToExtract ].QueueData; /*get the data from the queue*/
        xTask = kernel.QueueStack[ IndexTaskToExtract ].Task; /*assign the task to the output*/
        qOS_PriorityQueue_ClearIndex( IndexTaskToExtract );
        qCritical_Exit();
    }
    return xTask;
}
/*========================== Shared Private Method ===========================*/
size_t qOS_PriorityQueue_GetCount( void ){
    size_t RetValue = (size_t)0;

    if( kernel.QueueIndex >= 0 ){ 
        RetValue = (size_t)kernel.QueueIndex + (size_t)1;
    }
    return RetValue;
}
/*============================================================================*/
#endif /* #if ( Q_PRIORITY_QUEUE == 1 ) */
/*============================================================================*/
qBool_t qOS_Add_Task( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg ){
    qBool_t RetValue = qFalse;

    if( ( NULL != Task ) ) {
        Task->qPrivate.Callback = CallbackFcn;
        (void)qSTimer_Set( &Task->qPrivate.timer, Time );
        Task->qPrivate.TaskData = arg;
        Task->qPrivate.Priority = ( Priority > ((qPriority_t)Q_PRIORITY_LEVELS - (qPriority_t)1u) )? 
                                  ( (qPriority_t)Q_PRIORITY_LEVELS - (qPriority_t)1u ) : 
                                  Priority;
        Task->qPrivate.Iterations = ( qPeriodic == nExecutions )? qPeriodic : -nExecutions;    
        Task->qPrivate.Notification = 0uL;
        Task->qPrivate.Trigger = qTriggerNULL;
        qOS_Set_TaskFlags( Task,
                           QTASK_BIT_INIT | QTASK_BIT_QUEUE_RECEIVER | 
                           QTASK_BIT_QUEUE_FULL | QTASK_BIT_QUEUE_COUNT | 
                           QTASK_BIT_QUEUE_EMPTY | QTASK_BIT_REMOVE_REQUEST, 
                           qFalse);
        qOS_Set_TaskFlags( Task, QTASK_BIT_SHUTDOWN | QTASK_BIT_ENABLED, qTrue );  /*task will be awaken and enabled*/ 
        qTask_Set_State( Task, InitialState );

        #if ( Q_TASK_COUNT_CYCLES == 1 )
            Task->qPrivate.Cycles = 0uL;
        #endif
        #if ( Q_QUEUES == 1 )
            Task->qPrivate.Queue = NULL;
        #endif
        #if ( Q_FSM == 1 )
            Task->qPrivate.StateMachine = NULL;
        #endif
        #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1 )
            Task->qPrivate.Entry = kernel.TaskEntries++;
        #endif
        RetValue = qList_Insert( WaitingList, Task, QLIST_ATBACK ); 
    }
    return RetValue;  
}
/*============================================================================*/
qBool_t qOS_Add_EventTask( qTask_t * const Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg ){
    return qOS_Add_Task( Task, CallbackFcn, Priority, qTimeImmediate, qSingleShot, qDisabled, arg );
}
#if ( Q_FSM == 1)
/*============================================================================*/
qBool_t qOS_Add_StateMachineTask( qTask_t * const Task, qSM_t *m, qPriority_t Priority, qTime_t Time, qState_t InitialTaskState, void *arg ){
    qBool_t RetValue = qFalse;

    if( ( NULL != m ) ){
        if ( qTrue == qOS_Add_Task( Task, qOS_DummyTask_Callback, Priority, Time, qPeriodic, InitialTaskState, arg ) ){
            Task->qPrivate.StateMachine = m;
            RetValue = qTrue;
            #if ( Q_QUEUES == 1 )
                if( NULL != m->qPrivate.queue ){
                    RetValue = qTask_Attach_Queue( Task, m->qPrivate.queue, qQueueMode_Count, 1u ); /*to perform the queue connection */
                }
            #endif
        }
    }
    return RetValue;
}
#endif /* #if ( Q_FSM == 1) */
/*============================================================================*/
#if ( Q_ATCLI == 1 )
qBool_t qOS_Add_ATCLITask( qTask_t * const Task, qATCLI_t *cli, qPriority_t Priority ){    
    qBool_t RetValue = qFalse;

    if( NULL != cli ){
        cli->qPrivate.xPublic.UserData = Task;
        cli->qPrivate.xNotifyFcn = &qOS_ATCLI_NotifyFcn;
        RetValue =  qOS_Add_Task( Task, qOS_ATCLI_TaskCallback, Priority, qTimeImmediate, qSingleShot, qDisabled, cli );
    }
    return RetValue;
}
/*============================================================================*/
static void qOS_ATCLI_TaskCallback( qEvent_t  e ){ /*wrapper for the task callback */
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    (void)qATCLI_Run( (qATCLI_t*)e->TaskData ); /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
}
/*============================================================================*/
static void qOS_ATCLI_NotifyFcn( qATCLI_t * const cli ){
    qTask_t *Task;
    /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
    Task = (qTask_t *)cli->qPrivate.xPublic.UserData; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
    /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
    (void)qTask_Notification_Send( Task, NULL ); /*simple notifications preferred because queued notification can be disabled en <qconfig.h> */
}
#endif /* #if ( Q_ATCLI == 1) */
/*============================================================================*/
qBool_t qOS_Remove_Task( qTask_t * const Task ){
    qBool_t RetValue = qFalse;

    if( NULL != Task ){
        qOS_Set_TaskFlags( Task, QTASK_BIT_REMOVE_REQUEST, qTrue );
        RetValue = qTrue;
    }
    return RetValue;
}
#if ( Q_QUEUES == 1)
/*============================================================================*/
static qTrigger_t qOS_AttachedQueue_CheckEvents( const qTask_t * const Task ){
    qTrigger_t RetValue = qTriggerNULL;

    if( NULL != Task->qPrivate.Queue){
        qBool_t FullFlag, CountFlag, ReceiverFlag, EmptyFlag;
        size_t CurrentQueueCount;
        
        FullFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_FULL );
        CountFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_COUNT );
        ReceiverFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_RECEIVER );
        EmptyFlag = qOS_Get_TaskFlag( Task, QTASK_BIT_QUEUE_EMPTY );
        
        CurrentQueueCount = qQueue_Count( Task->qPrivate.Queue ); /*to avoid side effects*/
        /*check the queue events in the corresponding precedence order*/
        /*cstat -MISRAC2012-Rule-13.5 */ 
        if( FullFlag && qQueue_IsFull( Task->qPrivate.Queue ) ){ /*qQueue_IsFull is known to have no side effects*/        
            RetValue =  byQueueFull;
        }
        else if( ( CountFlag ) && ( CurrentQueueCount >= Task->qPrivate.QueueCount ) ){
            RetValue =  byQueueCount;
        }
        else if( ReceiverFlag && ( CurrentQueueCount > 0u ) ){    
            RetValue = byQueueReceiver; 
        }
        else if( EmptyFlag && qQueue_IsEmpty( Task->qPrivate.Queue ) ){ /*qQueue_IsEmpty is known to have no side effects*/
            RetValue =  byQueueEmpty;
        }
        else{
            /*this case does not need to be handled*/
        }
        /*cstat +MISRAC2012-Rule-13.5 */ 
    }
    return RetValue;
}
#endif
/*============================================================================*/
#if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
static void qOS_TriggerReleaseSchedEvent( void ){
    QKERNEL_COREFLAG_CLEAR( kernel.Flag, QKERNEL_BIT_INIT ); 
    QKERNEL_COREFLAG_CLEAR( kernel.Flag, QKERNEL_BIT_RELEASESCHED );  
    kernel.EventInfo.FirstCall = ( qFalse == QKERNEL_COREFLAG_GET( kernel.Flag, QKERNEL_BIT_FCALLRELEASED ) )? qTrue : qFalse;    
    kernel.EventInfo.Trigger = bySchedulingRelease;
    kernel.EventInfo.TaskData = NULL;
    if( NULL != kernel.ReleaseSchedCallback ){
        qTaskFcn_t Callback = kernel.ReleaseSchedCallback;
        Callback( &kernel.EventInfo ); /*some low-end compilers cant deal with function-pointers inside structs*/
    }    
    QKERNEL_COREFLAG_SET( kernel.Flag, QKERNEL_BIT_FCALLIDLE ); /*MISRAC2012-Rule-11.3 allowed*/
}
#endif
/*============================================================================*/
void qOS_Run( void ){
    do{           
        if( qList_ForEach( WaitingList, qOS_CheckIfReady, NULL, QLIST_FORWARD, NULL ) ){ /*check for ready tasks in the waiting-list*/
            qIndex_t xPriorityListIndex = (qIndex_t)Q_PRIORITY_LEVELS - (qIndex_t)1;
            qList_t *xList;
            do{ /*loop every ready-list in descending priority order*/
                xList = &ReadyList[ xPriorityListIndex ]; /*get the target ready-list*/
                if( xList->size > (size_t)0 ){ /*check for a non-empty target list */
                    (void)qList_ForEach( xList, qOS_Dispatch, xList, QLIST_FORWARD, NULL ); /*dispatch every task in the current ready-list*/
                }
            }while( (qIndex_t)0 != xPriorityListIndex-- ); /*move to the next ready-list*/
        }
        else{ /*no task in the scheme is ready*/
            if( NULL != kernel.IDLECallback ){ /*check if the idle-task is available*/
                _qList_ForEachHandle_t qOS_BuiltIn_IdleTask = { NULL, NULL, qList_WalkThrough };
                (void)qOS_Dispatch( &qOS_BuiltIn_IdleTask ); /*special call to dispatch idle-task already hardcoded in the kernel*/
            }
        }
        if( SuspendedList->size > (size_t)0 ){  /*check for a non-empty suspended-list*/
            (void)qList_Move( WaitingList, SuspendedList, QLIST_ATBACK ); /*move the remaining suspended tasks to the waiting-list*/
            #if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
                (void)qList_Sort( WaitingList, qOS_TaskEntryOrderPreserver ); /*preseve the entry order by sorting the new waiting-list layout*/
            #endif
        }
    }
    #if ( Q_ALLOW_SCHEDULER_RELEASE == 1 )
        while( qFalse == QKERNEL_COREFLAG_GET( kernel.Flag, QKERNEL_BIT_RELEASESCHED ) ); /*scheduling end-point*/ 
        qOS_TriggerReleaseSchedEvent(); /*check for a scheduling-release request*/
    #else
        while( qTrue == qTrue);
    #endif
}
/*============================================================================*/
#if ( Q_PRESERVE_TASK_ENTRY_ORDER == 1)
static qBool_t qOS_TaskEntryOrderPreserver( qList_CompareHandle_t h ){
    qTask_t *t1, *t2;

    t1 = (qTask_t*)h->n1;
    t2 = (qTask_t*)h->n1;
    return (qBool_t)( t1->qPrivate.Entry > t2->qPrivate.Entry );
}
#endif
/*============================================================================*/
static qBool_t qOS_CheckIfReady( qList_ForEachHandle_t h ){
    qTask_t *xTask;
    #if ( Q_QUEUES == 1 )
        qTrigger_t trg;
    #endif
    static qBool_t xReady = qFalse;
    qBool_t RetValue = qFalse;

    if( qList_WalkThrough == h->stage ){
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        xTask = (qTask_t*)h->node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        #if ( Q_NOTIFICATION_SPREADER == 1 )
            if( NULL != kernel.NotificationSpreadRequest.mode ){
                kernel.NotificationSpreadRequest.mode( xTask, kernel.NotificationSpreadRequest.eventdata );
                RetValue = qTrue;
            }
        #endif
        if( qOS_Get_TaskFlag( xTask, QTASK_BIT_SHUTDOWN) ){
            #if ( Q_PRIO_QUEUE_SIZE > 0 )  
            if( byNotificationQueued == xTask->qPrivate.Trigger ){
                xReady = qTrue;
            }
            else
            #endif 
            if( qOS_TaskDeadLineReached( xTask ) ){ /*nested check for timed task, check the first requirement(the task must be enabled)*/
                (void)qSTimer_Reload( &xTask->qPrivate.timer );
                xTask->qPrivate.Trigger = byTimeElapsed;      
                xReady = qTrue;            
            }
            #if ( Q_QUEUES == 1 )  
            else if( qTriggerNULL != ( trg = qOS_AttachedQueue_CheckEvents( xTask ) ) ){ /*If the deadline is not met, check if there is a queue-event available*/
                xTask->qPrivate.Trigger = trg;      
                xReady = qTrue;
            }
            #endif
            else if( xTask->qPrivate.Notification > (qNotifier_t)0 ){   /* task with a pending notification event?*/
                xTask->qPrivate.Trigger = byNotificationSimple;  
                xReady = qTrue;            
            }
            #if ( Q_TASK_EVENT_FLAGS == 1 )
            else if( 0uL != (QTASK_EVENTFLAGS_RMASK & xTask->qPrivate.Flags ) ){ /*task with enabled eventflags?*/
                xTask->qPrivate.Trigger = byEventFlags;          
                xReady = qTrue;        
            }
            #endif
            else{
                xTask->qPrivate.Trigger = qTriggerNULL;
                /*the task has no available events, put it into a suspended state*/        
            }
        }
        (void)qList_Remove( WaitingList, NULL, QLIST_ATFRONT ); 
        if( qOS_Get_TaskFlag( xTask, QTASK_BIT_REMOVE_REQUEST) ){ /*check if the task get a removal request*/
            #if ( Q_PRIO_QUEUE_SIZE > 0 )  
                qCritical_Enter(); 
                qOS_PriorityQueue_CleanUp( xTask ); /*clean any entry of this task from the priority queue */
                qCritical_Exit();
            #endif
            qOS_Set_TaskFlags( xTask, QTASK_BIT_REMOVE_REQUEST, qFalse );  /*clear the removal request*/
        }
        else{
            qList_t *xList;
            xList = ( qTriggerNULL != xTask->qPrivate.Trigger )? &ReadyList[ xTask->qPrivate.Priority ] : SuspendedList;
            (void)qList_Insert( xList, xTask, QLIST_ATBACK );
        }
    }
    else if( qList_WalkInit == h->stage ){
        xReady = qFalse;
        #if ( Q_PRIO_QUEUE_SIZE > 0 )  
            xTask = qOS_PriorityQueue_Get(); /*try to extract a task from the front of the priority queue*/
            if( NULL != xTask ){  /*if we got a task from the priority queue,*/
                xTask->qPrivate.Trigger = byNotificationQueued; 
                qOS_Set_TaskFlags( xTask, QTASK_BIT_SHUTDOWN, qTrue ); /*wake-up the task!!*/
            }     
        #endif          
    }
    else if( qList_WalkEnd == h->stage ){ 
        #if ( Q_NOTIFICATION_SPREADER == 1 )
            /*spread operation done, clean-up*/
            kernel.NotificationSpreadRequest.mode = NULL;
            kernel.NotificationSpreadRequest.eventdata = NULL;
        #endif
        RetValue = xReady; 
    }
    else{
        /*this should never enter here*/
    }
    return RetValue;
}
/*============================================================================*/
static qTrigger_t qOS_Dispatch_xTask_FillEventInfo( qTask_t *Task ){
    qTrigger_t Event;
    qIteration_t TaskIteration;
    
    Event = Task->qPrivate.Trigger;
    switch( Event ){ /*take the necessary actions before dispatching, depending on the event that triggered the task*/
        case byTimeElapsed:
            /*handle the iteration value and the FirstIteration flag*/
            TaskIteration = Task->qPrivate.Iterations;
            kernel.EventInfo.FirstIteration = ( ( qPeriodic != TaskIteration ) && ( TaskIteration < 0 ) )? qTrue : qFalse;
            Task->qPrivate.Iterations = ( kernel.EventInfo.FirstIteration )? -Task->qPrivate.Iterations : Task->qPrivate.Iterations;
            if( qPeriodic != Task->qPrivate.Iterations ){
                --Task->qPrivate.Iterations; /*Decrease the iteration value*/
            }
            kernel.EventInfo.LastIteration = ( 0 == Task->qPrivate.Iterations )? qTrue : qFalse; 
            if( kernel.EventInfo.LastIteration ) {
                qOS_Set_TaskFlags( Task, QTASK_BIT_ENABLED, qFalse ); /*When the iteration value is reached, the task will be disabled*/ 
            }           
            kernel.EventInfo.StartDelay = qClock_GetTick() - Task->qPrivate.timer.Start;
            break;
        case byNotificationSimple:
            kernel.EventInfo.EventData = Task->qPrivate.AsyncData; /*Transfer async-data to the eventinfo structure*/
            --Task->qPrivate.Notification; /* = qFalse */ /*Clear the async flag*/            
            break;
        #if ( Q_QUEUES == 1 )    
            case byQueueReceiver:
                kernel.EventInfo.EventData = qQueue_Peek( Task->qPrivate.Queue ); /*the EventData will point to the queue front-data*/
                break;
            case byQueueFull: case byQueueCount: case byQueueEmpty: 
                kernel.EventInfo.EventData = (void*)Task->qPrivate.Queue;  /*the EventData will point to the the linked queue*/
                break;
        #endif
        #if ( Q_PRIO_QUEUE_SIZE > 0 )  
            case byNotificationQueued:
                kernel.EventInfo.EventData = kernel.QueueData; /*get the extracted data from queue*/
                kernel.QueueData = NULL;
                break;
        #endif
        #if ( Q_TASK_EVENT_FLAGS == 1 )
            case byEventFlags:
                break;
        #endif        
            default: break;
    }     
    /*Fill the event info structure: Trigger, FirstCall and TaskData */       
    kernel.EventInfo.Trigger = Task->qPrivate.Trigger;
    kernel.EventInfo.FirstCall = ( qFalse == qOS_Get_TaskFlag( Task, QTASK_BIT_INIT) )? qTrue : qFalse;
    kernel.EventInfo.TaskData = Task->qPrivate.TaskData;
    kernel.CurrentRunningTask = Task; /*needed for qTask_Self()*/
    return Event;
}
/*============================================================================*/
static qBool_t qOS_Dispatch( qList_ForEachHandle_t h ){    
    /*cstat -MISRAC2012-Rule-11.5 -MISRAC2012-Rule-14.3_a -MISRAC2012-Rule-14.3_b -CERT-EXP36-C_b*/
    if( qList_WalkThrough == h->stage ){ /*#!OK: false-positive can be reported here*/
        qList_t *xList = (qList_t*)h->arg; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        qTaskFcn_t TaskActivities;
        qTrigger_t Event = byNoReadyTasks;

        if( NULL != xList){ /*#!OK* false-positive can be reported here*/     
            qTask_t *Task = (qTask_t*)h->node; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
            /*cstat +MISRAC2012-Rule-11.5 +MISRAC2012-Rule-14.3_a +MISRAC2012-Rule-14.3_b +CERT-EXP36-C_b*/   
            Event = qOS_Dispatch_xTask_FillEventInfo( Task ); /*#!OK : false-positive can be reported here*/
            TaskActivities = Task->qPrivate.Callback; /*#!OK: false-positive can be reported here*/
            #if ( Q_FSM == 1)
                if ( ( NULL != Task->qPrivate.StateMachine ) && ( qOS_DummyTask_Callback == Task->qPrivate.Callback ) ){
                    Task->qPrivate.StateMachine->qPrivate.handler.Data = &kernel.EventInfo;
                    (void)qStateMachine_Run( Task->qPrivate.StateMachine, QSM_SIGNAL_NONE );  /*If the task has a FSM attached, just run it*/  
                }
                else if ( NULL != TaskActivities ) {
                    TaskActivities( &kernel.EventInfo ); /*else, just launch the callback function*/ 
                }       
                else{
                    /*this case does not need to be handled*/
                }
            #else
                if ( NULL != TaskActivities ) {
                    TaskActivities( &kernel.EventInfo ); /*else, just launch the callback function*/ 
                }     
            #endif
            kernel.CurrentRunningTask = NULL;
            (void)qList_Remove( xList, NULL, QLIST_ATFRONT ); /*remove the task from the ready-list*/
            (void)qList_Insert( WaitingList, Task, QLIST_ATBACK );  /*and insert the task back to the waiting-list*/
            #if ( Q_QUEUES == 1) 
                if( byQueueReceiver == Event ){
                    (void)qQueue_RemoveFront( Task->qPrivate.Queue );  /*remove the data from the Queue, if the event was byQueueDequeue*/
                } 
            #endif
            
            qOS_Set_TaskFlags( Task, QTASK_BIT_INIT, qTrue ); /*set the init flag*/
            kernel.EventInfo.FirstIteration = qFalse;
            kernel.EventInfo.LastIteration =  qFalse; 
            kernel.EventInfo.StartDelay = (qClock_t)0uL;
            kernel.EventInfo.EventData = NULL; /*clear the eventdata*/
            #if ( Q_TASK_COUNT_CYCLES == 1 )
                ++Task->qPrivate.Cycles; /*increase the task-cycles value*/
            #endif
            Task->qPrivate.Trigger = qTriggerNULL;
        }
        else{ /*run the idle*/
            kernel.EventInfo.FirstCall = ( qFalse == QKERNEL_COREFLAG_GET( kernel.Flag, QKERNEL_BIT_FCALLIDLE ) )? qTrue : qFalse;
            kernel.EventInfo.TaskData = NULL;
            kernel.EventInfo.Trigger = Event;
            TaskActivities = kernel.IDLECallback; /*some compilers can´t deal with function pointers inside structs*/
            TaskActivities( &kernel.EventInfo ); /*run the idle callback*/ 
            QKERNEL_COREFLAG_SET( kernel.Flag, QKERNEL_BIT_FCALLIDLE );
        }
    }
    return qFalse;
}
/*============================================================================*/
static qBool_t qOS_TaskDeadLineReached( qTask_t * const Task ){
    qBool_t RetValue = qFalse;
    
    if( qOS_Get_TaskFlag( Task, QTASK_BIT_ENABLED ) ){ /*nested-check for timed task, check the first requirement(the task must be enabled)*/
        qIteration_t TaskIterations = Task->qPrivate.Iterations; /*avoid side efects in the next check*/
        if( ( _qAbs( TaskIterations ) > 0 ) || ( qPeriodic == TaskIterations ) ){ /*then task should be periodic or must have available iters*/
            qClock_t TaskInterval = Task->qPrivate.timer.TV;
            qBool_t DeadLineReached;

            DeadLineReached = qSTimer_Expired( &Task->qPrivate.timer );
            if( ( 0uL == TaskInterval ) || DeadLineReached ){ /*finally, check the time deadline*/
                RetValue = qTrue;                
            }
        }
    }
    return RetValue;
}
/*========================== Shared Private Method ===========================*/
qTask_GlobalState_t qOS_GetTaskGlobalState( const qTask_t * const Task ){
    qTask_GlobalState_t RetValue = qUndefinedGlobalState;
   
    if( NULL != Task ){
        /*cstat -MISRAC2012-Rule-11.5 -CERT-EXP36-C_b*/
        qList_t *xList = (qList_t *)Task->qPrivate.container; /* MISRAC2012-Rule-11.5,CERT-EXP36-C_b deviation allowed */
        /*cstat +MISRAC2012-Rule-11.5 +CERT-EXP36-C_b*/
        if( kernel.CurrentRunningTask == Task ){
            RetValue = qRunning;
        }
        else if( WaitingList == xList ){
            RetValue = qWaiting;
        }
        else if( SuspendedList == xList ){
            RetValue = qSuspended;
        }
        else if( NULL == xList ){
            /*undefined*/  
        }
        else{
            RetValue = qReady;      /*by discard, it must be ready*/
        }
    }
    return RetValue;
}
/*========================== Shared Private Method ===========================*/
qBool_t qOS_Get_TaskFlag( const qTask_t * const Task, qUINT32_t flag ){
    qUINT32_t xBit;

    xBit = Task->qPrivate.Flags & flag;
    return (( 0uL != xBit )? qTrue : qFalse );
}
/*========================== Shared Private Method ===========================*/
void qOS_Set_TaskFlags( qTask_t * const Task, qUINT32_t flags, qBool_t value ){
    if( qTrue == value ){
        Task->qPrivate.Flags |= flags; /*Set bits*/
    }
    else{
        Task->qPrivate.Flags &= ~flags; /*Clear bits*/
    }
}
/*============================================================================*/
