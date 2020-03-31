/*
QuarkTS V6.2.2  - A Cooperative OS for small embedded systems
GNU General Public License v3 (GPL-3)
C99 and MISRA-C 2012 Compliant    

Copyright (C) 2012 Eng. Juan Camilo Gomez C. MSc.
All rights reserved
    
This OS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published 
by the Free Software Foundation, either version 3 of the License, 
or (at your option) any later version.

This OS is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License 
along with this program. If not, see https://www.gnu.org/licenses/.

VISIT https://github.com/TECREA/QuarkTS TO ENSURE YOU ARE USING THE LATEST VERSION.
    

This file is part of the QuarkTS OS distribution.
*/

/* 
Download the user manual here : https://github.com/TECREA/QuarkTS/blob/master/quarkts_usermanual.pdf
*/

#ifndef QuarkTS_H
    #define	QuarkTS_H

    #include "qtypes.h"
    #include "qlists.h"
    #include "qkernel.h"
    #include "qtasks.h"    
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

    #if ( Q_RESPONSE_HANDLER == 1 )
        #include "qresponse.h"
    #endif

    #if ( Q_BYTE_SIZED_BUFFERS ==1 )
        #include "qbsbuffers.h"
    #endif

    #include "qflm.h"


    #if ( Q_PRIORITY_LEVELS < 1 )
        #error Q_PRIORITY_LEVELS must be defined to be greater than or equal to 1.
    #endif

    #if ( Q_DEFAULT_HEAP_SIZE < 64 )
        #error Q_DEFAULT_HEAP_SIZE it is too small. Min(64).
    #endif

    #if ( ( Q_BYTE_ALIGNMENT != 1 ) && ( Q_BYTE_ALIGNMENT != 2 ) && ( Q_BYTE_ALIGNMENT != 4 ) && ( Q_BYTE_ALIGNMENT != 8 ) )
        #error Q_BYTE_ALIGNMENT value not allowed, use only 1,2,4 or 8(default).
    #endif

    #if ( Q_DEBUGTRACE_BUFSIZE < 36 )
        #error Q_DEBUGTRACE_BUFSIZE its is too small. Use a value greather o equal to 36.
    #endif

    #if ( Q_PRIO_QUEUE_SIZE < 0 )   
        #error Q_PRIO_QUEUE_SIZE should be a value greater of equal than zero.
    #endif

    #if( Q_USE_STDINT_H != 1 )
        #warning Disposing standard types can cause portability issues and undefined behaviors. QuarkTS produce similar definitions based on the common sizes of native types, however, this sizes can vary because they are implementation-defined  across different compilers. Use this setting at your own risk.
    #endif

    #if ( Q_FSM_MAX_NEST_DEPTH < 1 )
        #error Q_FSM_MAX_NEST_DEPTH must be defined to be greater than or equal to 1.
    #endif

    #ifndef Q_TASK_EVENT_FLAGS
        #define Q_TASK_EVENT_FLAGS  ( 1 )
    #endif

    #include "qbackward.h"

#endif
