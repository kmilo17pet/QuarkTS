/*This file is part of the QuarkTS distribution.*/
#ifndef QSTIMERS_H
    #define QSTIMERS_H

    #include "qtypes.h"
    #include "qclock.h"

    #ifdef __cplusplus
    extern "C" {
    #endif
    
    typedef struct{ 
        qClock_t Start;     /*< The time(epochs) taken at the arming moment. */
        qClock_t TV;        /*< The required time in epochs. */
    }qSTimer_t;

    #define QSTIMER_DISARM_VALUE                ( 0uL )
    #define QSTIMER_INITIALIZER                 { QSTIMER_DISARM_VALUE, QSTIMER_DISARM_VALUE }
    #define QSTIMER_ARMED                       ( qTrue )
    #define QSTIMER_DISARMED                    ( qFalse )
    #define QSTIMER_REMAINING_IN_DISARMED_STATE ( 0xFFFFFFFFuL )

    qBool_t qSTimer_Reload( qSTimer_t * const obj );
    qBool_t qSTimer_Set( qSTimer_t * const obj, const qTime_t Time );
    qBool_t qSTimer_Expired( const qSTimer_t * const obj );
    qBool_t qSTimer_FreeRun( qSTimer_t * const obj, const qTime_t Time );
    qClock_t qSTimer_Elapsed( const qSTimer_t * const obj );
    qClock_t qSTimer_Remaining( const qSTimer_t * const obj );
    void qSTimer_Disarm( qSTimer_t * const obj );
    qBool_t qSTimer_Status( const qSTimer_t * const obj );

    #ifdef __cplusplus
    }
    #endif

#endif
