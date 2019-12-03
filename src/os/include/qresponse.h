/*This file is part of the QuarkTS distribution.*/
#ifndef QRESPONSE_H
    #define QRESPONSE_H

    #include "qtypes.h"
    #include "qstimers.h"

    #include <string.h>

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef struct{
        private_start{
            char *Pattern2Match;                /*< Points to the storage area provided by the user to hold the match requested response. */
            qSTimer_t timeout;                  /*< The timeout used to wait the requested response. */
            size_t MaxStrLength;                /*< The size of the storage area. */
            size_t PatternLength;               /*< The length of the current response request.*/
            volatile size_t MatchedCount;       /*< To hold the current number of response matches. */
            volatile qBool_t ResponseReceived;  /*< A flag that indicates when the response matches the request. */
        }private_end;
    }qResponseHandler_t; 

    #define QRESPONSE_INITIALIZER   {{NULL, 0u, 0u, 0u, qFalse, QSTIMER_INITIALIZER }}

    void qResponseInitialize( qResponseHandler_t * const obj, char *xLocBuff, size_t nMax ); 
    void qResponseReset( qResponseHandler_t * const obj );
    qBool_t qResponseReceived( qResponseHandler_t * const obj, const char *Pattern, size_t n );
    qBool_t qResponseReceivedWithTimeout( qResponseHandler_t * const obj, const char *Pattern, size_t n, qTime_t t );
    qBool_t qResponseISRHandler( qResponseHandler_t * const obj, const char rxchar );

    #ifdef __cplusplus
    }
    #endif

#endif