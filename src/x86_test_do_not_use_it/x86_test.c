/*
===================================================================================

WARNING:

This its just a test file for x86. Dont use this as reference example in your 
embedded application

===================================================================================
*/
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
/*#include <sys/time.h>*/
#include <signal.h>
#include <ctype.h>
#include <termios.h>
#include <math.h>
#include <assert.h>

#include "QuarkTS.h"

/*============================================================================*/
qClock_t GetTickCountMs(void){ /*get system background timer (1mS tick)*/
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (qClock_t)(ts.tv_nsec / 1000000) + ((qClock_t)ts.tv_sec * 1000ul);
}

/*============================================================================*/
qUINT32_t PORTA = 0x0A;
qIOEdgeCheck_t INPUTS;
qIONode_t button1, sensor1, button2, sensor2;

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
        
    }
    
    if (qSTimerExpired(&tmr)){
        qTraceMessage("timer of 2.5s expired");
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
    
    if(e->Trigger == byNotificationSimple){
        qDebugMessage("TASK1 BY SIMPLE NOTIFICATION");
    }

    if(e->Trigger == byNotificationQueued){
        qDebugMessage("TASK1 BY QUEUED NOTIFICATION");
    }
    
    if(qSTimerFreeRun(&tmr, 0.5)){
        qDebugMessage("Timer expired");
    }         
}
/*============================================================================*/
void Task3Callback(qEvent_t e){
    int data = -1;
    qTraceMessage( (char*)e->TaskData );
    qTraceMessage( (char*)e->EventData );

    if(e->Trigger == byQueueReceiver){
        data = *((int*)e->EventData);
        qDebugMessage("Queue event: byQueueReceiver");
        qDebugVariable(data, Decimal);
    } 
}
/*============================================================================*/
void TaskSameCallback(qEvent_t e){
    qTraceMessage( (char*)e->TaskData );
    qTraceMessage( (char*)e->EventData );
}
/*============================================================================*/
void IdleTaskCallback(qEvent_t e){
    static qSTimer_t t = QSTIMER_INITIALIZER;
    static qSTimer_t xd = QSTIMER_INITIALIZER;
    qEdgeCheck_Update(&INPUTS);

    if(e->FirstCall){
        qTraceMessage("IDLE TASK FIRST CALL");
        qSTimerSet(&t, 10.0);
    }

    if(qSTimerExpired(&t)){
        PORTA = ~PORTA;
        qTraceMessage("PORTA toggle");
        qSTimerDisarm(&t);
    }

    if(qSTimerFreeRun(&xd, 0.5)){
        qTraceUnsignedDecimal( qSTimerElapsed(&t) );
        qTraceUnsignedDecimal( qSTimerRemaining(&t) );
    }
}
/*============================================================================*/
void blinktaskCallback(qEvent_t e){
    qCoroutineBegin{
        qCoroutineDelay(2.0);
        puts("hello  1");
        qCoroutineDelay(2.0);
        puts("hello 2 ");

        qTaskSendNotification( qTaskSelf(), NULL );
        qTaskQueueNotification(&Task1, "notification 1");
        qTaskQueueNotification(&Task1, "notification 2");
        qTaskSendNotification(&Task1, "notification 3");
        qTaskSendNotification(&Task1, "notification 4");
        puts("notification sended to task1 ");
        /*qSchedulerRelease();*/
    }qCoroutineEnd;
}
/*============================================================================*/

typedef struct{
    qNode_MinimalFields;
    int priority;
}mynode_t;

qBool_t mylistprinter(void *node, void *arg){
    const mynode_t *xnode = node;
    printf( "%d->", xnode->priority ); 
    return qFalse;
}

qBool_t mylistcompare(const void *n1, const void *n2){
    const mynode_t *node1 = n1;
    const mynode_t *node2 = n2;
    
    return node1->priority > node2->priority;

}

void scheduler_Release(qEvent_t e){
    puts("SCHEDULER RELEASED");
}


int main(int argc, char** argv) {   
    qQueue_t somequeue;
    void *memtest;
    int x[]={10,20,30,40,50,60,70,80,90,100};

    qSetDebugFcn(putcharfcn);    
    
    mynode_t na, nb, nc, nd, ne;
    qList_t mylist1, mylist2;
    na.priority = 20;
    nb.priority = 39;
    nc.priority = 40;
    nd.priority = 100;
    ne.priority = 41;
    qList_Initialize( &mylist1 );
    qList_Initialize( &mylist2 );
   
    qList_Insert( &mylist1, &na, qList_AtFront );
    qList_Insert( &mylist1, &nb, qList_AtFront );
    qList_Insert( &mylist1, &ne, qList_AtFront );
   
    qList_Insert( &mylist2, &nc, qList_AtFront );
    qList_Insert( &mylist2, &nd, qList_AtFront);


    puts("\r\nlist1");
    qList_View( &mylist1, mylistprinter );
     puts("\r\nlist2");
    qList_View( &mylist2, mylistprinter );
    puts("");
    qList_Move( &mylist1, &mylist2, 3 );
    puts("===============================");
    puts("\r\nlist1");
    qList_View( &mylist1, mylistprinter );
     puts("\r\nlist2");
    qList_View( &mylist2, mylistprinter );
   
    printf("\r\nlist1 = %d  list2 = %d\r\n", qList_Length(&mylist1), qList_Length(&mylist2) );
    printf("head = %d   tail = %d\r\n", ((mynode_t*)qList_GetFront(&mylist1))->priority, ((mynode_t*)qList_GetBack(&mylist1))->priority );

    puts("===============================");
    qList_View( &mylist1, mylistprinter );
    puts("");
    qList_ForEach( &mylist1, mylistprinter, NULL, qTrue );

    return EXIT_SUCCESS;
    qTraceVariable( -3.1416, Float);
    qTraceVariable( "dafdaa", Message );
    qTraceVariable( sizeof(qTask_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qSM_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qSTimer_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qList_t) , UnsignedDecimal );
    
    qEdgeCheck_Initialize(&INPUTS, QREG_32BIT, 10);
    qEdgeCheck_InsertNode(&INPUTS, &button1, &PORTA, 0);
    qEdgeCheck_InsertNode(&INPUTS, &button2, &PORTA, 1);
    qEdgeCheck_InsertNode(&INPUTS, &sensor1, &PORTA, 2);
    qEdgeCheck_InsertNode(&INPUTS, &sensor2, &PORTA, 3);
    
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );

    qTraceVar( qHeapGetFreeSize() , Decimal);    
    memtest = qMalloc(16*sizeof(int));
    qTraceVar( qHeapGetFreeSize() , Decimal);
    qFree(memtest);
    qTraceVar( qHeapGetFreeSize() , Decimal);

    qQueueCreate( &somequeue, memtest, sizeof(int), 8);
    qQueueSendToBack( &somequeue, &x[0]);
    qQueueSendToFront( &somequeue, &x[1]);
    qQueueSendToBack( &somequeue, &x[2]);
    qQueueSendToFront( &somequeue, &x[3]);

    int b;

    qQueueReceive( &somequeue, &b);
    
    printf("queue received = %d \r\n", b);
    qQueueReceive( &somequeue, &b);
    printf("queue received = %d \r\n", b);
    qQueueReceive( &somequeue, &b);
    printf("queue received = %d \r\n", b);

    /*return EXIT_SUCCESS;*/
    qSchedulerSetup(GetTickCountMs, 0.001, IdleTaskCallback);           
    qSchedulerSetReleaseCallback( scheduler_Release );
    
    qSchedulerAdd_Task(&blinktask, blinktaskCallback, qLowest_Priority, 0.01, qPeriodic, qEnabled, "blink");    
    puts("added blink");
    qSchedulerAdd_Task(&Task1, Task1Callback, qHigh_Priority, 0.5, 5, qEnabled, "TASK1");
    puts("added task1");
    qSchedulerAdd_EventTask(&Task3, Task3Callback, qMedium_Priority, "TASK3");
    
    qTaskAttachQueue(&Task3, &somequeue, qQUEUE_RECEIVER, qATTACH);
    qSchedulerAdd_EventTask(&Task4, TaskSameCallback, 10, "TASK4");
    qSchedulerAdd_EventTask(&Task5, TaskSameCallback, 80, "TASK5");
    qSchedulerAdd_EventTask(&Task6, TaskSameCallback, 10, "TASK6");
    qSchedulerAdd_StateMachineTask(&SMTask, qHigh_Priority, 0.1, &statemachine, firststate, NULL, NULL, NULL, NULL, qEnabled, "smtask");
    
    qSchedulerRun();
    
    
    
    return (EXIT_SUCCESS);
}