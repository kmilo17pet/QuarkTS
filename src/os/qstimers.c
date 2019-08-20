#include "qstimers.h"

/*============================================================================*/
/*qBool_t qSTimerSet(qSTimer_t obj, const qTime_t Time)
 
Set the expiration time for a STimer. On success, the STimer gets
armed immediately

Parameters:

    - obj : A pointer to the STimer object.
    - Time : The expiration time(Must be specified in seconds).

    > Note 1: The scheduler must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greater than
              the scheduler-Tick.

Return value:

    Returns qTrue on success, otherwise, returns qFalse.
*/
qBool_t qSTimerSet( qSTimer_t *obj, const qTime_t Time ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        qConstField_Set( qClock_t, obj->TV ) = qTime2Clock(Time); /*set the STimer time in epochs*/
        qConstField_Set( qClock_t, obj->Start ) = qSchedulerGetTick(); /*set the init time of the STimer with the current system epoch value*/
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qSTimerFreeRun(qSTimer_t *obj, const qTime_t Time)

Non-Blocking STimer check with automatic arming. 
Behavior:
If disarmed, it gets armed immediately with the specified time.
If armed, the time argument is ignored and the API only checks for expiration.
When the time expires, the STimer gets armed immediately taking the specified time.

Parameters:

    - obj : A pointer to the STimer object.
    - Time : The expiration time(Must be specified in seconds). 
 
    > Note 1: The scheduler must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greater than
              the scheduler-Tick.
    > Note 3: Time parameter is only taken when the STimer is re-armed
  
Return value:

    Returns qTrue when STimer expires, otherwise, returns qFalse.
    > Note 4: A disarmed STimer also returns qFalse.
    > Note 5: After the STimer expiration,  qSTimerFreeRun re-arms the STimer
*/
qBool_t qSTimerFreeRun( qSTimer_t *obj, const qTime_t Time ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){ 
        if( QSTIMER_ARMED == qSTimerStatus( obj ) ){ 
            if( qSTimerExpired( obj ) ){
                qSTimerDisarm( obj ); 
                RetValue = qTrue;
            }
        }
        else{
            qSTimerSet( obj, Time ); 
        }
    }
    return RetValue;   
}
/*============================================================================*/
/*qBool_t qSTimerExpired(qSTimer_t *obj)

Non-Blocking STimer check

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    Returns qTrue when STimer expires, otherwise, returns qFalse.
    > Note 1: A disarmed STimer also returns false.

*/
qBool_t qSTimerExpired( const qSTimer_t *obj ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimerStatus( obj ) ){
            RetValue = ( qSTimerElapsed( obj ) >= obj->TV )? qTrue : qFalse; 
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qTime_t qSTimerElapsed(qSTimer_t *obj)

Query the elapsed time

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    The Elapsed time specified in epochs
*/
qClock_t qSTimerElapsed( const qSTimer_t *obj ){
    qClock_t RetValue = 0ul;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimerStatus( obj ) ) {
            RetValue = qSchedulerGetTick() - obj->Start;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qClock_t qSTimerRemainingEpochs(qSTimer_t *obj)

Query the remaining epochs

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    The remaining time specified in epochs
*/
qClock_t qSTimerRemaining( const qSTimer_t *obj ){
    qClock_t RetValue = 0xFFFFFFFFul;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimerStatus( obj ) ) {
            RetValue = obj->TV - qSTimerElapsed( obj );
        }
    }
    return RetValue;
}
/*============================================================================*/
/*void qSTimerDisarm(qSTimer_t *obj)

Disarms the STimer

Parameters:

    - obj : A pointer to the STimer object.  
*/
void qSTimerDisarm(qSTimer_t *obj){
    if( NULL != obj ){
        qConstField_Set( qClock_t, obj->TV ) = QSTIMER_DISARM_VALUE;
        qConstField_Set( qClock_t, obj->Start ) = QSTIMER_DISARM_VALUE;
    }
}
/*============================================================================*/
/*qBool_t qSTimerStatus(qSTimer_t *obj)

Get the current status of the STimer (Armed or Disarmed)

Parameters:

    - obj : A pointer to the STimer object.  

Return value:

    qTrue when armed, otherwise qFalse when disarmed
*/
qBool_t qSTimerStatus(const qSTimer_t *obj){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        RetValue =  ( obj->TV != QSTIMER_DISARM_VALUE )? qTrue : qFalse;
    } 
    return RetValue;
}
/*============================================================================*/