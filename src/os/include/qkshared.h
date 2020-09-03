/*This file is part of the QuarkTS distribution.*/
#ifndef QKSHARED_H
    #define QKSHARED_H

    #include "qtypes.h"
    #include "qtasks.h"

    #ifdef __cplusplus
    extern "C" {
    #endif
   
    /* Task flags
    MSB---------------------------------------------------------------------------------------------------------------------------------------------------------LSB
    | (31..11)EVENTFLAGS |  (10..8)-STATE  | 7-REM.REQ  | 6-SHUTDOWN | 5-QUEUE_EMPTY | 4-QUEUE_COUNT | 3-QUEUE_FULL | 2-QUEUE_RECEIVER |  1-ENABLED  |  0-INIT   |
    |-----------------------------------------------------------------------------------------------------------------------------------------------------------|
    */
    #define QTASK_COREBITS_RMASK        ( 0x000000FFuL )	 
    #define QTASK_COREBITS_WMASK        ( 0xFFFFFF00uL )
    #define QTASK_COREBITS_OFFSET       ( 0 )

    #define QTASK_STATEBITS_RMASK	    ( 0x00000F00uL )
    #define QTASK_STATEBITS_WMASK	    ( 0xFFFFF0FFuL )
    #define QTASK_STATEBITS_OFFSET      ( 8 )

    #define QTASK_EVENTFLAGS_RMASK	    ( 0xFFFFF000uL )
    #define QTASK_EVENTFLAGS_WMASK	    ( 0x00000FFFuL )
    #define QTASK_EVENTFLAGS_OFFSET     ( 12 )
    
    #define _QTASK_QUEUEFLAGS_MASK      ( 0x0000003CuL )
    #define _QTASK_BIT_INIT             ( 0x00000001uL )  
    #define _QTASK_BIT_ENABLED          ( 0x00000002uL )    
    #define _QTASK_BIT_QUEUE_RECEIVER   ( 0x00000004uL )
    #define _QTASK_BIT_QUEUE_FULL       ( 0x00000008uL )
    #define _QTASK_BIT_QUEUE_COUNT      ( 0x00000010uL )
    #define _QTASK_BIT_QUEUE_EMPTY      ( 0x00000020uL )
    #define _QTASK_BIT_SHUTDOWN         ( 0x00000040uL )
    #define _QTASK_BIT_REMOVE_REQUEST   ( 0x00000080uL )    
   
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
