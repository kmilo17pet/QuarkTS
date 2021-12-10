/*!
 * @file qtasks.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qkernel.h"
#include "qkshared.h" /*kernel shared methods*/
#include "qtrace.h"

/*============================================================================*/
qBool_t qTask_Notification_Send( qTask_t * const Task,
                                 void* eventdata )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        if ( Task->qPrivate.notification < QMAX_NOTIFICATION_VALUE ) {
            ++Task->qPrivate.notification;
            Task->qPrivate.asyncData = eventdata;
            _QTRACE_KERNEL( "(>)Notification sended to task ",
                            Task,
                            eventdata );
            retValue = qTrue;
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qTask_Notification_Queue( qTask_t * const Task,
                                  void* eventdata )
{
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        return qOS_PriorityQueue_Insert( Task, eventdata );
    #else
        _QTRACE_KERNEL( "(E)Priority queue disabled. Notification can't be"
                        "queued for task ",
                        Task,
                        NULL );
        return qFalse;
    #endif
}
/*============================================================================*/
qBool_t qTask_HasPendingNotifications( const qTask_t * const Task )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        if ( Task->qPrivate.notification > (qNotifier_t)0 ) {
            retValue = qTrue;
        }
        else {
            #if ( Q_PRIO_QUEUE_SIZE > 0 )
                retValue = qOS_PriorityQueue_IsTaskInside( Task );
            #endif
        }
    }

    return retValue;
}
/*============================================================================*/
qState_t qTask_Get_State( const qTask_t * const Task )
{
    qState_t retValue = qAsleep;

    if ( NULL != Task ) {
        retValue = (qState_t)qOS_Get_TaskFlag( Task, QTASK_BIT_SHUTDOWN );
        if ( (qState_t)qTrue == retValue ) { /*Task is awaken*/
            retValue = (qState_t)qOS_Get_TaskFlag( Task, QTASK_BIT_ENABLED );
        }
    }

    return retValue;
}
/*============================================================================*/
#if ( Q_TASK_COUNT_CYCLES == 1 )
qCycles_t qTask_Get_Cycles( const qTask_t * const Task )
{
    qCycles_t retValue = 0uL;

    if ( NULL != Task ) {
        retValue = Task->qPrivate.cycles;
    }

    return retValue;
}
#endif
/*============================================================================*/
qTask_GlobalState_t qTask_Get_GlobalState( const qTask_t * const Task )
{
    return qOS_GetTaskGlobalState( Task );
}
/*============================================================================*/
qBool_t qTask_Set_Time( qTask_t * const Task, const qTime_t tValue )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        retValue = qSTimer_Set( &Task->qPrivate.timer, tValue );
    }

    return retValue;
}
/*============================================================================*/
qBool_t qTask_Set_Iterations( qTask_t * const Task,
                              const qIteration_t iValue )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        if ( iValue >= (qIteration_t)0 ) {
            Task->qPrivate.iterations = -iValue;
            retValue = qTrue;
        }
        else if ( qPeriodic == iValue ) {
            Task->qPrivate.iterations = qPeriodic;
            retValue = qTrue;
        }
        else {
            /*nothing to do, return qFalse*/
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qTask_Set_Priority( qTask_t * const Task,
                            const qPriority_t pValue )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != Task ) && ( pValue < (qPriority_t)Q_PRIORITY_LEVELS ) ) {
        Task->qPrivate.priority = pValue;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qTask_Set_Callback( qTask_t * const Task,
                            const qTaskFcn_t cFcn )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != Task ) && ( cFcn != Task->qPrivate.callback ) ) {
        Task->qPrivate.callback = cFcn;
        #if ( ( Q_FSM == 1 ) || ( Q_ATCLI == 1 ) )
            Task->qPrivate.aObj = NULL;
        #endif
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qTask_Set_State( qTask_t * const Task,
                        const qState_t s )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        switch ( s ) {
            case qDisabled: case qEnabled:
                if ( s != (qState_t)qOS_Get_TaskFlag( Task, QTASK_BIT_ENABLED ) ) {
                    qOS_Set_TaskFlags( Task, QTASK_BIT_ENABLED, (qBool_t)s );
                    (void)qSTimer_Reload( &Task->qPrivate.timer );
                }
                retValue = qTrue;
                break;
            case qAsleep:
                qOS_Set_TaskFlags( Task, QTASK_BIT_SHUTDOWN, qFalse );
                retValue = qTrue;
                break;
            case qAwake:
                qOS_Set_TaskFlags( Task, QTASK_BIT_SHUTDOWN, qTrue );
                retValue = qTrue;
                break;
            default:
                break;
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qTask_Set_Data( qTask_t * const Task,
                        void* arg )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != Task ) && ( arg != Task->qPrivate.taskData ) ) {
        Task->qPrivate.taskData = arg;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qTask_Clear( qTask_t * const Task,
                     const qTask_ClrParam_t param )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        switch ( param ) {
            case qTask_ClearIterations:
                Task->qPrivate.iterations = (qIteration_t)0;
                retValue = qTrue;
                break;
            case qTask_ClearTimeElapsed:
                retValue =  qSTimer_Reload( &Task->qPrivate.timer );
                break;
            case qTask_ClearCycles:
                #if ( Q_TASK_COUNT_CYCLES == 1 )
                    Task->qPrivate.cycles = 0uL;
                    retValue = qTrue;
                #endif
                break;
            case qTask_ClearNotifications:
                Task->qPrivate.notification = 0uL;
                #if ( Q_PRIO_QUEUE_SIZE > 0 )
                    qOS_PriorityQueue_Init();
                #endif
                retValue = qTrue;
                break;
            case qTask_ClearSimpleNotifications:
                Task->qPrivate.notification = 0uL;
                retValue = qTrue;
                break;
            case qTask_ClearQueuedNotifications:
                #if ( Q_PRIO_QUEUE_SIZE > 0 )
                    qOS_PriorityQueue_Init();
                #endif
                retValue = qTrue;
                break;
            default:
                break;
        }
    }

    return retValue;
}
/*============================================================================*/
qTask_t* qTask_Self( void )
{
    return qOS_Get_TaskRunning();
}
#if ( Q_QUEUES == 1 )
/*============================================================================*/
qBool_t qTask_Attach_Queue( qTask_t * const Task,
                            qQueue_t * const q,
                            const qQueueLinkMode_t mode,
                            const qUINT16_t arg )
{
    qBool_t retValue = qFalse;

    if ( ( NULL != q ) && ( NULL != Task ) && ( NULL != q->qPrivate.head ) ) {
        qOS_Set_TaskFlags( Task,
                           (qUINT32_t)mode & QTASK_QUEUEFLAGS_MASK,
                           ( ( 0u != arg )? qATTACH : qDETACH ) );
        if ( mode == qQueueMode_Count ) {
            /*if mode is qQUEUE_COUNT, use their arg value as count*/
            Task->qPrivate.aQueueCount = (qUINT32_t)arg;
        }
        /*reject, if no valid arg input*/
        Task->qPrivate.aQueue = ( arg > 0u )? q : NULL;
        retValue = qTrue;
        _QTRACE_KERNEL( "(>)Queue successfully attached to task ", Task, q );
    }

    return retValue;
}
#endif /* #if ( Q_QUEUES == 1 ) */
#if ( Q_TASK_EVENT_FLAGS == 1 )
/*============================================================================*/
qBool_t qTask_EventFlags_Modify( qTask_t * const Task,
                                 const qTask_Flag_t flags,
                                 const qBool_t action )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        qTask_Flag_t flagsToSet = flags & QTASK_EVENTFLAGS_RMASK;
        qOS_Set_TaskFlags( Task, flagsToSet, action );
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qTask_Flag_t qTask_EventFlags_Read( const qTask_t * const Task )
{
    qTask_Flag_t retValue = 0u;

    if ( NULL != Task ) {
        retValue = Task->qPrivate.flags & QTASK_EVENTFLAGS_RMASK;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qTask_EventFlags_Check( qTask_t * const Task,
                                qTask_Flag_t flagsToCheck,
                                const qBool_t clearOnExit,
                                const qBool_t checkForAll )
{
    qBool_t retValue = qFalse;

    if ( NULL != Task ) {
        qTask_Flag_t cEventBits = Task->qPrivate.flags & QTASK_EVENTFLAGS_RMASK;

        flagsToCheck &= QTASK_EVENTFLAGS_RMASK;
        if ( qFalse == checkForAll ) {
            if ( (qTask_Flag_t)0 != ( cEventBits & flagsToCheck ) ) {
                retValue = qTrue;
            }
        }
        else {
            if ( ( cEventBits & flagsToCheck ) == flagsToCheck ) {
                retValue = qTrue;
            }
        }
        if ( ( qTrue == retValue ) && ( qTrue == clearOnExit ) ) {
            Task->qPrivate.flags &= ~flagsToCheck;
        }
    }

    return retValue;
}
/*============================================================================*/
#endif/* ( Q_TASK_EVENT_FLAGS == 1 ) */
#if ( Q_ALLOW_TASK_NAMING == 1 )
/*============================================================================*/
qBool_t qTask_Set_Name( qTask_t * const Task,
                        const char *name )
{
    qBool_t retValue = qFalse;
    /*cstat -MISRAC2012-Rule-13.5*/
    /*qOS_FindTaskByName is know to not have side effects*/
    if ( ( NULL != Task ) && ( NULL == qOS_FindTaskByName( name ) )) {
    /*cstat +MISRAC2012-Rule-13.5*/
        Task->qPrivate.name = name;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
const char *qTask_Get_Name( const qTask_t * const Task )
{
    const char *retValue = NULL;

    if ( NULL != Task ) {
        retValue = Task->qPrivate.name;
    }

    return retValue;
}
/*============================================================================*/
qTask_t* qTask_Find_ByName( const char *name )
{
    return qOS_FindTaskByName( name ); /*let the kernel perform this*/
}
#endif /* #if ( Q_ALLOW_TASK_NAMING == 1 ) */
/*============================================================================*/
