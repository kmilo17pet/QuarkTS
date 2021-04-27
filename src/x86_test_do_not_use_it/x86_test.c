/*
===================================================================================

WARNING:

This its just a minor-test file for x86. Dont use this as reference example in your 
embedded application
This is not a full OS test, most of the built-in modules are tested externally with
embedded C compilers in real hardware( theses are not included in this repository)

===================================================================================
*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
#include <math.h>
#include "QuarkTS.h"
#include "unity.h"


#define QSM_SIGNAL_USER1    1
#define QSM_SIGNAL_USER2    1

    #if  (Q_SETUP_TIME_CANONICAL != 1)
        #define T10MSEC         0.01f    
        #define T100MSEC        0.1f
        #define T500MSEC        0.5f
        #define T1SEC           1.0f
        #define T2SEC           2.0f        
        #define T2_5SEC         2.5f
        #define T10SEC          10.0f
        #define T30SEC          30.0f        
    #else
        #define T10MSEC         10
        #define T100MSEC        100
        #define T500MSEC        500
        #define T1SEC           1000
        #define T2SEC           2000           
        #define T2_5SEC         2500
        #define T10SEC          10000
        #define T30SEC          30000
    #endif


/*===========================Reference clock for the kernel===================*/
qClock_t GetTickCountMs(void){ /*get system background timer (1mS tick)*/
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (qClock_t)(ts.tv_nsec / (qClock_t)1000000uL) + ((qClock_t)ts.tv_sec * (qClock_t)1000uL);
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
qBool_t mylist_visualizer( qList_ForEachHandle_t h ){
    mynode_t *xnode = h->node;
    switch( h->stage ){
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
qBool_t mylist_binremove( qList_ForEachHandle_t h ){
    mynode_t *xnode = h->node;
    switch( h->stage ){
        case qList_WalkInit:
            break;
        case qList_WalkThrough:
            if( xnode->value & 1 ){
                TEST_ASSERT_NOT_NULL( qList_Remove( h->arg, h->node, 0 ) );
                TEST_ASSERT_EQUAL_UINT8( qTrue, qList_Insert( &otherlist, h->node, qList_AtBack ) );
            }
            break;
        case qList_WalkEnd:
            break;    
        default: break;
    }
    return qFalse;    
}
/*============================================================================*/
qBool_t comparator( qList_CompareHandle_t h ) { 
    const mynode_t *n1 = h->n1;
    const mynode_t *n2 = h->n2;
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

    qList_Iterator_t iter;
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
    void *memtest, *xpooltest;
    qMemMang_Pool_t xpool;
    #define XPOOL_SIZE  ( 512 )
    uint8_t xpool_area[XPOOL_SIZE]={0};
    TEST_ASSERT_EQUAL_UINT8( qTrue, qMemMang_Pool_Setup(  &xpool, xpool_area, sizeof(xpool_area) ) );
    TEST_MESSAGE( "Executing TEST qMemoryManagement_API..." ); 
    TEST_ASSERT_EQUAL_size_t( Q_DEFAULT_HEAP_SIZE - sizeof(qMemMang_BlockConnect_t) , qMemMang_Get_FreeSize( NULL ) );
    memtest = qMalloc( 16*sizeof(int) );
    TEST_ASSERT_NOT_NULL( memtest );   
    
    qMemMang_Pool_Select( &xpool );
    xpooltest = qMalloc( 25 );
    TEST_ASSERT_NOT_NULL( xpooltest );   
    qMemMang_Pool_Select( NULL );

    TEST_ASSERT_EQUAL_size_t( Q_DEFAULT_HEAP_SIZE - sizeof(int)*16 - 2*sizeof(qMemMang_BlockConnect_t), qMemMang_Get_FreeSize( NULL ) );
    qFree(memtest);
    TEST_ASSERT_EQUAL_size_t( Q_DEFAULT_HEAP_SIZE - sizeof(qMemMang_BlockConnect_t) , qMemMang_Get_FreeSize( NULL) );    
    TEST_ASSERT_NULL( qMalloc(Q_DEFAULT_HEAP_SIZE) );
}
/*============================================================================*/
qUINT32_t PORTA = 0x0A;
qEdgeCheck_t INPUTS;
qEdgeCheck_IONode_t button1, sensor1, button2, sensor2;

qSM_t statemachine;
qSM_State_t statefirst, statesecond, statethird;

/*============================================================================*/
qTask_t Task1, Task2, Task3, Task4, Task5, Task6, TaskTestST, blinktask, SMTask, SMTask2;

qSM_Status_t statefirst_callback(qSM_Handler_t fsm);
qSM_Status_t statesecond_callback(qSM_Handler_t fsm);
qSM_Status_t statethird_callback(qSM_Handler_t fsm);
qSM_Status_t statetop_callback(qSM_Handler_t h);
/*============================================================================*/
void datacapture(qSM_Handler_t fsm){
    (void)fsm;
}
void putcharfcn(void* stp, char c){
    (void)stp;
    putchar(c);
}
/*============================================================================*/
qSM_Status_t statetop_callback(qSM_Handler_t h){
    (void)h;
    return qSM_STATUS_EXIT_SUCCESS;
}
/*============================================================================*/
qSM_Status_t statefirst_callback(qSM_Handler_t h){
    qEvent_t e = h->Data;
    static qSTimer_t tmr;

    if(e->FirstCall){
        TEST_MESSAGE("state machine init");
    }
  
    switch( h->Signal ){
        case QSM_SIGNAL_ENTRY:
            puts("entering firststate");
            TEST_ASSERT_EQUAL_UINT8( qTrue, qSTimer_Set(&tmr, T2_5SEC) );
            qTrace_Message( (char*)e->TaskData );
            break;
        case QSM_SIGNAL_NONE:
            if (qSTimer_Expired(&tmr)){
                h->NextState = &statesecond;
            }
            break;
        case QSM_SIGNAL_EXIT:
            puts("exiting from firststate");
            break;
        default:
            break;
    }
    return qSM_STATUS_EXIT_SUCCESS;
}
/*============================================================================*/
qSM_Status_t statesecond_callback(qSM_Handler_t h){
    qEvent_t e = h->Data;
    static qSTimer_t tmr;

    switch( h->Signal ){
        case QSM_SIGNAL_ENTRY:
            puts("entering secondstate");    
            TEST_ASSERT_EQUAL_UINT8( qTrue, qSTimer_Set(&tmr, T2_5SEC) );
            TEST_MESSAGE( (char*)e->TaskData );
            break;
        case QSM_SIGNAL_NONE:
            if (qSTimer_Expired(&tmr)){
                TEST_MESSAGE("timer of 2.5s expired");
                h->NextState = &statefirst;
            }
            break;
        case QSM_SIGNAL_USER1:    
            h->NextState = &statethird;
            break;
        case QSM_SIGNAL_EXIT:
            puts("exiting from secondstate");
            break;
        default:
            break;
    }    
    return qSM_STATUS_EXIT_SUCCESS;
}
qSM_Status_t statethird_callback(qSM_Handler_t h){
    switch( h->Signal ){
        case QSM_SIGNAL_ENTRY:
            puts("entering thridstate");    
            break;
        case QSM_SIGNAL_NONE:
            break;
        case QSM_SIGNAL_USER1:
            h->NextState = &statefirst;
            break;       
        case QSM_SIGNAL_EXIT:
            puts("exiting from thridstate");
            break;
        default:
            break;
    }    
    return qSM_STATUS_EXIT_SUCCESS;
}
/*============================================================================*/
void Task1Callback(qEvent_t e){
    static qSTimer_t tmr = QSTIMER_INITIALIZER;
    TEST_MESSAGE( (char*)e->TaskData );
    TEST_MESSAGE( (char*)e->EventData );
    
    qTrace_Variable( e->StartDelay, UnsignedDecimal );

    #if ( Q_TASK_COUNT_CYCLES == 1 )
        qTrace_Variable( qTask_Get_Cycles(&Task1), UnsignedDecimal );
    #endif    
    if(e->FirstCall){
        TEST_MESSAGE("FirstCall");
    }
    if(e->FirstIteration){
        TEST_MESSAGE("FirstIteration");
    }
    if(e->LastIteration){
        TEST_MESSAGE("LastIteration");
    }
    
    if(e->Trigger == byNotificationSimple){
        TEST_MESSAGE("TASK1 BY SIMPLE NOTIFICATION");
    }

    if(e->Trigger == byNotificationQueued){
        TEST_MESSAGE("TASK1 BY QUEUED NOTIFICATION");
    }
    
    if(qSTimer_FreeRun(&tmr, T500MSEC)){
        TEST_MESSAGE("Timer expired");
    }         
}
/*============================================================================*/
void Task3Callback(qEvent_t e){
    int data = -1;
    TEST_MESSAGE( (char*)e->TaskData );
    TEST_MESSAGE( (char*)e->EventData );

    if(e->Trigger == byQueueReceiver){
        data = *((int*)e->EventData);
        TEST_MESSAGE("Queue event: byQueueReceiver");
        qDebug_Variable(data, Decimal);
    } 
    if(e->Trigger == byEventFlags){
        TEST_MESSAGE("event flag set");
        #if ( Q_TASK_EVENT_FLAGS == 1 )
        qTask_EventFlags_Modify( qTask_Self(), QEVENTFLAG_03, QEVENTFLAG_CLEAR );
        #endif
    }
}
/*============================================================================*/
void TaskSameCallback(qEvent_t e){
    TEST_MESSAGE( (char*)e->TaskData );
    TEST_MESSAGE( (char*)e->EventData );
}
/*============================================================================*/
void IdleTaskCallback(qEvent_t e){
    static qSTimer_t t = QSTIMER_INITIALIZER;
    static qSTimer_t xd = QSTIMER_INITIALIZER;

    static qSTimer_t EndSchedulingTimeout = QSTIMER_INITIALIZER;

    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_Update(&INPUTS) );

    if(e->FirstCall){
        TEST_MESSAGE("IDLE TASK FIRST CALL");
        TEST_ASSERT_EQUAL_UINT8( qTrue, qSTimer_Set(&t, T10SEC) );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qSTimer_Set(&EndSchedulingTimeout, T30SEC) );
    }

    if(qSTimer_Expired(&t)){
        PORTA = ~PORTA;
        TEST_MESSAGE("PORTA toggle");
        qSTimer_Disarm(&t);
    }

    if(qSTimer_FreeRun(&xd, T500MSEC)){
        qTrace_UnsignedDecimal( qSTimer_Elapsed(&t) );
        qTrace_UnsignedDecimal( qSTimer_Remaining(&t) );
        qTrace_Bool( qSTimer_Expired(&t) );
        /*
       qStateMachine_SendSignal( &statemachine, QSM_SIGNAL_USER1, qFalse );
        */
    }

    if( qSTimer_Expired(&EndSchedulingTimeout) ){
        #if (Q_ALLOW_SCHEDULER_RELEASE == 1)
        qOS_Scheduler_Release();
        #endif
    }
}
/*============================================================================*/
qCR_Semaphore_t cr_sem;
int sem_test = 0;
void blinktaskCallback(qEvent_t e){
    qCR_Position_t pos;
    if( e->FirstCall ){
        qCR_SemInit( &cr_sem, 1);
    }
    qCR_Begin{
        qCR_SemWait( &cr_sem );
        sem_test++;
        qCR_SemSignal( &cr_sem );

        qCR_TimedWaitUntil( sem_test > 5 , T1SEC);
        sem_test = 0;
        qCR_Delay(T2SEC);
        TEST_MESSAGE("hello  1");
        qCR_Delay(T2SEC);
        TEST_MESSAGE("hello 2 ");

        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Send( qTask_Self(), NULL ) );
        #if ( Q_TASK_EVENT_FLAGS == 1 )
            qTask_EventFlags_Modify( &Task3, QEVENTFLAG_03, QEVENTFLAG_SET );
        #endif

        TEST_ASSERT_EQUAL_UINT8( qFalse, qTask_HasPendingNotifications( &Task1 ) );

        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "notification 1") );

        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_HasPendingNotifications( &Task1 ) ); 
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "notification 2") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Send(&Task1, "notification 3") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Send(&Task1, "notification 4") );


        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "qin 3") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "qin 4") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "qin 5") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "qin 6") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "qin 7") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "qin 8") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "qin 9") );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Notification_Queue(&Task1, "qin 10") );
        TEST_ASSERT_EQUAL_UINT8( qFalse, qTask_Notification_Queue(&Task1, "qin 11") );

        TEST_MESSAGE("notification sended to task1 ");
        qCR_Yield;
        qCR_Restart;
        qCR_WaitUntil( 0 == pos );
        qCR_Delay( 0.0 );
        qCR_PositionReset(pos);

        /**/
    }qCR_End;
    (void)e;
}
/*============================================================================*/
void scheduler_Release(qEvent_t e){
    (void)e;
    TEST_MESSAGE("SCHEDULER RELEASED");
}
/*============================================================================*/
void test_OS_API( void ){
    #if ( Q_QUEUES == 1 )
    qQueue_t somequeue, sigqueue;
    int DataReceivedFromQueue;
    int x[]={10,20,30,40,50,60,70,80,90,100};
    int queuearea[8];
    #endif
    qSM_Signal_t fsmsigarea[5];
    
    TEST_MESSAGE( "Executing TEST OS_API.." ); 

    qTrace_Set_OutputFcn(putcharfcn); 
    qTrace_Variable( -3.1416, Float);
    qTrace_Variable( "dafdaa", Message );
    qTrace_Variable( sizeof(qTask_t) , UnsignedDecimal );
    qTrace_Variable( sizeof(qSM_t) , UnsignedDecimal );
    qTrace_Variable( sizeof(qSTimer_t) , UnsignedDecimal );
    qTrace_Variable( sizeof(qList_t) , UnsignedDecimal );
    qTrace_Variable( 1.0f/0.0f, Float );
    qTrace_Variable( -1.0f/0.0f, Float );
    qTrace_Variable( -0.0f/0.0f, Float );
    TEST_ASSERT_EQUAL_size_t( 10, qIOUtil_StrLen("hola q tal", Q_IOUTIL_MAX_STRLEN)  );

    TEST_MESSAGE( "qEdgeCheck_Module.." ); 
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_Setup(&INPUTS, QREG_32BIT, 10) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_Add_Node(&INPUTS, &button1, &PORTA, 0) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_Add_Node(&INPUTS, &button2, &PORTA, 1) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_Add_Node(&INPUTS, &sensor1, &PORTA, 2) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qEdgeCheck_Add_Node(&INPUTS, &sensor2, &PORTA, 3) );
    #if ( Q_QUEUES == 1 )
        TEST_MESSAGE( "qQueue_Module..." ); 
        TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_Setup( &somequeue, queuearea, sizeof(int), 8) );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_SendToBack( &somequeue, &x[0]) );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_SendToFront( &somequeue, &x[1]) );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_SendToBack( &somequeue, &x[2]) );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_SendToFront( &somequeue, &x[3]) );
        qTrace_Variable( qQueue_Count( &somequeue) , Decimal );
        TEST_ASSERT_EQUAL_size_t( 4, qQueue_Count( &somequeue ) );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_Receive( &somequeue, &DataReceivedFromQueue) );
        TEST_ASSERT_EQUAL_INT( x[3], DataReceivedFromQueue );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_Receive( &somequeue, &DataReceivedFromQueue) );
        TEST_ASSERT_EQUAL_INT( x[1], DataReceivedFromQueue );
        TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_Receive( &somequeue, &DataReceivedFromQueue) );
        TEST_ASSERT_EQUAL_INT( x[0], DataReceivedFromQueue );
        TEST_ASSERT_EQUAL_size_t( 1, qQueue_Count( &somequeue ) );
    #endif
    TEST_MESSAGE( "OS scheduling..." ); 
    #if  (Q_SETUP_TIME_CANONICAL != 1)
        qOS_Setup(GetTickCountMs, 0.001f, IdleTaskCallback ); /*  IdleTaskCallback  */ 
    #else
        qOS_Setup(GetTickCountMs, IdleTaskCallback ); /*  IdleTaskCallback  */
    #endif
    #if (Q_ALLOW_SCHEDULER_RELEASE == 1)
        qOS_Set_SchedulerReleaseCallback( scheduler_Release );
    #endif
    TEST_ASSERT_EQUAL_UINT8( qTrue, qOS_Add_Task(&blinktask, blinktaskCallback, qLowest_Priority, T10MSEC, qPeriodic, qEnabled, "blink") );   
    TEST_ASSERT_EQUAL_UINT8( qTrue, qOS_Add_Task(&Task1, Task1Callback, qHigh_Priority, T500MSEC, 5, qEnabled, "TASK1") );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qOS_Add_EventTask(&Task3, Task3Callback, qMedium_Priority, "TASK3") );
    #if ( Q_QUEUES == 1 )
    TEST_ASSERT_EQUAL_UINT8( qTrue, qTask_Attach_Queue(&Task3, &somequeue, qQueueMode_Receiver, qATTACH) );
    #endif
    TEST_ASSERT_EQUAL_UINT8( qTrue, qOS_Add_EventTask(&Task4, TaskSameCallback, qMedium_Priority, "TASK4") );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qOS_Add_EventTask(&Task5, TaskSameCallback, qMedium_Priority, "TASK5") );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qOS_Add_EventTask(&Task6, TaskSameCallback, qMedium_Priority, "TASK6") );


    TEST_ASSERT_EQUAL_UINT8( qTrue, qStateMachine_Setup( &statemachine, statetop_callback, &statefirst, NULL, NULL ) ) ;
    TEST_ASSERT_EQUAL_UINT8( qTrue, qStateMachine_StateSubscribe( &statemachine, &statefirst, NULL, statefirst_callback, NULL, qFalse ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qStateMachine_StateSubscribe( &statemachine, &statesecond, NULL, statesecond_callback, NULL, qFalse ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qStateMachine_StateSubscribe( &statemachine, &statethird, NULL, statethird_callback, NULL, qFalse ) );

    #if ( Q_QUEUES == 1 )
    TEST_ASSERT_EQUAL_UINT8( qTrue, qQueue_Setup( &sigqueue, fsmsigarea, sizeof(qSM_Signal_t), qFLM_ArraySize(fsmsigarea) ) );
    TEST_ASSERT_EQUAL_UINT8( qTrue, qStateMachine_InstallSignalQueue( &statemachine, &sigqueue ) );
    #endif
    TEST_ASSERT_EQUAL_UINT8( qTrue, qOS_Add_StateMachineTask(&SMTask, &statemachine, qHigh_Priority, T100MSEC, qEnabled, "smtask" ) ) ;
    qOS_Run();
}

int main(int argc, char** argv) {   
    (void)argc;
    (void)argv;
    
    /*Already tested externally (NOT INCLUDED HERE)
        - kernel internals
        - task internals
        - queue internals
        - STimers and related clock
        - BSBuffers
        - Critical
        - Trace
        - ioutils
        - atparser
        - list internals
        - memory management internals
        
    */
    UNITY_BEGIN();
        RUN_TEST( test_qList_API ); /*Some basic test of the qlist apis*/
        RUN_TEST( test_qMemoryManagement_API );  
        RUN_TEST( test_OS_API ); /*some scheduling test, including other redundant modules*/

    return UNITY_END();
}
