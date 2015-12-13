#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include "QuarkTS.h"

qNewTaskID(task1);
qNewTaskID(task2);
qNewTaskID(task3);
qNewTaskID(task4);
qNewTaskID(task5);

pthread_t TimerEmulation;
void* TimerInterruptEmulation(void* varargin){
    struct timespec tick={0, 0.01*1E9};
    for(;;){
        nanosleep(&tick, NULL);
        qISRHandler();
    }
}

void IdleTask(qEventInfo_t event){
    
}

void task1(qEventInfo_t event){
    printf("\r\nt1:%u,%u,%u,%s\r\n",event.FirstCall,event.LastTaskID,event.Trigger,(char*)event.UserData);
    //
}
void task2(qEventInfo_t event){
    printf("\r\nt2-%u,%u,%u,%s\r\n",event.FirstCall,event.LastTaskID,event.Trigger,(char*)event.UserData);
}
void task3(qEventInfo_t event){
    printf("\r\nt3-%u,%u,%u,%s\r\n",event.FirstCall,event.LastTaskID,event.Trigger,(char*)event.UserData);
    qSendEvent(task1);
}
void task5(qEventInfo_t event){
    printf("\r\nTASK5-%u,%u,%u,%s\r\n",event.FirstCall,event.LastTaskID,event.Trigger,(char*)event.UserData);
}
void task4(qEventInfo_t event){
    printf("\r\nt4-%u,%u,%u\r\n",event.FirstCall,event.LastTaskID,event.Trigger);
    qSendEvent(task1);
    qQueueEvent(task2, "data 1 t2");
    qQueueEvent(task3, "hello");  
    qQueueEvent(task1, "hi!");
    qQueueEvent(task1, "pkernel");
    qQueueEvent(task2, "task 2 t2");
}

int main(void) {
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );
    
    qSetup(5, 10, 0.01, NULL);
    qCreateEventTask(task1, HIGH_Priority, NULL);
    qCreateTask(task2, 20, 1.0, PERIODIC, ENABLE, NULL);
    qCreateTask(task3,  MEDIUM_Priority, 1.0, 2 , ENABLE , NULL);
    qCreateTask(task4,  8, 1.5, 2, ENABLE, NULL);
    qCreateTask(task5,  8, 2.0, SINGLESHOT, ENABLE, NULL);
    qSchedule();
    
    return (EXIT_SUCCESS);
}
 
