#include "qcoroutine.h"

/*============================================================================*/
/*void qCR_ExternControl( qCR_Handle_t h, const qCR_ExternAction_t action,  const qCR_ExtPosition_t pos )

Perform an external action over a Co-routine
Note:  Do not use this function inside a Coroutine segment.

Parameters:

    - h : The Co-routine handle
    - action : The specific action to perform, should be one of the following:
            qCR_RESTART : Restart the coroutine execution at the place of 
                        the <qCR_BeginWithHandle> statement.  
            qCR_SUSPEND : Suspend the entire coroutine segment. The task will still 
                        running instructions outside the segment.
            qCR_RESUME : Resume the entire coroutine segment at the point where
                        it had been left before the suspension.
            qCR_POSITIONSET : Force the coroutine execution at the position specified 
                            in <pos>. If a non-valid position is supplied, the Co-routine
                            segment will be suspended.      
    - pos : The required position if action = qCR_POSITIONSET. For other actions
            this argument its ignored.           
Return value:

    time (t) in seconds
*/
void qCR_ExternControl( qCR_Handle_t h, const qCR_ExternAction_t action,  const qCR_ExtPosition_t pos ){
    if( NULL != h ){ 
        switch( action ){
            case qCR_RESTART:
                h->instr = _qCR_PCInitVal; 
                break;
            case qCR_POSITIONSET:
                h->instr = pos; 
                break;
            case qCR_SUSPEND:
                h->prev = h->instr; 
                h->instr = _qCR_PCSuspendVal;
                break;   
            case qCR_RESUME:
                h->instr = ( _qCR_PCUndefined != h->prev )?  h->prev : _qCR_PCInitVal;
                h->prev = _qCR_PCUndefined;
                break;                                 
            default:
                break;
        }
    }
}                   