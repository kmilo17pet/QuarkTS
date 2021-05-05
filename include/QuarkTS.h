/*
QuarkTS V7.0.1- An open-source OS for small embedded applications.
MIT License
C99 and MISRAC 2012 Compliant    

Copyright (C) 2020 Amazon.com, Inc. or its affiliates.  All Rights Reserved.

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

VISIT https://github.com/TECREA/QuarkTS TO ENSURE YOU ARE USING THE LATEST VERSION.
    

This file is part of the QuarkTS OS distribution.
*/

/* 
Download the user manual here : https://github.com/kmilo17pet/quarkts-usermanual/raw/manual/QuarkTS_UserManual.pdf
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
