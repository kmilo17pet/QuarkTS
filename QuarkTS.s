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
	movq	ChainIterator.3296(%rip), %rdi
	jmp	.L238
	.p2align 4,,10
.L239:
	testq	%rdi, %rdi
	je	.L240
.L318:
	movq	(%rdi), %rdx
	movzbl	80(%rdi), %eax
	movq	%rdx, ChainIterator.3296(%rip)
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
	movq	%rdi, ChainIterator.3296(%rip)
	jne	.L318
.L240:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3296(%rip)
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L244
	jmp	.L317
	.p2align 4,,10
.L241:
	movl	84(%rdi), %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movq	ChainIterator.3296(%rip), %rdx
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
	je	.L352
	movl	8(%rcx), %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %r8d
	testl	%eax, %eax
	je	.L352
	subl	%r8d, %edx
	movl	%eax, %ecx
	subl	%edx, %ecx
	cmpl	%edx, %eax
	cmovnb	%ecx, %eax
.L352:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L358
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L358:
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
	je	.L364
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L364:
	movzbl	2(%r14), %ebx
	xorl	%r12d, %r12d
.L375:
	cmpb	%r12b, %bl
	jbe	.L374
	movq	8(%r14), %rdi
	movzbl	%r12b, %eax
	movzwl	(%r14), %r11d
	leaq	(%rdi,%rax), %rdx
	movzwl	%r11w, %r8d
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L376
	cmpw	%si, %r11w
	jnb	.L397
.L395:
	leal	1(%r12), %eax
	movl	%r11d, %r8d
	movl	$1, %r9d
	movzbl	%al, %eax
	jmp	.L369
	.p2align 4,,10
.L373:
	movzbl	(%rdi,%rax), %r10d
	testb	%r10b, %r10b
	jne	.L398
	addl	%r11d, %r8d
	leaq	1(%rax), %r10
	cmpw	%si, %r8w
	jnb	.L377
	movq	%r10, %rax
.L369:
	addl	$1, %r9d
	cmpb	%al, %bl
	movl	%eax, %ebp
	ja	.L373
.L367:
	cmpb	%bpl, %bl
	jne	.L375
.L374:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L380
	movq	72+QUARKTS(%rip), %rax
	xorl	%r13d, %r13d
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	jmp	.L363
	.p2align 4,,10
.L376:
	movzbl	%cl, %eax
	addl	%ecx, %r12d
	imull	%r8d, %eax
	cltq
	addq	%rax, %r13
	cmpb	%r12b, %bl
	jbe	.L399
	movzbl	%r12b, %eax
	leaq	(%rdi,%rax), %rdx
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L376
	cmpw	%si, %r11w
	jb	.L395
.L397:
	movl	$1, %r9d
	.p2align 4,,10
.L377:
	testw	%r15w, %r15w
	movb	%r9b, (%rdx)
	je	.L370
	addq	%r13, %rax
	xorl	%edx, %edx
	.p2align 4,,10
.L371:
	addl	$1, %edx
	movzbl	%dl, %ecx
	cmpw	%si, %cx
	jb	.L371
	movb	$0, (%rax)
.L370:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L363
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L363:
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
.L398:
	leal	(%r10,%rbp), %r12d
	movzbl	%r12b, %r13d
	imull	%r11d, %r13d
	movslq	%r13d, %r13
	addq	16(%r14), %r13
	cmpb	%bpl, %bl
	jne	.L375
	jmp	.L374
.L399:
	movl	%r12d, %ebp
	jmp	.L367
.L380:
	xorl	%r13d, %r13d
	jmp	.L363
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
	je	.L400
	testq	%rdx, %rdx
	je	.L400
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L404
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L404:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L405
	cmpq	%r8, %rbx
	je	.L423
	movzwl	(%rsi), %ecx
	xorl	%eax, %eax
	jmp	.L408
	.p2align 4,,10
.L409:
	cmpq	%r8, %rbx
	je	.L424
.L408:
	addl	$1, %eax
	addq	%rcx, %r8
	cmpb	%dl, %al
	jne	.L409
.L405:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L400
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L400:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L424:
	movzbl	%al, %eax
.L406:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	jmp	.L405
	.p2align 4,,10
.L423:
	xorl	%eax, %eax
	jmp	.L406
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
	je	.L425
	testq	%rdx, %rdx
	je	.L425
	xorl	%ecx, %ecx
	movq	%rdx, (%r10)
	movzwl	%r9w, %edx
	movw	%cx, 12(%r10)
	leal	-1(%rdx), %ecx
	xorl	%r11d, %r11d
	movw	%r11w, 14(%r10)
	movw	%r8w, 8(%r10)
	testl	%edx, %ecx
	jne	.L433
	movw	%ax, 10(%r10)
.L425:
	ret
	.p2align 4,,10
.L433:
	subl	$1, %r9d
	movl	$4, %edx
	movl	$1, %ecx
.L428:
	movzwl	%r9w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r9d
	subl	$1, %edx
	jne	.L428
	movzwl	%r9w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 10(%r10)
	jmp	.L425
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	movl	$1, %eax
	testq	%rcx, %rcx
	je	.L434
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L434:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L441
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L441
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
.L441:
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
	je	.L442
	movzwl	12(%rbx), %r8d
	movzwl	14(%rbx), %edx
	cmpw	%dx, %r8w
	je	.L442
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
.L442:
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
	je	.L451
	testq	%rcx, %rcx
	je	.L451
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r8d
	subl	%eax, %edx
	xorl	%eax, %eax
	cmpw	%r8w, %dx
	je	.L447
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
	je	.L449
	xorl	%eax, %eax
	.p2align 4,,10
.L450:
	movzwl	%ax, %r8d
	addl	$1, %eax
	leaq	(%r9,%r8), %rdx
	movzbl	(%r10,%r8), %r8d
	addq	%r11, %rdx
	movb	%r8b, (%rdx)
	movzwl	8(%rcx), %edx
	cmpw	%ax, %dx
	ja	.L450
.L449:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
.L447:
	ret
	.p2align 4,,10
.L451:
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
	je	.L463
	xorl	%r9d, %r9d
	.p2align 4,,10
.L465:
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
	jb	.L465
.L463:
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
	je	.L471
	xorl	%ebx, %ebx
	.p2align 4,,10
.L474:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	movsbl	(%r12,%rbx), %edx
	cmove	%rsi, %rcx
	addq	$1, %rbx
	call	*%rbp
	cmpq	%rdi, %rbx
	jne	.L474
.L471:
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
	je	.L480
	xorl	%ebx, %ebx
	.p2align 4,,10
.L483:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	cmove	%rsi, %rcx
	call	*%rbp
	movb	%al, (%r12,%rbx)
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	jne	.L483
.L480:
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
	je	.L489
	xorl	%edi, %edi
	.p2align 4,,10
.L492:
	addq	$1, %rbx
	testb	%r12b, %r12b
	movq	%rsi, %rcx
	je	.L491
	leaq	(%rsi,%rdi), %rcx
	addq	$1, %rdi
.L491:
	call	*%rbp
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L492
.L489:
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
	je	.L500
	movzwl	%r9w, %r9d
	movq	%r8, %rbp
	leal	-1(%r9), %eax
	leaq	1(%r8,%rax), %rdi
	.p2align 4,,10
.L503:
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
	jne	.L503
.L500:
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
	js	.L506
	movslq	%r8d, %rdx
	movl	%r8d, %r8d
	leaq	-1(%rax,%rdx), %r11
	leaq	(%rax,%rdx), %r10
	subq	%r8, %r11
	.p2align 4,,10
.L508:
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
	jne	.L508
.L506:
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
.L511:
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	ja	.L510
.L523:
	testb	%bl, %bl
	je	.L510
	call	__locale_ctype_ptr
	movsbl	%bl, %ecx
	addq	$1, %rsi
	call	toupper
	movzbl	%al, %r13d
	movl	%eax, %ebx
	call	__locale_ctype_ptr
	testb	$68, 1(%rax,%r13)
	je	.L512
	leal	-48(%rbx), %edx
	addl	$1, %edi
	cmpb	$9, %dl
	jbe	.L513
	leal	-65(%rbx), %eax
	movl	%r13d, %edx
	subl	$55, %ebx
	cmpb	$6, %al
	cmovb	%ebx, %edx
.L513:
	movl	%edx, %ebx
	sall	$4, %ebp
	andl	$15, %ebx
	orl	%ebx, %ebp
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	jbe	.L523
.L510:
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
.L512:
	call	__locale_ctype_ptr
	testb	$8, 1(%rax,%r13)
	jne	.L511
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
	.globl	qItoA
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qItoA
qItoA:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testl	%ecx, %ecx
	movl	%ecx, %eax
	movq	%rdx, %r9
	je	.L545
	movl	$0, %esi
	js	.L546
.L527:
	movq	%r9, %r10
	xorl	%r11d, %r11d
	jmp	.L530
	.p2align 4,,10
.L536:
	movl	%edx, %r11d
.L530:
	cltd
	idivl	%r8d
	leal	55(%rdx), %ebx
	leal	48(%rdx), %ecx
	cmpl	$10, %edx
	leal	1(%r11), %edx
	cmovge	%ebx, %ecx
	addq	$1, %r10
	movb	%cl, -1(%r10)
	testl	%eax, %eax
	jne	.L536
	movslq	%edx, %rax
	addq	%r9, %rax
	testb	%sil, %sil
	je	.L532
	leal	2(%r11), %edx
	movb	$45, (%rax)
	movslq	%edx, %rax
	addq	%r9, %rax
.L532:
	movb	$0, (%rax)
	movl	%edx, %eax
	subw	$1, %ax
	je	.L526
	xorl	%r8d, %r8d
	.p2align 4,,10
.L534:
	movzwl	%r8w, %ecx
	movzwl	%ax, %edx
	addl	$1, %r8d
	addq	%r9, %rcx
	addq	%r9, %rdx
	subl	$1, %eax
	movzbl	(%rcx), %r10d
	movzbl	(%rdx), %r11d
	cmpw	%ax, %r8w
	movb	%r11b, (%rcx)
	movb	%r10b, (%rdx)
	jb	.L534
.L526:
	movq	%r9, %rax
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L545:
	movl	$48, %eax
	movw	%ax, (%rdx)
	movq	%r9, %rax
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L546:
	cmpl	$10, %r8d
	sete	%sil
	negl	%eax
	jmp	.L527
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
	je	.L550
	ret
	.p2align 4,,10
.L550:
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
	pxor	%xmm1, %xmm1
	movq	%rdx, %r9
	ucomiss	%xmm1, %xmm0
	jp	.L553
	je	.L576
.L553:
	movd	%xmm0, %edx
	movd	%xmm0, %eax
	andl	$2147483647, %edx
	cmpl	$2139095040, %edx
	jne	.L577
	movq	%r9, %rax
	movl	$1718511915, (%r9)
	movb	$0, 4(%r9)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L577:
	movd	%xmm0, %edx
	andl	$2139095040, %edx
	cmpl	$2139095040, %edx
	je	.L578
.L558:
	ucomiss	%xmm0, %xmm1
	leaq	1(%r9), %r10
	movq	%r9, %r11
	ja	.L579
.L566:
	cvttss2si	%xmm0, %ebx
	testl	%ebx, %ebx
	jne	.L567
	movb	$48, (%r11)
.L561:
	testb	%r8b, %r8b
	je	.L563
	pxor	%xmm1, %xmm1
	cmpb	$10, %r8b
	movl	$10, %eax
	cmova	%eax, %r8d
	leaq	1(%r10), %r11
	movb	$46, (%r10)
	subl	$1, %r8d
	movss	.LC4(%rip), %xmm2
	cvtsi2ss	%ebx, %xmm1
	movzbl	%r8b, %r8d
	movq	%r11, %rdx
	leaq	2(%r10,%r8), %r10
	subss	%xmm1, %xmm0
	.p2align 4,,10
.L564:
	mulss	%xmm2, %xmm0
	addq	$1, %rdx
	pxor	%xmm1, %xmm1
	cmpq	%r10, %rdx
	cvttss2si	%xmm0, %eax
	leal	48(%rax), %ecx
	movsbl	%al, %eax
	cvtsi2ss	%eax, %xmm1
	movb	%cl, -1(%rdx)
	subss	%xmm1, %xmm0
	jne	.L564
	leaq	1(%r11,%r8), %r10
.L563:
	movq	%r9, %rax
	movb	$0, (%r10)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L576:
	movq	%r9, %rax
	movl	$3157552, (%rdx)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L578:
	testl	$8388607, %eax
	je	.L558
	movq	%r9, %rax
	movl	$7233902, (%r9)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L579:
	movq	%r10, %r11
	xorps	.LC3(%rip), %xmm0
	movb	$45, (%r9)
	leaq	2(%r9), %r10
	jmp	.L566
	.p2align 4,,10
.L567:
	movl	%ebx, %ecx
	movq	%r11, %r10
	movl	$1717986919, %esi
	.p2align 4,,10
.L560:
	movl	%ecx, %eax
	addq	$1, %r10
	imull	%esi
	movl	%ecx, %eax
	sarl	$31, %eax
	sarl	$2, %edx
	subl	%eax, %edx
	leal	(%rdx,%rdx,4), %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	addl	$48, %ecx
	testl	%edx, %edx
	movb	%cl, -1(%r10)
	movl	%edx, %ecx
	jne	.L560
	movq	%r10, %rcx
	subq	%r11, %rcx
	subw	$1, %cx
	je	.L561
	xorl	%esi, %esi
	.p2align 4,,10
.L562:
	movzwl	%si, %edx
	movzwl	%cx, %eax
	addl	$1, %esi
	addq	%r11, %rdx
	addq	%r11, %rax
	subl	$1, %ecx
	movzbl	(%rdx), %edi
	movzbl	(%rax), %r14d
	cmpw	%cx, %si
	movb	%r14b, (%rdx)
	movb	%dil, (%rax)
	jb	.L562
	jmp	.L561
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferInit
	.def	qISR_ByteBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferInit
qISR_ByteBufferInit:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L582
	cmpw	$1, %r8w
	jbe	.L582
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
.L582:
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
	jne	.L589
	movq	16(%rcx), %rax
	testq	%rax, %rax
	je	.L590
	movq	16(%rcx), %rax
	movsbl	%dl, %ecx
	call	*%rax
	testb	%al, %al
	je	.L589
.L590:
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L595
	movq	24(%rbx), %rax
	movsbl	%sil, %ecx
	call	*%rax
.L588:
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
	jb	.L591
	xorl	%edx, %edx
	movw	%dx, 8(%rbx)
.L591:
	movzbl	32(%rbx), %eax
	cmpb	%sil, %al
	je	.L596
.L589:
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L596:
	xorl	%eax, %eax
	movb	$1, 10(%rbx)
	movw	%ax, 8(%rbx)
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L595:
	movl	%esi, %eax
	jmp	.L588
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
	je	.L597
	movzwl	8(%rbx), %r8d
	movq	(%rbx), %rdx
	call	memcpy
	movb	$0, 10(%rbx)
	movl	$1, %eax
.L597:
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
	je	.L601
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	subl	%edx, %eax
	cltq
.L601:
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
	je	.L605
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %ecx
	subl	%edx, %eax
	cltq
	cmpq	%rax, %rcx
	sete	%al
.L605:
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
	je	.L609
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L609:
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
	je	.L613
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
.L613:
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
	je	.L617
	movzwl	(%rcx), %r9d
	movzwl	2(%rcx), %edx
	cmpw	%dx, %r9w
	je	.L617
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
.L617:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Read
	.def	qBSBuffer_Read;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Read
qBSBuffer_Read:
	.seh_endprologue
	testw	%r8w, %r8w
	je	.L625
	testq	%rcx, %rcx
	je	.L625
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %r9d
	cmpw	%ax, %r9w
	je	.L625
	subl	$1, %r8d
	movq	%rdx, %r9
	movzwl	%r8w, %r8d
	addq	%rdx, %r8
	.p2align 4,,10
.L626:
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
	je	.L632
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	addq	$1, %r9
	cmpw	%ax, %dx
	jne	.L626
.L625:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L632:
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
	je	.L633
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %r8d
	movzwl	16(%rcx), %r9d
	subl	%r8d, %edx
	movslq	%edx, %rdx
	movzwl	%r9w, %r8d
	cmpq	%r8, %rdx
	je	.L633
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
.L633:
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
	je	.L638
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, (%r9)
	leal	-1(%rdx), %ecx
	xorl	%r10d, %r10d
	movw	%r10w, 2(%r9)
	testl	%edx, %ecx
	jne	.L649
	movw	%ax, 16(%r9)
.L638:
	ret
	.p2align 4,,10
.L649:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L641:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L641
	movzwl	%r8w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%r9)
	jmp	.L638
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
	jne	.L652
	cmpq	$0, (%rcx)
	je	.L656
.L652:
	movzbl	12(%rcx), %edx
	xorl	%eax, %eax
	testb	%dl, %dl
	je	.L651
	xorl	%eax, %eax
	xorl	%edx, %edx
	movq	$0, (%rcx)
	movw	%ax, 8(%rcx)
	movw	%dx, 10(%rcx)
	movl	$1, %eax
	movb	$0, 12(%rcx)
.L651:
	ret
	.p2align 4,,10
.L656:
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
	je	.L657
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L657
	movzwl	10(%rcx), %eax
	cmpb	%dl, (%r8,%rax)
	je	.L666
.L660:
	movzbl	12(%rcx), %eax
.L657:
	ret
	.p2align 4,,10
.L666:
	movzwl	10(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 10(%rcx)
	movzwl	10(%rcx), %eax
	cmpw	8(%rcx), %ax
	jne	.L660
	movb	$1, 12(%rcx)
	jmp	.L660
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC5:
	.ascii "--------------------------------------------------------------------\0"
	.align 8
.LC6:
	.ascii "TaskData\11Priority\11Interval\11Iterations\0"
.LC7:
	.ascii "%s\11\11%d\11\11%d\11\11\0"
.LC8:
	.ascii "qPeriodic\0"
.LC9:
	.ascii "%d\15\12\0"
	.text
	.p2align 4,,15
	.globl	qSchedulePrintChain
	.def	qSchedulePrintChain;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulePrintChain
qSchedulePrintChain:
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
	leaq	.LC5(%rip), %rcx
	call	puts
	leaq	.LC6(%rip), %rcx
	call	puts
	leaq	.LC5(%rip), %rcx
	call	puts
	movq	56+QUARKTS(%rip), %rbx
	testq	%rbx, %rbx
	je	.L668
	leaq	.LC7(%rip), %rsi
	leaq	.LC9(%rip), %rdi
	leaq	.LC8(%rip), %rbp
	jmp	.L671
	.p2align 4,,10
.L669:
	movswl	32(%rbx), %edx
	movq	%rdi, %rcx
	negl	%edx
	call	printf
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L668
.L671:
	movl	24(%rbx), %r9d
	movzbl	40(%rbx), %r8d
	movq	%rsi, %rcx
	movq	8(%rbx), %rdx
	call	printf
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	jne	.L669
	movq	%rbp, %rcx
	call	puts
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L671
.L668:
	leaq	.LC5(%rip), %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	jmp	puts
	.seh_endproc
	.data
	.align 8
ChainIterator.3296:
	.quad	_qSysTick_Epochs_
	.globl	qDebugTrace_Buffer
	.bss
	.align 32
qDebugTrace_Buffer:
	.space 32
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
	.align 16
.LC3:
	.long	2147483648
	.long	0
	.long	0
	.long	0
	.align 4
.LC4:
	.long	1092616192
	.ident	"GCC: (GNU) 7.3.0"
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	__locale_ctype_ptr;	.scl	2;	.type	32;	.endef
	.def	toupper;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
