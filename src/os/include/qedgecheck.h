/*This file is part of the QuarkTS distribution.*/
#ifndef  QEDGECHECK_H
    #define QEDGECHECK_H

    #include "qtypes.h"
    #include "qclock.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    #define QREG_8BIT               ( _qReg_08Bits )
    #define QREG_16BIT              ( _qReg_16Bits )
    #define QREG_32BIT              ( _qReg_32Bits )
    
    #define QEDGECHECK_WAIT         ( (qUINT8_t)0u )
    #define QEDGECHECK_UPDATE       ( (qUINT8_t)1u )
    #define QEDGECHECK_CHECK        ( (qUINT8_t)2u )

  
    typedef struct _qEdgeCheck_IONode_s{
        /*This data should be handled only using the provided API*/
        struct _qEdgeCheck_IONode_Private_s{
            struct _qEdgeCheck_IONode_s *Next;  /*< Point to the next node of the IO list. */    
            void *Port;                         /*< Point to the address of the hardware PORT/IO register. */
            qBool_t PreviousPinValue;           /*< The previous value of "Pin". */
            qBool_t Status;                     /*< The status of the pin. */
            qBool_t Pin;                        /*< The specific pin to read. */ 
        }qPrivate;       
    }qEdgeCheck_IONode_t;

    typedef qBool_t (*qCoreRegSize_t)(const void* arg1, qBool_t arg2);
    
    typedef struct{
        /*This data should be handled only using the provided API*/
        struct _qEdgeCheck_Private_s{
            qEdgeCheck_IONode_t *Head;          /*< The first ionode in the list. */
            qClock_t Start, DebounceTime;       /*< Debounce time control*/
            qCoreRegSize_t Reader;              /*< The xbits reg-reader function*/
            qUINT8_t State;                     /*< The node state*/
        }qPrivate;
    }qEdgeCheck_t;

    qBool_t _qReg_08Bits( const void *Address, qBool_t PinNumber );
    qBool_t _qReg_16Bits( const void *Address, qBool_t PinNumber );
    qBool_t _qReg_32Bits( const void *Address, qBool_t PinNumber );
    
    qBool_t qEdgeCheck_Setup( qEdgeCheck_t * const Instance, const qCoreRegSize_t RegisterSize, const qClock_t DebounceTime );
    qBool_t qEdgeCheck_Add_Node( qEdgeCheck_t * const Instance, qEdgeCheck_IONode_t * const Node, void *PortAddress, const qBool_t PinNumber );    
    qBool_t qEdgeCheck_Update( qEdgeCheck_t * const Instance );
    qBool_t qEdgeCheck_Get_NodeStatus( const qEdgeCheck_IONode_t * const Node );
    void qEdgeCheck_Set_NodePin( qEdgeCheck_IONode_t * const Node, const qBool_t PinNumber );

    #ifdef __cplusplus
    }
    #endif

#endif
