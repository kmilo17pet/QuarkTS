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
#include "unity.h"


/*===========================Reference clock for the kernel===================*/
qClock_t GetTickCountMs(void){ /*get system background timer (1mS tick)*/
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (qClock_t)(ts.tv_nsec / 1000000) + ((qClock_t)ts.tv_sec * 1000uL);
}
/*============================================================================*/
/*For unity --------------------------------------------------------------------------*/
void setUp (void) {} /* Is run before every test, put unit init calls here. */
void tearDown (void) {} /* Is run after every test, put unit clean-up calls here. */

typedef struct{
    qNode_MinimalFields;
    int value;
}mynode_t;

qList_t otherlist;
/*============================================================================*/
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
/*============================================================================*/
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
/*============================================================================*/
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
/*============================================================================*/
void test_qList_API(void){
    qList_t mylist;
    mynode_t n1, n2, n3, n4, n5, n6, n7, n8, n9, xn;

    qListIterator_t iter;
    mynode_t *inode = NULL;

    TEST_MESSAGE( "Executing TEST qList_API..." ); 
    qList_Initialize( &mylist );
    qList_Initialize( &otherlist ); 
    n1.value = 1;
    n2.value = 6;
    n3.value = 5;
    n4.value = 2;
    n5.value = 3;
    n6.value = 9;
    n7.value = 4;
    n8.value = 7;
    n9.value = 8;

    qList_SetMemoryAllocation( qMalloc, qFree );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &mylist, mylist_visualizer, NULL, qFalse, NULL ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_IsMember(&mylist, &n1) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n1, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n2, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n3, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n4, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n5, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n6, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n7, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n8, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_IsMember(&mylist, &n1) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &mylist, &n9, qList_AtBack )  );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_Insert( &mylist, &n9, qList_AtBack ) ); /*node n9 its already a member*/
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_Insert( &mylist, NULL, qList_AtBack ) ); 
    xn.value = 50;
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_DInsert( &mylist, &xn, sizeof(mynode_t), qList_AtBack ) );
    xn.value =88;
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_DInsert( &mylist, &xn, sizeof(mynode_t), qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &mylist, mylist_visualizer, NULL, QLIST_FORWARD, NULL ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Sort( &mylist, comparator ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &mylist, mylist_visualizer, NULL, QLIST_FORWARD, NULL ) );
    TEST_ASSERT_NOT_NULL( qList_DRemove( &mylist, NULL, qList_AtBack ) );
    TEST_ASSERT_NOT_NULL( qList_DRemove( &mylist, NULL, qList_AtBack ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &mylist, mylist_visualizer, NULL, QLIST_FORWARD, NULL ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_FORWARD, NULL ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &mylist, mylist_binremove, &mylist, QLIST_FORWARD, NULL ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &mylist, mylist_visualizer, NULL, QLIST_FORWARD, NULL ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_FORWARD, NULL ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_BACKWARD, NULL ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_FORWARD, &n3 ) );
    TEST_ASSERT_EQUAL_UINT8( qFalse, qList_ForEach( &otherlist, mylist_visualizer, NULL, QLIST_BACKWARD, &n3 ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qList_IteratorSet( &iter, &otherlist, &n3, QLIST_BACKWARD ) );
    
    while( NULL != ( inode = (mynode_t*)qList_IteratorGetNext(&iter) ) ){
        TEST_ASSERT_NOT_NULL( inode );
        printf("{%d}->\r\n", inode->value );
    }
}
/*============================================================================*/
void test_qMemoryManagement_API(void){
    void *memtest;
    TEST_MESSAGE( "Executing TEST qMemoryManagement_API..." ); 
    TEST_ASSERT_EQUAL_size_t( Q_DEFAULT_HEAP_SIZE - sizeof(qMemBlockConnect_t) , qHeapGetFreeSize() );
    memtest = qMalloc( 16*sizeof(int) );
    TEST_ASSERT_NOT_NULL( memtest );   
    
    TEST_ASSERT_EQUAL_size_t( Q_DEFAULT_HEAP_SIZE - sizeof(int)*16 - 2*sizeof(qMemBlockConnect_t), qHeapGetFreeSize() );
    qFree(memtest);
    TEST_ASSERT_EQUAL_size_t( Q_DEFAULT_HEAP_SIZE - sizeof(qMemBlockConnect_t) , qHeapGetFreeSize() );    
    TEST_ASSERT_NULL( qMalloc(Q_DEFAULT_HEAP_SIZE) );
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
        TEST_MESSAGE("event flag set");
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

    static qSTimer_t EndSchedulingTimeout = QSTIMER_INITIALIZER;

    qEdgeCheck_Update(&INPUTS);

    if(e->FirstCall){
        qTraceMessage("IDLE TASK FIRST CALL");
        qSTimerSet(&t, 10.0);
        qSTimerSet(&EndSchedulingTimeout, 30.0);
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

    if( qSTimerExpired(&EndSchedulingTimeout) ){
        qSchedulerRelease();
    }
}
/*============================================================================*/
void blinktaskCallback(qEvent_t e){
    qCoroutineBegin{
        qCoroutineDelay(2.0);
        TEST_MESSAGE("hello  1");
        qCoroutineDelay(2.0);
        TEST_MESSAGE("hello 2 ");

        qTaskSendNotification( qTaskSelf(), NULL );
        qTaskModifyEventFlags( &Task3, QEVENTFLAG_03, QEVENTFLAG_SET );
        qTaskQueueNotification(&Task1, "notification 1");
        qTaskQueueNotification(&Task1, "notification 2");
        qTaskSendNotification(&Task1, "notification 3");
        qTaskSendNotification(&Task1, "notification 4");
        TEST_MESSAGE("notification sended to task1 ");
        /**/
    }qCoroutineEnd;
}
/*============================================================================*/
void scheduler_Release(qEvent_t e){
    TEST_MESSAGE("SCHEDULER RELEASED");
}
/*============================================================================*/
void test_OS_API( void ){
    qQueue_t somequeue;
    int DataReceivedFromQueue;
    int x[]={10,20,30,40,50,60,70,80,90,100};
    int queuearea[8];

    TEST_MESSAGE( "Executing TEST OS_API.." ); 

    qSetDebugFcn(putcharfcn); 
    qTraceVariable( -3.1416, Float);
    qTraceVariable( "dafdaa", Message );
    qTraceVariable( sizeof(qTask_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qSM_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qSTimer_t) , UnsignedDecimal );
    qTraceVariable( sizeof(qList_t) , UnsignedDecimal );
    qTraceVariable( 1.0f/0.0f, Float );
    qTraceVariable( -1.0f/0.0f, Float );
    qTraceVariable( -0.0f/0.0f, Float );

    TEST_MESSAGE( "qEdgeCheck_Module.." ); 
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_Initialize(&INPUTS, QREG_32BIT, 10) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_InsertNode(&INPUTS, &button1, &PORTA, 0) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_InsertNode(&INPUTS, &button2, &PORTA, 1) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_InsertNode(&INPUTS, &sensor1, &PORTA, 2) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_InsertNode(&INPUTS, &sensor2, &PORTA, 3) );
    TEST_MESSAGE( "qQueue_Module..." ); 
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueueCreate( &somequeue, queuearea, sizeof(int), 8) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueueSendToBack( &somequeue, &x[0]) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueueSendToFront( &somequeue, &x[1]) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueueSendToBack( &somequeue, &x[2]) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueueSendToFront( &somequeue, &x[3]) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueueReceive( &somequeue, &DataReceivedFromQueue) );
    TEST_ASSERT_EQUAL_INT( x[3], DataReceivedFromQueue );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueueReceive( &somequeue, &DataReceivedFromQueue) );
    TEST_ASSERT_EQUAL_INT( x[1], DataReceivedFromQueue );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueueReceive( &somequeue, &DataReceivedFromQueue) );
    TEST_ASSERT_EQUAL_INT( x[0], DataReceivedFromQueue );


    TEST_MESSAGE( "OS scheduling..." ); 
    qSchedulerSetup(GetTickCountMs, 0.001, IdleTaskCallback);           
    qSchedulerSetReleaseCallback( scheduler_Release );

    TEST_ASSERT_EQUAL_UINT8( qTrue, qSchedulerAdd_Task(&blinktask, blinktaskCallback, qLowest_Priority, 0.01, qPeriodic, qEnabled, "blink") );   
    TEST_ASSERT_EQUAL_UINT8( qTrue, qSchedulerAdd_Task(&Task1, Task1Callback, qHigh_Priority, 0.5, 5, qEnabled, "TASK1") );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qSchedulerAdd_EventTask(&Task3, Task3Callback, qMedium_Priority, "TASK3") );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qTaskAttachQueue(&Task3, &somequeue, qQUEUE_RECEIVER, qATTACH) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qSchedulerAdd_EventTask(&Task4, TaskSameCallback, qMedium_Priority, "TASK4") );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qSchedulerAdd_EventTask(&Task5, TaskSameCallback, qMedium_Priority, "TASK5") );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qSchedulerAdd_EventTask(&Task6, TaskSameCallback, qMedium_Priority, "TASK6") );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qSchedulerAdd_StateMachineTask(&SMTask, qHigh_Priority, 0.1, &statemachine, firststate, NULL, NULL, NULL, NULL, qEnabled, "smtask") );
    
    qSchedulerRun();
}


int main(int argc, char** argv) {   
    UNITY_BEGIN();
 
    RUN_TEST( test_qList_API );
    RUN_TEST( test_qMemoryManagement_API );
    pthread_create(&TimerEmulation, NULL, TimerInterruptEmulation, NULL );
    RUN_TEST( test_OS_API );

    UNITY_END();   /*return (EXIT_SUCCESS);*/
}