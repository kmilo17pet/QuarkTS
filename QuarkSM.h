/*******************************************************************************
 *  QuarkSM - State Machine API extension for QuakTS
 *  Version : 2.9.4
 *  Copyright (C) 2012 Eng. Juan Camilo Gomez C. MSc. (kmilo17pet@gmail.com)
 *
 *  QuarkSM is free software: you can redistribute it and/or modify it
 *  under the terms of the GNU Lesser General Public License (LGPL)as published
 *  by the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  QuarkSM is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*******************************************************************************/

#ifndef QUARKSM_H
#define QUARKSM_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>

    typedef enum state {qSM_EXIT_SUCCESS = 0xFEEF, qSM_EXIT_FAILURE = 0xFEAF} qSM_Status_t;

struct _qSM_t{
    qSM_Status_t (*NextState)(volatile struct _qSM_t*);
    qSM_Status_t (*PreviousState)(volatile struct _qSM_t*);
    qSM_Status_t PreviousReturnStatus;
};

#define qSM_t volatile struct _qSM_t
typedef qSM_Status_t (*qSM_State_t)(qSM_t*);

int _qStateMachine_Init(qSM_t *obj, qSM_State_t InitState, qSM_State_t SuccessState, qSM_State_t FailureState, qSM_State_t UnexpectedState);
int _qStateMachine_Run(qSM_t *obj);

#define qStateMachine_Init(OBJ, INIT_STATE, SUCCESS_STATE, FAILURE_STATE, UNEXPECTED_STATE)   _qStateMachine_Init(&OBJ, INIT_STATE, SUCCESS_STATE, FAILURE_STATE, UNEXPECTED_STATE) 
#define qStateMachine_Run(OBJ)   _qStateMachine_Run(&OBJ) 

#ifdef __cplusplus
}
#endif

#endif /* QUARKSM_H */

