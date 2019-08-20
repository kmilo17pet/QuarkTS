#ifndef QSTIMERS_H
    #define QSTIMERS_H

    #include "qtypes.h"
    #include "qclock.h"

    typedef struct{ /*STimer defintion*/
        qConst qClock_t Start, TV; /*The time-epochs registers*/
    }qSTimer_t;
    
    #define QSTIMER_ARMED           ( qTrue )
    #define QSTIMER_DISARMED        ( qFalse )
    #define QSTIMER_DISARM_VALUE    ( 0ul )

    qBool_t qSTimerSet( qSTimer_t *obj, const qTime_t Time );
    qBool_t qSTimerExpired( const qSTimer_t *obj );
    qBool_t qSTimerFreeRun( qSTimer_t *obj, const qTime_t Time );
    qClock_t qSTimerElapsed( const qSTimer_t *obj );
    qClock_t qSTimerRemaining( const qSTimer_t *obj );
    void qSTimerDisarm( qSTimer_t *obj );
    qBool_t qSTimerStatus( const qSTimer_t *obj );
    #define QSTIMER_INITIALIZER     {0ul, 0ul}
    
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        #define qMins2Time(t)    ( ((qTime_t)(t))*60.0 )    
        #define qHours2Time(t)   ( ((qTime_t)(t))*3600.0 )
        #define qDays2Time(t)    ( ((qTime_t)(t))*86400.0 )
        #define qWeeks2Time(t)   ( ((qTime_t)(t))*604800.0 )
    #endif 

#endif 