/*!
 * @file qcritical.c   
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qcritical.h"

/*! @cond */
typedef struct _qCritical_Handler_s{
    qInt_Disabler_t I_Disable;      /*< Point to the user-supplied function used to disable the hardware interrupts. */
    qInt_Restorer_t I_Restorer;     /*< Point to the user-supplied function used to restore the hardware interrupts. */
    volatile qUINT32_t IntFlags;    /*< To save the current interrupt flags before the disable action is performed. */
}qCritical_Handler_t;
/*! @endcond */

static qCritical_Handler_t Critical = { NULL, NULL , 0uL};

/*============================================================================*/
void qCritical_Enter( void ){
    if( NULL != Critical.I_Disable ){
        qInt_Disabler_t Disabler = Critical.I_Disable;

        Critical.IntFlags = Disabler();
    }
}
/*============================================================================*/
void qCritical_Exit( void ){
    if( NULL != Critical.I_Restorer ){
        qInt_Restorer_t Restorer = Critical.I_Restorer;

        Restorer( Critical.IntFlags );
    }
}
/*============================================================================*/
void qCritical_SetInterruptsED( const qInt_Restorer_t Restorer, const qInt_Disabler_t Disabler ){
    Critical.I_Restorer = Restorer;
    Critical.I_Disable = Disabler;
}
/*============================================================================*/
