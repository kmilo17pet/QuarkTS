#define _POSIX_C_SOURCE	199309L
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
#include "QuarkTS.h"
#include <signal.h>

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
qTask_t Task1, Task2, Task3, Task4, Task5, Task6, TaskTestST, blinktask, SMTask;

qSM_Status_t firststate(qSM_t *fsm);
qSM_Status_t secondstate(qSM_t *fsm);

void datacapture(qSM_t *fsm){
    
}

/*============================================================================*/
qSM_Status_t firststate(qSM_t *fsm){
    qEvent_t e = fsm->Data;
    if(e->FirstCall){
        puts("state machine init");
    }
    static qSTimer_t tmr;
    if(fsm->StateJustChanged){
        qSTimerSet(&tmr, 0.1);
        printf("[%s] first\r\n", (char*)e->TaskData);
    }
    if (qSTimerExpired(&tmr)){
        fsm->NextState = secondstate;
    }
    return qSM_EXIT_SUCCESS;
}
/*============================================================================*/
qSM_Status_t secondstate(qSM_t *fsm){
    qEvent_t e = fsm->Data;
    static qSTimer_t tmr;
    if(fsm->StateJustChanged){
        qSTimerSet(&tmr, 0.5);
        printf("[%s] second\r\n", (char*)e->TaskData);
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
    /*
    qTaskQueueEvent(&Task2, "A");
    qTaskQueueEvent(&Task3, "B");
    qTaskQueueEvent(&Task4, "C");
    qTaskQueueEvent(&Task5, "D");
    qTaskQueueEvent(&Task6, "E");
    qTaskQueueEvent(&Task6, "F");
    qTaskQueueEvent(&Task6, "G");
    qTaskQueueEvent(&Task6, "H");
    qTaskQueueEvent(&Task6, "I");
    qTaskQueueEvent(&Task6, "J");
    qTaskQueueEvent(&Task6, "K");
    
    qTaskSendEvent(&Task5,"fuck");
    qTaskSendEvent(&Task6,"shit");
    qTaskSendEvent(&Task3,"dam"); 
    */
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

}
/*============================================================================*/
void blinktaskCallback(qEvent_t e){
    static qSTimer_t tmr;
    qCoroutineBegin{
        puts("led on");
        qCoroutineWaitUntil(qSTimerFreeRun(&tmr, 0.2));
        puts("led off");
        qCoroutineWaitUntil(qSTimerFreeRun(&tmr, 1.0));
    }qCoroutineEnd;
}
/*============================================================================*/
int main(int argc, char** argv) {
    
    qRBuffer_t ringBuffer;
    /*
    signal(SIGALRM, alarm_signal);
    signal(SIGINT, sigint_signal);
    */
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );
    qMemoryHeapCreate(mtxheap, 10, MEMBLOCK_4_BYTE);
    qSM_t statemachine;
    void *memtest;
    int x=5 , y=6;
    memtest = qMemoryAlloc(&mtxheap, 10*sizeof(int));
    qRBufferInit(&ringBuffer, memtest, 10, sizeof(int));
    qRBufferPush(&ringBuffer, &x);
    qRBufferPush(&ringBuffer, &y);
    qSchedulerSetup(0.01, IdleTaskCallback, 10);
    qSchedulerAddxTask(&Task1, Task1Callback, HIGH_Priority, 0.1, PERIODIC, qEnabled, "TASK1");
    qSchedulerAddeTask(&Task3, Task3Callback, 50, "TASK3");
    qTaskLinkRBuffer(&Task3, &ringBuffer, RB_AUTOPOP, qLINK);
    qSchedulerAddeTask(&Task4, Task4Callback, 10, "TASK4");
    qSchedulerAddeTask(&Task5, Task5Callback, 80, "TASK5");
    qSchedulerAddeTask(&Task6, Task6Callback, 10, "TASK6");
    qSchedulerAddxTask(&blinktask, blinktaskCallback, HIGH_Priority, TIME_INMEDIATE, PERIODIC, qEnabled, "blink");
    qSchedulerAddSMTask(&SMTask, HIGH_Priority, 0.1, &statemachine, firststate, NULL, NULL, NULL, NULL, qEnabled, "smtask");
    qSchedulerRun();
    return (EXIT_SUCCESS);
}

