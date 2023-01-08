/*!
 * @file qedgecheck.h
 * @author J. Camilo Gomez C.
 * @version 1.13
 * @note This file is part of the QuarkTS distribution.
 * @brief An interface to manage and simplify the value(with edge-checking)
 *  of incoming digital-signal groups.
 **/
#ifndef  QEDGECHECK_H
    #define QEDGECHECK_H

    #include "qtypes.h"
    #include "qclock.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    #ifndef Q_EDGE_CHECK_IOGROUPS
        #define Q_EDGE_CHECK_IOGROUPS       ( 1 )
    #endif

    /** @addtogroup qedgecheck I/O Groups for edge checking
    * @brief An interface to manage and simplify the value(with edge-checking)
    * of incoming digital-signal groups.
    *  @{
    */

    /** @brief To define a register size of 8-bits for an Edge-Check instance*/
    #define QREG_8BIT                _qReg_08Bits

    /** @brief To define a register size of 16-bits for an Edge-Check instance*/
    #define QREG_16BIT               _qReg_16Bits

    /** @brief To define a register size of 32-bits for an Edge-Check instance*/
    #define QREG_32BIT               _qReg_32Bits
    /**
    * @brief An input node object for edge checking.
    * @note Do not access any member of this structure directly.
    */
    typedef struct _qEdgeCheck_IONode_s {
        /*! @cond  */
        struct _qEdgeCheck_IONode_Private_s {
            struct _qEdgeCheck_IONode_s *next;  /*< Point to the next node of the IO list. */
            void *xPort;                        /*< Point to the address of the hardware PORT/IO register. */
            qBool_t prevPinValue;               /*< The previous value of "Pin". */
            qBool_t status;                     /*< The status of the pin. */
            qBool_t xPin;                       /*< The specific pin to read. */
        }
        qPrivate;
        /*! @endcond  */
    }
    qEdgeCheck_IONode_t;

    /**
    * @brief A typedef to specify the I/O register size.
    */
    typedef qBool_t (*qCoreRegSize_t)(const void* arg1, qBool_t arg2);

    /**
    * @brief An I/O edge check object.
    * @note Do not access any member of this structure directly.
    */
    typedef struct _qEdgeCheck_s {
        /*! @cond  */
        struct _qEdgeCheck_Private_s {
            void (*state)( struct _qEdgeCheck_s * const ec );
            qEdgeCheck_IONode_t *head;          /*< The first io-node in the list. */
            qClock_t start, debounceTime;       /*< Debounce time control*/
            qCoreRegSize_t reader;              /*< The xBits reg-reader function*/
        }
        qPrivate;
        /*! @endcond  */
    }
    qEdgeCheck_t;

    /*! @cond  */
    /*cppcheck-suppress misra-c2012-20.7 */
    #define _QEDGECHECK_REG_FCN_DEC(NAME)                                   \
    qBool_t NAME( const void *addr, qBool_t pinNumber )                     \

    _QEDGECHECK_REG_FCN_DEC( _qReg_32Bits );
    _QEDGECHECK_REG_FCN_DEC( _qReg_16Bits );
    _QEDGECHECK_REG_FCN_DEC( _qReg_08Bits );
    /*! @endcond  */

    /**
    * @brief Initialize a I/O Edge-Check instance
    * @param[in] ec A pointer to the I/O Edge-Check object
    * @param[in] rSize The specific-core register size: #QREG_8BIT, #QREG_16BIT
    * or #QREG_32BIT(Default)
    * @param[in] debounceTime The specified time to bypass the bounce of the
    * input nodes
    * @return #qTrue on success. Otherwise #qFalse.
    */
    qBool_t qEdgeCheck_Setup( qEdgeCheck_t * const ec,
                              const qCoreRegSize_t rSize,
                              const qClock_t debounceTime );

    /**
    * @brief Add an input node to the Edge-Check instance
    * @param[in] ec A pointer to the I/O Edge-Check object
    * @param[in] n A pointer to the Input-Node object
    * @param[in] portAddress The address of the core PORTx-register to read the
    * levels of the specified PinNumber
    * @param[in] pinNumber The specified Pin to read from PortAddress
    * @return #qTrue on success. Otherwise #qFalse.
    */
    qBool_t qEdgeCheck_Add_Node( qEdgeCheck_t * const ec,
                                 qEdgeCheck_IONode_t * const n,
                                 void *portAddress,
                                 const qBool_t pinNumber );

    /**
    * @brief Update the status of all nodes inside the I/O Edge-Check instance
    * (Non-Blocking call).
    * @param[in] ec A pointer to the I/O Edge-Check object
    * @return #qTrue on success. Otherwise #qFalse.
    */
    qBool_t qEdgeCheck_Update( qEdgeCheck_t * const ec );

    /**
    * @brief Query the status of the specified input-node.
    * @param[in] n A pointer to the Input-Node object
    * @return The status of the input node : #qTrue, #qFalse, #qRising,
    * #qFalling or #qUnknown.
    */
    qBool_t qEdgeCheck_Get_NodeStatus( const qEdgeCheck_IONode_t * const n );

    /**
    * @brief Set/Change the pin number for the provided node.
    * @param[in] n A pointer to the Input-Node object.
    * @param[in] pinNumber The specified Pin to read from PortAddress.
    * @return #qTrue on success. Otherwise #qFalse.
    */
    qBool_t qEdgeCheck_Set_NodePin( qEdgeCheck_IONode_t * const n,
                                    const qBool_t pinNumber );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
