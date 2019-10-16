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
        if( Task->private.Notification < QMAX_NOTIFICATION_VALUE ){
            Task->private.Notification++;
            Task->private.AsyncData = eventdata;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qTaskQueueNotification(const qTask_t * const Task, void* eventdata)

Insert a notification in the FIFO priority queue. The scheduler get this notification
as asynchronous event, therefor, the task will be ready for execution according to 
the queue order (determined by priority), even if task is disabled. When extracted, 
the scheduler will set Trigger flag to  "byNotificationQueued". Specific user-data 
can be passed through, and will be available inside the EventData field, only in
corresponding launch.

Parameters:

    - Task : A pointer to the task node.
    - eventdata - Specific event user-data.

Return value:

    Returns qTrue if the event has been inserted in the queue, or qFalse if an error 
    occurred (The queue exceeds the size).
*/
qBool_t qTaskQueueNotification( qTask_t * const Task, void* eventdata ){
    return _qScheduler_PQueueInsert( Task, eventdata );     
}
/*============================================================================*/
/*
qBool_t qTaskIsEnabled(const qTask_t *Task)

Retrieve the enabled/disabled state

Parameters:

    Pointer to the task node.

Return value:

    True if the task in on Enabled state, otherwise returns false.
*/    
qBool_t qTaskIsEnabled( const qTask_t * const Task ){
    qBool_t RetValue = qFalse;
    if( NULL != Task ){
        RetValue = qTaskTCBGetFlag( Task, qTaskFlag_Enabled );
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
    qCycles_t RetValue = 0ul;
    if( NULL != Task ){
        RetValue = Task->private.Cycles;
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
        Task->private.Interval = qTime2Clock( Value );
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
        Task->private.Iterations = ( qPeriodic==Value )? qPeriodic : -Value;
    }      
}
/*============================================================================*/
/*void qTaskSetPriority(qTask_t * const Task, const qPriority_t Value)

Set/Change the task priority value

Parameters:

    - Task : A pointer to the task node.
    - Value : Priority Value. [0(min) - 255(max)]
*/
void qTaskSetPriority( qTask_t * const Task, const qPriority_t Value ){
    if( NULL != Task ){
        _qScheduler_ReloadScheme();
        Task->private.Priority = Value; 
    }
}
/*============================================================================*/
/*void qTaskSetCallback(qTask_t * const Task, const qTaskFcn_t Callback)

Set/Change the task callback function

Parameters:

    - Task : A pointer to the task node.
    - Callback : A pointer to a void callback method with a qEvent_t parameter 
                 as input argument.
*/
void qTaskSetCallback( qTask_t * const Task, const qTaskFcn_t CallbackFcn ){
    if( NULL != Task ){
        Task->private.Callback = CallbackFcn;
    }    
}
/*============================================================================*/
/*void qTaskSetState(qTask_t * const Task, const qState_t State)

Set the task state (Enabled or Disabled)

Parameters:

    - Task : A pointer to the task node.
    - State : qEnabled or qDisabled 
*/
void qTaskSetState(qTask_t * const Task, const qState_t State){
    if( NULL != Task ){
        if( State != qTaskTCBGetFlag( Task, qTaskFlag_Enabled ) ){ 
            qTaskTCBSetFlag( Task, qTaskFlag_Enabled, State );
            Task->private.ClockStart = qClock_GetTick();
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
        Task->private.TaskData = arg;
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
        Task->private.ClockStart = qClock_GetTick();
    }    
}
#if ( Q_QUEUES == 1)
/*============================================================================*/
/*qBool_t qTaskAttachQueue(qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, qUINT8_t arg)

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
           the element count of the queue. A zero value will act as 
           an qDETACH action. 

Return value:

    Returns qTrue on success, otherwise returns qFalse;
*/
qBool_t qTaskAttachQueue( qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const qUINT8_t arg ){
    qBool_t RetValue = qFalse;
    if( ( NULL != Queue ) && ( NULL != Task ) && ( Mode >= qQUEUE_RECEIVER ) && ( Mode <= qQUEUE_EMPTY)  ){
        if( NULL != Queue->pHead ) {
            if( Mode == qQUEUE_COUNT ){
                qTaskTCBSetFlag( Task, Mode, arg); /*if mode is qQUEUE_COUNT, use their arg value as count*/
            }
            else{
                qTaskTCBSetFlag( Task, Mode, (( arg != qFalse )? qATTACH :qDETACH) ); 
            }
            Task->private.Queue = ( arg > 0u )? Queue : NULL; /*reject, no valid arg input*/
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

Parameters:

    - Task : A pointer to the task node.
    - StateMachine : A pointer to the FSM object.

Return value:

    Returns qTrue on success, otherwise, returns qFalse.

*/
qBool_t qTaskAttachStateMachine( qTask_t * const Task, qSM_t * const StateMachine ){
    qBool_t RetValue = qFalse;
    if( ( NULL != Task ) && ( NULL != StateMachine ) ){
        Task->private.Callback = __qFSMCallbackMode;
        Task->private.StateMachine = StateMachine;
        RetValue = qTrue;
    }    
    return RetValue;
}
/*============================================================================*/
/* This function is not intended for user usage. */
qBool_t qTaskTCBGetFlag( const qTask_t * const Task, const qBase_t flagno ){
    return Task->private.Flag[ flagno ];
}
/*============================================================================*/
/* This function is not intended for user usage. */
void qTaskTCBSetFlag( qTask_t * const Task, const qBase_t flagno, const qBool_t Value ){
    Task->private.Flag[ flagno ] = Value;
}
/*============================================================================*/
#endif /* #if ( Q_FSM == 1) */