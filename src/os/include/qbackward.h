/*This file is part of the QuarkTS distribution.*/

/*
This file is used to define symbols required to mantain backward compatibility
*/
#ifdef  Q_ALLOW_BACKWARD_FROM_V5  /*to be used on future releases. Not enabled yet for testing*/

#define     qSchedulerSetup                             /*This function is deprecated used instead-> */     qOS_Setup                      
#define     qSchedulerSetIdleTask                       /*This function is deprecated used instead-> */     qOS_Set_IdleTask
#define     qSchedulerRelease                           /*This function is deprecated used instead-> */     qOS_Scheduler_Release
#define     qSchedulerSetReleaseCallback                /*This function is deprecated used instead-> */     qOS_Set_SchedulerReleaseCallback
#define     qSchedulerSpreadNotification                /*This function is deprecated used instead-> */     qOS_Notification_Spread
#define     qSchedulerAdd_Task                          /*This function is deprecated used instead-> */     qOS_Add_Task
#define     qSchedulerAdd_EventTask                     /*This function is deprecated used instead-> */     qOS_Add_EventTask
#define     qSchedulerAdd_StateMachineTask              /*This function is deprecated used instead-> */     qOS_Add_StateMachineTask  
#define     qScheduler_StateMachineTask_SignalConnect   /*This function is deprecated used instead-> */     qOS_StateMachineTask_SigCon
#define     qSchedulerAdd_ATParserTask                  /*This function is deprecated used instead-> */     qOS_Add_ATCLITask
#define     qSchedulerRemoveTask                        /*This function is deprecated used instead-> */     qOS_Remove_Task
#define     qSchedulerRun                               /*This function is deprecated used instead-> */     qOS_Run

#define     qTaskQueueNotification                      /*This function is deprecated used instead-> */     qTask_Notification_Queue
#define     qTaskGetState                               /*This function is deprecated used instead-> */     qTask_Get_State
#define     qTaskGetCycles                              /*This function is deprecated used instead-> */     qTask_Get_Cycles
#define     qTaskSetTime                                /*This function is deprecated used instead-> */     qTask_Set_Time
#define     qTaskSetIterations                          /*This function is deprecated used instead-> */     qTask_Set_Iterations    
#define     qTaskSetPriority                            /*This function is deprecated used instead-> */     qTask_Set_Priority    
#define     qTaskSetCallback                            /*This function is deprecated used instead-> */     qTask_Set_Callback
#define     qTaskSetState                               /*This function is deprecated used instead-> */     qTask_Set_State
#define     qTaskSendNotification                       /*This function is deprecated used instead-> */     qTask_Notification_Send
#define     qTaskSetData                                /*This function is deprecated used instead-> */     qTask_Set_Data
#define     qTaskClearTimeElapsed                       /*This function is deprecated used instead-> */     qTask_ClearTimeElapsed
#define     qTaskSuspend                                /*This function is deprecated used instead-> */     qTask_Suspend
#define     qTaskDisable                                /*This function is deprecated used instead-> */     qTask_Disable
#define     qTaskResume                                 /*This function is deprecated used instead-> */     qTask_Resume    
#define     qTaskEnable                                 /*This function is deprecated used instead-> */     qTask_Enable
#define     qTaskSelf                                   /*This function is deprecated used instead-> */     qTask_Self
#define     qTaskASleep                                 /*This function is deprecated used instead-> */     qTask_ASleep
#define     qTaskAwake                                  /*This function is deprecated used instead-> */     qTask_Awake
#define     qTaskIsEnabled                              /*This function is deprecated used instead-> */     qTask_IsEnabled
#define     qTaskAttachQueue                            /*This function is deprecated used instead-> */     qTask_Attach_Queue    
#define     qTaskAttachStateMachine                     /*This function is deprecated used instead-> */     qTask_Attach_StateMachine
#define     qTaskModifyEventFlags                       /*This function is deprecated used instead-> */     qTask_EventFlags_Modify
#define     qTaskReadEventFlags                         /*This function is deprecated used instead-> */     qTask_EventFlags_Read
#define     qTaskCheckEventFlags                        /*This function is deprecated used instead-> */     qTask_EventFlags_Check

#define     qSTimerReload                               /*This function is deprecated used instead-> */     qSTimer_Reload
#define     qSTimerSet                                  /*This function is deprecated used instead-> */     qSTimer_Set    
#define     qSTimerExpired                              /*This function is deprecated used instead-> */     qSTimer_Expired
#define     qSTimerFreeRun                              /*This function is deprecated used instead-> */     qSTimer_FreeRun
#define     qSTimerElapsed                              /*This function is deprecated used instead-> */     qSTimer_Elapsed
#define     qSTimerRemaining                            /*This function is deprecated used instead-> */     qSTimer_Remaining
#define     qSTimerDisarm                               /*This function is deprecated used instead-> */     qSTimer_Disarm
#define     qSTimerStatus                               /*This function is deprecated used instead-> */     qSTimer_Status

#define     qQueueSendToBack                            /*This function is deprecated used instead-> */     qQueue_SendToBack
#define     qQueueSend                                  /*This function is deprecated used instead-> */     qQueue_Send    
#define     qQueueSendToFront                           /*This function is deprecated used instead-> */     qQueue_SendToFront
#define     qQueueCreate                                /*This function is deprecated used instead-> */     qQueue_Setup
#define     qQueueReset                                 /*This function is deprecated used instead-> */     qQueue_Reset
#define     qQueueIsEmpty                               /*This function is deprecated used instead-> */     qQueue_IsEmpty
#define     qQueueCount                                 /*This function is deprecated used instead-> */     qQueue_Count
#define     qQueueIsFull                                /*This function is deprecated used instead-> */     qQueue_IsFull    
#define     qQueuePeek                                  /*This function is deprecated used instead-> */     qQueue_Peek
#define     qQueueRemoveFront                           /*This function is deprecated used instead-> */     qQueue_RemoveFront
#define     qQueueReceive                               /*This function is deprecated used instead-> */     qQueue_Receive
#define     qQueueGenericSend                           /*This function is deprecated used instead-> */     qQueue_SendGeneric

#define     qATResponse_t                               /*This type is deprecated used instead-> */         qATCLI_Response_t
#define     qATParser_PreCmd_t                          /*This type is deprecated used instead-> */         qATCLI_PreCmd_t
#define     qATParser_t                                 /*This type is deprecated used instead-> */         qATCLI_t    
#define     qATCommandCallback_t                        /*This type is deprecated used instead-> */         qATCLI_CommandCallback_t
#define     qATCommand_t                                /*This type is deprecated used instead-> */         qATCLI_Command_t
#define     qATParser_Setup                             /*This function is deprecated used instead-> */     qATCLI_Setup
#define     qATParser_CmdSubscribe                      /*This function is deprecated used instead-> */     qATCLI_CmdSubscribe
#define     qATParser_CmdIterate                        /*This function is deprecated used instead-> */     qATCLI_CmdIterate                
#define     qATParser_ISRHandler                        /*This function is deprecated used instead-> */     qATCLI_ISRHandler
#define     qATParser_ISRHandlerBlock                   /*This function is deprecated used instead-> */     qATCLI_ISRHandlerBlock
#define     qATParser_Raise                             /*This function is deprecated used instead-> */     qATCLI_Raise
#define     qATParser_Exec                              /*This function is deprecated used instead-> */     qATCLI_Exec
#define     qATCommandParser_FlushInput                 /*This function is deprecated used instead-> */     qATCLI_Input_Flush
#define     qATParser_Run                               /*This function is deprecated used instead-> */     qATCLI_Run
#define     qATParser_GetArgString                      /*This function is deprecated used instead-> */     qATCLI_GetArgString
#define     qATParser_GetArgPtr                         /*This function is deprecated used instead-> */     qATCLI_GetArgPtr
#define     qATParser_GetArgInt                         /*This function is deprecated used instead-> */     qATCLI_GetArgInt
#define     qATParser_GetArgFlt                         /*This function is deprecated used instead-> */     qATCLI_GetArgFlt
#define     qATParser_GetArgHex                         /*This function is deprecated used instead-> */     qATCLI_GetArgHex

#define     qResponseHandler_t                          /*This type is deprecated used instead-> */         qResponse_t
#define     qResponseInitialize                         /*This function is deprecated used instead-> */     qResponse_Setup
#define     qResponseReset                              /*This function is deprecated used instead-> */     qResponse_Reset
#define     qResponseReceived                           /*This function is deprecated used instead-> */     qResponse_Received
#define     qResponseReceivedWithTimeout                /*This function is deprecated used instead-> */     qResponse_ReceivedWithTimeout
#define     qResponseISRHandler                         /*This function is deprecated used instead-> */     qResponse_ISRHandler
    
#define     qSMData_t                                   /*This type is deprecated used instead-> */         qSM_Handler_t
#define     qBSBuffer_Init                              /*This function is deprecated used instead-> */     qBSBuffer_Setup
#define     qEdgeCheck_Initialize                       /*This function is deprecated used instead-> */     qEdgeCheck_Setup
#define     qIONode_t                                   /*This type is deprecated used instead-> */         qEdgeCheck_IONode_t
#define     qIOEdgeCheck_t                              /*This type is deprecated used instead-> */         qEdgeCheck_t
#define     qEdgeCheck_InsertNode                       /*This function is deprecated used instead-> */     qEdgeCheck_Add_Node
#define     qEdgeCheck_GetNodeStatus                    /*This function is deprecated used instead-> */     qEdgeCheck_Get_NodeStatus

#define     qClock2Time                                 /*This function is deprecated used instead-> */     qClock_Convert2Time
#define     qTime2Clock                                 /*This function is deprecated used instead-> */     qClock_Convert2Clock

#define     qMemoryPool_Init                            /*This function is deprecated used instead-> */     qMemMang_Pool_Setup      
#define     qMemoryPool_Select                          /*This function is deprecated used instead-> */     qMemMang_Pool_Select
#define     qHeapGetFreeSize                            /*This function is deprecated used instead-> */     qMemMang_Get_FreeSize


#define     qSwapBytes                                  /*This function is deprecated used instead-> */     qIOUtil_SwapBytes
#define     qCheckEndianness                            /*This function is deprecated used instead-> */     qIOUtil_CheckEndianness
#define     qOutputString                               /*This function is deprecated used instead-> */     qIOUtil_OutputString
#define     qPrintXData                                 /*This function is deprecated used instead-> */     qIOUtil_PrintXData
#define     qOutputRaw                                  /*This function is deprecated used instead-> */     qIOUtil_OutputRaw
#define     qInputRaw                                   /*This function is deprecated used instead-> */     qIOUtil_InputRaw
#define     qPrintString                                /*This function is deprecated used instead-> */     qIOUtil_PrintString
#define     qPrintRaw                                   /*This function is deprecated used instead-> */     qIOUtil_PrintRaw
#define     qU32toX                                     /*This function is deprecated used instead-> */     qIOUtil_U32toX
#define     qXtoU32                                     /*This function is deprecated used instead-> */     qIOUtil_XtoU32
#define     qAtoF                                       /*This function is deprecated used instead-> */     qIOUtil_AtoF
#define     qFtoA                                       /*This function is deprecated used instead-> */     qIOUtil_FtoA
#define     qAtoI                                       /*This function is deprecated used instead-> */     qIOUtil_AtoI
#define     qUtoA                                       /*This function is deprecated used instead-> */     qIOUtil_UtoA
#define     qItoA                                       /*This function is deprecated used instead-> */     qIOUtil_ItoA
#define     qBtoA                                       /*This function is deprecated used instead-> */     qIOUtil_BtoA
#define     qQBtoA                                      /*This function is deprecated used instead-> */     qIOUtil_QBtoA
#define     qIsInf                                      /*This function is deprecated used instead-> */     qIOUtil_IsInf
#define     qIsNan                                      /*This function is deprecated used instead-> */     qIOUtil_IsNan

#define     qSetDebugFcn                                /*This function is deprecated used instead-> */     qTrace_Set_OutputFcn
#define     qDebugCaller                                /*This function is deprecated used instead-> */     qDebug_Caller

#define     qDebugMessage                               /*This function is deprecated used instead-> */     qDebug_Message
#define     qDebugString                                /*This function is deprecated used instead-> */     qDebug_String
#define     qDebugBool                                  /*This function is deprecated used instead-> */     qDebug_Bool
#define     qDebugqBool                                 /*This function is deprecated used instead-> */     qDebug_qBool
#define     qDebugBinary                                /*This function is deprecated used instead-> */     qDebug_Binary    
#define     qDebugOctal                                 /*This function is deprecated used instead-> */     qDebug_Octal
#define     qDebugHexadecimal                           /*This function is deprecated used instead-> */     qDebug_Hexadecimal
#define     qDebugDecimal                               /*This function is deprecated used instead-> */     qDebug_Decimal
#define     qDebugFloat                                 /*This function is deprecated used instead-> */     qDebug_Float
#define     qDebugFloatPrec                             /*This function is deprecated used instead-> */     qDebug_FloatPrec
#define     qDebugUnsignedBinary                        /*This function is deprecated used instead-> */     qDebug_UnsignedBinary
#define     qDebugUnsignedOctal                         /*This function is deprecated used instead-> */     qDebug_UnsignedOctal
#define     qDebugUnsignedHexadecimal                   /*This function is deprecated used instead-> */     qDebug_UnsignedHexadecimal
#define     qDebugUnsignedDecimal                       /*This function is deprecated used instead-> */     qDebug_UnsignedDecimal

#define     qTraceMessage                               /*This function is deprecated used instead-> */     qTrace_Message
#define     qTraceString                                /*This function is deprecated used instead-> */     qTrace_String
#define     qTraceBool                                  /*This function is deprecated used instead-> */     qTrace_Bool
#define     qTraceqBool                                 /*This function is deprecated used instead-> */     qTrace_qBool
#define     qTraceBinary                                /*This function is deprecated used instead-> */     qTrace_Binary    
#define     qTraceOctal                                 /*This function is deprecated used instead-> */     qTrace_Octal
#define     qTraceHexadecimal                           /*This function is deprecated used instead-> */     qTrace_Hexadecimal
#define     qTraceDecimal                               /*This function is deprecated used instead-> */     qTrace_Decimal
#define     qTraceFloat                                 /*This function is deprecated used instead-> */     qTrace_Float
#define     qTraceFloatPrec                             /*This function is deprecated used instead-> */     qTrace_FloatPrec
#define     qTraceUnsignedBinary                        /*This function is deprecated used instead-> */     qTrace_UnsignedBinary
#define     qTraceUnsignedOctal                         /*This function is deprecated used instead-> */     qTrace_UnsignedOctal
#define     qTraceUnsignedHexadecimal                   /*This function is deprecated used instead-> */     qTrace_UnsignedHexadecimal
#define     qTraceUnsignedDecimal                       /*This function is deprecated used instead-> */     qTrace_UnsignedDecimal

#define     qTraceMemory                                /*This function is deprecated used instead-> */     qTrace_Memory
#define     qTraceMem                                   /*This function is deprecated used instead-> */     qTrace_Mem
#define     qDebugMemory                                /*This function is deprecated used instead-> */     qDebug_Memory
#define     qDebugMem                                   /*This function is deprecated used instead-> */     qDebug_Mem

#define     qTraceVariable                              /*This function is deprecated used instead-> */     qTrace_Variable
#define     qTraceVar                                   /*This function is deprecated used instead-> */     qTrace_Var
#define     qDebugVariable                              /*This function is deprecated used instead-> */     qDebug_Variable
#define     qDebugVar                                   /*This function is deprecated used instead-> */     qDebug_Var


#endif
