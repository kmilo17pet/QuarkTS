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
        r->qPrivate.pattern2Match = xLocBuff;
        r->qPrivate.maxStrLength = nMax;
        retValue = qResponse_Reset( r );
    }

    return retValue;
}
/*============================================================================*/
qBool_t qResponse_Reset( qResponse_t * const r )
{
    qBool_t retValue = qFalse;

    if ( NULL != r ) {
        r->qPrivate.patternLength = 0u;
        r->qPrivate.matchedCount = 0u;
        r->qPrivate.responseReceived = qFalse;
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
        if ( ( qFalse == r->qPrivate.responseReceived ) && ( 0u == r->qPrivate.patternLength ) ) {
            /*handler no configured yet*/
            /*set the expected response pattern*/
            (void)qIOUtil_StrlCpy( r->qPrivate.pattern2Match,
                                   (const char*)pattern,
                                   r->qPrivate.maxStrLength );
            /*set the number of chars to match*/
            r->qPrivate.patternLength = ( 0u == n )?
                                        qIOUtil_StrLen( pattern, r->qPrivate.maxStrLength ) :
                                        n;
            r->qPrivate.matchedCount = 0u; /*reinitialize the chars match count*/
            r->qPrivate.responseReceived = qFalse; /*clear the ready flag*/
            if ( t > qTimeImmediate ) {
                (void)qSTimer_Set( &r->qPrivate.timeout, t);
            }
        }
        else if ( qSTimer_Expired( &r->qPrivate.timeout ) ) {
            (void)qResponse_Reset( r );
            retValue = qResponseTimeout;
        }
        else if ( r->qPrivate.responseReceived ) {
            retValue = qResponse_Reset( r );
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
        if ( ( qFalse == r->qPrivate.responseReceived ) && ( r->qPrivate.patternLength > 0u ) ) {
            /*check if the received char match with the expected*/
            if ( r->qPrivate.pattern2Match[ r->qPrivate.matchedCount ] == rxchar ) {/*MISRAC2004-17.4_b Deviation allowed*/
                /*move to the next char in the expected buffer*/
                ++r->qPrivate.matchedCount;
                if ( r->qPrivate.matchedCount == r->qPrivate.patternLength ) {
                    r->qPrivate.responseReceived = qTrue;
                    /*if all the requested chars match, set the ready flag */
                    retValue = r->qPrivate.responseReceived;
                }
            }
        }
    }

    return retValue;
}
/*============================================================================*/

#endif /* #if ( Q_RESPONSE_HANDLER == 1 ) */
