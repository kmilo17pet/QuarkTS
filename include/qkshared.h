/*!
 * @file qkshared.h
 * @author J. Camilo Gomez C.
 * @version 1.08
 * @note This file is part of the QuarkTS distribution.
 * @brief Kernel shared interfaces
 **/
#ifndef QKSHARED_H
    #define QKSHARED_H

    #include "qtypes.h"
    #include "qtasks.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    /** @cond */

    /* Task flags
    MSB---------------------------------------------------------------------------------------------------------------------------------------------------------LSB
    | (31..11)EVENTFLAGS |  (10..8)-STATE  | 7-REM.REQ  | 6-SHUTDOWN | 5-QUEUE_EMPTY | 4-QUEUE_COUNT | 3-QUEUE_FULL | 2-QUEUE_RECEIVER |  1-ENABLED  |  0-INIT   |
    |------------------------------------------------------------------------------------------------------------------------------------------------------------|
    */
    #define QTASK_EVENTFLAGS_RMASK      ( 0xFFFFF000uL )
    #define QTASK_QUEUEFLAGS_MASK       ( 0x0000003CuL )

    #define QTASK_BIT_INIT              ( 0x00000001uL )
    #define QTASK_BIT_ENABLED           ( 0x00000002uL )
    #define QTASK_BIT_QUEUE_RECEIVER    ( 0x00000004uL )
    #define QTASK_BIT_QUEUE_FULL        ( 0x00000008uL )
    #define QTASK_BIT_QUEUE_COUNT       ( 0x00000010uL )
    #define QTASK_BIT_QUEUE_EMPTY       ( 0x00000020uL )
    #define QTASK_BIT_SHUTDOWN          ( 0x00000040uL )
    #define QTASK_BIT_REMOVE_REQUEST    ( 0x00000080uL )

     /*Private kernel shared functions*/
    #if ( Q_PRIO_QUEUE_SIZE > 0 )
        extern qBool_t qOS_PriorityQueue_Insert( qTask_t * const Task,
                                                 void *pData );
        extern qBool_t qOS_PriorityQueue_IsTaskInside( const qTask_t * const Task );
        extern size_t qOS_PriorityQueue_GetCount( void );
        extern void qOS_PriorityQueue_Init( void );
    #endif

    extern qTask_GlobalState_t qOS_GetTaskGlobalState( const qTask_t * const Task );
    extern qTask_t* qOS_Get_TaskRunning( void );

    extern qBool_t qOS_Get_TaskFlag( const qTask_t * const Task,
                                     const qUINT32_t flag );
    extern void qOS_Set_TaskFlags( qTask_t * const Task,
                                   const qUINT32_t flags,
                                   const qBool_t value );

    #if ( Q_ALLOW_TASK_NAMING == 1 )
        extern qTask_t* qOS_FindTaskByName( const char *name );
    #endif

    /** @endcond */

    #ifdef __cplusplus
    }
    #endif

#endif
