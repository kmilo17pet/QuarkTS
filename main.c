/* 
 * File:   main.c
 * Author: CamiloGomez
 *
 * Created on 12 de diciembre de 2015, 8:49
 */

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


qTask_t Task1, Task2, Task3, Task4, Task5;

void Task1Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
}

void Task2Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
}

void Task3Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
}

void Task4Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
    qSendEvent(Task1, "ASYNC");
    qQueueEvent(Task2, "data 1 t2");
    qQueueEvent(Task3, "hello");  
    qQueueEvent(Task1, "hi!");
    qQueueEvent(Task1, "qurakts");
    qQueueEvent(Task2, "task 2 t2");    
}

void Task5Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
    
}

int main(int argc, char** argv) {
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );

    qSetup(0.01, NULL, 5);
    qCreateEventTask(Task1, Task1Callback, HIGH_Priority, "TASK1");
    qCreateTask(Task2, Task2Callback, 20, 1.0, PERIODIC, ENABLE, "TASK2");
    qCreateTask(Task3, Task3Callback, MEDIUM_Priority, 1.0, 2, ENABLE, "TASK3");
    qCreateTask(Task4, Task4Callback, 8, 1.5, 2, ENABLE, "TASK4");
    qCreateTask(Task5, Task5Callback, 8, 2.0, SINGLESHOT, ENABLE, "TASK5");
    qSchedule();

    return (EXIT_SUCCESS);
}

