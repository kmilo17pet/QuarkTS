/*!
 * @file qresponse.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qresponse.h"

#if ( Q_RESPONSE_HANDLER == 1 )

/*============================================================================*/
void qResponse_Setup( qResponse_t * const obj, char *xLocBuff, size_t nMax ){
    if( NULL != obj ){
        obj->qPrivate.Pattern2Match = xLocBuff;
        obj->qPrivate.MaxStrLength = nMax; 
        qResponse_Reset( obj );
    }
}   
/*============================================================================*/
void qResponse_Reset( qResponse_t * const obj ){
    if( NULL != obj ){
        obj->qPrivate.PatternLength = 0u;
        obj->qPrivate.MatchedCount = 0u;
        obj->qPrivate.ResponseReceived = qFalse;
        qSTimer_Disarm( &obj->qPrivate.timeout );
    }
}
/*============================================================================*/
qBool_t qResponse_Received( qResponse_t * const obj, const char *Pattern, size_t n ){
    return qResponse_ReceivedWithTimeout( obj, Pattern, n, qTimeImmediate );
}
/*============================================================================*/
qBool_t qResponse_ReceivedWithTimeout( qResponse_t * const obj, const char *Pattern, size_t n, qTime_t t ){
    qBool_t RetValue = qFalse;
    
    if( NULL != obj ){
        if( ( qFalse == obj->qPrivate.ResponseReceived ) && ( 0u == obj->qPrivate.PatternLength ) ){ /*handler no configured yet*/
            (void)qIOUtil_StrlCpy( obj->qPrivate.Pattern2Match, (const char*)Pattern, obj->qPrivate.MaxStrLength ) ; /*set the expected response pattern*/
            obj->qPrivate.PatternLength = ( 0u == n )? qIOUtil_StrLen( Pattern, obj->qPrivate.MaxStrLength ) : n; /*set the number of chars to match*/
            obj->qPrivate.MatchedCount = 0u; /*reinitialize the chars match count*/
            obj->qPrivate.ResponseReceived = qFalse; /*clear the ready flag*/
            if( t > qTimeImmediate ){
                (void)qSTimer_Set( &obj->qPrivate.timeout, t);
            }
        }
        else if( qSTimer_Expired( &obj->qPrivate.timeout) ){
            qResponse_Reset( obj ); /*re-initialize the response handler*/
            RetValue = qResponseTimeout;
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
qBool_t qResponse_ISRHandler( qResponse_t * const obj, const char rxchar ){
    qBool_t RetValue = qFalse;
    
    if( NULL != obj ){
        if( ( qFalse == obj->qPrivate.ResponseReceived ) && ( obj->qPrivate.PatternLength > 0u ) ) {
            if( obj->qPrivate.Pattern2Match[ obj->qPrivate.MatchedCount ] == rxchar ){ /*if the received char match with the expected*/ /*MISRAC2004-17.4_b Deviation allowed*/
                ++obj->qPrivate.MatchedCount; /*move to the next char in the expected buffer*/
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
