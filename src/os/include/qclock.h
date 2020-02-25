/*This file is part of the QuarkTS distribution.*/
#ifndef QCLOCK_H
    #define QCLOCK_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    #if (Q_SETUP_TIME_CANONICAL == 1)
        typedef qUINT32_t qTime_t;
        #define qTimeImmediate    ( (qTime_t)(0uL) )
        #define QTUNIT_MINUTE     ( 60000uL )    
        #define QTUNIT_HOUR       ( 3600000uL )
        #define QTUNIT_DAY        ( 86400000uL )
        #define QTUNIT_WEEK       ( 604800000uL )           
    #else
        typedef qFloat32_t qTime_t;
        #define qTimeImmediate    ((qTime_t)(0.0f))
        #define QTUNIT_MINUTE     ( 60.0f )    
        #define QTUNIT_HOUR       ( 3600.0f )
        #define QTUNIT_DAY        ( 86400.0f )
        #define QTUNIT_WEEK       ( 604800.0f )       
    #endif

    #define QTUNIT_TOTIME( _xTime_ , _qunit_ )      ( (qTime_t)( _xTime_ ) *  (qTime_t)( _qunit_ ) )

    #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
        #define qTimingBase_t    qClock_t
    #else
        #define qTimingBase_t    qTime_t
    #endif 

    typedef qUINT32_t qClock_t;
    typedef qClock_t (*qGetTickFcn_t)(void);


    void qClock_SetTimeBase( const qTimingBase_t tb );
    void qClock_SetTickProvider( qGetTickFcn_t provider );
    qTime_t qClock_Convert2Time( const qClock_t t );
    qClock_t qClock_Convert2Clock( const qTime_t t );
    void qClock_SysTick( void );
    qClock_t qClock_GetTick( void );
    qBool_t qClock_TimeDeadlineCheck( const qClock_t ti, const qClock_t td );

    #ifdef __cplusplus
    }
    #endif

#endif
