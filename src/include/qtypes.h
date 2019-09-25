/*This file is part of the QuarkTS distribution.*/
#ifndef QTYPES_H
    #define QTYPES_H

    #ifdef __IAR_SYSTEMS_ICC__ /*stdint.h missing for some stupid reason*/
        #if defined( __ICC8051__ ) || defined ( __ICCARM__)
            #if !defined( STDINT_H ) && !defined( _STDINT )  /*_STDINT only in IAR */
                #define STDINT_H
                typedef unsigned char uint8_t;
                typedef unsigned short uint16_t;
                typedef unsigned long uint32_t;
                typedef uint32_t uint64_t[2];

                typedef signed char int8_t;
                typedef short int16_t;
                typedef long int32_t;
                typedef int32_t int64_t[2];
            #endif
        #endif      
    #else
        #include <stdint.h>
    #endif    
    
    #include <stdlib.h>
    #include "qconfig.h"

    #ifndef NULL
        #define NULL ((void*)0)
    #endif

    #define __QUARKTS__
    #define _QUARKTS_CR_DEFS_
    #define QUARKTS_VERSION         "5.1.1"
    #define QUARKTS_CAPTION         "QuarkTS " QUARKTS_VERSION

    #define _UNUSED_(x)             (void)(x)
 
    #define qFalse                  ( 0x00u )
    #define qTrue                   ( 0x01u )
    #define qEnabled                ( qTrue )
    #define qDisabled               ( qFalse )
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
    
    #define qRESPONSETIMEOUT        ( 0x02u )
    #define qRISING                 ( 0x03u )
    #define qFALLING                ( 0x04u )
    #define qUNKNOWN                ( 0xFFu )

    typedef enum{
        qOff                = qOFF,
        qOn                 = qON,
        qResponseTimeout    = qRESPONSETIMEOUT,           
        qRising             = qRISING,
        qFalling            = qFALLING,  
        qUnknown            = qUNKNOWN     
    }qIOStatus_t;    

    #ifndef STRUCT_PRIVATE_MEMBERS
        #define STRUCT_PRIVATE_MEMBERS
        #define ___private_join( symbol1, symbol2 )     ___private_do_join( symbol1, symbol2 )
        #define ___private_do_join( symbol1, symbol2 )   symbol1##symbol2
        #define private_start                           struct ___private_join( private_, __LINE__ )
        #define private_end                             private
    #endif

    typedef uint8_t qPriority_t;
    typedef int16_t qIteration_t;
    typedef uint8_t qState_t;
    typedef uint8_t qBool_t;
    typedef uint16_t qSize_t;
  
#endif