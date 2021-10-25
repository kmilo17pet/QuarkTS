/*!
 * @file qresponse.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qresponse.h"

#if ( Q_RESPONSE_HANDLER == 1 )

/*============================================================================*/
qBool_t qResponse_Setup( qResponse_t * const r, 
                         char *xLocBuff, 
                         const size_t nMax )
{
    qBool_t retValue = qFalse;
    
    if ( ( NULL != r ) && ( NULL != xLocBuff ) && ( nMax > 0u ) ) {
        (void)memset( r, 0, sizeof( qResponse_t ) );
        r->qPrivate.Pattern2Match = xLocBuff;
        r->qPrivate.MaxStrLength = nMax; 
        retValue = qResponse_Reset( r );
    }

    return retValue;
}   
/*============================================================================*/
qBool_t qResponse_Reset( qResponse_t * const r )
{
    qBool_t retValue = qFalse;
    
    if ( NULL != r ) {
        r->qPrivate.PatternLength = 0u;
        r->qPrivate.MatchedCount = 0u;
        r->qPrivate.ResponseReceived = qFalse;
        retValue = qSTimer_Disarm( &r->qPrivate.timeout );
    }

    return retValue;
}
/*============================================================================*/
qBool_t qResponse_Received( qResponse_t * const r, 
                            const char *pattern, 
                            const size_t n )
{
    return qResponse_ReceivedWithTimeout( r, pattern, n, qTimeImmediate );
}
/*============================================================================*/
qBool_t qResponse_ReceivedWithTimeout( qResponse_t * const r, 
                                       const char *pattern, 
                                       const size_t n, 
                                       const qTime_t t )
{
    qBool_t retValue = qFalse;
    
    if ( NULL != r ) {
        if ( ( qFalse == r->qPrivate.ResponseReceived ) && ( 0u == r->qPrivate.PatternLength ) ) { /*handler no configured yet*/
            (void)qIOUtil_StrlCpy( r->qPrivate.Pattern2Match, (const char*)pattern, r->qPrivate.MaxStrLength ) ; /*set the expected response pattern*/
            r->qPrivate.PatternLength = ( 0u == n )? qIOUtil_StrLen( pattern, r->qPrivate.MaxStrLength ) : n; /*set the number of chars to match*/
            r->qPrivate.MatchedCount = 0u; /*reinitialize the chars match count*/
            r->qPrivate.ResponseReceived = qFalse; /*clear the ready flag*/
            if ( t > qTimeImmediate ) {
                (void)qSTimer_Set( &r->qPrivate.timeout, t);
            }
        }
        else if ( qSTimer_Expired( &r->qPrivate.timeout ) ) {
            (void)qResponse_Reset( r ); /*re-initialize the response handler*/
            retValue = qResponseTimeout;
        }        
        else if ( r->qPrivate.ResponseReceived ) { /*if response received from ISR match the expected*/
            retValue = qResponse_Reset( r ); /*re-initialize the response handler*/
        } 
        else {
            /*nothing to do*/
        }    
    }

    return retValue;
}
/*============================================================================*/
qBool_t qResponse_ISRHandler( qResponse_t * const r, 
                              const char rxchar )
{
    qBool_t retValue = qFalse;
    
    if ( NULL != r ) {
        if ( ( qFalse == r->qPrivate.ResponseReceived ) && ( r->qPrivate.PatternLength > 0u ) ) {
            if ( r->qPrivate.Pattern2Match[ r->qPrivate.MatchedCount ] == rxchar ) { /*if the received char match with the expected*/ /*MISRAC2004-17.4_b Deviation allowed*/
                ++r->qPrivate.MatchedCount; /*move to the next char in the expected buffer*/
                if ( r->qPrivate.MatchedCount == r->qPrivate.PatternLength ) {
                    r->qPrivate.ResponseReceived = qTrue; /*if all the requested chars match, set the ready flag */
                    retValue = r->qPrivate.ResponseReceived;
                }
            }
        }    
    }
    
    return retValue;
}
/*============================================================================*/

#endif /* #if ( Q_RESPONSE_HANDLER == 1 ) */
