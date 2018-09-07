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
	je	.L20
	movzbl	58(%rcx), %eax
.L20:
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
	je	.L27
	movl	36(%rcx), %eax
.L27:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSendEvent
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSendEvent
qTaskSendEvent:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L31
	movb	$1, 57(%rcx)
	movq	%rdx, 16(%rcx)
.L31:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetTime
	.def	qTaskSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetTime
qTaskSetTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L36
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 24(%rcx)
.L36:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetIterations
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetIterations
qTaskSetIterations:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L41
	movl	%edx, %eax
	negl	%eax
	cmpw	$-32768, %dx
	cmovne	%eax, %edx
	movw	%dx, 32(%rcx)
.L41:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetPriority
	.def	qTaskSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetPriority
qTaskSetPriority:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L48
	movb	$0, 80+QUARKTS(%rip)
	movb	%dl, 40(%rcx)
.L48:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetCallback
	.def	qTaskSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetCallback
qTaskSetCallback:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L53
	movq	%rdx, 48(%rcx)
.L53:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetState
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetState
qTaskSetState:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L58
	testb	%dl, %dl
	je	.L60
	movzbl	58(%rcx), %eax
	testb	%al, %al
	jne	.L58
.L60:
	movb	%dl, 58(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L58:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetData
	.def	qTaskSetData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetData
qTaskSetData:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L64
	movq	%rdx, 8(%rcx)
.L64:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskClearTimeElapsed
	.def	qTaskClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskClearTimeElapsed
qTaskClearTimeElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L69
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L69:
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
	je	.L74
	movswl	98+QUARKTS(%rip), %r9d
	movzbl	96+QUARKTS(%rip), %r8d
	subl	$1, %r8d
	cmpl	%r8d, %r9d
	jge	.L74
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
.L74:
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
	je	.L81
	xorl	%eax, %eax
	.p2align 4,,10
.L82:
	movq	88+QUARKTS(%rip), %rcx
	movzbl	%al, %edx
	addl	$1, %eax
	salq	$4, %rdx
	addq	%rcx, %rdx
	movq	$0, (%rdx)
	movzbl	96+QUARKTS(%rip), %edx
	cmpb	%al, %dl
	ja	.L82
.L81:
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
	je	.L87
	cmpq	%rcx, %rdx
	je	.L89
	movq	(%rdx), %r8
	testq	%r8, %r8
	jne	.L91
	jmp	.L87
	.p2align 4,,10
.L98:
	movq	(%rax), %r8
	movq	%rax, %rdx
	testq	%r8, %r8
	je	.L97
.L91:
	movq	(%rdx), %rax
	cmpq	%rax, %rcx
	jne	.L98
	movq	(%rcx), %rax
	movq	%rax, (%rdx)
.L92:
	movq	$0, (%rcx)
	movl	$1, %eax
.L87:
	ret
	.p2align 4,,10
.L97:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L89:
	movq	(%rcx), %rax
	movq	%rax, 56+QUARKTS(%rip)
	jmp	.L92
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
	je	.L99
	movss	.LC0(%rip), %xmm0
	mulss	%xmm3, %xmm0
	movss	48+QUARKTS(%rip), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L107
	pxor	%xmm0, %xmm0
	movl	$1, %ebx
	ucomiss	%xmm0, %xmm3
	setp	%cl
	cmovne	%ebx, %ecx
	testb	%cl, %cl
	jne	.L99
.L107:
	xorl	%eax, %eax
	testq	%rdx, %rdx
	movl	%r8d, 44(%rsp)
	movq	%rdx, 32(%rsp)
	je	.L99
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
.L99:
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
	je	.L116
	cmpq	$0, 128(%rsp)
	je	.L116
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
	jne	.L120
.L116:
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L120:
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
	je	.L121
	testq	%rdx, %rdx
	movss	48+QUARKTS(%rip), %xmm0
	je	.L121
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
.L121:
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
	je	.L131
	testq	%rcx, %rcx
	je	.L131
	leal	-3(%r8), %r10d
	xorl	%eax, %eax
	cmpl	$3, %r10d
	ja	.L127
	cmpq	$0, (%rdx)
	je	.L127
	cmpl	$5, %r8d
	movl	%r9d, %eax
	je	.L129
	testb	%r9b, %r9b
	setne	%al
.L129:
	movl	%r8d, %r8d
	testb	%r9b, %r9b
	movb	%al, 56(%rcx,%r8)
	movl	$0, %eax
	cmove	%rax, %rdx
	movl	$1, %eax
	movq	%rdx, 64(%rcx)
.L127:
	ret
	.p2align 4,,10
.L131:
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
	je	.L139
	testq	%rdx, %rdx
	je	.L139
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
.L139:
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
	je	.L140
	movq	64(%rcx), %rax
	movq	%rdx, 32(%rcx)
	testq	%rax, %rax
	je	.L143
	call	*%rax
.L143:
	movq	(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L144
	movq	16(%rbx), %rax
	cmpq	%rax, %rsi
	setne	28(%rbx)
	je	.L145
	movq	%rax, 8(%rbx)
.L145:
	movq	%rbx, %rcx
	call	*%rsi
	cmpl	$-32768, %eax
	movl	%eax, 24(%rbx)
	movq	%rsi, 16(%rbx)
	je	.L147
	cmpl	$-32767, %eax
	je	.L148
	movq	56(%rbx), %rax
	testq	%rax, %rax
	je	.L140
.L166:
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L147:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	jne	.L166
.L140:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L144:
	movl	$-32767, 24(%rbx)
.L148:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L140
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
	ja	.L168
	movl	%edx, %eax
	leaq	.L170(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L170:
	.long	.L168-.L170
	.long	.L169-.L170
	.long	.L171-.L170
	.long	.L172-.L170
	.long	.L173-.L170
	.long	.L174-.L170
	.long	.L174-.L170
	.long	.L174-.L170
	.long	.L168-.L170
	.long	.L175-.L170
	.text
	.p2align 4,,10
.L169:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L176
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L202
.L176:
	movb	$0, 41+QUARKTS(%rip)
	movzwl	32(%rbx), %eax
.L184:
	movw	%ax, 32(%rbx)
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L178
	movzwl	32(%rbx), %eax
	subl	$1, %eax
	movw	%ax, 32(%rbx)
.L178:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	sete	%dl
	movb	%dl, 42+QUARKTS(%rip)
	jne	.L168
	movb	$0, 58(%rbx)
	.p2align 4,,10
.L168:
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
	je	.L181
	movq	48(%rbx), %rax
	cmpq	$1, %rax
	je	.L203
.L181:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L182
	movq	48(%rbx), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
.L182:
	cmpl	$4, %esi
	movq	$0, 112+QUARKTS(%rip)
	jne	.L183
	movq	64(%rbx), %rdx
	movzwl	14(%rdx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rdx)
.L183:
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
.L175:
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
.L171:
	movq	104+QUARKTS(%rip), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movq	$0, 104+QUARKTS(%rip)
	jmp	.L168
	.p2align 4,,10
.L172:
	movq	16(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movb	$0, 57(%rcx)
	jmp	.L168
	.p2align 4,,10
.L173:
	movq	64(%rcx), %rcx
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L201
	movzwl	12(%rcx), %r8d
	movzwl	14(%rcx), %edx
	cmpw	%dx, %r8w
	je	.L201
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
.L201:
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L168
	.p2align 4,,10
.L174:
	movq	64(%rcx), %rax
	jmp	.L201
	.p2align 4,,10
.L203:
	movq	72(%rbx), %rcx
	leaq	16+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L182
	.p2align 4,,10
.L202:
	movb	$1, 41+QUARKTS(%rip)
	movzwl	32(%rcx), %eax
	negl	%eax
	jmp	.L184
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
.L244:
	movzbl	80+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L313
.L205:
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	js	.L210
.L319:
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L211
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L211:
	movq	88+QUARKTS(%rip), %rax
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
	movzbl	96+QUARKTS(%rip), %eax
	cmpb	$1, %al
	jbe	.L248
	movq	88+QUARKTS(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L248
	xorl	%edx, %edx
	movl	$16, %eax
	movl	$1, %ecx
	jmp	.L213
	.p2align 4,,10
.L215:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%cl, %eax
	salq	$4, %rax
	addq	%rax, %r8
	movq	(%r8), %r8
	testq	%r8, %r8
	je	.L312
.L213:
	movq	88+QUARKTS(%rip), %r8
	addq	%rax, %r8
	movq	(%r8), %r8
	movzbl	40(%r8), %r8d
	cmpb	%r9b, %r8b
	jbe	.L214
	movq	88+QUARKTS(%rip), %rdx
	addq	%rdx, %rax
	movl	%ecx, %edx
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
.L214:
	movzbl	96+QUARKTS(%rip), %eax
	addl	$1, %ecx
	cmpb	%al, %cl
	jb	.L215
.L312:
	movzbl	%dl, %eax
	movzbl	%dl, %r8d
	salq	$4, %rax
.L212:
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
	jge	.L216
	.p2align 4,,10
.L217:
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
	jl	.L217
.L216:
	movzwl	98+QUARKTS(%rip), %eax
	subl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L218
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L218:
	movq	%rdi, %rcx
	movl	$2, %edx
	call	_qScheduler_Dispatch
	movb	%al, 80(%rdi)
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L243
.L246:
	xorl	%r8d, %r8d
	jmp	.L236
	.p2align 4,,10
.L221:
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jle	.L223
.L222:
	movl	24(%rcx), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm6, %xmm0
	jp	.L255
	je	.L224
.L255:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	28(%rcx), %r9d
	movl	24(%rcx), %edx
	subl	%r9d, %eax
	cmpl	%edx, %eax
	jnb	.L224
.L220:
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L229
	movzbl	60(%rcx), %eax
	testb	%al, %al
	je	.L230
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L250
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %r10d
	movzwl	10(%rax), %r9d
	movl	%edx, %eax
	subl	%r10d, %eax
	cmpw	%r9w, %ax
	je	.L250
.L230:
	movzbl	61(%rcx), %eax
	testb	%al, %al
	je	.L232
	movq	64(%rcx), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L233
	movzwl	12(%rdx), %eax
	movzwl	14(%rdx), %edx
	subl	%edx, %eax
.L233:
	movzbl	61(%rcx), %edx
	cmpw	%ax, %dx
	jbe	.L252
.L232:
	movzbl	59(%rcx), %eax
	testb	%al, %al
	je	.L234
	movq	64(%rcx), %r9
	testq	%r9, %r9
	je	.L234
	movzwl	12(%r9), %edx
	movzwl	14(%r9), %eax
	cmpw	%ax, %dx
	je	.L234
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
	jne	.L231
	.p2align 4,,10
.L234:
	movzbl	62(%rcx), %eax
	testb	%al, %al
	je	.L229
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L254
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %eax
	cmpw	%ax, %dx
	je	.L254
.L229:
	movzbl	57(%rcx), %eax
	testb	%al, %al
	jne	.L314
	movb	$3, 80(%rcx)
.L228:
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L315
.L236:
	movzbl	58(%rcx), %eax
	testb	%al, %al
	je	.L220
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jns	.L221
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L221
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L222
.L223:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	jne	.L220
	jmp	.L222
	.p2align 4,,10
.L224:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	$1, %r8d
	movl	%eax, 28(%rcx)
	movb	$1, 80(%rcx)
	movl	$1, 84(%rcx)
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L236
.L315:
	testb	%r8b, %r8b
	jne	.L316
	testq	%rdi, %rdi
	je	.L219
.L243:
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L244
.L317:
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
	je	.L245
	movq	8+QUARKTS(%rip), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
	nop
.L245:
	movaps	64(%rsp), %xmm6
	movb	$1, 81+QUARKTS(%rip)
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L252:
	movl	$6, %edx
.L231:
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L228
	.p2align 4,,10
.L314:
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	$3, 84(%rcx)
	jmp	.L228
	.p2align 4,,10
.L219:
	movq	(%rsi), %rax
	testq	%rax, %rax
	je	.L243
	xorl	%ecx, %ecx
	movl	$9, %edx
	call	_qScheduler_Dispatch
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L244
	jmp	.L317
	.p2align 4,,10
.L250:
	movl	$5, %edx
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L228
	.p2align 4,,10
.L316:
	movq	ChainIterator.3321(%rip), %rdi
	jmp	.L238
	.p2align 4,,10
.L239:
	testq	%rdi, %rdi
	je	.L240
.L318:
	movq	(%rdi), %rdx
	movzbl	80(%rdi), %eax
	movq	%rdx, ChainIterator.3321(%rip)
	cmpb	$1, %al
	je	.L241
	xorl	%eax, %eax
.L242:
	movb	%al, 80(%rdi)
	movq	%rdx, %rdi
.L238:
	cmpq	%rbx, %rdi
	jne	.L239
	movq	56+QUARKTS(%rip), %rdi
	testq	%rdi, %rdi
	movq	%rdi, ChainIterator.3321(%rip)
	jne	.L318
.L240:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3321(%rip)
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L244
	jmp	.L317
	.p2align 4,,10
.L241:
	movl	84(%rdi), %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movq	ChainIterator.3321(%rip), %rdx
	jmp	.L242
	.p2align 4,,10
.L313:
	movq	64+QUARKTS(%rip), %rax
	movq	$0, 56(%rsp)
	movq	56+QUARKTS(%rip), %rdx
	testq	%rax, %rax
	je	.L206
	movq	%rdx, 40(%rsp)
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movq	40(%rsp), %rdx
	movl	%eax, 84+QUARKTS(%rip)
.L206:
	testq	%rdx, %rdx
	je	.L207
	leaq	56(%rsp), %r11
	.p2align 4,,10
.L208:
	movq	(%rdx), %r10
	movq	%r11, %rcx
	call	_qScheduler_PriorizedInsert
	testq	%r10, %r10
	movq	%r10, %rdx
	jne	.L208
.L207:
	movq	56(%rsp), %rax
	movb	$1, 80+QUARKTS(%rip)
	movq	%rax, 56+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L205
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	jns	.L319
.L210:
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L219
	xorl	%edi, %edi
	jmp	.L246
	.p2align 4,,10
.L254:
	movl	$7, %edx
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L228
	.p2align 4,,10
.L248:
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L212
	.seh_endproc
	.p2align 4,,15
	.globl	qStateMachine_Attribute
	.def	qStateMachine_Attribute;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Attribute
qStateMachine_Attribute:
	.seh_endprologue
	cmpl	$5, %edx
	ja	.L320
	leaq	.L323(%rip), %r9
	movl	%edx, %edx
	movslq	(%r9,%rdx,4), %rax
	addq	%r9, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L323:
	.long	.L322-.L323
	.long	.L324-.L323
	.long	.L325-.L323
	.long	.L326-.L323
	.long	.L327-.L323
	.long	.L328-.L323
	.text
	.p2align 4,,10
.L328:
	movq	%r8, 64(%rcx)
.L320:
	ret
	.p2align 4,,10
.L327:
	movq	%r8, 56(%rcx)
	ret
	.p2align 4,,10
.L322:
	movq	%r8, (%rcx)
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	ret
	.p2align 4,,10
.L324:
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	ret
	.p2align 4,,10
.L325:
	movq	%r8, 40(%rcx)
	ret
	.p2align 4,,10
.L326:
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
	je	.L329
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	ja	.L329
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movb	$1, (%rcx)
	movl	%eax, 4(%rcx)
	movl	$1, %eax
.L329:
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
	je	.L334
	cmpb	$0, (%rcx)
	jne	.L341
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	jbe	.L342
.L334:
	ret
	.p2align 4,,10
.L341:
	movl	_qSysTick_Epochs_(%rip), %edx
	subl	4(%rcx), %edx
	cmpl	8(%rcx), %edx
	jb	.L334
	movl	$1, %eax
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
	ret
	.p2align 4,,10
.L342:
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
	je	.L343
	cmpb	$0, (%rcx)
	je	.L343
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	setnb	%al
.L343:
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
	je	.L348
	cmpb	$0, (%rcx)
	je	.L348
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
.L348:
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
	je	.L353
	cmpb	$0, (%rcx)
	movl	8(%rcx), %eax
	jne	.L362
.L353:
	ret
	.p2align 4,,10
.L362:
	testl	%eax, %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %ecx
	je	.L353
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
	je	.L363
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L363:
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
	je	.L368
	movzbl	(%rcx), %eax
.L368:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerChangeTime
	.def	qSTimerChangeTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerChangeTime
qSTimerChangeTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L372
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
.L372:
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
	je	.L381
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L381:
	movzbl	2(%r14), %ebx
	xorl	%r12d, %r12d
.L392:
	cmpb	%r12b, %bl
	jbe	.L391
	movq	8(%r14), %rdi
	movzbl	%r12b, %eax
	movzwl	(%r14), %r11d
	leaq	(%rdi,%rax), %rdx
	movzwl	%r11w, %r8d
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L393
	cmpw	%si, %r11w
	jnb	.L414
.L412:
	leal	1(%r12), %eax
	movl	%r11d, %r8d
	movl	$1, %r9d
	movzbl	%al, %eax
	jmp	.L386
	.p2align 4,,10
.L390:
	movzbl	(%rdi,%rax), %r10d
	testb	%r10b, %r10b
	jne	.L415
	addl	%r11d, %r8d
	leaq	1(%rax), %r10
	cmpw	%si, %r8w
	jnb	.L394
	movq	%r10, %rax
.L386:
	addl	$1, %r9d
	cmpb	%al, %bl
	movl	%eax, %ebp
	ja	.L390
.L384:
	cmpb	%bpl, %bl
	jne	.L392
.L391:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L397
	movq	72+QUARKTS(%rip), %rax
	xorl	%r13d, %r13d
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	jmp	.L380
	.p2align 4,,10
.L393:
	movzbl	%cl, %eax
	addl	%ecx, %r12d
	imull	%r8d, %eax
	cltq
	addq	%rax, %r13
	cmpb	%r12b, %bl
	jbe	.L416
	movzbl	%r12b, %eax
	leaq	(%rdi,%rax), %rdx
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L393
	cmpw	%si, %r11w
	jb	.L412
.L414:
	movl	$1, %r9d
	.p2align 4,,10
.L394:
	testw	%r15w, %r15w
	movb	%r9b, (%rdx)
	je	.L387
	addq	%r13, %rax
	xorl	%edx, %edx
	.p2align 4,,10
.L388:
	addl	$1, %edx
	movzbl	%dl, %ecx
	cmpw	%si, %cx
	jb	.L388
	movb	$0, (%rax)
.L387:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L380
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L380:
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
.L415:
	leal	(%r10,%rbp), %r12d
	movzbl	%r12b, %r13d
	imull	%r11d, %r13d
	movslq	%r13d, %r13
	addq	16(%r14), %r13
	cmpb	%bpl, %bl
	jne	.L392
	jmp	.L391
.L416:
	movl	%r12d, %ebp
	jmp	.L384
.L397:
	xorl	%r13d, %r13d
	jmp	.L380
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
	je	.L417
	testq	%rdx, %rdx
	je	.L417
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L421
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L421:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L422
	cmpq	%r8, %rbx
	je	.L440
	movzwl	(%rsi), %ecx
	xorl	%eax, %eax
	jmp	.L425
	.p2align 4,,10
.L426:
	cmpq	%r8, %rbx
	je	.L441
.L425:
	addl	$1, %eax
	addq	%rcx, %r8
	cmpb	%dl, %al
	jne	.L426
.L422:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L417
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L417:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L441:
	movzbl	%al, %eax
.L423:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	jmp	.L422
	.p2align 4,,10
.L440:
	xorl	%eax, %eax
	jmp	.L423
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
	je	.L442
	testq	%rdx, %rdx
	je	.L442
	xorl	%ecx, %ecx
	movq	%rdx, (%r10)
	movzwl	%r9w, %edx
	movw	%cx, 12(%r10)
	leal	-1(%rdx), %ecx
	xorl	%r11d, %r11d
	movw	%r11w, 14(%r10)
	movw	%r8w, 8(%r10)
	testl	%edx, %ecx
	jne	.L450
	movw	%ax, 10(%r10)
.L442:
	ret
	.p2align 4,,10
.L450:
	subl	$1, %r9d
	movl	$4, %edx
	movl	$1, %ecx
.L445:
	movzwl	%r9w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r9d
	subl	$1, %edx
	jne	.L445
	movzwl	%r9w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 10(%r10)
	jmp	.L442
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	movl	$1, %eax
	testq	%rcx, %rcx
	je	.L451
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L451:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L458
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L458
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
.L458:
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
	je	.L459
	movzwl	12(%rbx), %r8d
	movzwl	14(%rbx), %edx
	cmpw	%dx, %r8w
	je	.L459
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
.L459:
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
	je	.L468
	testq	%rcx, %rcx
	je	.L468
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r8d
	subl	%eax, %edx
	xorl	%eax, %eax
	cmpw	%r8w, %dx
	je	.L464
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
	je	.L466
	xorl	%eax, %eax
	.p2align 4,,10
.L467:
	movzwl	%ax, %r8d
	addl	$1, %eax
	leaq	(%r9,%r8), %rdx
	movzbl	(%r10,%r8), %r8d
	addq	%r11, %rdx
	movb	%r8b, (%rdx)
	movzwl	8(%rcx), %edx
	cmpw	%ax, %dx
	ja	.L467
.L466:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
.L464:
	ret
	.p2align 4,,10
.L468:
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
	je	.L480
	xorl	%r9d, %r9d
	.p2align 4,,10
.L482:
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
	jb	.L482
.L480:
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
	je	.L488
	xorl	%ebx, %ebx
	.p2align 4,,10
.L491:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	movsbl	(%r12,%rbx), %edx
	cmove	%rsi, %rcx
	addq	$1, %rbx
	call	*%rbp
	cmpq	%rdi, %rbx
	jne	.L491
.L488:
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
	je	.L497
	xorl	%ebx, %ebx
	.p2align 4,,10
.L500:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	cmove	%rsi, %rcx
	call	*%rbp
	movb	%al, (%r12,%rbx)
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	jne	.L500
.L497:
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
	je	.L506
	xorl	%edi, %edi
	.p2align 4,,10
.L509:
	addq	$1, %rbx
	testb	%r12b, %r12b
	movq	%rsi, %rcx
	je	.L508
	leaq	(%rsi,%rdi), %rcx
	addq	$1, %rdi
.L508:
	call	*%rbp
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L509
.L506:
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
	je	.L517
	movzwl	%r9w, %r9d
	movq	%r8, %rbp
	leal	-1(%r9), %eax
	leaq	1(%r8,%rax), %rdi
	.p2align 4,,10
.L520:
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
	jne	.L520
.L517:
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
	js	.L523
	movslq	%r8d, %rdx
	movl	%r8d, %r8d
	leaq	-1(%rax,%rdx), %r11
	leaq	(%rax,%rdx), %r10
	subq	%r8, %r11
	.p2align 4,,10
.L525:
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
	jne	.L525
.L523:
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
.L528:
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	ja	.L527
.L540:
	testb	%bl, %bl
	je	.L527
	call	__locale_ctype_ptr
	movsbl	%bl, %ecx
	addq	$1, %rsi
	call	toupper
	movzbl	%al, %r13d
	movl	%eax, %ebx
	call	__locale_ctype_ptr
	testb	$68, 1(%rax,%r13)
	je	.L529
	leal	-48(%rbx), %edx
	addl	$1, %edi
	cmpb	$9, %dl
	jbe	.L530
	leal	-65(%rbx), %eax
	movl	%r13d, %edx
	subl	$55, %ebx
	cmpb	$6, %al
	cmovb	%ebx, %edx
.L530:
	movl	%edx, %ebx
	sall	$4, %ebp
	andl	$15, %ebx
	orl	%ebx, %ebp
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	jbe	.L540
.L527:
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
.L529:
	call	__locale_ctype_ptr
	testb	$8, 1(%rax,%r13)
	jne	.L528
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
.L542:
	call	__locale_ctype_ptr
	movsbq	(%rbx,%rsi), %rcx
	movl	%esi, %edi
	addq	$1, %rsi
	testb	$8, 1(%rax,%rcx)
	jne	.L542
	cmpb	$45, %cl
	je	.L550
	cmpb	$43, %cl
	movl	$1, %esi
	je	.L543
.L544:
	movslq	%edi, %rdi
	pxor	%xmm6, %xmm6
	movsd	.LC5(%rip), %xmm7
	jmp	.L545
	.p2align 4,,10
.L546:
	pxor	%xmm0, %xmm0
	subl	$48, %edx
	movapd	%xmm6, %xmm1
	cvtsi2sd	%edx, %xmm0
	mulsd	%xmm7, %xmm1
	movapd	%xmm0, %xmm6
	addsd	%xmm1, %xmm6
.L545:
	call	__locale_ctype_ptr
	movsbl	(%rbx,%rdi), %edx
	movl	%edi, %ebp
	addq	$1, %rdi
	movsbq	%dl, %rcx
	testb	$4, 1(%rax,%rcx)
	jne	.L546
	xorl	%eax, %eax
	cmpb	$46, %dl
	sete	%al
	movsd	.LC4(%rip), %xmm7
	addl	%eax, %ebp
	movsd	.LC5(%rip), %xmm8
	movslq	%ebp, %rbp
	addq	%rbp, %rbx
	jmp	.L548
	.p2align 4,,10
.L549:
	pxor	%xmm1, %xmm1
	subl	$48, %edx
	movapd	%xmm6, %xmm0
	mulsd	%xmm8, %xmm7
	cvtsi2sd	%edx, %xmm1
	mulsd	%xmm8, %xmm0
	addsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm6
.L548:
	call	__locale_ctype_ptr
	movsbl	(%rbx), %edx
	addq	$1, %rbx
	movsbq	%dl, %rcx
	testb	$4, 1(%rax,%rcx)
	jne	.L549
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
.L550:
	movl	$-1, %esi
.L543:
	addl	$1, %edi
	jmp	.L544
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
	jmp	.L554
	.p2align 4,,10
.L555:
	addq	$1, %rbx
.L554:
	call	__locale_ctype_ptr
	movsbq	(%rbx), %rcx
	testb	$8, 1(%rax,%rcx)
	movq	%rcx, %rdx
	jne	.L555
	cmpb	$45, %cl
	je	.L569
	cmpb	$43, %cl
	movl	$1, %r8d
	je	.L570
.L557:
	testb	%dl, %dl
	je	.L565
	leal	-48(%rdx), %eax
	cmpb	$9, %al
	movl	$0, %eax
	jbe	.L558
	jmp	.L553
	.p2align 4,,10
.L560:
	leal	-48(%rdx), %ecx
	cmpb	$9, %cl
	ja	.L568
.L558:
	leal	(%rax,%rax,4), %ecx
	addq	$1, %rbx
	leal	-48(%rdx,%rcx,2), %eax
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L560
.L568:
	imull	%r8d, %eax
.L553:
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L570:
	movsbl	1(%rbx), %edx
	addq	$1, %rbx
	jmp	.L557
	.p2align 4,,10
.L569:
	movsbl	1(%rbx), %edx
	movl	$-1, %r8d
	addq	$1, %rbx
	jmp	.L557
	.p2align 4,,10
.L565:
	xorl	%eax, %eax
	jmp	.L553
	.seh_endproc
	.p2align 4,,15
	.globl	qUtoA
	.def	qUtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qUtoA
qUtoA:
	.seh_endprologue
	testq	%rdx, %rdx
	movl	%ecx, %eax
	movq	%rdx, %r11
	je	.L574
	testl	%ecx, %ecx
	je	.L587
	movzbl	%r8b, %r8d
	xorl	%r9d, %r9d
	jmp	.L577
	.p2align 4,,10
.L579:
	movl	%ecx, %r9d
.L577:
	xorl	%edx, %edx
	divl	%r8d
	leal	48(%rdx), %r10d
	leal	55(%rdx), %ecx
	cmpl	$10, %edx
	cmovb	%r10d, %ecx
	movzwl	%r9w, %r10d
	testl	%eax, %eax
	movl	%ecx, %edx
	leal	1(%r9), %ecx
	movb	%dl, (%r11,%r10)
	jne	.L579
	movzwl	%cx, %ecx
	testw	%r9w, %r9w
	movb	$0, (%r11,%rcx)
	je	.L574
	xorl	%edx, %edx
	jmp	.L578
	.p2align 4,,10
.L588:
	movzwl	%r9w, %r10d
.L578:
	movzwl	%dx, %eax
	addq	%r11, %r10
	addl	$1, %edx
	addq	%r11, %rax
	movzbl	(%r10), %r8d
	subl	$1, %r9d
	movzbl	(%rax), %ecx
	cmpw	%r9w, %dx
	movb	%r8b, (%rax)
	movb	%cl, (%r10)
	jb	.L588
.L574:
	movq	%r11, %rax
	ret
	.p2align 4,,10
.L587:
	movl	$48, %eax
	movw	%ax, (%rdx)
	movq	%r11, %rax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qItoA
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qItoA
qItoA:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testq	%rdx, %rdx
	movl	%ecx, %eax
	movq	%rdx, %r10
	je	.L592
	testl	%ecx, %ecx
	je	.L613
	movl	$0, %ebx
	jns	.L593
	cmpb	$10, %r8b
	sete	%bl
	negl	%eax
.L593:
	movzbl	%r8b, %r8d
	xorl	%ecx, %ecx
	jmp	.L596
	.p2align 4,,10
.L601:
	movl	%r9d, %ecx
.L596:
	cltd
	idivl	%r8d
	leal	55(%rdx), %r11d
	leal	48(%rdx), %r9d
	cmpl	$10, %edx
	movl	%r11d, %edx
	movzbl	%cl, %r11d
	cmovl	%r9d, %edx
	testl	%eax, %eax
	leal	1(%rcx), %r9d
	movb	%dl, (%r10,%r11)
	jne	.L601
	movzbl	%r9b, %eax
	addq	%r10, %rax
	testb	%bl, %bl
	jne	.L614
.L598:
	movb	$0, (%rax)
	movzbl	%r9b, %eax
	subw	$1, %ax
	je	.L592
	xorl	%r8d, %r8d
	.p2align 4,,10
.L599:
	movzwl	%r8w, %ecx
	movzwl	%ax, %edx
	addl	$1, %r8d
	addq	%r10, %rcx
	addq	%r10, %rdx
	subl	$1, %eax
	movzbl	(%rcx), %r9d
	movzbl	(%rdx), %r11d
	cmpw	%ax, %r8w
	movb	%r11b, (%rcx)
	movb	%r9b, (%rdx)
	jb	.L599
.L592:
	movq	%r10, %rax
	popq	%rbx
	ret
	.p2align 4,,10
.L613:
	movl	$48, %eax
	movw	%ax, (%rdx)
	movq	%r10, %rax
	popq	%rbx
	ret
	.p2align 4,,10
.L614:
	leal	2(%rcx), %r9d
	movb	$45, (%rax)
	movzbl	%r9b, %eax
	addq	%r10, %rax
	jmp	.L598
	.seh_endproc
	.p2align 4,,15
	.globl	qBtoA
	.def	qBtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qBtoA
qBtoA:
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %rax
	je	.L616
	testb	%cl, %cl
	jne	.L621
	movl	$1936482662, (%rdx)
	movl	$101, %edx
	movw	%dx, 4(%rax)
.L616:
	ret
	.p2align 4,,10
.L621:
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
	je	.L625
	ret
	.p2align 4,,10
.L625:
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
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %rcx
	je	.L646
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L629
	je	.L654
.L629:
	movd	%xmm0, %edx
	movd	%xmm0, %eax
	andl	$2147483647, %edx
	cmpl	$2139095040, %edx
	jne	.L655
	movl	$1718511915, (%rcx)
	movb	$0, 4(%rcx)
.L646:
	movq	%rcx, %rax
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L654:
	movq	%rcx, %rax
	movl	$3157552, (%rdx)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L655:
	movd	%xmm0, %edx
	andl	$2139095040, %edx
	cmpl	$2139095040, %edx
	je	.L656
.L633:
	ucomiss	%xmm0, %xmm1
	leaq	1(%rcx), %r10
	movq	%rcx, %r11
	ja	.L657
.L641:
	cvttss2si	%xmm0, %ebx
	testl	%ebx, %ebx
	jne	.L642
	movb	$48, (%r11)
.L636:
	testb	%r8b, %r8b
	je	.L638
	pxor	%xmm1, %xmm1
	cmpb	$10, %r8b
	movl	$10, %r9d
	cmovbe	%r8d, %r9d
	leaq	1(%r10), %r11
	movb	$46, (%r10)
	subl	$1, %r9d
	movss	.LC7(%rip), %xmm2
	cvtsi2ss	%ebx, %xmm1
	movzbl	%r9b, %r9d
	movq	%r11, %rdx
	leaq	2(%r10,%r9), %r10
	subss	%xmm1, %xmm0
	.p2align 4,,10
.L639:
	mulss	%xmm2, %xmm0
	addq	$1, %rdx
	pxor	%xmm1, %xmm1
	cmpq	%r10, %rdx
	cvttss2si	%xmm0, %eax
	leal	48(%rax), %r8d
	movsbl	%al, %eax
	cvtsi2ss	%eax, %xmm1
	movb	%r8b, -1(%rdx)
	subss	%xmm1, %xmm0
	jne	.L639
	leaq	1(%r11,%r9), %r10
.L638:
	movq	%rcx, %rax
	movb	$0, (%r10)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L656:
	testl	$8388607, %eax
	je	.L633
	movl	$7233902, (%rcx)
	jmp	.L646
	.p2align 4,,10
.L642:
	movl	%ebx, %r9d
	movq	%r11, %r10
	movl	$1717986919, %esi
	.p2align 4,,10
.L635:
	movl	%r9d, %eax
	addq	$1, %r10
	imull	%esi
	movl	%r9d, %eax
	sarl	$31, %eax
	sarl	$2, %edx
	subl	%eax, %edx
	leal	(%rdx,%rdx,4), %eax
	addl	%eax, %eax
	subl	%eax, %r9d
	addl	$48, %r9d
	testl	%edx, %edx
	movb	%r9b, -1(%r10)
	movl	%edx, %r9d
	jne	.L635
	movq	%r10, %r9
	subq	%r11, %r9
	subw	$1, %r9w
	je	.L636
	xorl	%esi, %esi
	.p2align 4,,10
.L637:
	movzwl	%si, %edx
	movzwl	%r9w, %eax
	addl	$1, %esi
	addq	%r11, %rdx
	addq	%r11, %rax
	subl	$1, %r9d
	movzbl	(%rdx), %edi
	movzbl	(%rax), %r14d
	cmpw	%r9w, %si
	movb	%r14b, (%rdx)
	movb	%dil, (%rax)
	jb	.L637
	jmp	.L636
	.p2align 4,,10
.L657:
	movq	%r10, %r11
	xorps	.LC6(%rip), %xmm0
	movb	$45, (%rcx)
	leaq	2(%rcx), %r10
	jmp	.L641
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferInit
	.def	qISR_ByteBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferInit
qISR_ByteBufferInit:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L660
	cmpw	$1, %r8w
	jbe	.L660
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
.L660:
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
	jne	.L667
	movq	16(%rcx), %rax
	testq	%rax, %rax
	je	.L668
	movq	16(%rcx), %rax
	movsbl	%dl, %ecx
	call	*%rax
	testb	%al, %al
	je	.L667
.L668:
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L673
	movq	24(%rbx), %rax
	movsbl	%sil, %ecx
	call	*%rax
.L666:
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
	jb	.L669
	xorl	%edx, %edx
	movw	%dx, 8(%rbx)
.L669:
	movzbl	32(%rbx), %eax
	cmpb	%sil, %al
	je	.L674
.L667:
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L674:
	xorl	%eax, %eax
	movb	$1, 10(%rbx)
	movw	%ax, 8(%rbx)
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L673:
	movl	%esi, %eax
	jmp	.L666
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
	je	.L675
	movzwl	8(%rbx), %r8d
	movq	(%rbx), %rdx
	call	memcpy
	movb	$0, 10(%rbx)
	movl	$1, %eax
.L675:
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
	je	.L679
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	subl	%edx, %eax
	cltq
.L679:
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
	je	.L683
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %ecx
	subl	%edx, %eax
	cltq
	cmpq	%rax, %rcx
	sete	%al
.L683:
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
	je	.L687
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L687:
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
	je	.L691
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
.L691:
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
	je	.L695
	movzwl	(%rcx), %r9d
	movzwl	2(%rcx), %edx
	cmpw	%dx, %r9w
	je	.L695
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
.L695:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Read
	.def	qBSBuffer_Read;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Read
qBSBuffer_Read:
	.seh_endprologue
	testw	%r8w, %r8w
	je	.L703
	testq	%rcx, %rcx
	je	.L703
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %r9d
	cmpw	%ax, %r9w
	je	.L703
	subl	$1, %r8d
	movq	%rdx, %r9
	movzwl	%r8w, %r8d
	addq	%rdx, %r8
	.p2align 4,,10
.L704:
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
	je	.L710
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	addq	$1, %r9
	cmpw	%ax, %dx
	jne	.L704
.L703:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L710:
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
	je	.L711
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %r8d
	movzwl	16(%rcx), %r9d
	subl	%r8d, %edx
	movslq	%edx, %rdx
	movzwl	%r9w, %r8d
	cmpq	%r8, %rdx
	je	.L711
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
.L711:
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
	je	.L716
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, (%r9)
	leal	-1(%rdx), %ecx
	xorl	%r10d, %r10d
	movw	%r10w, 2(%r9)
	testl	%edx, %ecx
	jne	.L727
	movw	%ax, 16(%r9)
.L716:
	ret
	.p2align 4,,10
.L727:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L719:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L719
	movzwl	%r8w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%r9)
	jmp	.L716
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
	jne	.L730
	cmpq	$0, (%rcx)
	je	.L734
.L730:
	movzbl	12(%rcx), %edx
	xorl	%eax, %eax
	testb	%dl, %dl
	je	.L729
	xorl	%eax, %eax
	xorl	%edx, %edx
	movq	$0, (%rcx)
	movw	%ax, 8(%rcx)
	movw	%dx, 10(%rcx)
	movl	$1, %eax
	movb	$0, 12(%rcx)
.L729:
	ret
	.p2align 4,,10
.L734:
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
	je	.L735
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L735
	movzwl	10(%rcx), %eax
	cmpb	%dl, (%r8,%rax)
	je	.L744
.L738:
	movzbl	12(%rcx), %eax
.L735:
	ret
	.p2align 4,,10
.L744:
	movzwl	10(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 10(%rcx)
	movzwl	10(%rcx), %eax
	cmpw	8(%rcx), %ax
	jne	.L738
	movb	$1, 12(%rcx)
	jmp	.L738
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
	je	.L745
	movsbl	(%rcx), %edx
	testb	%dl, %dl
	je	.L747
	.p2align 4,,10
.L748:
	addq	$1, %r14
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%r14), %edx
	testb	%dl, %dl
	jne	.L748
	movq	__qDebugOutputFcn(%rip), %rbx
.L747:
	testq	%r13, %r13
	je	.L749
	movl	$64, %edx
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	0(%r13), %edx
	movq	__qDebugOutputFcn(%rip), %rbx
	testb	%dl, %dl
	je	.L750
	.p2align 4,,10
.L751:
	addq	$1, %r13
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	0(%r13), %edx
	testb	%dl, %dl
	jne	.L751
	movq	__qDebugOutputFcn(%rip), %rbx
.L750:
	movl	$32, %edx
	xorl	%ecx, %ecx
	call	*%rbx
	movq	__qDebugOutputFcn(%rip), %rbx
.L749:
	movsbl	(%rsi), %edx
	testb	%dl, %dl
	je	.L752
	.p2align 4,,10
.L753:
	addq	$1, %rsi
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%rsi), %edx
	testb	%dl, %dl
	jne	.L753
	movq	__qDebugOutputFcn(%rip), %rbx
.L752:
	testq	%rdi, %rdi
	je	.L776
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	je	.L755
	.p2align 4,,10
.L756:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L756
	movq	__qDebugOutputFcn(%rip), %rbx
.L755:
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
.L745:
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
.L776:
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
ChainIterator.3321:
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
