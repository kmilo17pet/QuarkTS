#ifndef QCLOCK_H

    #define QCLOCK_H

    #include "qtypes.h"

    #if (Q_SETUP_TIME_CANONICAL == 1)
        typedef uint32_t qTime_t;
        #define qTimeImmediate       ((qTime_t)(0ul))
    #else
        typedef float qTime_t;
        #define qTimeImmediate       ((qTime_t)(0.0f))
    #endif

    #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
        #define qTimingBase_type    qClock_t
    #else
        #define qTimingBase_type    qTime_t
    #endif 

    typedef uint32_t qClock_t;
    typedef qClock_t (*qGetTickFcn_t)(void);

    void qClock_SetTimeBase( qTimingBase_type tb );
    void qClock_SetTickProvider( qGetTickFcn_t provider );
    qTime_t qClock2Time( const qClock_t t );
    qClock_t qTime2Clock( const qTime_t t );
    void qSchedulerSysTick( void );
    qClock_t qSchedulerGetTick( void );
    qBool_t qClock_TimeDeadlineCheck( qClock_t ti, qClock_t td );

#endif 