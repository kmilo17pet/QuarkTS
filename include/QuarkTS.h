/*
QuarkTS V7.0.1- An open-source OS for small embedded applications.
GNU General Public License v3 (GPL-3)
C99 and MISRAC 2012 Compliant    

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

    #define QUARKTS_VERSION         "7.0.1"
    #define QUARKTS_CAPTION         "QuarkTS OS " QUARKTS_VERSION

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

    #ifndef Q_PRIO_QUEUE_SIZE
        #define Q_PRIO_QUEUE_SIZE       (10)
    #endif

    #if ( Q_PRIO_QUEUE_SIZE < 0 )   
        #error Q_PRIO_QUEUE_SIZE should be a value greater of equal than zero.
    #endif


    #include "qbackward.h"

#endif
