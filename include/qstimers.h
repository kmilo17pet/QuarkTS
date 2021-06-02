/*!
 * @file qstimers.h
 * @author J. Camilo Gomez C.
 * @version 1.08
 * @note This file is part of the QuarkTS distribution.
 * @brief API interface for the Software-Timers module.
 **/
#ifndef QSTIMERS_H
    #define QSTIMERS_H

    #include "qtypes.h"
    #include "qclock.h"

    #ifdef __cplusplus
    extern "C" {
    #endif
    
    /** @addtogroup qstimers Software Timers (STimers)
    * @brief API interface for the Software-Timers module.
    *  @{
    */

    /** 
    * @brief A STimer(Software Timer) object
    * @details A STimer is referenced by a handle, an object of type qSTimer_t and preferably, 
    * should be initialized by the #QSTIMER_INITIALIZER constant before any usage. 
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qSTimer_s{ 
        /*! @cond  */
        qClock_t Start;     /*< The time(epochs) taken at the arming moment. */
        qClock_t TV;        /*< The required time in epochs. */
        /*! @endcond  */
    }qSTimer_t;

    /** @brief Macro that defines the value of a disarmed STimer*/
    #define QSTIMER_DISARM_VALUE                ( 0uL )
    /** @brief Macro that can be used to initialize a disarmed STimer instance*/
    #define QSTIMER_INITIALIZER                 { QSTIMER_DISARM_VALUE, QSTIMER_DISARM_VALUE }
    /** @brief Macro that defines the status of an armed STimer*/
    #define QSTIMER_ARMED                       ( qTrue )
    /** @brief Macro that defines the status of a disarmed STimer*/
    #define QSTIMER_DISARMED                    ( qFalse )
    /** @brief Macro that defines the value that a disarmed STimer returns when the remaining time is requested.*/
    #define QSTIMER_REMAINING_IN_DISARMED_STATE ( 0xFFFFFFFFuL )

    /**
    * @brief Reload the STimer with the previous specified time.
    * @note STimer should be armed before this operation
    * @param[in] obj A pointer to the STimer object.
    * @return Returns qTrue on success, otherwise, returns qFalse.
    */     
    qBool_t qSTimer_Reload( qSTimer_t * const obj );

    /**
    * @brief Set the expiration time for a STimer. On success, the STimer gets
    * armed immediately
    * @note The OS must be running before using STimers.
    * @note The expiration time should be at least, two times greater than 
    * the clock-Tick.
    * @param[in] obj A pointer to the STimer object.
    * @param[in] Time The expiration time(Must be specified in seconds).
    * @return Returns #qTrue on success, otherwise, returns #qFalse.
    */        
    qBool_t qSTimer_Set( qSTimer_t * const obj, const qTime_t Time );

    /**
    * @brief Non-Blocking STimer check
    * @param[in] obj A pointer to the STimer object.
    * @return Returns #qTrue when STimer expires, otherwise, returns #qFalse.
    * @note A disarmed STimer also returns #qFalse.
    */         
    qBool_t qSTimer_Expired( const qSTimer_t * const obj ); 

    /**
    * @brief Non-Blocking STimer check with automatic arming. 
    *
    * Behavior:
    * If disarmed, it gets armed immediately with the specified time.
    * 
    * If armed, the time argument is ignored and the API only checks for expiration.
    * When the time expires, the STimer gets armed immediately taking the specified time.
    * @note After the STimer expiration, qSTimer_FreeRun() re-arms the STimer
    * @note The OS must be running before using STimers.
    * @note The expiration time should be at least, two times greater than 
    * the clock-Tick.
    * @param[in] obj A pointer to the STimer object.
    * @param[in] Time The expiration time(Must be specified in seconds).
    * @return Returns #qTrue on success, otherwise, returns #qFalse.
    * @note A disarmed STimer also returns #qFalse.
    */          
    qBool_t qSTimer_FreeRun( qSTimer_t * const obj, const qTime_t Time );

    /**
    * @brief Retrieve the elapsed time in epochs
    * @param[in] obj A pointer to the STimer object.
    * @return The Elapsed time specified in epochs.
    */         
    qClock_t qSTimer_Elapsed( const qSTimer_t * const obj );

    /**
    * @brief Retrieve the remaining time in epochs
    * @param[in] obj A pointer to the STimer object.
    * @return The remaining time specified in epochs.
    */           
    qClock_t qSTimer_Remaining( const qSTimer_t * const obj );

    /**
    * @brief Disarms the STimer object
    * @param[in] obj A pointer to the STimer object.
    */         
    void qSTimer_Disarm( qSTimer_t * const obj );

    /**
    * @brief Get the current status of the STimer (Armed or Disarmed)
    * @param[in] obj A pointer to the STimer object.
    * @return #qTrue when armed, otherwise #qFalse when disarmed.
    */        
    qBool_t qSTimer_Status( const qSTimer_t * const obj );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
