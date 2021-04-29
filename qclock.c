#include "qclock.h"

static qClock_t qClock_InternalTick( void );

static volatile qClock_t qSysTick_Epochs = 0uL;
#define QFLT_TIME_FIX_VALUE  ( 0.5f )

#if (Q_SETUP_TIME_CANONICAL != 1)
static qTimingBase_t TimmingBase;
/*============================================================================*/
/*void qClock_SetTimeBase( const qTimingBase_t tb )

Set the system time-base for time conversions

Parameters:

    - tb : Time base 

*/
void qClock_SetTimeBase( const qTimingBase_t tb ){
    TimmingBase = tb;
} 
#endif
/*============================================================================*/
static qClock_t qClock_InternalTick( void ){
    return qSysTick_Epochs;
} 
/*============================================================================*/
/*void qClock_SetTickProvider( qGetTickFcn_t provider )

Set the clock-tick provider function.

Parameters:

    - provider : A pointer to the tick provider function  
                 qClock_t fcn(void)
                 qUINT32_t fcn(void)

*/
void qClock_SetTickProvider( const qGetTickFcn_t provider ){
    if( NULL != provider ){
        qClock_GetTick = provider;
    }
    else{
        qClock_GetTick = &qClock_InternalTick;
    }
}
/*============================================================================*/
/*qTime_t qClock_Convert2Time( const qClock_t t )

Convert the specified input time(epochs) to time(seconds)

Parameters:

    - t : time in epochs   

Return value:

    time (t) in seconds
*/
qTime_t qClock_Convert2Time( const qClock_t t ){
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        return (qTime_t)t;
    #else
        #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
            return (qTime_t)( t/TimmingBase );
        #else
            /*cstat -CERT-FLP36-C*/
            return (qTime_t)(TimmingBase*((qTime_t)t)); /*CERT-FLP36-C deviation allowed*/
            /*cstat +CERT-FLP36-C*/
        #endif      
    #endif      
}
/*============================================================================*/
/*qCLock_t qClock_Convert2Clock( const qTime_t t )

Convert the specified input time(seconds) to time(epochs)

Parameters:

    - t : time in seconds   

Return value:

    time (t) in epochs
*/
qClock_t qClock_Convert2Clock( const qTime_t t ){
    #if ( Q_SETUP_TIME_CANONICAL == 1 )
        return (qClock_t)t;
    #else 
        #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
            return (qClock_t)( t*TimmingBase );
        #else
            qTime_t epochs = qTimeImmediate;
            if( t > qTimeImmediate ){
                epochs = ( t/TimmingBase ) + QFLT_TIME_FIX_VALUE;
            }           
            return (qClock_t)epochs;
        #endif    
    #endif
}
/*============================================================================*/
/*
void qClock_SysTick( void )

Feed the system tick. This call is mandatory and must be called once inside the 
dedicated timer interrupt service routine (ISR). 
*/    
void qClock_SysTick( void ){ 
    ++qSysTick_Epochs; 
}
/*============================================================================*/
/*qClock_t qClock_GetTick( void )

Return the current tick used by the OS

Parameters:

    - t : time in epochs   

Return value:

    time (t) in seconds
*/
qGetTickFcn_t qClock_GetTick = &qClock_InternalTick;
/*============================================================================*/
/*qBool_t qClock_TimeDeadlineCheck( const qClock_t ti, const qClock_t td )

Perform a timestamp check. Computes the amount of time elapsed between the current
instant and the init timestamp <ti> and checks if the result is greather than <td>. 

Parameters:

    - ti : Init timestamp
    - td : Elapsed time to check  

Return value:

    qTrue if the elapsed time (t-ti) is greather or equal to td. Otherwise 
    returns qFalse
*/
/*============================================================================*/
qBool_t qClock_TimeDeadlineCheck( const qClock_t ti, const qClock_t td ){
    qBool_t RetValue = qFalse;
    
    if( ( qClock_GetTick() - ti ) >= td ){
        RetValue = qTrue;
    }
    return RetValue; 
}
/*============================================================================*/
