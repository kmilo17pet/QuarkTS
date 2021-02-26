#include "qcoroutine.h"

/*============================================================================*/
/*void qCR_ExternControl( qCR_Handle_t h, const qCR_ExternAction_t action,  const qCR_ExtPosition_t pos )

Perform an external action over the requested Co-routine

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
    - pos : The required position if <action> = qCR_POSITIONSET. For other actions
            this argument its ignored.           

*/
void qCR_ExternControl( qCR_Handle_t h, const qCR_ExternAction_t action,  const qCR_ExtPosition_t pos ){
    if( NULL != h ){ 
        switch( action ){
            case qCR_RESTART:
                h->instr = (_qCR_TaskPC_t)_qCR_PC_INITVAL; 
                break;
            case qCR_POSITIONSET:
                h->instr = pos; 
                break;
            case qCR_SUSPEND:
                h->prev = h->instr; 
                h->instr = (_qCR_TaskPC_t)_qCR_PC_SUSPENDEDVAL;
                break;   
            case qCR_RESUME:
                h->instr = ( (_qCR_TaskPC_t)_qCR_UNDEFINED != h->prev )?  h->prev : (_qCR_TaskPC_t)_qCR_PC_INITVAL;
                h->prev = (_qCR_TaskPC_t)_qCR_UNDEFINED;
                break;                                 
            default:
                break;
        }
    }
}
/*============================================================================*/
/* Used to perform the semaphores operations on Coroutines
Do not use this function explicitly to handle semaphores, use the provided coroutine 
statements instead : <qCR_SemInit>, <qCR_SemWait> and <qCR_SemSignal>
*/
qBool_t _qCR_Sem( qCR_Semaphore_t * const sem,  const _qCR_Oper_t oper ){
    qBool_t RetValue = qFalse;

    if( NULL != sem ){
        switch( oper ){
            case _qCR_SEM_SIGNAL:
                ++sem->count;
                break;
            case _qCR_SEM_TRYLOCK:
                if( sem->count > (size_t)0 ){
                    RetValue = qTrue; /*break the Wait operation*/
                    --sem->count;
                }
                break;
            default:
                if( oper >= _qCR_UNDEFINED ){
                    sem->count = (size_t)oper;
                }
                break;    
        }
    }
    return RetValue;
}
/*============================================================================*/