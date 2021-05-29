/**
 * @file qcoroutine.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qcoroutine.h"

/*============================================================================*/
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