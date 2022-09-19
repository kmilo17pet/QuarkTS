/*!
 * @file qclock.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qclock.h"

static qClock_t qClock_InternalTick( void );

static volatile qClock_t qSysTick_Epochs = 0uL;
#define QFLT_TIME_FIX_VALUE  ( 0.5f )

#if ( Q_SETUP_TIME_CANONICAL != 1 )
static qTimingBase_t timingBase;

/*============================================================================*/
qBool_t qClock_SetTimeBase( const qTimingBase_t tb )
{
    qBool_t retValue = qFalse;
    /*cstat -CERT-FLP36-C*/
    if ( tb > (qTimingBase_t)0 ) {
    /*cstat +CERT-FLP36-C*/
        timingBase = tb;
        retValue = qTrue;
    }

    return retValue;
}
#endif
/*============================================================================*/
static qClock_t qClock_InternalTick( void )
{
    return qSysTick_Epochs;
}
/*============================================================================*/
qBool_t qClock_SetTickProvider( const qGetTickFcn_t provider )
{
    qBool_t retValue = qFalse;

    if ( provider != qClock_GetTick ) {
        if ( NULL != provider ) {
            qClock_GetTick = provider;
        }
        else {
            qClock_GetTick = &qClock_InternalTick;
        }
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qTime_t qClock_Convert2Time( const qClock_t t )
{
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        return (qTime_t)t;
    #else
        #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
            return (qTime_t)( t/TimingBase );
        #else
            /*cstat -CERT-FLP36-C*/
            return (qTime_t)( timingBase*( (qTime_t)t) ); /*CERT-FLP36-C deviation allowed*/
            /*cstat +CERT-FLP36-C*/
        #endif
    #endif
}
/*============================================================================*/
qClock_t qClock_Convert2Clock( const qTime_t t )
{
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        return (qClock_t)t;
    #else
        #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
            return (qClock_t)( t*TimingBase );
        #else
            qTime_t epochs = qTimeImmediate;

            if ( t > qTimeImmediate ) {
                epochs = ( t/timingBase ) + QFLT_TIME_FIX_VALUE;
            }

            return (qClock_t)epochs;
        #endif
    #endif
}
/*============================================================================*/
void qClock_SysTick( void )
{
    ++qSysTick_Epochs;
}
/*============================================================================*/
qGetTickFcn_t qClock_GetTick = &qClock_InternalTick;
/*============================================================================*/
qBool_t qClock_TimeDeadlineCheck( const qClock_t ti,
                                  const qClock_t td )
{
    qBool_t retValue = qFalse;

    if ( ( qClock_GetTick() - ti ) >= td ) {
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
