/*!
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qtrace.h"

#if ( Q_TRACE_VARIABLES == 1 )

static qPutChar_t qDebug = NULL; // skipcq: CXX-W2009
char qTrace_PublicBuffer[ Q_DEBUGTRACE_BUFSIZE ] = { 0 };

static void qTrace_LogTicks( char *buff );

/*============================================================================*/
#if ( Q_TRACE_KERNEL_AND_MODULES == 1 )
void _qTrace_krn( const char *msg,
                  const void *id,
                  const void *obj )
{
    if ( NULL != qDebug ) {
        char *obuf = qTrace_PublicBuffer;

        qTrace_LogTicks( obuf );
        (void)qIOUtil_OutputString( qDebug, NULL, "{kernel} ", qFalse );
        (void)qIOUtil_OutputString( qDebug, NULL, msg, qFalse );
        if ( NULL != id ) {
            qUINT32_t val = 0;
            const size_t n = ( sizeof(val) < sizeof(void*) ) ? sizeof(val)
                                                             : sizeof(void*);

            (void)memcpy( &val, &id, n);
            (void)qIOUtil_UtoA( val, obuf, 16 );
            (void)qIOUtil_OutputString( qDebug, NULL, "0x", qFalse );
            (void)qIOUtil_OutputString( qDebug, NULL, obuf, qFalse );
            if ( obj != NULL ) {
                (void)memcpy( &val, &obj, n );
                (void)qIOUtil_UtoA( val, obuf, 16 );
                (void)qIOUtil_OutputString( qDebug, NULL, "<-0x", qFalse );
                (void)qIOUtil_OutputString( qDebug, NULL, obuf, qFalse );
            }
        }
        qDebug( NULL, '\r' );
        qDebug( NULL, '\n' );
    }
}
#endif   /*#if ( Q_TRACE_KERNEL_AND_MODULES == 1 )*/
/*============================================================================*/
void _qTrace_dgb( const char *loc,
                  const char* fcn,
                  const char *vName,
                  const char* vValue,
                  void* ptr,
                  const size_t blockSize )
{
    if ( NULL != qDebug ) { /*trace only if the output-function is defined*/
        #if ( Q_DEBUGTRACE_FULL == 1 )
            char oBuff[ 11 ] = { 0 };

            qTrace_LogTicks( oBuff );
        #endif
        if ( NULL != fcn ) { /*print out the function if available*/
            (void)qIOUtil_OutputString( qDebug, NULL, fcn, qFalse );
            (void)qIOUtil_OutputString( qDebug, NULL, loc, qFalse );
        }
        (void)qIOUtil_OutputString( qDebug, NULL, vName, qFalse );
        if ( NULL == vValue ) {
            /*
            if vValue is not defined, the call must correspond to memory
            tracing. Print out the memory in hex format.
            */
            (void)qIOUtil_PrintXData( qDebug, NULL, ptr, blockSize );
        }
        else { /*print out the variable value*/
            (void)qIOUtil_OutputString( qDebug, NULL, vValue, qFalse );
            qDebug( NULL, '\r' );
            qDebug( NULL, '\n' );
        }
    }
}
/*============================================================================*/
static void qTrace_LogTicks( char *buff ) {
    (void)qIOUtil_UtoA( qClock_GetTick(), buff, 10 );
    qDebug( NULL, '[' );
    (void)qIOUtil_OutputString( qDebug, NULL, buff, qFalse );
    qDebug( NULL, ']' );
    qDebug( NULL, ' ' );
}
/*============================================================================*/
void qTrace_Set_OutputFcn( qPutChar_t fcn )
{
    qDebug = fcn;
}
/*============================================================================*/
#endif /* #if ( Q_TRACE_VARIABLES ==1 ) */
