#ifndef  QEDGECHECK_H
    #define QEDGECHECK_H

    #include "qtypes.h"
    #include "qclock.h"

    
    #define QREG_8BIT               __qReg_08Bits
    #define QREG_16BIT              __qReg_16Bits
    #define QREG_32BIT              __qReg_32Bits
    
    #define QEDGECHECK_WAIT         ( 0u )
    #define QEDGECHECK_UPDATE       ( 1u )
    #define QEDGECHECK_CHECK        ( 2u )


    typedef struct _qIONode_t{
        qBool_t Pin, PreviousPinValue, Status;
        struct _qIONode_t *Next;
        void *Port;
    }qIONode_t;

    typedef qBool_t (*qCoreRegSize_t)(void*, qBool_t);
    typedef struct{
        qIONode_t *Head;
        qClock_t Start, DebounceTime;
        qCoreRegSize_t Reader;
        qBool_t State;
    }qIOEdgeCheck_t;
    qBool_t __qReg_08Bits( void *Address, qBool_t PinNumber );
    qBool_t __qReg_16Bits( void *Address, qBool_t PinNumber );
    qBool_t __qReg_32Bits( void *Address, qBool_t PinNumber );
    qBool_t qEdgeCheck_Initialize( qIOEdgeCheck_t *Instance, const qCoreRegSize_t RegisterSize, qClock_t DebounceTime );
    qBool_t qEdgeCheck_InsertNode( qIOEdgeCheck_t *Instance, qIONode_t *Node, void *PortAddress, qBool_t PinNumber );    
    qBool_t qEdgeCheck_Update( qIOEdgeCheck_t *Instance );
    qBool_t qEdgeCheck_GetNodeStatus( const qIONode_t *Node );

#endif 