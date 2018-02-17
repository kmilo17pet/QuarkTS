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
	je	.L23
	movzbl	58(%rcx), %eax
	ret
	.p2align 4,,10
.L23:
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
	je	.L29
	movl	36(%rcx), %eax
	ret
	.p2align 4,,10
.L29:
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
	je	.L30
	movb	$1, 57(%rcx)
	movq	%rdx, 16(%rcx)
.L30:
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
	je	.L35
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 24(%rcx)
.L35:
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
	je	.L40
	movl	%edx, %eax
	negl	%eax
	cmpw	$-32768, %dx
	cmovne	%eax, %edx
	movw	%dx, 32(%rcx)
.L40:
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
	je	.L47
	movb	$0, 80+QUARKTS(%rip)
	movb	%dl, 40(%rcx)
.L47:
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
	je	.L52
	movq	%rdx, 48(%rcx)
.L52:
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
	je	.L63
	movq	%rdx, 8(%rcx)
.L63:
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
	je	.L68
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L68:
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
	je	.L75
	movswl	98+QUARKTS(%rip), %r9d
	movzbl	96+QUARKTS(%rip), %r8d
	xorl	%eax, %eax
	subl	$1, %r8d
	cmpl	%r8d, %r9d
	jge	.L74
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
.L75:
	xorl	%eax, %eax
.L74:
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
	je	.L81
	.p2align 4,,10
.L82:
	movq	88+QUARKTS(%rip), %rcx
	movzbl	%dl, %eax
	addl	$1, %edx
	salq	$4, %rax
	addq	%rcx, %rax
	movq	$0, (%rax)
	movzbl	96+QUARKTS(%rip), %eax
	cmpb	%dl, %al
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
	je	.L92
	cmpq	%rcx, %rdx
	je	.L87
	movq	(%rdx), %rax
	testq	%rax, %rax
	jne	.L89
	jmp	.L92
	.p2align 4,,10
.L95:
	movq	(%rax), %r8
	movq	%rax, %rdx
	testq	%r8, %r8
	je	.L92
.L89:
	movq	(%rdx), %rax
	cmpq	%rax, %rcx
	jne	.L95
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
	je	.L100
	movss	.LC19(%rip), %xmm0
	mulss	%xmm3, %xmm0
	movss	48+QUARKTS(%rip), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L104
	pxor	%xmm0, %xmm0
	movl	$1, %ecx
	ucomiss	%xmm0, %xmm3
	setp	%al
	cmove	%eax, %ecx
	xorl	%eax, %eax
	testb	%cl, %cl
	je	.L104
.L97:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L104:
	xorl	%eax, %eax
	testq	%r11, %r11
	je	.L97
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
	movb	$0, 62(%r9)
	movb	$0, 61(%r9)
	movb	$0, 61(%r9)
	movb	$0, 59(%r9)
	movb	$0, 56(%r9)
	movb	$0, 57(%r9)
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
.L100:
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
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
	je	.L112
	cmpq	$0, 128(%rsp)
	je	.L112
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
	je	.L112
	movq	72(%rsp), %r9
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
	.p2align 4,,10
.L112:
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbx
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
	je	.L117
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
	movb	$0, 62(%rcx)
	movb	$0, 61(%rcx)
	movb	$0, 61(%rcx)
	movb	$0, 59(%rcx)
	movb	$0, 56(%rcx)
	movb	$0, 57(%rcx)
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
.L117:
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
	.section	.text.unlikely,"x"
.LCOLDE23:
	.text
.LHOTE23:
	.section	.text.unlikely,"x"
.LCOLDB24:
	.text
.LHOTB24:
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
	ja	.L122
	cmpq	$0, (%rdx)
	je	.L122
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
.L122:
	rep ret
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
.LCOLDE25:
	.text
.LHOTE25:
	.section	.text.unlikely,"x"
.LCOLDB26:
	.text
.LHOTB26:
	.p2align 4,,15
	.globl	qStateMachine_Init
	.def	qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Init
qStateMachine_Init:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L134
	testq	%rdx, %rdx
	je	.L134
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
.L134:
	xorl	%eax, %eax
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
	movq	%rcx, %rbx
	je	.L135
	movq	%rdx, 32(%rcx)
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L138
	movq	64(%rcx), %rax
	call	*%rax
.L138:
	movq	(%rbx), %rax
	testq	%rax, %rax
	je	.L139
	movq	16(%rbx), %rdx
	movq	(%rbx), %rax
	cmpq	%rax, %rdx
	setne	%al
	movb	%al, 28(%rbx)
	movzbl	28(%rbx), %eax
	testb	%al, %al
	jne	.L163
.L140:
	movq	(%rbx), %rsi
	movq	%rbx, %rcx
	movq	(%rbx), %rax
	call	*%rax
	movl	%eax, 24(%rbx)
	movq	%rsi, 16(%rbx)
.L141:
	movl	24(%rbx), %eax
	cmpl	$-32768, %eax
	je	.L143
	cmpl	$-32767, %eax
	je	.L164
	movq	56(%rbx), %rax
	testq	%rax, %rax
	je	.L135
	movq	56(%rbx), %rax
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp *%rax
	.p2align 4,,10
.L163:
	movq	16(%rbx), %rax
	movq	%rax, 8(%rbx)
	jmp	.L140
	.p2align 4,,10
.L164:
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
.L135:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L143:
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
.L139:
	movl	$-32767, 24(%rbx)
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
	ja	.L166
	leaq	.L168(%rip), %rax
	movl	%edx, %edx
	movslq	(%rax,%rdx,4), %rdx
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L168:
	.long	.L166-.L168
	.long	.L167-.L168
	.long	.L169-.L168
	.long	.L170-.L168
	.long	.L171-.L168
	.long	.L172-.L168
	.long	.L172-.L168
	.long	.L172-.L168
	.long	.L166-.L168
	.long	.L173-.L168
	.text
	.p2align 4,,10
.L167:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L174
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L200
.L174:
	movb	$0, 41+QUARKTS(%rip)
	movzwl	32(%rbx), %eax
.L183:
	movw	%ax, 32(%rbx)
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L176
	movzwl	32(%rbx), %eax
	subl	$1, %eax
	movw	%ax, 32(%rbx)
.L176:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	sete	%dl
	movb	%dl, 42+QUARKTS(%rip)
	jne	.L166
	movb	$0, 58(%rbx)
	.p2align 4,,10
.L166:
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
	je	.L180
	movq	48(%rbx), %rax
	cmpq	$1, %rax
	je	.L201
.L180:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L181
	movq	48(%rbx), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
.L181:
	cmpl	$4, %esi
	movq	$0, 104+QUARKTS(%rip)
	je	.L202
.L182:
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
.L169:
	movq	112+QUARKTS(%rip), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movq	$0, 112+QUARKTS(%rip)
.L173:
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
.L202:
	movq	64(%rbx), %rdx
	movzwl	14(%rdx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rdx)
	jmp	.L182
	.p2align 4,,10
.L172:
	movq	64(%rcx), %rax
.L198:
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L166
	.p2align 4,,10
.L170:
	movq	16(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movb	$0, 57(%rcx)
	jmp	.L166
	.p2align 4,,10
.L171:
	movq	64(%rcx), %r8
	testq	%r8, %r8
	je	.L184
	movzwl	12(%r8), %edx
	movzwl	14(%r8), %eax
	cmpw	%ax, %dx
	je	.L184
	movzwl	14(%r8), %eax
	movzwl	10(%r8), %r9d
	xorl	%edx, %edx
	movzwl	8(%r8), %ecx
	divw	%r9w
	movzwl	%dx, %eax
	imull	%ecx, %eax
	cltq
	addq	(%r8), %rax
	jmp	.L198
	.p2align 4,,10
.L200:
	movb	$1, 41+QUARKTS(%rip)
	movzwl	32(%rcx), %eax
	negl	%eax
	jmp	.L183
	.p2align 4,,10
.L184:
	xorl	%eax, %eax
	jmp	.L198
	.p2align 4,,10
.L201:
	movq	72(%rbx), %rcx
	leaq	16+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L181
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE28:
	.text
.LHOTE28:
	.section	.text.unlikely,"x"
.LCOLDB29:
	.text
.LHOTB29:
	.p2align 4,,15
	.globl	qSchedulerRun
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRun
qSchedulerRun:
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
	leaq	56(%rsp), %rbx
	movb	$1, 80+QUARKTS(%rip)
	.p2align 4,,10
.L249:
	movzbl	80+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L319
.L204:
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	js	.L211
.L325:
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L212
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L212:
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
	jmp	.L215
	.p2align 4,,10
.L217:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%cl, %eax
	salq	$4, %rax
	addq	%rax, %r8
	movq	(%r8), %r8
	testq	%r8, %r8
	je	.L317
.L215:
	movq	88+QUARKTS(%rip), %r8
	addq	%rax, %r8
	movq	(%r8), %r8
	movzbl	40(%r8), %r8d
	cmpb	%r9b, %r8b
	jbe	.L216
	movq	88+QUARKTS(%rip), %rdx
	addq	%rdx, %rax
	movl	%ecx, %edx
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
.L216:
	movzbl	96+QUARKTS(%rip), %eax
	addl	$1, %ecx
	cmpb	%al, %cl
	jb	.L217
.L317:
	movzbl	%dl, %eax
	movzbl	%dl, %r8d
	salq	$4, %rax
.L213:
	movq	88+QUARKTS(%rip), %rcx
	addq	%rax, %rcx
	movq	8(%rcx), %rcx
	movq	%rcx, 112+QUARKTS(%rip)
	movq	88+QUARKTS(%rip), %rcx
	addq	%rax, %rcx
	movq	(%rcx), %rsi
	movb	$1, 80(%rsi)
	movq	88+QUARKTS(%rip), %rcx
	addq	%rcx, %rax
	movq	$0, (%rax)
	movswl	98+QUARKTS(%rip), %eax
	cmpl	%eax, %r8d
	jge	.L222
	.p2align 4,,10
.L294:
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
	jl	.L294
.L222:
	movzwl	98+QUARKTS(%rip), %eax
	subl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L220
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L220:
	movl	$2, %edx
	movq	%rsi, %rcx
	call	_qScheduler_Dispatch
	movb	%al, 80(%rsi)
	movq	56+QUARKTS(%rip), %r8
	testq	%r8, %r8
	je	.L248
.L251:
	xorl	%ecx, %ecx
	jmp	.L241
	.p2align 4,,10
.L322:
	movzwl	32(%r8), %eax
	testw	%ax, %ax
	js	.L320
.L224:
	movzwl	32(%r8), %eax
	testw	%ax, %ax
	jle	.L226
.L225:
	movl	24(%r8), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm6, %xmm0
	jp	.L264
	je	.L227
.L264:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	28(%r8), %r9d
	movl	24(%r8), %edx
	subl	%r9d, %eax
	cmpl	%edx, %eax
	jb	.L223
.L227:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	$1, %ecx
	movl	%eax, 28(%r8)
	movb	$1, 80(%r8)
	movl	$1, 84(%r8)
.L231:
	movq	(%r8), %r8
	testq	%r8, %r8
	je	.L321
.L241:
	movzbl	58(%r8), %eax
	testb	%al, %al
	jne	.L322
.L223:
	movq	64(%r8), %rax
	testq	%rax, %rax
	je	.L232
	movzbl	60(%r8), %eax
	testb	%al, %al
	je	.L233
	movq	64(%r8), %rax
	testq	%rax, %rax
	je	.L257
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %r10d
	movzwl	10(%rax), %r9d
	movl	%edx, %eax
	subl	%r10d, %eax
	cmpw	%r9w, %ax
	je	.L257
.L233:
	movzbl	61(%r8), %eax
	testb	%al, %al
	je	.L235
	movq	64(%r8), %rax
	testq	%rax, %rax
	je	.L258
	movzwl	12(%rax), %r9d
	movzwl	14(%rax), %eax
	subl	%eax, %r9d
.L236:
	movzbl	61(%r8), %edx
	movl	$6, %eax
	cmpw	%r9w, %dx
	ja	.L235
.L252:
	movb	$1, 80(%r8)
	movl	%eax, 84(%r8)
	movl	$1, %ecx
	movq	(%r8), %r8
	testq	%r8, %r8
	jne	.L241
.L321:
	testb	%cl, %cl
	je	.L242
	movq	ChainIterator.3275(%rip), %rsi
	jmp	.L243
	.p2align 4,,10
.L244:
	testq	%rsi, %rsi
	je	.L245
.L323:
	movq	(%rsi), %rax
	movzbl	80(%rsi), %edx
	movq	%rax, ChainIterator.3275(%rip)
	cmpb	$1, %dl
	je	.L246
	xorl	%edx, %edx
.L247:
	movb	%dl, 80(%rsi)
	movq	%rax, %rsi
.L243:
	cmpq	$-1, %rsi
	jne	.L244
	movq	56+QUARKTS(%rip), %rsi
	testq	%rsi, %rsi
	movq	%rsi, ChainIterator.3275(%rip)
	jne	.L323
	.p2align 4,,10
.L245:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3275(%rip)
.L248:
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L249
.L324:
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
	je	.L250
	movq	8+QUARKTS(%rip), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
	nop
.L250:
	movaps	64(%rsp), %xmm6
	movb	$1, 81+QUARKTS(%rip)
	addq	$88, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L232:
	movzbl	57(%r8), %eax
	testb	%al, %al
	je	.L240
	movb	$1, 80(%r8)
	movl	$1, %ecx
	movl	$3, 84(%r8)
	jmp	.L231
	.p2align 4,,10
.L235:
	movzbl	59(%r8), %eax
	testb	%al, %al
	je	.L238
	movq	64(%r8), %r9
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
	movzwl	%dx, %eax
	imull	%eax, %r10d
	movslq	%r10d, %rax
	addq	(%r9), %rax
	je	.L238
	movl	$4, %eax
	jmp	.L252
	.p2align 4,,10
.L320:
	movzwl	32(%r8), %eax
	cmpw	$-32768, %ax
	je	.L224
	movzwl	32(%r8), %eax
	testw	$-32768, %ax
	jne	.L225
	.p2align 4,,10
.L226:
	movzwl	32(%r8), %eax
	cmpw	$-32768, %ax
	jne	.L223
	jmp	.L225
	.p2align 4,,10
.L240:
	movb	$3, 80(%r8)
	jmp	.L231
	.p2align 4,,10
.L238:
	movzbl	62(%r8), %eax
	testb	%al, %al
	je	.L232
	movq	64(%r8), %rax
	testq	%rax, %rax
	je	.L261
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %eax
	cmpw	%ax, %dx
	jne	.L232
.L261:
	movl	$7, %eax
	jmp	.L252
	.p2align 4,,10
.L257:
	movl	$5, %eax
	jmp	.L252
	.p2align 4,,10
.L246:
	movl	84(%rsi), %edx
	movq	%rsi, %rcx
	call	_qScheduler_Dispatch
	movl	%eax, %edx
	movq	ChainIterator.3275(%rip), %rax
	jmp	.L247
	.p2align 4,,10
.L242:
	testq	%rsi, %rsi
	jne	.L248
.L253:
	movq	QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L248
	xorl	%ecx, %ecx
	movl	$9, %edx
	call	_qScheduler_Dispatch
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L249
	jmp	.L324
	.p2align 4,,10
.L319:
	movq	64+QUARKTS(%rip), %rax
	movq	$0, 56(%rsp)
	movq	56+QUARKTS(%rip), %rdx
	testq	%rax, %rax
	je	.L316
	movq	%rdx, 40(%rsp)
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movq	40(%rsp), %rdx
	movl	%eax, 84+QUARKTS(%rip)
	jmp	.L316
	.p2align 4,,10
.L295:
	movq	(%rdx), %r10
	movq	%rbx, %rcx
	call	_qScheduler_PriorizedInsert
	movq	%r10, %rdx
.L316:
	testq	%rdx, %rdx
	jne	.L295
	movq	56(%rsp), %rax
	movb	$1, 80+QUARKTS(%rip)
	movq	%rax, 56+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L204
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	jns	.L325
.L211:
	movq	56+QUARKTS(%rip), %r8
	xorl	%esi, %esi
	testq	%r8, %r8
	jne	.L251
	jmp	.L253
	.p2align 4,,10
.L258:
	xorl	%r9d, %r9d
	jmp	.L236
.L255:
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L213
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE29:
	.text
.LHOTE29:
	.section	.text.unlikely,"x"
.LCOLDB30:
	.text
.LHOTB30:
	.p2align 4,,15
	.globl	qStateMachine_Attribute
	.def	qStateMachine_Attribute;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Attribute
qStateMachine_Attribute:
	.seh_endprologue
	cmpl	$5, %edx
	ja	.L326
	leaq	.L329(%rip), %rax
	movl	%edx, %edx
	movslq	(%rax,%rdx,4), %rdx
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L329:
	.long	.L328-.L329
	.long	.L330-.L329
	.long	.L331-.L329
	.long	.L332-.L329
	.long	.L333-.L329
	.long	.L334-.L329
	.text
	.p2align 4,,10
.L334:
	movq	%r8, 64(%rcx)
.L326:
	rep ret
	.p2align 4,,10
.L333:
	movq	%r8, 56(%rcx)
	ret
	.p2align 4,,10
.L328:
	movq	%r8, (%rcx)
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	ret
	.p2align 4,,10
.L330:
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	ret
	.p2align 4,,10
.L331:
	movq	%r8, 40(%rcx)
	ret
	.p2align 4,,10
.L332:
	movq	%r8, 48(%rcx)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE30:
	.text
.LHOTE30:
	.section	.text.unlikely,"x"
.LCOLDB32:
	.text
.LHOTB32:
	.p2align 4,,15
	.globl	qSTimerSet
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerSet
qSTimerSet:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L337
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	xorl	%eax, %eax
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC31(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	ja	.L336
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
.L337:
	xorl	%eax, %eax
.L336:
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
	.globl	qSTimerFreeRun
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerFreeRun
qSTimerFreeRun:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L343
	movzbl	(%rcx), %eax
	testb	%al, %al
	je	.L341
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	jb	.L343
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L341:
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC31(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	jbe	.L344
	rep ret
	.p2align 4,,10
.L344:
	movss	48+QUARKTS(%rip), %xmm0
	movb	$1, (%rcx)
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rdx
	movl	%edx, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	%edx, 4(%rcx)
	ret
	.p2align 4,,10
.L343:
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
	.globl	qSTimerExpired
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerExpired
qSTimerExpired:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L347
	movzbl	(%rcx), %eax
	testb	%al, %al
	je	.L346
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	setnb	%al
	ret
	.p2align 4,,10
.L347:
	xorl	%eax, %eax
.L346:
	rep ret
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
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L353
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	ret
	.p2align 4,,10
.L353:
	xorl	%eax, %eax
	ret
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
	.globl	qSTimerRemaining
	.def	qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerRemaining
qSTimerRemaining:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L356
	movl	8(%rcx), %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %r8d
	testl	%eax, %eax
	je	.L355
	subl	%r8d, %edx
	movl	%eax, %ecx
	subl	%edx, %ecx
	cmpl	%edx, %eax
	cmovnb	%ecx, %eax
	ret
	.p2align 4,,10
.L356:
	xorl	%eax, %eax
.L355:
	rep ret
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
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L360
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L360:
	rep ret
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
	je	.L399
	movq	64+QUARKTS(%rip), %rax
	movq	16(%rcx), %r14
	testq	%rax, %rax
	je	.L368
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L368:
	movzbl	2(%r12), %ebp
	xorl	%edx, %edx
.L380:
	cmpb	%bpl, %dl
	jnb	.L379
	movq	8(%r12), %rax
	movzbl	%dl, %r10d
	movzwl	(%r12), %esi
	leaq	(%rax,%r10), %rcx
	movzwl	%si, %r9d
	movzbl	(%rcx), %r8d
	testb	%r8b, %r8b
	jne	.L382
.L369:
	cmpw	%di, %si
	jnb	.L387
	movl	%esi, %r9d
	movl	%edx, %r8d
	movl	$1, %r11d
	jmp	.L373
	.p2align 4,,10
.L372:
	addl	%esi, %r9d
	cmpw	%di, %r9w
	jnb	.L384
.L373:
	addl	$1, %r8d
	addl	$1, %r11d
	cmpb	%bpl, %r8b
	jnb	.L371
	movzbl	%r8b, %r10d
	movzbl	(%rax,%r10), %ebx
	testb	%bl, %bl
	je	.L372
	leal	(%rbx,%r8), %edx
	movzbl	%dl, %eax
	imull	%eax, %esi
	movslq	%esi, %rax
	addq	16(%r12), %rax
	movq	%rax, %r14
.L371:
	cmpb	%bpl, %r8b
	jne	.L380
.L379:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L399
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L399:
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
	.p2align 4,,10
.L382:
	movzbl	%r8b, %ecx
	addl	%r8d, %edx
	imull	%r9d, %ecx
	movslq	%ecx, %rcx
	addq	%rcx, %r14
	cmpb	%bpl, %dl
	jnb	.L400
	movzbl	%dl, %r10d
	leaq	(%rax,%r10), %rcx
	movzbl	(%rcx), %r8d
	testb	%r8b, %r8b
	je	.L369
	jmp	.L382
.L387:
	movl	$1, %r11d
	.p2align 4,,10
.L384:
	addq	%r14, %r10
	xorl	%eax, %eax
	testw	%r13w, %r13w
	movb	%r11b, (%rcx)
	je	.L377
	.p2align 4,,10
.L392:
	addl	$1, %eax
	movzbl	%al, %edx
	cmpw	%dx, %di
	ja	.L392
	movb	$0, (%r10)
.L377:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L398
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L398:
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
.L400:
	movl	%edx, %r8d
	jmp	.L371
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
	je	.L401
	testq	%rdx, %rdx
	je	.L401
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L405
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L405:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L406
	cmpq	%r8, %rbx
	je	.L425
	movzwl	(%rsi), %r9d
	xorl	%eax, %eax
	jmp	.L409
	.p2align 4,,10
.L410:
	cmpq	%r8, %rbx
	je	.L426
.L409:
	addl	$1, %eax
	addq	%r9, %r8
	cmpb	%dl, %al
	jne	.L410
.L406:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L401
.L427:
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp *%rax
	.p2align 4,,10
.L401:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L426:
	movzbl	%al, %eax
.L407:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	jne	.L427
	jmp	.L401
.L425:
	xorl	%eax, %eax
	jmp	.L407
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
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
	.seh_endprologue
	movq	%rcx, %rax
	movl	%r9d, %ecx
	testq	%rax, %rax
	je	.L428
	testq	%rdx, %rdx
	je	.L428
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	movq	%rdx, (%rax)
	movzwl	%r9w, %edx
	movw	%r10w, 12(%rax)
	movw	%r11w, 14(%rax)
	movw	%r8w, 8(%rax)
	leal	-1(%rdx), %r8d
	testl	%edx, %r8d
	jne	.L436
	movw	%cx, 10(%rax)
.L428:
	rep ret
	.p2align 4,,10
.L436:
	subl	$1, %r9d
	movl	$4, %r8d
	movl	$1, %ecx
.L431:
	movzwl	%r9w, %edx
	sarl	%cl, %edx
	addl	%ecx, %ecx
	orl	%edx, %r9d
	subl	$1, %r8d
	jne	.L431
	movzwl	%r9w, %ecx
	addl	$1, %ecx
	shrl	%ecx
	movw	%cx, 10(%rax)
	jmp	.L428
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
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L439
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
	ret
	.p2align 4,,10
.L439:
	movl	$1, %eax
	ret
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
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L443
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L443
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
	.p2align 4,,10
.L443:
	xorl	%eax, %eax
	ret
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
	movq	%rcx, %rbx
	movq	%rdx, %rcx
	testq	%rbx, %rbx
	je	.L448
	movzwl	12(%rbx), %edx
	movzwl	14(%rbx), %eax
	cmpw	%ax, %dx
	je	.L448
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
.L448:
	xorl	%eax, %eax
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
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rdx, %r10
	je	.L456
	testq	%rdx, %rdx
	je	.L459
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %r9d
	movzwl	10(%rcx), %r8d
	subl	%r9d, %edx
	cmpw	%r8w, %dx
	je	.L464
	movzwl	12(%rcx), %eax
	movzwl	10(%rcx), %r9d
	xorl	%edx, %edx
	movzwl	8(%rcx), %r8d
	movq	(%rcx), %r11
	divw	%r9w
	xorl	%eax, %eax
	movzwl	%dx, %r9d
	movzwl	8(%rcx), %edx
	imull	%r9d, %r8d
	testw	%dx, %dx
	movslq	%r8d, %r9
	je	.L455
	.p2align 4,,10
.L460:
	movzwl	%ax, %r8d
	addl	$1, %eax
	leaq	(%r9,%r8), %rdx
	movzbl	(%r10,%r8), %r8d
	addq	%r11, %rdx
	movb	%r8b, (%rdx)
	movzwl	8(%rcx), %edx
	cmpw	%ax, %dx
	ja	.L460
.L455:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
	ret
	.p2align 4,,10
.L459:
	rep ret
	.p2align 4,,10
.L464:
	rep ret
	.p2align 4,,10
.L456:
	rep ret
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
	je	.L465
	.p2align 4,,10
.L469:
	movzbl	(%rcx,%rdx), %r8d
	movzbl	(%rcx,%rax), %r9d
	movb	%r9b, (%rcx,%rdx)
	movb	%r8b, (%rcx,%rax)
	addq	$1, %rdx
	subq	$1, %rax
	cmpq	%rax, %rdx
	jb	.L469
.L465:
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
	je	.L472
	.p2align 4,,10
.L476:
	movsbl	(%rdi,%rbx), %edx
	addq	$1, %rbx
	movq	%rbp, %rcx
	call	*%r12
	cmpq	%rsi, %rbx
	jne	.L476
.L472:
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
	movq	%rdx, %rsi
	movsbl	(%r8), %edx
	movq	%rcx, %rdi
	movq	%r8, %rbx
	testb	%dl, %dl
	je	.L478
	.p2align 4,,10
.L482:
	addq	$1, %rbx
	movq	%rsi, %rcx
	call	*%rdi
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L482
.L478:
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
	je	.L486
	cmpw	$1, %r8w
	jbe	.L486
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
.L486:
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
	jne	.L493
	movq	16(%rcx), %rax
	testq	%rax, %rax
	je	.L494
	movq	16(%rcx), %rax
	movsbl	%dl, %ecx
	call	*%rax
	testb	%al, %al
	je	.L493
.L494:
	movq	(%rbx), %rsi
	movzwl	8(%rbx), %eax
	leal	1(%rax), %edx
	addq	%rax, %rsi
	movw	%dx, 8(%rbx)
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L499
	movq	24(%rbx), %rax
	movsbl	%dil, %ecx
	call	*%rax
.L492:
	movb	%al, (%rsi)
	movq	(%rbx), %rdx
	movzwl	8(%rbx), %eax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movzwl	8(%rbx), %edx
	movzwl	34(%rbx), %eax
	cmpw	%ax, %dx
	jb	.L495
	xorl	%edx, %edx
	movw	%dx, 8(%rbx)
.L495:
	movzbl	32(%rbx), %eax
	cmpb	%al, %dil
	je	.L500
.L493:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L500:
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
.L499:
	movl	%edi, %eax
	jmp	.L492
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
	movq	%rcx, %rbx
	movq	%rdx, %rcx
	movzbl	10(%rbx), %eax
	testb	%al, %al
	je	.L502
	movzwl	8(%rbx), %r8d
	movq	(%rbx), %rdx
	call	memcpy
	movb	$0, 10(%rbx)
	movl	$1, %eax
.L502:
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
	je	.L508
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	subl	%edx, %eax
	cltq
	ret
	.p2align 4,,10
.L508:
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
	je	.L511
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %ecx
	subl	%edx, %eax
	cltq
	cmpq	%rax, %rcx
	sete	%al
	ret
	.p2align 4,,10
.L511:
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
	je	.L514
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
	ret
	.p2align 4,,10
.L514:
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
	je	.L517
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
	ret
	.p2align 4,,10
.L517:
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
	movq	%rdx, %r8
	je	.L521
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	je	.L521
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
.L521:
	xorl	%eax, %eax
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testw	%r8w, %r8w
	movq	%rcx, %r10
	je	.L526
	subl	$1, %r8d
	movq	%rdx, %r9
	movzwl	%r8w, %r8d
	leaq	1(%rdx,%r8), %r11
	jmp	.L527
	.p2align 4,,10
.L533:
	addq	$1, %r9
	cmpq	%r11, %r9
	je	.L532
.L527:
	movq	%r9, %rdx
	movq	%r10, %rcx
	call	qBSBuffer_Get
	testb	%al, %al
	jne	.L533
.L526:
	xorl	%eax, %eax
	addq	$40, %rsp
	ret
	.p2align 4,,10
.L532:
	movl	$1, %eax
	addq	$40, %rsp
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
	movl	%edx, %r9d
	je	.L537
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %r8d
	subl	%edx, %eax
	cltq
	movzwl	%r8w, %edx
	cmpq	%rdx, %rax
	je	.L537
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
.L537:
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
	je	.L539
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, (%r9)
	leal	-1(%rdx), %ecx
	xorl	%r10d, %r10d
	movw	%r10w, 2(%r9)
	testl	%edx, %ecx
	jne	.L550
.L541:
	movw	%ax, 16(%r9)
.L539:
	rep ret
	.p2align 4,,10
.L550:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L542:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L542
	movzwl	%r8w, %eax
	addl	$1, %eax
	shrl	%eax
	jmp	.L541
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
	jne	.L557
	jmp	.L556
	.p2align 4,,10
.L553:
	movswl	32(%rbx), %edx
	leaq	.LC64(%rip), %rcx
	negl	%edx
	call	printf
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L556
.L557:
	movl	24(%rbx), %r9d
	movzbl	40(%rbx), %r8d
	leaq	.LC62(%rip), %rcx
	movq	8(%rbx), %rdx
	call	printf
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	jne	.L553
	leaq	.LC63(%rip), %rcx
	call	puts
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L557
.L556:
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
ChainIterator.3275:
	.quad	-1
.lcomm _qSysTick_Epochs_,4,4
.lcomm QUARKTS,120,32
	.section .rdata,"dr"
	.align 4
.LC19:
	.long	1056964608
	.align 8
.LC31:
	.long	0
	.long	1071644672
	.ident	"GCC: (GNU) 5.4.0"
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
