/*This file is part of the QuarkTS distribution.*/

/*
This file is used to define symbols required to mantain backward compatibility
*/

#ifdef  Q_NEW_NAME_CONSISTENCY  /*to be used on future releases*/

    #define     qSchedulerSetup                             qOS_Setup                           
    #define     qSchedulerSetIdleTask                       qOS_Set_IdleTask
    #define     qSchedulerRelease                           qOS_Scheduler_Release
    #define     qSchedulerSetReleaseCallback                qOS_Set_SchedulerReleaseCallback
    #define     qSchedulerSpreadNotification                qOS_Notification_Spread
    #define     qSchedulerAdd_Task                          qOS_Add_Task
    #define     qSchedulerAdd_EventTask                     qOS_Add_EventTask
    #define     qSchedulerAdd_StateMachineTask              qOS_Add_StateMachineTask  
    #define     qScheduler_StateMachineTask_SignalConnect   qOS_StateMachineTask_SigCon
    #define     qSchedulerAdd_ATParserTask                  qOS_Add_ATCLITask
    #define     qSchedulerRemoveTask                        qOS_Remove_Task
    #define     qSchedulerRun                               qOS_Run
    #define     qScheduler_GetTaskGlobalState               qOS_Get_TaskGlobalState

    #define     qTaskSendNotification                       qTask_Notification_Send
    #define     qTaskQueueNotification                      qTask_Notification_Queue
    #define     qTaskGetState                               qTask_Get_State
    #define     qTaskGetCycles                              qTask_Get_Cycles
    #define     qTaskSetTime                                qTask_Set_Time
    #define     qTaskSetIterations                          qTask_Set_Iterations    
    #define     qTaskSetPriority                            qTask_Set_Priority    
    #define     qTaskSetCallback                            qTask_Set_Callback
    #define     qTaskSetState                               qTask_Set_State
    #define     qTaskSetData                                qTask_Set_Data
    #define     qTaskClearTimeElapsed                       qTask_ClearTimeElapsed
    #define     qTaskSuspend                                qTask_Suspend
    #define     qTaskDisable                                qTask_Disable
    #define     qTaskResume                                 qTask_Resume    
    #define     qTaskEnable                                 qTask_Enable
    #define     qTaskSelf                                   qTask_Self
    #define     qTaskASleep                                 qTask_ASleep
    #define     qTaskAwake                                  qTask_Awake
    #define     qTaskIsEnabled                              qTask_IsEnabled
    #define     qTaskAttachQueue                            qTask_Attach_Queue    
    #define     qTaskAttachStateMachine                     qTask_Attach_StateMachine
    #define     qTaskModifyEventFlags                       qTask_EventFlags_Modify
    #define     qTaskReadEventFlags                         qTask_EventFlags_Read
    #define     qTaskCheckEventFlags                        qTask_EventFlags_Check


    #define     qSTimerReload                               qSTimer_Reload
    #define     qSTimerSet                                  qSTimer_Set    
    #define     qSTimerExpired                              qSTimer_Expired
    #define     qSTimerFreeRun                              qSTimer_FreeRun
    #define     qSTimerElapsed                              qSTimer_Elapsed
    #define     qSTimerRemaining                            qSTimer_Remaining
    #define     qSTimerDisarm                               qSTimer_Disarm
    #define     qSTimerStatus                               qSTimer_Status


    #define     qQueueSendToBack                            qQueue_SendToBack
    #define     qQueueSend                                  qQueue_Send    
    #define     qQueueSendToFront                           qQueue_SendToFront
    #define     qQueueCreate                                qQueue_Init
    #define     qQueueReset                                 qQueue_Reset
    #define     qQueueIsEmpty                               qQueue_IsEmpty
    #define     qQueueCount                                 qQueue_Count
    #define     qQueueIsFull                                qQueue_IsFull    
    #define     qQueuePeek                                  qQueue_Peek
    #define     qQueueRemoveFront                           qQueue_RemoveFront
    #define     qQueueReceive                               qQueue_Receive
    #define     qQueueGenericSend                           qQueue_GenericSend

    #define     qATResponse_t                               qATCLI_Response_t
    #define     qATParserInput_t                            qATCLI_Input_t
    #define     qATCommandType_t                            qATCLI_CommandType_t
    #define     qATParser_PreCmd_t                          qATCLI_PreCmd_t
    #define     qATParser_t                                 qATCLI_t    
    #define     qATParserOptions_t                          qATCLI_Options_t
    #define     qATCommand_t                                qATCLI_Command_t
    #define     qATParser_Setup                             qATCLI_Setup
    #define     qATParser_CmdSubscribe                      qATCLI_CmdSubscribe
    #define     qATParser_CmdIterate                        qATCLI_CmdIterate                
    #define     qATParser_ISRHandler                        qATCLI_ISRHandler
    #define     qATParser_ISRHandlerBlock                   qATCLI_ISRHandlerBlock
    #define     qATParser_Raise                             qATCLI_Raise
    #define     qATParser_Exec                              qATCLI_Exec
    #define     qATCommandParser_FlushInput                 qATCLI_FlushInput
    #define     qATParser_Run                               qATCLI_Run
    #define     qATParser_GetArgString                      qATCLI_GetArgString
    #define     qATParser_GetArgPtr                         qATCLI_GetArgPtr
    #define     qATParser_GetArgInt                         qATCLI_GetArgInt
    #define     qATParser_GetArgFlt                         qATCLI_GetArgFlt
    #define     qATParser_GetArgHex                         qATCLI_GetArgHex

    #define     qResponseInitialize                         qResponse_Initialize
    #define     qResponseReset                              qResponse_Reset
    #define     qResponseReceived                           qResponse_Received
    #define     qResponseReceivedWithTimeout                qResponse_ReceivedWithTimeout
    #define     qResponseISRHandler                         qResponse_ISRHandler
    
#endif