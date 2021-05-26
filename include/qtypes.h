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
    #define     Q_NONE

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

    /** \addtogroup  qtypes
    *  @{
    */

    /** 
    * @brief A type-def to instantiate a byte variable
    */
    typedef qUINT8_t qByte_t;

    /** 
    * @brief A type-def to instantiate a integer-base variable
    * @note Compiler implementation-defined
    */    
    typedef int qBase_t;

    /** 
    * @brief A type-def to instantiate a single-precision variable of 32-bits.
    */   
    typedef float qFloat32_t;  /*this is not always true in some compilers*/   

    /** 
    * @brief A type-def to instantiate a double-precision variable of 64-bits.
    */       
    typedef double qFloat64_t; /*this is not always true in some compilers*/   
    
    /** 
    * @brief A type-def to instantiate a variable to hold the priority value of a task.
    */     
    typedef qUINT8_t qPriority_t;

    /** 
    * @brief A type-def to instantiate a variable that hold the number of task iterations.
    */       
    typedef qINT32_t qIteration_t;

    /** 
    * @brief A type-def to instantiate an OS state value.
    */  
    typedef qUINT8_t qState_t;
 
    /** 
    * @brief A type-def to instantiate an OS boolean variable.
    */  
    typedef qUINT8_t qBool_t;

    /** 
    * @brief A type-def to instantiate an OS index variable.
    */  
    typedef size_t qIndex_t; /*better portability*/

    /** 
    * @brief A type-def to instantiate a variable that hold the number of task cycles.
    */        
    typedef qUINT32_t qCycles_t;
    
    /** 
    * @brief A boolean value that represents false/Off/Low.
    */     
    #define qFalse                  ( (qBool_t)0x00u )

    /** 
    * @brief A boolean value that represents true/On/High.
    */     
    #define qTrue                   ( (qBool_t)0x01u )

    /** 
    * @brief A state value that enables a task.
    */      
    #define qEnabled                ( (qState_t)0x01u )

    /** 
    * @brief A state value that disables a task.
    */     
    #define qDisabled               ( (qState_t)0x00u )

    /** 
    * @brief A state value that awakes a task.
    */      
    #define qAwake                  ( 2u )

    /** 
    * @brief A state value that put a task in sleep mode.
    */  
    #define qAsleep                 ( 3u )

    /** 
    * @brief An operation value that links an object to a task.
    */  
    #define qLink                   ( qTrue )

    /** 
    * @brief An operation value that unlink an object from a task.
    */       
    #define qUnLink                 ( qFalse )

    /** @cond */ 
    #define qIgnore                 ( (qBool_t)0xFE )
    #define qLINK                   ( qTrue )
    #define qUNLINK                 ( qFalse )  
    #define qATTACH                 ( qTrue )
    #define qDETACH                 ( qFalse )
    #define qAttach                 ( qTrue )
    #define qDetach                 ( qFalse )   
    /** @endcond */ 

    /** 
    * @brief A status value that indicates a response timeout.
    */     
    #define qRESPONSETIMEOUT        ( (qBool_t)0x02u )

    /** 
    * @brief A status value that indicates a rising-edge condition.
    */         
    #define qRISING                 ( (qBool_t)0x03u )

    /** 
    * @brief A status value that indicates a falling-edge condition.
    */        
    #define qFALLING                ( (qBool_t)0x04u )

    /** 
    * @brief A status value that indicates an unknown condition.
    */       
    #define qUNKNOWN                ( (qBool_t)0xFFu )

    /** @}*/

#endif
