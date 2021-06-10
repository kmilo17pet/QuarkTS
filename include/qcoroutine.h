/*!
 * @file qcoroutine.h
 * @author J. Camilo Gomez C.
 * @version 3.71
 * @note This file is part of the QuarkTS distribution.
 * @brief  API interface for the Co-Routine module.
 **/
#ifndef QCOROUTINE_H
    #define QCOROUTINE_H

    #include "qtypes.h"
    #include "qstimers.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    /** \addtogroup  qcoroutines
    * @brief API interface for the Co-Routine module.
    *  @{
    */

    /*! @cond  */
    typedef qINT32_t _qCR_TaskPC_t;   
    typedef _qCR_TaskPC_t qCR_ExtPosition_t;
   /*! @endcond  */

    /** @brief A typedef to hold Co-Routine current position or progress*/
    #define qCR_Position_t static _qCR_TaskPC_t
    
    /* Please don't access any members of this structure directly */
    /*! @cond  */
    typedef struct _qCR_Instance_s{
        _qCR_TaskPC_t instr;    /*< Used to hold the local continuation. */
        _qCR_TaskPC_t prev;     /*< Temporally holds the local continuation during a coroutine suspension*/
        qSTimer_t crdelay;      /*< Used to hold the required delay for #qCR_Delay. */
    }_qCR_Instance_t;
    /*! @endcond  */

    /** @brief A typedef to instantiate a Co-Routine handle*/
    typedef _qCR_Instance_t *qCR_Handle_t;

    /** @brief A typedef to instantiate a Co-Routine Semaphore*/
    typedef struct _qCR_Semaphore_s{ 
        /*! @cond  */
        size_t count; 
        /*! @endcond  */
    }qCR_Semaphore_t; 
    
    /*! @cond  */
    #define QCR_RESTART     ( 0 )
    #define QCR_POSITIONSET ( 1 )
    #define QCR_SUSPEND     ( 2 )
    #define QCR_RESUME      ( 3 )
    /*! @endcond  */

    /** 
    * @brief An enumeration to define the possible actions that can be performed outside the context of a Co-Routine
    */
    typedef enum{
        qCR_RESTART = QCR_RESTART,          /**< Restart the coroutine execution at the place of the #qCR_BeginWithHandle statement.*/ 
        qCR_POSITIONSET = QCR_POSITIONSET,  /**< Force the coroutine execution at the position specified in qCR_ExternControl(). If a non-valid position is supplied, the Co-routine segment will be suspended.*/ 
        qCR_SUSPEND = QCR_SUSPEND,          /**< Suspend the entire coroutine segment. The task will still running instructions outside the segment. */ 
        qCR_RESUME = QCR_RESUME             /**< Resume the entire coroutine segment at the point where it had been left before the suspension. */ 
    }qCR_ExternAction_t;

    /*! @cond  */
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
    #define _qCR_Exit                  goto _qCR_TagExitCCR
    #define _qCR_TaskYield             _qCR_Exit;
    #define _qCR_Dispose               _qCR_SetPC(_qCR_PC_INITVAL);} _qCR_TagExitCCR:
    #define _qCR_Restorator(_VAL_)     case (_qCR_TaskPC_t)(_VAL_):            
    #define _qCR_SuspendPoint          default: _qCR_Exit
    #define _qCR_RestoreAfterYield     _qCR_Restorator(_qCR_TaskProgress)
    #define _qCR_RestoreFromBegin      _qCR_Restorator(_qCR_PC_INITVAL)
    #define _qCR_CatchHandle(h)        if( NULL == (h) ){ (h) = &_qCRTaskState_; }

    /*! @endcond */

    /**
    * @brief Set the internal Co-routine timeout to the specified time.
    * @param tValue The specific amount of time to wait given in seconds.
    * @return none.
    */     
    #define qCR_TimeoutSet( tValue )                qSTimer_Set( &_qCR_DelayVar, tValue )    

    /**
    * @brief  Check if the internal Co-routine timeout expires.
    * @return #qTrue when STimer expires, otherwise, returns #qFalse.
    */         
    #define qCR_TimeoutExpired( )                   qSTimer_Expired( &_qCR_DelayVar )

    /*! @cond  */
    /*Core Statements*/
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
    /*! @endcond  */
    
    /**
    * @brief Defines a Coroutine segment. Only one segment is allowed inside a task; 
    * The #qCR_Begin statement is used to declare the starting point of 
    * a Coroutine. It should be placed at the start of the function in which the 
    * Coroutine runs. #qCR_End declare the end of the Coroutine. 
    * It must always be used together with a matching #qCR_End statement.
    * Example:
    * @code{.c}
    * qCR_Begin{
    * 
    * }qCR_End;
    * @endcode
    */      
    #define qCR_Begin                                   _qCR_Start

    /**
    * @brief Defines a Coroutine segment with a supplied external handle. 
    * Only one segment is allowed inside a task.
    * The #qCR_BeginWithHandle statement is used to declare the starting point of 
    * a Coroutine. It should be placed at the start of the function in which the 
    * Coroutine runs. #qCR_End declare the end of the Coroutine. 
    * @note It must always be used together with a matching #qCR_End statement.
    * @param[in] handle The handle of a coroutine (qCR_Handle_t)
    * 
    * Example:
    * @code{.c}
    * qCR_BeginWithHandle( handle ){
    * 
    * }qCR_End;
    * @endcode
    */       
    #define qCR_BeginWithHandle( handle )               _qCR_hStart( handle )

    /**
    * @brief Ends a Coroutine segment. Only one segment is allowed inside a task; 
    * The #qCR_End statement is used to define the ending point of 
    * a Coroutine. It should be placed at the end of the function in which the 
    * Coroutine runs. 
    * @note It must always be used together with a matching #qCR_Begin/#qCR_BeginWithHandle
    * statement.
    * 
    * Example:
    * @code{.c}
    * qCR_Begin{
    * 
    * }qCR_End;
    * @endcode
    */          
    #define qCR_End                                     _qCR_Dispose  

    /**
    * @brief  This statement is only allowed inside a Coroutine segment. #qCR_Yield 
    * return the CPU control back to the scheduler but saving the execution progress. 
    * With the next task activation, the Coroutine will resume the execution after 
    * the last #qCR_Yield statement.
    * @verbatim Action sequence : [Save progress] then [Yield] @endverbatim
    */        
    #define qCR_Yield                                   _qCR_Yield

    /**
    * @brief This statement cause the running Coroutine to restart its execution at the 
    * place of the #qCR_Begin statement.
    * @verbatim Action sequence : [Reload progress] then [Yield] @endverbatim
    */     
    #define qCR_Restart                                 _qCR_Restart   

    /**
    * @brief Yields until the logical condition being true
    * @see #qCR_TimedWaitUntil
    * @param[in] bCondition The logical condition to be evaluated
    * @verbatim
     Action sequence : [Save progress] 
                     IF ( condition == False ){
                         [Yield]      
                     }
      @endverbatim 
    */      
    #define qCR_WaitUntil( bCondition )                 _qCR_wu_Assert( bCondition )

    /**
    * @brief  Yields until the logical condition being true or the specified timeout expires.
    * @see #qCR_WaitUntil
    * @param[in] bCondition The logical condition to be evaluated.
    * @param[in] tValue The specific amount of time to wait given in seconds.
    * @verbatim
     Action sequence : [Save progress] 
                     IF ( condition == False || NOT_EXPIRED(timeout) )
                         [Yield]      
                     }
     @endverbatim 
    */    
    #define qCR_TimedWaitUntil( bCondition, tValue )    _qCR_wu_TmrAssert( bCondition, tValue )

    /**
    * @brief  This statement start a blocking Job segment. 
    * @note Must be used together with a matching #qCR_Until statement.  
    * Example:
    * @code{.c}
    * qCR_Do{
    *     
    * }qCR_Until( Condition );
    * @endcode
    */     
    #define qCR_Do                                      _qCR_do   

    /**
    * @brief  This statement ends a blocking Job segment starting with the #qCR_Do statement.   
    * @param[in] bCondition The logical condition to be evaluated.
    * The condition determines if the blocking job ends (if condition is True)
    * or continue yielding (if false)
    * @note Must be used together with a matching #qCR_Do statement.  
    * Example:
    * @code{.c}
    * qCR_Do{
    *    
    * }qCR_Until( Condition );
    * @endcode 
    */     
    #define qCR_Until( bCondition )                     _qCR_until( bCondition )
     
    /**
    * @brief Initializes a semaphore with a value for the counter. Internally, the semaphores
    * use an "unsigned int" to represent the counter,  therefore the @a sValue 
    * argument should be within range of an "unsigned int".
    * @param[in] pSem A pointer to the qCR_Semaphore_t representing the semaphore
    * @param[in] sValue The initial count of the semaphore.
    * @return none.
    */     
    #define qCR_SemInit( pSem, sValue )                 Q_UNUSED( _qCR_Sem( pSem, sValue ) )
    
    /**
    * @brief Carries out the "wait" operation on the semaphore. The wait operation causes 
    * the Co-routine to block while the counter is zero. When the counter reaches a 
    * value larger than zero, the Co-routine will continue.
    * @param[in] pSem A pointer to the qCR_Semaphore_t object in which the 
    * operation is executed
    * @return none.
    */    
    #define qCR_SemWait( pSem )                         _qCR_wu_Assert( _qCR_Sem( pSem, _qCR_SEM_TRYLOCK ) ) 

    /**
    * @brief Carries out the "signal" operation on the semaphore. The signal operation increments
    * the counter inside the semaphore, which eventually will cause waiting Co-routines
    * to continue executing.
    * @param[in] pSem A pointer to the qCR_Semaphore_t object in which the 
    * operation is executed
    * @return none.
    */     
    #define qCR_SemSignal( pSem )                       Q_UNUSED( _qCR_Sem( pSem, _qCR_SEM_SIGNAL ) )

    /**
    * @brief Labels the current position and saves it to @a CRPos so it can be later 
    * restored by #qCR_PositionRestore
    * @param[out] CRPos The variable of type qCR_Position_t where the current position will be saved.
    * @return none.
    */        
    #define qCR_PositionGet( CRPos )                    _qCR_GetPosition( CRPos )
   
    /**
    * @brief Restores the Co-Routine position saved in @a CRPos
    * @param[in,out] CRPos The variable of type qCR_Position_t that contains the position to be restored.
    * @return none.
    */     
    #define qCR_PositionRestore( CRPos )                _qCR_RestoreFromPosition( CRPos )

    /**
    * @brief Resets the @a CRPos variable to the begining of the Co-Routine
    * @param[in,out] CRPos The variable of type qCR_Position_t to reset.
    * @return none.
    */     
    #define qCR_PositionReset( CRPos )                  _qCR_PositionReset( CRPos )

    /**
    * @brief Delay a coroutine for a given number of time
    * @param[in] tValue The amount of time (In seconds), that the calling coroutine should yield.
    * @return none.
    */       
    #define qCR_Delay( tValue )                         _qCR_Delay( tValue )

    /**
    * @brief Perform an external action over the requested Co-routine
    * @see #qCR_BeginWithHandle
    * @param[in] h The Co-routine handle.
    * @param[in] action The specific action to perform, should be one of the following: 
    * ::qCR_RESTART, ::qCR_SUSPEND, ::qCR_RESUME or ::qCR_POSITIONSET.
    * @param[in] pos The required position if @a action = ::qCR_POSITIONSET. For other actions
    * this argument its ignored. 
    * @return none.
    */   
    void qCR_ExternControl( qCR_Handle_t h, const qCR_ExternAction_t action,  const qCR_ExtPosition_t pos );

    /*! @cond  */
    qBool_t _qCR_Sem( qCR_Semaphore_t * const sem,  const _qCR_Oper_t oper );
    /*! @endcond */

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
