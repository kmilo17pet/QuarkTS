/*!
 * @file QuarkTS.h
 * @author J. Camilo Gomez C.
 * @version 2.11
 * @note This file is part of the QuarkTS distribution.
 * @brief Global inclusion header
 **/

/*
QuarkTS V7.2.4 - An open-source OS for small embedded applications.
MIT License
C99 and MISRAC 2012 Compliant

Copyright (C) 2012 Eng. Juan Camilo Gómez Cadavid MSc. All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

VISIT https://github.com/kmilo17pet/QuarkTS TO ENSURE YOU ARE USING THE LATEST
VERSION.


This file is part of the QuarkTS OS distribution.
*/

/*
Download the user manual here : https://github.com/kmilo17pet/quarkts-usermanual/raw/manual/QuarkTS_UserManual.pdf
Read the API reference here ; https://kmilo17pet.github.io/QuarkTS/
*/

#ifndef QuarkTS_H
    #define QuarkTS_H

    #define QUARKTS_VERSION         "7.2.2"
    #define QUARKTS_VERNUM          ( 0722u )
    #define QUARKTS_CAPTION         "QuarkTS OS " QUARKTS_VERSION

    #include "qtypes.h"
    #include "qlists.h"
    #include "qkernel.h"
    #include "qtasks.h"
    #include "qcoroutine.h"
    #include "qioutils.h"
    #include "qtrace.h"

    #if ( Q_MEMORY_MANAGER == 1 )
        #include "qmemmang.h"
    #endif

    #if ( Q_EDGE_CHECK_IOGROUPS == 1 )
        #include "qedgecheck.h"
    #endif

    #if ( Q_RESPONSE_HANDLER == 1 )
        #include "qresponse.h"
    #endif

    #if ( Q_BYTE_SIZED_BUFFERS ==1 )
        #include "qbsbuffers.h"
    #endif

    #include "qflm.h"

    #ifndef Q_PRIO_QUEUE_SIZE
        #define Q_PRIO_QUEUE_SIZE       ( 10 )
    #endif

    #if ( Q_PRIO_QUEUE_SIZE < 0 )
        #error Q_PRIO_QUEUE_SIZE should be a value greater of equal than zero.
    #endif

    #if ( Q_PRIO_QUEUE_SIZE > 512 )
        #error Q_PRIO_QUEUE_SIZE its too large.
    #endif

#endif

/**
*  @defgroup qos Operative System
*  This section contains the documentation related to all the Interfaces and 
*  intrinsic definitions of the operating system.
*/

/**
*  @defgroup qtaskcreation Scheduler Interface
*  @ingroup qos
*/

/**
*  @defgroup qtaskmanip Managing tasks
*  @ingroup qos
*/

/**
*  @defgroup qpriv Inter-Task communication
*  @brief Inter-Task communication primitives : Queues, Notifications and Event-flags
*  @ingroup qos
*/

/**
*  @defgroup qqueues Queues
*  @ingroup qpriv
*/

/**
*  @defgroup qnot Notifications
*  @ingroup qpriv
*/

/**
*  @defgroup qeventflags Event Flags
*  @ingroup qpriv
*/

/**
*  @defgroup qclock Clock
*  @ingroup qos
*/

/**
*  @defgroup qcritical Critical
*  @ingroup qos
*/

/**
*  @defgroup qtypes Types and macros
*  @ingroup qos
*/

/**
*  @defgroup qmodules Kernel extensions
*  This section contains the documentation related to all the extensions that 
*  adds additional functionality to the operating system.
*/

/**
*  @defgroup qfsm Finite State Machines
*  @ingroup qmodules
*/

/**
*  @defgroup qstimers Software-Timers
*  @ingroup qmodules
*/

/**
*  @defgroup qcoroutines Co-Routines
*  @ingroup qmodules
*/

/**
*  @defgroup qatcli AT Command Line Interface
*  @ingroup qmodules
*/

/**
*  @defgroup qmemmang Memory Management
*  @ingroup qmodules
*/

/**
*  @defgroup qutility Utilities
*  A collection of utility libraries for the QuarkTS OS
*/

/**
*  @defgroup qlists Generic double-linked lists
*  @ingroup qutility
*/

/**
*  @defgroup qbsbuffers Byte-Sized buffers
*  @ingroup qutility
*/

/**
*  @defgroup qedgecheck I/O Groups for edge checking
*  @ingroup qutility
*/

/**
*  @defgroup qioutils I/O Utils
*  @ingroup qutility
*/

/**
*  @defgroup qresponse Response handler
*  @ingroup qutility
*/

/**
*  @defgroup qtrace Trace
*  @ingroup qutility
*/

/**
*  @defgroup qflm General purpose macros
*  @ingroup qutility
*/
