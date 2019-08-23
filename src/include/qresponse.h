#ifndef QRESPONSE_H
    #define QRESPONSE_H

    #include "qtypes.h"
    #include "qstimers.h"

    #include <string.h>

    typedef struct{
        char *Pattern2Match;
        qSize_t MaxStrLength;
        qSize_t PatternLength;
        volatile qSize_t MatchedCount;
        volatile qBool_t ResponseReceived;
        qSTimer_t timeout;
    }qResponseHandler_t; 

    #define QRESPONSE_INITIALIZER   {NULL, 0u, 0u, 0u, qFalse, QSTIMER_INITIALIZER }

    void qResponseInitialize( qResponseHandler_t * const obj, char *xLocBuff, qSize_t nMax ); 
    void qResponseReset( qResponseHandler_t * const obj );
    qBool_t qResponseReceived( qResponseHandler_t * const obj, const char *Pattern, qSize_t n );
    qBool_t qResponseReceivedWithTimeout( qResponseHandler_t * const obj, const char *Pattern, qSize_t n, qTime_t t );
    qBool_t qResponseISRHandler( qResponseHandler_t * const obj, const char rxchar );

#endif