/*!
 * @file qcritical.h
 * @author J. Camilo Gomez C.
 * @version 3.25
 * @note This file is part of the QuarkTS distribution.
 * @brief API to handle entry/exit actions in critical sections.
 **/

#ifndef QCRITICAL_H  
    #define QCRITICAL_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif


    /** @addtogroup qcritical
    * @brief APIs to handle entry/exit actions in critical sections.
    *  @{
    */

    /**
    * @brief Pointer to Function type qInt_Restorer_t : function to restore interrupts.
    * 
    *@note  User should use bare-metal code to implement this function.
    * Example :
    * @code{.c}
    * void BSP_InterruptRestorer( qUINT32_t savedmask ){
    *       HAL_InteruptSetMask( savedmask );    
    *       HAL_EnableInterrupts();
    * }
    * @endcode
    * @param arg The current interrupt configuration 
    * @return none.
    */
    typedef void (*qInt_Restorer_t)(qUINT32_t arg1);

    /**
    * @brief Pointer to Function type qInt_Disabler_t : function to disable interrupts.
    * 
    *@note  User should use bare-metal code to implement this function.
    * Example :
    * @code{.c}
    * qUINT32_t BSP_InterruptDisabler( void ){
    *       qUINT32_t currentmask;
    *       currentmask = HAL_InteruptGetMask( savedmask );    
    *       HAL_DisableInterrupts();
    *       return currentmask;
    * }
    * @endcode
    * @param arg1 The current interrupt configuration 
    * @return none.
    */
    typedef qUINT32_t (*qInt_Disabler_t)(void);

  
    /**
    * @brief Enter a critical section. This function invokes the <b>Disabler</b> if available.
    * @note  Please see <b>qCritical_SetInterruptsED()</b>
    * @return none.
    */   
    void qCritical_Enter( void );


    /**
    * @brief Exit a critical section. This function invokes the <b>Enabler</b> if available.
    * @note  Please see <b>qCritical_SetInterruptsED()</b>
    * @return none.
    */      
    void qCritical_Exit( void );


    /**
    * @brief Set the hardware-specific code for global interrupt enable/disable. 
    * Setting this allows you to comunicate safely from Interrupts using queued 
    * notifications or qQueues.
    * Example :
    * @code{.c}
    * void qCritical_SetInterruptsED( BSP_InterruptRestorer, BSP_InterruptDisabler );
    * @endcode
    * @param Restorer The function with hardware specific code that enables or restores interrupts.
    * @param Disabler The function with hardware specific code that disables interrupts.
    * @return none.
    */   
    void qCritical_SetInterruptsED( const qInt_Restorer_t Restorer, const qInt_Disabler_t Disabler );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
