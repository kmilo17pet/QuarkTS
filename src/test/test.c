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

uint32_t GetTickCountMs(void){ /*get system background timer (1mS tick)*/
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint32_t)(ts.tv_nsec / 1000000) + ((uint32_t)ts.tv_sec * 1000ull);
}
/*============================================================================*/
uint32_t PORTA = 0x0A;
qIOEdgeCheck_t INPUTS;
qIONode_t buton1, sensor1, buton2, sensor2;

qSM_t statemachine;


pthread_t TimerEmulation;
void* TimerInterruptEmulation(void* arg){
    struct timespec tick={0, 0.01*1E9};
    for(;;){
        nanosleep(&tick, NULL);
        /*
        qSchedulerSysTick();       
        */
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
        qDebugMessage("state machine init");
    }
    
    if(fsm->StateFirstEntry){
        qSTimerSet(&tmr, 2.5);
        qTraceMessage( (char*)e->TaskData );
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
        qTraceMessage( (char*)e->TaskData );
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
    qTraceMessage( (char*)e->TaskData );
    qTraceMessage( (char*)e->EventData );
    qTraceVariable( qTaskGetCycles(&Task1), UnsignedDecimal );
    
    if(e->FirstCall){
        qDebugMessage("FirstCall");
    }
    if(e->FirstIteration){
        qDebugMessage("FirstIteration");
    }
    if(e->LastIteration){
        qDebugMessage("LastIteration");
    }
    
    if(e->Trigger == byAsyncEvent){
        qDebugMessage("TASK1 BY ASYNC EVENT");
    }

    if(e->Trigger == byQueueExtraction){
        qDebugMessage("TASK1 BY QUEUE EXTRACTION");
    }
    
    if(qSTimerFreeRun(&tmr, 0.5)){
        qDebugMessage("Timer expired");
    }         
}
/*============================================================================*/
void Task2Callback(qEvent_t e){
    qTraceMessage( (char*)e->TaskData );
    qTraceMessage( (char*)e->EventData );
}
/*============================================================================*/
void Task3Callback(qEvent_t e){
    qTraceMessage( (char*)e->TaskData );
    qTraceMessage( (char*)e->EventData );
    if(e->Trigger == byQueueReceiver){
        int *ptr = (int*)e->EventData;
        qDebugMessage("Queue event: byQueueReceiver");
        qDebugVariable(*ptr, Decimal);
    } 
}
/*============================================================================*/
void Task4Callback(qEvent_t e){
    qTraceMessage( (char*)e->TaskData );
    qTraceMessage( (char*)e->EventData );
}
/*============================================================================*/
void Task5Callback(qEvent_t e){
    qTraceMessage( (char*)e->TaskData );
    qTraceMessage( (char*)e->EventData );
}
/*============================================================================*/
void Task6Callback(qEvent_t e){
    qTraceMessage( (char*)e->TaskData );
    qTraceMessage( (char*)e->EventData );   
}
/*============================================================================*/
void IdleTaskCallback(qEvent_t e){
    return;
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
    qCRPosition_t state;
    qCoroutineSemaphore_t mutex;
    qCoroutineSemaphoreInit(&mutex, 1);
    static  int count = 0;
    qCoroutineBegin{
        qDebugMessage("CR:A");
        qDebugMessage("CR:B");
        qDebugMessage("CR:C");
        qCoroutinePositionGet(state);
        qDebugMessage("CR:D");
        qDebugMessage("CR:E");
        qCoroutineDelay(0.1);
        qTraceVariable(count, Decimal);
        qDebugMessage("CR:F");
        qDebugMessage("CR:G");
        if(++count>10)  qCoroutinePositionRestore(state);
        qDebugMessage("CR:H");
        qCoroutineWaitUntil(qSTimerFreeRun(&tmr,2.0));
        qDebugMessage("CR:I");
        qDebugMessage("CR:J");
        qCoroutineYield;
        qCoroutineRestart;
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
    qSetDebugFcn(putcharfcn);
    int yy = -128;
    qQueue_t somequeue;
    void *memtest;

    int x[]={10,20,30,40,50,60,70,80,90,100};

    
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
    qTrace();
       
    qMemoryHeapCreate(mtxheap, 16, qMB_4B);
    memtest = qMemoryAlloc(&mtxheap, 16*sizeof(int));

    qQueueCreate(&somequeue, memtest, sizeof(int), 8);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    qQueueSend(&somequeue, &x[0]);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    qQueueSend(&somequeue, &x[1]);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    qQueueSend(&somequeue, &x[2]);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    qQueueSend(&somequeue, &x[3]);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    qQueueSend(&somequeue, &x[4]);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    qQueueSend(&somequeue, &x[5]);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    qQueueSend(&somequeue, &x[6]);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    qQueueSend(&somequeue, &x[7]);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    
    int rx = -1;
    
    puts("=============================================================================================");
    qQueueReceive(&somequeue, &rx);
    qTraceVariable(rx, Decimal);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    
    qQueueReceive(&somequeue, &rx);
    qTraceVariable(rx, Decimal);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);
    

    qQueueReceive(&somequeue, &rx);
    qTraceVariable(rx, Decimal);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);

    qQueueReceive(&somequeue, &rx);
    qTraceVariable(rx, Decimal);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);

    qQueueReceive(&somequeue, &rx);
    qTraceVariable(rx, Decimal);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);


    qQueueReceive(&somequeue, &rx);
    qTraceVariable(rx, Decimal);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);

    qQueueReceive(&somequeue, &rx);
    qTraceVariable(rx, Decimal);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);

    qQueueReceive(&somequeue, &rx);
    qTraceVariable(rx, Decimal);
    printf("full:%d empty:%d count:%d head: %d tail:%d\r\n", qQueueIsFull(&somequeue), qQueueIsEmpty(&somequeue), qQueueCount(&somequeue), somequeue.head, somequeue.tail);

    return EXIT_SUCCESS;
    
    /*
    int qdata = -1;

    int *ptr;
    ptr = qQueuePeek(&somequeue);
    qTraceVariable(*ptr, Decimal);
    qQueueReceive( &somequeue,  &qdata);
    qTraceVariable(qdata, Decimal);
    qQueueReceive( &somequeue,  &qdata);
    qTraceVariable(qdata, Decimal);
    qQueueReceive( &somequeue,  &qdata);
    qTraceVariable(qdata, Decimal);
    qQueueReceive( &somequeue,  &qdata);
    qTraceVariable(qdata, Decimal);
    qQueueReceive( &somequeue,  &qdata);
    qTraceVariable(qdata, Decimal);
    qQueueReceive( &somequeue,  &qdata);
    qTraceVariable(qdata, Decimal);

    qTraceVariable( qQueueCount(&somequeue), Decimal );
    return EXIT_SUCCESS;
    */

    qSchedulerSetup(GetTickCountMs, 0.001, IdleTaskCallback, 10);           
    qSchedulerAdd_Task(&blinktask, blinktaskCallback, qLowest_Priority, 0.05, qPeriodic, qEnabled, "blink");
    
    qSchedulerAdd_Task(&Task1, Task1Callback, qHigh_Priority, 0.5, 5, qEnabled, "TASK1");
    qSchedulerAdd_EventTask(&Task3, Task3Callback, qMedium_Priority, "TASK3");
       

    qTaskAttachQueue(&Task3, &somequeue, qQUEUE_RECEIVER, qATTACH);
    qDebugString("some message");
    qSchedulerAdd_EventTask(&Task4, Task4Callback, 10, "TASK4");
    qSchedulerAdd_EventTask(&Task5, Task5Callback, 80, "TASK5");
    qSchedulerAdd_EventTask(&Task6, Task6Callback, 10, "TASK6");
    qSchedulerAdd_StateMachineTask(&SMTask, qHigh_Priority, 0.1, &statemachine, firststate, NULL, NULL, NULL, NULL, qEnabled, "smtask");

    qSchedulerRun();
    return (EXIT_SUCCESS);
}