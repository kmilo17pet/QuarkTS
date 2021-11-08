/*!
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qtrace.h"

#if ( Q_TRACE_VARIABLES == 1 )

static qPutChar_t qDebug = NULL;
char qTrace_PublicBuffer[ Q_DEBUGTRACE_BUFSIZE ] = { 0 };

/*============================================================================*/
#if ( Q_TRACE_KERNEL_AND_MODULES == 1 )
void _qtrace_krn( const char *msg,
                  const void *id,
                  const void *obj )
{
    if ( NULL != qDebug ) {
        char buff[ 11 ] = { 0 };
        qDebug( NULL, '[' );
        (void)qIOUtil_OutputString( qDebug, NULL, qIOUtil_UtoA( qClock_GetTick(), buff, 10 ), qFalse );
        (void)qIOUtil_OutputString( qDebug, NULL, "] {OS:Kernel} ", qFalse );
        (void)qIOUtil_OutputString( qDebug, NULL, msg, qFalse );
        if ( NULL != id ) {
            qUINT32_t val = 0;
            (void)memcpy( &val, &id, ( sizeof(val) < sizeof(void*) )? sizeof(val) : sizeof(void*)  );
            (void)qIOUtil_OutputString( qDebug, NULL, "0x", qFalse );
            (void)qIOUtil_OutputString( qDebug, NULL, qIOUtil_UtoA( val, buff, 16 ), qFalse );
            if ( obj != NULL ) {
                (void)memcpy( &val, &obj, ( sizeof(val) < sizeof(void*) )? sizeof(val) : sizeof(void*)  );
                (void)qIOUtil_OutputString( qDebug, NULL, "<-0x", qFalse );
                (void)qIOUtil_OutputString( qDebug, NULL, qIOUtil_UtoA( val, buff, 16 ), qFalse );
            }
        }
        qDebug( NULL, '\r' );
        qDebug( NULL, '\n' );
    }
}
#endif   /*#if ( Q_TRACE_KERNEL_AND_MODULES == 1 )*/
/*============================================================================*/
void _qtrace_func( const char *loc,
                   const char* fcn,
                   const char *vName,
                   const char* vValue,
                   void* ptr,
                   const size_t blockSize )
{
    if ( NULL != qDebug ) { /*trace only if the output-function is defined*/
        #if ( Q_DEBUGTRACE_FULL == 1 )
            char buff[ 11 ] = { 0 };
            qDebug( NULL, '[' );
            (void)qIOUtil_OutputString( qDebug, NULL, qIOUtil_UtoA( qClock_GetTick(), buff, 10 ), qFalse );
            qDebug( NULL, ']' );
            qDebug( NULL, ' ' );
        #endif
        if ( NULL != fcn ) { /*print out the function if available*/
            (void)qIOUtil_OutputString( qDebug, NULL, fcn, qFalse );
            (void)qIOUtil_OutputString( qDebug, NULL, loc, qFalse );
        }
        (void)qIOUtil_OutputString( qDebug, NULL, vName, qFalse );
        if ( NULL == vValue ) {
            /*
            if varvalue is not defined, the call must correspond to memory
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
void qTrace_Set_OutputFcn( qPutChar_t fcn )
{
    qDebug = fcn;
}
/*============================================================================*/

#endif /* #if ( Q_TRACE_VARIABLES ==1 ) */
