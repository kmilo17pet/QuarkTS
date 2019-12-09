/*This file is part of the QuarkTS distribution.*/
#ifndef QSTIMERS_H
    #define QSTIMERS_H

    #include "qtypes.h"
    #include "qclock.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef struct{ 
        private_start{
            qClock_t Start; /*< The time(epochs) taken at the arming moment. */
            qClock_t TV;    /*< The required time in epochs. */
        }private_end;
    }qSTimer_t;

    #define QSTIMER_DISARM_VALUE                ( 0uL )
    #define QSTIMER_INITIALIZER                 {{QSTIMER_DISARM_VALUE, QSTIMER_DISARM_VALUE}}
    #define QSTIMER_ARMED                       ( qTrue )
    #define QSTIMER_DISARMED                    ( qFalse )
    #define QSTIMER_REMAINING_IN_DISARMED_STATE ( 0xFFFFFFFFuL )

    qBool_t qSTimerReload( qSTimer_t * const obj );
    qBool_t qSTimerSet( qSTimer_t * const obj, const qTime_t Time );
    qBool_t qSTimerExpired( const qSTimer_t * const obj );
    qBool_t qSTimerFreeRun( qSTimer_t * const obj, const qTime_t Time );
    qClock_t qSTimerElapsed( const qSTimer_t * const obj );
    qClock_t qSTimerRemaining( const qSTimer_t * const obj );
    void qSTimerDisarm( qSTimer_t * const obj );
    qBool_t qSTimerStatus( const qSTimer_t * const obj );

    #if ( Q_SETUP_TIME_CANONICAL == 0 )
        #define qMins2Time(t)    ( ((qTime_t)(t))*60.0f )    
        #define qHours2Time(t)   ( ((qTime_t)(t))*3600.0f )
        #define qDays2Time(t)    ( ((qTime_t)(t))*86400.0f )
        #define qWeeks2Time(t)   ( ((qTime_t)(t))*604800.0f )
    #endif 

    #ifdef __cplusplus
    }
    #endif

#endif 