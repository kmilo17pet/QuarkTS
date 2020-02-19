/*This file is part of the QuarkTS distribution.*/
#ifndef QCOROUTINE_H
    #define QCOROUTINE_H

    #include "qtypes.h"
    #include "qstimers.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef qINT32_t _qCR_TaskPC_t;
    #define qCR_Position_t static _qCR_TaskPC_t
    
    typedef struct{
        _qCR_TaskPC_t instr;    /*< Used to the instruction where the coroutine yields. */
        qSTimer_t crdelay;      /*< Used to hold the required delay for qCR_Delay. */
    }_qCR_Instance_t;

    typedef struct {qUINT16_t head, tail;} qCR_Semaphore_t; 
    
    #define _qCR_Unused_(x)            (void)(x)
    #define _qCR_PCInitVal             ( -1 )            
    #define _qCR_CodeStartBlock        do
    #define _qCR_CodeEndBlock          while(qFalse)
    #define _qCR_Persistent            static _qCR_Instance_t
    #define _qCR_TaskProgress          __LINE__
    #define _qCR_Assert(_COND_)        if(!(_COND_))
    #define _qCR_TaskPCVar             _qCRTaskState_.instr
    #define _qCR_DelayVar              _qCRTaskState_.crdelay           
    #define _qCR_SetPC(_VAL_)          _qCR_TaskPCVar = (_VAL_) 
    #define _qCR_SaveState             _qCR_SetPC(_qCR_TaskProgress) 
    #define _qCR_SaveStateOn(_VAR_)    ( _VAR_)  =  _qCR_TaskProgress
    #define _qCR_InitState             _qCRTaskState_ = { _qCR_PCInitVal, QSTIMER_INITIALIZER }
    #define _qCR_TaskCheckPCJump(_PC_) switch(_PC_){    
    #define _qCR_TagExitCCR            _qCRYield_ExitLabel
    #define _qCR_Exit                  goto _qCR_TagExitCCR /*MISRA deviation*/
    #define _qCR_TaskYield             _qCR_Exit;
    #define _qCR_Dispose               _qCR_SetPC(_qCR_PCInitVal);} _qCR_TagExitCCR:
    #define _qCR_Restorator(_VAL_)     case (_qCR_TaskPC_t)(_VAL_):            
    #define _qCR_RestoreAfterYield     _qCR_Restorator(_qCR_TaskProgress)
    #define _qCR_RestoreFromBegin      _qCR_Restorator(_qCR_PCInitVal)
    #define _qCR_SemInit(s, c)         _qCR_CodeStartBlock{ (s)->tail = 0; (s)->head = (c); }_qCR_CodeEndBlock
    #define _qCR_SemCount(s)           ((s)->head - (s)->tail)
    #define _qCR_SemLock(s)            (++(s)->tail)
    #define _qCR_SemRelease(s)         (++(s)->head)

    #define _qCR_Start                         _qCR_Persistent  _qCR_InitState ;  _qCR_TaskCheckPCJump(_qCR_TaskPCVar) _qCR_RestoreFromBegin
    #define _qCR_Yield                         _qCR_CodeStartBlock{ _qCR_SaveState              ; _qCR_TaskYield  _qCR_RestoreAfterYield; }                         _qCR_CodeEndBlock
    #define _qCR_Restart                       _qCR_CodeStartBlock{ _qCR_SetPC(_qCR_PCInitVal)  ; _qCR_TaskYield }                                                  _qCR_CodeEndBlock
    #define _qCR_wu_Assert(_cond_)             _qCR_CodeStartBlock{ _qCR_SaveState              ; _qCR_RestoreAfterYield    ; _qCR_Assert(_cond_) _qCR_TaskYield }  _qCR_CodeEndBlock
    #define _qCR_GetPosition(_pos_)            _qCR_CodeStartBlock{ _qCR_SaveStateOn((_pos_))   ; _qCR_RestoreAfterYield    ; _qCR_Unused_((_pos_)); }              _qCR_CodeEndBlock
    #define _qCR_RestoreFromPosition(_pos_)    _qCR_CodeStartBlock{ _qCR_SetPC(_pos_)           ; _qCR_TaskYield }                                                  _qCR_CodeEndBlock
    #define _qCR_Delay(_time_)                 _qCR_CodeStartBlock{ qSTimer_Set( &_qCR_DelayVar, _time_  )     ; _qCR_SaveState;  _qCR_RestoreAfterYield;   _qCR_Assert( qSTimer_Expired( &_qCR_DelayVar )  ) _qCR_TaskYield } _qCR_CodeEndBlock
    #define _qCR_SemWait(_sem_)                _qCR_CodeStartBlock{ qCR_WaitUntil(_qCR_SemCount(_sem_) > 0);  _qCR_SemLock(_sem_); } _qCR_CodeEndBlock 
    #define _qCR_do                            _qCR_CodeStartBlock{ _qCR_SaveState              ; _qCR_RestoreAfterYield;
    #define _qCR_until( _cond_ )               _qCR_Assert(_cond_) _qCR_TaskYield }  _qCR_CodeEndBlock     
    #define _qCR_PositionReset(_pos_)          (_pos_) = _qCR_PCInitVal
    #define _qCR_wu_preAssert(_pre_ , _cond_)  _qCR_do{ (_pre_); }_qCR_until((_cond_))    



    /*qCR_Begin{
    
    }qCR_End;
    
    Defines a Coroutine segment. Only one segment is allowed inside a task; 
    The qCR_Begin statement is used to declare the starting point of 
    a Coroutine. It should be placed at the start of the function in which the 
    Coroutine runs. qCR_End declare the end of the Coroutine. 
    It must always be used together with a matching qCR_End statement.

    */
    #define qCR_Begin                                   _qCR_Start
    /*qCR_Begin{
    
    }qCR_End;
    
    Ends a Coroutine segment. Only one segment is allowed inside a task; 
    The qCR_End statement is used to define the ending point of 
    a Coroutine. It should be placed at the end of the function in which the 
    Coroutine runs. 
    It must always be used together with a matching qCR_Begin statement.

    */   
    #define qCR_End                                     _qCR_Dispose
    /*qCR_Yield

    This statement is only allowed inside a Coroutine segment. qCR_Yield 
    return the CPU control back to the scheduler but saving the execution progress. 
    With the next task activation, the Coroutine will resume the execution after 
    the last 'qCR_Yield' statement.

    Action sequence : [Save progress] then [Yield]

    */     
    #define qCR_Yield                                   _qCR_Yield
    /*qCR_Restart

    This statement cause the running Coroutine to restart its execution at the 
    place of the qCR_Begin statement.

    Action sequence : [Reload progress] then [Yield]

    */
    #define qCR_Restart                                 _qCR_Restart 
    /*qCRWait_Until(_CONDITION_)

    Yields until the logical condition being true

    Action sequence : [Save progress] 
                    IF (Condition == False){
                        [Yield]      
                    }  

    */    
    #define qCR_WaitUntil(_condition_)                  _qCR_wu_Assert(_condition_)
    /*qCR_Do

    This statement start a blocking Job segment. 
    Must be used together with a matching qCR_Until statement.  

    */    
    #define qCR_Do                                      _qCR_do
    /*qCR_Until( _condition_ )

    This statement ends a blocking Job segment starting the qCR_Do statement.   
    The condition determines if the blocking job ends (if condition is True)
    or continue yielding (if false)

    */         
    #define qCR_Until( _condition_ )                    _qCR_until( _condition_ )
    /*qCR_SemInit(_qCR_Semaphore_t_, _Value_)

    Initializes a semaphore with a value for the counter. Internally, the semaphores
    use an "unsigned int" to represent the counter,  therefore the "count" 
    argument should be within range of an unsigned int.

    Parameters:

        - _qCR_Semaphore_t_ :  A pointer to the qCR_Semaphore_t representing the semaphore

        - _Value_ : The initial count of the semaphore.

    */          
    #define qCR_SemInit(_qCR_Semaphore_t_, _Value_)     _qCR_SemInit((_qCR_Semaphore_t_), (_Value_))  
    /*qCR_SemWait(_qCR_Semaphore_t_)  

    Carries out the "wait" operation on the semaphore. The wait operation causes 
    the Co-routine to block while the counter is zero. When the counter reaches a 
    value larger than zero, the Co-routine  will continue.

    Parameters:

        - _qCR_Semaphore_t_ :  A pointer to the qCR_Semaphore_t representing the semaphore

    */        
    #define qCR_SemWait(_qCR_Semaphore_t_)              _qCR_SemWait(_qCR_Semaphore_t_)                    

    /*qCR_SemSignal(_qCR_Semaphore_t_)

    Carries out the "signal" operation on the semaphore. The signal operation increments
    the counter inside the semaphore, which eventually will cause waiting Co-routines
    to continue executing.

    Parameters:

        - _qCR_Semaphore_t_ :  A pointer to the qCR_Semaphore_t representing the semaphore

    */     
    #define qCR_SemSignal(_qCR_Semaphore_t_)            _qCR_SemRelease(_qCR_Semaphore_t_)
    /*qCR_PositionGet(qCR_Position_t _CRPos_) 

    Labels the current position and saves it to _CRPos_ so it can be later restored by qCR_PositionRestore

    */    
    #define qCR_PositionGet(_CRPos_)                    _qCR_GetPosition(_CRPos_)
    /*qCR_PositionRestore(qCR_Position_t _CRPos_) 

    Restores the Co-Routine position saved in _CRPos_

    */   
    #define qCR_PositionRestore(_CRPos_)                _qCR_RestoreFromPosition(_CRPos_)
    /*qCR_PositionReset(qCR_Position_t _CRPos_) 

    Resets the _CRPos_ variable to the begining of the Co-Routine

    */ 
    #define qCR_PositionReset(_CRPos_)                  _qCR_PositionReset(_CRPos_)
    /*qCR_Delay(_qTime_t_)  

    Delay a coroutine for a given number of time

    Parameters:

        - _qTime_t_ :  The amount of time (In seconds), that the calling coroutine should yield.

    */        
    #define qCR_Delay(_qTime_t_)                        _qCR_Delay(_qTime_t_)

    #ifdef __cplusplus
    }
    #endif

#endif
