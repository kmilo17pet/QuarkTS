/*This file is part of the QuarkTS distribution.*/
#ifndef QKSHARED_H
    #define QKSHARED_H

    #include "qtypes.h"
    #include "qtasks.h"

    #ifdef __cplusplus
    extern "C" {
    #endif
   
    /*Private kernel shared functions*/
    #if ( Q_PRIO_QUEUE_SIZE > 0 ) 
        extern qBool_t qOS_PriorityQueue_Insert( qTask_t * const Task, void *Data );
        extern qBool_t qOS_PriorityQueue_IsTaskInside( const qTask_t * const Task );
        extern size_t qOS_PriorityQueue_GetCount( void );
    #endif
    
    extern void qOS_DummyTask_Callback( qEvent_t e );
    extern qTask_GlobalState_t qOS_GetTaskGlobalState( const qTask_t * const Task);
    extern qTask_t* qOS_Get_TaskRunning( void );

    #ifdef __cplusplus
    }
    #endif

#endif
