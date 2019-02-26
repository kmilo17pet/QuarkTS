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
	.globl	__qReg_32Bits
	.def	__qReg_32Bits;	.scl	2;	.type	32;	.endef
	.seh_proc	__qReg_32Bits
__qReg_32Bits:
	.seh_endprologue
	movl	$1, %eax
	movq	%rcx, %r8
	movl	%edx, %ecx
	sall	%cl, %eax
	testl	%eax, (%r8)
	setne	%al
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
	je	.L27
	movzbl	%r8b, %r8d
	xorl	%r9d, %r9d
	jmp	.L24
	.p2align 4,,10
.L28:
	movzbl	%r11b, %r9d
.L24:
	xorl	%edx, %edx
	divl	%r8d
	leal	48(%rdx), %r11d
	leal	55(%rdx), %ecx
	cmpl	$10, %edx
	cmovb	%r11d, %ecx
	testl	%eax, %eax
	leal	1(%r9), %r11d
	movb	%cl, (%r10,%r9)
	jne	.L28
	movzbl	%r11b, %r8d
	subw	$1, %r8w
	je	.L20
.L21:
	xorl	%r9d, %r9d
	.p2align 4,,10
.L26:
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
	jb	.L26
.L20:
	movl	%r11d, %eax
	popq	%rbx
	ret
	.p2align 4,,10
.L27:
	xorl	%r11d, %r11d
	movl	$-1, %r8d
	jmp	.L21
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
	.globl	qTime2Clock
	.def	qTime2Clock;	.scl	2;	.type	32;	.endef
	.seh_proc	qTime2Clock
qTime2Clock:
	.seh_endprologue
	movss	48+QUARKTS(%rip), %xmm1
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
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
	je	.L38
	movzbl	58(%rcx), %eax
.L38:
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
	je	.L45
	movl	36(%rcx), %eax
.L45:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSendEvent
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSendEvent
qTaskSendEvent:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L49
	movb	$1, 57(%rcx)
	movq	%rdx, 16(%rcx)
.L49:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetTime
	.def	qTaskSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetTime
qTaskSetTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L54
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 24(%rcx)
.L54:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetIterations
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetIterations
qTaskSetIterations:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L59
	movl	%edx, %eax
	negl	%eax
	cmpw	$-32768, %dx
	cmovne	%eax, %edx
	movw	%dx, 32(%rcx)
.L59:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetPriority
	.def	qTaskSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetPriority
qTaskSetPriority:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L66
	movb	$0, 80+QUARKTS(%rip)
	movb	%dl, 40(%rcx)
.L66:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetCallback
	.def	qTaskSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetCallback
qTaskSetCallback:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L71
	movq	%rdx, 48(%rcx)
.L71:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetState
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetState
qTaskSetState:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L76
	testb	%dl, %dl
	je	.L78
	movzbl	58(%rcx), %eax
	testb	%al, %al
	jne	.L76
.L78:
	movb	%dl, 58(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L76:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetData
	.def	qTaskSetData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetData
qTaskSetData:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L82
	movq	%rdx, 8(%rcx)
.L82:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskClearTimeElapsed
	.def	qTaskClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskClearTimeElapsed
qTaskClearTimeElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L87
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L87:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskQueueEvent
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskQueueEvent
qTaskQueueEvent:
	subq	$24, %rsp
	.seh_stackalloc	24
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L92
	movswl	98+QUARKTS(%rip), %r9d
	movzbl	96+QUARKTS(%rip), %r8d
	subl	$1, %r8d
	cmpl	%r8d, %r9d
	jge	.L92
	movq	%rdx, 8(%rsp)
	movq	%rcx, (%rsp)
	movq	88+QUARKTS(%rip), %rdx
	movzwl	98+QUARKTS(%rip), %eax
	addl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	(%rsp), %r9
	movswq	%ax, %rax
	movq	8(%rsp), %r10
	salq	$4, %rax
	movq	%r9, (%rdx,%rax)
	movq	%r10, 8(%rdx,%rax)
	movl	$1, %eax
.L92:
	addq	$24, %rsp
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
	je	.L99
	xorl	%eax, %eax
	.p2align 4,,10
.L100:
	movq	88+QUARKTS(%rip), %rcx
	movzbl	%al, %edx
	addl	$1, %eax
	salq	$4, %rdx
	movq	$0, (%rcx,%rdx)
	movzbl	96+QUARKTS(%rip), %edx
	cmpb	%al, %dl
	ja	.L100
.L99:
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
	je	.L105
	cmpq	%rcx, %rdx
	je	.L107
	movq	(%rdx), %r8
	testq	%r8, %r8
	jne	.L109
	jmp	.L105
	.p2align 4,,10
.L116:
	movq	(%rax), %r8
	movq	%rax, %rdx
	testq	%r8, %r8
	je	.L115
.L109:
	movq	(%rdx), %rax
	cmpq	%rax, %rcx
	jne	.L116
	movq	(%rcx), %rax
	movq	%rax, (%rdx)
.L110:
	movq	$0, (%rcx)
	movl	$1, %eax
.L105:
	ret
	.p2align 4,,10
.L115:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L107:
	movq	(%rcx), %rax
	movq	%rax, 56+QUARKTS(%rip)
	jmp	.L110
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
	je	.L117
	movss	.LC0(%rip), %xmm0
	mulss	%xmm3, %xmm0
	movss	48+QUARKTS(%rip), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L125
	pxor	%xmm0, %xmm0
	movl	$1, %ebx
	ucomiss	%xmm0, %xmm3
	setp	%cl
	cmovne	%ebx, %ecx
	testb	%cl, %cl
	jne	.L117
.L125:
	xorl	%eax, %eax
	testq	%rdx, %rdx
	movl	%r8d, 44(%rsp)
	movq	%rdx, 32(%rsp)
	je	.L117
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
.L117:
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
	je	.L134
	cmpq	$0, 128(%rsp)
	je	.L134
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
	jne	.L138
.L134:
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L138:
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
	je	.L139
	testq	%rdx, %rdx
	movss	48+QUARKTS(%rip), %xmm0
	je	.L139
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
.L139:
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
	je	.L149
	testq	%rcx, %rcx
	je	.L149
	leal	-3(%r8), %r10d
	xorl	%eax, %eax
	cmpl	$3, %r10d
	ja	.L145
	cmpq	$0, (%rdx)
	je	.L145
	cmpl	$5, %r8d
	movl	%r9d, %eax
	je	.L147
	testb	%r9b, %r9b
	setne	%al
.L147:
	movl	%r8d, %r8d
	testb	%r9b, %r9b
	movb	%al, 56(%rcx,%r8)
	movl	$0, %eax
	cmove	%rax, %rdx
	movl	$1, %eax
	movq	%rdx, 64(%rcx)
.L145:
	ret
	.p2align 4,,10
.L149:
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
	je	.L157
	testq	%rdx, %rdx
	je	.L157
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
.L157:
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
	je	.L158
	movq	64(%rcx), %rax
	movq	%rdx, 32(%rcx)
	testq	%rax, %rax
	je	.L161
	call	*%rax
.L161:
	movq	(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L162
	movq	16(%rbx), %rax
	cmpq	%rax, %rsi
	setne	28(%rbx)
	je	.L163
	movq	%rax, 8(%rbx)
.L163:
	movq	%rbx, %rcx
	call	*%rsi
	cmpl	$-32768, %eax
	movl	%eax, 24(%rbx)
	movq	%rsi, 16(%rbx)
	je	.L165
	cmpl	$-32767, %eax
	je	.L166
	movq	56(%rbx), %rax
	testq	%rax, %rax
	je	.L158
.L184:
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L165:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	jne	.L184
.L158:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L162:
	movl	$-32767, 24(%rbx)
.L166:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L158
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
	ja	.L186
	movl	%edx, %eax
	leaq	.L188(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L188:
	.long	.L186-.L188
	.long	.L187-.L188
	.long	.L189-.L188
	.long	.L190-.L188
	.long	.L191-.L188
	.long	.L192-.L188
	.long	.L192-.L188
	.long	.L192-.L188
	.long	.L186-.L188
	.long	.L193-.L188
	.text
	.p2align 4,,10
.L187:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L194
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L220
.L194:
	movb	$0, 41+QUARKTS(%rip)
	movzwl	32(%rbx), %eax
.L202:
	movw	%ax, 32(%rbx)
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L196
	movzwl	32(%rbx), %eax
	subl	$1, %eax
	movw	%ax, 32(%rbx)
.L196:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	sete	%dl
	movb	%dl, 42+QUARKTS(%rip)
	jne	.L186
	movb	$0, 58(%rbx)
	.p2align 4,,10
.L186:
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
	je	.L199
	movq	48(%rbx), %rax
	cmpq	$1, %rax
	je	.L221
.L199:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L200
	movq	48(%rbx), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
.L200:
	cmpl	$4, %esi
	movq	$0, 112+QUARKTS(%rip)
	jne	.L201
	movq	64(%rbx), %rdx
	movzwl	14(%rdx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rdx)
.L201:
	movb	$1, 56(%rbx)
	movb	$0, 41+QUARKTS(%rip)
	movb	$0, 42+QUARKTS(%rip)
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
.L193:
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
.L189:
	movq	104+QUARKTS(%rip), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movq	$0, 104+QUARKTS(%rip)
	jmp	.L186
	.p2align 4,,10
.L190:
	movq	16(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movb	$0, 57(%rcx)
	jmp	.L186
	.p2align 4,,10
.L191:
	movq	64(%rcx), %rcx
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L219
	movzwl	12(%rcx), %r8d
	movzwl	14(%rcx), %edx
	cmpw	%dx, %r8w
	je	.L219
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
.L219:
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L186
	.p2align 4,,10
.L192:
	movq	64(%rcx), %rax
	jmp	.L219
	.p2align 4,,10
.L221:
	movq	72(%rbx), %rcx
	leaq	16+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L200
	.p2align 4,,10
.L220:
	movb	$1, 41+QUARKTS(%rip)
	movzwl	32(%rcx), %eax
	negl	%eax
	jmp	.L202
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
.L262:
	movzbl	80+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L331
.L223:
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	js	.L228
.L337:
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L229
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L229:
	movq	88+QUARKTS(%rip), %rax
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
	movzbl	96+QUARKTS(%rip), %eax
	cmpb	$1, %al
	jbe	.L266
	movq	88+QUARKTS(%rip), %rax
	cmpq	$0, 16(%rax)
	je	.L266
	xorl	%edx, %edx
	movl	$16, %eax
	movl	$1, %ecx
	jmp	.L231
	.p2align 4,,10
.L233:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%cl, %eax
	salq	$4, %rax
	cmpq	$0, (%r8,%rax)
	je	.L330
.L231:
	movq	88+QUARKTS(%rip), %r8
	movq	(%r8,%rax), %r8
	movzbl	40(%r8), %r8d
	cmpb	%r9b, %r8b
	jbe	.L232
	movq	88+QUARKTS(%rip), %rdx
	movq	(%rdx,%rax), %rax
	movl	%ecx, %edx
	movzbl	40(%rax), %r9d
.L232:
	movzbl	96+QUARKTS(%rip), %eax
	addl	$1, %ecx
	cmpb	%al, %cl
	jb	.L233
.L330:
	movzbl	%dl, %eax
	movzbl	%dl, %r8d
	salq	$4, %rax
.L230:
	movq	88+QUARKTS(%rip), %rcx
	movq	8(%rcx,%rax), %rcx
	movq	%rcx, 104+QUARKTS(%rip)
	movq	88+QUARKTS(%rip), %rcx
	movq	(%rcx,%rax), %rdi
	movb	$1, 80(%rdi)
	movq	88+QUARKTS(%rip), %rcx
	movq	$0, (%rcx,%rax)
	movswl	98+QUARKTS(%rip), %eax
	cmpl	%eax, %r8d
	jge	.L234
	.p2align 4,,10
.L235:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%dl, %eax
	movq	88+QUARKTS(%rip), %rcx
	addq	$1, %rax
	addl	$1, %edx
	salq	$4, %rax
	movq	(%r8,%rax), %r9
	movq	8(%r8,%rax), %r10
	movq	%r9, -16(%rcx,%rax)
	movq	%r10, -8(%rcx,%rax)
	movzbl	%dl, %ecx
	movswl	98+QUARKTS(%rip), %eax
	cmpl	%eax, %ecx
	jl	.L235
.L234:
	movzwl	98+QUARKTS(%rip), %eax
	subl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L236
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L236:
	movq	%rdi, %rcx
	movl	$2, %edx
	call	_qScheduler_Dispatch
	movb	%al, 80(%rdi)
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L261
.L264:
	xorl	%r8d, %r8d
	jmp	.L254
	.p2align 4,,10
.L239:
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jle	.L241
.L240:
	movl	24(%rcx), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm6, %xmm0
	jp	.L273
	je	.L242
.L273:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	28(%rcx), %r9d
	movl	24(%rcx), %edx
	subl	%r9d, %eax
	cmpl	%edx, %eax
	jnb	.L242
.L238:
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L247
	movzbl	60(%rcx), %eax
	testb	%al, %al
	je	.L248
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L268
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %r10d
	movzwl	10(%rax), %r9d
	movl	%edx, %eax
	subl	%r10d, %eax
	cmpw	%r9w, %ax
	je	.L268
.L248:
	movzbl	61(%rcx), %eax
	testb	%al, %al
	je	.L250
	movq	64(%rcx), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L251
	movzwl	12(%rdx), %eax
	movzwl	14(%rdx), %edx
	subl	%edx, %eax
.L251:
	movzbl	61(%rcx), %edx
	cmpw	%ax, %dx
	jbe	.L270
.L250:
	movzbl	59(%rcx), %eax
	testb	%al, %al
	je	.L252
	movq	64(%rcx), %r9
	testq	%r9, %r9
	je	.L252
	movzwl	12(%r9), %edx
	movzwl	14(%r9), %eax
	cmpw	%ax, %dx
	je	.L252
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
	jne	.L249
	.p2align 4,,10
.L252:
	movzbl	62(%rcx), %eax
	testb	%al, %al
	je	.L247
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L272
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %eax
	cmpw	%ax, %dx
	je	.L272
.L247:
	movzbl	57(%rcx), %eax
	testb	%al, %al
	jne	.L332
	movb	$3, 80(%rcx)
.L246:
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L333
.L254:
	movzbl	58(%rcx), %eax
	testb	%al, %al
	je	.L238
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jns	.L239
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L239
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L240
.L241:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	jne	.L238
	jmp	.L240
	.p2align 4,,10
.L242:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	$1, %r8d
	movl	%eax, 28(%rcx)
	movb	$1, 80(%rcx)
	movl	$1, 84(%rcx)
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L254
.L333:
	testb	%r8b, %r8b
	jne	.L334
	testq	%rdi, %rdi
	je	.L237
.L261:
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L262
.L335:
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
	je	.L263
	movq	8+QUARKTS(%rip), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
	nop
.L263:
	movaps	64(%rsp), %xmm6
	movb	$1, 81+QUARKTS(%rip)
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L270:
	movl	$6, %edx
.L249:
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L246
	.p2align 4,,10
.L332:
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	$3, 84(%rcx)
	jmp	.L246
	.p2align 4,,10
.L237:
	movq	(%rsi), %rax
	testq	%rax, %rax
	je	.L261
	xorl	%ecx, %ecx
	movl	$9, %edx
	call	_qScheduler_Dispatch
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L262
	jmp	.L335
	.p2align 4,,10
.L268:
	movl	$5, %edx
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L246
	.p2align 4,,10
.L334:
	movq	ChainIterator.3391(%rip), %rdi
	jmp	.L256
	.p2align 4,,10
.L257:
	testq	%rdi, %rdi
	je	.L258
.L336:
	movq	(%rdi), %rdx
	movzbl	80(%rdi), %eax
	movq	%rdx, ChainIterator.3391(%rip)
	cmpb	$1, %al
	je	.L259
	xorl	%eax, %eax
.L260:
	movb	%al, 80(%rdi)
	movq	%rdx, %rdi
.L256:
	cmpq	%rbx, %rdi
	jne	.L257
	movq	56+QUARKTS(%rip), %rdi
	testq	%rdi, %rdi
	movq	%rdi, ChainIterator.3391(%rip)
	jne	.L336
.L258:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3391(%rip)
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L262
	jmp	.L335
	.p2align 4,,10
.L259:
	movl	84(%rdi), %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movq	ChainIterator.3391(%rip), %rdx
	jmp	.L260
	.p2align 4,,10
.L331:
	movq	64+QUARKTS(%rip), %rax
	movq	$0, 56(%rsp)
	movq	56+QUARKTS(%rip), %rdx
	testq	%rax, %rax
	je	.L224
	movq	%rdx, 40(%rsp)
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movq	40(%rsp), %rdx
	movl	%eax, 84+QUARKTS(%rip)
.L224:
	testq	%rdx, %rdx
	je	.L225
	leaq	56(%rsp), %r11
	.p2align 4,,10
.L226:
	movq	(%rdx), %r10
	movq	%r11, %rcx
	call	_qScheduler_PriorizedInsert
	testq	%r10, %r10
	movq	%r10, %rdx
	jne	.L226
.L225:
	movq	56(%rsp), %rax
	movb	$1, 80+QUARKTS(%rip)
	movq	%rax, 56+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L223
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	jns	.L337
.L228:
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L237
	xorl	%edi, %edi
	jmp	.L264
	.p2align 4,,10
.L272:
	movl	$7, %edx
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L246
	.p2align 4,,10
.L266:
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L230
	.seh_endproc
	.p2align 4,,15
	.globl	qStateMachine_Attribute
	.def	qStateMachine_Attribute;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Attribute
qStateMachine_Attribute:
	.seh_endprologue
	cmpl	$5, %edx
	ja	.L338
	leaq	.L341(%rip), %r9
	movl	%edx, %edx
	movslq	(%r9,%rdx,4), %rax
	addq	%r9, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L341:
	.long	.L340-.L341
	.long	.L342-.L341
	.long	.L343-.L341
	.long	.L344-.L341
	.long	.L345-.L341
	.long	.L346-.L341
	.text
	.p2align 4,,10
.L346:
	movq	%r8, 64(%rcx)
.L338:
	ret
	.p2align 4,,10
.L345:
	movq	%r8, 56(%rcx)
	ret
	.p2align 4,,10
.L340:
	movq	%r8, (%rcx)
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	ret
	.p2align 4,,10
.L342:
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	ret
	.p2align 4,,10
.L343:
	movq	%r8, 40(%rcx)
	ret
	.p2align 4,,10
.L344:
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
	je	.L347
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	ja	.L347
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movb	$1, (%rcx)
	movl	%eax, 4(%rcx)
	movl	$1, %eax
.L347:
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
	je	.L352
	cmpb	$0, (%rcx)
	jne	.L359
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	jbe	.L360
.L352:
	ret
	.p2align 4,,10
.L359:
	movl	_qSysTick_Epochs_(%rip), %edx
	subl	4(%rcx), %edx
	cmpl	8(%rcx), %edx
	jb	.L352
	movl	$1, %eax
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
	ret
	.p2align 4,,10
.L360:
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
	je	.L361
	cmpb	$0, (%rcx)
	je	.L361
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	setnb	%al
.L361:
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
	je	.L366
	cmpb	$0, (%rcx)
	je	.L366
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
.L366:
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
	je	.L371
	cmpb	$0, (%rcx)
	movl	8(%rcx), %eax
	jne	.L380
.L371:
	ret
	.p2align 4,,10
.L380:
	testl	%eax, %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %ecx
	je	.L371
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
	je	.L381
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L381:
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
	je	.L386
	movzbl	(%rcx), %eax
.L386:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerChangeTime
	.def	qSTimerChangeTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerChangeTime
qSTimerChangeTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L390
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
.L390:
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
	je	.L396
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L396:
	movzbl	2(%r14), %ebx
	xorl	%r12d, %r12d
.L407:
	cmpb	%r12b, %bl
	jbe	.L406
	movq	8(%r14), %rdi
	movzbl	%r12b, %eax
	movzwl	(%r14), %r11d
	leaq	(%rdi,%rax), %rdx
	movzwl	%r11w, %r8d
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L408
	cmpw	%si, %r11w
	jnb	.L429
.L427:
	leal	1(%r12), %eax
	movl	%r11d, %r8d
	movl	$1, %r9d
	movzbl	%al, %eax
	jmp	.L401
	.p2align 4,,10
.L405:
	movzbl	(%rdi,%rax), %r10d
	testb	%r10b, %r10b
	jne	.L430
	addl	%r11d, %r8d
	leaq	1(%rax), %r10
	cmpw	%si, %r8w
	jnb	.L409
	movq	%r10, %rax
.L401:
	addl	$1, %r9d
	cmpb	%al, %bl
	movl	%eax, %ebp
	ja	.L405
.L399:
	cmpb	%bpl, %bl
	jne	.L407
.L406:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L412
	movq	72+QUARKTS(%rip), %rax
	xorl	%r13d, %r13d
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	jmp	.L395
	.p2align 4,,10
.L408:
	movzbl	%cl, %eax
	addl	%ecx, %r12d
	imull	%r8d, %eax
	cltq
	addq	%rax, %r13
	cmpb	%r12b, %bl
	jbe	.L431
	movzbl	%r12b, %eax
	leaq	(%rdi,%rax), %rdx
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L408
	cmpw	%si, %r11w
	jb	.L427
.L429:
	movl	$1, %r9d
	.p2align 4,,10
.L409:
	testw	%r15w, %r15w
	movb	%r9b, (%rdx)
	je	.L402
	addq	%r13, %rax
	xorl	%edx, %edx
	.p2align 4,,10
.L403:
	addl	$1, %edx
	movzbl	%dl, %ecx
	cmpw	%si, %cx
	jb	.L403
	movb	$0, (%rax)
.L402:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L395
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L395:
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
.L430:
	leal	(%r10,%rbp), %r12d
	movzbl	%r12b, %r13d
	imull	%r11d, %r13d
	movslq	%r13d, %r13
	addq	16(%r14), %r13
	cmpb	%bpl, %bl
	jne	.L407
	jmp	.L406
.L431:
	movl	%r12d, %ebp
	jmp	.L399
.L412:
	xorl	%r13d, %r13d
	jmp	.L395
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
	je	.L432
	testq	%rdx, %rdx
	je	.L432
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L436
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L436:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L437
	cmpq	%r8, %rbx
	je	.L455
	movzwl	(%rsi), %ecx
	xorl	%eax, %eax
	jmp	.L440
	.p2align 4,,10
.L441:
	cmpq	%r8, %rbx
	je	.L456
.L440:
	addl	$1, %eax
	addq	%rcx, %r8
	cmpb	%dl, %al
	jne	.L441
.L437:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L432
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L432:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L456:
	movzbl	%al, %eax
.L438:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	jmp	.L437
	.p2align 4,,10
.L455:
	xorl	%eax, %eax
	jmp	.L438
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
	je	.L457
	testq	%rdx, %rdx
	je	.L457
	xorl	%ecx, %ecx
	movq	%rdx, (%r10)
	movzwl	%r9w, %edx
	movw	%cx, 12(%r10)
	leal	-1(%rdx), %ecx
	xorl	%r11d, %r11d
	movw	%r11w, 14(%r10)
	movw	%r8w, 8(%r10)
	testl	%edx, %ecx
	jne	.L465
	movw	%ax, 10(%r10)
.L457:
	ret
	.p2align 4,,10
.L465:
	subl	$1, %r9d
	movl	$4, %edx
	movl	$1, %ecx
.L460:
	movzwl	%r9w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r9d
	subl	$1, %edx
	jne	.L460
	movzwl	%r9w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 10(%r10)
	jmp	.L457
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	movl	$1, %eax
	testq	%rcx, %rcx
	je	.L466
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L466:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L473
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L473
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
.L473:
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
	je	.L474
	movzwl	12(%rbx), %r8d
	movzwl	14(%rbx), %edx
	cmpw	%dx, %r8w
	je	.L474
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
.L474:
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
	je	.L483
	testq	%rcx, %rcx
	je	.L483
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r8d
	subl	%eax, %edx
	xorl	%eax, %eax
	cmpw	%r8w, %dx
	je	.L479
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
	je	.L481
	xorl	%eax, %eax
	.p2align 4,,10
.L482:
	movzwl	%ax, %r8d
	addl	$1, %eax
	leaq	(%r9,%r8), %rdx
	movzbl	(%r10,%r8), %r8d
	addq	%r11, %rdx
	movb	%r8b, (%rdx)
	movzwl	8(%rcx), %edx
	cmpw	%ax, %dx
	ja	.L482
.L481:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
.L479:
	ret
	.p2align 4,,10
.L483:
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
	je	.L495
	xorl	%r9d, %r9d
	.p2align 4,,10
.L497:
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
	jb	.L497
.L495:
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
	je	.L503
	xorl	%ebx, %ebx
	.p2align 4,,10
.L506:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	movsbl	(%r12,%rbx), %edx
	cmove	%rsi, %rcx
	addq	$1, %rbx
	call	*%rbp
	cmpq	%rdi, %rbx
	jne	.L506
.L503:
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
	je	.L512
	xorl	%ebx, %ebx
	.p2align 4,,10
.L515:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	cmove	%rsi, %rcx
	call	*%rbp
	movb	%al, (%r12,%rbx)
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	jne	.L515
.L512:
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
	je	.L521
	xorl	%edi, %edi
	.p2align 4,,10
.L524:
	addq	$1, %rbx
	testb	%r12b, %r12b
	movq	%rsi, %rcx
	je	.L523
	leaq	(%rsi,%rdi), %rcx
	addq	$1, %rdi
.L523:
	call	*%rbp
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L524
.L521:
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
	je	.L532
	movzwl	%r9w, %r9d
	movq	%r8, %rbp
	leal	-1(%r9), %eax
	leaq	1(%r8,%rax), %rdi
	.p2align 4,,10
.L535:
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
	jne	.L535
.L532:
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
	js	.L538
	movslq	%r8d, %rdx
	movl	%r8d, %r8d
	leaq	-1(%rax,%rdx), %r11
	leaq	(%rax,%rdx), %r10
	subq	%r8, %r11
	.p2align 4,,10
.L540:
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
	jne	.L540
.L538:
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
.L543:
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	ja	.L542
.L555:
	testb	%bl, %bl
	je	.L542
	call	__locale_ctype_ptr
	movsbl	%bl, %ecx
	addq	$1, %rsi
	call	toupper
	movzbl	%al, %r13d
	movl	%eax, %ebx
	call	__locale_ctype_ptr
	testb	$68, 1(%rax,%r13)
	je	.L544
	leal	-48(%rbx), %edx
	addl	$1, %edi
	cmpb	$9, %dl
	jbe	.L545
	leal	-65(%rbx), %eax
	movl	%r13d, %edx
	subl	$55, %ebx
	cmpb	$6, %al
	cmovb	%ebx, %edx
.L545:
	movl	%edx, %ebx
	sall	$4, %ebp
	andl	$15, %ebx
	orl	%ebx, %ebp
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	jbe	.L555
.L542:
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
.L544:
	call	__locale_ctype_ptr
	testb	$8, 1(%rax,%r13)
	jne	.L543
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
.L557:
	call	__locale_ctype_ptr
	movsbq	(%rbx,%rsi), %rcx
	movl	%esi, %edi
	addq	$1, %rsi
	testb	$8, 1(%rax,%rcx)
	jne	.L557
	cmpb	$45, %cl
	je	.L565
	cmpb	$43, %cl
	movl	$1, %esi
	je	.L558
.L559:
	movslq	%edi, %rdi
	pxor	%xmm6, %xmm6
	movsd	.LC5(%rip), %xmm7
	jmp	.L560
	.p2align 4,,10
.L561:
	pxor	%xmm0, %xmm0
	subl	$48, %edx
	movapd	%xmm6, %xmm1
	cvtsi2sd	%edx, %xmm0
	mulsd	%xmm7, %xmm1
	movapd	%xmm0, %xmm6
	addsd	%xmm1, %xmm6
.L560:
	call	__locale_ctype_ptr
	movsbl	(%rbx,%rdi), %edx
	movl	%edi, %ebp
	addq	$1, %rdi
	movsbq	%dl, %rcx
	testb	$4, 1(%rax,%rcx)
	jne	.L561
	xorl	%eax, %eax
	cmpb	$46, %dl
	sete	%al
	movsd	.LC4(%rip), %xmm7
	addl	%eax, %ebp
	movsd	.LC5(%rip), %xmm8
	movslq	%ebp, %rbp
	addq	%rbp, %rbx
	jmp	.L563
	.p2align 4,,10
.L564:
	pxor	%xmm1, %xmm1
	subl	$48, %edx
	movapd	%xmm6, %xmm0
	mulsd	%xmm8, %xmm7
	cvtsi2sd	%edx, %xmm1
	mulsd	%xmm8, %xmm0
	addsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm6
.L563:
	call	__locale_ctype_ptr
	movsbl	(%rbx), %edx
	addq	$1, %rbx
	movsbq	%dl, %rcx
	testb	$4, 1(%rax,%rcx)
	jne	.L564
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
.L565:
	movl	$-1, %esi
.L558:
	addl	$1, %edi
	jmp	.L559
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
	jmp	.L569
	.p2align 4,,10
.L570:
	addq	$1, %rbx
.L569:
	call	__locale_ctype_ptr
	movsbq	(%rbx), %rcx
	testb	$8, 1(%rax,%rcx)
	movq	%rcx, %rdx
	jne	.L570
	cmpb	$45, %cl
	je	.L584
	cmpb	$43, %cl
	movl	$1, %r8d
	je	.L585
.L572:
	testb	%dl, %dl
	je	.L580
	leal	-48(%rdx), %eax
	cmpb	$9, %al
	movl	$0, %eax
	jbe	.L573
	jmp	.L568
	.p2align 4,,10
.L575:
	leal	-48(%rdx), %ecx
	cmpb	$9, %cl
	ja	.L583
.L573:
	leal	(%rax,%rax,4), %ecx
	addq	$1, %rbx
	leal	-48(%rdx,%rcx,2), %eax
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L575
.L583:
	imull	%r8d, %eax
.L568:
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L585:
	movsbl	1(%rbx), %edx
	addq	$1, %rbx
	jmp	.L572
	.p2align 4,,10
.L584:
	movsbl	1(%rbx), %edx
	movl	$-1, %r8d
	addq	$1, %rbx
	jmp	.L572
	.p2align 4,,10
.L580:
	xorl	%eax, %eax
	jmp	.L568
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
	je	.L587
	testl	%ecx, %ecx
	jne	.L593
	movb	$48, (%rdx)
	movl	$1, %eax
.L589:
	movb	$0, (%rbx,%rax)
.L587:
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L593:
	movzbl	%r8b, %r8d
	call	__q_revuta.part.5
	movzbl	%al, %eax
	jmp	.L589
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
	je	.L595
	testl	%ecx, %ecx
	js	.L605
	jne	.L606
	movb	$48, (%rdx)
	movl	$1, %eax
.L600:
	movb	$0, (%rbx,%rax)
.L595:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L605:
	xorl	%esi, %esi
	cmpb	$10, %r8b
	je	.L607
.L597:
	negl	%ecx
.L598:
	movzbl	%r8b, %r8d
	call	__q_revuta.part.5
	addl	%esi, %eax
	movzbl	%al, %eax
	jmp	.L600
	.p2align 4,,10
.L607:
	movb	$45, (%rdx)
	movl	$1, %esi
	leaq	1(%rdx), %rdx
	jmp	.L597
.L606:
	xorl	%esi, %esi
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
	je	.L609
	testb	%cl, %cl
	jne	.L614
	movl	$1936482662, (%rdx)
	movl	$101, %edx
	movw	%dx, 4(%rax)
.L609:
	ret
	.p2align 4,,10
.L614:
	movl	$1702195828, (%rdx)
	movb	$0, 4(%rdx)
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qQBtoA
	.def	qQBtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qQBtoA
qQBtoA:
	.seh_endprologue
	movq	%rdx, %rax
	movzbl	%cl, %edx
	testq	%rax, %rax
	je	.L616
	cmpb	$4, %cl
	ja	.L617
	leaq	.L619(%rip), %rcx
	movslq	(%rcx,%rdx,4), %rdx
	addq	%rcx, %rdx
	jmp	*%rdx
	.section .rdata,"dr"
	.align 4
.L619:
	.long	.L618-.L619
	.long	.L620-.L619
	.long	.L621-.L619
	.long	.L622-.L619
	.long	.L623-.L619
	.text
	.p2align 4,,10
.L620:
	movl	$1702195828, (%rax)
	movb	$0, 4(%rax)
.L616:
	ret
	.p2align 4,,10
.L622:
	movl	$26478, %edx
	movl	$1769171314, (%rax)
	movb	$0, 6(%rax)
	movw	%dx, 4(%rax)
	ret
	.p2align 4,,10
.L623:
	movabsq	$29113321670861158, %rcx
	movq	%rcx, (%rax)
	ret
	.p2align 4,,10
.L618:
	movl	$101, %ecx
	movl	$1936482662, (%rax)
	movw	%cx, 4(%rax)
	ret
	.p2align 4,,10
.L621:
	movabsq	$32780218601924980, %rcx
	movq	%rcx, (%rax)
	ret
	.p2align 4,,10
.L617:
	movabsq	$31093567915781749, %rcx
	movq	%rcx, (%rax)
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
	je	.L630
	ret
	.p2align 4,,10
.L630:
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
	je	.L649
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L634
	je	.L654
.L634:
	movd	%xmm0, %edx
	movd	%xmm0, %eax
	andl	$2147483647, %edx
	cmpl	$2139095040, %edx
	jne	.L655
	movl	$1718511915, (%rbx)
	movb	$0, 4(%rbx)
.L649:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L654:
	movq	%rbx, %rax
	movl	$3157552, (%rdx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L655:
	movd	%xmm0, %edx
	andl	$2139095040, %edx
	cmpl	$2139095040, %edx
	je	.L656
.L638:
	ucomiss	%xmm0, %xmm1
	ja	.L646
	movq	%rbx, %rdx
	xorl	%edi, %edi
.L647:
	cvttss2siq	%xmm0, %rbp
	testl	%ebp, %ebp
	jne	.L657
	movb	$48, (%rdx)
	movl	$1, %eax
.L641:
	leal	(%rdi,%rax), %ecx
	movzbl	%cl, %eax
	addq	%rbx, %rax
	testb	%sil, %sil
	je	.L642
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
.L645:
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
	jne	.L645
	leal	(%r10,%rsi), %eax
	movzbl	%al, %eax
	addq	%rbx, %rax
.L642:
	movb	$0, (%rax)
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L656:
	testl	$8388607, %eax
	je	.L638
	movl	$7233902, (%rbx)
	jmp	.L649
	.p2align 4,,10
.L646:
	xorps	.LC6(%rip), %xmm0
	leaq	1(%rbx), %rdx
	movb	$45, (%rbx)
	movl	$1, %edi
	jmp	.L647
	.p2align 4,,10
.L657:
	movl	$10, %r8d
	movl	%ebp, %ecx
	call	__q_revuta.part.5
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
	subl	%edx, %eax
	cmpw	%ax, 16(%rcx)
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
	movzwl	(%rcx), %r9d
	movzwl	2(%rcx), %eax
	cmpw	%ax, %r9w
	je	.L703
	subl	$1, %r8d
	movq	%rdx, %r9
	movzwl	%r8w, %r8d
	addq	%rdx, %r8
	jmp	.L704
	.p2align 4,,10
.L705:
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	addq	$1, %r9
	cmpw	%ax, %dx
	je	.L703
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
	jne	.L705
	movl	$1, %eax
	ret
	.p2align 4,,10
.L703:
	xorl	%eax, %eax
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
	movl	%edx, %r9d
	je	.L709
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %r10d
	movzwl	16(%rcx), %r8d
	subl	%r10d, %edx
	cmpw	%r8w, %dx
	je	.L709
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
.L709:
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
	je	.L714
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, (%r9)
	leal	-1(%rdx), %ecx
	xorl	%r10d, %r10d
	movw	%r10w, 2(%r9)
	testl	%edx, %ecx
	jne	.L725
	movw	%ax, 16(%r9)
.L714:
	ret
	.p2align 4,,10
.L725:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L717:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L717
	movzwl	%r8w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%r9)
	jmp	.L714
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
	.globl	qResponseReceivedWithTimeout
	.def	qResponseReceivedWithTimeout;	.scl	2;	.type	32;	.endef
	.seh_proc	qResponseReceivedWithTimeout
qResponseReceivedWithTimeout:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, %rbx
	movzbl	12(%rcx), %ecx
	movl	%r8d, %eax
	testb	%cl, %cl
	jne	.L728
	cmpq	$0, (%rbx)
	je	.L740
.L728:
	testq	%r9, %r9
	je	.L733
	cmpb	$0, (%r9)
	jne	.L741
.L734:
	movzbl	12(%rbx), %eax
	testb	%al, %al
	je	.L739
	xorl	%eax, %eax
	xorl	%edx, %edx
	movq	$0, (%rbx)
	movw	%ax, 8(%rbx)
	movl	$1, %eax
	movw	%dx, 10(%rbx)
	movb	$0, 12(%rbx)
	movb	$0, (%r9)
	movl	$0, 4(%r9)
	addq	$48, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L740:
	testw	%r8w, %r8w
	jne	.L729
	movq	%rdx, %rcx
	movq	%r9, 40(%rsp)
	movq	%rdx, 32(%rsp)
	call	strlen
	movq	40(%rsp), %r9
	movq	32(%rsp), %rdx
.L729:
	movw	%ax, 8(%rbx)
	xorl	%eax, %eax
	testq	%r9, %r9
	movw	%ax, 10(%rbx)
	movq	%rdx, (%rbx)
	movb	$0, 12(%rbx)
	je	.L739
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm1
	cvtss2sd	%xmm1, %xmm1
	cvtss2sd	96(%rsp), %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm1
	ja	.L739
	movss	48+QUARKTS(%rip), %xmm0
	movss	96(%rsp), %xmm2
	divss	%xmm0, %xmm2
	cvttss2siq	%xmm2, %rax
	movl	%eax, 8(%r9)
	movl	_qSysTick_Epochs_(%rip), %eax
	movb	$1, (%r9)
	movl	%eax, 4(%r9)
	.p2align 4,,10
.L739:
	xorl	%eax, %eax
.L727:
	addq	$48, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L733:
	movzbl	12(%rbx), %eax
	testb	%al, %al
	je	.L739
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	movl	$1, %eax
	movw	%r8w, 10(%rbx)
	movq	$0, (%rbx)
	movw	%cx, 8(%rbx)
	movb	$0, 12(%rbx)
	addq	$48, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L741:
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%r9), %eax
	cmpl	8(%r9), %eax
	jb	.L734
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	movq	$0, (%rbx)
	movw	%r11w, 10(%rbx)
	movw	%r10w, 8(%rbx)
	movl	$2, %eax
	movb	$0, 12(%rbx)
	movb	$0, (%r9)
	movl	$0, 4(%r9)
	jmp	.L727
	.seh_endproc
	.p2align 4,,15
	.globl	qResponseReceived
	.def	qResponseReceived;	.scl	2;	.type	32;	.endef
	.seh_proc	qResponseReceived
qResponseReceived:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	xorl	%r9d, %r9d
	movl	$0x00000000, 32(%rsp)
	movzwl	%r8w, %r8d
	call	qResponseReceivedWithTimeout
	addq	$56, %rsp
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
	je	.L743
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L743
	movzwl	10(%rcx), %eax
	cmpb	%dl, (%r8,%rax)
	je	.L752
.L746:
	movzbl	12(%rcx), %eax
.L743:
	ret
	.p2align 4,,10
.L752:
	movzwl	10(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 10(%rcx)
	movzwl	10(%rcx), %eax
	cmpw	8(%rcx), %ax
	jne	.L746
	movb	$1, 12(%rcx)
	jmp	.L746
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
	je	.L753
	movsbl	(%rcx), %edx
	testb	%dl, %dl
	je	.L755
	.p2align 4,,10
.L756:
	addq	$1, %r14
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%r14), %edx
	testb	%dl, %dl
	jne	.L756
	movq	__qDebugOutputFcn(%rip), %rbx
.L755:
	testq	%r13, %r13
	je	.L757
	movl	$64, %edx
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	0(%r13), %edx
	movq	__qDebugOutputFcn(%rip), %rbx
	testb	%dl, %dl
	je	.L758
	.p2align 4,,10
.L759:
	addq	$1, %r13
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	0(%r13), %edx
	testb	%dl, %dl
	jne	.L759
	movq	__qDebugOutputFcn(%rip), %rbx
.L758:
	movl	$32, %edx
	xorl	%ecx, %ecx
	call	*%rbx
	movq	__qDebugOutputFcn(%rip), %rbx
.L757:
	movsbl	(%rsi), %edx
	testb	%dl, %dl
	je	.L760
	.p2align 4,,10
.L761:
	addq	$1, %rsi
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%rsi), %edx
	testb	%dl, %dl
	jne	.L761
	movq	__qDebugOutputFcn(%rip), %rbx
.L760:
	testq	%rdi, %rdi
	je	.L784
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	je	.L763
	.p2align 4,,10
.L764:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbx
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L764
	movq	__qDebugOutputFcn(%rip), %rbx
.L763:
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
.L753:
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
.L784:
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
	.p2align 4,,15
	.globl	__qReg_08Bits
	.def	__qReg_08Bits;	.scl	2;	.type	32;	.endef
	.seh_proc	__qReg_08Bits
__qReg_08Bits:
	.seh_endprologue
	movzbl	(%rcx), %eax
	movl	%edx, %ecx
	sarl	%cl, %eax
	andl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	__qReg_16Bits
	.def	__qReg_16Bits;	.scl	2;	.type	32;	.endef
	.seh_proc	__qReg_16Bits
__qReg_16Bits:
	.seh_endprologue
	movzwl	(%rcx), %eax
	movl	%edx, %ecx
	sarl	%cl, %eax
	andl	$1, %eax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qEdgeCheck_Initialize
	.def	qEdgeCheck_Initialize;	.scl	2;	.type	32;	.endef
	.seh_proc	qEdgeCheck_Initialize
qEdgeCheck_Initialize:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L787
	leaq	__qReg_32Bits(%rip), %rax
	testq	%rdx, %rdx
	movq	$0, (%rcx)
	movl	%r8d, 12(%rcx)
	movb	$2, 24(%rcx)
	cmove	%rax, %rdx
	movl	_qSysTick_Epochs_(%rip), %eax
	movq	%rdx, 16(%rcx)
	movl	%eax, 8(%rcx)
	movl	$1, %eax
.L787:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qEdgeCheck_InsertNode
	.def	qEdgeCheck_InsertNode;	.scl	2;	.type	32;	.endef
	.seh_proc	qEdgeCheck_InsertNode
qEdgeCheck_InsertNode:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rcx, %rsi
	movq	%rdx, %rbx
	je	.L794
	testq	%rcx, %rcx
	je	.L794
	movb	%r9b, 24(%rdx)
	movq	(%rcx), %rax
	movq	%r8, %rcx
	movq	%r8, 16(%rdx)
	movq	%rax, (%rdx)
	movzbl	%r9b, %edx
	call	*16(%rsi)
	movb	%al, 8(%rbx)
	movl	$1, %eax
	movq	%rbx, (%rsi)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L794:
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qEdgeCheck_Update
	.def	qEdgeCheck_Update;	.scl	2;	.type	32;	.endef
	.seh_proc	qEdgeCheck_Update
qEdgeCheck_Update:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rcx, %rsi
	je	.L795
	movzbl	24(%rcx), %eax
	testb	%al, %al
	je	.L816
	movq	(%rcx), %rbx
	testq	%rbx, %rbx
	jne	.L805
	jmp	.L799
	.p2align 4,,10
.L800:
	je	.L817
.L802:
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	je	.L818
.L805:
	movzbl	24(%rbx), %edx
	movq	16(%rbx), %rcx
	call	*16(%rsi)
	movzbl	24(%rsi), %edx
	cmpb	$1, %dl
	jbe	.L800
	cmpb	%al, 8(%rbx)
	je	.L801
	addl	$1, %edx
	movb	$-1, 9(%rbx)
	movb	%dl, 24(%rsi)
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L805
.L818:
	movzbl	24(%rsi), %eax
.L799:
	cmpb	$1, %al
	je	.L819
	cmpb	$2, %al
	jbe	.L815
	movb	$0, 24(%rsi)
.L815:
	movl	$1, %eax
.L795:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L816:
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	8(%rcx), %eax
	cmpl	12(%rcx), %eax
	jb	.L815
	movl	$1, %eax
	movb	$1, 24(%rcx)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L817:
	cmpb	%al, 8(%rbx)
	je	.L803
	testb	%al, %al
	sete	%dl
	addl	$3, %edx
	movb	%dl, 9(%rbx)
.L803:
	movb	%al, 8(%rbx)
	jmp	.L802
	.p2align 4,,10
.L801:
	movb	%al, 9(%rbx)
	jmp	.L802
	.p2align 4,,10
.L819:
	movl	_qSysTick_Epochs_(%rip), %edx
	movb	$2, 24(%rsi)
	movl	%edx, 8(%rsi)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qEdgeCheck_GetNodeStatus
	.def	qEdgeCheck_GetNodeStatus;	.scl	2;	.type	32;	.endef
	.seh_proc	qEdgeCheck_GetNodeStatus
qEdgeCheck_GetNodeStatus:
	.seh_endprologue
	movzbl	9(%rcx), %eax
	ret
	.seh_endproc
	.data
	.align 8
ChainIterator.3391:
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
	.def	strlen;	.scl	2;	.type	32;	.endef
