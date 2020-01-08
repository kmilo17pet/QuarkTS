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
#include <sys/time.h>
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
    return (qClock_t)(ts.tv_nsec / 1000000) + ((qClock_t)ts.tv_sec * 1000uL);
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
    if(e->Trigger == byEventFlags){
        puts("event flag set");
        qTaskModifyEventFlags( qTaskSelf(), QEVENTFLAG_03, QEVENTFLAG_CLEAR );
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
        qTaskModifyEventFlags( &Task3, QEVENTFLAG_03, QEVENTFLAG_SET );
        qTaskQueueNotification(&Task1, "notification 1");
        qTaskQueueNotification(&Task1, "notification 2");
        qTaskSendNotification(&Task1, "notification 3");
        qTaskSendNotification(&Task1, "notification 4");
        puts("notification sended to task1 ");
        /*qSchedulerRelease();*/
    }qCoroutineEnd;
}
/*============================================================================*/
void scheduler_Release(qEvent_t e){
    puts("SCHEDULER RELEASED");
}

typedef struct{
    qNode_MinimalFields;
    int value;
}mynode_t;

qBool_t mylist_visualizer(void *node, void *arg, qList_WalkStage_t stage){
    mynode_t *xnode = node;
    switch (stage){
        case qList_WalkInit:
            printf("list={");
            break;
        case qList_WalkThrough:
            printf("%d->", xnode->value );
            break;
        case qList_WalkEnd:
            puts("}");
            break;    
        default: break;
    }
    return qFalse;
}

qList_t otherlist;

qBool_t mylist_binremove( void *node, void *arg, qList_WalkStage_t stage){
    mynode_t *xnode = node;
    switch (stage){
        case qList_WalkInit:
            break;
        case qList_WalkThrough:
            if( xnode->value & 1 ){
                qList_Remove( arg, node, 0 );
                qList_Insert( &otherlist, node, qList_AtBack );
            }
            break;
        case qList_WalkEnd:
            break;    
        default: break;
    }
    return qFalse;    
}


qBool_t comparator(const void *p, const void *q) { 
    const mynode_t *n1 = p;
    const mynode_t *n2 = q;
    int l, r;

    l = n1->value;
    r = n2->value;
    /* both odd, put the greater of two first. */
    if ((l&1) && (r&1)) 
        return l>r; 
  
    /* both even, put the smaller of two first */
    if ( !(l&1) && !(r&1) ) 
        return l>r; 
  
    /*l is even, put r first */
    if (!(l&1)) 
        return qTrue; 
  
    /* l is odd, put l first */
    return qFalse; 
} 

int main(int argc, char** argv) {
       
    qQueue_t somequeue;
    void *memtest;
    int b;
    int x[]={10,20,30,40,50,60,70,80,90,100};


    qList_t mylist;
    mynode_t n1, n2, n3, n4, n5, n6, n7, n8, n9, xn;

    qListIterator_t iter;
    mynode_t *inode = NULL;

    n1.value = 1;
    n2.value = 6;
    n3.value = 5;
    n4.value = 2;
    n5.value = 3;
    n6.value = 9;
    n7.value = 4;
    n8.value = 7;
    n9.value = 8;

    qSetDebugFcn(putcharfcn); 

    qList_Initialize( &mylist );
    qList_Initialize( &otherlist ); 

    qList_SetMemoryAllocation( qMalloc, qFree );
    qList_ForEach( &mylist, mylist_visualizer, NULL, qFalse, NULL );

    qTraceqBool( qList_IsMember(&mylist, &n1) );

    qList_Insert( &mylist, &n1, qList_AtBack );
    qList_Insert( &mylist, &n2, qList_AtBack );
    qList_Insert( &mylist, &n3, qList_AtBack );
    qList_Insert( &mylist, &n4, qList_AtBack );
    qList_Insert( &mylist, &n5, qList_AtBack );
    qList_Insert( &mylist, &n6, qList_AtBack );
    qList_Insert( &mylist, &n7, qList_AtBack );
    qList_Insert( &mylist, &n8, qList_AtBack );

    qTraceqBool( qList_IsMember(&mylist, &n1) );
    assert( qList_Insert( &mylist, &n9, qList_AtBack ) == qTrue );
    assert( qList_Insert( &mylist, &n9, qList_AtBack ) == qFalse ); /*node n9 its already a member*/
    assert( qList_Insert( &mylist, NULL, qList_AtBack ) == qFalse ); 

    xn.value = 50;
    qList_DInsert( &mylist, &xn, sizeof(mynode_t), qList_AtBack );
    xn.value =88;
    qList_DInsert( &mylist, &xn, sizeof(mynode_t), qList_AtBack );

    qList_ForEach( &mylist, mylist_visualizer, NULL, QLIST_FORWARD, NULL );
    qList_Sort( &mylist, comparator );
    qList_ForEach( &mylist, mylist_visualizer, NULL, QLIST_FORWARD, NULL );
    
    qList_DRemove( &mylist, NULL, qList_AtBack );
    qList_DRemove( &mylist, NULL, qList_AtBack );
    qList_ForEach( &mylist, mylist_visualizer, NULL, QLIST_FORWARD, NULL );

    
    qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_FORWARD, NULL );

    qList_ForEach( &mylist, mylist_binremove, &mylist, QLIST_FORWARD, NULL );

    qList_ForEach( &mylist, mylist_visualizer, NULL, QLIST_FORWARD, NULL );
    qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_FORWARD, NULL );
    qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_BACKWARD, NULL );

    
    qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_FORWARD, &n3 );
    qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_BACKWARD, &n3 );


    qList_IteratorSet( &iter, &otherlist, &n3, QLIST_BACKWARD );
    
    while( NULL != ( inode = (mynode_t*)qList_IteratorGetNext(&iter) ) ){
        printf("{%d}->\r\n", inode->value );
    }

    qTraceVariable( -3.1416, Float);
    qTraceVariable( "dafdaa", Message );
    qTraceVariable( sizeof(qTask_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qSM_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qSTimer_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qList_t) , UnsignedDecimal );
    qTraceVariable( 1.0f/0.0f, Float );
    qTraceVariable( -1.0f/0.0f, Float );
    qTraceVariable( -0.0f/0.0f, Float );
    
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

    qQueueReceive( &somequeue, &b);
    
    printf("queue received = %d \r\n", b);
    qQueueReceive( &somequeue, &b);
    printf("queue received = %d \r\n", b);
    qQueueReceive( &somequeue, &b);
    printf("queue received = %d \r\n", b);

    qSchedulerSetup(GetTickCountMs, 0.001, IdleTaskCallback);           
    qSchedulerSetReleaseCallback( scheduler_Release );
    qSchedulerAdd_Task(&blinktask, blinktaskCallback, qLowest_Priority, 0.01, qPeriodic, qEnabled, "blink");   
    qSchedulerAdd_Task(&Task1, Task1Callback, qHigh_Priority, 0.5, 5, qEnabled, "TASK1");
    qSchedulerAdd_EventTask(&Task3, Task3Callback, qMedium_Priority, "TASK3");
    qTaskAttachQueue(&Task3, &somequeue, qQUEUE_RECEIVER, qATTACH);
    qSchedulerAdd_EventTask(&Task4, TaskSameCallback, qMedium_Priority, "TASK4");
    qSchedulerAdd_EventTask(&Task5, TaskSameCallback, qMedium_Priority, "TASK5");
    qSchedulerAdd_EventTask(&Task6, TaskSameCallback, qMedium_Priority, "TASK6");
    qSchedulerAdd_StateMachineTask(&SMTask, qHigh_Priority, 0.1, &statemachine, firststate, NULL, NULL, NULL, NULL, qEnabled, "smtask");

    qSchedulerRun();
    
    
    return (EXIT_SUCCESS);
}