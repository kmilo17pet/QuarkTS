/*!
* @file qinput.h
* @author Julian Bustamante N
* @version 1.0
* @note This file is part of the QuarkTS distribution.
* @brief A comprehensive event structure for efficient, maintainable working with
* input channels
*/
#ifndef QINPUT_H
#define QINPUT_H

#include <stdint.h>
#include "qtypes.h"
#include "qclock.h"
#include "qlists.h"
#include "qstimers.h"


#ifdef __cplusplus
extern "C" {
#endif

/** @addtogroup qinput Input channel events
* @brief A comprehensive event structure for efficient, maintainable working with
* input channels.
*  @{
*/

/**
* @brief Input Interfaces.
*/

/** @addtogroup qinput
*  @{
*/

/**
* @brief An enum with all the possible events that can be detected by the
* watcher structure for a specified input-channel.
*/
typedef enum qEvent_t {
    NONE = 0,
    EXCEPTION,              /**< Error due a bad reading or channel configuration .*/
    ON_CHANGE,              /**< Event on any input-channel change when crossing the thresholds*/
    FALLING_EDGE,           /**< Event on falling-edge( high to low ) of the digital input-channel*/
    RISING_EDGE,            /**< Event on rising-edge( low to high ) of the digital input-channel*/
    PULSATION_DOUBLE,       /**< Event when the digital input is pulsated two times within the interval*/
    PULSATION_TRIPLE,       /**< Event when the digital input is pulsated three times within the interval*/
    PULSATION_MULTI,        /**< Event when the digital input is pulsated more than three times within the interval*/
    HIGH_THRESHOLD,         /**< Event when the analog input-channel reading is above the high threshold*/
    LOW_THRESHOLD,          /**< Event when the analog input-channel reading is below the low threshold*/
    IN_BAND,                /**< Event when the analog input-channel reading enters the band defined by the low-high thresholds*/
    STEADY_IN_HIGH,         /**< Event when the input-channel has been kept on high (or above the high threshold) for the specified time .*/
    STEADY_IN_LOW,          /**< Event when the input-channel has been kept on low (or below the low threshold) for the specified time .*/
    STEADY_IN_BAND,         /**< Event when the analog input-channel has remained within the band for the specified time .*/
    DELTA,                  /**< Event when the difference of the last and latest reading of an analog input channel is greater than the defined delta*/
    STEP_UP,                /**< Event on step reading of the analog-input channel*/
    STEP_DOWN,              /**< Event on step reading of the analog-input channel*/
    /*! @cond  */
    MAX_EVENTS,
    STEP = STEP_UP
    /*! @endcond  */
} qEvent_t;

/**
* @brief An enum class to define the types of input channels
*/
typedef enum qType_t{
    DIGITAL_CHANNEL,            /**< Digital input channel.*/
    ANALOG_CHANNEL,             /**< Analog input channel.*/
}qType_t;


typedef int qDigitalValue_t;
typedef uint32_t qAnalogValue_t;



/**
* @brief A pointer to the  wrapper function that reads the specific
* digital input-channel
*
* Prototype: @code qDigitalValue_t readerFcn( uint8_t channelNumber ) @endcode
*/
typedef qDigitalValue_t (*qDigitalReaderFcn_t)( uint8_t );



/**
* @brief A pointer to the  wrapper function that reads the specific
* analog input-channel
*
* Prototype: @code qAnalogValue_t readerFcn( uint8_t channelNumber ) @endcode
*/
typedef qAnalogValue_t (*qAnalogReaderFcn_t)( uint8_t );




typedef struct qChannel_t qChannel_t;

/**
* @brief A pointer to the input-channel event callback
*
* Prototype: @code void xCallback( input::channel& c ) @endcode
*/
typedef void (*qEventCallback_t) (qChannel_t *channel);


/**
 * @brief A pointer to the  wrapper function 
 * 
 * Prototype: @code void updateReading( qBool_t act ) @endcode
 */
typedef void (*qUpdateReading_t)( qBool_t );

/**
 * @brief A pointer to the  wrapper function 
 * 
 * Prototype: @code void evaluateState() @endcode
 */
typedef void (*qEvaluateState_t)( void );


/**
 * @brief A pointer to the  wrapper function 
 * 
 * Prototype: @code qBool_t isValidConfig() @endcode
 */
typedef qBool_t (*qIsValidConfig_t)( void );


/**
 * @brief A pointer to the  wrapper function 
 * 
 * Prototype: @code void setInitalState() @endcode
 */
typedef void (*qSetInitalState_t)( void );

/**
 * @brief A pointer to the  wrapper function 
 * 
 * Prototype: @code void dispatchEvent(qEvent_t e) @endcode
 */
typedef void (*qDispatchEvent_t)( qEvent_t );

/* inline void dispatchEvent( qEvent_t ) 
{
    lastEvent = e;  --> event = e
    callback( *this );  --> callback = dispatchEvent
}*/

/**
* @brief Get the channel type.
* @return The channel type.
* Prototype: @code qType_t getType( void ) @endcode
*/
typedef qType_t (*qGetType_t)( void );


/**
* @brief Retrieves the last event for the given input channel.
* @return @c The last input-channel event.
* Prototype: @code qEvent_t getEvent( void ) @endcode
*/
typedef qEvent_t (*qGetEvent_t)( void );


/**
* @brief Set the callback function when event are detected on the
* input input channel.
* @param[in] cb The callback function
* Prototype: @code qBool_t setCallback( const qEventCallback_t cb ) @endcode
*/
typedef qBool_t (*qSetCallback_t)( const qEventCallback_t );



/**
* @brief Set/Change the channel(pin) number.
* @param[in] inputChannel The specified channel number (pin) to read.
* @return @c true on success. Otherwise @c false.
* Prototype: @code qBool_t setChannel( const uint8_t ich ) @endcode
*/
typedef qBool_t (*qSetChannel_t)( const uint8_t );

/**
* @brief Get the channel(pin) number.
* @return The channel(pin) number.
* Prototype: @code uint8_t getChannel( void)  @endcode
*/
typedef uint8_t (*qGetChannel_t)( void );


/**
* @brief Set the channel user-data.
* @param[in] pUserData A pointer to the user-data
* Prototype: @code void setUserData( void* pUserData)  @endcode
*/
typedef void (*qSetUserData_t)( void*  );

/**
* @brief Get the channel user-data.
* @return A pointer to the user-data
* Prototype: @code void* getUserData( void)  @endcode
*/
typedef void* (*qGetUserData_t)( void );

/**
* @brief Check if the channel value is shared with other channel
* with the same (pin) number.
* @return @c true if shared. Otherwise @c false.
* Prototype: @code qBool_t isShared( void)  @endcode
*/
typedef qBool_t (*qIsShared_t)( void );

/**
* @brief Set the timeout for the specified event.
* @param[in] e The event where the timeout will be set.
* @param[in] t The value of the timeout.
* @return @c true on success. Otherwise @c false.
* Prototype: 
*     @code 
*     qBool_t setTime( const qEvent_t e, const qClock_t t)
*     @endcode
*/
typedef qBool_t (*qSetTime_t)( const qEvent_t , const qClock_t );


/**
* @brief Set the parameter for the specified event.
* @param[in] e The event where the parameter will be set.
* @param[in] p The value of the parameter.
* @return @c true on success. Otherwise @c false.
* Prototype:
*   @code
*   qBool_t setParameter( const qEvent_t e, const qAnalogValue_t p )
*   @endcode
*/
typedef qBool_t (*qSetParameter_t)( const qEvent_t e, const qAnalogValue_t p);

/**
* @brief Get pulsation count for the digital input.
* @note No valid on analog inputs
* @return The current pulsation count.
* Prototype: @code uint8_t getCount( void)  @endcode
*/
typedef uint8_t (*qGetCount_t)( void );

/*! @cond  */
/**
* Prototype: @code qBool_t setDigitalReader( qDigitalReaderFcn_t r) @endcode
*/
typedef qBool_t (*qSetDigitalReader_t)( qDigitalReaderFcn_t );
/**
* Prototype: @code qBool_t setAnalogReader( qAnalogReaderFcn_t r)  @endcode
*/
typedef qBool_t (*qSetAnalogReader_t)( qAnalogReaderFcn_t );
/*! @endcond  */

/**
* @brief
* @note
* Prototype: @code uint8_t unShare_t( void)  @endcode
*/
typedef qBool_t (*qUnShare_t)( void );



typedef struct qChannel_t {
    qList_Node_t node;
    qEvent_t lastEvent;
    uint8_t number;
    void *userData;

    qEventCallback_t  callback;
    qUpdateReading_t  updateReading;
    qEvaluateState_t  evaluateState;
    qIsValidConfig_t  isValidConfig;
    qSetInitalState_t setInitalState;
    qDispatchEvent_t  dispatchEvent;
    qGetType_t getType;
    qGetEvent_t getEvent;
    qSetCallback_t setCallback;


    qSetChannel_t   setChannel;
    qGetChannel_t   getChannel;
    qSetUserData_t  setUserData;
    qGetUserData_t  getUserData;
    qIsShared_t     isShared;
    qSetTime_t      setTime;
    qSetParameter_t setParameter;
    qGetCount_t     getCount;
    qSetDigitalReader_t setDigitalReader;
    qSetAnalogReader_t  setAnalogReader;
    qUnShare_t unShare;

    qClock_t tChange; //0U
    qClock_t tSteadyHigh; // 0xFFFFFFFFU ;
    qClock_t tSteadyLow;  // 0xFFFFFFFFU ;

} qChannel_t;


#define NULL_CHANNELS_INITIALIZATION \
        {\
            NULL, NULL, NULL, \
            NONE, 0, NULL, \
            NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, \
            NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,\
            0U, 0xFFFFFFFFU, 0xFFFFFFFFU \
        }



//typedef void (*qChannelStateFcn_t)(qDigitalChannel_t *);

typedef struct _qDigitalChannel_t {
    qChannel_t channel;
    
    qDigitalValue_t value;
    qDigitalValue_t *ptrValue;
    qDigitalReaderFcn_t reader;
    //qChannelStateFcn_t channelState;
    void (*channelStateFcn)(struct _qDigitalChannel_t *);
    qBool_t negate;
    qClock_t pulsationInterval;//250U
    uint8_t pulsationCount;

    void (*fallingEdgeStateFcn)( struct _qDigitalChannel_t * );
    void (*risingEdgeStateFcn)( struct _qDigitalChannel_t * );
    void (*steadyInHighStateFcn)( struct _qDigitalChannel_t * );
    void (*steadyInLowStateFcn)( struct _qDigitalChannel_t * );

} qDigitalChannel_t;

#define NULL_DIGITAL_CHANNELS_INITIALIZATION \
    {\
        NULL_CHANNELS_INITIALIZATION, \
        0, NULL , NULL, NULL, qFalse, 250, 0, \
        NULL, NULL, NULL, NULL \
    }

typedef struct _qAnalogChannel_t {
    qChannel_t channel;
    
    qAnalogValue_t value;
    qAnalogValue_t *ptrValue;
    qAnalogReaderFcn_t reader;
    //qChannelStateFcn_t channelState;
    void (*channelStateFcn)(struct _qAnalogChannel_t *);
    qAnalogValue_t high; // 800U
    qAnalogValue_t low; //200U
    qAnalogValue_t lastStep; //0
    qAnalogValue_t lastSampled; //0
    qAnalogValue_t delta; //0xFFFFFFFFU
    qAnalogValue_t step; //0xFFFFFFFFU
    qAnalogValue_t hysteresis; //20U
    qClock_t tSteadyBand; //0xFFFFFFFFU

    void (*lowThresholdStateFcn)( struct _qAnalogChannel_t * );
    void (*highThresholdStateFcn)( struct _qAnalogChannel_t * );
    void (*inBandStateFcn)( struct _qAnalogChannel_t * );
    void (*steadyInHighStateFcn)( struct _qAnalogChannel_t * );
    void (*steadyInLowStateFcn)( struct _qAnalogChannel_t * );
    void (*steadyInBandStateFcn)( struct _qAnalogChannel_t * );
} qAnalogChannel_t;

#define NULL_ANALOG_CHANNELS_INITIALIZATION \
    {\
        NULL_CHANNELS_INITIALIZATION, \
        0, NULL , NULL, NULL, 800, 200, 0, 0,\
        0xFFFFFFFFU, 0xFFFFFFFFU, 20U, 0xFFFFFFFFU,\
        NULL, NULL, NULL, NULL, NULL, NULL \
    }
    

#ifdef __cplusplus
}
#endif

#endif
