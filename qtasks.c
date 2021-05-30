/*!
 * @file qtasks.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qkernel.h"
#include "qkshared.h" /*kernel shared methods*/

/*============================================================================*/
qBool_t qTask_Notification_Send( qTask_t * const Task, void* eventdata ){
    qBool_t RetValue = qFalse;

    if( NULL != Task ){
        if( Task->qPrivate.Notification < QMAX_NOTIFICATION_VALUE ){
            ++Task->qPrivate.Notification;
            Task->qPrivate.AsyncData = eventdata;
            RetValue = qTrue;
        }
    }
    return RetValue;
}
/*============================================================================*/
qBool_t qTask_Notification_Queue( qTask_t * const Task, void* eventdata ){
    #if ( Q_PRIO_QUEUE_SIZE > 0 )      
        return qOS_PriorityQueue_Insert( Task, eventdata );     
    #else
        return qFalse;
    #endif
}
/*============================================================================*/
qBool_t qTask_HasPendingNotifications( const qTask_t * const Task  ){
    qBool_t RetValue = qFalse;

    if( NULL != Task ){
        if( Task->qPrivate.Notification > (qNotifier_t)0 ){
            RetValue = qTrue;
        }
        else{
            #if ( Q_PRIO_QUEUE_SIZE > 0 )  
                RetValue = qOS_PriorityQueue_IsTaskInside( Task );
            #endif  
        }   
    }
    return RetValue;
}
/*============================================================================*/ 
qState_t qTask_Get_State( const qTask_t * const Task){
    qState_t RetValue = qAsleep;

    if( NULL != Task ){
        RetValue = (qState_t)qOS_Get_TaskFlag( Task, QTASK_BIT_SHUTDOWN ); 
        if( (qState_t)qTrue == RetValue ){ /*Task is awaken*/
            RetValue = (qState_t)qOS_Get_TaskFlag( Task, QTASK_BIT_ENABLED );
        }
    }
    return RetValue;
}
/*============================================================================*/
#if ( Q_TASK_COUNT_CYCLES == 1 )
qCycles_t qTask_Get_Cycles( const qTask_t * const Task ){
    qCycles_t RetValue = 0uL;

    if( NULL != Task ){
        RetValue = Task->qPrivate.Cycles;
    }
    return RetValue;
}
#endif
/*============================================================================*/
qTask_GlobalState_t qTask_Get_GlobalState( const qTask_t * const Task ){  
    return qOS_GetTaskGlobalState( Task );
}
/*============================================================================*/
void qTask_Set_Time( qTask_t * const Task, const qTime_t Value ){
    if( NULL != Task ){
        (void)qSTimer_Set( &Task->qPrivate.timer , Value );
    }
}
/*============================================================================*/
void qTask_Set_Iterations( qTask_t * const Task, const qIteration_t Value ){
    if( NULL != Task ){
        Task->qPrivate.Iterations = ( qPeriodic == Value )? qPeriodic : -Value;
    }      
}
/*============================================================================*/
void qTask_Set_Priority( qTask_t * const Task, const qPriority_t Value ){
    if( NULL != Task ){
        Task->qPrivate.Priority = Value; 
    }
}
/*============================================================================*/
void qTask_Set_Callback( qTask_t * const Task, const qTaskFcn_t CallbackFcn ){
    if( NULL != Task ){ 
        Task->qPrivate.Callback = CallbackFcn;
        #if ( Q_FSM == 1 )
            Task->qPrivate.StateMachine = NULL;    
        #endif  
    }    
}
/*============================================================================*/
void qTask_Set_State( qTask_t * const Task, const qState_t State ){
    if( NULL != Task ){
        switch( State ){
            case qDisabled: case qEnabled:
                if( State != (qState_t)qOS_Get_TaskFlag( Task, QTASK_BIT_ENABLED ) ){ 
                    qOS_Set_TaskFlags( Task, QTASK_BIT_ENABLED, (qBool_t)State );
                    (void)qSTimer_Reload( &Task->qPrivate.timer );
                }
                break;
            case qAsleep:
                qOS_Set_TaskFlags( Task, QTASK_BIT_SHUTDOWN, qFalse );
                break;
            case qAwake:
                qOS_Set_TaskFlags( Task, QTASK_BIT_SHUTDOWN, qTrue );
                break;
            default:
                break;
        }
    }
}
/*============================================================================*/
void qTask_Set_Data( qTask_t * const Task, void* arg ){
    if( NULL != Task ){
        Task->qPrivate.TaskData = arg;
    }
}
/*============================================================================*/
void qTask_ClearTimeElapsed( qTask_t * const Task ){
    if( NULL != Task ){
        (void)qSTimer_Reload( &Task->qPrivate.timer );
    }    
}
/*============================================================================*/
qTask_t* qTask_Self( void ){
    return qOS_Get_TaskRunning();
}
#if ( Q_QUEUES == 1)
/*============================================================================*/
qBool_t qTask_Attach_Queue( qTask_t * const Task, qQueue_t * const Queue, const qQueueLinkMode_t Mode, const qUINT16_t arg ){
    qBool_t RetValue = qFalse;

    if( ( NULL != Queue ) && ( NULL != Task ) ){
        if( NULL != Queue->qPrivate.head ) {
            qOS_Set_TaskFlags( Task, (qUINT32_t)Mode & QTASK_QUEUEFLAGS_MASK, (( 0u != arg )? qATTACH : qDETACH ) );
            if( Mode == qQueueMode_Count ){
                Task->qPrivate.QueueCount = (qUINT32_t)arg; /*if mode is qQUEUE_COUNT, use their arg value as count*/
            }
            Task->qPrivate.Queue = ( arg > 0u )? Queue : NULL; /*reject, no valid arg input*/
            RetValue = qTrue;
        }
    }
    return RetValue;
}
#endif /* #if ( Q_QUEUES == 1) */
#if ( Q_TASK_EVENT_FLAGS == 1 )
/*============================================================================*/
void qTask_EventFlags_Modify( qTask_t * const Task, qTask_Flag_t flags, qBool_t action ){
    if( NULL != Task ){
        qTask_Flag_t FlagsToSet = flags & QTASK_EVENTFLAGS_RMASK;
        qOS_Set_TaskFlags( Task, FlagsToSet, action );
    }
}
/*============================================================================*/
qTask_Flag_t qTask_EventFlags_Read( const qTask_t * const Task ){
    qTask_Flag_t RetValue = 0u;
    
    if( NULL != Task ){
        RetValue = Task->qPrivate.Flags & QTASK_EVENTFLAGS_RMASK;
    }    
    return RetValue;
}
/*============================================================================*/
qBool_t qTask_EventFlags_Check( qTask_t * const Task, qTask_Flag_t FlagsToCheck, qBool_t ClearOnExit, qBool_t CheckForAll ){
    qBool_t RetValue = qFalse;
    
    if( NULL != Task ){
        qTask_Flag_t CurrentEventBits = Task->qPrivate.Flags & QTASK_EVENTFLAGS_RMASK;

        FlagsToCheck &= QTASK_EVENTFLAGS_RMASK;
        if( qFalse == CheckForAll ){
            if( (qTask_Flag_t)0 != ( CurrentEventBits & FlagsToCheck ) ){
                RetValue = qTrue;
            }
        }
        else{
            if(  (CurrentEventBits & FlagsToCheck ) == FlagsToCheck ){
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
#endif/* ( Q_TASK_EVENT_FLAGS == 1 ) */

