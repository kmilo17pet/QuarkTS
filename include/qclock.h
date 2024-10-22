/*!
* @file qclock.h
* @author J. Camilo Gomez C.
* @version 3.29
* @note This file is part of the QuarkTS distribution.
* @brief Clock and time manipulation interface used by the OS and kernel extensions.
*/
#ifndef QCLOCK_H
    #define QCLOCK_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif


    /** @addtogroup qclock
    * @brief Clock and time manipulation interface used by the entire OS.
    * @{
    */

    #if (Q_SETUP_TIME_CANONICAL == 1)
        typedef qUINT32_t qTime_t;
        #define QTIME_NULL        ( 0UL )
        #define qTimeImmediate    ( (qTime_t)(0UL) )
        #define QTUNIT_MINUTE     ( 60000UL )
        #define QTUNIT_HOUR       ( 3600000UL )
        #define QTUNIT_DAY        ( 86400000UL )
        #define QTUNIT_WEEK       ( 604800000UL )
    #else
        /** @brief The typedef that specified an time quantity, usually expressed in seconds.*/
        typedef qFloat32_t qTime_t;
        /** @brief To specify a @c NULL time value.*/
        #define QTIME_NULL        ( 0.0F )
        /** @brief To specify a non-wait time value.*/
        #define qTimeImmediate    ( (qTime_t)(0.0F) )
        /** @brief Conversion factor from seconds to minutes.*/
        #define QTUNIT_MINUTE     ( 60.0F )
        /** @brief Conversion factor from seconds to hours.*/
        #define QTUNIT_HOUR       ( 3600.0F )
        /** @brief Conversion factor from seconds to days.*/
        #define QTUNIT_DAY        ( 86400.0F )
        /** @brief Conversion factor from seconds to weeks.*/
        #define QTUNIT_WEEK       ( 604800.0F )
    #endif

    /**
     * @brief A macro to perform time conversions.
     * @param[in] _xTime_   The input time in seconds.
     * @param[in] _qUnit_   The target unit. Use on of the provided factors
     * prefixed with @c QTUNIT_XXX.
     * @return The time converted to the specified unit.
    */
    #define QTUNIT_TOTIME( _xTime_ , _qUnit_ )                              \
    ( (qTime_t)(_xTime_)*(qTime_t)(_qUnit_) )                               \

    #if ( Q_SETUP_TICK_IN_HERTZ == 1 )
        #define qTimingBase_t    qClock_t
    #else
        /** @brief A macro to specify a qTime_t type for time-base APIs.*/
        #define qTimingBase_t    qTime_t
    #endif

    /** @brief A 32-bit unsigned integer to hold ticks count. Epochs counter.*/
    typedef qUINT32_t qClock_t;

    /**
    * @brief Pointer to Function type @ref qGetTickFcn_t : A function to get the
    * hardware tick value.
    *
    * @note User should use bare-metal code to implement this function.
    * Example :
    * @code{.c}
    * qUINT32_t OSInterface_GetTick( void ) {
    *       return HAL_GetTick();
    * }
    * @endcode
    * @return The number of ticks provided by the system HAL.
    */
    typedef qClock_t (*qGetTickFcn_t)(void);

    /**
    * @brief Set the system time-base for time conversions
    * @param[in]  tb Time base
    * @return #qTrue on success, otherwise returns #qFalse.
    */
    qBool_t qClock_SetTimeBase( const qTimingBase_t tb );

    /**
    * @brief Set the clock-tick provider function.
    * @param[in] provider A pointer to the tick provider function
    * @return #qTrue on success, otherwise returns #qFalse.
    */
    qBool_t qClock_SetTickProvider( const qGetTickFcn_t provider );

    /**
    * @brief Convert the specified input time(epochs) to time(seconds)
    * @param[in] t Time in epochs
    * @return time (t) in seconds
    */
    qTime_t qClock_Convert2Time( const qClock_t t );

    /**
    * @brief Convert the specified input time(seconds) to time(epochs)
    * @param[in]  t Time in seconds
    * @return time (t) in epochs
    */
    qClock_t qClock_Convert2Clock( const qTime_t t );

    /**
    * @brief Feed the system tick.
    * @note This call is mandatory and must be called once inside the
    * dedicated timer interrupt service routine (ISR). Example
    * @code{.c}
    * void interrupt xPeriodicTimer_ISR( void ) {
    *       qClock_SysTick();
    * }
    * @endcode
    */
    void qClock_SysTick( void );

    /**
    * @brief Return the current tick used by the OS
    * @return time (t) in epochs.
    */
    extern qGetTickFcn_t qClock_GetTick; // skipcq: CXX-W2009

     /**
    * @brief Perform a timestamp check. This function computes the amount
    * of time elapsed between the current instant and the init timestamp @a ti
    * and checks if the result is greater than @a td.
    * @param[in] ti Init timestamp in epochs
    * @param[in] td Elapsed time to check in epochs
    * @return #qTrue if the elapsed time (t-ti) is greater or equal to td.
    * Otherwise returns #qFalse
    */
    qBool_t qClock_TimeDeadlineCheck( const qClock_t ti,
                                      const qClock_t td );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif

