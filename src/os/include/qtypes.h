/*This file is part of the QuarkTS OS distribution.*/
#ifndef QTYPES_H
    #define QTYPES_H

    #include <stdlib.h>
    #include "qconfig.h"

    #ifndef NULL
        #define NULL ((void*)0)
    #endif

    #if ( Q_USE_STDINT_H  == 1 )
        #include <stdint.h>
        /*Unsigned types*/
        typedef uint8_t qUINT8_t;
        typedef uint16_t qUINT16_t;
        typedef uint32_t qUINT32_t;
        /*Signed types*/
        typedef int8_t qINT8_t;
        typedef int16_t qINT16_t;
        typedef int32_t qINT32_t;      
    #else
        /*Unsigned types*/
        typedef unsigned char qUINT8_t;
        typedef unsigned short qUINT16_t;
        typedef unsigned long qUINT32_t;

        /*Signed types*/
        typedef signed char qINT8_t;
        typedef short qINT16_t;
        typedef long qINT32_t;

    #endif

    typedef qUINT8_t qByte_t;
    typedef int qBase_t;
    /*Floating-point types*/
    typedef float qFloat32_t;
    typedef double qFloat64_t; /*this is not always true in some compilers*/
        

    #define __QUARKTS__
    #define _QUARKTS_CR_DEFS_
    #define QUARKTS_VERSION         "5.4.6"
    #define QUARKTS_CAPTION         "QuarkTS OS " QUARKTS_VERSION

    #define _UNUSED_(x)             (void)(x)

    #ifndef STRUCT_PRIVATE_MEMBERS /*to define private inside kernel objects*/
        #define STRUCT_PRIVATE_MEMBERS
        #define ___private_join( symbol1, symbol2 )     ___private_do_join( symbol1, symbol2 )
        #define ___private_do_join( symbol1, symbol2 )   symbol1##symbol2
        #define private_start                           struct ___private_join( qPrivate_, __LINE__ )
        #define private_end                             qPrivate
    #endif

    typedef qUINT8_t qPriority_t;
    typedef qINT32_t qIteration_t;
    typedef qUINT8_t qState_t;
    typedef qUINT8_t qBool_t;
    typedef size_t qIndex_t; /*better portability*/
    typedef qUINT32_t qCycles_t;
    
    #define qFalse                  ( (qBool_t)0x00u )
    #define qTrue                   ( (qBool_t)0x01u )
    #define qEnabled                ( (qState_t)0x01u )
    #define qDisabled               ( (qState_t)0x00u )
    #define qAwake                  ( 2u )
    #define qAsleep                 ( 3u )
    #define qLINK                   ( qTrue )
    #define qUNLINK                 ( qFalse )  
    #define qLink                   ( qTrue )
    #define qATTACH                 ( qTrue )
    #define qDETACH                 ( qFalse )
    #define qAttach                 ( qTrue )
    #define qDetach                 ( qFalse )    
    #define qUnLink                 ( qFalse )
    #define qON                     ( qTrue )
    #define qOFF                    ( qFalse )
    
    #define qRESPONSETIMEOUT        ( (qBool_t)0x02u )
    #define qRISING                 ( (qBool_t)0x03u )
    #define qFALLING                ( (qBool_t)0x04u )
    #define qUNKNOWN                ( (qBool_t)0xFFu )

    typedef enum{
        qOff                = qOFF,
        qOn                 = qON,
        qResponseTimeout    = qRESPONSETIMEOUT,           
        qRising             = qRISING,
        qFalling            = qFALLING,  
        qUnknown            = qUNKNOWN     
    }qIOStatus_t;  

#endif