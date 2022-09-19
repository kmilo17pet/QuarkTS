/*!
 * @file qcritical.h
 * @author J. Camilo Gomez C.
 * @version 3.28
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
    * @brief Function called by qCritical_Exit() to restore interrupts.
    *
    * @note User should use bare-metal code to implement this function.
    * @note The kernel passes the previously saved interrupt configuration as
    * input argument. The user is responsible for taking this argument to
    * restore the saved interrupt setup.
    * Example :
    * @code{.c}
    * void BSP_InterruptRestorer( qUINT32_t savedMask ) {
    *       HAL_InterruptSetMask( savedMask );
    *       HAL_EnableInterrupts();
    * }
    * @endcode
    * @param[in] savedMask The interrupt configuration saved by the "Disabler"
    * function
    * @return none.
    */
    typedef void (*qInt_Restorer_t)(qUINT32_t arg1);

    /**
    * @brief Function called by qCritical_Enter() to disable interrupts.
    *
    * @note User should use bare-metal code to implement this function.
    * @note User should return the current interrupt configuration to be saved
    * by the kernel.
    * Example :
    * @code{.c}
    * qUINT32_t BSP_InterruptDisabler( void ) {
    *       qUINT32_t currentMask;
    *       currentMask = HAL_InterruptGetMask( savedMask );
    *       HAL_DisableInterrupts();
    *       return currentMask;
    * }
    * @endcode
    * @return The current interrupt configuration (mask). The kernel will retain
    * this value
    * until the critical section is exited
    */
    typedef qUINT32_t (*qInt_Disabler_t)(void);


    /**
    * @brief Enter a critical section. This function invokes the @b Disabler
    * function if available.
    * @note  Please see qCritical_SetInterruptsED()
    * @return none.
    */
    void qCritical_Enter( void );


    /**
    * @brief Exit a critical section. This function invokes the @b Enabler
    * function if available.
    * @note  Please see qCritical_SetInterruptsED()
    * @return none.
    */
    void qCritical_Exit( void );


    /**
    * @brief Set the hardware-specific code for global interrupt enable/disable.
    * Setting this allows you to communicate safely from Interrupts using queued
    * notifications or qQueues.
    * Example :
    * @code{.c}
    * void qCritical_SetInterruptsED( BSP_InterruptRestorer, BSP_InterruptDisabler );
    * @endcode
    * @param[in] rFcn The function with hardware specific code that enables or
    * restores interrupts.
    * @param[in] dFcn The function with hardware specific code that disables
    * interrupts.
    * @return #qTrue on success. Otherwise return #qFalse.
    */
    qBool_t qCritical_SetInterruptsED( const qInt_Restorer_t rFcn,
                                       const qInt_Disabler_t dFcn );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
