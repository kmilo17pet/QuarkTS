#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include "QuarkTS.h"

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
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
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
    //puts("IDLE");
    //qQueueEvent(Task6,"async");
}

int main(int argc, char** argv) {
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );
    qSetup(0.01, IdleTaskCallback, 10);
    qCreateEventTask(Task1, Task1Callback, HIGH_Priority, "TASK1");
    qCreateTask(Task2, Task2Callback, 20, 1.0, PERIODIC, ENABLE, "TASK2");
    qCreateTask(Task3, Task3Callback, MEDIUM_Priority, 1.0, 2, ENABLE, "TASK3");
    qCreateTask(Task4, Task4Callback, MEDIUM_Priority, 1.5, 2, ENABLE, "TASK4");
    qCreateTask(Task5, Task5Callback, MEDIUM_Priority, 2.0, SINGLESHOT, ENABLE, "TASK5");
    //qCreateTask(Task6, Task6Callback, MEDIUM_Priority, TIME_INMEDIATE, 5, ENABLE, "TASK6");
    qSchedule();

    return (EXIT_SUCCESS);
}

