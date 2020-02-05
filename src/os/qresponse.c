#include "qresponse.h"

#if ( Q_RESPONSE_HANDLER == 1 )

/*============================================================================*/
/*void qResponse_Setup( qResponse_t * const obj, char *xLocBuff, size_t nMax)

Initialize the instance of the response handler object

Parameters:

    - obj : A pointer to the Response Handler object
    - xLocBuff : A pointer to the memory block where the desired response
                 will remain.
    - nMax : The size of <xLocBuff>
  
*/
void qResponse_Setup( qResponse_t * const obj, char *xLocBuff, size_t nMax ){
    if( NULL != obj ){
        obj->qPrivate.Pattern2Match = xLocBuff;
        obj->qPrivate.MaxStrLength = nMax; 
        qResponse_Reset( obj );
    }
}   
/*============================================================================*/
/*void qResponseInitialize( qResponse_t * const obj )

Reset the Response Handler

Parameters:

    - obj : A pointer to the Response Handler object
  
*/
void qResponse_Reset( qResponse_t * const obj ){
    if( obj != NULL ){
        obj->qPrivate.PatternLength = 0u;
        obj->qPrivate.MatchedCount = 0u;
        obj->qPrivate.ResponseReceived = qFalse;
        qSTimer_Disarm( &obj->qPrivate.timeout );
    }
}
/*============================================================================*/
/*qBool_t qResponse_Received( qResponse_t * const obj, const char *Pattern, size_t n )
 
Non-Blocking Response check

Parameters:

    - obj : A pointer to the Response Handler object
    - Pattern: The data checked in the receiver ISR
    - n : The length of the data pointer by Pattern 
          (if Pattern is string, set n to 0 to auto-compute the length)
  
Return value:

    qTrue if there is a response acknowledge, otherwise returns qFalse
*/
qBool_t qResponse_Received( qResponse_t * const obj, const char *Pattern, size_t n ){
    return qResponse_ReceivedWithTimeout( obj, Pattern, n, qTimeImmediate );
}
/*============================================================================*/
/*qBool_t qResponse_ReceivedWithTimeout( qResponse_t * const obj, const char *Pattern, size_t n, qTime_t t )
 
Non-Blocking Response check with timeout

Parameters:

    - obj : A pointer to the Response Handler object
    - Pattern: The data checked in the receiver ISR
    - n : The length of the data pointed by Pattern 
          (if Pattern is string, set n to 0 to auto-compute the length)
    - t : The timeout value
  
Return value:

    qTrue if there is a response acknowledge,
    qTimeoutReached if timeout t expires
    otherwise returns qFalse
*/
qBool_t qResponse_ReceivedWithTimeout( qResponse_t * const obj, const char *Pattern, size_t n, qTime_t t ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( ( qFalse == obj->qPrivate.ResponseReceived ) && ( 0u == obj->qPrivate.PatternLength ) ){ /*handler no configured yet*/
            (void)strncpy( obj->qPrivate.Pattern2Match, (const char*)Pattern, obj->qPrivate.MaxStrLength - (size_t)1 ) ; /*set the expected response pattern*/
            obj->qPrivate.PatternLength = (0u == n)? strlen( Pattern ) : n; /*set the number of chars to match*/
            obj->qPrivate.MatchedCount = 0u; /*reinitialize the chars match count*/
            obj->qPrivate.ResponseReceived = qFalse; /*clear the ready flag*/
            if( t > qTimeImmediate ){
                (void)qSTimer_Set( &obj->qPrivate.timeout, t);
            }
        }
        else if( qSTimer_Expired( &obj->qPrivate.timeout) ){
            qResponse_Reset( obj ); /*re-initialize the response handler*/
            RetValue = (qBool_t)qResponseTimeout;
        }        
        else if( obj->qPrivate.ResponseReceived ){ /*if response received from ISR match the expected*/
            qResponse_Reset( obj ); /*re-initialize the response handler*/
            RetValue = qTrue; /*let it know to the caller that expected response was received*/
        } 
        else{
        /*nothing to do*/
        }    
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qResponse_ISRHandler( qResponse_t * const obj, const char rxchar )

ISR receiver for the response handler

Parameters:

    - obj : A pointer to the Response Handler object
    - rxchar: The byte-data from the receiver 

Return value:

    qTrue when the Response handler match the request from "qResponseReceived"
*/
qBool_t qResponse_ISRHandler( qResponse_t * const obj, const char rxchar ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        if( ( qFalse == obj->qPrivate.ResponseReceived ) && ( obj->qPrivate.PatternLength > 0u ) ) {
            if( obj->qPrivate.Pattern2Match[ obj->qPrivate.MatchedCount ] == rxchar ){ /*if the received char match with the expected*/ /*MISRAC2004-17.4_b Deviation allowed*/
                obj->qPrivate.MatchedCount++; /*move to the next char in the expected buffer*/
                if( obj->qPrivate.MatchedCount == obj->qPrivate.PatternLength ){
                    obj->qPrivate.ResponseReceived = qTrue; /*if all the requested chars match, set the ready flag */
                    RetValue = obj->qPrivate.ResponseReceived;
                }
            }
        }    
    }
    return RetValue;
}
/*============================================================================*/

#endif /* #if ( Q_RESPONSE_HANDLER == 1 ) */
