	.file	"QuarkTS.c"
	.text
	.p2align 4,,15
	.def	_qScheduler_PriorizedInsert;	.scl	3;	.type	32;	.endef
	.seh_proc	_qScheduler_PriorizedInsert
_qScheduler_PriorizedInsert:
	.seh_endprologue
	movq	(%rcx), %rax
	testq	%rax, %rax
	je	.L2
	movzbl	40(%rdx), %r9d
	movzbl	40(%rax), %r8d
	cmpb	%r8b, %r9b
	ja	.L2
	movq	(%rax), %rcx
	testq	%rcx, %rcx
	je	.L3
	movzbl	40(%rdx), %ecx
	movq	(%rax), %r8
	movzbl	40(%r8), %r8d
	cmpb	%cl, %r8b
	jnb	.L4
	jmp	.L3
	.p2align 4,,10
.L18:
	movzbl	40(%rdx), %r8d
	movq	(%rax), %rcx
	movzbl	40(%rcx), %ecx
	cmpb	%cl, %r8b
	ja	.L3
.L4:
	movq	(%rax), %rax
	movq	(%rax), %rcx
	testq	%rcx, %rcx
	jne	.L18
.L3:
	movq	(%rax), %rcx
	movq	%rcx, (%rdx)
	movq	%rdx, (%rax)
	ret
	.p2align 4,,10
.L2:
	movq	%rax, (%rdx)
	movq	%rdx, (%rcx)
	ret
	.seh_endproc
	.p2align 4,,15
	.def	__q_revuta.part.5;	.scl	3;	.type	32;	.endef
	.seh_proc	__q_revuta.part.5
__q_revuta.part.5:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testl	%ecx, %ecx
	movl	%ecx, %eax
	movq	%rdx, %r10
	je	.L26
	movzbl	%r8b, %r8d
	xorl	%r9d, %r9d
	jmp	.L23
	.p2align 4,,10
.L27:
	movzbl	%r11b, %r9d
.L23:
	xorl	%edx, %edx
	divl	%r8d
	leal	48(%rdx), %r11d
	leal	55(%rdx), %ecx
	cmpl	$10, %edx
	cmovb	%r11d, %ecx
	testl	%eax, %eax
	leal	1(%r9), %r11d
	movb	%cl, (%r10,%r9)
	jne	.L27
	movzbl	%r11b, %r8d
	subw	$1, %r8w
	je	.L19
.L20:
	xorl	%r9d, %r9d
	.p2align 4,,10
.L25:
	movzwl	%r9w, %ecx
	movzwl	%r8w, %edx
	addl	$1, %r9d
	addq	%r10, %rcx
	addq	%r10, %rdx
	subl	$1, %r8d
	movzbl	(%rcx), %eax
	movzbl	(%rdx), %ebx
	cmpw	%r8w, %r9w
	movb	%bl, (%rcx)
	movb	%al, (%rdx)
	jb	.L25
.L19:
	movl	%r11d, %eax
	popq	%rbx
	ret
	.p2align 4,,10
.L26:
	xorl	%r11d, %r11d
	movl	$-1, %r8d
	jmp	.L20
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSelf
	.def	qTaskSelf;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSelf
qTaskSelf:
	.seh_endprologue
	movq	112+QUARKTS(%rip), %rax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskIsEnabled
	.def	qTaskIsEnabled;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskIsEnabled
qTaskIsEnabled:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L33
	movzbl	58(%rcx), %eax
.L33:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerSetIdleTask
	.def	qSchedulerSetIdleTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetIdleTask
qSchedulerSetIdleTask:
	.seh_endprologue
	movq	%rcx, QUARKTS(%rip)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerRelease
	.def	qSchedulerRelease;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRelease
qSchedulerRelease:
	.seh_endprologue
	movb	$1, 82+QUARKTS(%rip)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerSetReleaseCallback
	.def	qSchedulerSetReleaseCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetReleaseCallback
qSchedulerSetReleaseCallback:
	.seh_endprologue
	movq	%rcx, 8+QUARKTS(%rip)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskGetCycles
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskGetCycles
qTaskGetCycles:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L40
	movl	36(%rcx), %eax
.L40:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSendEvent
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSendEvent
qTaskSendEvent:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L44
	movb	$1, 57(%rcx)
	movq	%rdx, 16(%rcx)
.L44:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetTime
	.def	qTaskSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetTime
qTaskSetTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L49
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 24(%rcx)
.L49:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetIterations
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetIterations
qTaskSetIterations:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L54
	movl	%edx, %eax
	negl	%eax
	cmpw	$-32768, %dx
	cmovne	%eax, %edx
	movw	%dx, 32(%rcx)
.L54:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetPriority
	.def	qTaskSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetPriority
qTaskSetPriority:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L61
	movb	$0, 80+QUARKTS(%rip)
	movb	%dl, 40(%rcx)
.L61:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetCallback
	.def	qTaskSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetCallback
qTaskSetCallback:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L66
	movq	%rdx, 48(%rcx)
.L66:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetState
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetState
qTaskSetState:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L71
	testb	%dl, %dl
	je	.L73
	movzbl	58(%rcx), %eax
	testb	%al, %al
	jne	.L71
.L73:
	movb	%dl, 58(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L71:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetData
	.def	qTaskSetData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetData
qTaskSetData:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L77
	movq	%rdx, 8(%rcx)
.L77:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskClearTimeElapsed
	.def	qTaskClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskClearTimeElapsed
qTaskClearTimeElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L82
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L82:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskQueueEvent
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskQueueEvent
qTaskQueueEvent:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L87
	movswl	98+QUARKTS(%rip), %r9d
	movzbl	96+QUARKTS(%rip), %r8d
	subl	$1, %r8d
	cmpl	%r8d, %r9d
	jge	.L87
	movq	88+QUARKTS(%rip), %r8
	movzwl	98+QUARKTS(%rip), %eax
	addl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movswq	%ax, %rax
	salq	$4, %rax
	addq	%r8, %rax
	movq	%rcx, (%rax)
	movq	%rdx, 8(%rax)
	movl	$1, %eax
.L87:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerSetInterruptsED
	.def	qSchedulerSetInterruptsED;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetInterruptsED
qSchedulerSetInterruptsED:
	.seh_endprologue
	movq	%rcx, 72+QUARKTS(%rip)
	movq	%rdx, 64+QUARKTS(%rip)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	_qInitScheduler
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qInitScheduler
_qInitScheduler:
	.seh_endprologue
	movq	$0, 56+QUARKTS(%rip)
	movss	%xmm0, 48+QUARKTS(%rip)
	movq	%rdx, QUARKTS(%rip)
	movq	$0, 8+QUARKTS(%rip)
	movq	%r8, 88+QUARKTS(%rip)
	movb	%r9b, 96+QUARKTS(%rip)
	movzbl	96+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L94
	xorl	%eax, %eax
	.p2align 4,,10
.L95:
	movq	88+QUARKTS(%rip), %rcx
	movzbl	%al, %edx
	addl	$1, %eax
	salq	$4, %rdx
	addq	%rcx, %rdx
	movq	$0, (%rdx)
	movzbl	96+QUARKTS(%rip), %edx
	cmpb	%al, %dl
	ja	.L95
.L94:
	movl	$-1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	$0, 104+QUARKTS(%rip)
	movb	$0, 80+QUARKTS(%rip)
	movb	$0, 82+QUARKTS(%rip)
	movb	$0, 83+QUARKTS(%rip)
	movq	$0, 72+QUARKTS(%rip)
	movq	$0, 64+QUARKTS(%rip)
	movq	$0, 112+QUARKTS(%rip)
	movl	$0, _qSysTick_Epochs_(%rip)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerRemoveTask
	.def	qSchedulerRemoveTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRemoveTask
qSchedulerRemoveTask:
	.seh_endprologue
	movq	56+QUARKTS(%rip), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L100
	cmpq	%rcx, %rdx
	je	.L102
	movq	(%rdx), %r8
	testq	%r8, %r8
	jne	.L104
	jmp	.L100
	.p2align 4,,10
.L111:
	movq	(%rax), %r8
	movq	%rax, %rdx
	testq	%r8, %r8
	je	.L110
.L104:
	movq	(%rdx), %rax
	cmpq	%rax, %rcx
	jne	.L111
	movq	(%rcx), %rax
	movq	%rax, (%rdx)
.L105:
	movq	$0, (%rcx)
	movl	$1, %eax
.L100:
	ret
	.p2align 4,,10
.L110:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L102:
	movq	(%rcx), %rax
	movq	%rax, 56+QUARKTS(%rip)
	jmp	.L105
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerAddxTask
	.def	qSchedulerAddxTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddxTask
qSchedulerAddxTask:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	xorl	%eax, %eax
	movl	96(%rsp), %r10d
	movl	104(%rsp), %r11d
	testq	%rcx, %rcx
	movq	%rcx, %r9
	je	.L112
	movss	.LC0(%rip), %xmm0
	mulss	%xmm3, %xmm0
	movss	48+QUARKTS(%rip), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L120
	pxor	%xmm0, %xmm0
	movl	$1, %ebx
	ucomiss	%xmm0, %xmm3
	setp	%cl
	cmovne	%ebx, %ecx
	testb	%cl, %cl
	jne	.L112
.L120:
	xorl	%eax, %eax
	testq	%rdx, %rdx
	movl	%r8d, 44(%rsp)
	movq	%rdx, 32(%rsp)
	je	.L112
	movq	%r9, %rcx
	call	qSchedulerRemoveTask
	movq	32(%rsp), %rdx
	movl	44(%rsp), %r8d
	leaq	56+QUARKTS(%rip), %rcx
	movq	%rdx, 48(%r9)
	movq	%r9, %rdx
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm3
	cvttss2siq	%xmm3, %rax
	movl	%eax, 24(%r9)
	movq	112(%rsp), %rax
	movq	%rax, 8(%r9)
	movl	%r10d, %eax
	movb	%r8b, 40(%r9)
	negl	%eax
	cmpw	$-32768, %r10w
	cmovne	%eax, %r10d
	testb	%r11b, %r11b
	setne	%al
	movw	%r10w, 32(%r9)
	movb	$0, 57(%r9)
	movb	$0, 56(%r9)
	movb	$0, 59(%r9)
	movb	$0, 61(%r9)
	movb	$0, 61(%r9)
	movb	$0, 62(%r9)
	movb	%al, 58(%r9)
	movq	$0, (%r9)
	movl	$0, 36(%r9)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%r9)
	movq	$0, 64(%r9)
	movq	$0, 72(%r9)
	movb	$3, 80(%r9)
	call	_qScheduler_PriorizedInsert
	movl	$1, %eax
.L112:
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerAddSMTask
	.def	qSchedulerAddSMTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddSMTask
qSchedulerAddSMTask:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$80, %rsp
	.seh_stackalloc	80
	.seh_endprologue
	movl	168(%rsp), %eax
	testq	%r9, %r9
	movq	%rcx, %rbx
	je	.L129
	cmpq	$0, 128(%rsp)
	je	.L129
	movq	176(%rsp), %rcx
	movzbl	%al, %eax
	movzbl	%dl, %r8d
	movaps	%xmm2, %xmm3
	movl	%eax, 40(%rsp)
	movl	$-32768, 32(%rsp)
	movl	$1, %edx
	movq	%r9, 72(%rsp)
	movq	%rcx, 48(%rsp)
	movq	%rbx, %rcx
	call	qSchedulerAddxTask
	testb	%al, %al
	movq	72(%rsp), %r9
	jne	.L133
.L129:
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L133:
	movq	128(%rsp), %rax
	movq	$0, 8(%r9)
	movb	$0, 28(%r9)
	movl	$-32768, 24(%r9)
	movq	$0, 16(%r9)
	movq	%rax, (%r9)
	movq	152(%rsp), %rax
	movq	%rax, 40(%r9)
	movq	144(%rsp), %rax
	movq	%rax, 48(%r9)
	movq	160(%rsp), %rax
	movq	%rax, 56(%r9)
	movq	136(%rsp), %rax
	movq	%rax, 64(%r9)
	movl	$1, %eax
	movq	%r9, 72(%rbx)
	addq	$80, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerAddeTask
	.def	qSchedulerAddeTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddeTask
qSchedulerAddeTask:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rdx, %r11
	movl	%r8d, 44(%rsp)
	je	.L134
	testq	%rdx, %rdx
	movss	48+QUARKTS(%rip), %xmm0
	je	.L134
	call	qSchedulerRemoveTask
	pxor	%xmm0, %xmm0
	movq	%r11, 48(%rcx)
	movss	48+QUARKTS(%rip), %xmm1
	movl	44(%rsp), %r8d
	movq	%rcx, %rdx
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, 24(%rcx)
	movl	$-1, %eax
	movq	%r9, 8(%rcx)
	movb	%r8b, 40(%rcx)
	movw	%ax, 32(%rcx)
	movb	$0, 57(%rcx)
	movb	$0, 56(%rcx)
	movb	$0, 59(%rcx)
	movb	$0, 61(%rcx)
	movb	$0, 61(%rcx)
	movb	$0, 62(%rcx)
	movb	$0, 58(%rcx)
	movq	$0, (%rcx)
	movl	$0, 36(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
	movq	$0, 64(%rcx)
	movq	$0, 72(%rcx)
	movb	$3, 80(%rcx)
	leaq	56+QUARKTS(%rip), %rcx
	call	_qScheduler_PriorizedInsert
	movl	$1, %eax
.L134:
	addq	$56, %rsp
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskLinkRBuffer
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskLinkRBuffer
qTaskLinkRBuffer:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L144
	testq	%rcx, %rcx
	je	.L144
	leal	-3(%r8), %r10d
	xorl	%eax, %eax
	cmpl	$3, %r10d
	ja	.L140
	cmpq	$0, (%rdx)
	je	.L140
	cmpl	$5, %r8d
	movl	%r9d, %eax
	je	.L142
	testb	%r9b, %r9b
	setne	%al
.L142:
	movl	%r8d, %r8d
	testb	%r9b, %r9b
	movb	%al, 56(%rcx,%r8)
	movl	$0, %eax
	cmove	%rax, %rdx
	movl	$1, %eax
	movq	%rdx, 64(%rcx)
.L140:
	ret
	.p2align 4,,10
.L144:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerSysTick
	.def	qSchedulerSysTick;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSysTick
qSchedulerSysTick:
	.seh_endprologue
	movl	_qSysTick_Epochs_(%rip), %eax
	addl	$1, %eax
	movl	%eax, _qSysTick_Epochs_(%rip)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qStateMachine_Init
	.def	qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Init
qStateMachine_Init:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L152
	testq	%rdx, %rdx
	je	.L152
	movq	40(%rsp), %rax
	movq	%rdx, (%rcx)
	movq	$0, 8(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	movq	%r9, 40(%rcx)
	movq	%rax, 56(%rcx)
	movq	48(%rsp), %rax
	movq	%r8, 48(%rcx)
	movq	$0, 16(%rcx)
	movq	%rax, 64(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L152:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qStateMachine_Run
	.def	qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Run
qStateMachine_Run:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L153
	movq	64(%rcx), %rax
	movq	%rdx, 32(%rcx)
	testq	%rax, %rax
	je	.L156
	call	*%rax
.L156:
	movq	(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L157
	movq	16(%rbx), %rax
	cmpq	%rax, %rsi
	setne	28(%rbx)
	je	.L158
	movq	%rax, 8(%rbx)
.L158:
	movq	%rbx, %rcx
	call	*%rsi
	cmpl	$-32768, %eax
	movl	%eax, 24(%rbx)
	movq	%rsi, 16(%rbx)
	je	.L160
	cmpl	$-32767, %eax
	je	.L161
	movq	56(%rbx), %rax
	testq	%rax, %rax
	je	.L153
.L179:
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L160:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	jne	.L179
.L153:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L157:
	movl	$-32767, 24(%rbx)
.L161:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L153
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.seh_endproc
	.p2align 4,,15
	.def	_qScheduler_Dispatch;	.scl	3;	.type	32;	.endef
	.seh_proc	_qScheduler_Dispatch
_qScheduler_Dispatch:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	cmpl	$9, %edx
	movq	%rcx, %rbx
	movl	%edx, %esi
	ja	.L181
	movl	%edx, %eax
	leaq	.L183(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L183:
	.long	.L181-.L183
	.long	.L182-.L183
	.long	.L184-.L183
	.long	.L185-.L183
	.long	.L186-.L183
	.long	.L187-.L183
	.long	.L187-.L183
	.long	.L187-.L183
	.long	.L181-.L183
	.long	.L188-.L183
	.text
	.p2align 4,,10
.L182:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L189
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L215
.L189:
	movb	$0, 41+QUARKTS(%rip)
	movzwl	32(%rbx), %eax
.L197:
	movw	%ax, 32(%rbx)
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L191
	movzwl	32(%rbx), %eax
	subl	$1, %eax
	movw	%ax, 32(%rbx)
.L191:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	sete	%dl
	movb	%dl, 42+QUARKTS(%rip)
	jne	.L181
	movb	$0, 58(%rbx)
	.p2align 4,,10
.L181:
	movb	$2, 80(%rbx)
	movl	%esi, 16+QUARKTS(%rip)
	movzbl	56(%rbx), %eax
	testb	%al, %al
	sete	%al
	movb	%al, 40+QUARKTS(%rip)
	movq	8(%rbx), %rax
	movq	%rax, 24+QUARKTS(%rip)
	movq	%rbx, 112+QUARKTS(%rip)
	movq	72(%rbx), %rax
	testq	%rax, %rax
	je	.L194
	movq	48(%rbx), %rax
	cmpq	$1, %rax
	je	.L216
.L194:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L195
	movq	48(%rbx), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
.L195:
	cmpl	$4, %esi
	movq	$0, 112+QUARKTS(%rip)
	jne	.L196
	movq	64(%rbx), %rdx
	movzwl	14(%rdx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rdx)
.L196:
	movb	$1, 56(%rbx)
	movb	$0, 42+QUARKTS(%rip)
	movb	$0, 41+QUARKTS(%rip)
	movq	$0, 32+QUARKTS(%rip)
	movl	36(%rbx), %eax
	addl	$1, %eax
	movl	%eax, 36(%rbx)
	movl	$3, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L188:
	movzbl	81+QUARKTS(%rip), %eax
	leaq	16+QUARKTS(%rip), %rcx
	testb	%al, %al
	sete	%al
	movb	%al, 40+QUARKTS(%rip)
	movl	$9, 16+QUARKTS(%rip)
	movq	$0, 24+QUARKTS(%rip)
	movq	QUARKTS(%rip), %rax
	call	*%rax
	movl	$3, %eax
	movb	$1, 81+QUARKTS(%rip)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L184:
	movq	104+QUARKTS(%rip), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movq	$0, 104+QUARKTS(%rip)
	jmp	.L181
	.p2align 4,,10
.L185:
	movq	16(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movb	$0, 57(%rcx)
	jmp	.L181
	.p2align 4,,10
.L186:
	movq	64(%rcx), %rcx
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L214
	movzwl	12(%rcx), %r8d
	movzwl	14(%rcx), %edx
	cmpw	%dx, %r8w
	je	.L214
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r9d
	xorl	%edx, %edx
	movzwl	8(%rcx), %r8d
	divw	%r9w
	movzwl	%dx, %eax
	movzwl	%r8w, %edx
	imull	%edx, %eax
	cltq
	addq	(%rcx), %rax
.L214:
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L181
	.p2align 4,,10
.L187:
	movq	64(%rcx), %rax
	jmp	.L214
	.p2align 4,,10
.L216:
	movq	72(%rbx), %rcx
	leaq	16+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L195
	.p2align 4,,10
.L215:
	movb	$1, 41+QUARKTS(%rip)
	movzwl	32(%rcx), %eax
	negl	%eax
	jmp	.L197
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerRun
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRun
qSchedulerRun:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$80, %rsp
	.seh_stackalloc	80
	movaps	%xmm6, 64(%rsp)
	.seh_savexmm	%xmm6, 64
	.seh_endprologue
	pxor	%xmm6, %xmm6
	leaq	QUARKTS(%rip), %rsi
	leaq	_qSysTick_Epochs_(%rip), %rbx
	movb	$1, 80+QUARKTS(%rip)
	.p2align 4,,10
.L257:
	movzbl	80+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L326
.L218:
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	js	.L223
.L332:
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L224
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L224:
	movq	88+QUARKTS(%rip), %rax
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
	movzbl	96+QUARKTS(%rip), %eax
	cmpb	$1, %al
	jbe	.L261
	movq	88+QUARKTS(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L261
	xorl	%edx, %edx
	movl	$16, %eax
	movl	$1, %ecx
	jmp	.L226
	.p2align 4,,10
.L228:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%cl, %eax
	salq	$4, %rax
	addq	%rax, %r8
	movq	(%r8), %r8
	testq	%r8, %r8
	je	.L325
.L226:
	movq	88+QUARKTS(%rip), %r8
	addq	%rax, %r8
	movq	(%r8), %r8
	movzbl	40(%r8), %r8d
	cmpb	%r9b, %r8b
	jbe	.L227
	movq	88+QUARKTS(%rip), %rdx
	addq	%rdx, %rax
	movl	%ecx, %edx
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
.L227:
	movzbl	96+QUARKTS(%rip), %eax
	addl	$1, %ecx
	cmpb	%al, %cl
	jb	.L228
.L325:
	movzbl	%dl, %eax
	movzbl	%dl, %r8d
	salq	$4, %rax
.L225:
	movq	88+QUARKTS(%rip), %rcx
	addq	%rax, %rcx
	movq	8(%rcx), %rcx
	movq	%rcx, 104+QUARKTS(%rip)
	movq	88+QUARKTS(%rip), %rcx
	addq	%rax, %rcx
	movq	(%rcx), %rdi
	movb	$1, 80(%rdi)
	movq	88+QUARKTS(%rip), %rcx
	addq	%rcx, %rax
	movq	$0, (%rax)
	movswl	98+QUARKTS(%rip), %eax
	cmpl	%eax, %r8d
	jge	.L229
	.p2align 4,,10
.L230:
	movq	88+QUARKTS(%rip), %rcx
	movzbl	%dl, %eax
	movq	88+QUARKTS(%rip), %r8
	addq	$1, %rax
	addl	$1, %edx
	salq	$4, %rax
	addq	%rax, %rcx
	leaq	-16(%r8,%rax), %rax
	movq	(%rcx), %r9
	movq	8(%rcx), %r10
	movzbl	%dl, %ecx
	movq	%r9, (%rax)
	movq	%r10, 8(%rax)
	movswl	98+QUARKTS(%rip), %eax
	cmpl	%eax, %ecx
	jl	.L230
.L229:
	movzwl	98+QUARKTS(%rip), %eax
	subl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L231
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L231:
	movq	%rdi, %rcx
	movl	$2, %edx
	call	_qScheduler_Dispatch
	movb	%al, 80(%rdi)
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L256
.L259:
	xorl	%r8d, %r8d
	jmp	.L249
	.p2align 4,,10
.L234:
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jle	.L236
.L235:
	movl	24(%rcx), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm6, %xmm0
	jp	.L268
	je	.L237
.L268:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	28(%rcx), %r9d
	movl	24(%rcx), %edx
	subl	%r9d, %eax
	cmpl	%edx, %eax
	jnb	.L237
.L233:
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L242
	movzbl	60(%rcx), %eax
	testb	%al, %al
	je	.L243
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L263
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %r10d
	movzwl	10(%rax), %r9d
	movl	%edx, %eax
	subl	%r10d, %eax
	cmpw	%r9w, %ax
	je	.L263
.L243:
	movzbl	61(%rcx), %eax
	testb	%al, %al
	je	.L245
	movq	64(%rcx), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L246
	movzwl	12(%rdx), %eax
	movzwl	14(%rdx), %edx
	subl	%edx, %eax
.L246:
	movzbl	61(%rcx), %edx
	cmpw	%ax, %dx
	jbe	.L265
.L245:
	movzbl	59(%rcx), %eax
	testb	%al, %al
	je	.L247
	movq	64(%rcx), %r9
	testq	%r9, %r9
	je	.L247
	movzwl	12(%r9), %edx
	movzwl	14(%r9), %eax
	cmpw	%ax, %dx
	je	.L247
	movzwl	14(%r9), %eax
	movzwl	10(%r9), %r11d
	xorl	%edx, %edx
	movzwl	8(%r9), %r10d
	divw	%r11w
	movzwl	%r10w, %eax
	movzwl	%dx, %edx
	imull	%eax, %edx
	movslq	%edx, %rax
	addq	(%r9), %rax
	movl	$4, %edx
	jne	.L244
	.p2align 4,,10
.L247:
	movzbl	62(%rcx), %eax
	testb	%al, %al
	je	.L242
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L267
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %eax
	cmpw	%ax, %dx
	je	.L267
.L242:
	movzbl	57(%rcx), %eax
	testb	%al, %al
	jne	.L327
	movb	$3, 80(%rcx)
.L241:
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L328
.L249:
	movzbl	58(%rcx), %eax
	testb	%al, %al
	je	.L233
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jns	.L234
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L234
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L235
.L236:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	jne	.L233
	jmp	.L235
	.p2align 4,,10
.L237:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	$1, %r8d
	movl	%eax, 28(%rcx)
	movb	$1, 80(%rcx)
	movl	$1, 84(%rcx)
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L249
.L328:
	testb	%r8b, %r8b
	jne	.L329
	testq	%rdi, %rdi
	je	.L232
.L256:
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L257
.L330:
	movb	$0, 80+QUARKTS(%rip)
	movb	$0, 82+QUARKTS(%rip)
	movzbl	83+QUARKTS(%rip), %eax
	testb	%al, %al
	sete	%al
	movb	%al, 40+QUARKTS(%rip)
	movl	$8, 16+QUARKTS(%rip)
	movq	$0, 24+QUARKTS(%rip)
	movq	8+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L258
	movq	8+QUARKTS(%rip), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
	nop
.L258:
	movaps	64(%rsp), %xmm6
	movb	$1, 81+QUARKTS(%rip)
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L265:
	movl	$6, %edx
.L244:
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L241
	.p2align 4,,10
.L327:
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	$3, 84(%rcx)
	jmp	.L241
	.p2align 4,,10
.L232:
	movq	(%rsi), %rax
	testq	%rax, %rax
	je	.L256
	xorl	%ecx, %ecx
	movl	$9, %edx
	call	_qScheduler_Dispatch
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L257
	jmp	.L330
	.p2align 4,,10
.L263:
	movl	$5, %edx
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L241
	.p2align 4,,10
.L329:
	movq	ChainIterator.3325(%rip), %rdi
	jmp	.L251
	.p2align 4,,10
.L252:
	testq	%rdi, %rdi
	je	.L253
.L331:
	movq	(%rdi), %rdx
	movzbl	80(%rdi), %eax
	movq	%rdx, ChainIterator.3325(%rip)
	cmpb	$1, %al
	je	.L254
	xorl	%eax, %eax
.L255:
	movb	%al, 80(%rdi)
	movq	%rdx, %rdi
.L251:
	cmpq	%rbx, %rdi
	jne	.L252
	movq	56+QUARKTS(%rip), %rdi
	testq	%rdi, %rdi
	movq	%rdi, ChainIterator.3325(%rip)
	jne	.L331
.L253:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3325(%rip)
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L257
	jmp	.L330
	.p2align 4,,10
.L254:
	movl	84(%rdi), %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movq	ChainIterator.3325(%rip), %rdx
	jmp	.L255
	.p2align 4,,10
.L326:
	movq	64+QUARKTS(%rip), %rax
	movq	$0, 56(%rsp)
	movq	56+QUARKTS(%rip), %rdx
	testq	%rax, %rax
	je	.L219
	movq	%rdx, 40(%rsp)
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movq	40(%rsp), %rdx
	movl	%eax, 84+QUARKTS(%rip)
.L219:
	testq	%rdx, %rdx
	je	.L220
	leaq	56(%rsp), %r11
	.p2align 4,,10
.L221:
	movq	(%rdx), %r10
	movq	%r11, %rcx
	call	_qScheduler_PriorizedInsert
	testq	%r10, %r10
	movq	%r10, %rdx
	jne	.L221
.L220:
	movq	56(%rsp), %rax
	movb	$1, 80+QUARKTS(%rip)
	movq	%rax, 56+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L218
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	jns	.L332
.L223:
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L232
	xorl	%edi, %edi
	jmp	.L259
	.p2align 4,,10
.L267:
	movl	$7, %edx
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L241
	.p2align 4,,10
.L261:
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L225
	.seh_endproc
	.p2align 4,,15
	.globl	qStateMachine_Attribute
	.def	qStateMachine_Attribute;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Attribute
qStateMachine_Attribute:
	.seh_endprologue
	cmpl	$5, %edx
	ja	.L333
	leaq	.L336(%rip), %r9
	movl	%edx, %edx
	movslq	(%r9,%rdx,4), %rax
	addq	%r9, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L336:
	.long	.L335-.L336
	.long	.L337-.L336
	.long	.L338-.L336
	.long	.L339-.L336
	.long	.L340-.L336
	.long	.L341-.L336
	.text
	.p2align 4,,10
.L341:
	movq	%r8, 64(%rcx)
.L333:
	ret
	.p2align 4,,10
.L340:
	movq	%r8, 56(%rcx)
	ret
	.p2align 4,,10
.L335:
	movq	%r8, (%rcx)
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	ret
	.p2align 4,,10
.L337:
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	ret
	.p2align 4,,10
.L338:
	movq	%r8, 40(%rcx)
	ret
	.p2align 4,,10
.L339:
	movq	%r8, 48(%rcx)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerSet
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerSet
qSTimerSet:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L342
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	ja	.L342
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movb	$1, (%rcx)
	movl	%eax, 4(%rcx)
	movl	$1, %eax
.L342:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerFreeRun
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerFreeRun
qSTimerFreeRun:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L347
	cmpb	$0, (%rcx)
	jne	.L354
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	jbe	.L355
.L347:
	ret
	.p2align 4,,10
.L354:
	movl	_qSysTick_Epochs_(%rip), %edx
	subl	4(%rcx), %edx
	cmpl	8(%rcx), %edx
	jb	.L347
	movl	$1, %eax
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
	ret
	.p2align 4,,10
.L355:
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rdx
	movl	%edx, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %edx
	movb	$1, (%rcx)
	movl	%edx, 4(%rcx)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerExpired
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerExpired
qSTimerExpired:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L356
	cmpb	$0, (%rcx)
	je	.L356
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	setnb	%al
.L356:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L361
	cmpb	$0, (%rcx)
	je	.L361
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
.L361:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerRemaining
	.def	qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerRemaining
qSTimerRemaining:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L366
	cmpb	$0, (%rcx)
	movl	8(%rcx), %eax
	jne	.L375
.L366:
	ret
	.p2align 4,,10
.L375:
	testl	%eax, %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %ecx
	je	.L366
	subl	%ecx, %edx
	movl	%eax, %ecx
	subl	%edx, %ecx
	cmpl	%eax, %edx
	cmovbe	%ecx, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L376
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L376:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerStatus
	.def	qSTimerStatus;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerStatus
qSTimerStatus:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L381
	movzbl	(%rcx), %eax
.L381:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerChangeTime
	.def	qSTimerChangeTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerChangeTime
qSTimerChangeTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L385
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
.L385:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qClock2Time
	.def	qClock2Time;	.scl	2;	.type	32;	.endef
	.seh_proc	qClock2Time
qClock2Time:
	.seh_endprologue
	pxor	%xmm0, %xmm0
	movl	%ecx, %ecx
	movss	48+QUARKTS(%rip), %xmm1
	cvtsi2ssq	%rcx, %xmm0
	mulss	%xmm1, %xmm0
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qMemoryAlloc
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryAlloc
qMemoryAlloc:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	64+QUARKTS(%rip), %rax
	movq	16(%rcx), %r13
	movq	%rcx, %r14
	movl	%edx, %r15d
	movl	%edx, %esi
	testq	%rax, %rax
	je	.L394
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L394:
	movzbl	2(%r14), %ebx
	xorl	%r12d, %r12d
.L405:
	cmpb	%r12b, %bl
	jbe	.L404
	movq	8(%r14), %rdi
	movzbl	%r12b, %eax
	movzwl	(%r14), %r11d
	leaq	(%rdi,%rax), %rdx
	movzwl	%r11w, %r8d
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L406
	cmpw	%si, %r11w
	jnb	.L427
.L425:
	leal	1(%r12), %eax
	movl	%r11d, %r8d
	movl	$1, %r9d
	movzbl	%al, %eax
	jmp	.L399
	.p2align 4,,10
.L403:
	movzbl	(%rdi,%rax), %r10d
	testb	%r10b, %r10b
	jne	.L428
	addl	%r11d, %r8d
	leaq	1(%rax), %r10
	cmpw	%si, %r8w
	jnb	.L407
	movq	%r10, %rax
.L399:
	addl	$1, %r9d
	cmpb	%al, %bl
	movl	%eax, %ebp
	ja	.L403
.L397:
	cmpb	%bpl, %bl
	jne	.L405
.L404:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L410
	movq	72+QUARKTS(%rip), %rax
	xorl	%r13d, %r13d
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	jmp	.L393
	.p2align 4,,10
.L406:
	movzbl	%cl, %eax
	addl	%ecx, %r12d
	imull	%r8d, %eax
	cltq
	addq	%rax, %r13
	cmpb	%r12b, %bl
	jbe	.L429
	movzbl	%r12b, %eax
	leaq	(%rdi,%rax), %rdx
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L406
	cmpw	%si, %r11w
	jb	.L425
.L427:
	movl	$1, %r9d
	.p2align 4,,10
.L407:
	testw	%r15w, %r15w
	movb	%r9b, (%rdx)
	je	.L400
	addq	%r13, %rax
	xorl	%edx, %edx
	.p2align 4,,10
.L401:
	addl	$1, %edx
	movzbl	%dl, %ecx
	cmpw	%si, %cx
	jb	.L401
	movb	$0, (%rax)
.L400:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L393
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L393:
	movq	%r13, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4,,10
.L428:
	leal	(%r10,%rbp), %r12d
	movzbl	%r12b, %r13d
	imull	%r11d, %r13d
	movslq	%r13d, %r13
	addq	16(%r14), %r13
	cmpb	%bpl, %bl
	jne	.L405
	jmp	.L404
.L429:
	movl	%r12d, %ebp
	jmp	.L397
.L410:
	xorl	%r13d, %r13d
	jmp	.L393
	.seh_endproc
	.p2align 4,,15
	.globl	qMemoryFree
	.def	qMemoryFree;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryFree
qMemoryFree:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rsi
	movq	%rdx, %rbx
	je	.L430
	testq	%rdx, %rdx
	je	.L430
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L434
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L434:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L435
	cmpq	%r8, %rbx
	je	.L453
	movzwl	(%rsi), %ecx
	xorl	%eax, %eax
	jmp	.L438
	.p2align 4,,10
.L439:
	cmpq	%r8, %rbx
	je	.L454
.L438:
	addl	$1, %eax
	addq	%rcx, %r8
	cmpb	%dl, %al
	jne	.L439
.L435:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L430
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L430:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L454:
	movzbl	%al, %eax
.L436:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	jmp	.L435
	.p2align 4,,10
.L453:
	xorl	%eax, %eax
	jmp	.L436
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %r10
	movl	%r9d, %eax
	je	.L455
	testq	%rdx, %rdx
	je	.L455
	xorl	%ecx, %ecx
	movq	%rdx, (%r10)
	movzwl	%r9w, %edx
	movw	%cx, 12(%r10)
	leal	-1(%rdx), %ecx
	xorl	%r11d, %r11d
	movw	%r11w, 14(%r10)
	movw	%r8w, 8(%r10)
	testl	%edx, %ecx
	jne	.L463
	movw	%ax, 10(%r10)
.L455:
	ret
	.p2align 4,,10
.L463:
	subl	$1, %r9d
	movl	$4, %edx
	movl	$1, %ecx
.L458:
	movzwl	%r9w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r9d
	subl	$1, %edx
	jne	.L458
	movzwl	%r9w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 10(%r10)
	jmp	.L455
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	movl	$1, %eax
	testq	%rcx, %rcx
	je	.L464
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L464:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L471
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L471
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r9d
	xorl	%edx, %edx
	movzwl	8(%rcx), %r8d
	divw	%r9w
	movzwl	%dx, %eax
	movzwl	%r8w, %edx
	imull	%edx, %eax
	cltq
	addq	(%rcx), %rax
	ret
	.p2align 4,,10
.L471:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferPopFront
	.def	qRBufferPopFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPopFront
qRBufferPopFront:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	xorl	%eax, %eax
	movq	%rcx, %rbx
	movq	%rdx, %rcx
	testq	%rbx, %rbx
	je	.L472
	movzwl	12(%rbx), %r8d
	movzwl	14(%rbx), %edx
	cmpw	%dx, %r8w
	je	.L472
	movzwl	14(%rbx), %eax
	movzwl	10(%rbx), %r10d
	xorl	%edx, %edx
	movzwl	8(%rbx), %r9d
	movzwl	8(%rbx), %r8d
	divw	%r10w
	movzwl	%dx, %edx
	imull	%r9d, %edx
	movslq	%edx, %rdx
	addq	(%rbx), %rdx
	call	memcpy
	movzwl	14(%rbx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rbx)
	movl	$1, %eax
.L472:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferPush
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPush
qRBufferPush:
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %r10
	je	.L481
	testq	%rcx, %rcx
	je	.L481
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r8d
	subl	%eax, %edx
	xorl	%eax, %eax
	cmpw	%r8w, %dx
	je	.L477
	movzwl	12(%rcx), %eax
	movzwl	10(%rcx), %r9d
	xorl	%edx, %edx
	movzwl	8(%rcx), %r8d
	movq	(%rcx), %r11
	divw	%r9w
	movzwl	8(%rcx), %eax
	movzwl	%r8w, %r9d
	movzwl	%dx, %edx
	imull	%r9d, %edx
	testw	%ax, %ax
	movslq	%edx, %r9
	je	.L479
	xorl	%eax, %eax
	.p2align 4,,10
.L480:
	movzwl	%ax, %r8d
	addl	$1, %eax
	leaq	(%r9,%r8), %rdx
	movzbl	(%r10,%r8), %r8d
	addq	%r11, %rdx
	movb	%r8b, (%rdx)
	movzwl	8(%rcx), %edx
	cmpw	%ax, %dx
	ja	.L480
.L479:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
.L477:
	ret
	.p2align 4,,10
.L481:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSwapBytes
	.def	qSwapBytes;	.scl	2;	.type	32;	.endef
	.seh_proc	qSwapBytes
qSwapBytes:
	.seh_endprologue
	subw	$1, %dx
	je	.L493
	xorl	%r9d, %r9d
	.p2align 4,,10
.L495:
	movzwl	%r9w, %r8d
	movzwl	%dx, %eax
	addl	$1, %r9d
	addq	%rcx, %r8
	addq	%rcx, %rax
	subl	$1, %edx
	movzbl	(%r8), %r10d
	movzbl	(%rax), %r11d
	cmpw	%dx, %r9w
	movb	%r11b, (%r8)
	movb	%r10b, (%rax)
	jb	.L495
.L493:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qCheckEndianness
	.def	qCheckEndianness;	.scl	2;	.type	32;	.endef
	.seh_proc	qCheckEndianness
qCheckEndianness:
	.seh_endprologue
	movl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qOutputRaw
	.def	qOutputRaw;	.scl	2;	.type	32;	.endef
	.seh_proc	qOutputRaw
qOutputRaw:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movzbl	128(%rsp), %r13d
	movzwl	%r9w, %edi
	movq	%rcx, %rbp
	movq	%rdx, %rsi
	testq	%rdi, %rdi
	movq	%r8, %r12
	je	.L501
	xorl	%ebx, %ebx
	.p2align 4,,10
.L504:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	movsbl	(%r12,%rbx), %edx
	cmove	%rsi, %rcx
	addq	$1, %rbx
	call	*%rbp
	cmpq	%rdi, %rbx
	jne	.L504
.L501:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qInputRaw
	.def	qInputRaw;	.scl	2;	.type	32;	.endef
	.seh_proc	qInputRaw
qInputRaw:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movzbl	128(%rsp), %r13d
	movzwl	%r9w, %edi
	movq	%rcx, %rbp
	movq	%rdx, %rsi
	testq	%rdi, %rdi
	movq	%r8, %r12
	je	.L510
	xorl	%ebx, %ebx
	.p2align 4,,10
.L513:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	cmove	%rsi, %rcx
	call	*%rbp
	movb	%al, (%r12,%rbx)
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	jne	.L513
.L510:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qOutputString
	.def	qOutputString;	.scl	2;	.type	32;	.endef
	.seh_proc	qOutputString
qOutputString:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rdx, %rsi
	movsbl	(%r8), %edx
	movq	%rcx, %rbp
	movq	%r8, %rbx
	movl	%r9d, %r12d
	testb	%dl, %dl
	je	.L519
	xorl	%edi, %edi
	.p2align 4,,10
.L522:
	addq	$1, %rbx
	testb	%r12b, %r12b
	movq	%rsi, %rcx
	je	.L521
	leaq	(%rsi,%rdi), %rcx
	addq	$1, %rdi
.L521:
	call	*%rbp
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L522
.L519:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qPrintXData
	.def	qPrintXData;	.scl	2;	.type	32;	.endef
	.seh_proc	qPrintXData
qPrintXData:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testw	%r9w, %r9w
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	je	.L530
	movzwl	%r9w, %r9d
	movq	%r8, %rbp
	leal	-1(%r9), %eax
	leaq	1(%r8,%rax), %rdi
	.p2align 4,,10
.L533:
	movzbl	0(%rbp), %eax
	movq	%rsi, %rcx
	shrb	$4, %al
	leal	48(%rax), %edx
	addl	$55, %eax
	cmpb	$57, %dl
	cmova	%eax, %edx
	movzbl	%dl, %edx
	call	*%rbx
	movzbl	0(%rbp), %eax
	movq	%rsi, %rcx
	andl	$15, %eax
	leal	48(%rax), %edx
	addl	$55, %eax
	cmpb	$57, %dl
	cmova	%eax, %edx
	addq	$1, %rbp
	movzbl	%dl, %edx
	call	*%rbx
	movl	$32, %edx
	movq	%rsi, %rcx
	call	*%rbx
	cmpq	%rbp, %rdi
	jne	.L533
.L530:
	movq	%rsi, %rcx
	movl	$13, %edx
	call	*%rbx
	movl	$10, %edx
	movq	%rsi, %rcx
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	rex.W jmp	*%rax
	.seh_endproc
	.p2align 4,,15
	.globl	qU32toX
	.def	qU32toX;	.scl	2;	.type	32;	.endef
	.seh_proc	qU32toX
qU32toX:
	.seh_endprologue
	movq	%rdx, %rax
	movsbq	%r8b, %rdx
	movsbl	%r8b, %r8d
	subl	$1, %r8d
	movb	$0, (%rax,%rdx)
	js	.L536
	movslq	%r8d, %rdx
	movl	%r8d, %r8d
	leaq	-1(%rax,%rdx), %r11
	leaq	(%rax,%rdx), %r10
	subq	%r8, %r11
	.p2align 4,,10
.L538:
	movl	%ecx, %r9d
	andl	$15, %r9d
	leal	48(%r9), %r8d
	addl	$55, %r9d
	cmpb	$57, %r8b
	cmova	%r9d, %r8d
	subq	$1, %r10
	shrl	$4, %ecx
	movb	%r8b, 1(%r10)
	cmpq	%r11, %r10
	jne	.L538
.L536:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qXtoU32
	.def	qXtoU32;	.scl	2;	.type	32;	.endef
	.seh_proc	qXtoU32
qXtoU32:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	xorl	%edi, %edi
	xorl	%ebp, %ebp
	movq	%rcx, %rsi
.L541:
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	ja	.L540
.L553:
	testb	%bl, %bl
	je	.L540
	call	__locale_ctype_ptr
	movsbl	%bl, %ecx
	addq	$1, %rsi
	call	toupper
	movzbl	%al, %r13d
	movl	%eax, %ebx
	call	__locale_ctype_ptr
	testb	$68, 1(%rax,%r13)
	je	.L542
	leal	-48(%rbx), %edx
	addl	$1, %edi
	cmpb	$9, %dl
	jbe	.L543
	leal	-65(%rbx), %eax
	movl	%r13d, %edx
	subl	$55, %ebx
	cmpb	$6, %al
	cmovb	%ebx, %edx
.L543:
	movl	%edx, %ebx
	sall	$4, %ebp
	andl	$15, %ebx
	orl	%ebx, %ebp
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	jbe	.L553
.L540:
	movl	%ebp, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
.L542:
	call	__locale_ctype_ptr
	testb	$8, 1(%rax,%r13)
	jne	.L541
	movl	%ebp, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qAtoF
	.def	qAtoF;	.scl	2;	.type	32;	.endef
	.seh_proc	qAtoF
qAtoF:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$88, %rsp
	.seh_stackalloc	88
	movaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	movaps	%xmm7, 48(%rsp)
	.seh_savexmm	%xmm7, 48
	movaps	%xmm8, 64(%rsp)
	.seh_savexmm	%xmm8, 64
	.seh_endprologue
	xorl	%esi, %esi
	movq	%rcx, %rbx
	.p2align 4,,10
.L555:
	call	__locale_ctype_ptr
	movsbq	(%rbx,%rsi), %rcx
	movl	%esi, %edi
	addq	$1, %rsi
	testb	$8, 1(%rax,%rcx)
	jne	.L555
	cmpb	$45, %cl
	je	.L563
	cmpb	$43, %cl
	movl	$1, %esi
	je	.L556
.L557:
	movslq	%edi, %rdi
	pxor	%xmm6, %xmm6
	movsd	.LC5(%rip), %xmm7
	jmp	.L558
	.p2align 4,,10
.L559:
	pxor	%xmm0, %xmm0
	subl	$48, %edx
	movapd	%xmm6, %xmm1
	cvtsi2sd	%edx, %xmm0
	mulsd	%xmm7, %xmm1
	movapd	%xmm0, %xmm6
	addsd	%xmm1, %xmm6
.L558:
	call	__locale_ctype_ptr
	movsbl	(%rbx,%rdi), %edx
	movl	%edi, %ebp
	addq	$1, %rdi
	movsbq	%dl, %rcx
	testb	$4, 1(%rax,%rcx)
	jne	.L559
	xorl	%eax, %eax
	cmpb	$46, %dl
	sete	%al
	movsd	.LC4(%rip), %xmm7
	addl	%eax, %ebp
	movsd	.LC5(%rip), %xmm8
	movslq	%ebp, %rbp
	addq	%rbp, %rbx
	jmp	.L561
	.p2align 4,,10
.L562:
	pxor	%xmm1, %xmm1
	subl	$48, %edx
	movapd	%xmm6, %xmm0
	mulsd	%xmm8, %xmm7
	cvtsi2sd	%edx, %xmm1
	mulsd	%xmm8, %xmm0
	addsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm6
.L561:
	call	__locale_ctype_ptr
	movsbl	(%rbx), %edx
	addq	$1, %rbx
	movsbq	%dl, %rcx
	testb	$4, 1(%rax,%rcx)
	jne	.L562
	pxor	%xmm0, %xmm0
	movaps	64(%rsp), %xmm8
	cvtsi2sd	%esi, %xmm0
	mulsd	%xmm6, %xmm0
	movaps	32(%rsp), %xmm6
	divsd	%xmm7, %xmm0
	movaps	48(%rsp), %xmm7
	addq	$88, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L563:
	movl	$-1, %esi
.L556:
	addl	$1, %edi
	jmp	.L557
	.seh_endproc
	.p2align 4,,15
	.globl	qAtoI
	.def	qAtoI;	.scl	2;	.type	32;	.endef
	.seh_proc	qAtoI
qAtoI:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	jmp	.L567
	.p2align 4,,10
.L568:
	addq	$1, %rbx
.L567:
	call	__locale_ctype_ptr
	movsbq	(%rbx), %rcx
	testb	$8, 1(%rax,%rcx)
	movq	%rcx, %rdx
	jne	.L568
	cmpb	$45, %cl
	je	.L582
	cmpb	$43, %cl
	movl	$1, %r8d
	je	.L583
.L570:
	testb	%dl, %dl
	je	.L578
	leal	-48(%rdx), %eax
	cmpb	$9, %al
	movl	$0, %eax
	jbe	.L571
	jmp	.L566
	.p2align 4,,10
.L573:
	leal	-48(%rdx), %ecx
	cmpb	$9, %cl
	ja	.L581
.L571:
	leal	(%rax,%rax,4), %ecx
	addq	$1, %rbx
	leal	-48(%rdx,%rcx,2), %eax
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L573
.L581:
	imull	%r8d, %eax
.L566:
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L583:
	movsbl	1(%rbx), %edx
	addq	$1, %rbx
	jmp	.L570
	.p2align 4,,10
.L582:
	movsbl	1(%rbx), %edx
	movl	$-1, %r8d
	addq	$1, %rbx
	jmp	.L570
	.p2align 4,,10
.L578:
	xorl	%eax, %eax
	jmp	.L566
	.seh_endproc
	.p2align 4,,15
	.globl	qUtoA
	.def	qUtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qUtoA
qUtoA:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %rbx
	je	.L585
	testl	%ecx, %ecx
	jne	.L591
	movb	$48, (%rdx)
	movl	$1, %eax
.L587:
	movb	$0, (%rbx,%rax)
.L585:
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L591:
	movzbl	%r8b, %r8d
	call	__q_revuta.part.5
	movzbl	%al, %eax
	jmp	.L587
	.seh_endproc
	.p2align 4,,15
	.globl	qItoA
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qItoA
qItoA:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %rbx
	je	.L593
	testl	%ecx, %ecx
	js	.L603
	jne	.L604
	movb	$48, (%rdx)
	movl	$1, %eax
.L598:
	movb	$0, (%rbx,%rax)
.L593:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L603:
	xorl	%esi, %esi
	cmpb	$10, %r8b
	je	.L605
.L595:
	negl	%ecx
.L596:
	movzbl	%r8b, %r8d
	call	__q_revuta.part.5
	addl	%esi, %eax
	movzbl	%al, %eax
	jmp	.L598
	.p2align 4,,10
.L605:
	movb	$45, (%rdx)
	movl	$1, %esi
	leaq	1(%rdx), %rdx
	jmp	.L595
.L604:
	xorl	%esi, %esi
	jmp	.L596
	.seh_endproc
	.p2align 4,,15
	.globl	qBtoA
	.def	qBtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qBtoA
qBtoA:
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %rax
	je	.L607
	testb	%cl, %cl
	jne	.L612
	movl	$1936482662, (%rdx)
	movl	$101, %edx
	movw	%dx, 4(%rax)
.L607:
	ret
	.p2align 4,,10
.L612:
	movl	$1702195828, (%rdx)
	movb	$0, 4(%rdx)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qIsNan
	.def	qIsNan;	.scl	2;	.type	32;	.endef
	.seh_proc	qIsNan
qIsNan:
	.seh_endprologue
	xorl	%eax, %eax
	movd	%xmm0, %ecx
	movd	%xmm0, %edx
	andl	$2139095040, %ecx
	cmpl	$2139095040, %ecx
	je	.L616
	ret
	.p2align 4,,10
.L616:
	andl	$8388607, %edx
	setne	%al
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qIsInf
	.def	qIsInf;	.scl	2;	.type	32;	.endef
	.seh_proc	qIsInf
qIsInf:
	.seh_endprologue
	movd	%xmm0, %eax
	andl	$2147483647, %eax
	cmpl	$2139095040, %eax
	sete	%al
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qFtoA
	.def	qFtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qFtoA
qFtoA:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %rbx
	movl	%r8d, %esi
	je	.L635
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L620
	je	.L640
.L620:
	movd	%xmm0, %edx
	movd	%xmm0, %eax
	andl	$2147483647, %edx
	cmpl	$2139095040, %edx
	jne	.L641
	movl	$1718511915, (%rbx)
	movb	$0, 4(%rbx)
.L635:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L640:
	movq	%rbx, %rax
	movl	$3157552, (%rdx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L641:
	movd	%xmm0, %edx
	andl	$2139095040, %edx
	cmpl	$2139095040, %edx
	je	.L642
.L624:
	ucomiss	%xmm0, %xmm1
	ja	.L632
	movq	%rbx, %rdx
	xorl	%edi, %edi
.L633:
	cvttss2siq	%xmm0, %rbp
	testl	%ebp, %ebp
	jne	.L643
	movb	$48, (%rdx)
	movl	$1, %eax
.L627:
	leal	(%rdi,%rax), %ecx
	movzbl	%cl, %eax
	addq	%rbx, %rax
	testb	%sil, %sil
	je	.L628
	pxor	%xmm1, %xmm1
	movl	%ebp, %ebp
	movb	$46, (%rax)
	cmpb	$10, %sil
	movl	$10, %eax
	leal	1(%rcx), %r10d
	cmova	%eax, %esi
	movss	.LC7(%rip), %xmm2
	cvtsi2ssq	%rbp, %xmm1
	leal	1(%rcx,%rsi), %ecx
	movl	%r10d, %edx
	subss	%xmm1, %xmm0
	.p2align 4,,10
.L631:
	mulss	%xmm2, %xmm0
	movzbl	%dl, %r8d
	addl	$1, %edx
	pxor	%xmm1, %xmm1
	cmpb	%cl, %dl
	cvttss2si	%xmm0, %eax
	leal	48(%rax), %r9d
	movsbl	%al, %eax
	cvtsi2ss	%eax, %xmm1
	movb	%r9b, (%rbx,%r8)
	subss	%xmm1, %xmm0
	jne	.L631
	leal	(%r10,%rsi), %eax
	movzbl	%al, %eax
	addq	%rbx, %rax
.L628:
	movb	$0, (%rax)
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L642:
	testl	$8388607, %eax
	je	.L624
	movl	$7233902, (%rbx)
	jmp	.L635
	.p2align 4,,10
.L632:
	xorps	.LC6(%rip), %xmm0
	leaq	1(%rbx), %rdx
	movb	$45, (%rbx)
	movl	$1, %edi
	jmp	.L633
	.p2align 4,,10
.L643:
	movl	$10, %r8d
	movl	%ebp, %ecx
	call	__q_revuta.part.5
	jmp	.L627
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferInit
	.def	qISR_ByteBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferInit
qISR_ByteBufferInit:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L646
	cmpw	$1, %r8w
	jbe	.L646
	movq	40(%rsp), %rax
	subl	$1, %r8d
	movq	%rax, 16(%rcx)
	movq	48(%rsp), %rax
	movq	%rax, 24(%rcx)
	xorl	%eax, %eax
	movb	%r9b, 32(%rcx)
	movw	%r8w, 34(%rcx)
	movq	%rdx, (%rcx)
	movw	%ax, 8(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L646:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferFill
	.def	qISR_ByteBufferFill;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferFill
qISR_ByteBufferFill:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movzbl	10(%rcx), %eax
	movq	%rcx, %rbx
	movl	%edx, %esi
	testb	%al, %al
	jne	.L653
	movq	16(%rcx), %rax
	testq	%rax, %rax
	je	.L654
	movq	16(%rcx), %rax
	movsbl	%dl, %ecx
	call	*%rax
	testb	%al, %al
	je	.L653
.L654:
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L659
	movq	24(%rbx), %rax
	movsbl	%sil, %ecx
	call	*%rax
.L652:
	movq	(%rbx), %rcx
	movzwl	8(%rbx), %edx
	leal	1(%rdx), %r8d
	addq	%rcx, %rdx
	movw	%r8w, 8(%rbx)
	movb	%al, (%rdx)
	movq	(%rbx), %rax
	movzwl	8(%rbx), %edx
	addq	%rdx, %rax
	movb	$0, (%rax)
	movzwl	8(%rbx), %edx
	movzwl	34(%rbx), %eax
	cmpw	%ax, %dx
	jb	.L655
	xorl	%edx, %edx
	movw	%dx, 8(%rbx)
.L655:
	movzbl	32(%rbx), %eax
	cmpb	%sil, %al
	je	.L660
.L653:
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L660:
	xorl	%eax, %eax
	movb	$1, 10(%rbx)
	movw	%ax, 8(%rbx)
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L659:
	movl	%esi, %eax
	jmp	.L652
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferGet
	.def	qISR_ByteBufferGet;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferGet
qISR_ByteBufferGet:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	xorl	%eax, %eax
	movq	%rcx, %rbx
	movq	%rdx, %rcx
	movzbl	10(%rbx), %edx
	testb	%dl, %dl
	je	.L661
	movzwl	8(%rbx), %r8d
	movq	(%rbx), %rdx
	call	memcpy
	movb	$0, 10(%rbx)
	movl	$1, %eax
.L661:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Count
	.def	qBSBuffer_Count;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Count
qBSBuffer_Count:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L665
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	subl	%edx, %eax
	cltq
.L665:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_IsFull
	.def	qBSBuffer_IsFull;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_IsFull
qBSBuffer_IsFull:
	.seh_endprologue
	movl	$1, %eax
	testq	%rcx, %rcx
	je	.L669
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %ecx
	subl	%edx, %eax
	cltq
	cmpq	%rax, %rcx
	sete	%al
.L669:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Empty
	.def	qBSBuffer_Empty;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Empty
qBSBuffer_Empty:
	.seh_endprologue
	movl	$1, %eax
	testq	%rcx, %rcx
	je	.L673
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L673:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Peek
	.def	qBSBuffer_Peek;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Peek
qBSBuffer_Peek:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L677
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
.L677:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Get
	.def	qBSBuffer_Get;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Get
qBSBuffer_Get:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rdx, %r8
	je	.L681
	movzwl	(%rcx), %r9d
	movzwl	2(%rcx), %edx
	cmpw	%dx, %r9w
	je	.L681
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
	movb	%al, (%r8)
	movzwl	2(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 2(%rcx)
	movl	$1, %eax
.L681:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Read
	.def	qBSBuffer_Read;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Read
qBSBuffer_Read:
	.seh_endprologue
	testw	%r8w, %r8w
	je	.L689
	testq	%rcx, %rcx
	je	.L689
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %r9d
	cmpw	%ax, %r9w
	je	.L689
	subl	$1, %r8d
	movq	%rdx, %r9
	movzwl	%r8w, %r8d
	addq	%rdx, %r8
	.p2align 4,,10
.L690:
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %eax
	addq	8(%rcx), %rax
	movzbl	(%rax), %eax
	movb	%al, (%r9)
	movzwl	2(%rcx), %eax
	addl	$1, %eax
	cmpq	%r8, %r9
	movw	%ax, 2(%rcx)
	je	.L696
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	addq	$1, %r9
	cmpw	%ax, %dx
	jne	.L690
.L689:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L696:
	movl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Put
	.def	qBSBuffer_Put;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Put
qBSBuffer_Put:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movl	%edx, %r10d
	je	.L697
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %r8d
	movzwl	16(%rcx), %r9d
	subl	%r8d, %edx
	movslq	%edx, %rdx
	movzwl	%r9w, %r8d
	cmpq	%r8, %rdx
	je	.L697
	movzwl	(%rcx), %eax
	xorl	%edx, %edx
	divw	%r9w
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movb	%r10b, (%rdx)
	movzwl	(%rcx), %eax
	addl	$1, %eax
	movw	%ax, (%rcx)
	movl	$1, %eax
.L697:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Init
	.def	qBSBuffer_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Init
qBSBuffer_Init:
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %r9
	movl	%r8d, %eax
	je	.L702
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, (%r9)
	leal	-1(%rdx), %ecx
	xorl	%r10d, %r10d
	movw	%r10w, 2(%r9)
	testl	%edx, %ecx
	jne	.L713
	movw	%ax, 16(%r9)
.L702:
	ret
	.p2align 4,,10
.L713:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L705:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L705
	movzwl	%r8w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%r9)
	jmp	.L702
	.seh_endproc
	.p2align 4,,15
	.globl	qResponseInitialize
	.def	qResponseInitialize;	.scl	2;	.type	32;	.endef
	.seh_proc	qResponseInitialize
qResponseInitialize:
	.seh_endprologue
	xorl	%eax, %eax
	xorl	%edx, %edx
	movw	%dx, 10(%rcx)
	movq	$0, (%rcx)
	movw	%ax, 8(%rcx)
	movb	$0, 12(%rcx)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qResponseReceived
	.def	qResponseReceived;	.scl	2;	.type	32;	.endef
	.seh_proc	qResponseReceived
qResponseReceived:
	.seh_endprologue
	movzbl	12(%rcx), %eax
	testb	%al, %al
	jne	.L716
	cmpq	$0, (%rcx)
	je	.L720
.L716:
	movzbl	12(%rcx), %edx
	xorl	%eax, %eax
	testb	%dl, %dl
	je	.L715
	xorl	%eax, %eax
	xorl	%edx, %edx
	movq	$0, (%rcx)
	movw	%ax, 8(%rcx)
	movw	%dx, 10(%rcx)
	movl	$1, %eax
	movb	$0, 12(%rcx)
.L715:
	ret
	.p2align 4,,10
.L720:
	movw	%r8w, 8(%rcx)
	xorl	%r8d, %r8d
	movq	%rdx, (%rcx)
	movw	%r8w, 10(%rcx)
	movb	$0, 12(%rcx)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qResponseISRHandler
	.def	qResponseISRHandler;	.scl	2;	.type	32;	.endef
	.seh_proc	qResponseISRHandler
qResponseISRHandler:
	.seh_endprologue
	movzbl	12(%rcx), %r8d
	xorl	%eax, %eax
	cmpb	$1, %r8b
	je	.L721
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L721
	movzwl	10(%rcx), %eax
	cmpb	%dl, (%r8,%rax)
	je	.L730
.L724:
	movzbl	12(%rcx), %eax
.L721:
	ret
	.p2align 4,,10
.L730:
	movzwl	10(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 10(%rcx)
	movzwl	10(%rcx), %eax
	cmpw	8(%rcx), %ax
	jne	.L724
	movb	$1, 12(%rcx)
	jmp	.L724
	.seh_endproc
	.p2align 4,,15
	.globl	__qtrace_func
	.def	__qtrace_func;	.scl	2;	.type	32;	.endef
	.seh_proc	__qtrace_func
__qtrace_func:
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	__qDebugOutputFcn(%rip), %rbx
	movq	128(%rsp), %rbp
	movq	%rcx, %r14
	movq	%rdx, %r13
	movq	%r8, %rsi
	movq	%r9, %rdi
	movl	136(%rsp), %r12d
	testq	%rbx, %rbx
	je	.L731
	movsbl	(%rcx), %edx
	testb	%dl, %dl
	je	.L733
	.p2align 4,,10
.L734:
	addq	$1, %r14
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%r14), %edx
	testb	%dl, %dl
	jne	.L734
	movq	__qDebugOutputFcn(%rip), %rbx
.L733:
	testq	%r13, %r13
	je	.L735
	movl	$64, %edx
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	0(%r13), %edx
	movq	__qDebugOutputFcn(%rip), %rbx
	testb	%dl, %dl
	je	.L736
	.p2align 4,,10
.L737:
	addq	$1, %r13
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	0(%r13), %edx
	testb	%dl, %dl
	jne	.L737
	movq	__qDebugOutputFcn(%rip), %rbx
.L736:
	movl	$32, %edx
	xorl	%ecx, %ecx
	call	*%rbx
	movq	__qDebugOutputFcn(%rip), %rbx
.L735:
	movsbl	(%rsi), %edx
	testb	%dl, %dl
	je	.L738
	.p2align 4,,10
.L739:
	addq	$1, %rsi
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%rsi), %edx
	testb	%dl, %dl
	jne	.L739
	movq	__qDebugOutputFcn(%rip), %rbx
.L738:
	testq	%rdi, %rdi
	je	.L762
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	je	.L741
	.p2align 4,,10
.L742:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L742
	movq	__qDebugOutputFcn(%rip), %rbx
.L741:
	xorl	%ecx, %ecx
	movl	$13, %edx
	call	*%rbx
	movl	$10, %edx
	xorl	%ecx, %ecx
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	rex.W jmp	*__qDebugOutputFcn(%rip)
	.p2align 4,,10
.L731:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
	.p2align 4,,10
.L762:
	movzwl	%r12w, %r9d
	movq	%rbp, %r8
	xorl	%edx, %edx
	movq	%rbx, %rcx
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	jmp	qPrintXData
	.seh_endproc
	.data
	.align 8
ChainIterator.3325:
	.quad	_qSysTick_Epochs_
	.globl	qDebugTrace_Buffer
	.bss
	.align 32
qDebugTrace_Buffer:
	.space 36
	.globl	__qDebugOutputFcn
	.align 8
__qDebugOutputFcn:
	.space 8
.lcomm _qSysTick_Epochs_,4,4
.lcomm QUARKTS,120,32
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1056964608
	.align 8
.LC2:
	.long	0
	.long	1071644672
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1076101120
	.align 16
.LC6:
	.long	2147483648
	.long	0
	.long	0
	.long	0
	.align 4
.LC7:
	.long	1092616192
	.ident	"GCC: (GNU) 7.3.0"
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	__locale_ctype_ptr;	.scl	2;	.type	32;	.endef
	.def	toupper;	.scl	2;	.type	32;	.endef
