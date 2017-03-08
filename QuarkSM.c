#include "QuarkSM.h"

static qSM_Status_t (*__qSM_Failure)(volatile struct _qSM_t*) = NULL;
static qSM_Status_t (*__qSM_Success)(volatile struct _qSM_t*) = NULL;
static qSM_Status_t (*__qSM_Unexpected)(volatile struct _qSM_t*) = NULL;

/*=================================================================================================*/
int _qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_State_t SuccessState, qSM_State_t FailureState, qSM_State_t UnexpectedState){
    obj->NextState = InitState;
    obj->PreviousState = NULL;
    __qSM_Failure = FailureState;
    __qSM_Success = SuccessState;
    __qSM_Unexpected = UnexpectedState;
}
/*=================================================================================================*/
int _qStateMachine_Run(qSM_t *obj){
    qSM_State_t prev  = NULL;
    if(obj->NextState!=NULL){
        prev = obj->NextState;
        obj->PreviousReturnStatus = obj->NextState(obj);
        obj->PreviousState = prev;
    }
    else    obj->PreviousReturnStatus = qSM_EXIT_FAILURE;
    
    switch(obj->PreviousReturnStatus){
        case qSM_EXIT_FAILURE:
            if(__qSM_Failure != NULL) __qSM_Failure(obj);
            break;
        case qSM_EXIT_SUCCESS:
            if(__qSM_Success != NULL) __qSM_Success(obj);
            break;
        default:
            if(__qSM_Unexpected != NULL) __qSM_Unexpected(obj);
            break;
    }
    
    return 0;
 }
/*=================================================================================================*/