/*!
 * @file qresponse.h
 * @author J. Camilo Gomez C.
 * @version 1.23
 * @note This file is part of the QuarkTS distribution.
 * @brief API to simplify the handling of requested responses from terminal interfaces.
 **/
#ifndef QRESPONSE_H
    #define QRESPONSE_H

    #include "qtypes.h"
    #include "qstimers.h"
    #include "qioutils.h"

    #include <string.h>

    #ifdef __cplusplus
    extern "C" {
    #endif

    #ifndef Q_RESPONSE_HANDLER
        #define Q_RESPONSE_HANDLER      ( 1 )
    #endif

    /** @addtogroup  qresponse Response handler
    * @brief API to simplify the handling of requested responses from terminal interfaces.
    *  @{
    */

    /** 
    * @brief A Response Handler object.
    * @note Do not access any member of this structure directly. 
    */
    typedef struct{
        /*! @cond PRIVATE */
        struct _qResponse_Private_s{
            char *Pattern2Match;                /*< Points to the storage area provided by the user to hold the match requested response. */
            qSTimer_t timeout;                  /*< The timeout used to wait the requested response. */
            size_t MaxStrLength;                /*< The size of the storage area. */
            size_t PatternLength;               /*< The length of the current response request.*/
            volatile size_t MatchedCount;       /*< To hold the current number of response matches. */
            volatile qBool_t ResponseReceived;  /*< A flag that indicates when the response matches the request. */
        }qPrivate;
        /*! @endcond PRIVATE */
    }qResponse_t;

    /**
    * @brief Initialize the instance of the response handler object
    * @param obj A pointer to the Response Handler object.
    * @param xLocBuff A pointer to the memory block where the desired response will remain.
    * @param nMax The size of <b>xLocBuff</b>
    * @return none.
    */ 
    void qResponse_Setup( qResponse_t * const obj, char *xLocBuff, size_t nMax ); 

    /**
    * @brief Reset the Response Handler
    * @param obj A pointer to the Response Handler object.
    * @return none.
    */     
    void qResponse_Reset( qResponse_t * const obj );

    /**
    * @brief Non-Blocking Response check
    * @param obj A pointer to the Response Handler object.
    * @param Pattern The data checked in the receiver ISR
    * @param n The length of the data pointer by <b>Pattern</b> 
    * (if Pattern is string, set <b>n</b> to 0 to auto-compute the length)
    * @return  qTrue if there is a response acknowledge, otherwise returns qFalse.
    */     
    qBool_t qResponse_Received( qResponse_t * const obj, const char *Pattern, size_t n );
    
    /**
    * @brief Non-Blocking Response check with timeout
    * @param obj A pointer to the Response Handler object.
    * @param Pattern The data checked in the receiver ISR
    * @param n The length of the data pointer by <b>Pattern</b> 
    * (if Pattern is string, set <b>n</b> to 0 to auto-compute the length)
    * @param t The timeout value given in seconds
    * @return qTrue if there is a response acknowledge, qTimeoutReached if timeout t expires otherwise returns qFalse
    */      
    qBool_t qResponse_ReceivedWithTimeout( qResponse_t * const obj, const char *Pattern, size_t n, qTime_t t );
    
    /**
    * @brief ISR receiver for the response handler
    * @param obj A pointer to the Response Handler object.
    * @param rxchar The byte-data from the receiver 
    * @return  qTrue when the Response handler match the request from "qResponseReceived"
    */      
    qBool_t qResponse_ISRHandler( qResponse_t * const obj, const char rxchar );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
