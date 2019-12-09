/*This file is part of the QuarkTS distribution.*/
#ifndef QCLOCK_H
    #define QCLOCK_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    #if (Q_SETUP_TIME_CANONICAL == 1)
        typedef qUINT32_t qTime_t;
        #define qTimeImmediate       ((qTime_t)(0uL))
    #else
        typedef qFloat32_t qTime_t;
        #define qTimeImmediate       ((qTime_t)(0.0f))
        #define QFLT_TIME_FIX_VALUE  ( 0.00001f )
    #endif

    #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
        #define qTimingBase_type    qClock_t
    #else
        #define qTimingBase_type    qTime_t
    #endif 

    typedef qUINT32_t qClock_t;
    typedef qClock_t (*qGetTickFcn_t)(void);


    void qClock_SetTimeBase( const qTimingBase_type tb );
    void qClock_SetTickProvider( qGetTickFcn_t provider );
    qTime_t qClock2Time( const qClock_t t );
    qClock_t qTime2Clock( const qTime_t t );
    void qClock_SysTick( void );
    qClock_t qClock_GetTick( void );
    qBool_t qClock_TimeDeadlineCheck( const qClock_t ti, const qClock_t td );

    #ifdef __cplusplus
    }
    #endif

#endif 