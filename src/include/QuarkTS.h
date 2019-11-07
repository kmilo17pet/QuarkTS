/*
        _    _         _____  _  __           _______ _____   
       | |  | |  /\   |  __ \| |/ /          |__   __/ ____|  
   __ _| |  | | /  \  | |__) | ' /   ______     | | | (___    
  / _` | |  | |/ /\ \ |  _  /|  <   |______|    | |  \___ \   
 | (_| | |__| / ____ \| | \ \| . \              | |  ____) |  
  \__, |\____/_/    \_\_|  \_\_|\_\             |_| |_____/   
     | |                                                      
     |_|  
     
    QuarkTS V5.2.2 - Copyright (C) 2012 Eng. Juan Camilo Gomez C. MSc.
    All rights reserved
    
    This file is part of the QuarkTS OS distribution.
    
    VISIT https://github.com/TECREA/QuarkTS TO ENSURE YOU ARE USING THE LATEST VERSION.
    
    A Non-Preemptive RTOS for small embedded systems
    GNU Lesser General Public License (LGPL)
    C99 and MISRA-C 2004 Compliant
*/

#ifndef QuarkTS_H
    #define	QuarkTS_H

    #include "qtypes.h"
    #include "qkernel.h"
    #include "qtasks.h"    
    #include "qstimers.h"
    #include "qcoroutine.h"
    
    #include "qioutils.h"

    #if ( Q_TRACE_VARIABLES ==1 )
        #include "qtrace.h"
    #endif
    
    #if ( Q_MEMORY_MANAGER == 1 )
        #include "qmemmang.h"
    #endif

    #if ( Q_EDGE_CHECK_IOGROUPS == 1 )
        #include "qedgecheck.h"
    #endif

    #if ( Q_LISTS == 1 )
        #include "qlists.h"
    #endif

    #if ( Q_RESPONSE_HANDLER == 1 )
        #include "qresponse.h"
    #endif

    #if ( Q_BYTE_SIZED_BUFFERS ==1 )
        #include "qbsbuffers.h"
    #endif

    #include "qbitmacros.h"


    #if ( Q_DEFAULT_HEAP_SIZE < 64 )
        #error Q_DEFAULT_HEAP_SIZE it is too small. Min(64).
    #endif

    #if ( Q_BYTE_ALIGNMENT != 1 && Q_BYTE_ALIGNMENT != 2 && Q_BYTE_ALIGNMENT != 4 && Q_BYTE_ALIGNMENT != 8 )
        #error Q_BYTE_ALIGNMENT value not allowed, use only 1,2,4 or 8(default).
    #endif

    #if ( Q_DEBUGTRACE_BUFSIZE < 36 )
        #error Q_DEBUGTRACE_BUFSIZE its is too small. Use a value greather o equal to 36.
    #endif

#endif
