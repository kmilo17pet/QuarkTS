/*!
* @file qtypes.h
* @author J. Camilo Gomez C.
* @version 1.45
* @note This file is part of the QuarkTS distribution.
* @brief type definitions for all OS interfaces
*/
#ifndef QTYPES_H
    #define QTYPES_H

    #include <stdlib.h>

    #ifndef  QCONFIG_H          /*if this file available?*/
        #include "qconfig.h"
    #endif


    #ifndef Q_USE_STDINT_H
        #define Q_USE_STDINT_H      ( 1 )     
    #endif

    #if( Q_USE_STDINT_H != 1 )
        #warning Disposing standard types can cause portability issues and undefined behaviors. QuarkTS produce similar definitions based on the common sizes of native types, however, this sizes can vary because they are implementation-defined  across different compilers. Use this setting at your own risk.
    #endif

    #ifndef NULL
        #define NULL ((void*)0)
    #endif

    #define     Q_UNUSED(arg)     (void)(arg)

    /** @addtogroup  qtypes Base types and macros
    *  @{
    */

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
        typedef unsigned long qUINT32_t;    /*Not always true, be careful with this definition */

        /*Signed types*/
        typedef signed char qINT8_t;
        typedef short qINT16_t;
        typedef long qINT32_t;              /*Not always true, be careful with this definition */

    #endif

    typedef qUINT8_t qByte_t;
    typedef int qBase_t;
    /*Floating-point types*/
    typedef float qFloat32_t;  /*this is not always true in some compilers*/   
    typedef double qFloat64_t; /*this is not always true in some compilers*/   
    
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
    #define qIgnore                 ( (qBool_t)0xFE )
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

    /** @}*/

#endif
