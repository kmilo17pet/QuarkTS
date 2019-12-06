/*This file is part of the QuarkTS distribution.*/
#ifndef QCOROUTINE_H
    #define QCOROUTINE_H

    #include "qtypes.h"
    #include "qstimers.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef qINT32_t _qTaskPC_t;
    #define qCRPosition_t static _qTaskPC_t
    
    typedef struct{
        _qTaskPC_t instr;   /*< Used to the instruction where the coroutine yields. */
        qSTimer_t crdelay;  /*< Used to hold the required delay for qCoroutineDelay. */
    }qCoroutineInstance_t;

    typedef struct {qUINT16_t head, tail;} qCoroutineSemaphore_t; 
    typedef qCoroutineSemaphore_t qCRSem_t;
    
    #define qCR_PCInitVal               ( -1 )            
    #define __qCRKeep
    #define __qCRCodeStartBlock         do
    #define __qCRCodeEndBlock           while(qFalse)
    #define __qPersistent               static qCoroutineInstance_t/*static _qTaskPC_t*/
    #define __qTaskProgress             __LINE__
    #define __qAssert(_COND_)           if(!(_COND_))
    #define __qTaskPCVar                _qCRTaskState_.instr /*_qCRTaskState_*/
    #define __qCRDelayVar               _qCRTaskState_.crdelay           
    #define __qSetPC(_VAL_)             __qTaskPCVar = (_VAL_)
    #define __qTaskSaveState            __qSetPC(__qTaskProgress) 
    #define __qTaskInitState            _qCRTaskState_ = { qCR_PCInitVal, QSTIMER_INITIALIZER }/*__qSetPC({qCR_PCInitVal}) */ 
    #define __qTaskCheckPCJump(_PC_)    switch(_PC_){    
    #define __TagExitCCR                __qCRYield_ExitLabel
    #define __qExit                     goto __TagExitCCR /*MISRA deviation*/
    #define __qTaskYield                __qExit;
    #define __qCRDispose                __qSetPC(qCR_PCInitVal);} __TagExitCCR:/*__qTaskInitState;} __TagExitCCR:*/
    #define __qRestorator(_VAL_)        case (_qTaskPC_t)(_VAL_):            
    #define __RestoreAfterYield         __qRestorator(__qTaskProgress)
    #define __RestoreFromBegin          __qRestorator(qCR_PCInitVal)
    #define __qCRSemInit(s, c)          __qCRCodeStartBlock{ (s)->tail = 0; (s)->head = (c); }__qCRCodeEndBlock
    #define __qCRSemCount(s)            ((s)->head - (s)->tail)
    #define __qCRSemLock(s)             (++(s)->tail)
    #define __qCRSemRelease(s)          (++(s)->head)

    #define __qCRStart                          __qPersistent  __qTaskInitState ;  __qTaskCheckPCJump(__qTaskPCVar) __RestoreFromBegin
    #define __qCRYield                          __qCRCodeStartBlock{  __qTaskSaveState      ; __qTaskYield  __RestoreAfterYield; }                      __qCRCodeEndBlock
    #define __qCRRestart                        __qCRCodeStartBlock{  __qSetPC(qCR_PCInitVal)      ; __qTaskYield }                                     __qCRCodeEndBlock
    #define __qCR_wu_Assert(_cond_)             __qCRCodeStartBlock{  __qTaskSaveState      ; __RestoreAfterYield   ; __qAssert(_cond_) __qTaskYield }  __qCRCodeEndBlock
        
    #define __qCR_do                            __qCRCodeStartBlock{  __qTaskSaveState      ; __RestoreAfterYield;
    #define __qCR_until( _cond_ )               __qAssert(_cond_) __qTaskYield }  __qCRCodeEndBlock           
        
    #define __qCR_wu_preAssert(_pre_ , _cond_)  __qCR_do{ (_pre_); }__qCR_until((_cond_)) \


    #define __qCR_GetPosition(_pos_)            __qCRCodeStartBlock{  (_pos_) =__qTaskProgress ; __RestoreAfterYield   ;_UNUSED_((_pos_));}             __qCRCodeEndBlock
    #define __qCR_RestoreFromPosition(_pos_)    __qCRCodeStartBlock{  __qSetPC(_pos_)       ; __qTaskYield}                                             __qCRCodeEndBlock
    #define __qCR_Delay(_time_)                 __qCRCodeStartBlock{  qSTimerSet( &__qCRDelayVar, _time_  )     ; __qTaskSaveState;  __RestoreAfterYield;   __qAssert( qSTimerExpired( &__qCRDelayVar )  ) __qTaskYield } __qCRCodeEndBlock
    #define __qCR_PositionReset(_pos_)          (_pos_) = qCR_PCInitVal

    /*qCoroutineBegin{
    
    }qCoroutineEnd;

    qCRBegin{
    
    }qCREnd;
    * 
    Defines a Coroutine segment. Only one segment is allowed inside a task; 
    The qCoroutineBegin statement is used to declare the starting point of 
    a Coroutine. It should be placed at the start of the function in which the 
    Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
    It must always be used together with a matching qCoroutineBegin statement.
    */
    #define qCoroutineBegin                         __qCRStart
    #define qCRBegin                                __qCRStart
    /*qCoroutineYield
    qCRYield

    This statement is only allowed inside a Coroutine segment. qCoroutineYield 
    return the CPU control back to the scheduler but saving the execution progress. 
    With the next task activation, the Coroutine will resume the execution after 
    the last 'qCoroutineYield' statement.

    Action sequence : [Save progress] then [Yield]

    */
    #define qCoroutineYield                         __qCRYield          
    #define qCRYield                                __qCRYield
    /*qCoroutineBegin{
    
    }qCoroutineEnd;
    qCRBegin{
    
    }qCREnd;

    Defines a Coroutine segment. Only one segment is allowed inside a task; 
    The qCoroutineBegin statement is used to declare the starting point of 
    a Coroutine. It should be placed at the start of the function in which the 
    Coroutine runs. qCoroutineEnd declare the end of the Coroutine. 
    It must always be used together with a matching qCoroutineBegin statement.
    */    
    #define qCoroutineEnd                           __qCRDispose
    #define qCREnd                                  __qCRDispose
    /*qCoroutineRestart
    qCRRestart

    This statement cause the running Coroutine to restart its execution at the 
    place of the qCoroutineBegin statement.

    Action sequence : [Reload progress] then [Yield]

    */
    #define qCoroutineRestart                       __qCRRestart  
    #define qCRRestart                              __qCRRestart 
    /*qCoroutineWaitUntil(_CONDITION_) 
    qCRWaitUntil(_CONDITION_)

    Yields until the logical condition being true

    Action sequence : [Save progress] 
                    IF (Condition == False){
                        [Yield]      
                    }  

    */    
    #define qCoroutineWaitUntil(_condition_)        __qCR_wu_Assert(_condition_)
    #define qCRWaitUntil(_condition_)               __qCR_wu_Assert(_condition_)

    /*qCoroutineDo 
    qCRDo

    This statement tart a blocking Job segment. 
    Must be used together with a matching qCoroutineDo statement.   
    */    
    #define qCoroutineDo                        __qCR_do
    #define qCRDo                               __qCR_do
    /*qCoroutineUntil( _condition_ )
    qCRUntil( _condition_ )

    This statement ends a qCoroutineDo statement for a blocking Job.   
    The condition determines if the blocking job ends (if condition is True)
    or continue yielding (if false)
    */         
    #define qCoroutineUntil( _condition_ )           __qCR_until( _condition_ )
    #define qCRUntil( _condition_ )                  __qCR_until( _condition_ )

    /*qCoroutineSemaphoreInit(_qCRSemaphore_t_, _Value_) 
    qCRSemInit(_qCRSemaphore_t_, _Value_)

    Initializes a semaphore with a value for the counter. Internally, the semaphores
    use an "unsigned int" to represent the counter,  therefore the "count" 
    argument should be within range of an unsigned int.

    Parameters:

        - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore

        - _Value_ : The initial count of the semaphore.
    */          
    #define qCoroutineSemaphoreInit(_qCRSemaphore_t_, _Value_)      __qCRSemInit((_qCRSemaphore_t_), (_Value_))
    #define qCRSemInit(_qCRSemaphore_t_, _Value_)                   __qCRSemInit((_qCRSemaphore_t_), (_Value_))  
    /*qCoroutineSemaphoreWait(_qCRSemaphore_t_) 
    qCRSemWait(_qCRSemaphore_t_)  

    Carries out the "wait" operation on the semaphore. The wait operation causes 
    the Co-routine to block while the counter is zero. When the counter reaches a 
    value larger than zero, the Co-routine  will continue.

    Parameters:

        - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore
    */        
    #define qCoroutineSemaphoreWait(_qCRSemaphore_t_)               __qCRCodeStartBlock{ qCoroutineWaitUntil(__qCRSemCount(_qCRSemaphore_t_) > 0);  __qCRSemLock(_qCRSemaphore_t_); } __qCRCodeEndBlock    
    #define qCRSemWait(_qCRSemaphore_t_)                            qCoroutineSemaphoreWait(_qCRSemaphore_t_)

    /*qCoroutineSemaphoreSignal(_qCRSemaphore_t_) 
    qCRSemSignal(_qCRSemaphore_t_)

    Carries out the "signal" operation on the semaphore. The signal operation increments
    the counter inside the semaphore, which eventually will cause waiting Co-routines
    to continue executing.

    Parameters:

        - _qCRSemaphore_t_ :  A pointer to the qCRSemaphore_t representing the semaphore
    */     
    #define qCoroutineSemaphoreSignal(_qCRSemaphore_t_)             __qCRSemRelease(_qCRSemaphore_t_)
    #define qCRSemSignal(_qCRSemaphore_t_)                          __qCRSemRelease(_qCRSemaphore_t_)
    /*qCoroutinePositionGet(qCRPosition_t _CRPos_)
    qCRPositionGet(qCRPosition_t _CRPos_) 

    Labels the current position and saves it to _CRPos_ so it can be later restored by qCoroutinePositionRestore
    */    
    #define qCoroutinePositionGet(_CRPos_)                          __qCR_GetPosition(_CRPos_)
    #define qCRPositionGet(_CRPos_)                                 __qCR_GetPosition(_CRPos_)
    /*qCoroutinePositionRestore(qCRPosition_t _CRPos_)
    qCRPositionRestore(qCRPosition_t _CRPos_) 

    Restores the Co-Routine position saved in _CRPos_
    */   
    #define qCoroutinePositionRestore(_CRPos_)                      __qCR_RestoreFromPosition(_CRPos_)
    #define qCRPositionRestore(_CRPos_)                             __qCR_RestoreFromPosition(_CRPos_)
    /*qCoroutinePositionReset(qCRPosition_t _CRPos_)
    qCRPositionReset(qCRPosition_t _CRPos_) 

    Resets the _CRPos_ variable to the begining of the Co-Routine
    */ 
    #define qCoroutinePositionReset(_CRPos_)                        __qCR_PositionReset(_CRPos_)
    #define qCRPositionReset(_CRPos_)                               __qCR_PositionReset(_CRPos_)

    /*qCoroutineDelay(_qTime_t_) 
    qCRDelay(_qTime_t_)  

    Delay a coroutine for a given number of time

    Parameters:

        - _qTime_t_ :  The amount of time (In seconds), that the calling coroutine should yield.
    */        
    #define qCoroutineDelay(_qTime_t_)                              __qCR_Delay(_qTime_t_)
    #define qCRDelay(_qTime_t_)                                     __qCR_Delay(_qTime_t_)

    #ifdef __cplusplus
    }
    #endif

#endif