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
	jnb	.L13
	jmp	.L3
	.p2align 4,,10
.L19:
	movzbl	40(%rdx), %r8d
	movq	(%rax), %rcx
	movzbl	40(%rcx), %ecx
	cmpb	%cl, %r8b
	ja	.L3
.L13:
	movq	(%rax), %rax
	movq	(%rax), %rcx
	testq	%rcx, %rcx
	jne	.L19
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
	movq	104+QUARKTS(%rip), %rax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskIsEnabled
	.def	qTaskIsEnabled;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskIsEnabled
qTaskIsEnabled:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L23
	movzbl	58(%rcx), %eax
	ret
	.p2align 4,,10
.L23:
	xorl	%eax, %eax
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
	testq	%rcx, %rcx
	je	.L29
	movl	36(%rcx), %eax
	ret
	.p2align 4,,10
.L29:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSendEvent
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSendEvent
qTaskSendEvent:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L30
	movb	$1, 57(%rcx)
	movq	%rdx, 16(%rcx)
.L30:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetTime
	.def	qTaskSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetTime
qTaskSetTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L35
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 24(%rcx)
.L35:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetIterations
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetIterations
qTaskSetIterations:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L40
	movl	%edx, %eax
	negl	%eax
	cmpw	$-32768, %dx
	cmovne	%eax, %edx
	movw	%dx, 32(%rcx)
.L40:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetPriority
	.def	qTaskSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetPriority
qTaskSetPriority:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L47
	movb	$0, 80+QUARKTS(%rip)
	movb	%dl, 40(%rcx)
.L47:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetCallback
	.def	qTaskSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetCallback
qTaskSetCallback:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L52
	movq	%rdx, 48(%rcx)
.L52:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetState
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetState
qTaskSetState:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L57
	testb	%dl, %dl
	je	.L59
	movzbl	58(%rcx), %eax
	testb	%al, %al
	jne	.L57
.L59:
	movb	%dl, 58(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L57:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetData
	.def	qTaskSetData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetData
qTaskSetData:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L63
	movq	%rdx, 8(%rcx)
.L63:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskClearTimeElapsed
	.def	qTaskClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskClearTimeElapsed
qTaskClearTimeElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L68
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L68:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskQueueEvent
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskQueueEvent
qTaskQueueEvent:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L75
	movswl	98+QUARKTS(%rip), %r9d
	movzbl	96+QUARKTS(%rip), %r8d
	xorl	%eax, %eax
	subl	$1, %r8d
	cmpl	%r8d, %r9d
	jge	.L73
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
	ret
	.p2align 4,,10
.L75:
	xorl	%eax, %eax
.L73:
	rep ret
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
	xorl	%eax, %eax
	movss	%xmm0, 48+QUARKTS(%rip)
	movq	%rdx, QUARKTS(%rip)
	movq	$0, 8+QUARKTS(%rip)
	movq	%r8, 88+QUARKTS(%rip)
	movb	%r9b, 96+QUARKTS(%rip)
	movzbl	96+QUARKTS(%rip), %edx
	testb	%dl, %dl
	je	.L81
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
	movb	$0, 80+QUARKTS(%rip)
	movb	$0, 82+QUARKTS(%rip)
	movb	$0, 83+QUARKTS(%rip)
	movq	$0, 72+QUARKTS(%rip)
	movq	$0, 64+QUARKTS(%rip)
	movq	$0, 104+QUARKTS(%rip)
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
	testq	%rdx, %rdx
	je	.L92
	cmpq	%rcx, %rdx
	je	.L87
	movq	(%rdx), %rax
	testq	%rax, %rax
	jne	.L89
	jmp	.L92
	.p2align 4,,10
.L94:
	movq	(%rax), %r8
	movq	%rax, %rdx
	testq	%r8, %r8
	je	.L92
.L89:
	movq	(%rdx), %rax
	cmpq	%rax, %rcx
	jne	.L94
	movq	(%rcx), %rax
	movq	%rax, (%rdx)
.L90:
	movq	$0, (%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L92:
	xorl	%eax, %eax
	ret
.L87:
	movq	(%rcx), %rax
	movq	%rax, 56+QUARKTS(%rip)
	jmp	.L90
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerAddxTask
	.def	qSchedulerAddxTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddxTask
qSchedulerAddxTask:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	96(%rsp), %r10d
	movl	104(%rsp), %ebx
	testq	%rcx, %rcx
	movq	%rcx, %r9
	movq	%rdx, %r11
	movl	%r8d, %esi
	je	.L99
	movss	.LC0(%rip), %xmm0
	mulss	%xmm3, %xmm0
	movss	48+QUARKTS(%rip), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L103
	pxor	%xmm0, %xmm0
	movl	$1, %eax
	ucomiss	%xmm0, %xmm3
	setp	%cl
	cmovne	%eax, %ecx
	xorl	%eax, %eax
	testb	%cl, %cl
	je	.L103
.L95:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L103:
	xorl	%eax, %eax
	testq	%r11, %r11
	je	.L95
	movq	%r9, %rcx
	call	qSchedulerRemoveTask
	movq	%r11, 48(%r9)
	leaq	56+QUARKTS(%rip), %rcx
	movq	%r9, %rdx
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm3
	cvttss2siq	%xmm3, %rax
	movl	%eax, 24(%r9)
	movq	112(%rsp), %rax
	movq	%rax, 8(%r9)
	movl	%r10d, %eax
	movb	%sil, 40(%r9)
	negl	%eax
	cmpw	$-32768, %r10w
	cmovne	%eax, %r10d
	testb	%bl, %bl
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
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L99:
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
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
	je	.L111
	cmpq	$0, 128(%rsp)
	je	.L111
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
	jne	.L115
.L111:
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L115:
	movq	128(%rsp), %rax
	movq	%rax, (%r9)
	movq	152(%rsp), %rax
	movq	$0, 8(%r9)
	movb	$0, 28(%r9)
	movl	$-32768, 24(%r9)
	movq	%rax, 40(%r9)
	movq	144(%rsp), %rax
	movq	%rax, 48(%r9)
	movq	160(%rsp), %rax
	movq	%rax, 56(%r9)
	movq	136(%rsp), %rax
	movq	%rax, 64(%r9)
	movl	$1, %eax
	movq	$0, 16(%r9)
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
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rdx, %r11
	movl	%r8d, %ebx
	je	.L118
	xorl	%eax, %eax
	testq	%rdx, %rdx
	movss	48+QUARKTS(%rip), %xmm0
	je	.L116
	call	qSchedulerRemoveTask
	pxor	%xmm0, %xmm0
	movq	%r11, 48(%rcx)
	movss	48+QUARKTS(%rip), %xmm1
	movq	%rcx, %rdx
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, 24(%rcx)
	movl	$-1, %eax
	movq	%r9, 8(%rcx)
	movb	%bl, 40(%rcx)
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
.L116:
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L118:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskLinkRBuffer
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskLinkRBuffer
qTaskLinkRBuffer:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L125
	testq	%rcx, %rcx
	je	.L125
	leal	-3(%r8), %r10d
	xorl	%eax, %eax
	cmpl	$3, %r10d
	ja	.L121
	cmpq	$0, (%rdx)
	je	.L121
	cmpl	$5, %r8d
	movl	%r9d, %eax
	je	.L123
	testb	%r9b, %r9b
	setne	%al
.L123:
	movl	%r8d, %r8d
	testb	%r9b, %r9b
	movb	%al, 56(%rcx,%r8)
	movl	$0, %eax
	cmove	%rax, %rdx
	movl	$1, %eax
	movq	%rdx, 64(%rcx)
	ret
	.p2align 4,,10
.L125:
	xorl	%eax, %eax
.L121:
	rep ret
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
	je	.L133
	testq	%rdx, %rdx
	je	.L133
	movq	40(%rsp), %rax
	movq	%rdx, (%rcx)
	movq	$0, 8(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	movq	%r9, 40(%rcx)
	movq	%r8, 48(%rcx)
	movq	%rax, 56(%rcx)
	movq	48(%rsp), %rax
	movq	%rax, 64(%rcx)
	movq	$0, 16(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L133:
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
	je	.L134
	movq	%rdx, 32(%rcx)
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L137
	movq	64(%rcx), %rax
	call	*%rax
.L137:
	movq	(%rbx), %rax
	testq	%rax, %rax
	je	.L138
	movq	16(%rbx), %rdx
	movq	(%rbx), %rax
	cmpq	%rax, %rdx
	setne	%al
	movb	%al, 28(%rbx)
	movzbl	28(%rbx), %eax
	testb	%al, %al
	jne	.L162
.L139:
	movq	(%rbx), %rsi
	movq	%rbx, %rcx
	movq	(%rbx), %rax
	call	*%rax
	movl	%eax, 24(%rbx)
	movq	%rsi, 16(%rbx)
.L140:
	movl	24(%rbx), %eax
	cmpl	$-32768, %eax
	je	.L142
	cmpl	$-32767, %eax
	je	.L163
	movq	56(%rbx), %rax
	testq	%rax, %rax
	je	.L134
	movq	56(%rbx), %rax
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L162:
	movq	16(%rbx), %rax
	movq	%rax, 8(%rbx)
	jmp	.L139
	.p2align 4,,10
.L163:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L134
	movq	40(%rbx), %rax
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L134:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L142:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L134
	movq	48(%rbx), %rax
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L138:
	movl	$-32767, 24(%rbx)
	jmp	.L140
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
	ja	.L165
	movl	%edx, %eax
	leaq	.L167(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L167:
	.long	.L165-.L167
	.long	.L166-.L167
	.long	.L168-.L167
	.long	.L169-.L167
	.long	.L170-.L167
	.long	.L171-.L167
	.long	.L171-.L167
	.long	.L171-.L167
	.long	.L165-.L167
	.long	.L172-.L167
	.text
	.p2align 4,,10
.L166:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L173
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L199
.L173:
	movb	$0, 41+QUARKTS(%rip)
	movzwl	32(%rbx), %eax
.L182:
	movw	%ax, 32(%rbx)
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L175
	movzwl	32(%rbx), %eax
	subl	$1, %eax
	movw	%ax, 32(%rbx)
.L175:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	sete	%dl
	movb	%dl, 42+QUARKTS(%rip)
	jne	.L165
	movb	$0, 58(%rbx)
	.p2align 4,,10
.L165:
	movb	$2, 80(%rbx)
	movl	%esi, 16+QUARKTS(%rip)
	movzbl	56(%rbx), %eax
	testb	%al, %al
	sete	%al
	movb	%al, 40+QUARKTS(%rip)
	movq	8(%rbx), %rax
	movq	%rax, 24+QUARKTS(%rip)
	movq	%rbx, 104+QUARKTS(%rip)
	movq	72(%rbx), %rax
	testq	%rax, %rax
	je	.L179
	movq	48(%rbx), %rax
	cmpq	$1, %rax
	je	.L200
.L179:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L180
	movq	48(%rbx), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
.L180:
	cmpl	$4, %esi
	movq	$0, 104+QUARKTS(%rip)
	je	.L201
.L181:
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
.L168:
	movq	112+QUARKTS(%rip), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movq	$0, 112+QUARKTS(%rip)
.L172:
	movzbl	81+QUARKTS(%rip), %eax
	leaq	16+QUARKTS(%rip), %rcx
	testb	%al, %al
	sete	%al
	movb	%al, 40+QUARKTS(%rip)
	movl	%esi, 16+QUARKTS(%rip)
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
.L201:
	movq	64(%rbx), %rdx
	movzwl	14(%rdx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rdx)
	jmp	.L181
	.p2align 4,,10
.L171:
	movq	64(%rcx), %rax
.L197:
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L165
	.p2align 4,,10
.L169:
	movq	16(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movb	$0, 57(%rcx)
	jmp	.L165
	.p2align 4,,10
.L170:
	movq	64(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L183
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L183
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
	jmp	.L197
	.p2align 4,,10
.L199:
	movb	$1, 41+QUARKTS(%rip)
	movzwl	32(%rcx), %eax
	negl	%eax
	jmp	.L182
	.p2align 4,,10
.L183:
	xorl	%eax, %eax
	jmp	.L197
	.p2align 4,,10
.L200:
	movq	72(%rbx), %rcx
	leaq	16+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L180
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
	leaq	56(%rsp), %rbx
	movb	$1, 80+QUARKTS(%rip)
	.p2align 4,,10
.L252:
	movzbl	80+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L313
.L203:
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
	jbe	.L255
	movq	88+QUARKTS(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L255
	xorl	%edx, %edx
	movl	$16, %eax
	movl	$1, %ecx
	jmp	.L214
	.p2align 4,,10
.L216:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%cl, %eax
	salq	$4, %rax
	addq	%rax, %r8
	movq	(%r8), %r8
	testq	%r8, %r8
	je	.L311
.L214:
	movq	88+QUARKTS(%rip), %r8
	addq	%rax, %r8
	movq	(%r8), %r8
	movzbl	40(%r8), %r8d
	cmpb	%r9b, %r8b
	jbe	.L215
	movq	88+QUARKTS(%rip), %rdx
	addq	%rdx, %rax
	movl	%ecx, %edx
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
.L215:
	movzbl	96+QUARKTS(%rip), %eax
	addl	$1, %ecx
	cmpb	%al, %cl
	jb	.L216
.L311:
	movzbl	%dl, %eax
	movzbl	%dl, %r8d
	salq	$4, %rax
.L212:
	movq	88+QUARKTS(%rip), %rcx
	addq	%rax, %rcx
	movq	8(%rcx), %rcx
	movq	%rcx, 112+QUARKTS(%rip)
	movq	88+QUARKTS(%rip), %rcx
	addq	%rax, %rcx
	movq	(%rcx), %rdi
	movb	$1, 80(%rdi)
	movq	88+QUARKTS(%rip), %rcx
	addq	%rcx, %rax
	movq	$0, (%rax)
	movswl	98+QUARKTS(%rip), %eax
	cmpl	%eax, %r8d
	jge	.L221
	.p2align 4,,10
.L290:
	movq	88+QUARKTS(%rip), %rcx
	movq	88+QUARKTS(%rip), %r8
	movzbl	%dl, %eax
	salq	$4, %rax
	addl	$1, %edx
	addq	%rax, %rcx
	leaq	16(%r8,%rax), %rax
	movq	(%rax), %r9
	movq	8(%rax), %r10
	movq	%r9, (%rcx)
	movq	%r10, 8(%rcx)
	movzbl	%dl, %ecx
	movswl	98+QUARKTS(%rip), %eax
	cmpl	%eax, %ecx
	jl	.L290
.L221:
	movzwl	98+QUARKTS(%rip), %eax
	subl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L219
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L219:
	movq	%rdi, %rcx
	movl	$2, %edx
	call	_qScheduler_Dispatch
	movb	%al, 80(%rdi)
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L250
.L222:
	xorl	%r8d, %r8d
	jmp	.L243
	.p2align 4,,10
.L316:
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L314
.L226:
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jle	.L228
.L227:
	movl	24(%rcx), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm6, %xmm0
	jp	.L264
	je	.L229
.L264:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	28(%rcx), %r9d
	movl	24(%rcx), %edx
	subl	%r9d, %eax
	cmpl	%edx, %eax
	jb	.L225
.L229:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	$1, %r8d
	movl	%eax, 28(%rcx)
	movb	$1, 80(%rcx)
	movl	$1, 84(%rcx)
.L233:
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L315
.L243:
	movzbl	58(%rcx), %eax
	testb	%al, %al
	jne	.L316
.L225:
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L234
	movzbl	60(%rcx), %eax
	testb	%al, %al
	je	.L235
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L258
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %r10d
	movzwl	10(%rax), %r9d
	movl	%edx, %eax
	subl	%r10d, %eax
	cmpw	%r9w, %ax
	je	.L258
.L235:
	movzbl	61(%rcx), %eax
	testb	%al, %al
	je	.L237
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L259
	movzwl	12(%rax), %r9d
	movzwl	14(%rax), %eax
	subl	%eax, %r9d
.L238:
	movzbl	61(%rcx), %edx
	movl	$6, %eax
	cmpw	%r9w, %dx
	ja	.L237
.L239:
	movb	$1, 80(%rcx)
	movl	%eax, 84(%rcx)
	movl	$1, %r8d
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L243
.L315:
	testb	%r8b, %r8b
	je	.L244
	movq	ChainIterator.3178(%rip), %rdi
	jmp	.L245
	.p2align 4,,10
.L246:
	testq	%rdi, %rdi
	je	.L247
.L317:
	movq	(%rdi), %rdx
	movzbl	80(%rdi), %eax
	movq	%rdx, ChainIterator.3178(%rip)
	cmpb	$1, %al
	je	.L248
	xorl	%eax, %eax
.L249:
	movb	%al, 80(%rdi)
	movq	%rdx, %rdi
.L245:
	cmpq	$-1, %rdi
	jne	.L246
	movq	56+QUARKTS(%rip), %rdi
	testq	%rdi, %rdi
	movq	%rdi, ChainIterator.3178(%rip)
	jne	.L317
	.p2align 4,,10
.L247:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3178(%rip)
.L250:
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L252
.L318:
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
	je	.L253
	movq	8+QUARKTS(%rip), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
	nop
.L253:
	movaps	64(%rsp), %xmm6
	movb	$1, 81+QUARKTS(%rip)
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L237:
	movzbl	59(%rcx), %eax
	testb	%al, %al
	je	.L240
	movq	64(%rcx), %r9
	testq	%r9, %r9
	je	.L240
	movzwl	12(%r9), %edx
	movzwl	14(%r9), %eax
	cmpw	%ax, %dx
	je	.L240
	movzwl	14(%r9), %eax
	movzwl	10(%r9), %r11d
	xorl	%edx, %edx
	movzwl	8(%r9), %r10d
	divw	%r11w
	movl	$4, %eax
	movzwl	%dx, %edx
	imull	%r10d, %edx
	movslq	%edx, %rdx
	addq	(%r9), %rdx
	jne	.L239
	.p2align 4,,10
.L240:
	movzbl	62(%rcx), %eax
	testb	%al, %al
	je	.L234
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L262
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %eax
	cmpw	%ax, %dx
	je	.L262
.L234:
	movzbl	57(%rcx), %eax
	testb	%al, %al
	je	.L242
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	$3, 84(%rcx)
	jmp	.L233
	.p2align 4,,10
.L314:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L226
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L227
.L228:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	jne	.L225
	jmp	.L227
	.p2align 4,,10
.L262:
	movl	$7, %eax
	jmp	.L239
	.p2align 4,,10
.L242:
	movb	$3, 80(%rcx)
	jmp	.L233
	.p2align 4,,10
.L258:
	movl	$5, %eax
	jmp	.L239
	.p2align 4,,10
.L248:
	movl	84(%rdi), %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movq	ChainIterator.3178(%rip), %rdx
	jmp	.L249
	.p2align 4,,10
.L244:
	testq	%rdi, %rdi
	jne	.L250
.L251:
	movq	(%rsi), %rax
	testq	%rax, %rax
	je	.L250
	xorl	%ecx, %ecx
	movl	$9, %edx
	call	_qScheduler_Dispatch
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L252
	jmp	.L318
	.p2align 4,,10
.L313:
	movq	64+QUARKTS(%rip), %rax
	movq	$0, 56(%rsp)
	movq	56+QUARKTS(%rip), %rdx
	testq	%rax, %rax
	je	.L310
	movq	%rdx, 40(%rsp)
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movq	40(%rsp), %rdx
	movl	%eax, 84+QUARKTS(%rip)
	jmp	.L310
	.p2align 4,,10
.L291:
	movq	(%rdx), %r10
	movq	%rbx, %rcx
	call	_qScheduler_PriorizedInsert
	movq	%r10, %rdx
.L310:
	testq	%rdx, %rdx
	jne	.L291
	movq	56(%rsp), %rax
	movb	$1, 80+QUARKTS(%rip)
	movq	%rax, 56+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L203
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	jns	.L319
.L210:
	movq	56+QUARKTS(%rip), %rcx
	xorl	%edi, %edi
	testq	%rcx, %rcx
	jne	.L222
	jmp	.L251
	.p2align 4,,10
.L259:
	xorl	%r9d, %r9d
	jmp	.L238
.L255:
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
	rep ret
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
	testq	%rcx, %rcx
	je	.L331
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	xorl	%eax, %eax
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	ja	.L329
	movss	48+QUARKTS(%rip), %xmm0
	movb	$1, (%rcx)
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 4(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L331:
	xorl	%eax, %eax
.L329:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerFreeRun
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerFreeRun
qSTimerFreeRun:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L336
	movzbl	(%rcx), %eax
	testb	%al, %al
	jne	.L338
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	jbe	.L339
.L333:
	rep ret
	.p2align 4,,10
.L339:
	movss	48+QUARKTS(%rip), %xmm0
	movb	$1, (%rcx)
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rdx
	movl	%edx, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	%edx, 4(%rcx)
	ret
	.p2align 4,,10
.L338:
	movl	_qSysTick_Epochs_(%rip), %edx
	subl	4(%rcx), %edx
	xorl	%eax, %eax
	cmpl	8(%rcx), %edx
	jb	.L333
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L336:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerExpired
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerExpired
qSTimerExpired:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L342
	movzbl	(%rcx), %eax
	testb	%al, %al
	je	.L340
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	setnb	%al
	ret
	.p2align 4,,10
.L342:
	xorl	%eax, %eax
.L340:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L348
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	ret
	.p2align 4,,10
.L348:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerRemaining
	.def	qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerRemaining
qSTimerRemaining:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L351
	movl	8(%rcx), %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %r8d
	testl	%eax, %eax
	je	.L349
	subl	%r8d, %edx
	movl	%eax, %ecx
	subl	%edx, %ecx
	cmpl	%edx, %eax
	cmovnb	%ecx, %eax
	ret
	.p2align 4,,10
.L351:
	xorl	%eax, %eax
.L349:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L355
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L355:
	rep ret
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
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movq	64+QUARKTS(%rip), %rax
	movq	16(%rcx), %r13
	movq	%rcx, %r14
	movl	%edx, %r15d
	movl	%edx, %esi
	testq	%rax, %rax
	je	.L361
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L361:
	movzbl	2(%r14), %ebp
	xorl	%edx, %edx
.L374:
	cmpb	%bpl, %dl
	jnb	.L373
	movq	8(%r14), %r12
	movzbl	%dl, %r8d
	movzwl	(%r14), %edi
	leaq	(%r12,%r8), %rax
	movzwl	%di, %r9d
	movzbl	(%rax), %ecx
	testb	%cl, %cl
	jne	.L376
.L362:
	cmpw	%di, %si
	jbe	.L394
	leal	1(%rdx), %r8d
	movl	%edi, %r10d
	movl	%edx, %r9d
	movl	$1, %r11d
	movzbl	%r8b, %r8d
	jmp	.L366
	.p2align 4,,10
.L365:
	addl	%edi, %r10d
	leaq	1(%r8), %rbx
	cmpw	%si, %r10w
	jnb	.L377
	movq	%rbx, %r8
.L366:
	addl	$1, %r9d
	addl	$1, %r11d
	cmpb	%bpl, %r9b
	jnb	.L364
	movzbl	(%r12,%r8), %ebx
	testb	%bl, %bl
	je	.L365
	leal	(%rbx,%r9), %edx
	movzbl	%dl, %r13d
	imull	%edi, %r13d
	movslq	%r13d, %r13
	addq	16(%r14), %r13
.L364:
	cmpb	%bpl, %r9b
	jne	.L374
.L373:
	movq	72+QUARKTS(%rip), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L360
	movq	%rax, 40(%rsp)
	movq	72+QUARKTS(%rip), %rdx
	movl	84+QUARKTS(%rip), %ecx
	call	*%rdx
	movq	40(%rsp), %rax
	jmp	.L360
	.p2align 4,,10
.L376:
	movzbl	%cl, %eax
	addl	%ecx, %edx
	imull	%r9d, %eax
	cltq
	addq	%rax, %r13
	cmpb	%bpl, %dl
	jnb	.L395
	movzbl	%dl, %r8d
	leaq	(%r12,%r8), %rax
	movzbl	(%rax), %ecx
	testb	%cl, %cl
	je	.L362
	jmp	.L376
.L394:
	movl	$1, %r11d
	.p2align 4,,10
.L377:
	addq	%r13, %r8
	xorl	%ecx, %ecx
	testw	%r15w, %r15w
	movb	%r11b, (%rax)
	je	.L371
	.p2align 4,,10
.L386:
	addl	$1, %ecx
	movzbl	%cl, %eax
	cmpw	%ax, %si
	ja	.L386
	movb	$0, (%r8)
.L371:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L392
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L392:
	movq	%r13, %rax
.L360:
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L395:
	movl	%edx, %r9d
	jmp	.L364
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
	je	.L396
	testq	%rdx, %rdx
	je	.L396
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L400
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L400:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L401
	cmpq	%r8, %rbx
	je	.L420
	movzwl	(%rsi), %r9d
	xorl	%eax, %eax
	jmp	.L404
	.p2align 4,,10
.L405:
	cmpq	%r8, %rbx
	je	.L421
.L404:
	addl	$1, %eax
	addq	%r9, %r8
	cmpb	%dl, %al
	jne	.L405
.L401:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L396
.L422:
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L396:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L421:
	movzbl	%al, %eax
.L402:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	jne	.L422
	jmp	.L396
.L420:
	xorl	%eax, %eax
	jmp	.L402
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
	.seh_endprologue
	movq	%rcx, %rax
	movl	%r9d, %ecx
	testq	%rax, %rax
	je	.L423
	testq	%rdx, %rdx
	je	.L423
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	movq	%rdx, (%rax)
	movzwl	%r9w, %edx
	movw	%r10w, 12(%rax)
	movw	%r11w, 14(%rax)
	movw	%r8w, 8(%rax)
	leal	-1(%rdx), %r8d
	testl	%edx, %r8d
	jne	.L431
	movw	%cx, 10(%rax)
.L423:
	rep ret
	.p2align 4,,10
.L431:
	subl	$1, %r9d
	movl	$4, %r8d
	movl	$1, %ecx
.L426:
	movzwl	%r9w, %edx
	sarl	%cl, %edx
	addl	%ecx, %ecx
	orl	%edx, %r9d
	subl	$1, %r8d
	jne	.L426
	movzwl	%r9w, %ecx
	addl	$1, %ecx
	shrl	%ecx
	movw	%cx, 10(%rax)
	jmp	.L423
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L434
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
	ret
	.p2align 4,,10
.L434:
	movl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L438
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L438
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
.L438:
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
	movq	%rcx, %rbx
	movq	%rdx, %rcx
	testq	%rbx, %rbx
	je	.L442
	movzwl	12(%rbx), %edx
	movzwl	14(%rbx), %eax
	cmpw	%ax, %dx
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
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L442:
	xorl	%eax, %eax
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
	testq	%rcx, %rcx
	movq	%rdx, %r10
	je	.L449
	testq	%rdx, %rdx
	je	.L449
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r8d
	subl	%eax, %edx
	xorl	%eax, %eax
	cmpw	%r8w, %dx
	je	.L460
	movzwl	12(%rcx), %eax
	movzwl	10(%rcx), %r9d
	xorl	%edx, %edx
	movzwl	8(%rcx), %r8d
	movq	(%rcx), %r11
	divw	%r9w
	movzwl	%r8w, %r9d
	xorl	%eax, %eax
	movzwl	%dx, %edx
	imull	%r9d, %edx
	movslq	%edx, %r9
	movzwl	8(%rcx), %edx
	testw	%dx, %dx
	je	.L448
	.p2align 4,,10
.L455:
	movzwl	%ax, %r8d
	addl	$1, %eax
	leaq	(%r9,%r8), %rdx
	movzbl	(%r10,%r8), %r8d
	addq	%r11, %rdx
	movb	%r8b, (%rdx)
	movzwl	8(%rcx), %edx
	cmpw	%ax, %dx
	ja	.L455
.L448:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L460:
	rep ret
	.p2align 4,,10
.L449:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSwapBytes
	.def	qSwapBytes;	.scl	2;	.type	32;	.endef
	.seh_proc	qSwapBytes
qSwapBytes:
	.seh_endprologue
	movzwl	%dx, %eax
	xorl	%edx, %edx
	subl	$1, %eax
	cltq
	testq	%rax, %rax
	je	.L461
	.p2align 4,,10
.L465:
	movzbl	(%rcx,%rdx), %r8d
	movzbl	(%rcx,%rax), %r9d
	movb	%r9b, (%rcx,%rdx)
	movb	%r8b, (%rcx,%rax)
	addq	$1, %rdx
	subq	$1, %rax
	cmpq	%rax, %rdx
	jb	.L465
.L461:
	rep ret
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
	.globl	qPrintRaw
	.def	qPrintRaw;	.scl	2;	.type	32;	.endef
	.seh_proc	qPrintRaw
qPrintRaw:
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
	xorl	%ebx, %ebx
	movzwl	%r9w, %esi
	movq	%rcx, %r12
	movq	%rdx, %rbp
	testq	%rsi, %rsi
	movq	%r8, %rdi
	je	.L468
	.p2align 4,,10
.L472:
	movsbl	(%rdi,%rbx), %edx
	addq	$1, %rbx
	movq	%rbp, %rcx
	call	*%r12
	cmpq	%rsi, %rbx
	jne	.L472
.L468:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qPrintString
	.def	qPrintString;	.scl	2;	.type	32;	.endef
	.seh_proc	qPrintString
qPrintString:
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
	movq	%rcx, %rdi
	movq	%r8, %rbx
	testb	%dl, %dl
	je	.L474
	.p2align 4,,10
.L478:
	addq	$1, %rbx
	movq	%rsi, %rcx
	call	*%rdi
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L478
.L474:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferInit
	.def	qISR_ByteBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferInit
qISR_ByteBufferInit:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L482
	cmpw	$1, %r8w
	jbe	.L482
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
.L482:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferFill
	.def	qISR_ByteBufferFill;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferFill
qISR_ByteBufferFill:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movzbl	10(%rcx), %eax
	movq	%rcx, %rbx
	movl	%edx, %esi
	testb	%al, %al
	jne	.L489
	movq	16(%rcx), %rax
	testq	%rax, %rax
	je	.L490
	movq	16(%rcx), %rax
	movsbl	%dl, %ecx
	call	*%rax
	testb	%al, %al
	je	.L489
.L490:
	movq	(%rbx), %rdi
	movzwl	8(%rbx), %eax
	leal	1(%rax), %edx
	addq	%rax, %rdi
	movw	%dx, 8(%rbx)
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L495
	movq	24(%rbx), %rax
	movsbl	%sil, %ecx
	call	*%rax
.L488:
	movb	%al, (%rdi)
	movq	(%rbx), %rax
	movzwl	8(%rbx), %edx
	addq	%rdx, %rax
	movb	$0, (%rax)
	movzwl	8(%rbx), %edx
	movzwl	34(%rbx), %eax
	cmpw	%ax, %dx
	jb	.L491
	xorl	%edx, %edx
	movw	%dx, 8(%rbx)
.L491:
	movzbl	32(%rbx), %eax
	cmpb	%al, %sil
	je	.L496
.L489:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L496:
	xorl	%eax, %eax
	movb	$1, 10(%rbx)
	movw	%ax, 8(%rbx)
	movl	$1, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L495:
	movl	%esi, %eax
	jmp	.L488
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
	je	.L497
	movzwl	8(%rbx), %r8d
	movq	(%rbx), %rdx
	call	memcpy
	movb	$0, 10(%rbx)
	movl	$1, %eax
.L497:
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
	testq	%rcx, %rcx
	je	.L503
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	subl	%edx, %eax
	cltq
	ret
	.p2align 4,,10
.L503:
	xorl	%eax, %eax
	cltq
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_IsFull
	.def	qBSBuffer_IsFull;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_IsFull
qBSBuffer_IsFull:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L506
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %ecx
	subl	%edx, %eax
	cltq
	cmpq	%rax, %rcx
	sete	%al
	ret
	.p2align 4,,10
.L506:
	movl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Empty
	.def	qBSBuffer_Empty;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Empty
qBSBuffer_Empty:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L509
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
	ret
	.p2align 4,,10
.L509:
	movl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Peek
	.def	qBSBuffer_Peek;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Peek
qBSBuffer_Peek:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L512
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
	ret
	.p2align 4,,10
.L512:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Get
	.def	qBSBuffer_Get;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Get
qBSBuffer_Get:
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rdx, %r8
	je	.L516
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	je	.L516
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
	ret
	.p2align 4,,10
.L516:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Read
	.def	qBSBuffer_Read;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Read
qBSBuffer_Read:
	.seh_endprologue
	testw	%r8w, %r8w
	je	.L520
	testq	%rcx, %rcx
	je	.L520
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %r9d
	cmpw	%ax, %r9w
	je	.L520
	subl	$1, %r8d
	movq	%rdx, %r9
	movzwl	%r8w, %r8d
	addq	%rdx, %r8
	.p2align 4,,10
.L522:
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
	movb	%al, (%r9)
	movzwl	2(%rcx), %eax
	addl	$1, %eax
	cmpq	%r8, %r9
	movw	%ax, 2(%rcx)
	je	.L528
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	addq	$1, %r9
	cmpw	%ax, %dx
	jne	.L522
.L520:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L528:
	movl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Put
	.def	qBSBuffer_Put;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Put
qBSBuffer_Put:
	.seh_endprologue
	testq	%rcx, %rcx
	movl	%edx, %r9d
	je	.L532
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %r8d
	subl	%edx, %eax
	cltq
	movzwl	%r8w, %edx
	cmpq	%rdx, %rax
	je	.L532
	movzwl	(%rcx), %eax
	xorl	%edx, %edx
	divw	%r8w
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movb	%r9b, (%rdx)
	movzwl	(%rcx), %eax
	addl	$1, %eax
	movw	%ax, (%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L532:
	xorl	%eax, %eax
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
	je	.L533
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, (%r9)
	leal	-1(%rdx), %ecx
	xorl	%r10d, %r10d
	movw	%r10w, 2(%r9)
	testl	%edx, %ecx
	jne	.L544
.L535:
	movw	%ax, 16(%r9)
.L533:
	rep ret
	.p2align 4,,10
.L544:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L536:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L536
	movzwl	%r8w, %eax
	addl	$1, %eax
	shrl	%eax
	jmp	.L535
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC3:
	.ascii "--------------------------------------------------------------------\0"
	.align 8
.LC4:
	.ascii "TaskData\11Priority\11Interval\11Iterations\0"
.LC5:
	.ascii "%s\11\11%d\11\11%d\11\11\0"
.LC6:
	.ascii "qPeriodic\0"
.LC7:
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
	leaq	.LC3(%rip), %rcx
	leaq	.LC5(%rip), %rsi
	leaq	.LC6(%rip), %rbp
	leaq	.LC7(%rip), %rdi
	call	puts
	leaq	.LC4(%rip), %rcx
	call	puts
	leaq	.LC3(%rip), %rcx
	call	puts
	movq	56+QUARKTS(%rip), %rbx
	testq	%rbx, %rbx
	jne	.L551
	jmp	.L550
	.p2align 4,,10
.L547:
	movswl	32(%rbx), %edx
	movq	%rdi, %rcx
	negl	%edx
	call	printf
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L550
.L551:
	movl	24(%rbx), %r9d
	movzbl	40(%rbx), %r8d
	movq	%rsi, %rcx
	movq	8(%rbx), %rdx
	call	printf
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	jne	.L547
	movq	%rbp, %rcx
	call	puts
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L551
.L550:
	leaq	.LC3(%rip), %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	jmp	puts
	.seh_endproc
	.data
	.align 8
ChainIterator.3178:
	.quad	-1
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
	.ident	"GCC: (GNU) 6.4.0"
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
