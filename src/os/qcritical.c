#include "qcritical.h"

static qCriticalHandler_t Critical = { NULL, NULL , 0ul};

/*============================================================================*/
/*void qEnterCritical(void)

Enter a critical section. This function invokes the <Disabler> if available.
Please see <qSchedulerSetInterruptsED>

*/  
void qEnterCritical(void){
    qInt_Disabler_t Disabler;
    if( NULL != Critical.I_Disable ){
        Disabler = Critical.I_Disable;
        Critical.IntFlags = Disabler();
    }
}
/*============================================================================*/
/*void qEnterCritical(void)

Enter a critical section. This function invokes the <Enabler> if available.
Please see <qSchedulerSetInterruptsED>

*/ 
void qExitCritical( void ){
    qInt_Restorer_t Restorer;
    if( NULL != Critical.I_Restorer ){
        Restorer = Critical.I_Restorer;
        Restorer( Critical.IntFlags );
    }
}
/*============================================================================*/
/*void qSchedulerSetInterruptsED(void (*Restorer)(void), void (*Disabler)(void))

Set the hardware-specific code for global interrupt enable/disable. 
Setting this allows you to comunicate safely from Interrupts using queued notifications
or qQueues.

Parameters:

    - Restorer : The function with hardware specific code that enables or 
                 restores interrupts.
    - Disabler : The function with hardware specific code that disables interrupts.
*/ 
void qSchedulerSetInterruptsED( const qInt_Restorer_t Restorer, const qInt_Disabler_t Disabler ){
    Critical.I_Restorer = Restorer;
    Critical.I_Disable = Disabler;
}
/*============================================================================*/