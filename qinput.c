#include "include/qinput.h"

#define DEFAULT_DIGITAL_CHANNELS_PTR_FUNCTIONS \
            digitalXCallback, digitalUpdateReading, digitalEvaluateState, \
            digitalIsValidConfig, digitalSetInitalState, digitalDispatchEvent, \
            digitalGetType, digitalGetEvent, digitalSetCallback,\
            digitalSetChannel, digitalGetChannel, digitalSetUserData,\
            digitalGetUserData, digitalIsShared , digitalSetTime, \
            digitalSetParameter, digitalGetCount, digitalSetReader, NULL \
        

#define DEFAULT_DIGITAL_CHANNELS_INITIALIZATION \
    {\
        NULL, NULL, NULL, \
        NONE, 0, NULL, \
        DEFAULT_DIGITAL_CHANNELS_PTR_FUNCTIONS , \
        0U, 0xFFFFFFFFU, 0xFFFFFFFFU \
    }


#define DEFAULT_ANALOGL_CHANNELS_PTR_FUNCTIONS \
        analogXCallback, analogUpdateReading, analogEvaluateState, \
        analogIsValidConfig, analogSetInitalState, analogDispatchEvent, \
        analogGetType, analogGetEvent, analogSetCallback, \
        analogSetChannel, analogGetChannel, analogSetUserData,\
        analogGetUserData, analogIsShared , analogSetTime, \
        analogSetParameter, analogGetCount, NULL, analogSetReader \
    

#define DEFAULT_ANALOG_CHANNELS_INITIALIZATION \
    {\
        NULL, NULL, NULL, \
        NONE, 0, NULL, \
        DEFAULT_ANALOGL_CHANNELS_PTR_FUNCTIONS , \
        0U, 0xFFFFFFFFU, 0xFFFFFFFFU \
    }


qChannel_t channels = NULL_CHANNELS_INITIALIZATION;
qDigitalChannel_t digitalChannels = NULL_CHANNELS_INITIALIZATION;
qAnalogChannel_t  analogChannels = NULL_CHANNELS_INITIALIZATION;

//----------------------------------------------------
static void analogXCallback( qChannel_t *c ) {

}

static void analogUpdateReading( qBool_t act ) {

}

static void analogEvaluateState() {

}

static qBool_t analogIsValidConfig() {

    return qTrue;
}

static void analogSetInitalState() {

}

static void analogDispatchEvent(qEvent_t e) {
    analogChannels.channel.lastEvent = e;
}


static qType_t analogGetType( void ) {
    return DIGITAL_CHANNEL;
}

static qEvent_t analogGetEvent( void ) {
    return analogChannels.channel.lastEvent;
}

static qBool_t analogSetCallback( const qEventCallback_t cb ) {
    analogChannels.channel.callback = cb;
    return (cb != analogChannels.channel.callback);
}

static qBool_t analogSetChannel( const uint8_t inputChannel ) {
    qBool_t retValue = qFalse;

    if ( inputChannel < 32U ) {
        analogChannels.channel.number = inputChannel;
        retValue = qTrue;
    }

    return retValue;
}

static uint8_t analogGetChannel( void) {
    return analogChannels.channel.number;
}

static void analogSetUserData( void* pUserData) {
    analogChannels.channel.userData = pUserData;
}

static void* analogGetUserData( void) {
    return analogChannels.channel.userData;
}

static qBool_t analogIsShared( void) {
    return qTrue;
}

static qBool_t analogSetTime( const qEvent_t e, const qClock_t t) {
    return qTrue;
}

static qBool_t analogSetParameter( const qEvent_t e, const qAnalogValue_t p ) {
    return qTrue;
}

static uint8_t analogGetCount( void) {
    return 0;
}

static qBool_t analogSetReader( qAnalogReaderFcn_t r) {
    return qTrue;
}

//------------------------------------------------------------
static void digitalXCallback( qChannel_t *c ) {

}

static void digitalUpdateReading( qBool_t act ) {

}

static void digitalEvaluateState() {

}

static qBool_t digitalIsValidConfig() {

    return qTrue;
}

static void digitalSetInitalState() {

}

static void digitalDispatchEvent(qEvent_t e) {
    digitalChannels.channel.lastEvent = e;
}


static qType_t digitalGetType( void ) {
    return DIGITAL_CHANNEL;
}

static qEvent_t digitalGetEvent( void ) {
    return digitalChannels.channel.lastEvent;
}

static qBool_t digitalSetCallback( const qEventCallback_t cb ) {
    digitalChannels.channel.callback = cb;
    return (cb != digitalChannels.channel.callback);
}

static qBool_t digitalSetChannel( const uint8_t inputChannel ) {
    qBool_t retValue = qFalse;

    if ( inputChannel < 32U ) {
        digitalChannels.channel.number = inputChannel;
        retValue = qTrue;
    }

    return retValue;
}

static uint8_t digitalGetChannel( void) {
    return digitalChannels.channel.number;
}

static void digitalSetUserData( void* pUserData) {
    digitalChannels.channel.userData = pUserData;
}

static  void* digitalGetUserData( void) {
    return digitalChannels.channel.userData;
}

static qBool_t digitalIsShared( void) {
    return qTrue;
}

static qBool_t digitalSetTime( const qEvent_t e, const qClock_t t) {
    return qTrue;
}

static qBool_t digitalSetParameter( const qEvent_t e, const qAnalogValue_t p ) {
    return qTrue;
}

static uint8_t digitalGetCount( void) {
    return 0;
}

static qBool_t digitalSetReader( qDigitalReaderFcn_t r) {
    return qTrue;
}


/**
 * @brief This function should be invoked at the begining
 */
void qInputInitialize() {

    const qDigitalChannel_t _digitalChannels =
                                DEFAULT_DIGITAL_CHANNELS_INITIALIZATION;
    const qAnalogChannel_t  _analogChannels =
                                DEFAULT_ANALOG_CHANNELS_INITIALIZATION;

    digitalChannels = _digitalChannels;
    analogChannels = _analogChannels;

}


void lala () {

    digitalChannels.channel.callback(&channels);
    analogChannels.channel.callback(&channels);

    analogChannels.channel.dispatchEvent(LOW_THRESHOLD);
    

}