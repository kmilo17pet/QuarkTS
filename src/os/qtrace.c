#include "qtrace.h"

#if ( Q_TRACE_VARIABLES ==1 )

qPutChar_t __qDebugOutputFcn = NULL;
char qDebugTrace_Buffer[Q_DEBUGTRACE_BUFSIZE] = {0};

/*============================================================================*/
void __qtrace_func( const char *loc, const char* fcn, const char *varname, const char* varvalue, void* Pointer, qSize_t BlockSize ){
    if( NULL != __qDebugOutputFcn ){ /*trace only if the output-function is defined*/
        qPrintString( __qDebugOutputFcn, NULL, loc ); /*print out the line location*/
        if( NULL != fcn ){ /*print out the function if available*/
            __qDebugOutputFcn( NULL, '@' );
            qPrintString( __qDebugOutputFcn, NULL, fcn ); 
            __qDebugOutputFcn( NULL, ' ' );
        }
        qPrintString( __qDebugOutputFcn, NULL, varname );
        if( NULL == varvalue ){ /*if varvalue is not defined, the call must correspond to memory tracing*/
            qPrintXData( __qDebugOutputFcn, NULL, Pointer, BlockSize ); /*print out the memory in hex format*/
        }
        else{ /*print out the variable value*/
            qPrintString( __qDebugOutputFcn, NULL, varvalue );
            __qDebugOutputFcn( NULL, '\r' );
            __qDebugOutputFcn( NULL, '\n' );
        }
    }
}
/*============================================================================*/

#endif /* #if ( Q_TRACE_VARIABLES ==1 ) */