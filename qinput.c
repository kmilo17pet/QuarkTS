#include "include/qinput.h"

#define DEFAULT_DIGITAL_CHANNELS_FUNCTIONS_PTR \
            digitalXCallback, digitalUpdateReading, digitalEvaluateState, \
            digitalIsValidConfig, digitalSetInitalState, digitalDispatchEvent, \
            digitalGetType, digitalGetEvent, digitalSetCallback,\
            digitalSetChannel, digitalGetChannel, digitalSetUserData,\
            digitalGetUserData, digitalIsShared , digitalSetTime, \
            digitalSetParameter, digitalGetCount, digitalSetReader, NULL, \
            digitalUnShare \

#define DEFAULT_DIGITAL_INTERNAL_FUNCTIONS_PTR \
        fallingEdgeState, risingEdgeState, digitalSteadyInHighState, digitalSteadyInLowState\

#define DEFAULT_DIGITAL_CHANNELS_INITIALIZATION \
    {\
        NULL, NULL, NULL, \
        QINPUT_NONE, 0, NULL, \
        DEFAULT_DIGITAL_CHANNELS_FUNCTIONS_PTR , \
        0U, 0xFFFFFFFFU, 0xFFFFFFFFU, \
        0, NULL , NULL, NULL, qFalse, 250, 0, \
        DEFAULT_DIGITAL_INTERNAL_FUNCTIONS_PTR \
    }


#define DEFAULT_ANALOG_CHANNELS_FUNCTIONS_PTR \
        analogXCallback, analogUpdateReading, analogEvaluateState, \
        analogIsValidConfig, analogSetInitalState, analogDispatchEvent, \
        analogGetType, analogGetEvent, analogSetCallback, \
        analogSetChannel, analogGetChannel, analogSetUserData,\
        analogGetUserData, analogIsShared , analogSetTime, \
        analogSetParameter, analogGetCount, NULL, analogSetReader, \
        analogUnShare \

#define DEFAULT_ANALOG_INTERNAL_FUNCTIONS_PTR \
        lowThresholdState, highThresholdState, inBandState, analogSteadyInHighState, \
        analogSteadyInLowState, steadyInBandState \

#define DEFAULT_ANALOG_CHANNELS_INITIALIZATION \
    {\
        NULL, NULL, NULL, \
        QINPUT_NONE, 0, NULL, \
        DEFAULT_ANALOG_CHANNELS_FUNCTIONS_PTR , \
        0U, 0xFFFFFFFFU, 0xFFFFFFFFU, \
        0, NULL , NULL, NULL, 800, 200, 0, 0,\
        0xFFFFFFFFU, 0xFFFFFFFFU, 20U, 0xFFFFFFFFU,\
        DEFAULT_ANALOG_INTERNAL_FUNCTIONS_PTR \
    }

#define DEFAULT_WATCHER_FUNCTIONS_PTR \
  addChannel, addCallback, addCallbackDigital, addCallbackAnalog, remove \

#define DEFAULT_WATCHER_INITIALIZATION \
    {\
        NULL, NULL, NULL, \
        NULL , \
        NULL, NULL, NULL, NULL, NULL, 0,\
        NULL, NULL, NULL, NULL, NULL, 0,\
        100, 100 \
        NULL, NULL, NULL, NULL, NULL, NULL, NULL \
    }

qChannel_t channels = NULL_CHANNELS_INITIALIZATION; // skipcq: CXX-W2009

// skipcq: CXX-W2009
qDigitalChannel_t digitalChannels =
                    NULL_DIGITAL_CHANNELS_INITIALIZATION;

// skipcq: CXX-W2009
qAnalogChannel_t  analogChannels =
                    NULL_ANALOG_CHANNELS_INITIALIZATION;

qWatcher_t watcher; // skipcq: CXX-W2009
//----------------------------------------------------
static void analogXCallback( qChannel_t *c ) {

}

static void analogUpdateReading( qBool_t act ) {
    analogChannels.value = ( analogChannels.channel.isShared() ) ?
        analogChannels.ptrValue[ 0 ] : analogChannels.reader( analogChannels.channel.number );

    const qAnalogValue_t currentStep = analogChannels.value/analogChannels.step;
    if ( currentStep != analogChannels.lastStep ) {
        qAnalogValue_t diff;
        qInput_Event_t dir;

        if ( currentStep > analogChannels.lastStep ) {
            diff = currentStep - analogChannels.lastStep;
            dir = QINPUT_STEP_UP;
        }
        else {
            diff = analogChannels.lastStep - currentStep;
            dir = QINPUT_STEP_DOWN;
        }
        for ( qAnalogValue_t i = 0; i < diff; ++i ) {
            analogChannels.channel.dispatchEvent( dir );
        }
        analogChannels.lastStep = currentStep;
    }

    if ( act ) {
        const qAnalogValue_t diff =
            ( analogChannels.value > analogChannels.lastSampled ) ?
                analogChannels.value - analogChannels.lastSampled  :
                    analogChannels.lastSampled - analogChannels.value;

        if ( diff >= analogChannels.delta ) {
            analogChannels.channel.dispatchEvent( QINPUT_DELTA );
        }
        analogChannels.lastSampled = analogChannels.value;
    }
}

static void analogEvaluateState() {
    //channelState( *this );
    //TODO: is this good?
    analogChannels.channelStateFcn(&analogChannels);
}

static qBool_t analogIsValidConfig() {

    return ( analogChannels.high - analogChannels.low ) >
                analogChannels.hysteresis;
}

static void analogSetInitalState() {
    const qAnalogValue_t val = ( NULL != analogChannels.reader ) ?
        analogChannels.reader( analogChannels.channel.number ) : 0U;

    if ( val > analogChannels.high ) {
        analogChannels.channelStateFcn = analogChannels.highThresholdStateFcn;
    }
    else if ( val < analogChannels.low ) {
        analogChannels.channelStateFcn = analogChannels.lowThresholdStateFcn;
    }
    else {
        analogChannels.channelStateFcn = analogChannels.inBandStateFcn;
    }
    analogChannels.lastStep = val/analogChannels.step;
    analogChannels.lastSampled = val;
}

static void analogDispatchEvent(qInput_Event_t e) {
    analogChannels.channel.lastEvent = e;
}


static qType_t analogGetType( void ) {
    return ANALOG_CHANNEL;
}

static qInput_Event_t analogGetEvent( void ) {
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
    return ( &analogChannels.value != analogChannels.ptrValue );
}

static qBool_t analogSetTime( const qInput_Event_t e, const qClock_t t) {
    qBool_t retValue = qTrue;

    if ( t > 0U ) {
        switch( e ) {
            case QINPUT_STEADY_IN_BAND:
                analogChannels.tSteadyBand = (qClock_t)t;
                break;
            case QINPUT_STEADY_IN_HIGH:
                analogChannels.channel.tSteadyHigh = (qClock_t)t;
                break;
            case QINPUT_STEADY_IN_LOW:
                analogChannels.channel.tSteadyLow = (qClock_t)t;
                break;
            default:
                retValue = qFalse;
                break;
        }
    }
    else {
        retValue = qFalse;
    }

    return retValue;
}

static qBool_t analogSetParameter( const qInput_Event_t e, const qAnalogValue_t p ) {
    qBool_t retValue = qTrue;

    switch( e ) {
        case QINPUT_HIGH_THRESHOLD:
            analogChannels.high = p;
            break;
        case QINPUT_LOW_THRESHOLD:
            analogChannels.low = p;
            break;
        case QINPUT_IN_BAND:
            analogChannels.hysteresis = p;
            break;
        case QINPUT_DELTA:
            analogChannels.delta = p;
            break;
        case QINPUT_STEP_UP:
        case QINPUT_STEP_DOWN: // skipcq: CXX-C1001
            analogChannels.step = p;
            break;
        default:
            retValue = qFalse;
            break;
    }

    return retValue;
}

static uint8_t analogGetCount( void) {
    return 0;
}

static qBool_t analogSetReader( qAnalogReaderFcn_t r) {
    analogChannels.reader = r;
    return qTrue;
}

static uint8_t analogUnShare( void) {
    analogChannels.ptrValue = &analogChannels.value;
    return qTrue;
}

static void lowThresholdState( struct _qAnalogChannel_t * c ) {
    const qClock_t CURRENT_TIME = qClock_GetTick();

    if ( c->value > c->high ) {
        c->channelStateFcn = analogChannels.highThresholdStateFcn;
        c->channel.dispatchEvent( QINPUT_HIGH_THRESHOLD );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = CURRENT_TIME;
    }
    else if ( c->value > ( c->low + c->hysteresis ) ) {
        c->channelStateFcn = analogChannels.inBandStateFcn;
        c->channel.dispatchEvent( QINPUT_IN_BAND );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = CURRENT_TIME;
    }
    else {
        /*Nothing to do here*/
    }

    if ( ( CURRENT_TIME - c->channel.tChange ) > c->channel.tSteadyLow ) {
        c->channelStateFcn = analogChannels.steadyInLowStateFcn;
        c->channel.dispatchEvent( QINPUT_STEADY_IN_LOW );
        c->channel.tChange = CURRENT_TIME;
    }
}
static void highThresholdState( struct _qAnalogChannel_t * c ) {
    const qClock_t CURRENT_TIME = qClock_GetTick();

    if ( c->value < c->low ) {
        c->channelStateFcn = analogChannels.lowThresholdStateFcn;
        c->channel.dispatchEvent( QINPUT_LOW_THRESHOLD );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = CURRENT_TIME;
    }
    else if ( c->value < ( c->high - c->hysteresis ) ) {
        c->channelStateFcn = analogChannels.inBandStateFcn;
        c->channel.dispatchEvent( QINPUT_IN_BAND );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = CURRENT_TIME;
    }
    else {
        /*Nothing to do here*/
    }

    if ( ( CURRENT_TIME - c->channel.tChange ) > c->channel.tSteadyHigh ) {
        c->channelStateFcn = analogChannels.steadyInHighStateFcn;
        c->channel.dispatchEvent( QINPUT_STEADY_IN_HIGH );
        c->channel.tChange = CURRENT_TIME;
    }
}
static void inBandState( struct _qAnalogChannel_t * c ) {
    const qClock_t CURRENT_TIME = qClock_GetTick();

    if ( c->value > c->high ) {
        c->channelStateFcn = analogChannels.highThresholdStateFcn;
        c->channel.dispatchEvent( QINPUT_HIGH_THRESHOLD );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = CURRENT_TIME;
    }
    else if ( c->value < c->low ) {
        c->channelStateFcn = analogChannels.lowThresholdStateFcn;
        c->channel.dispatchEvent( QINPUT_LOW_THRESHOLD );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = CURRENT_TIME;
    }
    else {
        /*Nothing to do here*/
    }

    if ( ( CURRENT_TIME - c->channel.tChange ) > c->tSteadyBand ) {
        c->channelStateFcn = analogChannels.steadyInBandStateFcn;
        c->channel.dispatchEvent( QINPUT_STEADY_IN_BAND );
        c->channel.tChange = CURRENT_TIME;
    }
}
static void analogSteadyInHighState( struct _qAnalogChannel_t * c ) {
    if ( c->value < c->low ) {
        c->channelStateFcn = analogChannels.lowThresholdStateFcn;
        c->channel.dispatchEvent( QINPUT_LOW_THRESHOLD );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = qClock_GetTick();
    }
    else if ( c->value < ( c->high - c->hysteresis ) ) {
        c->channelStateFcn = analogChannels.inBandStateFcn;
        c->channel.dispatchEvent( QINPUT_IN_BAND );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = qClock_GetTick();
    }
    else {
        /*Nothing to do here*/
    }
}
static void analogSteadyInLowState( struct _qAnalogChannel_t * c ) {
    if ( c->value > c->high ) {
        c->channelStateFcn = analogChannels.highThresholdStateFcn;
        c->channel.dispatchEvent( QINPUT_HIGH_THRESHOLD );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = qClock_GetTick();
    }
    else if ( c->value > ( c->low + c->hysteresis ) ) {
        c->channelStateFcn = analogChannels.inBandStateFcn;
        c->channel.dispatchEvent( QINPUT_IN_BAND );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = qClock_GetTick();
    }
    else {
        /*Nothing to do here*/
    }
}
static void steadyInBandState( struct _qAnalogChannel_t * c ) {
    if ( c->value > c->high ) {
        c->channelStateFcn = analogChannels.highThresholdStateFcn;
        c->channel.dispatchEvent( QINPUT_HIGH_THRESHOLD );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = qClock_GetTick();
    }
    else if ( c->value < c->low ) {
        c->channelStateFcn = analogChannels.lowThresholdStateFcn;
        c->channel.dispatchEvent( QINPUT_LOW_THRESHOLD );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = qClock_GetTick();
    }
    else {
        /*Nothing to do here*/
    }
}

//------------------------------------------------------------
static void digitalXCallback( qChannel_t *c ) {

}

static void digitalUpdateReading( qBool_t act ) {
    qDigitalValue_t sample =
        digitalChannels.reader(digitalChannels.channel.number);

    if ( digitalChannels.negate ) {
        sample = !sample;
    }
    digitalChannels.value = sample;
}

static void digitalEvaluateState() {
    //channelStateFcn =
    //TODO: is this good?
    digitalChannels.channelStateFcn(&digitalChannels);
}

static qBool_t digitalIsValidConfig() {

    return qTrue;
}

static void digitalSetInitalState() {
    qDigitalValue_t val =
    ( NULL != digitalChannels.reader ) ?
        digitalChannels.reader( digitalChannels.channel.number ) : -1;

    if ( digitalChannels.negate ) {
        val = !val;
    }
    digitalChannels.channelStateFcn =
        ( 0 == val ) ? digitalChannels.fallingEdgeStateFcn
            : digitalChannels.risingEdgeStateFcn;
}

static void digitalDispatchEvent(qInput_Event_t e) {
    digitalChannels.channel.lastEvent = e;
}


static qType_t digitalGetType( void ) {
    return DIGITAL_CHANNEL;
}

static qInput_Event_t digitalGetEvent( void ) {
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
    return ( &digitalChannels.value != digitalChannels.ptrValue );
}

static qBool_t digitalSetTime( const qInput_Event_t e, const qClock_t t) {
    qBool_t retValue = qTrue;

    if ( t > 0U ) {
        switch( e ) {
            case QINPUT_PULSATION_DOUBLE:
            case QINPUT_PULSATION_TRIPLE: // skipcq: CXX-C1001
            case QINPUT_PULSATION_MULTI:  // skipcq: CXX-C1001
                digitalChannels.pulsationInterval = (qClock_t)t;
                break;
            case QINPUT_STEADY_IN_HIGH:
                digitalChannels.channel.tSteadyHigh = (qClock_t)t;
                break;
            case QINPUT_STEADY_IN_LOW:
                digitalChannels.channel.tSteadyLow = (qClock_t)t;
                break;
            default:
                retValue = qFalse;
                break;
        }
    }
    else {
        retValue = qFalse;
    }

    return retValue;
}

static qBool_t digitalSetParameter( const qInput_Event_t e, const qAnalogValue_t p ) {
    (void)e;
    (void)p;
    return qFalse;
}

static uint8_t digitalGetCount( void) {
    return digitalChannels.pulsationCount;
}

static qBool_t digitalSetReader( qDigitalReaderFcn_t r) {
    digitalChannels.reader = r;
    return qTrue;
}

static uint8_t digitalUnShare( void) {
    digitalChannels.ptrValue = &digitalChannels.value;
}

static void fallingEdgeState( struct _qDigitalChannel_t * c ) {
    const qClock_t CURRENT_TIME = qClock_GetTick();

    if ( 0 != c->value ) {
        c->channelStateFcn = digitalChannels.risingEdgeStateFcn;
        c->channel.dispatchEvent( QINPUT_RISING_EDGE );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        if ( ( CURRENT_TIME - c->channel.tChange ) > c->pulsationInterval ) {
            c->pulsationCount = 0U;
        }
        c->channel.tChange = CURRENT_TIME;
    }
    if ( ( CURRENT_TIME - c->channel.tChange ) > c->channel.tSteadyLow ) {
        c->channelStateFcn = digitalChannels.steadyInLowStateFcn;
        c->channel.dispatchEvent( QINPUT_STEADY_IN_LOW );
        c->channel.tChange = CURRENT_TIME;
    }
}
static void risingEdgeState( struct _qDigitalChannel_t * c ) {
    const qClock_t CURRENT_TIME = qClock_GetTick();

    if ( 0 == c->value ) {
        c->channelStateFcn = digitalChannels.fallingEdgeStateFcn;
        c->channel.dispatchEvent( QINPUT_FALLING_EDGE );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        if ( ( CURRENT_TIME - c->channel.tChange ) <= c->pulsationInterval ) {
            ++c->pulsationCount;
        }
        c->channel.tChange = CURRENT_TIME;

        switch ( c->pulsationCount ) {
            case 0 : case 1: break;
            case 2:
                c->channel.dispatchEvent( QINPUT_PULSATION_DOUBLE );
                break;
            case 3:
                c->channel.dispatchEvent( QINPUT_PULSATION_TRIPLE );
                break;
            default:
                c->channel.dispatchEvent( QINPUT_PULSATION_MULTI );
                break;
        }
    }
    if ( ( CURRENT_TIME - c->channel.tChange ) > c->channel.tSteadyHigh ) {
        c->channelStateFcn = digitalChannels.steadyInHighStateFcn;
        c->channel.dispatchEvent( QINPUT_STEADY_IN_HIGH );
        c->channel.tChange = CURRENT_TIME;
    }
}

static void digitalSteadyInHighState( struct _qDigitalChannel_t * c ) {
    if ( 0 == c->value ) {
        c->channelStateFcn = digitalChannels.fallingEdgeStateFcn;
        c->channel.dispatchEvent( QINPUT_FALLING_EDGE );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = qClock_GetTick();
    }
}

static void digitalSteadyInLowState( struct _qDigitalChannel_t * c ) {
    if ( 0 != c->value ) {
        c->channelStateFcn = digitalChannels.risingEdgeStateFcn;
        c->channel.dispatchEvent( QINPUT_RISING_EDGE );
        c->channel.dispatchEvent( QINPUT_ON_CHANGE );
        c->channel.tChange = qClock_GetTick();
    }
}


static qBool_t addChannel( qChannel_t * c ) {
    qBool_t retValue;
    qList_Iterator_t i;

    if ( DIGITAL_CHANNEL == c->getType() ) {
        (void)c->setDigitalReader( watcher.digitalReader );
        c->setInitalState();
        retValue = qList_Insert( &watcher.digitalChannels, c, QLIST_AT_BACK );
    }
    else {
        (void)c->setAnalogReader( watcher.analogReader );
        (void)c->setInitalState();
        qAnalogChannel_t *chan = (qAnalogChannel_t*)c;
        /* check if channel is shared( same channel number)*/
        for ( i = qList_Begin( &watcher.analogChannels) ;
                    qListIterator_Until( &i, NULL ) ;
                        qListIterator_Forward( &i ) ) {

            qAnalogChannel_t * channelInWatcher =
                                (qAnalogChannel_t *)qListIterator_Get( &i );

            if ( chan->channel.number == channelInWatcher->channel.number ) {
                chan->ptrValue = &channelInWatcher->value;
                break;
            }
        }
        retValue = qList_Insert( &watcher.analogChannels, c, QLIST_AT_BACK );
    }
    c->tChange = qClock_GetTick();

    return retValue;
}

static qBool_t addCallback( qChannel_t *c, qEventCallback_t cb ) {

        (void)c->setCallback( cb );
        return addChannel( c );
}

static qBool_t addCallbackDigital( qChannel_t *c, qDigitalReaderFcn_t fcn, qEventCallback_t cb ) {
        qBool_t retValue;
        (void)c->setCallback( cb );
        retValue = addChannel( c );
        (void)c->setDigitalReader( fcn );
        return retValue;
}

static qBool_t addCallbackAnalog( qChannel_t *c, qAnalogReaderFcn_t fcn, qEventCallback_t cb ) {
        qBool_t retValue;
        (void)c->setCallback( cb );
        retValue = addChannel( c );
        (void)c->setAnalogReader( fcn );
        return retValue;
}

static qBool_t remove( qChannel_t *c ) {
    qList_Iterator_t i;
    qList_t* const channelContainer = c->node.container;
    const qBool_t retValue =  //channelContainer->remove( &c );
        qList_Remove(channelContainer, c, QLIST_AT_BACK) == NULL? qFalse:qTrue;

    (void)c->unShare();

    if ( (ANALOG_CHANNEL == c->getType() ) && !c->isShared() ) { // no side-effects here
        qAnalogValue_t *newPtrVal = NULL;
        /*find the next shared channel*/
        for ( i = qList_Begin( &watcher.analogChannels) ;
                    qListIterator_Until( &i, NULL ) ;
                        qListIterator_Forward( &i ) ) {

            qAnalogChannel_t *channelInList =
                                (qAnalogChannel_t *)qListIterator_Get( &i );

            if ( channelInList->channel.number == c->number ) {
                if ( NULL == newPtrVal ) { /*first shared channel*/
                    newPtrVal = &channelInList->value;
                    channelInList->ptrValue = &channelInList->value;
                }
                else {
                    channelInList->ptrValue = newPtrVal;
                }
            }
        }
    }

    return retValue;
}

/*============================================================================*/
static qBool_t watch( void )
{
    qList_Iterator_t i;
    const qBool_t act = qSTimer_FreeRun(
                            &watcher.waitDebounce, watcher.debounceTime);

    if ( ( qList_Length(&watcher.digitalChannels) > 0U ) && act ) {

        for ( i = qList_Begin( &watcher.digitalChannels) ;
                    qListIterator_Until( &i, NULL ) ;
                        qListIterator_Forward( &i ) ) {

            qChannel_t *c = (qChannel_t *)qListIterator_Get( &i );
            if ( NULL != c->callback ) {
                if ( NULL != watcher.digitalReader ) {
                    c->updateReading( qTrue );
                    c->evaluateState();
                }
                else {
                    c->dispatchEvent( QINPUT_EXCEPTION );
                }
            }
        }
    }

    if ( ( qList_Length(&watcher.analogChannels) > 0U ) > 0U ) {
        for ( i = qList_Begin( &watcher.analogChannels) ;
                qListIterator_Until( &i, NULL ) ;
                    qListIterator_Forward( &i ) ) {

        qChannel_t *c = (qChannel_t *)qListIterator_Get( &i );
            if ( NULL != c->callback ) {
                if ( ( NULL != watcher.analogReader ) && c->isValidConfig() ) { // no side-effects here
                    c->updateReading( act );
                    c->evaluateState();
                }
                else {
                    c->dispatchEvent( QINPUT_EXCEPTION );
                }
            }
        }
    }

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

    const qWatcher_t _watcher ;
    digitalChannels = _digitalChannels;
    analogChannels = _analogChannels;
    watcher = _watcher;
    (void)qList_Initialize( &watcher.digitalChannels );
    (void)qList_Initialize( &watcher.analogChannels );

}


void test () {

    digitalChannels.channel.callback(&channels);
    analogChannels.channel.callback(&channels);

    analogChannels.channel.dispatchEvent(QINPUT_LOW_THRESHOLD);

}
