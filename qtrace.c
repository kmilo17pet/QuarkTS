/*!
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qtrace.h"

#if ( Q_TRACE_VARIABLES ==1 )

static qPutChar_t qDebug = NULL;
char qTrace_PublicBuffer[ Q_DEBUGTRACE_BUFSIZE ] = {0};

/*============================================================================*/
void _qtrace_func( const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, size_t BlockSize ){
    if( NULL != qDebug ){ /*trace only if the output-function is defined*/
        #if ( Q_DEBUGTRACE_FULL == 1 )
            char qTrace_EpochsBuffer[ 11 ] = {0};

            qDebug( NULL, '[' );
            qIOUtil_OutputString( qDebug, NULL, qIOUtil_UtoA( qClock_GetTick(), qTrace_EpochsBuffer, 10 ), qFalse ); /*print out the systick*/
            qDebug( NULL, ']' );
            qDebug( NULL, ' ' );          
        #endif
        if( NULL != fcn ){ /*print out the function if available*/
            qIOUtil_OutputString( qDebug, NULL, fcn, qFalse ); 
            qIOUtil_OutputString( qDebug, NULL, loc, qFalse ); /*print out the line location*/
        }
        qIOUtil_OutputString( qDebug, NULL, varname, qFalse );
        if( NULL == varvalue ){ /*if varvalue is not defined, the call must correspond to memory tracing*/
            qIOUtil_PrintXData( qDebug, NULL, Pointer, BlockSize ); /*print out the memory in hex format*/
        }
        else{ /*print out the variable value*/
            qIOUtil_OutputString( qDebug, NULL, varvalue, qFalse );
            qDebug( NULL, '\r' );
            qDebug( NULL, '\n' );
        }
    }
}
/*============================================================================*/
void qTrace_Set_OutputFcn( qPutChar_t fcn ){
    qDebug = fcn;
}
/*============================================================================*/

#endif /* #if ( Q_TRACE_VARIABLES ==1 ) */
