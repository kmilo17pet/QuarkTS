#include "QuarkSM.h"

static qSM_Status_t (*__qSM_Error)(volatile struct _qSM_t*) = NULL;
static qSM_Status_t (*__qSM_OK)(volatile struct _qSM_t*) = NULL;
static qSM_Status_t (*__qSM_Unexpected)(volatile struct _qSM_t*) = NULL;

/*=================================================================================================*/
int _qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_State_t OKState, qSM_State_t ErrorState, qSM_State_t UnexpectedState){
    obj->NextState = InitState;
    obj->PreviousState = NULL;
    __qSM_Error = ErrorState;
    __qSM_OK = OKState;
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
    else    obj->PreviousReturnStatus = SM_ERROR;
    
    switch(obj->PreviousReturnStatus){
        case SM_ERROR:
            if(__qSM_Error != NULL) __qSM_Error(obj);
            break;
        case SM_OK:
            if(__qSM_OK != NULL) __qSM_OK(obj);
            break;
        default:
            if(__qSM_Unexpected != NULL) __qSM_Unexpected(obj);
            break;
    }
    
    return 0;
 }
/*=================================================================================================*/