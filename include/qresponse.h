/*!
 * @file qresponse.h
 * @author J. Camilo Gomez C.
 * @version 1.30
 * @note This file is part of the QuarkTS distribution.
 * @brief API to simplify the handling of requested responses from terminal
 * interfaces.
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

    /** @addtogroup qresponse Response handler
    * @brief API to simplify the handling of requested responses from terminal
    * interfaces.
    *  @{
    */

    /**
    * @brief A Response Handler object.
    * @note Do not access any member of this structure directly.
    */
    typedef struct _qResponse_s { // skipcq: CXX-E2000
        /*! @cond  */
        struct _qResponse_Private_s { // skipcq: CXX-E2000
            char *pattern2Match;                /*< Points to the storage area provided by the user to hold the match requested response. */
            qSTimer_t timeout;                  /*< The timeout used to wait the requested response. */
            size_t maxStrLength;                /*< The size of the storage area. */
            size_t patternLength;               /*< The length of the current response request.*/
            volatile size_t matchedCount;       /*< To hold the current number of response matches. */
            volatile qBool_t responseReceived;  /*< A flag that indicates when the response matches the request. */
        }
        qPrivate;
        /*! @endcond  */
    }
    qResponse_t;

    /**
    * @brief Initialize the instance of the response handler object
    * @param[in] r A pointer to the Response Handler object.
    * @param[in] xLocBuff A pointer to the memory block where the desired
    * response will remain.
    * @param[in] nMax The size of @a xLocBuff
    * @return On success returns #qTrue, otherwise returns #qFalse.
    */
    qBool_t qResponse_Setup( qResponse_t * const r,
                             char *xLocBuff,
                             const size_t nMax );

    /**
    * @brief Reset the Response Handler
    * @param[in] r A pointer to the Response Handler object.
    * @return #qTrue on success. Otherwise returns #qFalse.
    */
    qBool_t qResponse_Reset( qResponse_t * const r );

    /**
    * @brief Non-Blocking Response check
    * @param[in] r A pointer to the Response Handler object.
    * @param[in] pattern The data checked in the receiver ISR
    * @param[in] n The length of the data pointer by @a Pattern
    * (if Pattern is string, set @a n to 0 to auto-compute the length)
    * @return #qTrue if there is a response acknowledge, otherwise returns
    * #qFalse.
    */
    qBool_t qResponse_Received( qResponse_t * const r,
                                const char *pattern,
                                const size_t n );

    /**
    * @brief Non-Blocking Response check with timeout
    * @param[in] r A pointer to the Response Handler object.
    * @param[in] pattern The data checked in the receiver ISR
    * @param[in] n The length of the data pointer by @a Pattern
    * (if @a pattern is string, set @a n to 0 to auto-compute the length)
    * @param[in] t The timeout value given in seconds
    * @return #qTrue if there is a response acknowledge, #qResponseTimeout if
    * timeout expires otherwise returns #qFalse
    */
    qBool_t qResponse_ReceivedWithTimeout( qResponse_t * const r,
                                           const char *pattern,
                                           const size_t n,
                                           const qTime_t t );

    /**
    * @brief ISR receiver for the response handler
    * @param[in] r A pointer to the Response Handler object.
    * @param[in] rxChar The byte-data from the receiver
    * @return #qTrue when the Response handler match the request from
    * qResponse_Received()
    */
    qBool_t qResponse_ISRHandler( qResponse_t * const r,
                                  const char rxChar );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
