#ifndef QCRITICAL_H  
    #define QCRITICAL_H

    #include "qtypes.h"

    typedef void (*qInt_Restorer_t)(uint32_t);
    typedef uint32_t (*qInt_Disabler_t)(void);

    typedef struct{
        qInt_Disabler_t I_Disable;
        qInt_Restorer_t I_Restorer;
        volatile uint32_t IntFlags;
    }qCriticalHandler_t;

    void qEnterCritical( void );
    void qExitCritical( void );
    void qSchedulerSetInterruptsED( const qInt_Restorer_t Restorer, const qInt_Disabler_t Disabler );

#endif 