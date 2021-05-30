/*!
 * @file qstimers.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qstimers.h"

/*============================================================================*/
qBool_t qSTimer_Reload( qSTimer_t * const obj ){
    qBool_t RetValue = qFalse;
    
    if( NULL != obj ){
        obj->Start = qClock_GetTick();
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
qBool_t qSTimer_Set( qSTimer_t * const obj, const qTime_t Time ){
    qBool_t RetValue = qFalse;

    if( qSTimer_Reload( obj ) ){
        obj->TV  = qClock_Convert2Clock(Time); /*set the STimer time in epochs*/
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
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
void qSTimer_Disarm( qSTimer_t * const obj ){
    if( NULL != obj ){
        obj->TV = QSTIMER_DISARM_VALUE;
        obj->Start = QSTIMER_DISARM_VALUE;
    }
}
/*============================================================================*/
qBool_t qSTimer_Status( const qSTimer_t * const obj ){
    qBool_t RetValue = qFalse;

    if( NULL != obj ){
        RetValue =  ( obj->TV != QSTIMER_DISARM_VALUE )? qTrue : qFalse;
    } 
    return RetValue;
}
/*============================================================================*/
