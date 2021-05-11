/*This file is part of the QuarkTS distribution.*/
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

    #define QSM_STATE_TOP               ( NULL )   

    /*FSM internal signals*/
    #define QSM_SIGNAL_START            ( (qSM_Signal_t)0xFFFFFFFFuL )   /*built-in Signal -> transitions are not allowed here*/ /*signal for coding nested initial transitions */
    #define QSM_SIGNAL_EXIT             ( (qSM_Signal_t)0xFFFFFFFEuL )   /*built-in Signal -> transitions are not allowed here*/
    #define QSM_SIGNAL_ENTRY            ( (qSM_Signal_t)0xFFFFFFFDuL )   /*built-in Signal -> transitions are not allowed here*/
    #define QSM_SIGNAL_NONE             ( (qSM_Signal_t)0xFFFFFFFCuL )   /*to indicate that no signal has been received*/
    #define QSM_SIGNAL_TIMEOUT(index)   ( (qSM_Signal_t)0xFFFFFFFBuL - (qSM_Signal_t)(Q_FSM_MAX_TIMEOUTS-1) + (qSM_Signal_t)(index) )   
    

    /*Timeout specification options. Can be combined with a bitwise OR.*/
    #define QSM_TSOPT_INDEX(index)      ( ( (qSM_TimeoutSpecOptions_t)0x00FFFFFFuL & (qSM_TimeoutSpecOptions_t)index) )  /*to select the timeout to be used in the specification*/    
    #define QSM_TSOPT_SET_ENTRY         ( (qSM_TimeoutSpecOptions_t)0x01000000uL )  /*to set the timeout when the specified  state its entering*/
    #define QSM_TSOPT_RST_ENTRY         ( (qSM_TimeoutSpecOptions_t)0x02000000uL )  /*to reset the timeout when the specified state its entering*/
    #define QSM_TSOPT_SET_EXIT          ( (qSM_TimeoutSpecOptions_t)0x04000000uL )  /*to set the timeout when the specified state its exiting*/ 
    #define QSM_TSOPT_RST_EXIT          ( (qSM_TimeoutSpecOptions_t)0x08000000uL )  /*to reset the timeout when the specified state its exiting*/    
    #define QSM_TSOPT_KEEP_IF_SET       ( (qSM_TimeoutSpecOptions_t)0x10000000uL )  /*set only if the timeout is reset*/    
    #define QSM_TSOPT_PERIODIC          ( (qSM_TimeoutSpecOptions_t)0x20000000uL )  /*to mark the timeout as periodic*/    
    

    #define QSM_SIGNAL_RANGE_MIN        ( (qSM_Signal_t)0u )
    #define QSM_SIGNAL_RANGE_MAX        ( (qSM_Signal_t)(0xFFFFFFFBuL - (qSM_Signal_t)Q_FSM_MAX_TIMEOUTS  ) )
    #define QSM_SIGNAL_USER             ( QSM_SIGNAL_RANGE_MIN )

    typedef qUINT32_t qSM_Signal_t;
    typedef enum {
        qSM_STATUS_BEFORE_ANY = -32767, 
        qSM_STATUS_NULL = -32766, 
        qSM_STATUS_EXIT_FAILURE = -32765, 
        qSM_STATUS_EXIT_SUCCESS = -32764, 
        qSM_STATUS_SIGNAL_HANDLED = -32763
    }qSM_Status_t; 

    typedef enum {
        qSM_TRANSITION_NO_HISTORY = 0,
        qSM_TRANSITION_SHALLOW_HISTORY,        
        qSM_TRANSITION_DEEP_HISTORY,
    }qSM_TransitionHistoryMode_t;

    /*fields for the qSM_Handler_t pointer*/
    #define _qSM_HANDLER_FIELDS( pAttrib ) struct{\
        void *StartState;\
        void *NextState;\
        pAttrib void *machine;\
        pAttrib void *Data;\
        pAttrib void *StateData;\
        pAttrib qSM_Signal_t Signal;\
        pAttrib qSM_Status_t Status;\
        qSM_TransitionHistoryMode_t TransitionHistory;\
    };\

    /*< h->StartState : Used to set the initial state if the current state its a parent*/    
    /*< h->Next : Used to produce a transition to the desired state*/
    /*< h->machine : A pointer to the state machine*/
    /*< h->Data : The user storage pointer*/
    /*< h->Signal : the signal that its currently evaluated*/
    /*< h->Status : the status-stage of the current state. Only available in the surrounding callback*/


    typedef struct _qSM_uPublicData_s{ _qSM_HANDLER_FIELDS(/*none*/) }_qSM_UnprotectedPublicData_t;
    typedef struct _qSM_pPublicData_s{ _qSM_HANDLER_FIELDS( const  ) }_qSM_ProtectedPublicData_t;
    typedef _qSM_UnprotectedPublicData_t* qSM_UnprotectedHandler_t;    
    typedef _qSM_ProtectedPublicData_t* const qSM_Handler_t;  

    typedef qSM_Status_t (*qSM_StateCallback_t)( qSM_Handler_t arg ); 
    typedef void (*qSM_SurroundingCallback_t)( qSM_Handler_t arg ) ; 
    typedef qBool_t (*qSM_SignalAction_t)( qSM_Handler_t arg );
    typedef qUINT32_t qSM_TimeoutSpecOptions_t;

    typedef struct _qSM_State_s{
        struct _qSM_State_Private_s{
            struct _qSM_State_s *parent;                    /*< A pointer to the parent state*/
            struct _qSM_State_s *lastRunningChild;          /*< The last running child state*/
            struct _qSM_State_s *ChildStart;                /*< The initial state of this parent*/
            qSM_StateCallback_t sCallback;                  /*< The state callback function*/
            void* Data;                                     /*< State data. Storage pointer*/
        }qPrivate;
    }qSM_State_t;
    
    typedef struct{
        qSM_State_t *xState;                                /*< in witch state the timeout will be installed.*/
        qTime_t xTimeout;                                   /*< the time value to be used as Timeout.*/
        qSM_TimeoutSpecOptions_t options;                   /*< select the timeout index and set the options. */
    }qSM_TimeoutStateDefinition_t;
    
    typedef struct{
        qSM_TimeoutStateDefinition_t *spec;                 /*< a pointer to the state-timeout lookup table*/
        qSTimer_t builtin_timeout[ Q_FSM_MAX_TIMEOUTS ];    /*< the built-in timeouts*/     
        qUINT32_t isPeriodic;                               /*< witch one is periodic*/
        size_t n;                                           /*< the number of entries inside the <spec> field*/
    }qSM_TimeoutSpec_t;

    typedef struct _qSM_s{
        struct _qSM_Private_s{
            qSM_State_t *current;                           /*< A pointer to the current state.*/
            qSM_State_t *next;                              /*< The next state to execute. */
            qSM_State_t *source;                            /*< Source state during the last transition*/
            void *Data;                                     /*< The user storage-pointer*/
            void *tTable;                                   /*< A pointer to the transition table.*/
            #if ( Q_QUEUES == 1 )
                qQueue_t *queue;                            /*< A pointer to the signal queue.*/
            #endif
            qSM_TimeoutSpec_t *TimeSpec;                    /*< A pointer to the timeout specification object*/
            size_t tEntries;                                /*< Number of entries on <tTable>*/
            qSM_SurroundingCallback_t surrounding;          /*< An callback to handle actions after and before any state. */
            qSM_State_t top;                                /*< The top most state*/
            _qSM_UnprotectedPublicData_t handler;           /*< The FSM handler argument*/    
            qSM_Signal_t SignalNot;                         /*< Signal exclusion variable*/
        }qPrivate;         
    }qSM_t;

    typedef struct{
        qSM_State_t *CurrentState;                          /*< Where this transition takes place*/
        qSM_Signal_t xSignal;                               /*< The signal that will produce the transition*/
        qSM_SignalAction_t Guard;                           /*< The signal guard*/
        qSM_State_t *NextState;                             /*< The next state after the transition*/
        qSM_TransitionHistoryMode_t HistoryMode;            /*< To set the history mode for a transition*/
    }qSM_Transition_t;
    
    typedef enum{
        qSM_ATTRIB_STATE_TOP,                               /*< Only for qStateMachine_Get_Machine : Get a pointer to the top running*/
        qSM_ATTRIB_STATE_CURRENT,                           /*< Only for qStateMachine_Get_Machine : Get a pointer to the current running state*/
        qSM_ATTRIB_SIGNAL_QUEUE,                            /*< Only for qStateMachine_Get_Machine : Get a pointer to the signal-queue object if installed*/
        qSM_ATTRIB_TIMESPEC,                                /*< Only for qStateMachine_Get_Machine : Get a pointer to the timeout specification object if installed*/
        qSM_ATTRIB_TRANSITION_TABLE,                        /*< Only for qStateMachine_Get_Machine : Get a pointer to the transition table if installed*/
        qSM_ATTRIB_DATA,                                    /*< Only for qStateMachine_Get_Machine : Get the user storage-pointer*/
        qSM_ATTRIB_COMPOSITE_INITSTATE,                     /*< Only for qStateMachine_Get_State : Get the initial default or initial state, if input is composite*/
        qSM_ATTRIB_COMPOSITE_LASTSTATE,                     /*< Only for qStateMachine_Get_State : Get the last state, if input is composite*/
        qSM_ATTRIB_COMPOSITE_PARENT,                        /*< Only for qStateMachine_Get_State : Get the parent state, if input is a child*/
    }qSM_Attribute_t;

    qBool_t qStateMachine_Setup( qSM_t * const m, qSM_StateCallback_t topCallback, qSM_State_t * const childstart, qSM_SurroundingCallback_t surrounding, void *Data );
    qBool_t qStateMachine_StateSubscribe( qSM_t * const m, qSM_State_t * const state, qSM_State_t * const parent, qSM_StateCallback_t StateFcn, qSM_State_t * const ChildStart, void *Data );
    qBool_t qStateMachine_Run( qSM_t * const m, qSM_Signal_t xSignal );
    qBool_t qStateMachine_InstallTransitionTable( qSM_t * const m, qSM_Transition_t * const table, const size_t n );
    qBool_t qStateMachine_InstallSignalQueue( qSM_t * const m, qQueue_t *queue );
    qBool_t qStateMachine_SendSignal( qSM_t * const m, qSM_Signal_t xSignal, const qBool_t isUrgent );
    
    qBool_t qStateMachine_InstallTimeoutSpec( qSM_t * const m,  qSM_TimeoutSpec_t * const ts, qSM_TimeoutStateDefinition_t *tdef, const size_t n );
    qBool_t qStateMachine_TimeoutSet( qSM_t * const m, const qIndex_t xTimeout, const qTime_t xTime );
    void qStateMachine_TimeoutStop( qSM_t * const m, const qIndex_t xTimeout );

    /*helper functions to retrieve some attributes of the qSM_t and qSM_State_t objects*/
    void* qStateMachine_Get_Machine( qSM_t * const m, const qSM_Attribute_t attr );
    void* qStateMachine_Get_State( qSM_State_t * const s, const qSM_Attribute_t attr );
    qBool_t qStateMachine_Set_StateCallback( qSM_State_t * const state, qSM_StateCallback_t StateFcn );
    qBool_t qStateMachine_Set_MachineSurrounding( qSM_t * const m, qSM_SurroundingCallback_t surrounding );
    
    #ifdef __cplusplus
    }
    #endif

#endif