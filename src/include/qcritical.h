/*This file is part of the QuarkTS distribution.*/
#ifndef QCRITICAL_H  
    #define QCRITICAL_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef void (*qInt_Restorer_t)(qUINT32_t arg1);
    typedef qUINT32_t (*qInt_Disabler_t)(void);

    void qCritical_Enter( void );
    void qCritical_Exit( void );
    void qCritical_SetInterruptsED( const qInt_Restorer_t Restorer, const qInt_Disabler_t Disabler );

    #ifdef __cplusplus
    }
    #endif

#endif 