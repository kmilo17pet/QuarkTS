/*!
 * @file qfsm.h
 * @author J. Camilo Gomez C.
 * @version 5.30
 * @note This file is part of the QuarkTS distribution.
 * @brief  API interface of the Finite State Machine (FSM) module.
 **/
#ifndef Q_FSM_H
    #define Q_FSM_H

    #include "qtypes.h"
    #include "qqueues.h"
    #include "qstimers.h"

    #ifdef __cplusplus
    extern "C" {
    #endif
    

    #ifndef Q_FSM
        #define Q_FSM                   ( 1 )
    #endif
    
    #ifndef Q_FSM_MAX_NEST_DEPTH
        #define Q_FSM_MAX_NEST_DEPTH    ( 5 )
    #endif    
   
    #ifndef Q_FSM_MAX_TIMEOUTS
        #define Q_FSM_MAX_TIMEOUTS      ( 3 )
    #endif 

    #if ( Q_FSM_MAX_NEST_DEPTH < 1 )
        #error Q_FSM_MAX_NEST_DEPTH must be defined to be greater than or equal to 1.
    #endif

    #if ( ( Q_FSM_MAX_TIMEOUTS < 1 ) || ( Q_FSM_MAX_TIMEOUTS > 32 ) ) /*just to avoid overhead*/
        #error Q_FSM_MAX_TIMEOUTS must be defined with a value between 1 to 32.
    #endif

    /** @addtogroup  qfsm Finite State Machines
     * @brief API interface of the Finite State Machine (FSM) module.
     *  @{
     */

    /**
    * @brief This macro can be used to reference the top state when using the qStateMachine_StateSubscribe() API.
    */ 
    #define QSM_STATE_TOP               ( NULL )   

    /*FSM internal signals*/

    /**
    * @brief Built-in signal that can be used to set a nested initial-transition (aka default transition) 
    * by writing the qSM_Handler_t::StartState member.
    * @note Transitions by setting the qSM_Handler_t::NextState member are not allowed here
    */
    #define QSM_SIGNAL_START            ( (qSM_Signal_t)0xFFFFFFFFuL )
    /**
    * @brief Built-in signal to indicate if the current state has just exit to another state.
    * @note Transitions are not allowed here
    */
    #define QSM_SIGNAL_EXIT             ( (qSM_Signal_t)0xFFFFFFFEuL )
    /**
    * @brief Built-in signal to indicate if the current state has just entered from another state.
    * @note Transitions are not allowed here
    */ 
    #define QSM_SIGNAL_ENTRY            ( (qSM_Signal_t)0xFFFFFFFDuL )
    /**
    * @brief Built-in signal to indicate that there is not signal available.
    */     
    #define QSM_SIGNAL_NONE             ( (qSM_Signal_t)0xFFFFFFFCuL )
    /**
    * @brief Built-in signal to indicate that a timeout expiration event occurs.
    * @param index The index of the timeout (0, 1, 2 ... (Q_FSM_MAX_TIMEOUTS-1) )
    */      
    #define QSM_SIGNAL_TIMEOUT(index)   ( (qSM_Signal_t)0xFFFFFFFBuL - (qSM_Signal_t)(Q_FSM_MAX_TIMEOUTS-1) + (qSM_Signal_t)(index) )   
    
    /**
    * @brief Timeout-specification option. Should be used to specify the timeout index.
    * @note Can be combined with a bitwise OR
    */
    #define QSM_TSOPT_INDEX(index)      ( ( (qSM_TimeoutSpecOptions_t)0x00FFFFFFuL & (qSM_TimeoutSpecOptions_t)index) )  /*to select the timeout to be used in the specification*/    
    /**
    * @brief This timeout-specification option its used to specify that the engine should set the timeout when the specified state its entering.
    * @note Can be combined with a bitwise OR
    */
    #define QSM_TSOPT_SET_ENTRY         ( (qSM_TimeoutSpecOptions_t)0x01000000uL )
    /**
    * @brief This timeout-specification option its used to specify that the engine should reset the timeout when the specified state its entering.
    * @note Can be combined with a bitwise OR
    */    
    #define QSM_TSOPT_RST_ENTRY         ( (qSM_TimeoutSpecOptions_t)0x02000000uL )
    /**
    * @brief This timeout-specification option its used to specify that the engine should set the timeout when the specified state its exiting*.
    * @note Can be combined with a bitwise OR
    */      
    #define QSM_TSOPT_SET_EXIT          ( (qSM_TimeoutSpecOptions_t)0x04000000uL )
    /**
    * @brief This timeout-specification option its used to specify that the engine should reset the timeout when the specified state its exiting*.
    * @note Can be combined with a bitwise OR
    */          
    #define QSM_TSOPT_RST_EXIT          ( (qSM_TimeoutSpecOptions_t)0x08000000uL )
    /**
    * @brief This timeout-specification option its used to specify that the engine should set the timeout only if it is in reset state*.
    * @note Can be combined with a bitwise OR
    */      
    #define QSM_TSOPT_KEEP_IF_SET       ( (qSM_TimeoutSpecOptions_t)0x10000000uL )
    /**
    * @brief This timeout-specification option its used setup the timeout in periodic mode*.
    * @note Can be combined with a bitwise OR
    */         
    #define QSM_TSOPT_PERIODIC          ( (qSM_TimeoutSpecOptions_t)0x20000000uL )  /*to mark the timeout as periodic*/    
    
    /**
    * @brief Minimum value that can be used for an user-defined signal
    */  
    #define QSM_SIGNAL_RANGE_MIN        ( (qSM_Signal_t)0u )
    /**
    * @brief Maximum value that can be used for an user-defined signal
    */      
    #define QSM_SIGNAL_RANGE_MAX        ( (qSM_Signal_t)(0xFFFFFFFBuL - (qSM_Signal_t)Q_FSM_MAX_TIMEOUTS  ) )
    /**
    * @brief The start value for an user-defined signal
    */         
    #define QSM_SIGNAL_USER             ( QSM_SIGNAL_RANGE_MIN )

    /** 
     * @brief The type to be used as a container variable for a signal.
     */
    typedef qUINT32_t qSM_Signal_t;

    /**
    * @brief This enumeration defines the built-in state-execution status values 
    * that can be used as return value in a state callback.
    */    
    typedef enum {
        qSM_STATUS_BEFORE_ANY = -32767,         /**< (Only available in the surrounding callback) Indicates an execution of the surrounding callback before launching the state callback.*/
        qSM_STATUS_NULL = -32766,               /**< Not to be used at the application level. This value is reserved for use.*/
        qSM_STATUS_EXIT_FAILURE = -32765,       /**< To indicate that the state had a failure or abnormal execution. It can be used to handle exceptions.*/
        qSM_STATUS_EXIT_SUCCESS = -32764,       /**< To indicate that the status was successful.*/
        qSM_STATUS_SIGNAL_HANDLED = -32763      /**< To indicate that the state handled the signal and therefore it is not necessary to continue propagating the signal through the rest of the hierarchy*/
    }qSM_Status_t; 

    /**
    * @brief This enumeration defines the possible modes to perform a transistion to history  
    */    
    typedef enum {
        qSM_TRANSITION_NO_HISTORY = 0,          /**< History is not preserved. Composite states will start according to their default transition.*/
        qSM_TRANSITION_SHALLOW_HISTORY,         /**< History will be kept to allow the return to only the top-most sub-state of the most recent state configuration, which is entered using the default entry rule.*/
        qSM_TRANSITION_DEEP_HISTORY,            /**< History will be kept to allow full state configuration of the most recent visit to the containing region.*/
    }qSM_TransitionHistoryMode_t;

    /*fields for the qSM_Handler_t pointer*/
    
    /*! @cond  */
    #define _qSM_HANDLER_FIELDS( pAttrib ) struct{\
        void *StartState;\
        void *NextState;\
        pAttrib void *machine;\
        pAttrib void *state;\
        pAttrib void *Data;\
        pAttrib void *StateData;\
        pAttrib qSM_Signal_t Signal;\
        pAttrib qSM_Status_t Status;\
        qSM_TransitionHistoryMode_t TransitionHistory;\
    };\
    /*! @endcond */

    /*! @cond  */
    typedef struct _qSM_uPublicData_s{ _qSM_HANDLER_FIELDS( Q_NONE ) }_qSM_UnprotectedPublicData_t;
    typedef struct _qSM_pPublicData_s{ _qSM_HANDLER_FIELDS( const  ) }_qSM_ProtectedPublicData_t;
    typedef _qSM_UnprotectedPublicData_t* qSM_UnprotectedHandler_t;    
    typedef _qSM_ProtectedPublicData_t* const qSM_Handler_t;  
    /*! @endcond */
    
    #ifdef DOXYGEN
    /** 
    * @brief The callback argument to handle the state-machine dynamics and provide execution information.
    * Some members can be written to perform state-transtions.
    * @note Should be used only in state-callbacks as the only input argument. 
    * @note The members of this structure must be accessed as a pointer.
    */    
    typedef struct{
        void *StartState;                               /**< Used to set the initial state (default transition) if the current state its a parent.*/
        void *NextState;                                /**< Used to produce a transition to the desired state. */
        const void *machine;                            /**< A pointer to the state machine object. */
        const void *state;                              /**< A pointer to the state that its currently evaluated.*/
        const void *Data;                               /**< The user storage pointer*/
        const void *StateData;                          /**< The state user storage pointer*/
        const qSM_Signal_t Signal;                      /**< The signal that its currently evaluated*/
        const qSM_Status_t Status;                      /**< The last state return status. Only available in the surrounding callback. */
        qSM_TransitionHistoryMode_t TransitionHistory;  /**< Used to set the behavior of a transition to history. ::qSM_TRANSITION_NO_HISTORY by default*/
    }qSM_Handler_t;  
    #endif
    
    /**
    * @brief Pointer to a function that represents a state callback
    * @code{.c}
    * qSM_Status_t myState_Callback( qSM_Handler_t h ){
    *       qSM_Status_t retVal = qSM_STATUS_EXIT_SUCCESS;
    *       switch( h->Signal ){
    *           case QSM_SIGNAL_ENTRY:
    *               break;
    *           case QSM_SIGNAL_EXIT:
    *               break;
    *           case USER_SIGNAL:
    *               retVal = qSM_STATUS_SIGNAL_HANDLED;
    *               break;
    *           default:
    *               break;
    *       return retVal;
    * }
    * @endcode
    * @param h The object that handles the state machine
    * @return The execution status of the state.
    */
    typedef qSM_Status_t (*qSM_StateCallback_t)( qSM_Handler_t arg ); 

    /**
    * @brief Pointer to a function that represents a surrounding callback
    * @code{.c}
    * void surrounding_Callback( qSM_Handler_t h ){
    *       switch( h->Status ){
    *           case qSM_STATUS_BEFORE_ANY:
    *               break;
    *           case qSM_STATUS_EXIT_SUCCESS:
    *               break;
    *           case qSM_STATUS_EXIT_FAILURE:
    *               break;
    *           default:
    *               break;
    * }
    * @endcode
    * @param h The object that handles the state machine
    * @return The execution status of the state.
    */    
    typedef void (*qSM_SurroundingCallback_t)( qSM_Handler_t arg );

    /**
    * @brief Pointer to a function that represents a signal guard/action
    * @code{.c}
    * qBool_t signalAction_Callback( qSM_Handler_t h ){
    *       qBool_t retVal = qFalse
    *       if ( ConditionGuard ){
    *           performSomeAction();
    *           retVal = qTrue;
    *       }
    *       return retVal;
    * }
    * @endcode
    * @param h The object that handles the state machine
    * @return The execution status of the state.
    */       
    typedef qBool_t (*qSM_SignalAction_t)( qSM_Handler_t arg );

    /** 
    * @brief A typedef to hold the timeout specification options.
    */        
    typedef qUINT32_t qSM_TimeoutSpecOptions_t;


    /**
    * @brief This structure should be used to define an item for a timeout-specification table. 
    */
    typedef struct _qSM_TimeoutStateDefinition_s{
        qTime_t xTimeout;                                   /**< The value that the timeout will use*/
        qSM_TimeoutSpecOptions_t options;                   /**< Timeout options. This includes the index of the timeout to be used */
    }qSM_TimeoutStateDefinition_t;

    /** 
    * @brief A state object
    * @details  States are represented as instances of the qSM_State_t object.
    * One important attribute of this object is the callback function, which is used to describe
    * the behavior specific to the state. Also there is a pointer to the parent state to define
    * nesting of the state and its place in the hierarchical topology.
    * 
    * So concrete state machine are built by adding an arbitrary number states and defining 
    * callback functions. 
    * 
    * State  machines  are constructed by composition, therefore, the topology of a state machine 
    * is determined upon construction. In this module implementation, there are not distinction between
    *  composite states(states containing substates) and leaf states. All states are potentially composite. 
    * 
    * The API qStateMachine_StateSubscribe() should be used to initialize the state and define its
    * position in the topology.
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qSM_State_s{
        /*! @cond  */
        struct _qSM_State_Private_s{
            struct _qSM_State_s *parent;                    /*< A pointer to the parent state*/
            struct _qSM_State_s *lastRunningChild;          /*< The last running child state*/
            struct _qSM_State_s *initState;                 /*< The initial state of this parent*/
            qSM_StateCallback_t sCallback;                  /*< The state callback function*/
            qSM_TimeoutStateDefinition_t *tdef;             /*< The timeout state definition*/
            void *tTable;                                   /*< A pointer to the transition table.*/
            void* Data;                                     /*< State data. Storage pointer*/
            size_t tEntries;                                /*< Number of entries on <tTable>*/
            size_t nTm;                                     /*< Number of entries on <tdef>*/
        }qPrivate;
        /*! @endcond  */
    }qSM_State_t;
      
    /** 
    * @brief A FSM Timeout-specification object
    * @note Do not access any member of this structure directly. 
    */    
    typedef struct _qSM_TimeoutSpec_s{
        /*! @cond  */
        qSTimer_t builtin_timeout[ Q_FSM_MAX_TIMEOUTS ];    /*< the built-in timeouts*/     
        qUINT32_t isPeriodic;                               /*< witch one is periodic*/
        /*! @endcond  */
    }qSM_TimeoutSpec_t;

    /** 
    * @brief A FSM(Finite State Machine) object
    * @details In QuarkTS, a state-machine must be instantiated with an object of type qSM_t. 
    * 
    * Like any other OS object, a Finite State Machine (FSM) must be explicitly initialized before it can be used.
    * The qStateMachine_Setup() initializes the instance, sets the callback for the top state, sets the initial
    * state and the surrounding callback function.
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qSM_s{
        /*! @cond  */
        struct _qSM_Private_s{
            qSM_State_t *current;                           /*< A pointer to the current state.*/
            qSM_State_t *next;                              /*< The next state to execute. */
            qSM_State_t *source;                            /*< Source state during the last transition*/
            void *Data;                                     /*< The user storage-pointer*/
            #if ( Q_QUEUES == 1 )
                qQueue_t *queue;                            /*< A pointer to the signal queue.*/
            #endif
            qSM_TimeoutSpec_t *TimeSpec;                    /*< A pointer to the timeout specification object*/
            qSM_SurroundingCallback_t surrounding;          /*< An callback to handle actions after and before any state. */
            qSM_State_t top;                                /*< The top most state*/
            _qSM_UnprotectedPublicData_t handler;           /*< The FSM handler argument*/    
            qSM_Signal_t SignalNot;                         /*< Signal exclusion variable*/
        }qPrivate;   
        /*! @endcond  */      
    }qSM_t;

    /**
    * @brief This structure should be used to define an item for a state transition table. 
    */
    typedef struct _qSM_Transition_s{
        qSM_Signal_t xSignal;                               /**< The signal that will produce the transition*/
        qSM_SignalAction_t Guard;                           /**< The signal guard/action*/
        qSM_State_t *NextState;                             /**< A pointer to the next state after the transition*/
        qSM_TransitionHistoryMode_t HistoryMode;            /**< To set the history mode for a transition*/
    }qSM_Transition_t;
    
    /**
    * @brief This enumeration defines the attributes that can be acquired for a FSM or a state.
    */
    typedef enum{
        qSM_ATTRIB_STATE_TOP,                               /**< Only for qStateMachine_Get_Machine() : Get a pointer to the top state*/
        qSM_ATTRIB_STATE_CURRENT,                           /**< Only for qStateMachine_Get_Machine() : Get a pointer to the current running state*/
        qSM_ATTRIB_SIGNAL_QUEUE,                            /**< Only for qStateMachine_Get_Machine() : Get a pointer to the signal-queue object if installed*/
        qSM_ATTRIB_TIMESPEC,                                /**< Only for qStateMachine_Get_Machine() : Get a pointer to the timeout specification object if installed*/
        qSM_ATTRIB_TRANSITION_TABLE,                        /**< Only for qStateMachine_Get_State() : Get a pointer to the transition table if available*/
        qSM_ATTRIB_DATA,                                    /**< Get the user data ( storage-pointer ) */
        qSM_ATTRIB_COMPOSITE_INITSTATE,                     /**< Only for qStateMachine_Get_State() : Get the initial default or initial state, if input is composite*/
        qSM_ATTRIB_COMPOSITE_LASTSTATE,                     /**< Only for qStateMachine_Get_State() : Get the last state, if input is composite*/
        qSM_ATTRIB_COMPOSITE_PARENT,                        /**< Only for qStateMachine_Get_State() : Get the parent state, if input is a child*/
    }qSM_Attribute_t;

    /**
    * @brief Execute the Finite State Machine (FSM).
    * @see qOS_Add_StateMachineTask()
    * @param[in] m A pointer to the FSM object.
    * @param[in] xSignal User-defined signal (this value will be ignored if the installed queue 
    * has items available)
    * @note A signal coming from the signal-queue has the higher precedence. The user-defined
    * signal can be overridden
    * @return #qTrue if the signal was successfully handled, otherwise returns #qFalse.
    */        
    qBool_t qStateMachine_Run( qSM_t * const m, qSM_Signal_t xSignal );

    /**
    * @brief Initializes a Finite State Machine (FSM).
    * @see qOS_Add_StateMachineTask()
    * @note This API also initializes the top state.
    * @param[in] m A pointer to the FSM object.
    * @param[in] topCallback The callback for the "Top" state
    * @param[in] initState The first state to be executed (init-state or default transition). 
    * @param[in] surrounding The surrounding callback. To ignore pass NULL      
    * @param[in] Data Represents the FSM arguments. User storage pointer. To ignore pass NULL.
    * @return Returns #qTrue on Success, otherwise returns #qFalse.
    */   
    qBool_t qStateMachine_Setup( qSM_t * const m, qSM_StateCallback_t topCallback, qSM_State_t * const initState, qSM_SurroundingCallback_t surrounding, void *Data );
    
    /**
    * @brief This function subscribes the FSM instance to a specific state with an associated 
    * callback function. 
    * @param[in] m A pointer to the FSM object.
    * @param[in] state A pointer to the state object.
    * @param[in] parent A pointer to the parent state (Use #QSM_STATE_TOP) if the parent is the top state.
    * @param[in] StateFcn The handler function associated to the state.
    *
    * Prototype: @code qSM_Status_t xCallback( qSM_Handler_t h ) @endcode
    * @param[in] initState The first child-state to be executed if the subscribed 
    * state its a parent in an hierarchical pattern. (default transition).
    * To ignore pass NULL as argument.
    * @param[in] Data State data. Storage pointer. To ignore pass NULL.
    * @return #qTrue on success, otherwise return #qFalse.
    */     
    qBool_t qStateMachine_StateSubscribe( qSM_t * const m, qSM_State_t * const state, qSM_State_t * const parent, qSM_StateCallback_t StateFcn, qSM_State_t * const initState, void *Data );
       
    /**
    * @brief Installs a table with the outgoing transitions for the supplied state.
    * @param[in] state A pointer to the state object.
    * @param[in] table An array of entries of type qSM_Transition_t with the outgoing 
    * transitions. Each entry relates signals, actions and the target state using the 
    * following layout: 
    * @verbatim { [Signal], [Action/Guard],  [Target state],  [History Mode] } @endverbatim
    * @param[in] n The number of elements inside @a table. 
    * @return #qTrue on success, otherwise return #qFalse.
    */        
    qBool_t qStateMachine_Set_StateTransitions( qSM_State_t * const state, qSM_Transition_t * const table, const size_t n );

    /**
    * @brief Install a signal queue to the provided Finite State Machine (FSM).
    * @note Queue object should be previously initialized by using qQueue_Setup()
    * @attention Queue itemsize == qSM_Signal_t 
    * @param[in] m A pointer to the FSM object.
    * @param[in] queue A pointer to the queue object.
    * @return #qTrue on success, otherwise return #qFalse.
    */      
    qBool_t qStateMachine_InstallSignalQueue( qSM_t * const m, qQueue_t *queue );

    /**
    * @brief Sends a signal to the provided state machine.
    * @note If the signal queue is not available, an exclusion variable will be used.
    * This means that the signal cannot be sent until the variable is empty. 
    * (the signal was handled by the state-machine engine).
    * @note The signal-queue has the highest precedence.    
    * @param[in] m A pointer to the FSM object.
    * @param[in] xSignal  The user-defined signal.
    * @param[in] isUrgent If qTrue, the signal will be sent to the front of the queue. (only if the
    * there is a signal-queue available)
    * @return #qTrue if the provided signal was successfully delivered to the FSM, otherwise 
    * return #qFalse. #qFalse if there is a queue, and the signal cannot be inserted because it is full.
    */      
    qBool_t qStateMachine_SendSignal( qSM_t * const m, qSM_Signal_t xSignal, const qBool_t isUrgent );

    /**
    * @brief Install the Timeout-specification object to target FSM to allow timed 
    * signals within states ( See the #QSM_SIGNAL_TIMEOUT signal ). 
    * @attention This feature its only available if the FSM has a signal-queue installed.
    * @note You can increse the number of available timeouts instances by changing 
    * the @b Q_FSM_MAX_TIMEOUTS configuration macro inside @b qconfig.h          
    * @see qStateMachine_InstallSignalQueue()  
    * @param[in] m A pointer to the FSM object.
    * @param[in] ts A pointer to the timeout specification object.
    * @return Returns #qTrue on success, otherwise returns #qFalse.
    */    
    qBool_t qStateMachine_InstallTimeoutSpec( qSM_t * const m,  qSM_TimeoutSpec_t * const ts );
   
    /**
    * @brief Setup fixed timeouts for the specified state using a lookup-table. 
    * @attention This feature its only available if the FSM has a signal-queue installed.
    * @note The container state-machine must have a timeout-specification installed.
    * @note The lookup table should be an array of type qSM_TimeoutStateDefinition_t
    *  with @a nEntries elements matching { time, options }. 
    * @see qStateMachine_InstallSignalQueue(),  qStateMachine_InstallTimeoutSpec()       
    * @param[in] state A pointer to the state object.
    * @param[in] tdef  The lookup table matching the requested timeout values with their 
    * respective options.
    * @verbatim { [Timeout value], [Options(Combined with a bitwise OR)] } @endverbatim
    * @param[in] n The number of elements inside @a tdef. 
    * @return Returns #qTrue on success, otherwise returns #qFalse.
    */    
    qBool_t qStateMachine_Set_StateTimeouts( qSM_State_t * const state, qSM_TimeoutStateDefinition_t *tdef, const size_t n );

    /**
    * @brief Set the time for the selected built-in timeout inside the target FSM.
    * @note Requires an installed timeout-specification. For this use qStateMachine_InstallTimeoutSpec()
    * @note Requires an installed signal-queue. For this use qStateMachine_InstallSignalQueue()      
    * @param[in] m A pointer to the FSM object.
    * @param[in] xTimeout The index of the requested timeout (0, 1, 2 ... (Q_FSM_MAX_TIMEOUTS-1) )
    * @param[in] xTime The specified time usually given in seconds.
    * @return Returns #qTrue on success, otherwise returns #qFalse.
    */     
    qBool_t qStateMachine_TimeoutSet( qSM_t * const m, const qIndex_t xTimeout, const qTime_t xTime );

    /**
    * @brief Stop the time count for the selected built-in timeout.
    * @note Requires an installed timeout-specification. For this use qStateMachine_InstallTimeoutSpec()
    * @note Requires an installed signal-queue. For this use qStateMachine_InstallSignalQueue()      
    * @param[in] m A pointer to the FSM object.
    * @param[in] xTimeout The index of the timeout (0, 1, 2 ... (Q_FSM_MAX_TIMEOUTS-1) )
    * @return Returns #qTrue on success, otherwise returns #qFalse.
    */       
    void qStateMachine_TimeoutStop( qSM_t * const m, const qIndex_t xTimeout );

    /**
    * @brief Get attributes from the provided Finite State Machine object     
    * @param[in] m A pointer to the FSM object.
    * @param[in] attr The requested attribute
    * @return Returns a pointer to the requested attribute. Otherwise returns NULL.
    */  
    void* qStateMachine_Get_Machine( qSM_t * const m, const qSM_Attribute_t attr );

    /**
    * @brief Get attributes from the provided state object     
    * @param[in] s A pointer to the state object.
    * @param[in] attr The requested attribute
    * @return Returns a pointer to the requested attribute. Otherwise returns NULL.
    */     
    void* qStateMachine_Get_State( qSM_State_t * const s, const qSM_Attribute_t attr );

    /**
    * @brief Set/Change the state callback in run-time     
    * @param[in] state A pointer to the state object.
    * @param[in] StateFcn The new state callback
    * @return Returns #qTrue on success, otherwise returns #qFalse.
    */         
    qBool_t qStateMachine_Set_StateCallback( qSM_State_t * const state, qSM_StateCallback_t StateFcn );

    /**
    * @brief Set/Change the FSM surrounding callback in run-time     
    * @param[in] m A pointer to the state object.
    * @param[in] surrounding The new surrounding callback
    * @return Returns #qTrue on success, otherwise returns #qFalse.
    */     
    qBool_t qStateMachine_Set_MachineSurrounding( qSM_t * const m, qSM_SurroundingCallback_t surrounding );
    
    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif