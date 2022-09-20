/*!
 * @file qcritical.c
 * @author J. Camilo Gomez C.
 * @note This file is part of the QuarkTS distribution.
 **/

#include "qcritical.h"

/*! @cond */
typedef struct _qCritical_Handler_s {
    qInt_Disabler_t disable;     /*< Point to the user-supplied function used to disable the hardware interrupts. */
    qInt_Restorer_t restore;     /*< Point to the user-supplied function used to restore the hardware interrupts. */
    volatile qUINT32_t flags;    /*< To save the current interrupt flags before the disable action is performed. */
}
qCritical_Handler_t;
/*! @endcond */

static qCritical_Handler_t critical = { NULL, NULL , 0uL };
/*cstat -MISRAC2012-Rule-8.13*/
/*============================================================================*/
void qCritical_Enter( void )
{
    if ( NULL != critical.disable ) {
        const qInt_Disabler_t xDisabler = critical.disable;

        critical.flags = xDisabler();
    }
}
/*============================================================================*/
void qCritical_Exit( void )
{
    if ( NULL != critical.restore ) {
        const qInt_Restorer_t xRestorer = critical.restore;

        xRestorer( critical.flags );
    }
}
/*============================================================================*/
qBool_t qCritical_SetInterruptsED( const qInt_Restorer_t rFcn,
                                   const qInt_Disabler_t dFcn )
{
    qBool_t retValue = qFalse;

    if ( ( rFcn != critical.restore ) || ( dFcn != critical.disable ) ) {
        critical.restore = rFcn;
        critical.disable = dFcn;
        retValue = qTrue;
    }

    return retValue;
}
/*============================================================================*/
/*cstat +MISRAC2012-Rule-8.13*/
