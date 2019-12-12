/*This file is part of the QuarkTS distribution.*/
#ifndef  QEDGECHECK_H
    #define QEDGECHECK_H

    #include "qtypes.h"
    #include "qclock.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    #define QREG_8BIT               ( __qReg_08Bits )
    #define QREG_16BIT              ( __qReg_16Bits )
    #define QREG_32BIT              ( __qReg_32Bits )
    
    #define QEDGECHECK_WAIT         ( (qUINT8_t)0u )
    #define QEDGECHECK_UPDATE       ( (qUINT8_t)1u )
    #define QEDGECHECK_CHECK        ( (qUINT8_t)2u )

    typedef struct _qIONode_t{
        private_start{                  
            struct _qIONode_t *Next;        /*< Point to the next node of the IO list. */    
            void *Port;                     /*< Point to the address of the hardware PORT/IO register. */
            qBool_t PreviousPinValue;       /*< The previous value of "Pin". */
        }private_end;
        qBool_t Status;                     /*< The status of the pin. */
        qBool_t Pin;                        /*< The specific pin to read. */        
    }qIONode_t;

    typedef qBool_t (*qCoreRegSize_t)(const void* arg1, qBool_t arg2);
    
    typedef struct{
        private_start{
            qIONode_t *Head;
            qClock_t Start, DebounceTime;
            qCoreRegSize_t Reader;
            qUINT8_t State;
        }private_end;
    }qIOEdgeCheck_t;
    
    qBool_t __qReg_08Bits( const void *Address, qBool_t PinNumber );
    qBool_t __qReg_16Bits( const void *Address, qBool_t PinNumber );
    qBool_t __qReg_32Bits( const void *Address, qBool_t PinNumber );
    qBool_t qEdgeCheck_Initialize( qIOEdgeCheck_t * const Instance, const qCoreRegSize_t RegisterSize, const qClock_t DebounceTime );
    qBool_t qEdgeCheck_InsertNode( qIOEdgeCheck_t * const Instance, qIONode_t * const Node, void *PortAddress, const qBool_t PinNumber );    
    qBool_t qEdgeCheck_Update( qIOEdgeCheck_t * const Instance );
    qBool_t qEdgeCheck_GetNodeStatus( const qIONode_t * const Node );

    #ifdef __cplusplus
    }
    #endif

#endif 