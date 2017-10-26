#define _POSIX_C_SOURCE	199309L
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
#include "QuarkTS.h"
#include <signal.h>

qTask_t TSK_PRODUCER, TSK_CONSUMER; /*task nodes*/
qRBuffer_t handler_RBuffer; /*Ring-Buffer Handler*/
/*============================================================================*/
pthread_t TimerEmulation;
void* TimerInterruptEmulation(void* varargin){
    struct timespec tick={0, 0.01*1E9};
    for(;;){
        nanosleep(&tick, NULL);
        qSchedulerSysTick();
    }
}
/*============================================================================*/
void TSK_Producer_Callback(qEvent_t e) {
    static uint16_t unData = 0;
    unData++;	
    /*Buffer is empty, enable the producer if it was disabled*/
    if(e->Trigger == byRBufferEmpty){
        qTaskResume(qTaskSelf());
        puts("producer resumed");
    }
    printf("producer inserting %d\r\n",unData);
    if (!qRBufferPush(&handler_RBuffer, &unData)){ /*insert data into the buffer*/
        /*if the data insertion fails, the buffer is full and the task disables itself*/
	qTaskSuspend(qTaskSelf()); 
        puts("producer suspended");
    }
}
/*-------------------------------------------------------------------------------*/
/* The consumer task gets one element from the buffer. 
 */
void TSK_Consumer_Callback(qEvent_t e) {
    uint16_t unData;
    qRBuffer_t *rbuffer;
    if(e->Trigger == byRBufferCount){
	rbuffer = (qRBuffer_t *)e->EventData;
	qRBufferPopFront(rbuffer, &unData);
        printf("consumer extracting %d \r\n",unData);
	return;
    }
}
/*-------------------------------------------------------------------------------*/
void IdleTask_Callback(qEvent_t e){
    /*nothing to do...*/
}
/*============================================================================*/
int main(int argc, char** argv) {
    uint8_t BufferMem[16*sizeof(uint16_t)] = {0};  
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );

    qRBufferInit(&handler_RBuffer, BufferMem /*Memory block used*/, sizeof(uint16_t) /*element size*/, 16 /* element count*/);  
    qSchedulerSetup(0.01, IdleTask_Callback, 10);    
    qSchedulerAddxTask(&TSK_PRODUCER, TSK_Producer_Callback, 50, 0.1, qPeriodic, qDisabled, "producer");
    qSchedulerAddeTask(&TSK_CONSUMER, TSK_Consumer_Callback, 50, "consumer");
    qTaskLinkRBuffer(&TSK_CONSUMER, &handler_RBuffer, RB_COUNT, 10);
    qTaskLinkRBuffer(&TSK_PRODUCER, &handler_RBuffer, RB_EMPTY, qLINK);
    qSchedulerRun();
    return (EXIT_SUCCESS);
}

