/*!
 * @file qedgecheck.h
 * @author J. Camilo Gomez C.
 * @version 1.06
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
    * @brief An interface to manage and simplify the value(with edge-checking) of incoming digital-signal groups.
    *  @{
    */

    /** @brief To define a register size of 8-bits for an Edge-Check instance*/
    #define QREG_8BIT               ( _qReg_08Bits )

    /** @brief To define a register size of 16-bits for an Edge-Check instance*/
    #define QREG_16BIT              ( _qReg_16Bits )

    /** @brief To define a register size of 32-bits for an Edge-Check instance*/
    #define QREG_32BIT              ( _qReg_32Bits )
    
    /** 
    * @brief An input node object for edge checking.
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qEdgeCheck_IONode_s{
        /*! @cond  */
        struct _qEdgeCheck_IONode_Private_s{
            struct _qEdgeCheck_IONode_s *Next;  /*< Point to the next node of the IO list. */    
            void *Port;                         /*< Point to the address of the hardware PORT/IO register. */
            qBool_t PreviousPinValue;           /*< The previous value of "Pin". */
            qBool_t Status;                     /*< The status of the pin. */
            qBool_t Pin;                        /*< The specific pin to read. */ 
        }qPrivate;       
        /*! @endcond  */
    }qEdgeCheck_IONode_t;

    /** 
    * @brief A typedef to specify the I/O register size.
    */
    typedef qBool_t (*qCoreRegSize_t)(const void* arg1, qBool_t arg2);
    
    /** 
    * @brief An I/O edge check object.
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qEdgeCheck_s{
        /*! @cond  */
        struct _qEdgeCheck_Private_s{
            qEdgeCheck_IONode_t *Head;          /*< The first ionode in the list. */
            qClock_t Start, DebounceTime;       /*< Debounce time control*/
            qCoreRegSize_t Reader;              /*< The xBits reg-reader function*/
            qUINT8_t State;                     /*< The node state*/
        }qPrivate;
        /*! @endcond  */
    }qEdgeCheck_t;

    /*! @cond  */
    qBool_t _qReg_08Bits( const void *Address, qBool_t PinNumber );
    qBool_t _qReg_16Bits( const void *Address, qBool_t PinNumber );
    qBool_t _qReg_32Bits( const void *Address, qBool_t PinNumber );
    /*! @endcond  */

    /**
    * @brief Initialize a I/O Edge-Check instance 
    * @param[in] Instance A pointer to the I/O Edge-Check object
    * @param[in] RegisterSize The specific-core register size: #QREG_8BIT, #QREG_16BIT or #QREG_32BIT(Default)
    * @param[in] DebounceTime The specified time to bypass the bounce of the input nodes
    * @return #qTrue on success. Otherwise #qFalse.
    */   
    qBool_t qEdgeCheck_Setup( qEdgeCheck_t * const Instance, const qCoreRegSize_t RegisterSize, const qClock_t DebounceTime );

    /**
    * @brief Add an input node to the Edge-Check instance 
    * @param[in] Instance A pointer to the I/O Edge-Check object
    * @param[in] Node A pointer to the Input-Node object
    * @param[in] PortAddress The address of the core PORTx-register to read the levels of the specified PinNumber
    * @param[in] PinNumber  The specified Pin to read from PortAddress 
    * @return #qTrue on success. Otherwise #qFalse.
    */     
    qBool_t qEdgeCheck_Add_Node( qEdgeCheck_t * const Instance, qEdgeCheck_IONode_t * const Node, void *PortAddress, const qBool_t PinNumber );    
   
    /**
    * @brief Update the status of all nodes inside the I/O Edge-Check instance (Non-Blocking call).
    * @return #qTrue on success. Otherwise #qFalse.
    */        
    qBool_t qEdgeCheck_Update( qEdgeCheck_t * const Instance );

    /**
    * @brief Query the status of the specified input-node.
    * @param[in] Node A pointer to the Input-Node object
    * @return The status of the input node : #qTrue, #qFalse, #qRising, #qFalling or #qUnknown.
    */         
    qBool_t qEdgeCheck_Get_NodeStatus( const qEdgeCheck_IONode_t * const Node );

    /**
    * @brief Set/Change the pin number for the provided node.
    * @param[in] Node A pointer to the Input-Node object.
    * @param[in] PinNumber  The specified Pin to read from PortAddress  
    * @return none.
    */     
    void qEdgeCheck_Set_NodePin( qEdgeCheck_IONode_t * const Node, const qBool_t PinNumber );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
