#include "qstimers.h"

/*============================================================================*/
/*qBool_t qSTimer_Reload( qSTimer_t * const obj )

Reload the timer with the previous specified time.
Note: STimer should be armed before this operation

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    Returns qTrue on success, otherwise, returns qFalse.
*/
qBool_t qSTimer_Reload( qSTimer_t * const obj ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        obj->Start = qClock_GetTick();
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qSTimer_Set( qSTimer_t * const obj, const qTime_t Time )
 
Set the expiration time for a STimer. On success, the STimer gets
armed immediately

Parameters:

    - obj : A pointer to the STimer object.
    - Time : The expiration time(Must be specified in seconds).

    > Note 1: The OS must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greater than
              the clock-Tick.

Return value:

    Returns qTrue on success, otherwise, returns qFalse.
*/
qBool_t qSTimer_Set( qSTimer_t * const obj, const qTime_t Time ){
    qBool_t RetValue = qFalse;
    if( qSTimer_Reload( obj ) ){
        obj->TV  = qClock_Convert2Clock(Time); /*set the STimer time in epochs*/
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qSTimer_FreeRun( qSTimer_t * const obj, const qTime_t Time )

Non-Blocking STimer check with automatic arming. 
Behavior:
If disarmed, it gets armed immediately with the specified time.
If armed, the time argument is ignored and the API only checks for expiration.
When the time expires, the STimer gets armed immediately taking the specified time.

Parameters:

    - obj : A pointer to the STimer object.
    - Time : The expiration time(Must be specified in seconds). 
 
    > Note 1: The OS must be running before using STimers.
    > Note 2: The expiration time should be at least, two times greater than
              the clock-Tick.
    > Note 3: Time parameter is only taken when the STimer is re-armed
  
Return value:

    Returns qTrue when STimer expires, otherwise, returns qFalse.
    > Note 4: A disarmed STimer also returns qFalse.
    > Note 5: After the STimer expiration,  qSTimerFreeRun re-arms the STimer
*/
qBool_t qSTimer_FreeRun( qSTimer_t * const obj, const qTime_t Time ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){ 
        if( QSTIMER_ARMED == qSTimer_Status( obj ) ){ 
            if( qSTimer_Expired( obj ) ){
                qSTimer_Disarm( obj ); 
                RetValue = qTrue;
            }
        }
        else{
            (void)qSTimer_Set( obj, Time ); 
        }
    }
    return RetValue;   
}
/*============================================================================*/
/*qBool_t qSTimer_Expired( const qSTimer_t * const obj )

Non-Blocking STimer check

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    Returns qTrue when STimer expires, otherwise, returns qFalse.
    > Note 1: A disarmed STimer also returns false.

*/
qBool_t qSTimer_Expired( const qSTimer_t * const obj ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimer_Status( obj ) ){
            RetValue = qClock_TimeDeadlineCheck( obj->Start, obj->TV );
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qTime_t qSTimer_Elapsed( const qSTimer_t * const obj )

Query the elapsed time

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    The Elapsed time specified in epochs
*/
qClock_t qSTimer_Elapsed( const qSTimer_t * const obj ){
    qClock_t RetValue = 0uL;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimer_Status( obj ) ) {
            RetValue = qClock_GetTick() - obj->Start;
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qClock_t qSTimer_Remaining( const qSTimer_t * const obj )

Query the remaining epochs

Parameters:

    - obj : A pointer to the STimer object.

Return value:

    The remaining time specified in epochs
*/
qClock_t qSTimer_Remaining( const qSTimer_t * const obj ){
    qClock_t RetValue = QSTIMER_REMAINING_IN_DISARMED_STATE;
    if( NULL != obj ){
        if( QSTIMER_ARMED == qSTimer_Status( obj ) ) {
            RetValue = obj->TV - qSTimer_Elapsed( obj );
        }
    }
    return RetValue;
}
/*============================================================================*/
/*void qSTimer_Disarm( const qSTimer_t * const obj )

Disarms the STimer

Parameters:

    - obj : A pointer to the STimer object.  
*/
void qSTimer_Disarm(qSTimer_t * const obj){
    if( NULL != obj ){
        obj->TV = QSTIMER_DISARM_VALUE;
        obj->Start = QSTIMER_DISARM_VALUE;
    }
}
/*============================================================================*/
/*qBool_t qSTimer_Status( const qSTimer_t * const obj )

Get the current status of the STimer (Armed or Disarmed)

Parameters:

    - obj : A pointer to the STimer object.  

Return value:

    qTrue when armed, otherwise qFalse when disarmed
*/
qBool_t qSTimer_Status(const qSTimer_t * const obj){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        RetValue =  ( obj->TV != QSTIMER_DISARM_VALUE )? qTrue : qFalse;
    } 
    return RetValue;
}
/*============================================================================*/
