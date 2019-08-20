/*
    QuarkTS V5.0.1 - Copyright (C) 2012 Eng. Juan Camilo Gomez C. MSc.
    A Non-Preemptive RTOS for small embedded systems
    GNU Lesser General Public License (LGPL)
    C99 and MISRA-C 2004 Compliant
*/

#ifndef QuarkTS_H
    #define	QuarkTS_H

    #include "qtypes.h"
    #include "qkernel.h"
    #include "qstimers.h"
    #include "qcoroutine.h"
    
    #include "qioutils.h"

    #if ( Q_ATCOMMAND_PARSER == 1)
        #include "qatparser.h"
    #endif

    #if ( Q_TRACE_VARIABLES ==1 )
        #include "qtrace.h"
    #endif
    
    #if ( Q_MEMORY_MANAGER == 1 )
        #include "qmemmang.h"
    #endif

    #if ( Q_EDGE_CHECK_IOGROUPS == 1 )
        #include "qedgecheck.h"
    #endif

    #if ( Q_LISTS == 1)
        #include "qlists.h"
    #endif

    #if ( Q_RESPONSE_HANDLER == 1 )
        #include "qresponse.h"
    #endif

    #if ( Q_BYTE_SIZED_BUFFERS ==1 )
        #include "qbsbuffers.h"
    #endif

    #include "qbitmacros.h"

    #ifndef __ORDER_LITTLE_ENDIAN__  /*default endianess: little-endian*/
        #define __ORDER_LITTLE_ENDIAN__     1
    #endif
    #ifndef __BYTE_ORDER__
        #define __BYTE_ORDER__  __ORDER_LITTLE_ENDIAN__
    #endif

#endif
