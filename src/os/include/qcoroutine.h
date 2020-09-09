/*This file is part of the QuarkTS distribution.*/
#ifndef QCOROUTINE_H
    #define QCOROUTINE_H

    #include "qtypes.h"
    #include "qstimers.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef qINT32_t _qCR_TaskPC_t;
    typedef _qCR_TaskPC_t qCR_ExtPosition_t;
    #define qCR_Position_t static _qCR_TaskPC_t
    
    /* Please don't access any members of this structure directly */
    typedef struct{
        _qCR_TaskPC_t instr;    /*< Used to hold the local continuation. */
        _qCR_TaskPC_t prev;     /*< Temporally holds the local continuation during a coroutine suspension*/
        qSTimer_t crdelay;      /*< Used to hold the required delay for qCR_Delay. */
    }_qCR_Instance_t;

    typedef _qCR_Instance_t *qCR_Handle_t;
    typedef struct { size_t count; } qCR_Semaphore_t; 
    
    #define QCR_RESTART     ( 0 )
    #define QCR_POSITIONSET ( 1 )
    #define QCR_SUSPEND     ( 2 )
    #define QCR_RESUME      ( 3 )

    typedef enum{
        qCR_RESTART = QCR_RESTART,
        qCR_POSITIONSET = QCR_POSITIONSET,
        qCR_SUSPEND = QCR_SUSPEND,
        qCR_RESUME = QCR_RESUME
    }qCR_ExternAction_t;

    typedef enum{
        _qCR_UNDEFINED = 0,
        _qCR_PC_INITVAL = -1,
        _qCR_PC_SUSPENDEDVAL = -2,
        _qCR_SEM_SIGNAL = -3,
        _qCR_SEM_TRYLOCK = -4
    }_qCR_Oper_t;

    /*Construction stataments*/
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
    #define _qCR_InitState             _qCRTaskState_ = { _qCR_PC_INITVAL, _qCR_UNDEFINED, QSTIMER_INITIALIZER }
    #define _qCR_TaskCheckPCJump(_PC_) switch(_PC_){    
    #define _qCR_TagExitCCR            _qCRYield_ExitLabel
    #define _qCR_Exit                  goto _qCR_TagExitCCR /*MISRAC deviation*/
    #define _qCR_TaskYield             _qCR_Exit;
    #define _qCR_Dispose               _qCR_SetPC(_qCR_PC_INITVAL);} _qCR_TagExitCCR:
    #define _qCR_Restorator(_VAL_)     case (_qCR_TaskPC_t)(_VAL_):            
    #define _qCR_SuspendPoint          default: _qCR_Exit
    #define _qCR_RestoreAfterYield     _qCR_Restorator(_qCR_TaskProgress)
    #define _qCR_RestoreFromBegin      _qCR_Restorator(_qCR_PC_INITVAL)
    #define _qCR_CatchHandle(h)        if( NULL == (h) ){ (h) = &_qCRTaskState_; }

    /*Core Statements*/
    #define qCR_TimeoutSet(_timeout_)               qSTimer_Set( &_qCR_DelayVar, _timeout_ )    
    #define qCR_TimeoutExpired( )                   qSTimer_Expired( &_qCR_DelayVar )
    #define _qCR_Start                              _qCR_Persistent  _qCR_InitState ; _qCR_TaskCheckPCJump(_qCR_TaskPCVar) _qCR_RestoreFromBegin
    #define _qCR_hStart(h)                          _qCR_Persistent  _qCR_InitState ; _qCR_CatchHandle(h)   _qCR_TaskCheckPCJump(_qCR_TaskPCVar) _qCR_SuspendPoint; _qCR_RestoreFromBegin
    #define _qCR_Yield                              _qCR_CodeStartBlock{ _qCR_SaveState              ; _qCR_TaskYield  _qCR_RestoreAfterYield; }                      _qCR_CodeEndBlock
    #define _qCR_Restart                            _qCR_CodeStartBlock{ _qCR_SetPC(_qCR_PC_INITVAL) ; _qCR_TaskYield }                                               _qCR_CodeEndBlock
    #define _qCR_wu_Assert(_cond_)                  _qCR_CodeStartBlock{ _qCR_SaveState              ; _qCR_RestoreAfterYield ; _qCR_Assert(_cond_) _qCR_TaskYield }  _qCR_CodeEndBlock
    #define _qCR_GetPosition(_pos_)                 _qCR_CodeStartBlock{ _qCR_SaveStateOn((_pos_))   ; _qCR_RestoreAfterYield ; Q_UNUSED((_pos_)); }              _qCR_CodeEndBlock
    #define _qCR_RestoreFromPosition(_pos_)         _qCR_CodeStartBlock{ _qCR_SetPC(_pos_)           ; _qCR_TaskYield }                                               _qCR_CodeEndBlock    
    #define _qCR_Delay(_time_)                      _qCR_CodeStartBlock{ qCR_TimeoutSet(_time_)      ; _qCR_SaveState;  _qCR_RestoreAfterYield;   _qCR_Assert( qCR_TimeoutExpired() ) _qCR_TaskYield } _qCR_CodeEndBlock
    #define _qCR_wu_TmrAssert(_cond_, _timeout_)    _qCR_CodeStartBlock{ qCR_TimeoutSet(_timeout_)   ; _qCR_SaveState         ; _qCR_RestoreAfterYield    ; _qCR_Assert((_cond_) || qCR_TimeoutExpired() ) _qCR_TaskYield }  _qCR_CodeEndBlock       
    #define _qCR_do                                 _qCR_CodeStartBlock{ _qCR_SaveState              ; _qCR_RestoreAfterYield;
    #define _qCR_until( _cond_ )                    _qCR_Assert(_cond_) _qCR_TaskYield }  _qCR_CodeEndBlock     
    #define _qCR_PositionReset(_pos_)               (_pos_) = _qCR_PC_INITVAL
    #define _qCR_wu_preAssert(_pre_ , _cond_)       _qCR_do{ (_pre_); }_qCR_until((_cond_))                            


    /*qCR_Begin{
    
    }qCR_End;
    
    Defines a Coroutine segment. Only one segment is allowed inside a task; 
    The <qCR_Begin> statement is used to declare the starting point of 
    a Coroutine. It should be placed at the start of the function in which the 
    Coroutine runs. <qCR_End> declare the end of the Coroutine. 
    It must always be used together with a matching <qCR_End> statement.

    */
    #define qCR_Begin                                       _qCR_Start
    /*qCR_BeginWithHandle( handle ){
    
    }qCR_End;
    
    Defines a Coroutine segment with a supplied external handle. 
    Only one segment is allowed inside a task; 
    The qCR_BeginWithHandle statement is used to declare the starting point of 
    a Coroutine. It should be placed at the start of the function in which the 
    Coroutine runs. <qCR_End> declare the end of the Coroutine. 
    It must always be used together with a matching <qCR_End> statement.

    */   
    #define qCR_BeginWithHandle( handle )                   _qCR_hStart( handle )
    /*qCR_Begin{
    
    }qCR_End;
    
    Ends a Coroutine segment. Only one segment is allowed inside a task; 
    The <qCR_End> statement is used to define the ending point of 
    a Coroutine. It should be placed at the end of the function in which the 
    Coroutine runs. 
    It must always be used together with a matching <qCR_Begin>/<qCR_BeginWithHandle>
    statement.

    */      
    #define qCR_End                                         _qCR_Dispose
    /*qCR_Yield

    This statement is only allowed inside a Coroutine segment. <qCR_Yield> 
    return the CPU control back to the scheduler but saving the execution progress. 
    With the next task activation, the Coroutine will resume the execution after 
    the last <qCR_Yield> statement.

    Action sequence : [Save progress] then [Yield]

    */     
    #define qCR_Yield                                       _qCR_Yield
    /*qCR_Restart

    This statement cause the running Coroutine to restart its execution at the 
    place of the <qCR_Begin> statement.

    Action sequence : [Reload progress] then [Yield]

    */
    #define qCR_Restart                                     _qCR_Restart 
    /*qCRWait_Until( condition )

    Yields until the logical condition being true

    Action sequence : [Save progress] 
                    IF ( condition == False ){
                        [Yield]      
                    }  

    */    
    #define qCR_WaitUntil( _condition_ )                    _qCR_wu_Assert( _condition_ )
    /*qCR_TimedWaitUntil( condition)

    Yields until the logical condition being true or the specified timeout expires

    Action sequence : [Save progress] 
                    IF ( condition == False || EXPIRED(timeout) ){
                        [Yield]      
                    }  

    */    
    #define qCR_TimedWaitUntil( _condition_, _timeout_ )    _qCR_wu_TmrAssert( _condition_,_timeout_ )
    
    /*qCR_Do

    This statement start a blocking Job segment. 
    Must be used together with a matching <qCR_Until> statement.  

    */    
    #define qCR_Do                                          _qCR_do
    /*qCR_Until( condition )

    This statement ends a blocking Job segment starting with the <qCR_Do> statement.   
    The condition determines if the blocking job ends (if condition is True)
    or continue yielding (if false)

    */         
    #define qCR_Until( _condition_ )                        _qCR_until( _condition_ )
    /*qCR_SemInit( qCR_Semaphore_t *sem, int Value )

    Initializes a semaphore with a value for the counter. Internally, the semaphores
    use an "unsigned int" to represent the counter,  therefore the <Value> 
    argument should be within range of an "unsigned int".

    Parameters:

        - sem :  A pointer to the qCR_Semaphore_t representing the semaphore

        - Value : The initial count of the semaphore.

    */          
    #define qCR_SemInit( _qCR_Semaphore_t_, _Value_ )       Q_UNUSED( _qCR_Sem( _qCR_Semaphore_t_, _Value_ ) )
    /*qCR_SemWait( qCR_Semaphore_t *sem )

    Carries out the "wait" operation on the semaphore. The wait operation causes 
    the Co-routine to block while the counter is zero. When the counter reaches a 
    value larger than zero, the Co-routine will continue.

    Parameters:

        - sem :  A pointer to the qCR_Semaphore_t object in which the 
                operation is executed

    */        
    #define qCR_SemWait( _qCR_Semaphore_t_ )                _qCR_wu_Assert( _qCR_Sem( _qCR_Semaphore_t_, _qCR_SEM_TRYLOCK ) ) 

    /*qCR_SemSignal( qCR_Semaphore_t *sem )

    Carries out the "signal" operation on the semaphore. The signal operation increments
    the counter inside the semaphore, which eventually will cause waiting Co-routines
    to continue executing.

    Parameters:

        - sem :  A pointer to the qCR_Semaphore_t object in which the 
                operation is executed

    */     
    #define qCR_SemSignal( _qCR_Semaphore_t_ )              Q_UNUSED( _qCR_Sem( _qCR_Semaphore_t_, _qCR_SEM_SIGNAL ) )
    /*qCR_PositionGet( qCR_Position_t CRPos ) 

    Labels the current position and saves it to <CRPos> so it can be later restored by <qCR_PositionRestore>

    */    
    #define qCR_PositionGet( _CRPos_ )                      _qCR_GetPosition( _CRPos_ )
    /*qCR_PositionRestore( qCR_Position_t CRPos ) 

    Restores the Co-Routine position saved in <CRPos>

    */   
    #define qCR_PositionRestore( _CRPos_ )                  _qCR_RestoreFromPosition(_CRPos_)
    /*qCR_PositionReset( qCR_Position_t CRPos ) 

    Resets the <CRPos> variable to the begining of the Co-Routine

    */ 
    #define qCR_PositionReset( _CRPos_ )                    _qCR_PositionReset( _CRPos_ )
    /*qCR_Delay( qTime_t time )  

    Delay a coroutine for a given number of time

    Parameters:

        - time :  The amount of time (In seconds), that the calling coroutine should yield.

    */        
    #define qCR_Delay( _qTime_t_ )                          _qCR_Delay( _qTime_t_ )


    void qCR_ExternControl( qCR_Handle_t h, const qCR_ExternAction_t action,  const qCR_ExtPosition_t pos );
    qBool_t _qCR_Sem( qCR_Semaphore_t * const sem,  const _qCR_Oper_t oper );

    #ifdef __cplusplus
    }
    #endif

#endif
