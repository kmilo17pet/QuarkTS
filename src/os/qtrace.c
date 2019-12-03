#include "qtrace.h"

#if ( Q_TRACE_VARIABLES ==1 )

static qPutChar_t qDebug = NULL;
char qDebugTrace_Buffer[Q_DEBUGTRACE_BUFSIZE] = {0};

/*============================================================================*/
void __qtrace_func( const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, size_t BlockSize ){
    if( NULL != qDebug ){ /*trace only if the output-function is defined*/
        qPrintString( qDebug, NULL, loc ); /*print out the line location*/
        if( NULL != fcn ){ /*print out the function if available*/
            qDebug( NULL, '@' );
            qPrintString( qDebug, NULL, fcn ); 
            qDebug( NULL, ' ' );
        }
        qPrintString( qDebug, NULL, varname );
        if( NULL == varvalue ){ /*if varvalue is not defined, the call must correspond to memory tracing*/
            qPrintXData( qDebug, NULL, Pointer, BlockSize ); /*print out the memory in hex format*/
        }
        else{ /*print out the variable value*/
            qPrintString( qDebug, NULL, varvalue );
            qDebug( NULL, '\r' );
            qDebug( NULL, '\n' );
        }
    }
}
/*============================================================================*/
/*void qSetDebugFcn(qPutChar_t fcn)

This macro set the output method for debug/trace messages.

Parameters:

    - fcn : The basic output byte function

*/ 
void qSetDebugFcn(qPutChar_t fcn){
    qDebug = fcn;
}
/*============================================================================*/

#endif /* #if ( Q_TRACE_VARIABLES ==1 ) */