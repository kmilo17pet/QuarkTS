#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include "QuarkTS.h"


qSM_Status_t primero(qSM_t* Machine);
qSM_Status_t segundo(qSM_t* Machine);
qSM_Status_t tercero(qSM_t* Machine);

/*MACHINE STATES =============================================================*/
qSM_Status_t primero(qSM_t* Machine){
    puts("1");
    if(Machine->PreviousState == NULL){
        puts("oelo");
    }
    if(Machine->PreviousState == tercero){
        puts("again");
    }
    Machine->NextState = segundo;
    return SM_OK;
}

qSM_Status_t segundo(qSM_t* Machine){
    puts("2");
    Machine->NextState = tercero;
    return SM_OK;
}

qSM_Status_t tercero(qSM_t* Machine){
    static int x = 0;
    puts("3");
    Machine->NextState = primero;
    if(++x>=3){
        x = 0;
        return SM_ERROR;
    }
    return SM_OK;
}

qSM_Status_t smerror(qSM_t* Machine){
    puts("error");
}

qSM_Status_t smok(qSM_t* Machine){
    puts("ok...");
}

/*============================================================================*/

pthread_t TimerEmulation;
void* TimerInterruptEmulation(void* varargin){
    struct timespec tick={0, 0.01*1E9};
    for(;;){
        nanosleep(&tick, NULL);
        qISRHandler();
    }
}

qTask_t Task1, Task2, Task3, Task4, Task5, Task6;

void Task1Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
}

void Task2Callback(qEvent_t Data){
    static qSM_t Maquina1;
    if(Data.FirstCall){
        qStateMachine_Init(Maquina1, primero, smok, smerror, NULL);
    }
    qStateMachine_Run(Maquina1);
    printf("Userdata : %s  Eventdata:%s   %d\r\n", Data.UserData, Data.EventData, qGetCycles(Task2));
}

void Task3Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
    //qQueueEvent(Task2, "B"); 
    //qQueueEvent(Task1, "Z"); 
}

void Task4Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
    qQueueEvent(Task1, "A");
    qQueueEvent(Task2, "B");
    qQueueEvent(Task3, "C");
    qQueueEvent(Task3, "D");
    qQueueEvent(Task2, "F");
    qQueueEvent(Task2, "G");
    //qQueueEvent(Task2, "A");
 
    //qQueueEvent(Task1, "C");
    //qQueueEvent(Task1, "D");
    //qQueueEvent(Task2, "E");   
    //qSetPriority(Task1, 10);
}

void Task5Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
    
}

void Task6Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);   
}


void IdleTaskCallback(qEvent_t Data){

}

void SchedReleaseCallback(qEvent_t Data){
    puts("\r\nScheduler Released");
}

int main(int argc, char** argv) {
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );
    qSetup(0.01, IdleTaskCallback, 10);
    qSetReleaseSchedCallback(SchedReleaseCallback);
    qCreateEventTask(Task1, Task1Callback, HIGH_Priority, "TASK1");
    qCreateTask(Task2, Task2Callback, 20, 1.0, PERIODIC, ENABLE, "TASK2");
    qIgnoreOverruns(Task2, 1);
    qCreateTask(Task3, Task3Callback, MEDIUM_Priority, 1.0, 2, ENABLE, "TASK3");
    qCreateTask(Task4, Task4Callback, MEDIUM_Priority, 1.5, 2, ENABLE, "TASK4");
    qCreateTask(Task5, Task5Callback, MEDIUM_Priority, 2.0, SINGLESHOT, ENABLE, "TASK5");
    //qCreateTask(Task6, Task6Callback, MEDIUM_Priority, TIME_INMEDIATE, 5, ENABLE, "TASK6");
    qSchedule();
    return (EXIT_SUCCESS);
}

