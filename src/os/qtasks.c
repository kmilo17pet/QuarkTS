#include "qkernel.h"

/*============================================================================*/
/*void qTaskSendNotification(qTask_t * const Task, void* eventdata)

Sends a simple notification generating an asynchronous event. 
This method marks the task as 'qReady' for execution, therefore, the planner will launch the task 
immediately according to the scheduling rules (even if task is disabled) and 
setting the Trigger flag to "byNotificationSimple". Specific user-data can be passed 
through, and will be available in the respective callback inside the <EventData> 
field.

Parameters:

    - Task : Pointer to the task node.
    - eventdata : Specific event user-data.

Return value:

    qTrue on success. Otherwise qFalse.
*/ 
qBool_t qTaskSendNotification( qTask_t * const Task, void* eventdata){
    qBool_t RetValue = qFalse;
    if( NULL != Task ){
        if( Task->qPrivate.Notification < QMAX_NOTIFICATION_VALUE ){
            Task->qPrivate.Notification++;
            Task->qPrivate.AsyncData = eventdata;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qTaskQueueNotification(const qTask_t * const Task, void* eventdata)

Insert a notification in the FIFO priority queue. The scheduler get this notification
as asynchronous event, therefor, the task will be ready for execution according to 
the queue order (determined by priority), even if task is in a disabled or sleep 
operational state. When extracted, the scheduler will set Trigger flag to  
"byNotificationQueued". Specific user-data can be passed through, and will be 
available inside the EventData field, only in corresponding launch.
If the task is in a qSleep operation state, the scheduler will change the operational 
state to qAwaken setting the SHUTDOWN bit.

Parameters:

    - Task : A pointer to the task node.
    - eventdata - Specific event user-data.

Return value:

    Returns qTrue if the event has been inserted in the queue, or qFalse if an error 
    occurred (The queue exceeds the size).
*/
qBool_t qTaskQueueNotification( qTask_t * const Task, void* eventdata ){
    #if ( Q_PRIO_QUEUE_SIZE > 0 )      
        return _qScheduler_PriorityQueue_Insert( Task, eventdata );     
    #else
        return qFalse;
    #endif
}
/*============================================================================*/
/*
qState_t qTaskGetState( const qTask_t * const Task)

Retrieve the task operational state.

Parameters:

    Pointer to the task node.

Return value:

    qEnabled or qDisabled if the task is qAwaken. qAsleep if the task is 
    in a Sleep operational state.
*/    
qState_t qTaskGetState( const qTask_t * const Task){
    qState_t RetValue = qAsleep;
    if( NULL != Task ){
        RetValue = (qState_t)__qPrivate_TaskGetFlag( Task, __QTASK_BIT_SHUTDOWN ); 
        if( (qState_t)qTrue == RetValue ){ /*Task is awaken*/
            RetValue = (qState_t)__qPrivate_TaskGetFlag( Task, __QTASK_BIT_ENABLED );
        }
    }
    return RetValue;
}
/*============================================================================*/
#if ( Q_TASK_COUNT_CYCLES == 1 )
/*qCycles_t qTaskGetCycles(const qTask_t *Task)

Retrieve the number of task activations.

Parameters:

    - Task : Pointer to the task node.

Return value:

    A unsigned long value containing the number of task activations.
*/
qCycles_t qTaskGetCycles( const qTask_t * const Task ){
    qCycles_t RetValue = 0uL;
    if( NULL != Task ){
        RetValue = Task->qPrivate.Cycles;
    }
    return RetValue;
}
#endif
/*============================================================================*/
/*void qTaskSetTime(qTask_t * const Task, const qTime_t Value)

Set/Change the Task execution interval

Parameters:

    - Task : A pointer to the task node.
    - Value : Execution interval defined in seconds (floating-point format). 
              For immediate execution (tValue = qTimeImmediate).
*/
void qTaskSetTime( qTask_t * const Task, const qTime_t Value ){
    if( NULL != Task ){
        (void)qSTimerSet( &Task->qPrivate.timer , Value );
    }
}
/*============================================================================*/
/*void qTaskSetIterations(qTask_t * const Task, qIteration_t Value)

Set/Change the number of task iterations

Parameters:

    - Task : A pointer to the task node.
    - Value : Number of task executions (Integer value). For indefinite 
              execution (iValue = qPeriodic or qIndefinite). Tasks do not remember
              the number of iteration set initially. After the iterations are 
              done, internal iteration counter is 0. If you need to perform
              another set of iterations, you need to set the number of 
              iterations again and resume.
*/
void qTaskSetIterations( qTask_t * const Task, const qIteration_t Value ){
    if( NULL != Task ){
        Task->qPrivate.Iterations = ( qPeriodic==Value )? qPeriodic : -Value;
    }      
}
/*============================================================================*/
/*void qTaskSetPriority(qTask_t * const Task, const qPriority_t Value)

Set/Change the task priority value

Parameters:

    - Task : A pointer to the task node.
    - Value : Priority Value. [0(min) - Q_PRIORITY_LEVELS(max)]
*/
void qTaskSetPriority( qTask_t * const Task, const qPriority_t Value ){
    if( NULL != Task ){
        Task->qPrivate.Priority = Value; 
    }
}
/*============================================================================*/
/*void qTaskSetCallback(qTask_t * const Task, const qTaskFcn_t Callback)

Set/Change the task callback function.
Note: This function can be used to detach a state-machine from a task

Parameters:

    - Task : A pointer to the task node.
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
void qTaskSetCallback( qTask_t * const Task, const qTaskFcn_t CallbackFcn ){
    if( NULL != Task ){ 
        Task->qPrivate.Callback = CallbackFcn;
        #if ( Q_FSM == 1)
            Task->qPrivate.StateMachine = NULL;    
        #endif  
    }    
}
/*============================================================================*/
/*void qTaskSetState(qTask_t * const Task, const qState_t State)

Set the task state (Enabled or Disabled)

Parameters:

    - Task : A pointer to the task node.
    - State : Use one of the following values:
            qEnabled : Task will be able to catch all the events. (ENABLE Bit = 1 )
            qDisabled : Time events will be discarded. The task can catch asynchronous events.
                        (ENABLE Bit = 0)
            qAsleep : Put the task into a qSLEEP operability state. The task can't be triggered
                      by the lower precedence events. ( SHUTDOWN Bit = 0)
            qAwake : Put the task into the previous state before it was put in the sleep state.
                    ( SHUTDOWN Bit = 1 )
*/
void qTaskSetState(qTask_t * const Task, const qState_t State){
    if( NULL != Task ){
        switch( State ){
            case qDisabled: case qEnabled:
                if( State != (qState_t)__qPrivate_TaskGetFlag( Task, __QTASK_BIT_ENABLED ) ){ 
                    __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_ENABLED, (qBool_t)State );
                    (void)qSTimerReload( &Task->qPrivate.timer );
                }
                break;
            case qAsleep:
                __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_SHUTDOWN, qFalse );
                break;
            case qAwake:
                __qPrivate_TaskModifyFlags( Task, __QTASK_BIT_SHUTDOWN, qTrue );
                break;
            default:
                break;
        }
    }
}
/*============================================================================*/
/*void qTaskSetData(qTask_t * const Task, void* UserData)

Set the task data

Parameters:

    - Task : A pointer to the task node.

Return value:

    A void pointer to the task data.
*/
void qTaskSetData( qTask_t * const Task, void* arg ){
    if( NULL != Task ){
        Task->qPrivate.TaskData = arg;
    }
}
/*============================================================================*/
/*void qTaskClearTimeElapsed(qTask_t *Task)

Clear the elapsed time of the task. Restart the internal task tick;

Parameters:

    - Task : A pointer to the task node.
*/
void qTaskClearTimeElapsed( qTask_t * const Task ){
    if( NULL != Task ){
        (void)qSTimerReload( &Task->qPrivate.timer );
    }    
}
#if ( Q_QUEUES == 1)
/*============================================================================*/
/*qBool_t qTaskAttachQueue(qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const qUINT16_t arg)

Attach a Queue to the Task. 

Parameters:

    - Task : A pointer to the task node.
    - Queue : A pointer to a Queue  object
    - Mode: Attach mode. This implies the event that will trigger the task according
            to one of the following modes:
                        > qQUEUE_DEQUEUE: The task will be triggered if there are elements 
                          in the Queue. Data will be extracted automatically in 
                          every trigger and will be available in the <EventData> field 
                          of the qEvent_t structure.
     
                        > qQUEUE_FULL: the task will be triggered if the Queue
                          is full. A pointer to the queue will be available in the
                          <EventData> field of the qEvent_t structure.

                        > qQUEUE_COUNT: the task will be triggered if the count of 
                          elements in the queue reach the specified value. 
                          A pointer to the queue will be available in the
                          <EventData> field of the qEvent_t structure.

                        > qQUEUE_EMPTY: the task will be triggered if the queue
                          is empty. A pointer to the queue will be available in the
                          <EventData> field of the qEvent_t structure.
    - arg: This argument defines if the queue will be attached (qATTACH) or 
           detached (qDETACH) from the task.
           If the qQUEUE_COUNT mode is specified, this value will be used to check
           the element count of the queue. A zero value will act as a qDETACH action. 

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qTaskAttachQueue( qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const qUINT16_t arg ){
    qBool_t RetValue = qFalse;
    if( ( NULL != Queue ) && ( NULL != Task ) ){
        if( NULL != Queue->pHead ) {
            __qPrivate_TaskModifyFlags( Task, Mode & __QTASK_QUEUEFLAGS_MASK, (( arg != 0u )? qATTACH :qDETACH) );
            if( Mode == qQUEUE_COUNT ){
                Task->qPrivate.QueueCount = arg; /*if mode is qQUEUE_COUNT, use their arg value as count*/
            }
            Task->qPrivate.Queue = ( arg > 0u )? Queue : NULL; /*reject, no valid arg input*/
            RetValue = qTrue;
        }
    }
    return RetValue;
}
#endif /* #if ( Q_QUEUES == 1) */
#if ( Q_FSM == 1)
/*============================================================================*/
/*qBool_t qTaskAttachStateMachine( qTask_t * const Task, qSM_t * const StateMachine )

Attach a Finite State Machine(FSM) to the Task. 

Note: Task and state-machine should be previously initialized before the attach procedure.
Note: To perform a state-machine detach, use the qTaskSetCallback API. 

Parameters:

    - Task : A pointer to the task node.
    - StateMachine : A pointer to the FSM object.

Return value:

    Returns qTrue on success, otherwise, returns qFalse.

*/
qBool_t qTaskAttachStateMachine( qTask_t * const Task, qSM_t * const StateMachine ){
    qBool_t RetValue = qFalse;
    if( ( NULL != Task ) && ( NULL != StateMachine ) ){
        Task->qPrivate.Callback = __qFSMCallbackMode;
        Task->qPrivate.StateMachine = StateMachine;
        RetValue = qTrue;
    }    
    return RetValue;
}
#endif /* #if ( Q_FSM == 1) */
/*============================================================================*/
/*void qTaskModifyEventFlags( qTask_t * const Task, qTaskFlag_t flags, qBool_t action )

Modify the EventFlags of the task. 
Note: Any EventFlag set will cause a task activation

Parameters:

    - Task : A pointer to the task node.
    - flags : The flags to modify. Can be combined with a bitwise ‘OR’ (‘|’).
              QEVENTFLAG_01 | QEVENTFLAG_02 | QEVENTFLAG_03 | ... | QEVENTFLAG_20      
    - action : QEVENTFLAG_SET or QEVENTFLAG_CLEAR 

*/
void qTaskModifyEventFlags( qTask_t * const Task, qTaskFlag_t flags, qBool_t action ){
    qTaskFlag_t FlagsToSet;
    if( NULL != Task ){
        FlagsToSet = flags & QTASK_EVENTFLAGS_RMASK;
        __qPrivate_TaskModifyFlags( Task, FlagsToSet, action );
    }
}
/*============================================================================*/
/*qTaskFlag_t qTaskReadEventFlags( const qTask_t * const Task )

Returns the current value of the task's EventFlags.

Parameters:

    - Task : A pointer to the task node.

Return value:

    The EventFlag value of the task.

*/
qTaskFlag_t qTaskReadEventFlags( const qTask_t * const Task ){
    qTaskFlag_t RetValue = 0u;
    if( NULL != Task ){
        RetValue = Task->qPrivate.Flags & QTASK_EVENTFLAGS_RMASK;
    }    
    return RetValue;
}
/*============================================================================*/
/*qBool_t qTaskCheckEventFlags( qTask_t * const Task, qTaskFlag_t FlagsToCheck, qBool_t ClearOnExit, qBool_t CheckForAll )

Check for flags set to qTrue inside the task Event Flags.

Parameters:

    - Task : A pointer to the task node.
    - FlagsToCheck : A bitwise value that indicates the flags to test inside the EventFlags.
                    Can be combined with a bitwise ‘OR’ (‘|’).
                    QBITFLAG_01 | QBITFLAG_02 | QBITFLAG_03 | ... | QBITFLAG_20     
    - ClearOnExit : If is set to <qTrue> then any flags set in the value passed as the
                   <FlagsToCheck> parameter will be cleared in the event group before
                   this function returns only when the condition is meet.
    - CheckForAll : Used to create either a logical AND test (where all flags must be set)
                    or a logical OR test (where one or more flags must be set) as follows:
                    If is set to qTrue this API will return qTrue when either all the flags 
                    set in  the value passed as the <FlagsToCheck> parameter are set in 
                    the task's EventFlags.
                    If is set to qFalse this API will return qTrue when any of the flags set in 
                    the value passed as the <FlagsToCheck> parameter are set in the task's
                    EventFlags.

Return value:

    qTrue if the condition is meet, otherwise return qFalse.

*/
qBool_t qTaskCheckEventFlags( qTask_t * const Task, qTaskFlag_t FlagsToCheck, qBool_t ClearOnExit, qBool_t CheckForAll ){
    qBool_t RetValue = qFalse;
    qTaskFlag_t CurrentEventBits;
    if( NULL != Task){
        FlagsToCheck &= QTASK_EVENTFLAGS_RMASK;
        CurrentEventBits = Task->qPrivate.Flags & QTASK_EVENTFLAGS_RMASK;
        if( qFalse == CheckForAll ){
            if( (CurrentEventBits & FlagsToCheck) != (qTaskFlag_t)0 ){
                RetValue = qTrue;
            }
        }
        else{
            if( (CurrentEventBits & FlagsToCheck) == FlagsToCheck ){
                RetValue = qTrue;
            }        
        }
        if( ( qTrue == RetValue )  && ( qTrue == ClearOnExit ) ){
            Task->qPrivate.Flags &= ~FlagsToCheck;
        }
    }
    return RetValue;
}
/*============================================================================*/
/******************************************************************************


   PRIVATE : THIS FUNCTIONS ARE NOT INTENDED FOR THE USER USAGE
   

*******************************************************************************/
/*____________________________________________________________________________*/
qBool_t __qPrivate_TaskGetFlag( const qTask_t * const Task, qUINT32_t flag){
	qUINT32_t bit;
	bit = Task->qPrivate.Flags & flag;
	return (( bit != 0uL )? qTrue : qFalse);
}
/*____________________________________________________________________________*/
void __qPrivate_TaskModifyFlags( qTask_t * const Task, qUINT32_t flags, qBool_t value){
    if( qTrue == value ){
        Task->qPrivate.Flags |= flags; /*Set bits*/
    }
    else{
        Task->qPrivate.Flags &= ~flags; /*Clear bits*/
    }
}
/*____________________________________________________________________________*/
