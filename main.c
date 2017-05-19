#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include "QuarkTS.h"


qSM_Status_t primero(qSM_t* Machine);
qSM_Status_t segundo(qSM_t* Machine);
qSM_Status_t tercero(qSM_t* Machine);

/*MACHINE STATES =============================================================*/
qSM_Status_t primero(qSM_t* Machine){   
    qEvent_t *TaskEventData = (qEvent_t *)Machine->Data;
    printf("%s %s \r\n",TaskEventData->EventData, TaskEventData->UserData);
    if(Machine->PreviousState == NULL){
        puts("Running by first time.");
    }
    if(Machine->PreviousState == tercero){
        puts("Sequence started again.");
    }
    puts("1");
    Machine->NextState = segundo;
    return qSM_EXIT_SUCCESS;
}
/*============================================================================*/
qSM_Status_t segundo(qSM_t* Machine){
    puts("2");
    Machine->NextState = tercero;
    return qSM_EXIT_SUCCESS;
}
/*============================================================================*/
qSM_Status_t tercero(qSM_t* Machine){
    static int x = 0;
    if(Machine->StateJustChanged){
        /*
         * TODO
        */
    }
    puts("3");
    Machine->NextState = primero;
    if(++x>=3){
        x = 0;
        return qSM_EXIT_FAILURE;
    }
    return qSM_EXIT_SUCCESS;
}
/*============================================================================*/
void smerror(qSM_t* Machine){
    puts("error");
}
/*============================================================================*/
void smok(qSM_t* Machine){
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
/*============================================================================*/
qTask_t Task1, Task2, Task3, Task4, Task5, Task6, TaskTestST;

void Task1Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
}
/*============================================================================*/
void Task2Callback(qEvent_t Data){
    static qSM_t Maquina1;
    if(Data.FirstCall){
        qStateMachine_Init(Maquina1, primero, smok, smerror, NULL);
    }
    qStateMachine_Run(Maquina1, &Data);
    printf("Userdata : %s  Eventdata:%s   %d\r\n", Data.UserData, Data.EventData, qGetCycles(Task2));
}
/*============================================================================*/
void Task3Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
    //qQueueEvent(Task2, "B"); 
    //qQueueEvent(Task1, "Z"); 
}
/*============================================================================*/
void Task4Callback(qEvent_t Data){
    static qSTimer_t Timer;
    if(Data.FirstCall){
        
    }  
    printf("Userdata : %s  Eventdata:%s    %d  \r\n", Data.UserData, Data.EventData,qGetCycles(Task4));
    qCoroutineBegin{              
        qQueueEvent(Task1, "A");
        qCoroutineYield;
        
        qQueueEvent(Task1, "B");
        qCoroutineYield;
        qSTimerSet(Timer, 5.0);
        qCoroutineWaitUntil(qSTimerExpired(Timer));
        qSTimerSet(Timer, 2.0);
        qQueueEvent(Task1, "C");       
        qQueueEvent(Task1, "D");
        qSTimerSet(Timer, 4.0);
        qCoroutineYield;
        qQueueEvent(Task1, "F");
        //qCoroutineRestart;
        qCoroutineWaitUntil(qSTimerExpired(Timer));
        
        qQueueEvent(Task1, "G");
        qCoroutineYield;
    }qCoroutineEnd;
}
/*============================================================================*/
void Task5Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);
    
}
/*============================================================================*/
void Task6Callback(qEvent_t Data){
    printf("Userdata : %s  Eventdata:%s\r\n", Data.UserData, Data.EventData);   
}
/*============================================================================*/
void IdleTaskCallback(qEvent_t Data){

}
/*============================================================================*/
void SchedReleaseCallback(qEvent_t Data){
    puts("\r\nScheduler Released");
}
/*============================================================================*/
void TaskTestSTCallback(qEvent_t Data){


}
/*============================================================================*/
qTask_t TaskX, TaskY;
void TaskX_Callback(qEvent_t Data){
    qCoroutineBegin{
        printf("a");
        qCoroutineYield;
        printf("b");
        qCoroutineYield;
        printf("c");        
        qCoroutineYield;
        
    }qCoroutineEnd;
}
/*============================================================================*/
void TaskY_Callback(qEvent_t Data){
    int i;
    qCoroutineBegin{
        printf("1");
        qCoroutineYield;
        printf("2");
        qCoroutineYield;
        puts("3");      
        qCoroutineYield;
        
    }qCoroutineEnd;    
}
/*============================================================================*/
int main(int argc, char** argv) {
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );
    qSetup(0.01, IdleTaskCallback, 10);
    //qSetReleaseSchedCallback(SchedReleaseCallback);
    qCreateEventTask(Task1, Task1Callback, HIGH_Priority, "TASK1");
    qCreateTask(Task2, Task2Callback, 20, 0.5, PERIODIC, ENABLE, "TASK2");
    qIgnoreOverruns(Task2, 1);
    qCreateTask(Task3, Task3Callback, MEDIUM_Priority, 1.0, 2, ENABLE, "TASK3");
    qCreateTask(Task4, Task4Callback, MEDIUM_Priority, 0.1, PERIODIC, ENABLE, "TASK4");
    qCreateTask(Task5, Task5Callback, MEDIUM_Priority, 2.0, SINGLESHOT, ENABLE, "TASK5");
    qCreateTask(Task6, Task6Callback, MEDIUM_Priority, TIME_INMEDIATE, 5, ENABLE, "TASK6");   
    //qCreateTask(TaskY, TaskY_Callback, HIGH_Priority, TIME_INMEDIATE, PERIODIC, ENABLE, NULL);
    //qCreateTask(TaskX, TaskX_Callback, HIGH_Priority, TIME_INMEDIATE, PERIODIC, ENABLE, NULL);    
    //qCreateTask(TaskTestST,  TaskTestSTCallback, MEDIUM_Priority, 0.1, PERIODIC, ENABLE, NULL);
    qSchedule();
    return (EXIT_SUCCESS);
}

