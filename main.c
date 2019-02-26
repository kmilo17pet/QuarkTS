#define _POSIX_C_SOURCE	199309L
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
#include <signal.h>
#include <ctype.h>
#include <termios.h>
#include <math.h>
#include <assert.h>
#include <float.h>

#include "QuarkTS.h"



/*============================================================================*/
uint32_t PORTA = 0x0A;
qIOEdgeCheck_t INPUTS;
qIONode_t buton1, sensor1, buton2, sensor2;

pthread_t TimerEmulation;
void* TimerInterruptEmulation(void* arg){
    struct timespec tick={0, 0.01*1E9};
    for(;;){
        nanosleep(&tick, NULL);
        qSchedulerSysTick();       
    }
}
/*============================================================================*/
qTask_t Task1, Task2, Task3, Task4, Task5, Task6, TaskTestST, blinktask, SMTask, SMTask2;

qSM_Status_t firststate(qSMData_t fsm);
qSM_Status_t secondstate(qSMData_t fsm);

/*============================================================================*/
void datacapture(qSMData_t fsm){
    
}
void putcharfcn(void* stp, char c){
    putchar(c);
}
/*============================================================================*/
qSM_Status_t firststate(qSMData_t fsm){
    qEvent_t e = fsm->Data;
    static qSTimer_t tmr;
    if(e->FirstCall){
        puts("state machine init");
    }
    
    if(fsm->StateFirstEntry){
        qSTimerSet(&tmr, 2.5);
        printf("[%s] first\r\n", (char*)e->TaskData);
    }
    if (qSTimerExpired(&tmr)){
        fsm->NextState = secondstate;
    }
    return qSM_EXIT_SUCCESS;
}
/*============================================================================*/
qSM_Status_t secondstate(qSMData_t fsm){
    qEvent_t e = fsm->Data;
    static qSTimer_t tmr;
    if(fsm->StateFirstEntry){
        qSTimerSet(&tmr, 2.5);
        printf("[%s] second\r\n", (char*)e->TaskData);
        qTaskQueueEvent(&Task1, "HELLO");
    }
    
    if (qSTimerExpired(&tmr)){
        fsm->NextState = firststate;
    }
    return qSM_EXIT_SUCCESS;
}
/*============================================================================*/
void Task1Callback(qEvent_t e){
    static qSTimer_t tmr = QSTIMER_INITIALIZER;
    printf("Userdata : %s  Eventdata:%s   %d\r\n", (char*)e->TaskData, (char*)e->EventData, qTaskGetCycles(&Task1));
    
    
    if(e->FirstCall){
        puts("FirstCall");
    }
    if(e->FirstIteration){
        puts("FirtsIteration");
    }
    if(e->LastIteration){
        puts("LastIteration");
    }
    
    if(e->Trigger == byAsyncEvent){
        puts("TASK1 BY ASYNC EVENT");
    }

    if(e->Trigger == byQueueExtraction){
        puts("TASK1 BY QUEUE EXTRACTION");
    }
    
    if(qSTimerFreeRun(&tmr, 0.5)){
        puts("Timer expired");
    }         
}
/*============================================================================*/
void Task2Callback(qEvent_t e){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)e->TaskData, (char*)e->EventData);
}
/*============================================================================*/
void Task3Callback(qEvent_t e){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)e->TaskData, (char*)e->EventData);
    if(e->Trigger == byRBufferPop){
        int *ptr = (int*)e->EventData;
        printf("ring extracted data %d\r\n",*ptr);
    } 
}
/*============================================================================*/
void Task4Callback(qEvent_t e){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)e->TaskData, (char*)e->EventData);
}
/*============================================================================*/
void Task5Callback(qEvent_t e){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)e->TaskData, (char*)e->EventData);
}
/*============================================================================*/
void Task6Callback(qEvent_t e){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)e->TaskData, (char*)e->EventData);   
}
/*============================================================================*/
void IdleTaskCallback(qEvent_t e){
    static qSTimer_t t = QSTIMER_INITIALIZER;
    qEdgeCheck_Update(&INPUTS);
    qTraceVariable( buton2.Status , qBool );
    if(qSTimerFreeRun(&t, 0.5)){
        PORTA = ~PORTA;
    }
}
/*============================================================================*/
void blinktaskCallback(qEvent_t e){
    static qSTimer_t tmr;
    static qResponseHandler_t rep;
    qCRPosition_t state;
    qCoroutineSemaphore_t mutex;
    qCoroutineSemaphoreInit(&mutex, 1);
    qCoroutineBegin{
        puts(">>>>>>>>>>>>>>led on");
        qCoroutinePositionGet(state);
        qSTimerSet(&tmr, 1);
        qCoroutineWaitUntil( qSTimerExpired(&tmr) );
        
        qCoroutineSemaphoreWait(&mutex);
        qCoroutinePositionGet(state);
        qSTimerSet(&tmr, 1);
        /**/
        
        /*qCoroutinePositionRestore(state);*/
        qCoroutineSemaphoreSignal(&mutex);
        puts(">>>>>>>>>>>>>>led off");
        qTaskSendEvent(&Task1, NULL);
        qCoroutineWaitUntil(qSTimerExpired(&tmr));
        puts(">>>>>>>>>>>>>>led fuck");
        qSTimerSet(&tmr, 0.5);
        qCoroutineWaitUntil(qSTimerExpired(&tmr));
    }qCoroutineEnd;
}
/*============================================================================*/
uint32_t qStringHash(const char* s, uint8_t mode){
    uint32_t hash;
    switch(mode){
        case 0: /*D. J. Bernstein */
            for(hash = 5381; *s;) hash = 33*hash^((uint8_t)*s++);
            return hash;
        case 1: /*Fowler/Noll/Vo (FNV) */
            for(hash = 0x811c9dc5; *s; hash *= 0x01000193) hash ^= ((uint8_t)*s++);
            return hash;
        case 2: /*Jenkins' One-at-a-Time*/
            for(hash=0; *s; hash ^= (hash >> 6)) hash += (*s++) + (hash << 10);
            hash += (hash << 3);
            hash ^= (hash >> 11);
            hash += (hash << 15);
            return hash;
        case 3: /*sdbm*/
            for(hash=0; *s; hash = (*s++) + (hash<<6) + (hash<<16) - hash );
            return hash; 
        default : return 0;
    }    
    return 0;
}

/*============================================================================*/
int main(int argc, char** argv) {      
    int yy = -128;
    
    qSetDebugFcn(putcharfcn);
           
    qEdgeCheck_Initialize(&INPUTS, QREG_32BIT, 10);
    qEdgeCheck_InsertNode(&INPUTS, &buton1, &PORTA, 0);
    qEdgeCheck_InsertNode(&INPUTS, &buton2, &PORTA, 1);
    qEdgeCheck_InsertNode(&INPUTS, &sensor1, &PORTA, 2);
    qEdgeCheck_InsertNode(&INPUTS, &sensor2, &PORTA, 3);
    
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );
   
    qTraceVariable( yy, Decimal);
    qTraceMessage( "test" );
    qTraceVariable( 48765, UnsignedDecimal);
    qTraceVariable( yy, Binary);
    qTraceVariable( yy, UnsignedHexadecimal );
    qTraceVariable( yy, UnsignedBinary);
    qTraceVariable( 0, UnsignedHexadecimal );
    qTraceVariable( 0b01001101, Binary );
    qTraceMemory( &yy, sizeof(yy));
    qTraceVariable( 3.1416, Float);
    qTraceVariable( qStringHash("aloh", 0), UnsignedDecimal);
    qTraceVariable( qStringHash("hola", 0), UnsignedDecimal);
    qTraceVariable( qStringHash("hannah", 0), UnsignedDecimal);
    qTrace();
    

    qRBuffer_t ringBuffer;
    
    qMemoryHeapCreate(mtxheap, 10, qMB_4B);
    qSM_t statemachine;
    void *memtest;
    int x=5 , y=6;
    memtest = qMemoryAlloc(&mtxheap, 10*sizeof(int));
    qRBufferInit(&ringBuffer, memtest, sizeof(int), 10);
    qRBufferPush(&ringBuffer, &x);
    qRBufferPush(&ringBuffer, &y); y=1;
    qRBufferPush(&ringBuffer, &y); y=-7;
    qRBufferPush(&ringBuffer, &y); 
    
    qSchedulerSetup(0.01, IdleTaskCallback, 10);           
    qSchedulerAddxTask(&blinktask, blinktaskCallback, qLowest_Priority, 0.05, qPeriodic, qEnabled, "blink");
    qSchedulerAddxTask(&Task1, Task1Callback, qHigh_Priority, 0.5, 5, qEnabled, "TASK1");
    qSchedulerAddeTask(&Task3, Task3Callback, qMedium_Priority, "TASK3");

    qTaskLinkRBuffer(&Task3, &ringBuffer, qRB_AUTOPOP, qLink);
    qSchedulerAddeTask(&Task4, Task4Callback, 10, "TASK4");
    qSchedulerAddeTask(&Task5, Task5Callback, 80, "TASK5");
    qSchedulerAddeTask(&Task6, Task6Callback, 10, "TASK6");
    qSchedulerAddSMTask(&SMTask, qHigh_Priority, 0.1, &statemachine, firststate, NULL, NULL, NULL, NULL, qEnabled, "smtask");
    /*qISR_Byte_t DataAlloc[100] = {0};
    qISR_ByteBuffer_t Buffer;
    qISR_ByteBufferInit(&Buffer, DataAlloc, sizeof(DataAlloc), '\r', isalpha, tolower);*/
    
    qSchedulerRun();
    return (EXIT_SUCCESS);
}