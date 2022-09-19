/*!
 * @file qstimers.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qstimers.h"

/*============================================================================*/
qBool_t qSTimer_Reload( qSTimer_t * const t )
{
    qBool_t retValue = qFalse;

    if ( NULL != t ) {
        t->tStart = qClock_GetTick();
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qSTimer_Set( qSTimer_t * const t,
                     const qTime_t tTime )
{
    qBool_t retValue = qFalse;

    if ( qSTimer_Reload( t ) ) {
        /*set the STimer time in epochs*/
        t->tv = qClock_Convert2Clock( tTime );
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qSTimer_FreeRun( qSTimer_t * const t,
                         const qTime_t tTime )
{
    qBool_t retValue = qFalse;

    if ( NULL != t ) {
        if ( QSTIMER_ARMED == qSTimer_Status( t ) ) {
            if ( qSTimer_Expired( t ) ) {
                retValue = qSTimer_Disarm( t );
            }
        }
        else {
            (void)qSTimer_Set( t, tTime );
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qSTimer_Expired( const qSTimer_t * const t )
{
    qBool_t retValue = qFalse;

    if ( NULL != t ) {
        if ( QSTIMER_ARMED == qSTimer_Status( t ) ) {
            retValue = qClock_TimeDeadlineCheck( t->tStart, t->tv );
        }
    }

    return retValue;
}
/*============================================================================*/
qClock_t qSTimer_Elapsed( const qSTimer_t * const t )
{
    qClock_t retValue = 0uL;

    if ( NULL != t ) {
        if ( QSTIMER_ARMED == qSTimer_Status( t ) ) {
            retValue = qClock_GetTick() - t->tStart;
        }
    }

    return retValue;
}
/*============================================================================*/
qClock_t qSTimer_Remaining( const qSTimer_t * const t )
{
    qClock_t retValue = QSTIMER_REMAINING_IN_DISARMED_STATE;

    if ( NULL != t ) {
        if ( QSTIMER_ARMED == qSTimer_Status( t ) ) {
            retValue = t->tv - qSTimer_Elapsed( t );
        }
    }

    return retValue;
}
/*============================================================================*/
qBool_t qSTimer_Disarm( qSTimer_t * const t )
{
    qBool_t retValue = qFalse;

    if ( NULL != t ) {
        t->tv = QSTIMER_DISARM_VALUE;
        t->tStart = QSTIMER_DISARM_VALUE;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
qBool_t qSTimer_Status( const qSTimer_t * const t )
{
    qBool_t retValue = qFalse;

    if ( NULL != t ) {
        retValue = ( t->tv != QSTIMER_DISARM_VALUE )? qTrue : qFalse;
    }

    return retValue;
}
/*============================================================================*/
