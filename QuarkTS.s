	.file	"QuarkTS.c"
	.section	.text.unlikely,"x"
.LCOLDB0:
	.text
.LHOTB0:
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
	jbe	.L20
	jmp	.L2
	.p2align 4,,10
.L22:
	movzbl	40(%rdx), %r8d
	movq	(%rax), %rcx
	movzbl	40(%rcx), %ecx
	cmpb	%cl, %r8b
	ja	.L3
	movq	(%rax), %rax
.L20:
	movq	(%rax), %rcx
	testq	%rcx, %rcx
	jne	.L22
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
	.section	.text.unlikely,"x"
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely,"x"
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	qTaskSelf
	.def	qTaskSelf;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSelf
qTaskSelf:
	.seh_endprologue
	movq	104+QUARKTS(%rip), %rax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely,"x"
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	qTaskIsEnabled
	.def	qTaskIsEnabled;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskIsEnabled
qTaskIsEnabled:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L26
	movzbl	58(%rcx), %eax
	ret
	.p2align 4,,10
.L26:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely,"x"
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	qSchedulerSetIdleTask
	.def	qSchedulerSetIdleTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetIdleTask
qSchedulerSetIdleTask:
	.seh_endprologue
	movq	%rcx, QUARKTS(%rip)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely,"x"
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4,,15
	.globl	qSchedulerRelease
	.def	qSchedulerRelease;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRelease
qSchedulerRelease:
	.seh_endprologue
	movb	$1, 82+QUARKTS(%rip)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely,"x"
.LCOLDB5:
	.text
.LHOTB5:
	.p2align 4,,15
	.globl	qSchedulerSetReleaseCallback
	.def	qSchedulerSetReleaseCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetReleaseCallback
qSchedulerSetReleaseCallback:
	.seh_endprologue
	movq	%rcx, 8+QUARKTS(%rip)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely,"x"
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.globl	qTaskGetCycles
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskGetCycles
qTaskGetCycles:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L32
	movl	36(%rcx), %eax
	ret
	.p2align 4,,10
.L32:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely,"x"
.LCOLDB7:
	.text
.LHOTB7:
	.p2align 4,,15
	.globl	qTaskSendEvent
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSendEvent
qTaskSendEvent:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L33
	movb	$1, 57(%rcx)
	movq	%rdx, 16(%rcx)
.L33:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely,"x"
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.globl	qTaskSetTime
	.def	qTaskSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetTime
qTaskSetTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L38
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 24(%rcx)
.L38:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely,"x"
.LCOLDB9:
	.text
.LHOTB9:
	.p2align 4,,15
	.globl	qTaskSetIterations
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetIterations
qTaskSetIterations:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L43
	movl	%edx, %eax
	negl	%eax
	cmpw	$-32768, %dx
	cmovne	%eax, %edx
	movw	%dx, 32(%rcx)
.L43:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely,"x"
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.globl	qTaskSetPriority
	.def	qTaskSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetPriority
qTaskSetPriority:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L50
	movb	$0, 80+QUARKTS(%rip)
	movb	%dl, 40(%rcx)
.L50:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely,"x"
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4,,15
	.globl	qTaskSetCallback
	.def	qTaskSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetCallback
qTaskSetCallback:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L55
	movq	%rdx, 48(%rcx)
.L55:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE11:
	.text
.LHOTE11:
	.section	.text.unlikely,"x"
.LCOLDB12:
	.text
.LHOTB12:
	.p2align 4,,15
	.globl	qTaskSetState
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetState
qTaskSetState:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L60
	testb	%dl, %dl
	je	.L62
	movzbl	58(%rcx), %eax
	testb	%al, %al
	jne	.L60
.L62:
	movb	%dl, 58(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L60:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE12:
	.text
.LHOTE12:
	.section	.text.unlikely,"x"
.LCOLDB13:
	.text
.LHOTB13:
	.p2align 4,,15
	.globl	qTaskSetData
	.def	qTaskSetData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetData
qTaskSetData:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L66
	movq	%rdx, 8(%rcx)
.L66:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE13:
	.text
.LHOTE13:
	.section	.text.unlikely,"x"
.LCOLDB14:
	.text
.LHOTB14:
	.p2align 4,,15
	.globl	qTaskClearTimeElapsed
	.def	qTaskClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskClearTimeElapsed
qTaskClearTimeElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L71
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L71:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE14:
	.text
.LHOTE14:
	.section	.text.unlikely,"x"
.LCOLDB15:
	.text
.LHOTB15:
	.p2align 4,,15
	.globl	qTaskQueueEvent
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskQueueEvent
qTaskQueueEvent:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L78
	movswl	98+QUARKTS(%rip), %r9d
	movzbl	96+QUARKTS(%rip), %r8d
	xorl	%eax, %eax
	subl	$1, %r8d
	cmpl	%r8d, %r9d
	jge	.L77
	movq	88+QUARKTS(%rip), %r9
	movzwl	98+QUARKTS(%rip), %r8d
	leal	1(%r8), %eax
	movw	%ax, 98+QUARKTS(%rip)
	movswq	%ax, %rax
	salq	$4, %rax
	addq	%r9, %rax
	movq	%rcx, (%rax)
	movq	%rdx, 8(%rax)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L78:
	xorl	%eax, %eax
.L77:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE15:
	.text
.LHOTE15:
	.section	.text.unlikely,"x"
.LCOLDB16:
	.text
.LHOTB16:
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
	.section	.text.unlikely,"x"
.LCOLDE16:
	.text
.LHOTE16:
	.section	.text.unlikely,"x"
.LCOLDB17:
	.text
.LHOTB17:
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
	xorl	%edx, %edx
	movzbl	96+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L83
	.p2align 4,,10
.L85:
	movq	88+QUARKTS(%rip), %rcx
	movzbl	%dl, %eax
	addl	$1, %edx
	salq	$4, %rax
	addq	%rcx, %rax
	movq	$0, (%rax)
	movzbl	96+QUARKTS(%rip), %eax
	cmpb	%dl, %al
	ja	.L85
.L83:
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
	.section	.text.unlikely,"x"
.LCOLDE17:
	.text
.LHOTE17:
	.section	.text.unlikely,"x"
.LCOLDB18:
	.text
.LHOTB18:
	.p2align 4,,15
	.globl	qSchedulerRemoveTask
	.def	qSchedulerRemoveTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRemoveTask
qSchedulerRemoveTask:
	.seh_endprologue
	movq	56+QUARKTS(%rip), %rdx
	testq	%rdx, %rdx
	je	.L95
	cmpq	%rcx, %rdx
	je	.L90
	movq	(%rdx), %rax
	testq	%rax, %rax
	jne	.L92
	jmp	.L95
	.p2align 4,,10
.L98:
	movq	(%rax), %r8
	movq	%rax, %rdx
	testq	%r8, %r8
	je	.L95
.L92:
	movq	(%rdx), %rax
	cmpq	%rax, %rcx
	jne	.L98
	movq	(%rcx), %rax
	movq	%rax, (%rdx)
.L93:
	movq	$0, (%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L95:
	xorl	%eax, %eax
	ret
.L90:
	movq	(%rcx), %rax
	movq	%rax, 56+QUARKTS(%rip)
	jmp	.L93
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE18:
	.text
.LHOTE18:
	.section	.text.unlikely,"x"
.LCOLDB21:
	.text
.LHOTB21:
	.p2align 4,,15
	.globl	qSchedulerAddxTask
	.def	qSchedulerAddxTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddxTask
qSchedulerAddxTask:
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
	subq	$48, %rsp
	.seh_stackalloc	48
	movaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	movq	%rdx, %rdi
	movl	%r8d, %r12d
	movaps	%xmm3, %xmm6
	movl	128(%rsp), %esi
	movl	136(%rsp), %ebp
	je	.L103
	movss	.LC19(%rip), %xmm0
	mulss	%xmm3, %xmm0
	movss	48+QUARKTS(%rip), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L107
	pxor	%xmm0, %xmm0
	movl	$1, %ecx
	ucomiss	%xmm0, %xmm3
	setp	%al
	cmove	%eax, %ecx
	xorl	%eax, %eax
	testb	%cl, %cl
	je	.L107
.L100:
	movaps	32(%rsp), %xmm6
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
.L107:
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L100
	movq	%rbx, %rcx
	call	qSchedulerRemoveTask
	movq	%rdi, 48(%rbx)
	leaq	56+QUARKTS(%rip), %rcx
	movq	%rbx, %rdx
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm6
	cvttss2siq	%xmm6, %rax
	movl	%eax, 24(%rbx)
	movq	144(%rsp), %rax
	movq	%rax, 8(%rbx)
	movl	%esi, %eax
	movb	%r12b, 40(%rbx)
	negl	%eax
	cmpw	$-32768, %si
	cmovne	%eax, %esi
	testb	%bpl, %bpl
	setne	%al
	movw	%si, 32(%rbx)
	movb	$0, 62(%rbx)
	movb	$0, 61(%rbx)
	movb	$0, 61(%rbx)
	movb	$0, 59(%rbx)
	movb	$0, 56(%rbx)
	movb	$0, 57(%rbx)
	movb	%al, 58(%rbx)
	movq	$0, (%rbx)
	movl	$0, 36(%rbx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rbx)
	movq	$0, 64(%rbx)
	movq	$0, 72(%rbx)
	movb	$3, 80(%rbx)
	call	_qScheduler_PriorizedInsert
	nop
	movaps	32(%rsp), %xmm6
	movl	$1, %eax
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
.L103:
	movaps	32(%rsp), %xmm6
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE21:
	.text
.LHOTE21:
	.section	.text.unlikely,"x"
.LCOLDB22:
	.text
.LHOTB22:
	.p2align 4,,15
	.globl	qSchedulerAddeTask
	.def	qSchedulerAddeTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddeTask
qSchedulerAddeTask:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	pxor	%xmm3, %xmm3
	movq	%r9, 48(%rsp)
	movl	$0, 40(%rsp)
	movzbl	%r8b, %r8d
	movl	$1, 32(%rsp)
	call	qSchedulerAddxTask
	addq	$72, %rsp
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE22:
	.text
.LHOTE22:
	.section	.text.unlikely,"x"
.LCOLDB23:
	.text
.LHOTB23:
	.p2align 4,,15
	.globl	qTaskLinkRBuffer
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskLinkRBuffer
qTaskLinkRBuffer:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L116
	testq	%rcx, %rcx
	je	.L116
	leal	-3(%r8), %r10d
	xorl	%eax, %eax
	cmpl	$3, %r10d
	ja	.L113
	cmpq	$0, (%rdx)
	je	.L113
	cmpl	$5, %r8d
	movl	%r9d, %eax
	je	.L114
	testb	%r9b, %r9b
	setne	%al
.L114:
	movl	%r8d, %r8d
	testb	%r9b, %r9b
	movb	%al, 56(%rcx,%r8)
	movl	$0, %eax
	cmove	%rax, %rdx
	movl	$1, %eax
	movq	%rdx, 64(%rcx)
	ret
	.p2align 4,,10
.L116:
	xorl	%eax, %eax
.L113:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE23:
	.text
.LHOTE23:
	.section	.text.unlikely,"x"
.LCOLDB24:
	.text
.LHOTB24:
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
	.section	.text.unlikely,"x"
.LCOLDE24:
	.text
.LHOTE24:
	.section	.text.unlikely,"x"
.LCOLDB25:
	.text
.LHOTB25:
	.p2align 4,,15
	.globl	qStateMachine_Init
	.def	qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Init
qStateMachine_Init:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L125
	testq	%rdx, %rdx
	je	.L125
	movq	40(%rsp), %rax
	movq	%rdx, (%rcx)
	movq	$0, 8(%rcx)
	movb	$0, 20(%rcx)
	movl	$-32768, 16(%rcx)
	movq	%r9, 32(%rcx)
	movq	%r8, 40(%rcx)
	movq	%rax, 48(%rcx)
	movq	48(%rsp), %rax
	movq	%rax, 56(%rcx)
	movq	$0, 64(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L125:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE25:
	.text
.LHOTE25:
	.section	.text.unlikely,"x"
.LCOLDB26:
	.text
.LHOTB26:
	.p2align 4,,15
	.globl	qSchedulerAddSMTask
	.def	qSchedulerAddSMTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddSMTask
qSchedulerAddSMTask:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	movl	168(%rsp), %eax
	testq	%r9, %r9
	movq	%rcx, %rsi
	movq	%r9, %rbx
	je	.L130
	cmpq	$0, 128(%rsp)
	je	.L130
	movq	176(%rsp), %rcx
	movzbl	%al, %eax
	movzbl	%dl, %r8d
	movaps	%xmm2, %xmm3
	movl	%eax, 40(%rsp)
	movl	$-32768, 32(%rsp)
	movl	$1, %edx
	movq	%rcx, 48(%rsp)
	movq	%rsi, %rcx
	call	qSchedulerAddxTask
	testb	%al, %al
	jne	.L134
.L130:
	xorl	%eax, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L134:
	movq	136(%rsp), %rax
	movq	152(%rsp), %r9
	movq	%rbx, %rcx
	movq	144(%rsp), %r8
	movq	128(%rsp), %rdx
	movq	%rax, 40(%rsp)
	movq	160(%rsp), %rax
	movq	%rax, 32(%rsp)
	call	qStateMachine_Init
	movl	$1, %eax
	movq	%rbx, 72(%rsi)
	addq	$72, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE26:
	.text
.LHOTE26:
	.section	.text.unlikely,"x"
.LCOLDB27:
	.text
.LHOTB27:
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
	je	.L135
	movq	%rdx, 24(%rcx)
	movq	56(%rcx), %rax
	movq	%rcx, %rbx
	testq	%rax, %rax
	je	.L138
	movq	56(%rcx), %rax
	call	*%rax
.L138:
	movq	(%rbx), %rax
	testq	%rax, %rax
	je	.L139
	movq	64(%rbx), %rdx
	movq	(%rbx), %rax
	cmpq	%rax, %rdx
	setne	%al
	movb	%al, 20(%rbx)
	movzbl	20(%rbx), %eax
	testb	%al, %al
	jne	.L163
.L140:
	movq	(%rbx), %rsi
	movq	%rbx, %rcx
	movq	(%rbx), %rax
	call	*%rax
	movl	%eax, 16(%rbx)
	movq	%rsi, 64(%rbx)
.L141:
	movl	16(%rbx), %eax
	cmpl	$-32768, %eax
	je	.L143
	cmpl	$-32767, %eax
	je	.L164
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L135
	movq	48(%rbx), %rax
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp *%rax
	.p2align 4,,10
.L163:
	movq	64(%rbx), %rax
	movq	%rax, 8(%rbx)
	jmp	.L140
	.p2align 4,,10
.L164:
	movq	32(%rbx), %rax
	testq	%rax, %rax
	je	.L135
	movq	32(%rbx), %rax
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp *%rax
	.p2align 4,,10
.L135:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L143:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L135
	movq	40(%rbx), %rax
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp *%rax
	.p2align 4,,10
.L139:
	movl	$-32767, 16(%rbx)
	jmp	.L141
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE27:
	.text
.LHOTE27:
	.section	.text.unlikely,"x"
.LCOLDB28:
	.text
.LHOTB28:
	.p2align 4,,15
	.globl	qStateMachine_Attribute
	.def	qStateMachine_Attribute;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Attribute
qStateMachine_Attribute:
	.seh_endprologue
	cmpl	$5, %edx
	ja	.L165
	leaq	.L168(%rip), %rax
	movl	%edx, %edx
	movslq	(%rax,%rdx,4), %rdx
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L168:
	.long	.L167-.L168
	.long	.L169-.L168
	.long	.L170-.L168
	.long	.L171-.L168
	.long	.L172-.L168
	.long	.L173-.L168
	.text
	.p2align 4,,10
.L173:
	movq	%r8, 56(%rcx)
.L165:
	rep ret
	.p2align 4,,10
.L172:
	movq	%r8, 48(%rcx)
	ret
	.p2align 4,,10
.L167:
	movq	%r8, (%rcx)
	movq	$0, 8(%rcx)
	movq	$0, 64(%rcx)
	movb	$0, 20(%rcx)
	movl	$-32768, 16(%rcx)
	ret
	.p2align 4,,10
.L169:
	movq	$0, 8(%rcx)
	movq	$0, 64(%rcx)
	ret
	.p2align 4,,10
.L170:
	movq	%r8, 32(%rcx)
	ret
	.p2align 4,,10
.L171:
	movq	%r8, 40(%rcx)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE28:
	.text
.LHOTE28:
	.section	.text.unlikely,"x"
.LCOLDB30:
	.text
.LHOTB30:
	.p2align 4,,15
	.globl	qSTimerSet
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerSet
qSTimerSet:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L176
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	xorl	%eax, %eax
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC29(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	ja	.L175
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
.L176:
	xorl	%eax, %eax
.L175:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE30:
	.text
.LHOTE30:
	.section	.text.unlikely,"x"
.LCOLDB31:
	.text
.LHOTB31:
	.p2align 4,,15
	.globl	qSTimerFreeRun
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerFreeRun
qSTimerFreeRun:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L182
	movzbl	(%rcx), %ebx
	testb	%bl, %bl
	je	.L180
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	jb	.L182
	movl	$1, %ebx
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
	movl	%ebx, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L180:
	call	qSTimerSet
	movl	%ebx, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L182:
	xorl	%ebx, %ebx
	movl	%ebx, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE31:
	.text
.LHOTE31:
	.section	.text.unlikely,"x"
.LCOLDB32:
	.text
.LHOTB32:
	.p2align 4,,15
	.globl	qSTimerExpired
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerExpired
qSTimerExpired:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L185
	movzbl	(%rcx), %eax
	testb	%al, %al
	je	.L184
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	setnb	%al
	ret
	.p2align 4,,10
.L185:
	xorl	%eax, %eax
.L184:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE32:
	.text
.LHOTE32:
	.section	.text.unlikely,"x"
.LCOLDB33:
	.text
.LHOTB33:
	.p2align 4,,15
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L191
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	ret
	.p2align 4,,10
.L191:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE33:
	.text
.LHOTE33:
	.section	.text.unlikely,"x"
.LCOLDB34:
	.text
.LHOTB34:
	.p2align 4,,15
	.globl	qSTimerRemaining
	.def	qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerRemaining
qSTimerRemaining:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L194
	movl	8(%rcx), %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %r8d
	testl	%eax, %eax
	jne	.L198
	rep ret
	.p2align 4,,10
.L198:
	subl	%r8d, %edx
	movl	%eax, %ecx
	subl	%edx, %ecx
	cmpl	%edx, %eax
	cmovnb	%ecx, %eax
	ret
	.p2align 4,,10
.L194:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE34:
	.text
.LHOTE34:
	.section	.text.unlikely,"x"
.LCOLDB35:
	.text
.LHOTB35:
	.p2align 4,,15
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L199
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L199:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE35:
	.text
.LHOTE35:
	.section	.text.unlikely,"x"
.LCOLDB36:
	.text
.LHOTB36:
	.p2align 4,,15
	.globl	qMemoryAlloc
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryAlloc
qMemoryAlloc:
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
	testq	%rcx, %rcx
	movq	%rcx, %r12
	movl	%edx, %r13d
	movl	%edx, %edi
	je	.L238
	movq	64+QUARKTS(%rip), %rax
	movq	16(%rcx), %r14
	testq	%rax, %rax
	je	.L207
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L207:
	movzbl	2(%r12), %ebp
	xorl	%edx, %edx
.L220:
	cmpb	%bpl, %dl
	jnb	.L219
	movq	8(%r12), %rax
	movzbl	%dl, %r10d
	movzwl	(%r12), %esi
	leaq	(%rax,%r10), %rcx
	movzbl	(%rcx), %r8d
	testb	%r8b, %r8b
	je	.L208
	movzwl	%si, %r9d
.L222:
	movzbl	%r8b, %ecx
	addl	%r8d, %edx
	imull	%r9d, %ecx
	movslq	%ecx, %rcx
	addq	%rcx, %r14
	cmpb	%dl, %bpl
	jbe	.L239
	movzbl	%dl, %r10d
	leaq	(%rax,%r10), %rcx
	movzbl	(%rcx), %r8d
	testb	%r8b, %r8b
	jne	.L222
.L208:
	cmpw	%si, %di
	jbe	.L227
	movl	%esi, %r9d
	movl	%edx, %r8d
	movl	$1, %r11d
	jmp	.L212
	.p2align 4,,10
.L218:
	movzbl	%r8b, %r10d
	movzbl	(%rax,%r10), %ebx
	testb	%bl, %bl
	jne	.L240
	addl	%esi, %r9d
	cmpw	%di, %r9w
	jnb	.L224
.L212:
	addl	$1, %r8d
	addl	$1, %r11d
	cmpb	%r8b, %bpl
	ja	.L218
	cmpb	%r8b, %bpl
	jne	.L220
.L219:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L238
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L238:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L227:
	movl	$1, %r11d
	.p2align 4,,10
.L224:
	addq	%r14, %r10
	xorl	%eax, %eax
	testw	%r13w, %r13w
	movb	%r11b, (%rcx)
	je	.L217
	.p2align 4,,10
.L232:
	addl	$1, %eax
	movzbl	%al, %edx
	cmpw	%dx, %di
	ja	.L232
	movb	$0, (%r10)
.L217:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L215
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L215:
	movq	%r14, %rax
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
.L240:
	leal	(%rbx,%r8), %edx
	movzbl	%dl, %eax
	imull	%esi, %eax
	cltq
	addq	16(%r12), %rax
	cmpb	%r8b, %bpl
	movq	%rax, %r14
	jne	.L220
	jmp	.L219
.L239:
	movl	%edx, %r8d
	cmpb	%r8b, %bpl
	jne	.L220
	jmp	.L219
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE36:
	.text
.LHOTE36:
	.section	.text.unlikely,"x"
.LCOLDB37:
	.text
.LHOTB37:
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
	je	.L241
	testq	%rdx, %rdx
	je	.L241
	movq	64+QUARKTS(%rip), %rax
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	testq	%rax, %rax
	je	.L245
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L245:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L246
	cmpq	%r8, %rbx
	je	.L265
	movzwl	(%rsi), %r10d
	xorl	%eax, %eax
	addq	%r10, %r8
	jmp	.L249
	.p2align 4,,10
.L250:
	cmpq	%r8, %rbx
	leaq	(%r8,%r10), %r9
	je	.L266
	movq	%r9, %r8
.L249:
	addl	$1, %eax
	cmpb	%dl, %al
	jne	.L250
.L246:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L241
.L267:
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp *%rax
	.p2align 4,,10
.L241:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L266:
	movzbl	%al, %eax
.L247:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	jne	.L267
	jmp	.L241
.L265:
	xorl	%eax, %eax
	jmp	.L247
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE37:
	.text
.LHOTE37:
	.section	.text.unlikely,"x"
.LCOLDB38:
	.text
.LHOTB38:
	.p2align 4,,15
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
	.seh_endprologue
	movq	%rcx, %rax
	movl	%r9d, %ecx
	testq	%rax, %rax
	je	.L268
	testq	%rdx, %rdx
	je	.L268
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	movq	%rdx, (%rax)
	movzwl	%r9w, %edx
	movw	%r10w, 12(%rax)
	movw	%r11w, 14(%rax)
	movw	%r8w, 8(%rax)
	leal	-1(%rdx), %r8d
	testl	%edx, %r8d
	jne	.L276
	movw	%cx, 10(%rax)
.L268:
	rep ret
	.p2align 4,,10
.L276:
	subl	$1, %r9d
	movl	$4, %r8d
	movl	$1, %ecx
.L271:
	movzwl	%r9w, %edx
	sarl	%cl, %edx
	addl	%ecx, %ecx
	orl	%edx, %r9d
	subl	$1, %r8d
	jne	.L271
	movzwl	%r9w, %ecx
	addl	$1, %ecx
	shrl	%ecx
	movw	%cx, 10(%rax)
	jmp	.L268
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE38:
	.text
.LHOTE38:
	.section	.text.unlikely,"x"
.LCOLDB39:
	.text
.LHOTB39:
	.p2align 4,,15
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L279
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
	ret
	.p2align 4,,10
.L279:
	movl	$1, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE39:
	.text
.LHOTE39:
	.section	.text.unlikely,"x"
.LCOLDB40:
	.text
.LHOTB40:
	.p2align 4,,15
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L283
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	jne	.L282
.L283:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L282:
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r9d
	xorl	%edx, %edx
	movzwl	8(%rcx), %r8d
	divw	%r9w
	movzwl	%dx, %eax
	imull	%r8d, %eax
	cltq
	addq	(%rcx), %rax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE40:
	.text
.LHOTE40:
	.section	.text.unlikely,"x"
.LCOLDB41:
	.text
.LHOTB41:
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
	ja	.L286
	leaq	.L288(%rip), %rax
	movl	%edx, %edx
	movslq	(%rax,%rdx,4), %rdx
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L288:
	.long	.L286-.L288
	.long	.L287-.L288
	.long	.L289-.L288
	.long	.L290-.L288
	.long	.L291-.L288
	.long	.L292-.L288
	.long	.L292-.L288
	.long	.L292-.L288
	.long	.L286-.L288
	.long	.L293-.L288
	.text
	.p2align 4,,10
.L287:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L294
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L319
.L294:
	movb	$0, 41+QUARKTS(%rip)
	movzwl	32(%rbx), %eax
.L301:
	movw	%ax, 32(%rbx)
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L296
	movzwl	32(%rbx), %eax
	subl	$1, %eax
	movw	%ax, 32(%rbx)
.L296:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	sete	%al
	testb	%al, %al
	movb	%al, 42+QUARKTS(%rip)
	je	.L286
	movb	$0, 58(%rbx)
	.p2align 4,,10
.L286:
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
	je	.L298
	movq	48(%rbx), %rax
	cmpq	$1, %rax
	je	.L320
.L298:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L299
	movq	48(%rbx), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
.L299:
	cmpl	$4, %esi
	movq	$0, 104+QUARKTS(%rip)
	je	.L321
.L300:
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
.L289:
	movq	112+QUARKTS(%rip), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movq	$0, 112+QUARKTS(%rip)
.L293:
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
.L321:
	movq	64(%rbx), %rdx
	movzwl	14(%rdx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rdx)
	jmp	.L300
	.p2align 4,,10
.L292:
	movq	64(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L286
	.p2align 4,,10
.L290:
	movq	16(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movb	$0, 57(%rcx)
	jmp	.L286
	.p2align 4,,10
.L291:
	movq	64(%rcx), %rcx
	call	qRBufferGetFront
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L286
	.p2align 4,,10
.L320:
	movq	72(%rbx), %rcx
	leaq	16+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L299
	.p2align 4,,10
.L319:
	movb	$1, 41+QUARKTS(%rip)
	movzwl	32(%rcx), %eax
	negl	%eax
	jmp	.L301
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE41:
	.text
.LHOTE41:
	.section	.text.unlikely,"x"
.LCOLDB42:
	.text
.LHOTB42:
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
	leaq	56(%rsp), %rsi
	movb	$1, 80+QUARKTS(%rip)
	.p2align 4,,10
.L370:
	movzbl	80+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L427
.L323:
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	js	.L330
.L433:
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L331
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L331:
	movq	88+QUARKTS(%rip), %rax
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
	movzbl	96+QUARKTS(%rip), %eax
	cmpb	$1, %al
	jbe	.L376
	movq	88+QUARKTS(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L376
	xorl	%edx, %edx
	movl	$16, %eax
	movl	$1, %ecx
	jmp	.L334
	.p2align 4,,10
.L336:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%cl, %eax
	salq	$4, %rax
	addq	%rax, %r8
	movq	(%r8), %r8
	testq	%r8, %r8
	je	.L425
.L334:
	movq	88+QUARKTS(%rip), %r8
	addq	%rax, %r8
	movq	(%r8), %r8
	movzbl	40(%r8), %r8d
	cmpb	%r9b, %r8b
	jbe	.L335
	movq	88+QUARKTS(%rip), %rdx
	addq	%rdx, %rax
	movl	%ecx, %edx
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
.L335:
	movzbl	96+QUARKTS(%rip), %eax
	addl	$1, %ecx
	cmpb	%al, %cl
	jb	.L336
.L425:
	movzbl	%dl, %eax
	movzbl	%dl, %r8d
	salq	$4, %rax
.L332:
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
	cmpl	%r8d, %eax
	jle	.L341
	.p2align 4,,10
.L406:
	movq	88+QUARKTS(%rip), %r8
	movq	88+QUARKTS(%rip), %rcx
	movzbl	%dl, %eax
	salq	$4, %rax
	addl	$1, %edx
	addq	%rax, %r8
	leaq	16(%rcx,%rax), %rax
	movq	(%rax), %rcx
	movq	8(%rax), %rbx
	movq	%rcx, (%r8)
	movq	%rbx, 8(%r8)
	movzbl	%dl, %r8d
	movswl	98+QUARKTS(%rip), %eax
	cmpl	%eax, %r8d
	jl	.L406
.L341:
	movzwl	98+QUARKTS(%rip), %eax
	subl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L339
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L339:
	movl	$2, %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movb	%al, 80(%rdi)
	movq	56+QUARKTS(%rip), %rbx
	testq	%rbx, %rbx
	je	.L369
.L372:
	xorl	%ebp, %ebp
	jmp	.L362
	.p2align 4,,10
.L430:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	js	.L428
.L343:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	jle	.L345
.L344:
	movl	24(%rbx), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm6, %xmm0
	jp	.L386
	je	.L347
.L386:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	28(%rbx), %ecx
	movl	24(%rbx), %edx
	subl	%ecx, %eax
	cmpl	%edx, %eax
	jnb	.L347
.L346:
	movb	$3, 80(%rbx)
.L351:
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L429
.L362:
	movzbl	58(%rbx), %eax
	testb	%al, %al
	jne	.L430
	movq	64(%rbx), %rax
	testq	%rax, %rax
	je	.L361
	movzbl	60(%rbx), %eax
	testb	%al, %al
	je	.L353
	movq	64(%rbx), %rax
	testq	%rax, %rax
	je	.L378
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %r8d
	movzwl	10(%rax), %ecx
	movl	%edx, %eax
	subl	%r8d, %eax
	cmpw	%cx, %ax
	je	.L378
.L353:
	movzbl	61(%rbx), %eax
	testb	%al, %al
	je	.L355
	movq	64(%rbx), %rax
	testq	%rax, %rax
	je	.L379
	movzwl	12(%rax), %ecx
	movzwl	14(%rax), %eax
	subl	%eax, %ecx
.L356:
	movzbl	61(%rbx), %eax
	movl	$6, %edx
	cmpw	%cx, %ax
	ja	.L355
.L373:
	movb	$1, 80(%rbx)
	movl	%edx, 84(%rbx)
	movl	$1, %ebp
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L362
	.p2align 4,,10
.L429:
	testb	%bpl, %bpl
	je	.L363
	movq	ChainIterator.3243(%rip), %rbx
	jmp	.L364
	.p2align 4,,10
.L365:
	testq	%rbx, %rbx
	je	.L366
.L431:
	movq	(%rbx), %rax
	movzbl	80(%rbx), %edx
	movq	%rax, ChainIterator.3243(%rip)
	cmpb	$1, %dl
	je	.L367
	xorl	%edx, %edx
.L368:
	movb	%dl, 80(%rbx)
	movq	%rax, %rbx
.L364:
	cmpq	$-1, %rbx
	jne	.L365
	movq	56+QUARKTS(%rip), %rbx
	testq	%rbx, %rbx
	movq	%rbx, ChainIterator.3243(%rip)
	jne	.L431
	.p2align 4,,10
.L366:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3243(%rip)
.L369:
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L370
.L432:
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
	je	.L371
	movq	8+QUARKTS(%rip), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
	nop
.L371:
	movaps	64(%rsp), %xmm6
	movb	$1, 81+QUARKTS(%rip)
	addq	$88, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L347:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	$1, %ebp
	movl	%eax, 28(%rbx)
	movb	$1, 80(%rbx)
	movl	$1, 84(%rbx)
	jmp	.L351
	.p2align 4,,10
.L428:
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L343
	movzwl	32(%rbx), %eax
	testw	$-32768, %ax
	jne	.L344
	.p2align 4,,10
.L345:
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	jne	.L346
	jmp	.L344
	.p2align 4,,10
.L361:
	movzbl	57(%rbx), %eax
	testb	%al, %al
	je	.L346
	movb	$1, 80(%rbx)
	movl	$1, %ebp
	movl	$3, 84(%rbx)
	jmp	.L351
	.p2align 4,,10
.L355:
	movzbl	59(%rbx), %eax
	testb	%al, %al
	jne	.L358
.L360:
	movzbl	62(%rbx), %eax
	testb	%al, %al
	je	.L361
	movq	64(%rbx), %rax
	testq	%rax, %rax
	je	.L383
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %eax
	cmpw	%ax, %dx
	jne	.L361
.L383:
	movl	$7, %edx
	jmp	.L373
	.p2align 4,,10
.L367:
	movl	84(%rbx), %edx
	movq	%rbx, %rcx
	call	_qScheduler_Dispatch
	movl	%eax, %edx
	movq	ChainIterator.3243(%rip), %rax
	jmp	.L368
	.p2align 4,,10
.L378:
	movl	$5, %edx
	jmp	.L373
	.p2align 4,,10
.L363:
	testq	%rdi, %rdi
	jne	.L369
.L374:
	movq	QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L369
	xorl	%ecx, %ecx
	movl	$9, %edx
	call	_qScheduler_Dispatch
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L370
	jmp	.L432
	.p2align 4,,10
.L358:
	movq	64(%rbx), %rcx
	call	qRBufferGetFront
	testq	%rax, %rax
	movl	$4, %edx
	jne	.L373
	jmp	.L360
	.p2align 4,,10
.L427:
	movq	64+QUARKTS(%rip), %rax
	movq	$0, 56(%rsp)
	movq	56+QUARKTS(%rip), %rdx
	testq	%rax, %rax
	je	.L424
	movq	%rdx, 40(%rsp)
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movq	40(%rsp), %rdx
	movl	%eax, 84+QUARKTS(%rip)
	jmp	.L424
	.p2align 4,,10
.L407:
	movq	(%rdx), %rbx
	movq	%rsi, %rcx
	call	_qScheduler_PriorizedInsert
	movq	%rbx, %rdx
.L424:
	testq	%rdx, %rdx
	jne	.L407
	movq	56(%rsp), %rax
	movb	$1, 80+QUARKTS(%rip)
	movq	%rax, 56+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L323
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	jns	.L433
.L330:
	movq	56+QUARKTS(%rip), %rbx
	xorl	%edi, %edi
	testq	%rbx, %rbx
	jne	.L372
	jmp	.L374
	.p2align 4,,10
.L379:
	xorl	%ecx, %ecx
	jmp	.L356
.L376:
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L332
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE42:
	.text
.LHOTE42:
	.section	.text.unlikely,"x"
.LCOLDB43:
	.text
.LHOTB43:
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
	testq	%rcx, %rcx
	je	.L437
	movzwl	12(%rcx), %r8d
	movzwl	14(%rcx), %eax
	cmpw	%ax, %r8w
	jne	.L436
.L437:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L436:
	movq	%rcx, %rbx
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %ecx
	movq	%rdx, %r10
	xorl	%edx, %edx
	movzwl	8(%rbx), %r9d
	movzwl	8(%rbx), %r8d
	divw	%cx
	movq	%r10, %rcx
	movzwl	%dx, %eax
	imull	%eax, %r9d
	movslq	%r9d, %r9
	movq	%r9, %rdx
	addq	(%rbx), %rdx
	call	memcpy
	movzwl	14(%rbx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rbx)
	movl	$1, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE43:
	.text
.LHOTE43:
	.section	.text.unlikely,"x"
.LCOLDB44:
	.text
.LHOTB44:
	.p2align 4,,15
	.globl	qRBufferPush
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPush
qRBufferPush:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rdx, %r11
	je	.L448
	testq	%rdx, %rdx
	je	.L448
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %r9d
	movzwl	10(%rcx), %r8d
	subl	%r9d, %edx
	cmpw	%r8w, %dx
	je	.L448
	movzwl	12(%rcx), %eax
	movzwl	10(%rcx), %r9d
	xorl	%edx, %edx
	movzwl	8(%rcx), %r8d
	movq	(%rcx), %rbx
	divw	%r9w
	xorl	%eax, %eax
	movzwl	%dx, %r10d
	movzwl	8(%rcx), %edx
	imull	%r8d, %r10d
	testw	%dx, %dx
	movslq	%r10d, %r10
	je	.L443
	.p2align 4,,10
.L449:
	movzwl	%ax, %r9d
	addl	$1, %eax
	leaq	(%r9,%r10), %r8
	movzbl	(%r11,%r9), %r9d
	addq	%rbx, %r8
	movb	%r9b, (%r8)
	movzwl	8(%rcx), %r8d
	cmpw	%ax, %r8w
	ja	.L449
.L443:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
.L448:
	popq	%rbx
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE44:
	.text
.LHOTE44:
	.section	.text.unlikely,"x"
.LCOLDB45:
	.text
.LHOTB45:
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
	je	.L453
	.p2align 4,,10
.L457:
	movzbl	(%rcx,%rdx), %r8d
	movzbl	(%rcx,%rax), %r9d
	movb	%r9b, (%rcx,%rdx)
	movb	%r8b, (%rcx,%rax)
	addq	$1, %rdx
	subq	$1, %rax
	cmpq	%rax, %rdx
	jb	.L457
.L453:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE45:
	.text
.LHOTE45:
	.section	.text.unlikely,"x"
.LCOLDB46:
	.text
.LHOTB46:
	.p2align 4,,15
	.globl	qCheckEndianness
	.def	qCheckEndianness;	.scl	2;	.type	32;	.endef
	.seh_proc	qCheckEndianness
qCheckEndianness:
	.seh_endprologue
	movl	$1, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE46:
	.text
.LHOTE46:
	.section	.text.unlikely,"x"
.LCOLDB47:
	.text
.LHOTB47:
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
	je	.L460
	.p2align 4,,10
.L464:
	movsbl	(%rdi,%rbx), %edx
	addq	$1, %rbx
	movq	%rbp, %rcx
	call	*%r12
	cmpq	%rsi, %rbx
	jne	.L464
.L460:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE47:
	.text
.LHOTE47:
	.section	.text.unlikely,"x"
.LCOLDB48:
	.text
.LHOTB48:
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
	movzbl	(%r8), %eax
	movq	%rcx, %rdi
	movq	%rdx, %rsi
	movq	%r8, %rbx
	testb	%al, %al
	je	.L466
	.p2align 4,,10
.L470:
	addq	$1, %rbx
	movsbl	%al, %edx
	movq	%rsi, %rcx
	call	*%rdi
	movzbl	(%rbx), %eax
	testb	%al, %al
	jne	.L470
.L466:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE48:
	.text
.LHOTE48:
	.section	.text.unlikely,"x"
.LCOLDB49:
	.text
.LHOTB49:
	.p2align 4,,15
	.globl	qISR_ByteBufferInit
	.def	qISR_ByteBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferInit
qISR_ByteBufferInit:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L474
	cmpw	$1, %r8w
	jbe	.L474
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
.L474:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE49:
	.text
.LHOTE49:
	.section	.text.unlikely,"x"
.LCOLDB50:
	.text
.LHOTB50:
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
	movl	%edx, %edi
	testb	%al, %al
	jne	.L481
	movq	16(%rcx), %rax
	testq	%rax, %rax
	je	.L482
	movq	16(%rcx), %rax
	movsbl	%dl, %ecx
	call	*%rax
	testb	%al, %al
	je	.L481
.L482:
	movq	(%rbx), %rsi
	movzwl	8(%rbx), %eax
	leal	1(%rax), %edx
	addq	%rax, %rsi
	movw	%dx, 8(%rbx)
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L487
	movq	24(%rbx), %rax
	movsbl	%dil, %ecx
	call	*%rax
.L480:
	movb	%al, (%rsi)
	movq	(%rbx), %rdx
	movzwl	8(%rbx), %eax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movzwl	8(%rbx), %edx
	movzwl	34(%rbx), %eax
	cmpw	%ax, %dx
	jb	.L483
	xorl	%edx, %edx
	movw	%dx, 8(%rbx)
.L483:
	movzbl	32(%rbx), %eax
	cmpb	%dil, %al
	je	.L488
.L481:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L488:
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
.L487:
	movl	%edi, %eax
	jmp	.L480
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE50:
	.text
.LHOTE50:
	.section	.text.unlikely,"x"
.LCOLDB51:
	.text
.LHOTB51:
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
	movzbl	10(%rcx), %eax
	testb	%al, %al
	je	.L490
	movzwl	8(%rcx), %r8d
	movq	%rdx, %rax
	movq	(%rcx), %rdx
	movq	%rcx, %rbx
	movq	%rax, %rcx
	call	memcpy
	movb	$0, 10(%rbx)
	movl	$1, %eax
.L490:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE51:
	.text
.LHOTE51:
	.section	.text.unlikely,"x"
.LCOLDB52:
	.text
.LHOTB52:
	.p2align 4,,15
	.globl	qBSBuffer_Count
	.def	qBSBuffer_Count;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Count
qBSBuffer_Count:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L496
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	subl	%edx, %eax
	cltq
	ret
	.p2align 4,,10
.L496:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE52:
	.text
.LHOTE52:
	.section	.text.unlikely,"x"
.LCOLDB53:
	.text
.LHOTB53:
	.p2align 4,,15
	.globl	qBSBuffer_IsFull
	.def	qBSBuffer_IsFull;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_IsFull
qBSBuffer_IsFull:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L499
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %ecx
	subl	%edx, %eax
	cltq
	cmpq	%rax, %rcx
	sete	%al
	ret
	.p2align 4,,10
.L499:
	movl	$1, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE53:
	.text
.LHOTE53:
	.section	.text.unlikely,"x"
.LCOLDB54:
	.text
.LHOTB54:
	.p2align 4,,15
	.globl	qBSBuffer_Empty
	.def	qBSBuffer_Empty;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Empty
qBSBuffer_Empty:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L502
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
	ret
	.p2align 4,,10
.L502:
	movl	$1, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE54:
	.text
.LHOTE54:
	.section	.text.unlikely,"x"
.LCOLDB55:
	.text
.LHOTB55:
	.p2align 4,,15
	.globl	qBSBuffer_Peek
	.def	qBSBuffer_Peek;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Peek
qBSBuffer_Peek:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L505
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
	ret
	.p2align 4,,10
.L505:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE55:
	.text
.LHOTE55:
	.section	.text.unlikely,"x"
.LCOLDB56:
	.text
.LHOTB56:
	.p2align 4,,15
	.globl	qBSBuffer_Get
	.def	qBSBuffer_Get;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Get
qBSBuffer_Get:
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rdx, %r9
	je	.L509
	movzwl	(%rcx), %r8d
	movzwl	2(%rcx), %eax
	cmpw	%ax, %r8w
	jne	.L508
.L509:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L508:
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %r8d
	addq	8(%rcx), %r8
	movzbl	(%r8), %eax
	movb	%al, (%r9)
	movzwl	2(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 2(%rcx)
	movl	$1, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE56:
	.text
.LHOTE56:
	.section	.text.unlikely,"x"
.LCOLDB57:
	.text
.LHOTB57:
	.p2align 4,,15
	.globl	qBSBuffer_Read
	.def	qBSBuffer_Read;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Read
qBSBuffer_Read:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testw	%r8w, %r8w
	movq	%rcx, %rsi
	je	.L514
	subl	$1, %r8d
	movq	%rdx, %rbx
	movzwl	%r8w, %r8d
	leaq	1(%rdx,%r8), %rdi
	jmp	.L515
	.p2align 4,,10
.L521:
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	je	.L520
.L515:
	movq	%rbx, %rdx
	movq	%rsi, %rcx
	call	qBSBuffer_Get
	testb	%al, %al
	jne	.L521
.L514:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L520:
	movl	$1, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE57:
	.text
.LHOTE57:
	.section	.text.unlikely,"x"
.LCOLDB58:
	.text
.LHOTB58:
	.p2align 4,,15
	.globl	qBSBuffer_Put
	.def	qBSBuffer_Put;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Put
qBSBuffer_Put:
	.seh_endprologue
	testq	%rcx, %rcx
	movl	%edx, %r10d
	je	.L525
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %r8d
	movzwl	16(%rcx), %edx
	subl	%r8d, %eax
	cltq
	movq	%rdx, %r9
	cmpq	%rdx, %rax
	je	.L525
	movzwl	(%rcx), %eax
	xorl	%edx, %edx
	divw	%r9w
	movzwl	%dx, %r8d
	addq	8(%rcx), %r8
	movb	%r10b, (%r8)
	movzwl	(%rcx), %eax
	addl	$1, %eax
	movw	%ax, (%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L525:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE58:
	.text
.LHOTE58:
	.section	.text.unlikely,"x"
.LCOLDB59:
	.text
.LHOTB59:
	.p2align 4,,15
	.globl	qBSBuffer_Init
	.def	qBSBuffer_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Init
qBSBuffer_Init:
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %r9
	movl	%r8d, %eax
	je	.L527
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, (%r9)
	leal	-1(%rdx), %ecx
	xorl	%r10d, %r10d
	movw	%r10w, 2(%r9)
	testl	%edx, %ecx
	jne	.L538
.L529:
	movw	%ax, 16(%r9)
.L527:
	rep ret
	.p2align 4,,10
.L538:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L530:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L530
	movzwl	%r8w, %eax
	addl	$1, %eax
	shrl	%eax
	jmp	.L529
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE59:
	.text
.LHOTE59:
	.section .rdata,"dr"
	.align 8
.LC60:
	.ascii "--------------------------------------------------------------------\0"
	.align 8
.LC61:
	.ascii "TaskData\11Priority\11Interval\11Iterations\0"
.LC62:
	.ascii "%s\11\11%d\11\11%d\11\11\0"
.LC63:
	.ascii "qPeriodic\0"
.LC64:
	.ascii "%d\15\12\0"
	.section	.text.unlikely,"x"
.LCOLDB65:
	.text
.LHOTB65:
	.p2align 4,,15
	.globl	qSchedulePrintChain
	.def	qSchedulePrintChain;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulePrintChain
qSchedulePrintChain:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leaq	.LC60(%rip), %rcx
	call	puts
	leaq	.LC61(%rip), %rcx
	call	puts
	leaq	.LC60(%rip), %rcx
	call	puts
	movq	56+QUARKTS(%rip), %rbx
	testq	%rbx, %rbx
	jne	.L545
	jmp	.L544
	.p2align 4,,10
.L541:
	movswl	32(%rbx), %edx
	leaq	.LC64(%rip), %rcx
	negl	%edx
	call	printf
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L544
.L545:
	movl	24(%rbx), %r9d
	movzbl	40(%rbx), %r8d
	leaq	.LC62(%rip), %rcx
	movq	8(%rbx), %rdx
	call	printf
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	jne	.L541
	leaq	.LC63(%rip), %rcx
	call	puts
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L545
.L544:
	leaq	.LC60(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	puts
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE65:
	.text
.LHOTE65:
	.data
	.align 8
ChainIterator.3243:
	.quad	-1
.lcomm _qSysTick_Epochs_,4,4
.lcomm QUARKTS,120,64
	.section .rdata,"dr"
	.align 4
.LC19:
	.long	1056964608
	.align 8
.LC29:
	.long	0
	.long	1071644672
	.ident	"GCC: (GNU) 4.9.3"
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
