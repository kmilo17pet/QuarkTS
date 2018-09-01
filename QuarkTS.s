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
	.def	qItoA.part.5;	.scl	3;	.type	32;	.endef
	.seh_proc	qItoA.part.5
qItoA.part.5:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testl	%ecx, %ecx
	movl	%ecx, %eax
	movq	%rdx, %r10
	js	.L39
	movl	$0, %ebx
	je	.L40
.L25:
	movzbl	%r8b, %r8d
	xorl	%ecx, %ecx
	jmp	.L23
	.p2align 4,,10
.L32:
	movl	%r9d, %ecx
.L23:
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
	jne	.L32
	movzbl	%r9b, %edx
	addq	%r10, %rdx
	testb	%bl, %bl
	je	.L41
	addl	$2, %ecx
	movb	$45, (%rdx)
	movzbl	%cl, %eax
	movzbl	%cl, %ecx
	leaq	(%r10,%rcx), %rdx
	subl	$1, %eax
.L28:
	testw	%ax, %ax
	movb	$0, (%rdx)
	je	.L19
	movzbl	(%r10), %r11d
.L31:
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	jmp	.L30
	.p2align 4,,10
.L42:
	movzwl	%cx, %r8d
	movzbl	(%r10,%r8), %r11d
.L30:
	movzwl	%ax, %edx
	addl	$1, %ecx
	subl	$1, %eax
	addq	%r10, %rdx
	cmpw	%ax, %cx
	movzbl	(%rdx), %r9d
	movb	%r9b, (%r10,%r8)
	movb	%r11b, (%rdx)
	jb	.L42
.L19:
	popq	%rbx
	ret
	.p2align 4,,10
.L41:
	movzbl	%r9b, %eax
	subl	$1, %eax
	jmp	.L28
	.p2align 4,,10
.L39:
	cmpb	$10, %r8b
	sete	%bl
	negl	%eax
	jmp	.L25
	.p2align 4,,10
.L40:
	movb	$0, (%rdx)
	xorl	%r11d, %r11d
	movl	$-1, %eax
	jmp	.L31
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
	je	.L44
	movzbl	58(%rcx), %eax
.L44:
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
	je	.L51
	movl	36(%rcx), %eax
.L51:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSendEvent
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSendEvent
qTaskSendEvent:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L55
	movb	$1, 57(%rcx)
	movq	%rdx, 16(%rcx)
.L55:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetTime
	.def	qTaskSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetTime
qTaskSetTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L60
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 24(%rcx)
.L60:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetIterations
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetIterations
qTaskSetIterations:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L65
	movl	%edx, %eax
	negl	%eax
	cmpw	$-32768, %dx
	cmovne	%eax, %edx
	movw	%dx, 32(%rcx)
.L65:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetPriority
	.def	qTaskSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetPriority
qTaskSetPriority:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L72
	movb	$0, 80+QUARKTS(%rip)
	movb	%dl, 40(%rcx)
.L72:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetCallback
	.def	qTaskSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetCallback
qTaskSetCallback:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L77
	movq	%rdx, 48(%rcx)
.L77:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetState
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetState
qTaskSetState:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L82
	testb	%dl, %dl
	je	.L84
	movzbl	58(%rcx), %eax
	testb	%al, %al
	jne	.L82
.L84:
	movb	%dl, 58(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L82:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskSetData
	.def	qTaskSetData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetData
qTaskSetData:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L88
	movq	%rdx, 8(%rcx)
.L88:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qTaskClearTimeElapsed
	.def	qTaskClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskClearTimeElapsed
qTaskClearTimeElapsed:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L93
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	%eax, 28(%rcx)
.L93:
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
	je	.L98
	movswl	98+QUARKTS(%rip), %r9d
	movzbl	96+QUARKTS(%rip), %r8d
	subl	$1, %r8d
	cmpl	%r8d, %r9d
	jge	.L98
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
.L98:
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
	je	.L105
	xorl	%eax, %eax
	.p2align 4,,10
.L106:
	movq	88+QUARKTS(%rip), %rcx
	movzbl	%al, %edx
	addl	$1, %eax
	salq	$4, %rdx
	addq	%rcx, %rdx
	movq	$0, (%rdx)
	movzbl	96+QUARKTS(%rip), %edx
	cmpb	%al, %dl
	ja	.L106
.L105:
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
	je	.L111
	cmpq	%rcx, %rdx
	je	.L113
	movq	(%rdx), %r8
	testq	%r8, %r8
	jne	.L115
	jmp	.L111
	.p2align 4,,10
.L122:
	movq	(%rax), %r8
	movq	%rax, %rdx
	testq	%r8, %r8
	je	.L121
.L115:
	movq	(%rdx), %rax
	cmpq	%rax, %rcx
	jne	.L122
	movq	(%rcx), %rax
	movq	%rax, (%rdx)
.L116:
	movq	$0, (%rcx)
	movl	$1, %eax
.L111:
	ret
	.p2align 4,,10
.L121:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L113:
	movq	(%rcx), %rax
	movq	%rax, 56+QUARKTS(%rip)
	jmp	.L116
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
	je	.L123
	movss	.LC0(%rip), %xmm0
	mulss	%xmm3, %xmm0
	movss	48+QUARKTS(%rip), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L131
	pxor	%xmm0, %xmm0
	movl	$1, %ebx
	ucomiss	%xmm0, %xmm3
	setp	%cl
	cmovne	%ebx, %ecx
	testb	%cl, %cl
	jne	.L123
.L131:
	xorl	%eax, %eax
	testq	%rdx, %rdx
	movl	%r8d, 44(%rsp)
	movq	%rdx, 32(%rsp)
	je	.L123
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
.L123:
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
	je	.L140
	cmpq	$0, 128(%rsp)
	je	.L140
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
	jne	.L144
.L140:
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L144:
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
	je	.L145
	testq	%rdx, %rdx
	movss	48+QUARKTS(%rip), %xmm0
	je	.L145
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
.L145:
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
	je	.L155
	testq	%rcx, %rcx
	je	.L155
	leal	-3(%r8), %r10d
	xorl	%eax, %eax
	cmpl	$3, %r10d
	ja	.L151
	cmpq	$0, (%rdx)
	je	.L151
	cmpl	$5, %r8d
	movl	%r9d, %eax
	je	.L153
	testb	%r9b, %r9b
	setne	%al
.L153:
	movl	%r8d, %r8d
	testb	%r9b, %r9b
	movb	%al, 56(%rcx,%r8)
	movl	$0, %eax
	cmove	%rax, %rdx
	movl	$1, %eax
	movq	%rdx, 64(%rcx)
.L151:
	ret
	.p2align 4,,10
.L155:
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
	je	.L163
	testq	%rdx, %rdx
	je	.L163
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
.L163:
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
	je	.L164
	movq	64(%rcx), %rax
	movq	%rdx, 32(%rcx)
	testq	%rax, %rax
	je	.L167
	call	*%rax
.L167:
	movq	(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L168
	movq	16(%rbx), %rax
	cmpq	%rax, %rsi
	setne	28(%rbx)
	je	.L169
	movq	%rax, 8(%rbx)
.L169:
	movq	%rbx, %rcx
	call	*%rsi
	cmpl	$-32768, %eax
	movl	%eax, 24(%rbx)
	movq	%rsi, 16(%rbx)
	je	.L171
	cmpl	$-32767, %eax
	je	.L172
	movq	56(%rbx), %rax
	testq	%rax, %rax
	je	.L164
.L190:
	movq	%rbx, %rcx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L171:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	jne	.L190
.L164:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L168:
	movl	$-32767, 24(%rbx)
.L172:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L164
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
	ja	.L192
	movl	%edx, %eax
	leaq	.L194(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L194:
	.long	.L192-.L194
	.long	.L193-.L194
	.long	.L195-.L194
	.long	.L196-.L194
	.long	.L197-.L194
	.long	.L198-.L194
	.long	.L198-.L194
	.long	.L198-.L194
	.long	.L192-.L194
	.long	.L199-.L194
	.text
	.p2align 4,,10
.L193:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L200
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L226
.L200:
	movb	$0, 41+QUARKTS(%rip)
	movzwl	32(%rbx), %eax
.L208:
	movw	%ax, 32(%rbx)
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L202
	movzwl	32(%rbx), %eax
	subl	$1, %eax
	movw	%ax, 32(%rbx)
.L202:
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	sete	%dl
	movb	%dl, 42+QUARKTS(%rip)
	jne	.L192
	movb	$0, 58(%rbx)
	.p2align 4,,10
.L192:
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
	je	.L205
	movq	48(%rbx), %rax
	cmpq	$1, %rax
	je	.L227
.L205:
	movq	48(%rbx), %rax
	testq	%rax, %rax
	je	.L206
	movq	48(%rbx), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
.L206:
	cmpl	$4, %esi
	movq	$0, 112+QUARKTS(%rip)
	jne	.L207
	movq	64(%rbx), %rdx
	movzwl	14(%rdx), %eax
	addl	$1, %eax
	movw	%ax, 14(%rdx)
.L207:
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
.L199:
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
.L195:
	movq	104+QUARKTS(%rip), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movq	$0, 104+QUARKTS(%rip)
	jmp	.L192
	.p2align 4,,10
.L196:
	movq	16(%rcx), %rax
	movq	%rax, 32+QUARKTS(%rip)
	movb	$0, 57(%rcx)
	jmp	.L192
	.p2align 4,,10
.L197:
	movq	64(%rcx), %rcx
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L225
	movzwl	12(%rcx), %r8d
	movzwl	14(%rcx), %edx
	cmpw	%dx, %r8w
	je	.L225
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
.L225:
	movq	%rax, 32+QUARKTS(%rip)
	jmp	.L192
	.p2align 4,,10
.L198:
	movq	64(%rcx), %rax
	jmp	.L225
	.p2align 4,,10
.L227:
	movq	72(%rbx), %rcx
	leaq	16+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L206
	.p2align 4,,10
.L226:
	movb	$1, 41+QUARKTS(%rip)
	movzwl	32(%rcx), %eax
	negl	%eax
	jmp	.L208
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
.L268:
	movzbl	80+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L337
.L229:
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	js	.L234
.L343:
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L235
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L235:
	movq	88+QUARKTS(%rip), %rax
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
	movzbl	96+QUARKTS(%rip), %eax
	cmpb	$1, %al
	jbe	.L272
	movq	88+QUARKTS(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L272
	xorl	%edx, %edx
	movl	$16, %eax
	movl	$1, %ecx
	jmp	.L237
	.p2align 4,,10
.L239:
	movq	88+QUARKTS(%rip), %r8
	movzbl	%cl, %eax
	salq	$4, %rax
	addq	%rax, %r8
	movq	(%r8), %r8
	testq	%r8, %r8
	je	.L336
.L237:
	movq	88+QUARKTS(%rip), %r8
	addq	%rax, %r8
	movq	(%r8), %r8
	movzbl	40(%r8), %r8d
	cmpb	%r9b, %r8b
	jbe	.L238
	movq	88+QUARKTS(%rip), %rdx
	addq	%rdx, %rax
	movl	%ecx, %edx
	movq	(%rax), %rax
	movzbl	40(%rax), %r9d
.L238:
	movzbl	96+QUARKTS(%rip), %eax
	addl	$1, %ecx
	cmpb	%al, %cl
	jb	.L239
.L336:
	movzbl	%dl, %eax
	movzbl	%dl, %r8d
	salq	$4, %rax
.L236:
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
	jge	.L240
	.p2align 4,,10
.L241:
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
	jl	.L241
.L240:
	movzwl	98+QUARKTS(%rip), %eax
	subl	$1, %eax
	movw	%ax, 98+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L242
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L242:
	movq	%rdi, %rcx
	movl	$2, %edx
	call	_qScheduler_Dispatch
	movb	%al, 80(%rdi)
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L267
.L270:
	xorl	%r8d, %r8d
	jmp	.L260
	.p2align 4,,10
.L245:
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jle	.L247
.L246:
	movl	24(%rcx), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm6, %xmm0
	jp	.L279
	je	.L248
.L279:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	28(%rcx), %r9d
	movl	24(%rcx), %edx
	subl	%r9d, %eax
	cmpl	%edx, %eax
	jnb	.L248
.L244:
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L253
	movzbl	60(%rcx), %eax
	testb	%al, %al
	je	.L254
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L274
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %r10d
	movzwl	10(%rax), %r9d
	movl	%edx, %eax
	subl	%r10d, %eax
	cmpw	%r9w, %ax
	je	.L274
.L254:
	movzbl	61(%rcx), %eax
	testb	%al, %al
	je	.L256
	movq	64(%rcx), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L257
	movzwl	12(%rdx), %eax
	movzwl	14(%rdx), %edx
	subl	%edx, %eax
.L257:
	movzbl	61(%rcx), %edx
	cmpw	%ax, %dx
	jbe	.L276
.L256:
	movzbl	59(%rcx), %eax
	testb	%al, %al
	je	.L258
	movq	64(%rcx), %r9
	testq	%r9, %r9
	je	.L258
	movzwl	12(%r9), %edx
	movzwl	14(%r9), %eax
	cmpw	%ax, %dx
	je	.L258
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
	jne	.L255
	.p2align 4,,10
.L258:
	movzbl	62(%rcx), %eax
	testb	%al, %al
	je	.L253
	movq	64(%rcx), %rax
	testq	%rax, %rax
	je	.L278
	movzwl	12(%rax), %edx
	movzwl	14(%rax), %eax
	cmpw	%ax, %dx
	je	.L278
.L253:
	movzbl	57(%rcx), %eax
	testb	%al, %al
	jne	.L338
	movb	$3, 80(%rcx)
.L252:
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.L339
.L260:
	movzbl	58(%rcx), %eax
	testb	%al, %al
	je	.L244
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	jns	.L245
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	je	.L245
	movzwl	32(%rcx), %eax
	testw	%ax, %ax
	js	.L246
.L247:
	movzwl	32(%rcx), %eax
	cmpw	$-32768, %ax
	jne	.L244
	jmp	.L246
	.p2align 4,,10
.L248:
	movl	_qSysTick_Epochs_(%rip), %eax
	movl	$1, %r8d
	movl	%eax, 28(%rcx)
	movb	$1, 80(%rcx)
	movl	$1, 84(%rcx)
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L260
.L339:
	testb	%r8b, %r8b
	jne	.L340
	testq	%rdi, %rdi
	je	.L243
.L267:
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L268
.L341:
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
	je	.L269
	movq	8+QUARKTS(%rip), %rax
	leaq	16+QUARKTS(%rip), %rcx
	call	*%rax
	nop
.L269:
	movaps	64(%rsp), %xmm6
	movb	$1, 81+QUARKTS(%rip)
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L276:
	movl	$6, %edx
.L255:
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L252
	.p2align 4,,10
.L338:
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	$3, 84(%rcx)
	jmp	.L252
	.p2align 4,,10
.L243:
	movq	(%rsi), %rax
	testq	%rax, %rax
	je	.L267
	xorl	%ecx, %ecx
	movl	$9, %edx
	call	_qScheduler_Dispatch
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L268
	jmp	.L341
	.p2align 4,,10
.L274:
	movl	$5, %edx
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L252
	.p2align 4,,10
.L340:
	movq	ChainIterator.3311(%rip), %rdi
	jmp	.L262
	.p2align 4,,10
.L263:
	testq	%rdi, %rdi
	je	.L264
.L342:
	movq	(%rdi), %rdx
	movzbl	80(%rdi), %eax
	movq	%rdx, ChainIterator.3311(%rip)
	cmpb	$1, %al
	je	.L265
	xorl	%eax, %eax
.L266:
	movb	%al, 80(%rdi)
	movq	%rdx, %rdi
.L262:
	cmpq	%rbx, %rdi
	jne	.L263
	movq	56+QUARKTS(%rip), %rdi
	testq	%rdi, %rdi
	movq	%rdi, ChainIterator.3311(%rip)
	jne	.L342
.L264:
	movq	56+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3311(%rip)
	movzbl	82+QUARKTS(%rip), %eax
	testb	%al, %al
	je	.L268
	jmp	.L341
	.p2align 4,,10
.L265:
	movl	84(%rdi), %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movq	ChainIterator.3311(%rip), %rdx
	jmp	.L266
	.p2align 4,,10
.L337:
	movq	64+QUARKTS(%rip), %rax
	movq	$0, 56(%rsp)
	movq	56+QUARKTS(%rip), %rdx
	testq	%rax, %rax
	je	.L230
	movq	%rdx, 40(%rsp)
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movq	40(%rsp), %rdx
	movl	%eax, 84+QUARKTS(%rip)
.L230:
	testq	%rdx, %rdx
	je	.L231
	leaq	56(%rsp), %r11
	.p2align 4,,10
.L232:
	movq	(%rdx), %r10
	movq	%r11, %rcx
	call	_qScheduler_PriorizedInsert
	testq	%r10, %r10
	movq	%r10, %rdx
	jne	.L232
.L231:
	movq	56(%rsp), %rax
	movb	$1, 80+QUARKTS(%rip)
	movq	%rax, 56+QUARKTS(%rip)
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L229
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	movzwl	98+QUARKTS(%rip), %eax
	testw	%ax, %ax
	jns	.L343
.L234:
	movq	56+QUARKTS(%rip), %rcx
	testq	%rcx, %rcx
	je	.L243
	xorl	%edi, %edi
	jmp	.L270
	.p2align 4,,10
.L278:
	movl	$7, %edx
	movb	$1, 80(%rcx)
	movl	$1, %r8d
	movl	%edx, 84(%rcx)
	jmp	.L252
	.p2align 4,,10
.L272:
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L236
	.seh_endproc
	.p2align 4,,15
	.globl	qStateMachine_Attribute
	.def	qStateMachine_Attribute;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Attribute
qStateMachine_Attribute:
	.seh_endprologue
	cmpl	$5, %edx
	ja	.L344
	leaq	.L347(%rip), %r9
	movl	%edx, %edx
	movslq	(%r9,%rdx,4), %rax
	addq	%r9, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L347:
	.long	.L346-.L347
	.long	.L348-.L347
	.long	.L349-.L347
	.long	.L350-.L347
	.long	.L351-.L347
	.long	.L352-.L347
	.text
	.p2align 4,,10
.L352:
	movq	%r8, 64(%rcx)
.L344:
	ret
	.p2align 4,,10
.L351:
	movq	%r8, 56(%rcx)
	ret
	.p2align 4,,10
.L346:
	movq	%r8, (%rcx)
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	ret
	.p2align 4,,10
.L348:
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	ret
	.p2align 4,,10
.L349:
	movq	%r8, 40(%rcx)
	ret
	.p2align 4,,10
.L350:
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
	je	.L353
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	ja	.L353
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
	movl	_qSysTick_Epochs_(%rip), %eax
	movb	$1, (%rcx)
	movl	%eax, 4(%rcx)
	movl	$1, %eax
.L353:
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
	je	.L358
	cmpb	$0, (%rcx)
	jne	.L365
	pxor	%xmm0, %xmm0
	movss	48+QUARKTS(%rip), %xmm2
	cvtss2sd	%xmm2, %xmm2
	cvtss2sd	%xmm1, %xmm0
	mulsd	.LC2(%rip), %xmm0
	ucomisd	%xmm0, %xmm2
	jbe	.L366
.L358:
	ret
	.p2align 4,,10
.L365:
	movl	_qSysTick_Epochs_(%rip), %edx
	subl	4(%rcx), %edx
	cmpl	8(%rcx), %edx
	jb	.L358
	movl	$1, %eax
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
	ret
	.p2align 4,,10
.L366:
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
	je	.L367
	cmpb	$0, (%rcx)
	je	.L367
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
	cmpl	8(%rcx), %eax
	setnb	%al
.L367:
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
	je	.L372
	cmpb	$0, (%rcx)
	je	.L372
	movl	_qSysTick_Epochs_(%rip), %eax
	subl	4(%rcx), %eax
.L372:
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
	je	.L377
	cmpb	$0, (%rcx)
	movl	8(%rcx), %eax
	jne	.L386
.L377:
	ret
	.p2align 4,,10
.L386:
	testl	%eax, %eax
	movl	_qSysTick_Epochs_(%rip), %edx
	movl	4(%rcx), %ecx
	je	.L377
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
	je	.L387
	movb	$0, (%rcx)
	movl	$0, 4(%rcx)
.L387:
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
	je	.L392
	movzbl	(%rcx), %eax
.L392:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qSTimerChangeTime
	.def	qSTimerChangeTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerChangeTime
qSTimerChangeTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L396
	movss	48+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 8(%rcx)
.L396:
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
	je	.L405
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L405:
	movzbl	2(%r14), %ebx
	xorl	%r12d, %r12d
.L416:
	cmpb	%r12b, %bl
	jbe	.L415
	movq	8(%r14), %rdi
	movzbl	%r12b, %eax
	movzwl	(%r14), %r11d
	leaq	(%rdi,%rax), %rdx
	movzwl	%r11w, %r8d
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L417
	cmpw	%si, %r11w
	jnb	.L438
.L436:
	leal	1(%r12), %eax
	movl	%r11d, %r8d
	movl	$1, %r9d
	movzbl	%al, %eax
	jmp	.L410
	.p2align 4,,10
.L414:
	movzbl	(%rdi,%rax), %r10d
	testb	%r10b, %r10b
	jne	.L439
	addl	%r11d, %r8d
	leaq	1(%rax), %r10
	cmpw	%si, %r8w
	jnb	.L418
	movq	%r10, %rax
.L410:
	addl	$1, %r9d
	cmpb	%al, %bl
	movl	%eax, %ebp
	ja	.L414
.L408:
	cmpb	%bpl, %bl
	jne	.L416
.L415:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L421
	movq	72+QUARKTS(%rip), %rax
	xorl	%r13d, %r13d
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
	jmp	.L404
	.p2align 4,,10
.L417:
	movzbl	%cl, %eax
	addl	%ecx, %r12d
	imull	%r8d, %eax
	cltq
	addq	%rax, %r13
	cmpb	%r12b, %bl
	jbe	.L440
	movzbl	%r12b, %eax
	leaq	(%rdi,%rax), %rdx
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L417
	cmpw	%si, %r11w
	jb	.L436
.L438:
	movl	$1, %r9d
	.p2align 4,,10
.L418:
	testw	%r15w, %r15w
	movb	%r9b, (%rdx)
	je	.L411
	addq	%r13, %rax
	xorl	%edx, %edx
	.p2align 4,,10
.L412:
	addl	$1, %edx
	movzbl	%dl, %ecx
	cmpw	%si, %cx
	jb	.L412
	movb	$0, (%rax)
.L411:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L404
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	call	*%rax
.L404:
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
.L439:
	leal	(%r10,%rbp), %r12d
	movzbl	%r12b, %r13d
	imull	%r11d, %r13d
	movslq	%r13d, %r13
	addq	16(%r14), %r13
	cmpb	%bpl, %bl
	jne	.L416
	jmp	.L415
.L440:
	movl	%r12d, %ebp
	jmp	.L408
.L421:
	xorl	%r13d, %r13d
	jmp	.L404
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
	je	.L441
	testq	%rdx, %rdx
	je	.L441
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L445
	movq	64+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 84+QUARKTS(%rip)
.L445:
	movzbl	2(%rsi), %edx
	movq	16(%rsi), %r8
	testb	%dl, %dl
	je	.L446
	cmpq	%r8, %rbx
	je	.L464
	movzwl	(%rsi), %ecx
	xorl	%eax, %eax
	jmp	.L449
	.p2align 4,,10
.L450:
	cmpq	%r8, %rbx
	je	.L465
.L449:
	addl	$1, %eax
	addq	%rcx, %r8
	cmpb	%dl, %al
	jne	.L450
.L446:
	movq	72+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L441
	movq	72+QUARKTS(%rip), %rax
	movl	84+QUARKTS(%rip), %ecx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	rex.W jmp	*%rax
	.p2align 4,,10
.L441:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L465:
	movzbl	%al, %eax
.L447:
	movq	8(%rsi), %rdx
	movb	$0, (%rdx,%rax)
	jmp	.L446
	.p2align 4,,10
.L464:
	xorl	%eax, %eax
	jmp	.L447
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
	je	.L466
	testq	%rdx, %rdx
	je	.L466
	xorl	%ecx, %ecx
	movq	%rdx, (%r10)
	movzwl	%r9w, %edx
	movw	%cx, 12(%r10)
	leal	-1(%rdx), %ecx
	xorl	%r11d, %r11d
	movw	%r11w, 14(%r10)
	movw	%r8w, 8(%r10)
	testl	%edx, %ecx
	jne	.L474
	movw	%ax, 10(%r10)
.L466:
	ret
	.p2align 4,,10
.L474:
	subl	$1, %r9d
	movl	$4, %edx
	movl	$1, %ecx
.L469:
	movzwl	%r9w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r9d
	subl	$1, %edx
	jne	.L469
	movzwl	%r9w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 10(%r10)
	jmp	.L466
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	movl	$1, %eax
	testq	%rcx, %rcx
	je	.L475
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L475:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L482
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	cmpw	%ax, %dx
	je	.L482
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
.L482:
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
	je	.L483
	movzwl	12(%rbx), %r8d
	movzwl	14(%rbx), %edx
	cmpw	%dx, %r8w
	je	.L483
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
.L483:
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
	je	.L492
	testq	%rcx, %rcx
	je	.L492
	movzwl	12(%rcx), %edx
	movzwl	14(%rcx), %eax
	movzwl	10(%rcx), %r8d
	subl	%eax, %edx
	xorl	%eax, %eax
	cmpw	%r8w, %dx
	je	.L488
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
	je	.L490
	xorl	%eax, %eax
	.p2align 4,,10
.L491:
	movzwl	%ax, %r8d
	addl	$1, %eax
	leaq	(%r9,%r8), %rdx
	movzbl	(%r10,%r8), %r8d
	addq	%r11, %rdx
	movb	%r8b, (%rdx)
	movzwl	8(%rcx), %edx
	cmpw	%ax, %dx
	ja	.L491
.L490:
	movzwl	12(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 12(%rcx)
	movl	$1, %eax
.L488:
	ret
	.p2align 4,,10
.L492:
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
	je	.L504
	xorl	%r9d, %r9d
	.p2align 4,,10
.L506:
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
	jb	.L506
.L504:
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
	je	.L512
	xorl	%ebx, %ebx
	.p2align 4,,10
.L515:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	movsbl	(%r12,%rbx), %edx
	cmove	%rsi, %rcx
	addq	$1, %rbx
	call	*%rbp
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
	je	.L521
	xorl	%ebx, %ebx
	.p2align 4,,10
.L524:
	leaq	(%rsi,%rbx), %rcx
	testb	%r13b, %r13b
	cmove	%rsi, %rcx
	call	*%rbp
	movb	%al, (%r12,%rbx)
	addq	$1, %rbx
	cmpq	%rdi, %rbx
	jne	.L524
.L521:
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
	je	.L530
	xorl	%edi, %edi
	.p2align 4,,10
.L533:
	addq	$1, %rbx
	testb	%r12b, %r12b
	movq	%rsi, %rcx
	je	.L532
	leaq	(%rsi,%rdi), %rcx
	addq	$1, %rdi
.L532:
	call	*%rbp
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L533
.L530:
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
	je	.L541
	movzwl	%r9w, %r9d
	movq	%r8, %rbp
	leal	-1(%r9), %eax
	leaq	1(%r8,%rax), %rdi
	.p2align 4,,10
.L544:
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
	jne	.L544
.L541:
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
	js	.L547
	movslq	%r8d, %rdx
	movl	%r8d, %r8d
	leaq	-1(%rax,%rdx), %r11
	leaq	(%rax,%rdx), %r10
	subq	%r8, %r11
	.p2align 4,,10
.L549:
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
	jne	.L549
.L547:
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
.L552:
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	ja	.L551
.L564:
	testb	%bl, %bl
	je	.L551
	call	__locale_ctype_ptr
	movsbl	%bl, %ecx
	addq	$1, %rsi
	call	toupper
	movzbl	%al, %r13d
	movl	%eax, %ebx
	call	__locale_ctype_ptr
	testb	$68, 1(%rax,%r13)
	je	.L553
	leal	-48(%rbx), %edx
	addl	$1, %edi
	cmpb	$9, %dl
	jbe	.L554
	leal	-65(%rbx), %eax
	movl	%r13d, %edx
	subl	$55, %ebx
	cmpb	$6, %al
	cmovb	%ebx, %edx
.L554:
	movl	%edx, %ebx
	sall	$4, %ebp
	andl	$15, %ebx
	orl	%ebx, %ebp
	cmpb	$7, %dil
	movzbl	(%rsi), %ebx
	jbe	.L564
.L551:
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
.L553:
	call	__locale_ctype_ptr
	testb	$8, 1(%rax,%r13)
	jne	.L552
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
.L566:
	call	__locale_ctype_ptr
	movsbq	(%rbx,%rsi), %rcx
	movl	%esi, %edi
	addq	$1, %rsi
	testb	$8, 1(%rax,%rcx)
	jne	.L566
	cmpb	$45, %cl
	je	.L574
	cmpb	$43, %cl
	movl	$1, %esi
	je	.L567
.L568:
	movslq	%edi, %rdi
	pxor	%xmm6, %xmm6
	movsd	.LC5(%rip), %xmm7
	jmp	.L569
	.p2align 4,,10
.L570:
	pxor	%xmm0, %xmm0
	subl	$48, %edx
	movapd	%xmm6, %xmm1
	cvtsi2sd	%edx, %xmm0
	mulsd	%xmm7, %xmm1
	movapd	%xmm0, %xmm6
	addsd	%xmm1, %xmm6
.L569:
	call	__locale_ctype_ptr
	movsbl	(%rbx,%rdi), %edx
	movl	%edi, %ebp
	addq	$1, %rdi
	movsbq	%dl, %rcx
	testb	$4, 1(%rax,%rcx)
	jne	.L570
	xorl	%eax, %eax
	cmpb	$46, %dl
	sete	%al
	movsd	.LC4(%rip), %xmm7
	addl	%eax, %ebp
	movsd	.LC5(%rip), %xmm8
	movslq	%ebp, %rbp
	addq	%rbp, %rbx
	jmp	.L572
	.p2align 4,,10
.L573:
	pxor	%xmm1, %xmm1
	subl	$48, %edx
	movapd	%xmm6, %xmm0
	mulsd	%xmm8, %xmm7
	cvtsi2sd	%edx, %xmm1
	mulsd	%xmm8, %xmm0
	addsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm6
.L572:
	call	__locale_ctype_ptr
	movsbl	(%rbx), %edx
	addq	$1, %rbx
	movsbq	%dl, %rcx
	testb	$4, 1(%rax,%rcx)
	jne	.L573
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
.L574:
	movl	$-1, %esi
.L567:
	addl	$1, %edi
	jmp	.L568
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
	jmp	.L578
	.p2align 4,,10
.L579:
	addq	$1, %rbx
.L578:
	call	__locale_ctype_ptr
	movsbq	(%rbx), %rcx
	testb	$8, 1(%rax,%rcx)
	movq	%rcx, %rdx
	jne	.L579
	cmpb	$45, %cl
	je	.L593
	cmpb	$43, %cl
	movl	$1, %r8d
	je	.L594
.L581:
	testb	%dl, %dl
	je	.L589
	leal	-48(%rdx), %eax
	cmpb	$9, %al
	movl	$0, %eax
	jbe	.L582
	jmp	.L577
	.p2align 4,,10
.L584:
	leal	-48(%rdx), %ecx
	cmpb	$9, %cl
	ja	.L592
.L582:
	leal	(%rax,%rax,4), %ecx
	addq	$1, %rbx
	leal	-48(%rdx,%rcx,2), %eax
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L584
.L592:
	imull	%r8d, %eax
.L577:
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L594:
	movsbl	1(%rbx), %edx
	addq	$1, %rbx
	jmp	.L581
	.p2align 4,,10
.L593:
	movsbl	1(%rbx), %edx
	movl	$-1, %r8d
	addq	$1, %rbx
	jmp	.L581
	.p2align 4,,10
.L589:
	xorl	%eax, %eax
	jmp	.L577
	.seh_endproc
	.p2align 4,,15
	.globl	qUtoA
	.def	qUtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qUtoA
qUtoA:
	.seh_endprologue
	movl	%ecx, %eax
	movq	%rdx, %rcx
	testl	%eax, %eax
	je	.L608
	movzbl	%r8b, %r8d
	xorl	%r9d, %r9d
	jmp	.L600
	.p2align 4,,10
.L603:
	movl	%r11d, %r9d
.L600:
	xorl	%edx, %edx
	divl	%r8d
	leal	55(%rdx), %r11d
	leal	48(%rdx), %r10d
	cmpl	$10, %edx
	movl	%r11d, %edx
	leal	1(%r9), %r11d
	cmovb	%r10d, %edx
	movzwl	%r9w, %r10d
	testl	%eax, %eax
	movb	%dl, (%rcx,%r10)
	jne	.L603
	movzwl	%r11w, %r11d
	testw	%r9w, %r9w
	movb	$0, (%rcx,%r11)
	je	.L597
	xorl	%edx, %edx
	jmp	.L602
	.p2align 4,,10
.L609:
	movzwl	%r9w, %r10d
.L602:
	movzwl	%dx, %eax
	addq	%rcx, %r10
	addl	$1, %edx
	addq	%rcx, %rax
	movzbl	(%r10), %r11d
	subl	$1, %r9d
	movzbl	(%rax), %r8d
	cmpw	%r9w, %dx
	movb	%r11b, (%rax)
	movb	%r8b, (%r10)
	jb	.L609
.L597:
	movq	%rcx, %rax
	ret
	.p2align 4,,10
.L608:
	movl	$48, %eax
	movw	%ax, (%rdx)
	movq	%rcx, %rax
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qItoA
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qItoA
qItoA:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testl	%ecx, %ecx
	movq	%rdx, %rbx
	je	.L613
	movzbl	%r8b, %r8d
	call	qItoA.part.5
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L613:
	movl	$48, %eax
	movw	%ax, (%rdx)
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
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
	je	.L617
	ret
	.p2align 4,,10
.L617:
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
	jp	.L620
	je	.L643
.L620:
	movd	%xmm0, %edx
	movd	%xmm0, %eax
	andl	$2147483647, %edx
	cmpl	$2139095040, %edx
	jne	.L644
	movq	%r9, %rax
	movl	$1718511915, (%r9)
	movb	$0, 4(%r9)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L644:
	movd	%xmm0, %edx
	andl	$2139095040, %edx
	cmpl	$2139095040, %edx
	je	.L645
.L625:
	ucomiss	%xmm0, %xmm1
	leaq	1(%r9), %r10
	movq	%r9, %r11
	ja	.L646
.L633:
	cvttss2si	%xmm0, %ebx
	testl	%ebx, %ebx
	jne	.L634
	movb	$48, (%r11)
.L628:
	testb	%r8b, %r8b
	je	.L630
	pxor	%xmm1, %xmm1
	cmpb	$10, %r8b
	movl	$10, %eax
	cmova	%eax, %r8d
	leaq	1(%r10), %r11
	movb	$46, (%r10)
	subl	$1, %r8d
	movss	.LC7(%rip), %xmm2
	cvtsi2ss	%ebx, %xmm1
	movzbl	%r8b, %r8d
	movq	%r11, %rdx
	leaq	2(%r10,%r8), %r10
	subss	%xmm1, %xmm0
	.p2align 4,,10
.L631:
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
	jne	.L631
	leaq	1(%r11,%r8), %r10
.L630:
	movq	%r9, %rax
	movb	$0, (%r10)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L643:
	movq	%r9, %rax
	movl	$3157552, (%rdx)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L645:
	testl	$8388607, %eax
	je	.L625
	movq	%r9, %rax
	movl	$7233902, (%r9)
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r14
	ret
	.p2align 4,,10
.L646:
	movq	%r10, %r11
	xorps	.LC6(%rip), %xmm0
	movb	$45, (%r9)
	leaq	2(%r9), %r10
	jmp	.L633
	.p2align 4,,10
.L634:
	movl	%ebx, %ecx
	movq	%r11, %r10
	movl	$1717986919, %esi
	.p2align 4,,10
.L627:
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
	jne	.L627
	movq	%r10, %rcx
	subq	%r11, %rcx
	subw	$1, %cx
	je	.L628
	xorl	%esi, %esi
	.p2align 4,,10
.L629:
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
	jb	.L629
	jmp	.L628
	.seh_endproc
	.p2align 4,,15
	.globl	qISR_ByteBufferInit
	.def	qISR_ByteBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qISR_ByteBufferInit
qISR_ByteBufferInit:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L649
	cmpw	$1, %r8w
	jbe	.L649
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
.L649:
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
	jne	.L656
	movq	16(%rcx), %rax
	testq	%rax, %rax
	je	.L657
	movq	16(%rcx), %rax
	movsbl	%dl, %ecx
	call	*%rax
	testb	%al, %al
	je	.L656
.L657:
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L662
	movq	24(%rbx), %rax
	movsbl	%sil, %ecx
	call	*%rax
.L655:
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
	jb	.L658
	xorl	%edx, %edx
	movw	%dx, 8(%rbx)
.L658:
	movzbl	32(%rbx), %eax
	cmpb	%sil, %al
	je	.L663
.L656:
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L663:
	xorl	%eax, %eax
	movb	$1, 10(%rbx)
	movw	%ax, 8(%rbx)
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L662:
	movl	%esi, %eax
	jmp	.L655
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
	je	.L664
	movzwl	8(%rbx), %r8d
	movq	(%rbx), %rdx
	call	memcpy
	movb	$0, 10(%rbx)
	movl	$1, %eax
.L664:
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
	je	.L668
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	subl	%edx, %eax
	cltq
.L668:
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
	je	.L672
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %edx
	movzwl	16(%rcx), %ecx
	subl	%edx, %eax
	cltq
	cmpq	%rax, %rcx
	sete	%al
.L672:
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
	je	.L676
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	cmpw	%ax, %dx
	sete	%al
.L676:
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
	je	.L680
	movzwl	2(%rcx), %eax
	xorl	%edx, %edx
	divw	16(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movzbl	(%rdx), %eax
.L680:
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
	je	.L684
	movzwl	(%rcx), %r9d
	movzwl	2(%rcx), %edx
	cmpw	%dx, %r9w
	je	.L684
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
.L684:
	ret
	.seh_endproc
	.p2align 4,,15
	.globl	qBSBuffer_Read
	.def	qBSBuffer_Read;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Read
qBSBuffer_Read:
	.seh_endprologue
	testw	%r8w, %r8w
	je	.L692
	testq	%rcx, %rcx
	je	.L692
	movzwl	(%rcx), %eax
	movzwl	2(%rcx), %r9d
	cmpw	%ax, %r9w
	je	.L692
	subl	$1, %r8d
	movq	%rdx, %r9
	movzwl	%r8w, %r8d
	addq	%rdx, %r8
	.p2align 4,,10
.L693:
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
	je	.L699
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %eax
	addq	$1, %r9
	cmpw	%ax, %dx
	jne	.L693
.L692:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L699:
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
	je	.L700
	movzwl	(%rcx), %edx
	movzwl	2(%rcx), %r8d
	movzwl	16(%rcx), %r9d
	subl	%r8d, %edx
	movslq	%edx, %rdx
	movzwl	%r9w, %r8d
	cmpq	%r8, %rdx
	je	.L700
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
.L700:
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
	je	.L705
	xorl	%ecx, %ecx
	movq	%rdx, 8(%r9)
	movzwl	%r8w, %edx
	movw	%cx, (%r9)
	leal	-1(%rdx), %ecx
	xorl	%r10d, %r10d
	movw	%r10w, 2(%r9)
	testl	%edx, %ecx
	jne	.L716
	movw	%ax, 16(%r9)
.L705:
	ret
	.p2align 4,,10
.L716:
	subl	$1, %r8d
	movl	$4, %edx
	movl	$1, %ecx
.L708:
	movzwl	%r8w, %eax
	sarl	%cl, %eax
	addl	%ecx, %ecx
	orl	%eax, %r8d
	subl	$1, %edx
	jne	.L708
	movzwl	%r8w, %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%r9)
	jmp	.L705
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
	jne	.L719
	cmpq	$0, (%rcx)
	je	.L723
.L719:
	movzbl	12(%rcx), %edx
	xorl	%eax, %eax
	testb	%dl, %dl
	je	.L718
	xorl	%eax, %eax
	xorl	%edx, %edx
	movq	$0, (%rcx)
	movw	%ax, 8(%rcx)
	movw	%dx, 10(%rcx)
	movl	$1, %eax
	movb	$0, 12(%rcx)
.L718:
	ret
	.p2align 4,,10
.L723:
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
	je	.L724
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L724
	movzwl	10(%rcx), %eax
	cmpb	%dl, (%r8,%rax)
	je	.L733
.L727:
	movzbl	12(%rcx), %eax
.L724:
	ret
	.p2align 4,,10
.L733:
	movzwl	10(%rcx), %eax
	addl	$1, %eax
	movw	%ax, 10(%rcx)
	movzwl	10(%rcx), %eax
	cmpw	8(%rcx), %ax
	jne	.L727
	movb	$1, 12(%rcx)
	jmp	.L727
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC8:
	.ascii "--------------------------------------------------------------------\15\12\0"
	.align 8
.LC9:
	.ascii "TaskData\11Priority\11Interval\11Iterations\15\12\0"
.LC10:
	.ascii "\11\11\0"
.LC11:
	.ascii "qPeriodic\0"
.LC12:
	.ascii "\15\12\0"
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
	movq	__qDebugOutputFcn(%rip), %rsi
	leaq	.LC8(%rip), %rbx
	movl	$45, %edx
	.p2align 4,,10
.L735:
	addq	$1, %rbx
	xorl	%ecx, %ecx
	call	*%rsi
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L735
	movq	__qDebugOutputFcn(%rip), %rsi
	leaq	.LC9(%rip), %rbx
	movl	$84, %edx
	.p2align 4,,10
.L736:
	addq	$1, %rbx
	xorl	%ecx, %ecx
	call	*%rsi
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L736
	movq	__qDebugOutputFcn(%rip), %rsi
	leaq	.LC8(%rip), %rbx
	movl	$45, %edx
	.p2align 4,,10
.L737:
	addq	$1, %rbx
	xorl	%ecx, %ecx
	call	*%rsi
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L737
	movq	56+QUARKTS(%rip), %rbx
	testq	%rbx, %rbx
	je	.L738
	leaq	qDebugTrace_Buffer(%rip), %rsi
	.p2align 4,,10
.L760:
	movq	8(%rbx), %rdi
	movq	__qDebugOutputFcn(%rip), %rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	je	.L739
	.p2align 4,,10
.L740:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L740
	movq	__qDebugOutputFcn(%rip), %rbp
.L739:
	leaq	.LC10(%rip), %rdi
	movl	$9, %edx
	.p2align 4,,10
.L741:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L741
	movzbl	40(%rbx), %ecx
	testl	%ecx, %ecx
	jne	.L742
	movq	__qDebugOutputFcn(%rip), %rbp
	movl	$48, %ecx
	movl	$48, %edx
	movw	%cx, qDebugTrace_Buffer(%rip)
.L743:
	leaq	qDebugTrace_Buffer(%rip), %rdi
	.p2align 4,,10
.L745:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L745
	movq	__qDebugOutputFcn(%rip), %rbp
.L744:
	leaq	.LC10(%rip), %rdi
	movl	$9, %edx
	.p2align 4,,10
.L746:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L746
	movl	24(%rbx), %ecx
	testl	%ecx, %ecx
	jne	.L747
	movq	__qDebugOutputFcn(%rip), %rbp
	movl	$48, %edx
	movw	%dx, qDebugTrace_Buffer(%rip)
	movl	$48, %edx
.L748:
	leaq	qDebugTrace_Buffer(%rip), %rdi
	.p2align 4,,10
.L750:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L750
	movq	__qDebugOutputFcn(%rip), %rbp
.L749:
	leaq	.LC10(%rip), %rdi
	movl	$9, %edx
	.p2align 4,,10
.L751:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L751
	movzwl	32(%rbx), %eax
	cmpw	$-32768, %ax
	je	.L792
	movzwl	32(%rbx), %eax
	testw	%ax, %ax
	jne	.L755
	movq	__qDebugOutputFcn(%rip), %rbp
	movl	$48, %eax
	movl	$48, %edx
	movw	%ax, qDebugTrace_Buffer(%rip)
.L756:
	leaq	qDebugTrace_Buffer(%rip), %rdi
	.p2align 4,,10
.L758:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L758
.L791:
	movq	__qDebugOutputFcn(%rip), %rbp
.L757:
	leaq	.LC12(%rip), %rdi
	movl	$13, %edx
	.p2align 4,,10
.L759:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L759
	movq	(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.L760
.L738:
	movq	__qDebugOutputFcn(%rip), %rsi
	leaq	.LC8(%rip), %rbx
	movl	$45, %edx
	.p2align 4,,10
.L761:
	addq	$1, %rbx
	xorl	%ecx, %ecx
	call	*%rsi
	movsbl	(%rbx), %edx
	testb	%dl, %dl
	jne	.L761
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
.L792:
	movq	__qDebugOutputFcn(%rip), %rbp
	leaq	.LC11(%rip), %rdi
	movl	$113, %edx
	.p2align 4,,10
.L753:
	addq	$1, %rdi
	xorl	%ecx, %ecx
	call	*%rbp
	movsbl	(%rdi), %edx
	testb	%dl, %dl
	jne	.L753
	jmp	.L791
	.p2align 4,,10
.L742:
	leaq	qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	call	qItoA.part.5
	movsbl	(%rsi), %edx
	movq	__qDebugOutputFcn(%rip), %rbp
	testb	%dl, %dl
	jne	.L743
	jmp	.L744
	.p2align 4,,10
.L747:
	leaq	qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	call	qItoA.part.5
	movsbl	(%rsi), %edx
	movq	__qDebugOutputFcn(%rip), %rbp
	testb	%dl, %dl
	jne	.L748
	jmp	.L749
	.p2align 4,,10
.L755:
	movswl	%ax, %ecx
	leaq	qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	negl	%ecx
	call	qItoA.part.5
	movsbl	(%rsi), %edx
	movq	__qDebugOutputFcn(%rip), %rbp
	testb	%dl, %dl
	jne	.L756
	jmp	.L757
	.seh_endproc
	.data
	.align 8
ChainIterator.3311:
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
