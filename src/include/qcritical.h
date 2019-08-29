/*This file is part of the QuarkTS distribution.*/
#ifndef QCRITICAL_H  
    #define QCRITICAL_H

    #include "qtypes.h"

    typedef void (*qInt_Restorer_t)(uint32_t arg1);
    typedef uint32_t (*qInt_Disabler_t)(void);

    typedef struct{
        qInt_Disabler_t I_Disable;  /*< Point to the user-supplied function used to disable the hardware interrupts. */
        qInt_Restorer_t I_Restorer; /*< Point to the user-supplied function used to restore the hardware interrupts. */
        volatile uint32_t IntFlags; /*< To save the current interrupt flags before the disable action is performed. */
    }qCriticalHandler_t;

    void qCritical_Enter( void );
    void qCritical_Exit( void );
    void qCritical_SetInterruptsED( const qInt_Restorer_t Restorer, const qInt_Disabler_t Disabler );

#endif 