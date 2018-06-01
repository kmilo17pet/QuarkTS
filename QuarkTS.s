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
	movq	%rax, 56(%rcx)
	movq	48(%rsp), %rax
	movq	%r8, 48(%rcx)
	movq	$0, 16(%rcx)
	movq	%rax, 64(%rcx)
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
	movq	64(%rcx), %rax
	movq	%rdx, 32(%rcx)
	testq	%rax, %rax
	je	.L137
	call	*%rax
.L137:
	movq	(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L138
	movq	16(%rbx), %rax
	cmpq	%rax, %rsi
	setne	28(%rbx)
	je	.L139
	movq	%rax, 8(%rbx)
.L139:
	movq	%rbx, %rcx
	call	*%rsi
	cmpl	$-32768, %eax
	movl	%eax, 24(%rbx)
	movq	%rsi, 16(%rbx)
	je	.L141
	cmpl	$-32767, %eax
	je	.L142
	movq	56(%rbx), %rax
	testq	%rax, %rax
	je	.L134
.L160:
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L141:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	jne	.L160
.L134:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L138:
	movl	$-32767, 24(%rbx)
.L142:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L134
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
	ja	.L163
	movl	%edx, %eax
	leaq	.L165(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L165:
	.long	.L163-.L165
	.long	.L164-.L165
	.long	.L166-.L165
	.long	.L167-.L165
	.long	.L168-.L165
	.long	.L169-.L165
	.long	.L169-.L165
	.long	.L169-.L165
	.long	.L163-.L165
	.long	.L170-.L165
	.text
	.p2align 4,,10
.L164:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L171
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L197
.L171:
	movb	$0, 41+QUARKTS(%rip)
	movzwl	32(%rbx), %eax
.L180:
	movw	%ax, 32(%rbx)
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L173
	movzwl	32(%rbx), %eax
	subl	$1, %eax
	movw	%ax, 32(%rbx)
.L173:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	sete	%dl
	movb	%dl, 42+QUARKTS(%rip)
	jne	.L163
	movb	$0, 58(%rbx)
	.p2align 4,,10
.L163:
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
	je	.L177
	movq	48(%rbx), %rax
	cmpq	$1, %rax
	je	.L198
.L177:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L178
	movq	48(%rbx), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
.L178:
	cmpl	$4, %esi
	movq	$0, 104+QUARKTS(%rip)
	je	.L199
.L179:
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
.L166:
	movq	112+QUARKTS(%rip), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movq	$0, 112+QUARKTS(%rip)
.L170:
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
.L199:
	movq	64(%rbx), %rdx
	movzwl	14(%rdx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rdx)
	jmp	.L179
	.p2align 4,,10
.L169:
	movq	64(%rcx), %rax
.L195:
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L163
	.p2align 4,,10
.L167:
	movq	16(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movb	$0, 57(%rcx)
	jmp	.L163
	.p2align 4,,10
.L168:
	movq	64(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L181
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L181
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
	jmp	.L195
	.p2align 4,,10
.L197:
	movb	$1, 41+QUARKTS(%rip)
	movzwl	32(%rcx), %eax
	negl	%eax
	jmp	.L180
	.p2align 4,,10
.L181:
	xorl	%eax, %eax
	jmp	.L195
	.p2align 4,,10
.L198:
	movq	72(%rbx), %rcx
	leaq	16+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L178
	.seh_endproc
	.p2align 4,,15
	.globl	qSchedulerRun
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRun
qSchedulerRun:
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
	movaps	%xmm6, 64(%rsp)
	.seh_savexmm	%xmm6, 64
	.seh_endprologue
	pxor	%xmm6, %xmm6
	leaq	QUARKTS(%rip), %rsi
	leaq	56(%rsp), %rbx
	movb	$1, 80+QUARKTS(%rip)
	.p2align 4,,10
.L250:
	movzbl	80+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L311
.L201:
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	js	.L208
.L317:
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L209
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L209:
	movq	88+QUARKTS(%rip), %rax
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
	movzbl	96+QUARKTS(%rip), %eax
	cmpb	$1, %al
	jbe	.L253
	movq	88+QUARKTS(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L253
	xorl	%edx, %edx
	movl	$16, %eax
	movl	$1, %ecx
	jmp	.L212
	.p2align 4,,10
.L214:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%cl, %eax
	salq	$4, %rax
	addq	%rax, %r8
	movq	(%r8), %r8
	testq	%r8, %r8
	je	.L309
.L212:
	movq	88+QUARKTS(%rip), %r8
	addq	%rax, %r8
	movq	(%r8), %r8
	movzbl	40(%r8), %r8d
	cmpb	%r9b, %r8b
	jbe	.L213
	movq	88+QUARKTS(%rip), %rdx
	addq	%rdx, %rax
	movl	%ecx, %edx
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
.L213:
	movzbl	96+QUARKTS(%rip), %eax
	addl	$1, %ecx
	cmpb	%al, %cl
	jb	.L214
.L309:
	movzbl	%dl, %eax
	movzbl	%dl, %r8d
	salq	$4, %rax
.L210:
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
	jge	.L219
	.p2align 4,,10
.L288:
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
	jl	.L288
.L219:
	movzwl	98+QUARKTS(%rip), %eax
	subl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L217
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L217:
	movq	%rdi, %rcx
	movl	$2, %edx
	call	_qScheduler_Dispatch
	movb	%al, 80(%rdi)
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L248
.L220:
	xorl	%r8d, %r8d
	jmp	.L241
	.p2align 4,,10
.L314:
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L312
.L224:
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jle	.L226
.L225:
	movl	24(%rcx), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm6, %xmm0
	jp	.L262
	je	.L227
.L262:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	28(%rcx), %r9d
	movl	24(%rcx), %edx
	subl	%r9d, %eax
	cmpl	%edx, %eax
	jb	.L223
.L227:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	$1, %r8d
	movl	%eax, 28(%rcx)
	movb	$1, 80(%rcx)
	movl	$1, 84(%rcx)
.L231:
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L313
.L241:
	movzbl	58(%rcx), %eax
	testb	%al, %al
	jne	.L314
.L223:
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L232
	movzbl	60(%rcx), %eax
	testb	%al, %al
	je	.L233
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L256
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %r10d
	movzwl	10(%rax), %r9d
	movl	%edx, %eax
	subl	%r10d, %eax
	cmpw	%r9w, %ax
	je	.L256
.L233:
	movzbl	61(%rcx), %eax
	testb	%al, %al
	je	.L235
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L257
	movzwl	12(%rax), %r9d
	movzwl	14(%rax), %eax
	subl	%eax, %r9d
.L236:
	movzbl	61(%rcx), %edx
	movl	$6, %eax
	cmpw	%r9w, %dx
	ja	.L235
.L237:
	movb	$1, 80(%rcx)
	movl	%eax, 84(%rcx)
	movl	$1, %r8d
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L241
.L313:
	testb	%r8b, %r8b
	je	.L242
	movq	ChainIterator.3231(%rip), %rdi
	leaq	_qSysTick_Epochs_(%rip), %rbp
	jmp	.L243
	.p2align 4,,10
.L244:
	testq	%rdi, %rdi
	je	.L245
.L315:
	movq	(%rdi), %rdx
	movzbl	80(%rdi), %eax
	movq	%rdx, ChainIterator.3231(%rip)
	cmpb	$1, %al
	je	.L246
	xorl	%eax, %eax
.L247:
	movb	%al, 80(%rdi)
	movq	%rdx, %rdi
.L243:
	cmpq	%rbp, %rdi
	jne	.L244
	movq	56+QUARKTS(%rip), %rdi
	testq	%rdi, %rdi
	movq	%rdi, ChainIterator.3231(%rip)
	jne	.L315
	.p2align 4,,10
.L245:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3231(%rip)
.L248:
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L250
.L316:
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
	je	.L251
	movq	8+QUARKTS(%rip), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
	nop
.L251:
	movaps	64(%rsp), %xmm6
	movb	$1, 81+QUARKTS(%rip)
	addq	$88, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L235:
	movzbl	59(%rcx), %eax
	testb	%al, %al
	je	.L238
	movq	64(%rcx), %r9
	testq	%r9, %r9
	je	.L238
	movzwl	12(%r9), %edx
	movzwl	14(%r9), %eax
	cmpw	%ax, %dx
	je	.L238
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
	jne	.L237
	.p2align 4,,10
.L238:
	movzbl	62(%rcx), %eax
	testb	%al, %al
	je	.L232
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L260
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %eax
	cmpw	%ax, %dx
	je	.L260
.L232:
	movzbl	57(%rcx), %eax
	testb	%al, %al
	je	.L240
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	$3, 84(%rcx)
	jmp	.L231
	.p2align 4,,10
.L312:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L224
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L225
.L226:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	jne	.L223
	jmp	.L225
	.p2align 4,,10
.L260:
	movl	$7, %eax
	jmp	.L237
	.p2align 4,,10
.L240:
	movb	$3, 80(%rcx)
	jmp	.L231
	.p2align 4,,10
.L256:
	movl	$5, %eax
	jmp	.L237
	.p2align 4,,10
.L246:
	movl	84(%rdi), %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movq	ChainIterator.3231(%rip), %rdx
	jmp	.L247
	.p2align 4,,10
.L242:
	testq	%rdi, %rdi
	jne	.L248
.L249:
	movq	(%rsi), %rax
	testq	%rax, %rax
	je	.L248
	xorl	%ecx, %ecx
	movl	$9, %edx
	call	_qScheduler_Dispatch
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L250
	jmp	.L316
	.p2align 4,,10
.L311:
	movq	64+QUARKTS(%rip), %rax
	movq	$0, 56(%rsp)
	movq	56+QUARKTS(%rip), %rdx
	testq	%rax, %rax
	je	.L308
	movq	%rdx, 40(%rsp)
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movq	40(%rsp), %rdx
	movl	%eax, 84+QUARKTS(%rip)
	jmp	.L308
	.p2align 4,,10
.L289:
	movq	(%rdx), %r10
	movq	%rbx, %rcx
	call	_qScheduler_PriorizedInsert
	movq	%r10, %rdx
.L308:
	testq	%rdx, %rdx
	jne	.L289
	movq	56(%rsp), %rax
	movb	$1, 80+QUARKTS(%rip)
	movq	%rax, 56+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L201
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	jns	.L317
.L208:
	movq	56+QUARKTS(%rip), %rcx
	xorl	%edi, %edi
	testq	%rcx, %rcx
	jne	.L220
	jmp	.L249
	.p2align 4,,10
.L257:
	xorl	%r9d, %r9d
	jmp	.L236
.L253:
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L210
	.seh_endproc
	.p2align 4,,15
	.globl	qStateMachine_Attribute
	.def	qStateMachine_Attribute;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Attribute
qStateMachine_Attribute:
	.seh_endprologue
	cmpl	$5, %edx
	ja	.L318
	leaq	.L321(%rip), %r9
	movl	%edx, %edx
	movslq	(%r9,%rdx,4), %rax
	addq	%r9, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L321:
	.long	.L320-.L321
	.long	.L322-.L321
	.long	.L323-.L321
	.long	.L324-.L321
	.long	.L325-.L321
	.long	.L326-.L321
	.text
	.p2align 4,,10
.L326:
	movq	%r8, 64(%rcx)
.L318:
	rep ret
	.p2align 4,,10
.L325:
	movq	%r8, 56(%rcx)
	ret
	.p2align 4,,10
.L320:
	movq	%r8, (%rcx)
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	ret
	.p2align 4,,10
.L322:
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	ret
	.p2align 4,,10
.L323:
	movq	%r8, 40(%rcx)
	ret
	.p2align 4,,10
.L324:
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
	je	.L329
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	xorl	%eax, %eax
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	ja	.L327
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movb	$1, (%rcx)
	movl	%eax, 4(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L329:
	xorl	%eax, %eax
.L327:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerFreeRun
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerFreeRun
qSTimerFreeRun:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L334
	cmpb	$0, (%rcx)
	jne	.L337
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	xorl	%eax, %eax
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	jbe	.L338
.L331:
	rep ret
	.p2align 4,,10
.L338:
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rdx
	movl	%edx, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %edx
	movb	$1, (%rcx)
	movl	%edx, 4(%rcx)
	ret
	.p2align 4,,10
.L337:
	movl	_qSysTick_Epochs_(%rip), %edx
	subl	4(%rcx), %edx
	xorl	%eax, %eax
	cmpl	8(%rcx), %edx
	jb	.L331
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L334:
	xorl	%eax, %eax
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
	je	.L339
	cmpb	$0, (%rcx)
	je	.L339
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	setnb	%al
	ret
	.p2align 4,,10
.L339:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L345
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	ret
	.p2align 4,,10
.L345:
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
	je	.L348
	movl	8(%rcx), %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %r8d
	testl	%eax, %eax
	je	.L346
	subl	%r8d, %edx
	movl	%eax, %ecx
	subl	%edx, %ecx
	cmpl	%edx, %eax
	cmovnb	%ecx, %eax
	ret
	.p2align 4,,10
.L348:
	xorl	%eax, %eax
.L346:
	rep ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L351
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L351:
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
	je	.L357
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L357:
	movzbl	2(%r14), %ebp
	xorl	%edx, %edx
.L370:
	cmpb	%bpl, %dl
	jnb	.L369
	movq	8(%r14), %r12
	movzbl	%dl, %r8d
	movzwl	(%r14), %edi
	leaq	(%r12,%r8), %rax
	movzwl	%di, %r9d
	movzbl	(%rax), %ecx
	testb	%cl, %cl
	jne	.L372
.L358:
	cmpw	%di, %si
	jbe	.L390
	leal	1(%rdx), %r8d
	movl	%edi, %r10d
	movl	%edx, %r9d
	movl	$1, %r11d
	movzbl	%r8b, %r8d
	jmp	.L362
	.p2align 4,,10
.L361:
	addl	%edi, %r10d
	leaq	1(%r8), %rbx
	cmpw	%si, %r10w
	jnb	.L373
	movq	%rbx, %r8
.L362:
	addl	$1, %r9d
	addl	$1, %r11d
	cmpb	%bpl, %r9b
	jnb	.L360
	movzbl	(%r12,%r8), %ebx
	testb	%bl, %bl
	je	.L361
	leal	(%rbx,%r9), %edx
	movzbl	%dl, %r13d
	imull	%edi, %r13d
	movslq	%r13d, %r13
	addq	16(%r14), %r13
.L360:
	cmpb	%bpl, %r9b
	jne	.L370
.L369:
	movq	72+QUARKTS(%rip), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L356
	movq	%rax, 40(%rsp)
	movq	72+QUARKTS(%rip), %rdx
	movl	84+QUARKTS(%rip), %ecx
	call	*%rdx
	movq	40(%rsp), %rax
	jmp	.L356
	.p2align 4,,10
.L372:
	movzbl	%cl, %eax
	addl	%ecx, %edx
	imull	%r9d, %eax
	cltq
	addq	%rax, %r13
	cmpb	%bpl, %dl
	jnb	.L391
	movzbl	%dl, %r8d
	leaq	(%r12,%r8), %rax
	movzbl	(%rax), %ecx
	testb	%cl, %cl
	je	.L358
	jmp	.L372
.L390:
	movl	$1, %r11d
	.p2align 4,,10
.L373:
	addq	%r13, %r8
	xorl	%ecx, %ecx
	testw	%r15w, %r15w
	movb	%r11b, (%rax)
	je	.L367
	.p2align 4,,10
.L382:
	addl	$1, %ecx
	movzbl	%cl, %eax
	cmpw	%ax, %si
	ja	.L382
	movb	$0, (%r8)
.L367:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L388
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L388:
	movq	%r13, %rax
.L356:
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
.L391:
	movl	%edx, %r9d
	jmp	.L360
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
	je	.L392
	testq	%rdx, %rdx
	je	.L392
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L396
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L396:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L397
	cmpq	%r8, %rbx
	je	.L416
	movzwl	(%rsi), %r9d
	xorl	%eax, %eax
	jmp	.L400
	.p2align 4,,10
.L401:
	cmpq	%r8, %rbx
	je	.L417
.L400:
	addl	$1, %eax
	addq	%r9, %r8
	cmpb	%dl, %al
	jne	.L401
.L397:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L392
.L418:
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L392:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L417:
	movzbl	%al, %eax
.L398:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	jne	.L418
	jmp	.L392
.L416:
	xorl	%eax, %eax
	jmp	.L398
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rax
	je	.L419
	testq	%rdx, %rdx
	je	.L419
	xorl	%ecx, %ecx
	xorl	%r10d, %r10d
	movq	%rdx, (%rax)
	movw	%cx, 12(%rax)
	movzwl	%r9w, %ecx
	movw	%r10w, 14(%rax)
	movw	%r8w, 8(%rax)
	leal	-1(%rcx), %r8d
	movl	%r9d, %edx
	testl	%ecx, %r8d
	jne	.L426
	movw	%dx, 10(%rax)
.L419:
	rep ret
	.p2align 4,,10
.L426:
	subl	$1, %r9d
	movl	$4, %r8d
	movl	$1, %ecx
.L422:
	movzwl	%r9w, %edx
	sarl	%cl, %edx
	addl	%ecx, %ecx
	orl	%edx, %r9d
	subl	$1, %r8d
	jne	.L422
	movzwl	%r9w, %edx
	addl	$1, %edx
	shrl	%edx
	movw	%dx, 10(%rax)
	jmp	.L419
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L429
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
	ret
	.p2align 4,,10
.L429:
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
	je	.L433
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L433
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
.L433:
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
	je	.L437
	movzwl	12(%rbx), %edx
	movzwl	14(%rbx), %eax
	cmpw	%ax, %dx
	je	.L437
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
.L437:
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
	je	.L444
	testq	%rdx, %rdx
	je	.L444
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r8d
	subl	%eax, %edx
	xorl	%eax, %eax
	cmpw	%r8w, %dx
	je	.L455
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
	je	.L443
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
.L443:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L455:
	rep ret
	.p2align 4,,10
.L444:
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
	je	.L456
	.p2align 4,,10
.L460:
	movzbl	(%rcx,%rdx), %r8d
	movzbl	(%rcx,%rax), %r9d
	movb	%r9b, (%rcx,%rdx)
	movb	%r8b, (%rcx,%rax)
	addq	$1, %rdx
	subq	$1, %rax
	cmpq	%rax, %rdx
	jb	.L460
.L456:
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
	.globl	qOutputRAW
	.def	qOutputRAW;	.scl	2;	.type	32;	.endef
	.seh_proc	qOutputRAW
qOutputRAW:
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
	movzbl	128(%rsp), %r12d
	movzwl	%r9w, %r9d
	movq	%rcx, %r13
	movq	%rdx, %rdi
	testq	%r9, %r9
	movq	%r8, %rsi
	movq	%rdx, %rbx
	leaq	(%rdx,%r9), %rbp
	je	.L463
	.p2align 4,,10
.L469:
	testb	%r12b, %r12b
	movq	%rbx, %rcx
	movsbl	(%rsi), %edx
	cmove	%rdi, %rcx
	addq	$1, %rbx
	addq	$1, %rsi
	call	*%r13
	cmpq	%rbp, %rbx
	jne	.L469
.L463:
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
	xorl	%esi, %esi
	movq	%rdx, %rdi
	movsbl	(%r8), %edx
	movq	%rcx, %r12
	movq	%r8, %rbx
	movl	%r9d, %ebp
	testb	%dl, %dl
	je	.L471
	.p2align 4,,10
.L477:
	addq	$1, %rbx
	testb	%bpl, %bpl
	movq	%rdi, %rcx
	je	.L473
	leaq	(%rdi,%rsi), %rcx
	addq	$1, %rsi
.L473:
	call	*%r12
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L477
.L471:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
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
	testl	%r8d, %r8d
	movslq	%r8d, %r10
	js	.L487
	.p2align 4,,10
.L485:
	movl	%ecx, %r9d
	andl	$15, %r9d
	leal	48(%r9), %r8d
	addl	$55, %r9d
	cmpb	$58, %r8b
	cmovnb	%r9d, %r8d
	shrl	$4, %ecx
	movb	%r8b, (%rax,%r10)
	subq	$1, %r10
	testl	%r10d, %r10d
	jns	.L485
.L487:
	rep ret
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
	xorl	%ebp, %ebp
	xorl	%r12d, %r12d
	movq	%rcx, %rdi
	cmpb	$7, %bpl
	movzbl	(%rdi), %ebx
	ja	.L488
.L507:
	testb	%bl, %bl
	je	.L488
	call	__locale_ctype_ptr
	movsbl	%bl, %ecx
	call	toupper
	movsbq	%al, %r13
	movl	%eax, %ebx
	call	__locale_ctype_ptr
	testb	$7, 1(%rax,%r13)
	movq	%r13, %rsi
	je	.L490
	cmpb	$70, %bl
	jg	.L490
	leal	-48(%rbx), %eax
	addl	$1, %ebp
	cmpb	$9, %al
	ja	.L491
	movl	%eax, %esi
.L492:
	sall	$4, %r12d
	andl	$15, %esi
	orl	%esi, %r12d
.L493:
	addq	$1, %rdi
	cmpb	$7, %bpl
	movzbl	(%rdi), %ebx
	jbe	.L507
.L488:
	movl	%r12d, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
.L490:
	call	__locale_ctype_ptr
	testb	$8, 1(%rax,%r13)
	jne	.L493
	movl	%r12d, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
.L491:
	leal	-65(%rbx), %eax
	subl	$55, %ebx
	cmpb	$5, %al
	cmovbe	%ebx, %esi
	jmp	.L492
	.seh_endproc
	.p2align 4,,15
	.globl	qItoA
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qItoA
qItoA:
	.seh_endprologue
	testl	%edx, %edx
	movl	%edx, %r10d
	js	.L516
.L509:
	cmpl	$999999999, %r10d
	movl	$1000000000, %r8d
	jg	.L510
	movl	$-858993459, %r9d
	.p2align 4,,10
.L511:
	movl	%r8d, %eax
	mull	%r9d
	movl	%edx, %r8d
	shrl	$3, %r8d
	cmpl	%r10d, %r8d
	ja	.L511
.L510:
	movl	$-858993459, %r11d
	.p2align 4,,10
.L512:
	xorl	%edx, %edx
	movl	%r10d, %eax
	addq	$1, %rcx
	divl	%r8d
	movl	%r10d, %eax
	subl	%edx, %eax
	xorl	%edx, %edx
	divl	%r8d
	movl	%eax, %r9d
	mull	%r11d
	shrl	$3, %edx
	leal	(%rdx,%rdx,4), %eax
	addl	%eax, %eax
	subl	%eax, %r9d
	movl	%r8d, %eax
	mull	%r11d
	addl	$48, %r9d
	movb	%r9b, -1(%rcx)
	movl	%edx, %r8d
	shrl	$3, %r8d
	testl	%r8d, %r8d
	jne	.L512
	movb	$0, (%rcx)
	movl	%r10d, %eax
	ret
	.p2align 4,,10
.L516:
	movb	$45, (%rcx)
	negl	%r10d
	addq	$1, %rcx
	jmp	.L509
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferInit
	.def	qISR_ByteBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferInit
qISR_ByteBufferInit:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L519
	cmpw	$1, %r8w
	jbe	.L519
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
.L519:
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
	jne	.L526
	movq	16(%rcx), %rax
	testq	%rax, %rax
	je	.L527
	movq	16(%rcx), %rax
	movsbl	%dl, %ecx
	call	*%rax
	testb	%al, %al
	je	.L526
.L527:
	movq	(%rbx), %rdi
	movzwl	8(%rbx), %eax
	leal	1(%rax), %edx
	addq	%rax, %rdi
	movw	%dx, 8(%rbx)
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L532
	movq	24(%rbx), %rax
	movsbl	%sil, %ecx
	call	*%rax
.L525:
	movb	%al, (%rdi)
	movq	(%rbx), %rax
	movzwl	8(%rbx), %edx
	addq	%rdx, %rax
	movb	$0, (%rax)
	movzwl	8(%rbx), %edx
	movzwl	34(%rbx), %eax
	cmpw	%ax, %dx
	jb	.L528
	xorl	%edx, %edx
	movw	%dx, 8(%rbx)
.L528:
	movzbl	32(%rbx), %eax
	cmpb	%al, %sil
	je	.L533
.L526:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L533:
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
.L532:
	movl	%esi, %eax
	jmp	.L525
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
	je	.L534
	movzwl	8(%rbx), %r8d
	movq	(%rbx), %rdx
	call	memcpy
	movb	$0, 10(%rbx)
	movl	$1, %eax
.L534:
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
	je	.L540
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	subl	%edx, %eax
	cltq
	ret
	.p2align 4,,10
.L540:
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
	je	.L543
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %ecx
	subl	%edx, %eax
	cltq
	cmpq	%rax, %rcx
	sete	%al
	ret
	.p2align 4,,10
.L543:
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
	je	.L546
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
	ret
	.p2align 4,,10
.L546:
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
	je	.L549
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
	ret
	.p2align 4,,10
.L549:
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
	je	.L553
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	je	.L553
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
.L553:
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
	je	.L557
	testq	%rcx, %rcx
	je	.L557
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %r9d
	cmpw	%ax, %r9w
	je	.L557
	subl	$1, %r8d
	movq	%rdx, %r9
	movzwl	%r8w, %r8d
	addq	%rdx, %r8
	.p2align 4,,10
.L559:
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
	je	.L565
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	addq	$1, %r9
	cmpw	%ax, %dx
	jne	.L559
.L557:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L565:
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
	je	.L569
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %r8d
	subl	%edx, %eax
	cltq
	movzwl	%r8w, %edx
	cmpq	%rdx, %rax
	je	.L569
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
.L569:
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
	je	.L570
	xorl	%eax, %eax
	movw	%ax, (%rcx)
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, 2(%r9)
	movl	%r8d, %eax
	leal	-1(%rdx), %ecx
	testl	%edx, %ecx
	jne	.L580
.L572:
	movw	%ax, 16(%r9)
.L570:
	rep ret
	.p2align 4,,10
.L580:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L573:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L573
	movzwl	%r8w, %eax
	addl	$1, %eax
	shrl	%eax
	jmp	.L572
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
	jne	.L583
	cmpq	$0, (%rcx)
	je	.L587
.L583:
	movzbl	12(%rcx), %edx
	xorl	%eax, %eax
	testb	%dl, %dl
	je	.L582
	xorl	%eax, %eax
	xorl	%edx, %edx
	movq	$0, (%rcx)
	movw	%ax, 8(%rcx)
	movw	%dx, 10(%rcx)
	movl	$1, %eax
	movb	$0, 12(%rcx)
.L582:
	rep ret
	.p2align 4,,10
.L587:
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
	movzbl	12(%rcx), %eax
	cmpb	$1, %al
	je	.L594
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L594
	movzwl	10(%rcx), %eax
	cmpb	%dl, (%r8,%rax)
	je	.L595
.L591:
	movzbl	12(%rcx), %eax
	ret
	.p2align 4,,10
.L594:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L595:
	movzwl	10(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 10(%rcx)
	movzwl	10(%rcx), %eax
	cmpw	8(%rcx), %ax
	jne	.L591
	movb	$1, 12(%rcx)
	jmp	.L591
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
	jne	.L602
	jmp	.L601
	.p2align 4,,10
.L598:
	movswl	32(%rbx), %edx
	movq	%rdi, %rcx
	negl	%edx
	call	printf
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L601
.L602:
	movl	24(%rbx), %r9d
	movzbl	40(%rbx), %r8d
	movq	%rsi, %rcx
	movq	8(%rbx), %rdx
	call	printf
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	jne	.L598
	movq	%rbp, %rcx
	call	puts
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L602
.L601:
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
ChainIterator.3231:
	.quad	_qSysTick_Epochs_
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
	.def	__locale_ctype_ptr;	.scl	2;	.type	32;	.endef
	.def	toupper;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
