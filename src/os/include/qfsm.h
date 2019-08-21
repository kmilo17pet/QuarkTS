#ifndef QFSM_H
    #define QFSM_H

    #include "qtypes.h"

    typedef enum {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;
    #define _qSMData_t struct _qSM_t * const 
    #define CurrentState    NextState

    typedef struct _qSM_t{ 
        /* NextState: (Read/Write) 
        Next state to be performed after this state finish
        */
        qSM_Status_t (*NextState)(_qSMData_t);
        /* PreviousState: (Read Only)
        Last state seen in the flow chart
        */
        qSM_Status_t (* qConst PreviousState)(_qSMData_t);
        /* LastState: (Read Only) 
        The last state executed
        */        
        qSM_Status_t (* qConst LastState)(_qSMData_t);
        /* PreviousReturnStatus: (Read Only)
        The return status of <PreviousState>
        */
        qConst qSM_Status_t PreviousReturnStatus;
        /* StateFirstEntry: [== StateJustChanged] (Read Only)
        True when  <Previous State> !=  <Current State>
        */
        qConst qBool_t StateFirstEntry;
        /* Data: (Read Only)
        State-machine associated data.
        Note: If the FSM is running as a task, the associated event data can be 
        queried throught the "Data" field. (cast to qEvent_t is mandatory)
        */
        void * qConst Data;
        /*Private members (DO NOT USE THEM)*/
        struct /**/{
            void (*qConst __Failure)(_qSMData_t);
            void (*qConst __Success)(_qSMData_t);
            void (*qConst __Unexpected)(_qSMData_t);  
            void (*qConst __BeforeAnyState)(_qSMData_t);/*only used when a task has a SM attached*/
        }qPrivate;
    }qSM_t;
    typedef qSM_t* const qSMData_t;    
    typedef qSM_Status_t (*qSM_State_t)(qSMData_t); 
    typedef void (*qSM_SubState_t)(qSMData_t); 

    typedef enum{ /*FSM Attribute Flags definition*/
        qSM_RESTART, /*Restart the FSM*/
        qSM_CLEAR_STATE_FIRST_ENTRY_FLAG, /*Clear the entry flag for the current state if the NextState field doesn't change*/
        qSM_FAILURE_STATE, /*Set the Failure State*/
        qSM_SUCCESS_STATE, /*Set the Success State*/
        qSM_UNEXPECTED_STATE, /*Set the Unexpected State*/
        qSM_BEFORE_ANY_STATE /*Set the state executed before any state*/              
    }qFSM_Attribute_t; 

    qBool_t qStateMachine_Init( qSM_t *obj, qSM_State_t InitState, qSM_SubState_t SuccessState, qSM_SubState_t FailureState, qSM_SubState_t UnexpectedState, qSM_SubState_t BeforeAnyState );
    void qStateMachine_Run( qSM_t *obj, void *Data );
    void qStateMachine_Attribute( qSM_t *obj, qFSM_Attribute_t Flag , qSM_State_t  s, qSM_SubState_t subs );

#endif 