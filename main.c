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
qTask_t Task1, Task2, Task3, Task4, Task5, Task6, TaskTestST, blinktask;
qTask_t *taskx;

qSM_Status_t firststate(qSM_t *fsm);
qSM_Status_t secondstate(qSM_t *fsm);

qSM_Status_t firststate(qSM_t *fsm){
    static qSTimer_t tmr;
    if(fsm->StateJustChanged){
        qSTimerSet(&tmr, 0.1);
        puts("first");
    }
    if (qSTimerExpired(&tmr)){
        fsm->NextState = secondstate;
    }
    return qSM_EXIT_SUCCESS;
}
qSM_Status_t secondstate(qSM_t *fsm){
    static qSTimer_t tmr;
    if(fsm->StateJustChanged){
        qSTimerSet(&tmr, 0.5);
        puts("second");
    }
    if (qSTimerExpired(&tmr)){
        fsm->NextState = firststate;
    }
    return qSM_EXIT_SUCCESS;
}

/*============================================================================*/
void Task1Callback(qEvent_t Data){
    static qSTimer_t tmr = QSTIMER_INITIALIZER;
    printf("Userdata : %s  Eventdata:%s   %d\r\n", (char*)Data.UserData, (char*)Data.EventData, qTaskGetCycles(&Task1));
    qTaskQueueEvent(&Task2, "A"); /*20*/
    qTaskQueueEvent(&Task3, "B"); /*50*/
    qTaskQueueEvent(&Task4, "C"); /*10*/
    qTaskQueueEvent(&Task5, "D"); /*80*/
    qTaskQueueEvent(&Task6, "E"); /*10*/
    qTaskQueueEvent(&Task6, "F"); /*10*/
    qTaskQueueEvent(&Task6, "G"); /*10*/
    qTaskQueueEvent(&Task6, "H"); /*10*/
    qTaskQueueEvent(&Task6, "I"); /*10*/
    qTaskQueueEvent(&Task6, "J"); /*10*/
    qTaskQueueEvent(&Task6, "K"); /*10*/
    qTaskSendEvent(&Task5,"fuck");
    qTaskSendEvent(&Task6,"shit");
    qTaskSendEvent(&Task3,"dam"); 
    if(qSTimerFreeRun(&tmr, 0.5)){
        puts("Timer expired");
    }
}
/*============================================================================*/
void Task2Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)Data.UserData, (char*)Data.EventData);
}
/*============================================================================*/
void Task3Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)Data.UserData, (char*)Data.EventData);
    if(Data.Trigger == byRBufferPop){
        int *ptr = (int*)Data.EventData;
        printf("ring extracted data %d\r\n",*ptr);
    }
}
/*============================================================================*/
void Task4Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)Data.UserData, (char*)Data.EventData);
}
/*============================================================================*/
void Task5Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)Data.UserData, (char*)Data.EventData);
}
/*============================================================================*/
void Task6Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", (char*)Data.UserData, (char*)Data.EventData);   
}
/*============================================================================*/
void IdleTaskCallback(qEvent_t Data){
    static qSM_t statemachine;
    if(Data.FirstCall){
        qStateMachine_Init(&statemachine, firststate, NULL, NULL, NULL);
    }
    qStateMachine_Run(&statemachine, NULL);
}
/*============================================================================*/
void blinktaskCallback(qEvent_t Data){
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
    qMemoryHeapCreate(mtxheap, 3, MEMBLOCK_4_BYTE);

    void *memtest;
    int x=5 , y=6;
    memtest = qMemoryAlloc(&mtxheap, 10);
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
    qSchedulerRun();
    return (EXIT_SUCCESS);
}

