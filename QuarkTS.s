	.file	"QuarkTS.c"
	.text
	.globl	qTaskSendEvent
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSendEvent
qTaskSendEvent:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L1
	movb	$1, 69(%rcx)
	movb	$1, %al
	movq	%rdx, 16(%rcx)
.L1:
	ret
	.seh_endproc
	.def	_qScheduler_FindPlace;	.scl	3;	.type	32;	.endef
	.seh_proc	_qScheduler_FindPlace
_qScheduler_FindPlace:
	.seh_endprologue
	movb	66(%rdx), %al
.L6:
	movq	(%rcx), %r8
	testq	%r8, %r8
	jne	.L7
.L9:
	movq	(%rcx), %rax
	movq	%rax, (%rdx)
	movq	%rdx, (%rcx)
	ret
.L7:
	movq	(%rcx), %r8
	movb	66(%r8), %r8b
	cmpb	%al, %r8b
	jb	.L9
	movq	(%rcx), %rcx
	jmp	.L6
	.seh_endproc
	.def	qStatemachine_ExecSubStateIfAvailable;	.scl	3;	.type	32;	.endef
	.seh_proc	qStatemachine_ExecSubStateIfAvailable
qStatemachine_ExecSubStateIfAvailable:
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rax
	je	.L11
	movq	%rdx, %rcx
	rex.W jmp	*%rax
.L11:
	ret
	.seh_endproc
	.def	_qRBufferValidPowerOfTwo;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferValidPowerOfTwo
_qRBufferValidPowerOfTwo:
	.seh_endprologue
	movzwl	%cx, %edx
	movl	%ecx, %r8d
	leal	-1(%rdx), %ecx
	movl	%r8d, %eax
	testl	%edx, %ecx
	je	.L13
	leal	-1(%r8), %eax
	movl	$4, %edx
	movl	$1, %ecx
.L15:
	movzwl	%ax, %r9d
	sarl	%cl, %r9d
	addl	%ecx, %ecx
	orl	%r9d, %eax
	decl	%edx
	jne	.L15
	movzwl	%ax, %edx
	incl	%edx
	sarl	%edx
	cmpw	%dx, %r8w
	movl	%edx, %eax
	jbe	.L13
	leal	(%rdx,%rdx), %eax
.L13:
	ret
	.seh_endproc
	.globl	__qReg_32Bits
	.def	__qReg_32Bits;	.scl	2;	.type	32;	.endef
	.seh_proc	__qReg_32Bits
__qReg_32Bits:
	.seh_endprologue
	movl	$1, %eax
	movq	%rcx, %r8
	movb	%dl, %cl
	sall	%cl, %eax
	testl	%eax, (%r8)
	setne	%al
	ret
	.seh_endproc
	.def	_qATPutc_Wrapper;	.scl	3;	.type	32;	.endef
	.seh_proc	_qATPutc_Wrapper
_qATPutc_Wrapper:
	.seh_endprologue
	movsbl	%cl, %edx
	xorl	%ecx, %ecx
	rex.W jmp	*ATOutCharFcn(%rip)
	.seh_endproc
	.def	_qATPuts_Wrapper;	.scl	3;	.type	32;	.endef
	.seh_proc	_qATPuts_Wrapper
_qATPuts_Wrapper:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	xorl	%ebx, %ebx
	movq	%rcx, %rsi
.L22:
	movzwl	%bx, %eax
	movsbl	(%rsi,%rax), %edx
	testb	%dl, %dl
	je	.L24
	incl	%ebx
	xorl	%ecx, %ecx
	call	*ATOutCharFcn(%rip)
	jmp	.L22
.L24:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.def	_qATParser_FixInput;	.scl	3;	.type	32;	.endef
	.seh_proc	_qATParser_FixInput
_qATParser_FixInput:
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
	xorl	%ebx, %ebx
	movq	%rcx, %rdi
	movq	%rcx, %rsi
.L26:
	movb	(%rsi), %al
	testb	%al, %al
	je	.L34
	cmpb	$13, %al
	jne	.L27
	movb	$0, (%rsi)
	jmp	.L28
.L27:
	call	__locale_ctype_ptr
	movsbq	(%rsi), %rdx
	testb	$23, 1(%rax,%rdx)
	movq	%rdx, %rbp
	je	.L29
	call	__locale_ctype_ptr
	movsbl	%bpl, %ecx
	call	tolower
	movslq	%ebx, %rdx
	incl	%ebx
	movb	%al, (%rdi,%rdx)
.L29:
	incq	%rsi
	jmp	.L26
.L34:
	movslq	%ebx, %rbx
	movb	$0, (%rdi,%rbx)
.L28:
	movq	%rdi, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.globl	qTaskQueueEvent
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskQueueEvent
qTaskQueueEvent:
	subq	$24, %rsp
	.seh_stackalloc	24
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L35
	movswl	QUARKTS(%rip), %r9d
	movzbl	2+QUARKTS(%rip), %r8d
	decl	%r8d
	cmpl	%r8d, %r9d
	jge	.L35
	movq	%rdx, 8(%rsp)
	movq	%rcx, (%rsp)
	movq	8+QUARKTS(%rip), %rdx
	movw	QUARKTS(%rip), %ax
	incl	%eax
	movw	%ax, QUARKTS(%rip)
	movq	(%rsp), %r9
	movswq	%ax, %rax
	movq	8(%rsp), %r10
	salq	$4, %rax
	movq	%r9, (%rdx,%rax)
	movq	%r10, 8(%rdx,%rax)
	movb	$1, %al
.L35:
	addq	$24, %rsp
	ret
	.seh_endproc
	.globl	qEnterCritical
	.def	qEnterCritical;	.scl	2;	.type	32;	.endef
	.seh_proc	qEnterCritical
qEnterCritical:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	56+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L39
	movq	56+QUARKTS(%rip), %rax
	call	*%rax
	movl	%eax, 72+QUARKTS(%rip)
.L39:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qExitCritical
	.def	qExitCritical;	.scl	2;	.type	32;	.endef
	.seh_proc	qExitCritical
qExitCritical:
	.seh_endprologue
	movq	64+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L44
	movq	64+QUARKTS(%rip), %rax
	movl	72+QUARKTS(%rip), %ecx
	rex.W jmp	*%rax
.L44:
	ret
	.seh_endproc
	.globl	qClock2Time
	.def	qClock2Time;	.scl	2;	.type	32;	.endef
	.seh_proc	qClock2Time
qClock2Time:
	.seh_endprologue
	movss	40+QUARKTS(%rip), %xmm1
	movl	%ecx, %ecx
	cvtsi2ssq	%rcx, %xmm0
	mulss	%xmm1, %xmm0
	ret
	.seh_endproc
	.globl	qTime2Clock
	.def	qTime2Clock;	.scl	2;	.type	32;	.endef
	.seh_proc	qTime2Clock
qTime2Clock:
	.seh_endprologue
	movss	40+QUARKTS(%rip), %xmm1
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	ret
	.seh_endproc
	.globl	qTaskSelf
	.def	qTaskSelf;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSelf
qTaskSelf:
	.seh_endprologue
	movq	80+QUARKTS(%rip), %rax
	ret
	.seh_endproc
	.globl	qTaskIsEnabled
	.def	qTaskIsEnabled;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskIsEnabled
qTaskIsEnabled:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L51
	movb	70(%rcx), %al
.L51:
	ret
	.seh_endproc
	.globl	qSchedulerSetIdleTask
	.def	qSchedulerSetIdleTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetIdleTask
qSchedulerSetIdleTask:
	.seh_endprologue
	movq	%rcx, 24+QUARKTS(%rip)
	ret
	.seh_endproc
	.globl	qSchedulerRelease
	.def	qSchedulerRelease;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRelease
qSchedulerRelease:
	.seh_endprologue
	movb	$1, 78+QUARKTS(%rip)
	ret
	.seh_endproc
	.globl	qSchedulerSetReleaseCallback
	.def	qSchedulerSetReleaseCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetReleaseCallback
qSchedulerSetReleaseCallback:
	.seh_endprologue
	movq	%rcx, 32+QUARKTS(%rip)
	ret
	.seh_endproc
	.globl	qTaskGetCycles
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskGetCycles
qTaskGetCycles:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L57
	movl	56(%rcx), %eax
.L57:
	ret
	.seh_endproc
	.globl	qSchedulerSpreadEvent
	.def	qSchedulerSpreadEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSpreadEvent
qSchedulerSpreadEvent:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leaq	qTaskQueueEvent(%rip), %rax
	movq	%rcx, %rdi
	movq	%rdx, %rsi
	cmpq	%rax, %rdx
	je	.L61
	leaq	qTaskSendEvent(%rip), %rax
	cmpq	%rax, %rdx
	je	.L61
.L64:
	xorl	%eax, %eax
	jmp	.L60
.L61:
	movq	48+QUARKTS(%rip), %rbx
.L63:
	testq	%rbx, %rbx
	je	.L69
	movq	%rdi, %rdx
	movq	%rbx, %rcx
	call	*%rsi
	testb	%al, %al
	je	.L64
	movq	(%rbx), %rbx
	jmp	.L63
.L69:
	movb	$1, %al
.L60:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	qTaskSetTime
	.def	qTaskSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetTime
qTaskSetTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L70
	movss	40+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 48(%rcx)
.L70:
	ret
	.seh_endproc
	.globl	qTaskSetIterations
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetIterations
qTaskSetIterations:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L75
	cmpw	$-32768, %dx
	movl	%edx, %eax
	je	.L77
	negl	%eax
.L77:
	movw	%ax, 64(%rcx)
.L75:
	ret
	.seh_endproc
	.globl	qTaskSetPriority
	.def	qTaskSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetPriority
qTaskSetPriority:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L82
	movb	$0, 76+QUARKTS(%rip)
	movb	%dl, 66(%rcx)
.L82:
	ret
	.seh_endproc
	.globl	qTaskSetCallback
	.def	qTaskSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetCallback
qTaskSetCallback:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L87
	movq	%rdx, 24(%rcx)
.L87:
	ret
	.seh_endproc
	.globl	qTaskSetData
	.def	qTaskSetData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetData
qTaskSetData:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L92
	movq	%rdx, 8(%rcx)
.L92:
	ret
	.seh_endproc
	.globl	qSchedulerSetInterruptsED
	.def	qSchedulerSetInterruptsED;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetInterruptsED
qSchedulerSetInterruptsED:
	.seh_endprologue
	movq	%rcx, 64+QUARKTS(%rip)
	movq	%rdx, 56+QUARKTS(%rip)
	ret
	.seh_endproc
	.globl	_qInitScheduler
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qInitScheduler
_qInitScheduler:
	.seh_endprologue
	movl	40(%rsp), %eax
	movq	$0, 48+QUARKTS(%rip)
	movss	%xmm1, 40+QUARKTS(%rip)
	movq	%r8, 24+QUARKTS(%rip)
	movq	$0, 32+QUARKTS(%rip)
	movq	%r9, 8+QUARKTS(%rip)
	movb	%al, 2+QUARKTS(%rip)
	xorl	%eax, %eax
.L99:
	movb	2+QUARKTS(%rip), %dl
	cmpb	%al, %dl
	jbe	.L101
	movq	8+QUARKTS(%rip), %r8
	movzbl	%al, %edx
	incl	%eax
	salq	$4, %rdx
	movq	$0, (%r8,%rdx)
	jmp	.L99
.L101:
	movw	$-1, QUARKTS(%rip)
	movq	$0, 16+QUARKTS(%rip)
	movb	$0, 76+QUARKTS(%rip)
	movb	$0, 78+QUARKTS(%rip)
	movb	$0, 79+QUARKTS(%rip)
	movq	$0, 64+QUARKTS(%rip)
	movq	$0, 56+QUARKTS(%rip)
	movq	$0, 80+QUARKTS(%rip)
	movq	%rcx, 88+QUARKTS(%rip)
	movl	$0, _qSysTick_Epochs_(%rip)
	ret
	.seh_endproc
	.globl	qSchedulerRemoveTask
	.def	qSchedulerRemoveTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRemoveTask
qSchedulerRemoveTask:
	.seh_endprologue
	movq	48+QUARKTS(%rip), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L102
	xorl	%eax, %eax
.L104:
	cmpq	%rcx, %rdx
	je	.L105
	movq	(%rdx), %rax
	testq	%rax, %rax
	je	.L102
	movq	(%rdx), %r8
	movq	%rdx, %rax
	movq	%r8, %rdx
	jmp	.L104
.L105:
	testq	%rax, %rax
	je	.L112
	movq	(%rdx), %rcx
	movq	%rcx, (%rax)
	jmp	.L107
.L112:
	movq	(%rdx), %rax
	movq	%rax, 48+QUARKTS(%rip)
.L107:
	movq	$0, (%rdx)
	movb	$1, %al
.L102:
	ret
	.seh_endproc
	.globl	qTaskLinkRBuffer
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskLinkRBuffer
qTaskLinkRBuffer:
	.seh_endprologue
	testq	%rdx, %rdx
	je	.L117
	testq	%rcx, %rcx
	je	.L117
	leal	-3(%r8), %r10d
	xorl	%eax, %eax
	cmpl	$3, %r10d
	ja	.L113
	cmpq	$0, (%rdx)
	je	.L113
	cmpl	$5, %r8d
	movb	%r9b, %al
	je	.L115
	testb	%r9b, %r9b
	setne	%al
.L115:
	movl	%r8d, %r8d
	testb	%r9b, %r9b
	movb	%al, 68(%rcx,%r8)
	movl	$0, %eax
	cmove	%rax, %rdx
	movb	$1, %al
	movq	%rdx, 40(%rcx)
	jmp	.L113
.L117:
	xorl	%eax, %eax
.L113:
	ret
	.seh_endproc
	.globl	qSchedulerSysTick
	.def	qSchedulerSysTick;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSysTick
qSchedulerSysTick:
	.seh_endprologue
	movl	_qSysTick_Epochs_(%rip), %eax
	incl	%eax
	movl	%eax, _qSysTick_Epochs_(%rip)
	ret
	.seh_endproc
	.globl	qSchedulerGetTick
	.def	qSchedulerGetTick;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerGetTick
qSchedulerGetTick:
	.seh_endprologue
	movq	88+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L123
	rex.W jmp	*88+QUARKTS(%rip)
.L123:
	movl	_qSysTick_Epochs_(%rip), %eax
	ret
	.seh_endproc
	.globl	__qCRDelay_Reached
	.def	__qCRDelay_Reached;	.scl	2;	.type	32;	.endef
	.seh_proc	__qCRDelay_Reached
__qCRDelay_Reached:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$64, %rsp
	.seh_stackalloc	64
	movaps	%xmm6, 48(%rsp)
	.seh_savexmm	%xmm6, 48
	.seh_endprologue
	movss	%xmm1, 44(%rsp)
	movss	40+QUARKTS(%rip), %xmm6
	movl	4(%rcx), %ebx
	call	qSchedulerGetTick
	movss	44(%rsp), %xmm1
	divss	%xmm6, %xmm1
	subl	%ebx, %eax
	movaps	48(%rsp), %xmm6
	cvttss2siq	%xmm1, %rdx
	cmpl	%edx, %eax
	setnb	%al
	addq	$64, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qTaskSetState
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetState
qTaskSetState:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L125
	testb	%dl, %dl
	je	.L127
	movb	70(%rcx), %al
	testb	%al, %al
	jne	.L125
.L127:
	movb	%dl, 70(%rbx)
	call	qSchedulerGetTick
	movl	%eax, 52(%rbx)
.L125:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qTaskClearTimeElapsed
	.def	qTaskClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskClearTimeElapsed
qTaskClearTimeElapsed:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L131
	call	qSchedulerGetTick
	movl	%eax, 52(%rbx)
.L131:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qSchedulerAdd_Task
	.def	qSchedulerAdd_Task;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAdd_Task
qSchedulerAdd_Task:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	96(%rsp), %r9d
	movl	104(%rsp), %r11d
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	movq	%rdx, %r10
	movl	%r8d, 44(%rsp)
	je	.L142
	testq	%rdx, %rdx
	je	.L142
	call	qSchedulerRemoveTask
	movq	%r10, 24(%rbx)
	movl	44(%rsp), %r8d
	cmpw	$-32768, %r9w
	movss	40+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm3
	cvttss2siq	%xmm3, %rax
	movl	%eax, 48(%rbx)
	movq	112(%rsp), %rax
	movq	%rax, 8(%rbx)
	movb	%r8b, 66(%rbx)
	movl	%r9d, %eax
	je	.L138
	negl	%eax
.L138:
	testb	%r11b, %r11b
	movw	%ax, 64(%rbx)
	movb	$0, 69(%rbx)
	setne	%al
	movb	$0, 68(%rbx)
	movb	$0, 71(%rbx)
	movb	$0, 73(%rbx)
	movb	$0, 73(%rbx)
	movb	$0, 74(%rbx)
	movb	%al, 70(%rbx)
	movq	$0, (%rbx)
	movl	$0, 56(%rbx)
	call	qSchedulerGetTick
	movl	%eax, 52(%rbx)
	movq	$0, 40(%rbx)
	movq	$0, 32(%rbx)
	movb	$3, 67(%rbx)
	movq	48+QUARKTS(%rip), %r9
	testq	%r9, %r9
	je	.L139
	movb	66(%rbx), %dl
	movb	66(%r9), %al
	cmpb	%al, %dl
	jbe	.L140
.L139:
	movq	%r9, (%rbx)
	jmp	.L141
.L140:
	movq	%rbx, %rdx
	movq	%r9, %rcx
	call	_qScheduler_FindPlace
	movq	%r9, %rbx
.L141:
	movq	%rbx, 48+QUARKTS(%rip)
	movb	$1, %al
	jmp	.L136
.L142:
	xorl	%eax, %eax
.L136:
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qSchedulerAdd_EventTask
	.def	qSchedulerAdd_EventTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAdd_EventTask
qSchedulerAdd_EventTask:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	xorps	%xmm3, %xmm3
	movq	%r9, 48(%rsp)
	movl	$0, 40(%rsp)
	movzbl	%r8b, %r8d
	movl	$1, 32(%rsp)
	call	qSchedulerAdd_Task
	addq	$72, %rsp
	ret
	.seh_endproc
	.globl	qStateMachine_Init
	.def	qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Init
qStateMachine_Init:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L150
	testq	%rdx, %rdx
	je	.L150
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
	movb	$1, %al
	jmp	.L148
.L150:
	xorl	%eax, %eax
.L148:
	ret
	.seh_endproc
	.globl	qSchedulerAdd_StateMachineTask
	.def	qSchedulerAdd_StateMachineTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAdd_StateMachineTask
qSchedulerAdd_StateMachineTask:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	128(%rsp), %rdi
	movl	168(%rsp), %eax
	testq	%r9, %r9
	movq	%rcx, %rsi
	movq	%r9, %rbx
	je	.L155
	testq	%rdi, %rdi
	jne	.L152
.L155:
	xorl	%eax, %eax
	jmp	.L151
.L152:
	movq	176(%rsp), %rcx
	movzbl	%al, %eax
	movzbl	%dl, %r8d
	movaps	%xmm2, %xmm3
	movl	%eax, 40(%rsp)
	movl	$-32768, 32(%rsp)
	movl	$1, %edx
	movq	%rcx, 48(%rsp)
	movq	%rsi, %rcx
	call	qSchedulerAdd_Task
	testb	%al, %al
	je	.L155
	movq	136(%rsp), %rax
	movq	152(%rsp), %r9
	movq	%rdi, %rdx
	movq	144(%rsp), %r8
	movq	%rbx, %rcx
	movq	%rax, 40(%rsp)
	movq	160(%rsp), %rax
	movq	%rax, 32(%rsp)
	call	qStateMachine_Init
	movq	%rbx, 32(%rsi)
	movb	$1, %al
.L151:
	addq	$64, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
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
	je	.L159
	movq	%rdx, 32(%rcx)
	movq	64(%rcx), %rcx
	movq	%rbx, %rdx
	call	qStatemachine_ExecSubStateIfAvailable
	movq	(%rbx), %rsi
	testq	%rsi, %rsi
	je	.L161
	movq	16(%rbx), %rax
	cmpq	%rax, %rsi
	setne	28(%rbx)
	je	.L162
	movq	%rax, 8(%rbx)
.L162:
	movq	%rbx, %rcx
	call	*%rsi
	movq	%rsi, 16(%rbx)
	movl	%eax, 24(%rbx)
	jmp	.L163
.L161:
	movl	$-32767, 24(%rbx)
.L163:
	movl	24(%rbx), %eax
	cmpl	$-32768, %eax
	je	.L165
	cmpl	$-32767, %eax
	jne	.L167
	movq	40(%rbx), %rcx
	jmp	.L168
.L165:
	movq	48(%rbx), %rcx
	jmp	.L168
.L167:
	movq	56(%rbx), %rcx
.L168:
	movq	%rbx, %rdx
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	jmp	qStatemachine_ExecSubStateIfAvailable
.L159:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	qStateMachine_Attribute
	.def	qStateMachine_Attribute;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Attribute
qStateMachine_Attribute:
	.seh_endprologue
	cmpl	$5, %edx
	ja	.L169
	leaq	.L172(%rip), %r10
	movl	%edx, %edx
	movslq	(%r10,%rdx,4), %rax
	addq	%r10, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L172:
	.long	.L171-.L172
	.long	.L173-.L172
	.long	.L174-.L172
	.long	.L175-.L172
	.long	.L176-.L172
	.long	.L177-.L172
	.text
.L171:
	movq	%r8, (%rcx)
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	movb	$0, 28(%rcx)
	movl	$-32768, 24(%rcx)
	jmp	.L169
.L173:
	movq	$0, 8(%rcx)
	movq	$0, 16(%rcx)
	jmp	.L169
.L174:
	movq	%r9, 40(%rcx)
	jmp	.L169
.L175:
	movq	%r9, 48(%rcx)
	jmp	.L169
.L176:
	movq	%r9, 56(%rcx)
	jmp	.L169
.L177:
	movq	%r9, 64(%rcx)
.L169:
	ret
	.seh_endproc
	.globl	qSTimerSet
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerSet
qSTimerSet:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L178
	movss	40+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 4(%rcx)
	call	qSchedulerGetTick
	movb	$1, 8(%rbx)
	movl	%eax, (%rbx)
	movb	$1, %al
.L178:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L182
	cmpb	$0, 8(%rcx)
	je	.L182
	call	qSchedulerGetTick
	subl	(%rbx), %eax
.L182:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qSTimerExpired
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerExpired
qSTimerExpired:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L186
	cmpb	$0, 8(%rcx)
	je	.L186
	call	qSTimerElapsed
	cmpl	4(%rbx), %eax
	setnb	%al
.L186:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qSTimerRemaining
	.def	qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerRemaining
qSTimerRemaining:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	jne	.L191
.L193:
	xorl	%edx, %edx
	jmp	.L190
.L191:
	call	qSTimerElapsed
	movl	4(%rbx), %edx
	testl	%edx, %edx
	je	.L193
	cmpl	%eax, %edx
	jb	.L190
	subl	%eax, %edx
.L190:
	movl	%edx, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L197
	movb	$0, 8(%rcx)
	movl	$0, (%rcx)
.L197:
	ret
	.seh_endproc
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
	movq	%rcx, %rbx
	je	.L210
	cmpb	$0, 8(%rcx)
	je	.L205
	call	qSTimerExpired
	testb	%al, %al
	je	.L210
	movq	%rbx, %rcx
	call	qSTimerDisarm
	movb	$1, %al
	jmp	.L202
.L205:
	call	qSTimerSet
.L210:
	xorl	%eax, %eax
.L202:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qSTimerStatus
	.def	qSTimerStatus;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerStatus
qSTimerStatus:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L211
	movb	8(%rcx), %al
.L211:
	ret
	.seh_endproc
	.globl	qSTimerChangeTime
	.def	qSTimerChangeTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerChangeTime
qSTimerChangeTime:
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L214
	movss	40+QUARKTS(%rip), %xmm0
	divss	%xmm0, %xmm1
	cvttss2siq	%xmm1, %rax
	movl	%eax, 4(%rcx)
.L214:
	ret
	.seh_endproc
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
	movq	8(%rcx), %rbx
	movq	%rcx, %rsi
	movl	%edx, %edi
	call	qEnterCritical
	movb	18(%rsi), %cl
	xorl	%r9d, %r9d
	movb	$1, %r10b
.L220:
	cmpb	%r9b, %cl
	jbe	.L230
	movq	(%rsi), %r12
.L222:
	movzbl	%r9b, %eax
	leaq	(%r12,%rax), %r13
	movb	0(%r13), %dl
	testb	%dl, %dl
	je	.L232
	movzwl	16(%rsi), %eax
	movzbl	%dl, %r8d
	addl	%edx, %r9d
	imull	%r8d, %eax
	cltq
	addq	%rax, %rbx
	cmpb	%r9b, %cl
	ja	.L222
	movb	%r9b, %r11b
	jmp	.L223
.L232:
	movb	%r10b, %r15b
	xorl	%ebp, %ebp
	subl	%r9d, %r15d
.L221:
	cmpb	%al, %cl
	movb	%al, %r11b
	leal	(%r15,%rax), %r14d
	jbe	.L223
	movb	(%r12,%rax), %r8b
	movzwl	16(%rsi), %edx
	testb	%r8b, %r8b
	je	.L224
	leal	(%r8,%r11), %r9d
	movzbl	%r9b, %ebx
	imull	%edx, %ebx
	movslq	%ebx, %rbx
	addq	8(%rsi), %rbx
	jmp	.L220
.L224:
	addl	%edx, %ebp
	leaq	1(%rax), %rdx
	cmpw	%di, %bp
	jb	.L233
	movb	%r14b, 0(%r13)
.L226:
	movzbl	%r8b, %edx
	cmpw	%di, %dx
	jnb	.L235
	movb	$0, (%rbx,%rax)
	incl	%r8d
	jmp	.L226
.L235:
	call	qExitCritical
	jmp	.L219
.L233:
	movq	%rdx, %rax
	jmp	.L221
.L223:
	cmpb	%r11b, %cl
	jne	.L220
.L230:
	xorl	%ebx, %ebx
	call	qExitCritical
.L219:
	movq	%rbx, %rax
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
	.seh_endproc
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
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	je	.L236
	testq	%rdx, %rdx
	je	.L236
	call	qEnterCritical
	movq	8(%rbx), %rcx
	movb	18(%rbx), %dl
	xorl	%eax, %eax
.L238:
	cmpb	%al, %dl
	je	.L240
	cmpq	%rsi, %rcx
	jne	.L239
	movq	(%rbx), %rdx
	movzbl	%al, %eax
	movb	$0, (%rdx,%rax)
	jmp	.L240
.L239:
	movzwl	16(%rbx), %r8d
	incl	%eax
	addq	%r8, %rcx
	jmp	.L238
.L240:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	jmp	qExitCritical
.L236:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %r10
	je	.L242
	testq	%rdx, %rdx
	je	.L242
	movw	$0, 12(%rcx)
	movq	%rdx, (%rcx)
	movw	$0, 14(%rcx)
	movw	%r8w, 8(%rcx)
	movzwl	%r9w, %ecx
	call	_qRBufferValidPowerOfTwo
	movw	%ax, 10(%r10)
.L242:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
	.seh_endprologue
	movb	$1, %al
	testq	%rcx, %rcx
	je	.L244
	movw	12(%rcx), %dx
	movw	14(%rcx), %ax
	cmpw	%ax, %dx
	sete	%al
.L244:
	ret
	.seh_endproc
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %r8
	jne	.L249
.L251:
	xorl	%eax, %eax
	jmp	.L248
.L249:
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L251
	movw	14(%rcx), %ax
	movw	10(%rcx), %r9w
	xorl	%edx, %edx
	movw	8(%rcx), %cx
	divw	%r9w
	movzwl	%dx, %eax
	movzwl	%cx, %edx
	imull	%edx, %eax
	cltq
	addq	(%r8), %rax
.L248:
	addq	$40, %rsp
	ret
	.seh_endproc
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
	leal	-1(%rdx), %eax
	movq	%rcx, %rbx
	movl	%edx, %esi
	cmpl	$8, %eax
	ja	.L253
	leaq	.L255(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L255:
	.long	.L254-.L255
	.long	.L256-.L255
	.long	.L257-.L255
	.long	.L258-.L255
	.long	.L259-.L255
	.long	.L259-.L255
	.long	.L259-.L255
	.long	.L253-.L255
	.long	.L260-.L255
	.text
.L254:
	movw	64(%rcx), %ax
	cmpw	$-32768, %ax
	je	.L261
	movw	64(%rcx), %ax
	testw	%ax, %ax
	jns	.L261
	movb	$1, 117+QUARKTS(%rip)
	movw	64(%rcx), %ax
	negl	%eax
	jmp	.L262
.L261:
	movb	$0, 117+QUARKTS(%rip)
	movw	64(%rbx), %ax
.L262:
	movw	%ax, 64(%rbx)
	movw	64(%rbx), %ax
	cmpw	$-32768, %ax
	je	.L263
	movw	64(%rbx), %ax
	decl	%eax
	movw	%ax, 64(%rbx)
.L263:
	movw	64(%rbx), %ax
	testw	%ax, %ax
	sete	%dl
	movb	%dl, 118+QUARKTS(%rip)
	jne	.L253
	movb	$0, 70(%rbx)
	jmp	.L253
.L257:
	movq	16(%rcx), %rax
	movq	%rax, 104+QUARKTS(%rip)
	movb	$0, 69(%rcx)
	jmp	.L253
.L258:
	movq	40(%rcx), %rcx
	call	qRBufferGetFront
	jmp	.L280
.L259:
	movq	40(%rcx), %rax
.L280:
	movq	%rax, 104+QUARKTS(%rip)
	jmp	.L253
.L256:
	movq	16+QUARKTS(%rip), %rax
	movq	%rax, 104+QUARKTS(%rip)
	movq	$0, 16+QUARKTS(%rip)
	jmp	.L253
.L260:
	movb	77+QUARKTS(%rip), %al
	leaq	96+QUARKTS(%rip), %rcx
	testb	%al, %al
	sete	%al
	movb	%al, 116+QUARKTS(%rip)
	movl	$9, 112+QUARKTS(%rip)
	movq	$0, 96+QUARKTS(%rip)
	movq	24+QUARKTS(%rip), %rax
	call	*%rax
	movb	$1, 77+QUARKTS(%rip)
	jmp	.L264
.L253:
	movb	$2, 67(%rbx)
	movl	%esi, 112+QUARKTS(%rip)
	movb	68(%rbx), %al
	testb	%al, %al
	sete	%al
	movb	%al, 116+QUARKTS(%rip)
	movq	8(%rbx), %rax
	movq	%rax, 96+QUARKTS(%rip)
	movq	%rbx, 80+QUARKTS(%rip)
	movq	32(%rbx), %rax
	testq	%rax, %rax
	je	.L265
	movq	24(%rbx), %rax
	decq	%rax
	jne	.L265
	movq	32(%rbx), %rcx
	leaq	96+QUARKTS(%rip), %rdx
	call	qStateMachine_Run
	jmp	.L266
.L265:
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L266
	movq	24(%rbx), %rax
	leaq	96+QUARKTS(%rip), %rcx
	call	*%rax
.L266:
	cmpl	$4, %esi
	movq	$0, 80+QUARKTS(%rip)
	jne	.L267
	movq	40(%rbx), %rdx
	movw	14(%rdx), %ax
	incl	%eax
	movw	%ax, 14(%rdx)
.L267:
	movb	$1, 68(%rbx)
	movb	$0, 117+QUARKTS(%rip)
	movb	$0, 118+QUARKTS(%rip)
	movq	$0, 104+QUARKTS(%rip)
	movl	56(%rbx), %eax
	incl	%eax
	movl	%eax, 56(%rbx)
.L264:
	movb	$3, %al
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	qSchedulerRun
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRun
qSchedulerRun:
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
	leaq	_qSysTick_Epochs_(%rip), %rsi
	movb	$1, 76+QUARKTS(%rip)
.L325:
	movb	76+QUARKTS(%rip), %al
	leaq	QUARKTS(%rip), %rbp
	testb	%al, %al
	jne	.L282
	xorl	%edi, %edi
	movq	48+QUARKTS(%rip), %rbx
	call	qEnterCritical
.L283:
	testq	%rbx, %rbx
	je	.L366
	testq	%rdi, %rdi
	movq	(%rbx), %r9
	je	.L284
	movb	66(%rbx), %dl
	movb	66(%rdi), %al
	cmpb	%al, %dl
	jbe	.L285
.L284:
	movq	%rdi, (%rbx)
	movq	%rbx, %rdi
	jmp	.L286
.L285:
	movq	%rbx, %rdx
	movq	%rdi, %rcx
	call	_qScheduler_FindPlace
.L286:
	movq	%r9, %rbx
	jmp	.L283
.L366:
	movb	$1, 76+QUARKTS(%rip)
	call	qExitCritical
	movq	%rdi, 48+QUARKTS(%rip)
.L282:
	movw	QUARKTS(%rip), %ax
	xorl	%edi, %edi
	testw	%ax, %ax
	js	.L288
	call	qEnterCritical
	movq	8+QUARKTS(%rip), %rax
	movb	$1, %dl
	movq	(%rax), %rax
	movb	66(%rax), %r8b
	xorl	%eax, %eax
.L289:
	movb	2+QUARKTS(%rip), %cl
	cmpb	%cl, %dl
	jnb	.L290
	movq	8+QUARKTS(%rip), %r9
	movzbl	%dl, %ecx
	salq	$4, %rcx
	cmpq	$0, (%r9,%rcx)
	je	.L290
	movq	8+QUARKTS(%rip), %r9
	movq	(%r9,%rcx), %r9
	movb	66(%r9), %r9b
	cmpb	%r8b, %r9b
	jbe	.L291
	movq	8+QUARKTS(%rip), %rax
	movq	(%rax,%rcx), %rax
	movb	66(%rax), %r8b
	movb	%dl, %al
.L291:
	incl	%edx
	jmp	.L289
.L290:
	movq	8+QUARKTS(%rip), %rcx
	movzbl	%al, %edx
	salq	$4, %rdx
	movq	8(%rcx,%rdx), %rcx
	movq	%rcx, 16+QUARKTS(%rip)
	movq	8+QUARKTS(%rip), %rcx
	movq	(%rcx,%rdx), %rdi
	movb	$1, 67(%rdi)
	movq	8+QUARKTS(%rip), %rcx
	movq	$0, (%rcx,%rdx)
.L293:
	movswl	0(%rbp), %edx
	movzbl	%al, %ecx
	cmpl	%edx, %ecx
	jge	.L367
	movq	8+QUARKTS(%rip), %r8
	movzbl	%al, %edx
	movq	8+QUARKTS(%rip), %rcx
	incq	%rdx
	incl	%eax
	salq	$4, %rdx
	movups	(%r8,%rdx), %xmm2
	movups	%xmm2, -16(%rcx,%rdx)
	jmp	.L293
.L367:
	movw	QUARKTS(%rip), %ax
	decl	%eax
	movw	%ax, QUARKTS(%rip)
	call	qExitCritical
	movl	$2, %edx
	movq	%rdi, %rcx
	call	_qScheduler_Dispatch
	movb	%al, 67(%rdi)
.L288:
	movq	48+QUARKTS(%rip), %rbx
	xorl	%ebp, %ebp
.L295:
	testq	%rbx, %rbx
	je	.L368
	movb	70(%rbx), %al
	testb	%al, %al
	je	.L296
	movw	64(%rbx), %ax
	testw	%ax, %ax
	jns	.L297
	movw	64(%rbx), %ax
	cmpw	$-32768, %ax
	je	.L297
	movw	64(%rbx), %ax
	testw	%ax, %ax
	jns	.L299
	jmp	.L298
.L297:
	movw	64(%rbx), %ax
	testw	%ax, %ax
	jg	.L298
.L299:
	movw	64(%rbx), %ax
	cmpw	$-32768, %ax
	jne	.L296
.L298:
	movl	48(%rbx), %eax
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm0
	ucomiss	%xmm1, %xmm0
	jp	.L300
	jne	.L300
.L305:
	call	qSchedulerGetTick
	movl	%eax, 52(%rbx)
	movb	$1, 67(%rbx)
	movl	$1, 60(%rbx)
	jmp	.L365
.L300:
	movl	48(%rbx), %r12d
	movl	52(%rbx), %r13d
	call	qSchedulerGetTick
	subl	%r13d, %eax
	cmpl	%eax, %r12d
	jbe	.L305
.L296:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L306
	movb	72(%rbx), %al
	testb	%al, %al
	je	.L307
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.L329
	movw	12(%rax), %dx
	movw	14(%rax), %r8w
	movw	10(%rax), %cx
	movl	%edx, %eax
	subl	%r8d, %eax
	cmpw	%ax, %cx
	je	.L329
.L307:
	movb	73(%rbx), %al
	testb	%al, %al
	je	.L309
	movq	40(%rbx), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L310
	movw	12(%rdx), %ax
	movw	14(%rdx), %dx
	subl	%edx, %eax
.L310:
	movzbl	73(%rbx), %edx
	cmpw	%ax, %dx
	jbe	.L331
.L309:
	movb	71(%rbx), %al
	testb	%al, %al
	jne	.L311
.L313:
	movb	74(%rbx), %al
	testb	%al, %al
	je	.L306
	jmp	.L369
.L311:
	movq	40(%rbx), %rcx
	call	qRBufferGetFront
	testq	%rax, %rax
	movl	$4, %edx
	jne	.L308
	jmp	.L313
.L369:
	movq	40(%rbx), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	movl	$7, %edx
	je	.L306
	jmp	.L308
.L329:
	movl	$5, %edx
	jmp	.L308
.L331:
	movl	$6, %edx
.L308:
	movb	$1, 67(%rbx)
	movl	%edx, 60(%rbx)
.L365:
	movb	$1, %bpl
	jmp	.L304
.L306:
	movb	69(%rbx), %al
	testb	%al, %al
	je	.L314
	movb	$1, 67(%rbx)
	movl	$3, 60(%rbx)
	jmp	.L365
.L314:
	movb	$3, 67(%rbx)
.L304:
	movq	(%rbx), %rbx
	jmp	.L295
.L368:
	testb	%bpl, %bpl
	je	.L364
.L316:
	cmpq	%rsi, ChainIterator.3545(%rip)
	jne	.L319
	movq	48+QUARKTS(%rip), %rax
	movq	%rax, ChainIterator.3545(%rip)
.L319:
	movq	ChainIterator.3545(%rip), %rbx
	testq	%rbx, %rbx
	je	.L320
	movq	(%rbx), %rax
	jmp	.L321
.L320:
	movq	48+QUARKTS(%rip), %rax
.L321:
	testq	%rbx, %rbx
	movq	%rax, ChainIterator.3545(%rip)
	je	.L323
	movb	67(%rbx), %dl
	xorl	%eax, %eax
	decb	%dl
	jne	.L318
	movl	60(%rbx), %edx
	movq	%rbx, %rcx
	call	_qScheduler_Dispatch
.L318:
	movb	%al, 67(%rbx)
	jmp	.L316
.L364:
	testq	%rdi, %rdi
	jne	.L323
	movq	24+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L323
	movl	$9, %edx
	xorl	%ecx, %ecx
	call	_qScheduler_Dispatch
.L323:
	movb	78+QUARKTS(%rip), %al
	testb	%al, %al
	je	.L325
	movb	$0, 76+QUARKTS(%rip)
	movb	$0, 78+QUARKTS(%rip)
	movb	79+QUARKTS(%rip), %al
	testb	%al, %al
	sete	%al
	movb	%al, 116+QUARKTS(%rip)
	movl	$8, 112+QUARKTS(%rip)
	movq	$0, 96+QUARKTS(%rip)
	movq	32+QUARKTS(%rip), %rax
	testq	%rax, %rax
	je	.L326
	movq	32+QUARKTS(%rip), %rax
	leaq	96+QUARKTS(%rip), %rcx
	call	*%rax
.L326:
	movb	$1, 77+QUARKTS(%rip)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.seh_endproc
	.globl	qRBufferRemoveFront
	.def	qRBufferRemoveFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferRemoveFront
qRBufferRemoveFront:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	jne	.L371
.L373:
	xorl	%eax, %eax
	jmp	.L370
.L371:
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L373
	movw	14(%rcx), %ax
	incl	%eax
	movw	%ax, 14(%rcx)
	movb	$1, %al
.L370:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qRBufferPopFront
	.def	qRBufferPopFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPopFront
qRBufferPopFront:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %r8
	movq	%rdx, %r9
	jne	.L375
.L377:
	xorl	%eax, %eax
	jmp	.L374
.L375:
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L377
	movw	14(%rcx), %ax
	movw	10(%rcx), %r11w
	xorl	%edx, %edx
	movw	8(%rcx), %r10w
	movzwl	8(%rcx), %ecx
	movq	%r9, %rdi
	divw	%r11w
	movzwl	%dx, %esi
	movzwl	%r10w, %edx
	imull	%edx, %esi
	movslq	%esi, %rsi
	addq	(%r8), %rsi
	rep movsb
	movw	14(%r8), %ax
	incl	%eax
	movw	%ax, 14(%r8)
	movb	$1, %al
.L374:
	addq	$40, %rsp
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	qRBufferPush
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPush
qRBufferPush:
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %r9
	je	.L382
	testq	%rcx, %rcx
	je	.L382
	movw	12(%rcx), %dx
	movw	14(%rcx), %ax
	movw	10(%rcx), %r8w
	subl	%eax, %edx
	xorl	%eax, %eax
	cmpw	%dx, %r8w
	je	.L378
	movw	12(%rcx), %ax
	movw	10(%rcx), %r11w
	xorl	%edx, %edx
	movzwl	8(%rcx), %r8d
	movq	(%rcx), %r10
	divw	%r11w
	xorl	%eax, %eax
	movzwl	%dx, %edx
	imull	%r8d, %edx
	movslq	%edx, %rdx
.L380:
	movw	8(%rcx), %r8w
	cmpw	%ax, %r8w
	jbe	.L390
	movzwl	%ax, %r11d
	incl	%eax
	leaq	(%rdx,%r11), %r8
	movb	(%r9,%r11), %r11b
	addq	%r10, %r8
	movb	%r11b, (%r8)
	jmp	.L380
.L390:
	movw	12(%rcx), %ax
	incl	%eax
	movw	%ax, 12(%rcx)
	movb	$1, %al
	jmp	.L378
.L382:
	xorl	%eax, %eax
.L378:
	ret
	.seh_endproc
	.globl	qSwapBytes
	.def	qSwapBytes;	.scl	2;	.type	32;	.endef
	.seh_proc	qSwapBytes
qSwapBytes:
	.seh_endprologue
	decl	%edx
	movl	%edx, %r8d
.L392:
	movl	%edx, %eax
	subl	%r8d, %eax
	cmpw	%ax, %r8w
	jbe	.L394
	movzwl	%r8w, %r9d
	movzwl	%ax, %eax
	decl	%r8d
	addq	%rcx, %rax
	addq	%rcx, %r9
	movb	(%rax), %r10b
	movb	(%r9), %r11b
	movb	%r11b, (%rax)
	movb	%r10b, (%r9)
	jmp	.L392
.L394:
	ret
	.seh_endproc
	.def	__q_revuta.part.9;	.scl	3;	.type	32;	.endef
	.seh_proc	__q_revuta.part.9
__q_revuta.part.9:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	xorl	%ebx, %ebx
	movl	%ecx, %eax
	movzbl	%r8b, %r8d
	movq	%rdx, %rcx
.L396:
	testl	%eax, %eax
	je	.L400
	xorl	%edx, %edx
	divl	%r8d
	cmpl	$9, %edx
	leal	48(%rdx), %r9d
	jbe	.L398
	leal	55(%rdx), %r9d
.L398:
	movzbl	%bl, %edx
	incl	%ebx
	movb	%r9b, (%rcx,%rdx)
	jmp	.L396
.L400:
	movzbl	%bl, %edx
	call	qSwapBytes
	movb	%bl, %al
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	qCheckEndianness
	.def	qCheckEndianness;	.scl	2;	.type	32;	.endef
	.seh_proc	qCheckEndianness
qCheckEndianness:
	.seh_endprologue
	movb	$1, %al
	ret
	.seh_endproc
	.globl	qOutputRaw
	.def	qOutputRaw;	.scl	2;	.type	32;	.endef
	.seh_proc	qOutputRaw
qOutputRaw:
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
	.seh_endprologue
	movb	128(%rsp), %r12b
	xorl	%ebx, %ebx
	movq	%rcx, %rbp
	movq	%rdx, %rsi
	movzwl	%r9w, %edi
.L403:
	cmpq	%rbx, %rdi
	jbe	.L408
	testb	%r12b, %r12b
	movsbl	(%r8,%rbx), %edx
	movq	%rsi, %rcx
	je	.L404
	leaq	(%rsi,%rbx), %rcx
.L404:
	movq	%r8, 40(%rsp)
	incq	%rbx
	call	*%rbp
	movq	40(%rsp), %r8
	jmp	.L403
.L408:
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.globl	qInputRaw
	.def	qInputRaw;	.scl	2;	.type	32;	.endef
	.seh_proc	qInputRaw
qInputRaw:
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
	.seh_endprologue
	movb	128(%rsp), %r12b
	xorl	%ebx, %ebx
	movq	%rcx, %rbp
	movq	%rdx, %rsi
	movzwl	%r9w, %edi
.L410:
	cmpq	%rbx, %rdi
	jbe	.L415
	testb	%r12b, %r12b
	movq	%rsi, %rcx
	je	.L411
	leaq	(%rsi,%rbx), %rcx
.L411:
	movq	%r8, 40(%rsp)
	call	*%rbp
	movq	40(%rsp), %r8
	movb	%al, (%r8,%rbx)
	incq	%rbx
	jmp	.L410
.L415:
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.globl	qOutputString
	.def	qOutputString;	.scl	2;	.type	32;	.endef
	.seh_proc	qOutputString
qOutputString:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	xorl	%ebx, %ebx
	movq	%rcx, %rdi
	movq	%rdx, %rsi
.L417:
	movsbl	(%r8), %edx
	testb	%dl, %dl
	je	.L422
	incq	%r8
	testb	%r9b, %r9b
	movq	%rsi, %rcx
	je	.L418
	leaq	(%rsi,%rbx), %rcx
	incq	%rbx
.L418:
	movb	%r9b, 47(%rsp)
	movq	%r8, 32(%rsp)
	call	*%rdi
	movb	47(%rsp), %r9b
	movq	32(%rsp), %r8
	jmp	.L417
.L422:
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	qPrintXData
	.def	qPrintXData;	.scl	2;	.type	32;	.endef
	.seh_proc	qPrintXData
qPrintXData:
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
	xorl	%edi, %edi
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	movq	%r8, %r12
	movzwl	%r9w, %ebp
.L424:
	cmpl	%edi, %ebp
	jle	.L428
	movb	(%r12,%rdi), %al
	shrb	$4, %al
	leal	48(%rax), %edx
	cmpb	$57, %dl
	jbe	.L425
	leal	55(%rax), %edx
.L425:
	movzbl	%dl, %edx
	movq	%rsi, %rcx
	call	*%rbx
	movb	(%r12,%rdi), %al
	andl	$15, %eax
	leal	48(%rax), %edx
	cmpb	$57, %dl
	jbe	.L426
	leal	55(%rax), %edx
.L426:
	movzbl	%dl, %edx
	movq	%rsi, %rcx
	incq	%rdi
	call	*%rbx
	movl	$32, %edx
	movq	%rsi, %rcx
	call	*%rbx
	jmp	.L424
.L428:
	movq	%rsi, %rcx
	movl	$13, %edx
	call	*%rbx
	movl	$10, %edx
	movq	%rsi, %rcx
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	rex.W jmp	*%rax
	.seh_endproc
	.globl	qU32toX
	.def	qU32toX;	.scl	2;	.type	32;	.endef
	.seh_proc	qU32toX
qU32toX:
	.seh_endprologue
	movq	%rdx, %rax
	movsbq	%r8b, %rdx
	movsbl	%r8b, %r8d
	decl	%r8d
	movb	$0, (%rax,%rdx)
	movslq	%r8d, %r8
.L430:
	testl	%r8d, %r8d
	js	.L433
	movb	%cl, %r9b
	andl	$15, %r9d
	leal	48(%r9), %edx
	cmpb	$57, %dl
	jbe	.L431
	leal	55(%r9), %edx
.L431:
	movb	%dl, (%rax,%r8)
	shrl	$4, %ecx
	decq	%r8
	jmp	.L430
.L433:
	ret
	.seh_endproc
	.globl	qXtoU32
	.def	qXtoU32;	.scl	2;	.type	32;	.endef
	.seh_proc	qXtoU32
qXtoU32:
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
	xorl	%ebp, %ebp
	testq	%rcx, %rcx
	movq	%rcx, %rdi
	je	.L434
.L436:
	cmpb	$7, %bpl
	movb	(%rdi), %sil
	ja	.L434
	testb	%sil, %sil
	je	.L434
	call	__locale_ctype_ptr
	movsbl	%sil, %ecx
	incq	%rdi
	call	toupper
	movzbl	%al, %r12d
	movl	%eax, %esi
	call	__locale_ctype_ptr
	testb	$68, 1(%rax,%r12)
	je	.L437
	leal	-48(%rsi), %eax
	incl	%ebp
	cmpb	$9, %al
	jbe	.L438
	leal	-65(%rsi), %edx
	movb	%sil, %al
	cmpb	$5, %dl
	ja	.L438
	leal	-55(%rsi), %eax
.L438:
	sall	$4, %ebx
	andl	$15, %eax
	orl	%eax, %ebx
	jmp	.L436
.L437:
	call	__locale_ctype_ptr
	testb	$8, 1(%rax,%r12)
	jne	.L436
.L434:
	movl	%ebx, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.globl	qAtoF
	.def	qAtoF;	.scl	2;	.type	32;	.endef
	.seh_proc	qAtoF
qAtoF:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$64, %rsp
	.seh_stackalloc	64
	movaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	movaps	%xmm7, 48(%rsp)
	.seh_savexmm	%xmm7, 48
	.seh_endprologue
	movq	%rcx, %rsi
.L451:
	call	__locale_ctype_ptr
	movsbq	(%rsi), %rcx
	testb	$8, 1(%rax,%rcx)
	movq	%rcx, %rdx
	je	.L467
	incq	%rsi
	jmp	.L451
.L467:
	cmpb	$45, %cl
	movsd	.LC1(%rip), %xmm7
	je	.L453
	movsd	.LC2(%rip), %xmm7
.L453:
	subl	$43, %edx
	xorl	%eax, %eax
	xorps	%xmm6, %xmm6
	andb	$-3, %dl
	sete	%al
	xorl	%edi, %edi
	addq	%rax, %rsi
.L455:
	movsbl	(%rsi), %ebx
	testb	%bl, %bl
	je	.L460
	cmpb	$46, %bl
	je	.L462
	call	__locale_ctype_ptr
	movsbq	%bl, %rdx
	testb	$4, 1(%rax,%rdx)
	je	.L460
	testl	%edi, %edi
	je	.L458
	mulsd	.LC4(%rip), %xmm7
.L458:
	subl	$48, %ebx
	mulsd	.LC5(%rip), %xmm6
	cvtsi2sd	%ebx, %xmm1
	addsd	%xmm1, %xmm6
	jmp	.L456
.L462:
	movl	$1, %edi
.L456:
	incq	%rsi
	jmp	.L455
.L460:
	movapd	%xmm6, %xmm0
	movaps	32(%rsp), %xmm6
	mulsd	%xmm7, %xmm0
	movaps	48(%rsp), %xmm7
	addq	$64, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	qAtoI
	.def	qAtoI;	.scl	2;	.type	32;	.endef
	.seh_proc	qAtoI
qAtoI:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L468
.L470:
	call	__locale_ctype_ptr
	movsbq	(%rbx), %rcx
	testb	$8, 1(%rax,%rcx)
	je	.L480
	incq	%rbx
	jmp	.L470
.L480:
	cmpb	$45, %cl
	jne	.L472
	incq	%rbx
	orl	$-1, %eax
	jmp	.L473
.L472:
	cmpb	$43, %cl
	movl	$1, %eax
	jne	.L473
	incq	%rbx
.L473:
	xorl	%edx, %edx
.L475:
	movsbl	(%rbx), %ecx
	testb	%cl, %cl
	je	.L479
	leal	-48(%rcx), %r8d
	cmpb	$9, %r8b
	ja	.L479
	imull	$10, %edx, %edx
	incq	%rbx
	leal	-48(%rdx,%rcx), %edx
	jmp	.L475
.L479:
	imull	%edx, %eax
.L468:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
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
	je	.L482
	testl	%ecx, %ecx
	je	.L483
	movzbl	%r8b, %r8d
	call	__q_revuta.part.9
	jmp	.L484
.L483:
	movb	$48, (%rdx)
	movb	$1, %al
.L484:
	movzbl	%al, %eax
	movb	$0, (%rbx,%rax)
.L482:
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
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
	movq	%rdx, %rsi
	je	.L489
	xorl	%ebx, %ebx
	testl	%ecx, %ecx
	jns	.L490
	cmpb	$10, %r8b
	jne	.L491
	movb	$45, (%rdx)
	movb	$1, %bl
.L491:
	negl	%ecx
.L490:
	movzbl	%bl, %edx
	addq	%rsi, %rdx
	testl	%ecx, %ecx
	je	.L492
	movzbl	%r8b, %r8d
	call	__q_revuta.part.9
	jmp	.L493
.L492:
	movb	$48, (%rdx)
	movb	$1, %al
.L493:
	addl	%eax, %ebx
	movzbl	%bl, %ebx
	movb	$0, (%rsi,%rbx)
.L489:
	movq	%rsi, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC6:
	.ascii "ERROR\0"
.LC7:
	.ascii "OK\0"
.LC8:
	.ascii "QuarkTS 4.8.0\0"
.LC9:
	.ascii "UNKNOWN\0"
.LC10:
	.ascii "\15\12\0"
.LC11:
	.ascii ":NOT ALLOWED\0"
	.text
	.def	_qATParser_HandleCommandResponse.part.12;	.scl	3;	.type	32;	.endef
	.seh_proc	_qATParser_HandleCommandResponse.part.12
_qATParser_HandleCommandResponse.part.12:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	cmpl	$1, %edx
	movq	%rcx, %rbx
	je	.L501
	jg	.L502
	cmpl	$-32768, %edx
	je	.L503
	cmpl	$-32767, %edx
	je	.L504
	jmp	.L500
.L502:
	cmpl	$32766, %edx
	je	.L505
	cmpl	$32767, %edx
	je	.L506
	cmpl	$32765, %edx
	jne	.L500
	jmp	.L524
.L503:
	movq	64(%rcx), %rax
	movq	16(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L513
	leaq	.LC6(%rip), %rcx
	jmp	.L513
.L501:
	movq	64(%rcx), %rax
	movq	8(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L513
	leaq	.LC7(%rip), %rcx
	jmp	.L513
.L504:
	movq	64(%rcx), %rax
	movq	16(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L511
	leaq	.LC6(%rip), %rcx
.L511:
	call	*%rax
	leaq	.LC11(%rip), %rcx
	jmp	.L523
.L524:
	movq	64(%rcx), %rax
	movq	32(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L513
	leaq	.LC8(%rip), %rcx
	jmp	.L513
.L505:
	movq	64(%rcx), %rax
	movq	24(%rcx), %rcx
	testq	%rcx, %rcx
	jne	.L513
	leaq	.LC9(%rip), %rcx
.L513:
	call	*%rax
	jmp	.L509
.L506:
	movq	80(%rcx), %rcx
.L523:
	call	*64(%rbx)
	jmp	.L509
.L500:
	testl	%edx, %edx
	jns	.L509
	negl	%edx
	movl	$10, %r8d
	movl	%edx, %ecx
	movq	80(%rbx), %rdx
	call	qItoA
	movq	16(%rbx), %rcx
	movq	64(%rbx), %rax
	testq	%rcx, %rcx
	jne	.L514
	leaq	.LC6(%rip), %rcx
.L514:
	call	*%rax
	movl	$58, %ecx
	call	*56(%rbx)
	movq	80(%rbx), %rcx
	call	*64(%rbx)
	movq	80(%rbx), %rax
	movb	$0, (%rax)
.L509:
	movq	40(%rbx), %rcx
	movq	64(%rbx), %rax
	testq	%rcx, %rcx
	jne	.L515
	leaq	.LC10(%rip), %rcx
.L515:
	addq	$32, %rsp
	popq	%rbx
	rex.W jmp	*%rax
	.seh_endproc
	.globl	qBtoA
	.def	qBtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qBtoA
qBtoA:
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rdx, %rax
	je	.L526
	testb	%cl, %cl
	je	.L527
	movl	$1702195828, (%rdx)
	movb	$0, 4(%rdx)
	jmp	.L526
.L527:
	movl	$1936482662, (%rdx)
	movw	$101, 4(%rdx)
.L526:
	ret
	.seh_endproc
	.globl	qQBtoA
	.def	qQBtoA;	.scl	2;	.type	32;	.endef
	.seh_proc	qQBtoA
qQBtoA:
	.seh_endprologue
	movq	%rdx, %rax
	testq	%rax, %rax
	je	.L532
	cmpb	$4, %cl
	ja	.L533
	leaq	.L535(%rip), %r8
	movzbl	%cl, %ecx
	movslq	(%r8,%rcx,4), %rdx
	addq	%r8, %rdx
	jmp	*%rdx
	.section .rdata,"dr"
	.align 4
.L535:
	.long	.L534-.L535
	.long	.L536-.L535
	.long	.L537-.L535
	.long	.L538-.L535
	.long	.L539-.L535
	.text
.L536:
	movl	$1702195828, (%rax)
	movb	$0, 4(%rax)
	jmp	.L532
.L534:
	movl	$1936482662, (%rax)
	movw	$101, 4(%rax)
	jmp	.L532
.L537:
	movabsq	$32780218601924980, %rcx
	jmp	.L543
.L538:
	movl	$1769171314, (%rax)
	movw	$26478, 4(%rax)
	movb	$0, 6(%rax)
	jmp	.L532
.L539:
	movabsq	$29113321670861158, %rdx
	movq	%rdx, (%rax)
	jmp	.L532
.L533:
	movabsq	$31093567915781749, %rcx
.L543:
	movq	%rcx, (%rax)
.L532:
	ret
	.seh_endproc
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
	jne	.L545
	xorl	%eax, %eax
	andl	$8388607, %edx
	setne	%al
.L545:
	ret
	.seh_endproc
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
	movaps	%xmm0, %xmm1
	movq	%rdx, %rsi
	movl	%r8d, %ebp
	je	.L549
	xorps	%xmm0, %xmm0
	ucomiss	%xmm0, %xmm1
	jp	.L550
	jne	.L550
	movl	$3157552, (%rdx)
	jmp	.L549
.L550:
	movaps	%xmm1, %xmm0
	call	qIsInf
	testb	%al, %al
	je	.L552
	decb	%al
	movl	$6712937, 1(%rsi)
	setne	%al
	leal	43(%rax,%rax), %eax
	movb	%al, (%rsi)
	jmp	.L549
.L552:
	call	qIsNan
	testb	%al, %al
	je	.L554
	movl	$7233902, (%rsi)
	jmp	.L549
.L554:
	xorps	%xmm0, %xmm0
	xorl	%ebx, %ebx
	ucomiss	%xmm1, %xmm0
	jbe	.L555
	xorps	.LC12(%rip), %xmm1
	movb	$1, %bl
	movb	$45, (%rsi)
.L555:
	cvttss2siq	%xmm1, %rdi
	movzbl	%bl, %edx
	addq	%rsi, %rdx
	testl	%edi, %edi
	je	.L557
	movl	$10, %r8d
	movl	%edi, %ecx
	call	__q_revuta.part.9
	jmp	.L558
.L557:
	movb	$48, (%rdx)
	movb	$1, %al
.L558:
	addl	%ebx, %eax
	testb	%bpl, %bpl
	je	.L559
	movl	%edi, %edi
	movb	$10, %dl
	leal	1(%rax), %r9d
	cvtsi2ssq	%rdi, %xmm0
	cmpb	$10, %bpl
	cmova	%edx, %ebp
	movzbl	%al, %eax
	movb	%r9b, %r8b
	movb	$46, (%rsi,%rax)
	movb	%bpl, %dl
	movss	.LC13(%rip), %xmm2
	subss	%xmm0, %xmm1
.L562:
	decl	%edx
	movzbl	%r8b, %ecx
	addq	%rsi, %rcx
	cmpb	$-1, %dl
	je	.L572
	mulss	%xmm2, %xmm1
	incl	%r8d
	cvttss2si	%xmm1, %eax
	leal	48(%rax), %r10d
	movsbl	%al, %eax
	cvtsi2ss	%eax, %xmm0
	movb	%r10b, (%rcx)
	subss	%xmm0, %xmm1
	jmp	.L562
.L572:
	leal	(%r9,%rbp), %eax
.L559:
	movzbl	%al, %eax
	movb	$0, (%rsi,%rax)
.L549:
	movq	%rsi, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.globl	qBSBuffer_Count
	.def	qBSBuffer_Count;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Count
qBSBuffer_Count:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L573
	movw	(%rcx), %ax
	movw	2(%rcx), %dx
	subl	%edx, %eax
.L573:
	ret
	.seh_endproc
	.globl	qBSBuffer_IsFull
	.def	qBSBuffer_IsFull;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_IsFull
qBSBuffer_IsFull:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movb	$1, %al
	testq	%rcx, %rcx
	je	.L576
	call	qBSBuffer_Count
	cmpw	%ax, 4(%rcx)
	sete	%al
.L576:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qBSBuffer_Empty
	.def	qBSBuffer_Empty;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Empty
qBSBuffer_Empty:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movb	$1, %al
	testq	%rcx, %rcx
	je	.L580
	call	qBSBuffer_Count
	testw	%ax, %ax
	sete	%al
.L580:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qBSBuffer_Peek
	.def	qBSBuffer_Peek;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Peek
qBSBuffer_Peek:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L584
	movw	2(%rcx), %ax
	xorl	%edx, %edx
	divw	4(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movb	(%rdx), %al
.L584:
	ret
	.seh_endproc
	.globl	qBSBuffer_Get
	.def	qBSBuffer_Get;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Get
qBSBuffer_Get:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rdx, %r9
	call	qBSBuffer_Empty
	xorl	%edx, %edx
	testb	%al, %al
	jne	.L587
	movw	2(%rcx), %ax
	xorl	%edx, %edx
	divw	4(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movb	(%rdx), %al
	movb	$1, %dl
	movb	%al, (%r9)
	movw	2(%rcx), %ax
	incl	%eax
	movw	%ax, 2(%rcx)
.L587:
	movb	%dl, %al
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qBSBuffer_Read
	.def	qBSBuffer_Read;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Read
qBSBuffer_Read:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testw	%r8w, %r8w
	movq	%rcx, %r11
	movzwl	%r8w, %r10d
	jne	.L591
.L594:
	xorl	%eax, %eax
	jmp	.L590
.L591:
	movq	%rdx, %r8
	addq	%rdx, %r10
.L593:
	cmpq	%r10, %r8
	je	.L599
	movq	%r8, %rdx
	movq	%r11, %rcx
	call	qBSBuffer_Get
	incq	%r8
	testb	%al, %al
	jne	.L593
	jmp	.L594
.L599:
	movb	$1, %al
.L590:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qBSBuffer_Put
	.def	qBSBuffer_Put;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Put
qBSBuffer_Put:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	movl	%edx, %r9d
	jne	.L601
.L603:
	xorl	%eax, %eax
	jmp	.L600
.L601:
	call	qBSBuffer_IsFull
	testb	%al, %al
	jne	.L603
	movw	(%rcx), %ax
	xorl	%edx, %edx
	divw	4(%rcx)
	movzwl	%dx, %edx
	addq	8(%rcx), %rdx
	movb	%r9b, (%rdx)
	movw	(%rcx), %ax
	incl	%eax
	movw	%ax, (%rcx)
	movb	$1, %al
.L600:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qBSBuffer_Init
	.def	qBSBuffer_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qBSBuffer_Init
qBSBuffer_Init:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %r10
	je	.L604
	movw	$0, (%rcx)
	movq	%rdx, 8(%rcx)
	movw	$0, 2(%rcx)
	movzwl	%r8w, %ecx
	call	_qRBufferValidPowerOfTwo
	movw	%ax, 4(%r10)
.L604:
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qResponseInitialize
	.def	qResponseInitialize;	.scl	2;	.type	32;	.endef
	.seh_proc	qResponseInitialize
qResponseInitialize:
	.seh_endprologue
	movw	$0, 10(%rcx)
	movq	$0, (%rcx)
	movw	$0, 8(%rcx)
	movb	$0, 12(%rcx)
	ret
	.seh_endproc
	.globl	qResponseReceivedWithTimeout
	.def	qResponseReceivedWithTimeout;	.scl	2;	.type	32;	.endef
	.seh_proc	qResponseReceivedWithTimeout
qResponseReceivedWithTimeout:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movq	%rcx, %rbx
	movl	%r8d, %ecx
	movb	12(%rbx), %al
	testb	%al, %al
	jne	.L611
	cmpq	$0, (%rbx)
	jne	.L611
	testw	%r8w, %r8w
	jne	.L612
	orq	$-1, %rcx
	movq	%rdx, %rdi
	repnz scasb
	notq	%rcx
	decl	%ecx
.L612:
	movw	%cx, 8(%rbx)
	movw	$0, 10(%rbx)
	movq	%r9, %rcx
	movb	$0, 12(%rbx)
	movq	%rdx, (%rbx)
	movss	112(%rsp), %xmm1
	call	qSTimerSet
	xorl	%eax, %eax
	jmp	.L610
.L611:
	movq	%r9, %rcx
	movq	%r9, 40(%rsp)
	call	qSTimerExpired
	testb	%al, %al
	movq	40(%rsp), %r9
	je	.L614
	movw	$0, 10(%rbx)
	movq	$0, (%rbx)
	movq	%r9, %rcx
	movw	$0, 8(%rbx)
	movb	$0, 12(%rbx)
	call	qSTimerDisarm
	movb	$2, %al
	jmp	.L610
.L614:
	movb	12(%rbx), %dl
	testb	%dl, %dl
	je	.L610
	movw	$0, 10(%rbx)
	movq	$0, (%rbx)
	movq	%r9, %rcx
	movw	$0, 8(%rbx)
	movb	$0, 12(%rbx)
	call	qSTimerDisarm
	movb	$1, %al
.L610:
	addq	$56, %rsp
	popq	%rbx
	popq	%rdi
	ret
	.seh_endproc
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
	.globl	qResponseISRHandler
	.def	qResponseISRHandler;	.scl	2;	.type	32;	.endef
	.seh_proc	qResponseISRHandler
qResponseISRHandler:
	.seh_endprologue
	movb	12(%rcx), %r8b
	xorl	%eax, %eax
	decb	%r8b
	je	.L619
	movq	(%rcx), %r8
	testq	%r8, %r8
	je	.L619
	movzwl	10(%rcx), %eax
	cmpb	%dl, (%r8,%rax)
	jne	.L622
	movw	10(%rcx), %ax
	incl	%eax
	movw	%ax, 10(%rcx)
	movw	10(%rcx), %ax
	cmpw	8(%rcx), %ax
	jne	.L622
	movb	$1, 12(%rcx)
.L622:
	movb	12(%rcx), %al
.L619:
	ret
	.seh_endproc
	.globl	__qtrace_func
	.def	__qtrace_func;	.scl	2;	.type	32;	.endef
	.seh_proc	__qtrace_func
__qtrace_func:
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
	movq	__qDebugOutputFcn(%rip), %rax
	movq	112(%rsp), %rdi
	movq	%rdx, %rsi
	movq	%r8, %r12
	movq	%r9, %rbx
	movl	120(%rsp), %ebp
	testq	%rax, %rax
	je	.L626
	xorl	%r9d, %r9d
	movq	%rcx, %r8
	xorl	%edx, %edx
	movq	%rax, %rcx
	call	qOutputString
	testq	%rsi, %rsi
	je	.L628
	movl	$64, %edx
	xorl	%ecx, %ecx
	call	*__qDebugOutputFcn(%rip)
	movq	__qDebugOutputFcn(%rip), %rcx
	xorl	%edx, %edx
	xorl	%r9d, %r9d
	movq	%rsi, %r8
	call	qOutputString
	movl	$32, %edx
	xorl	%ecx, %ecx
	call	*__qDebugOutputFcn(%rip)
.L628:
	movq	__qDebugOutputFcn(%rip), %rcx
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	movq	%r12, %r8
	call	qOutputString
	testq	%rbx, %rbx
	movq	__qDebugOutputFcn(%rip), %rcx
	jne	.L629
	movzwl	%bp, %r9d
	movq	%rdi, %r8
	xorl	%edx, %edx
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	jmp	qPrintXData
.L629:
	xorl	%r9d, %r9d
	movq	%rbx, %r8
	xorl	%edx, %edx
	call	qOutputString
	xorl	%ecx, %ecx
	movl	$13, %edx
	call	*__qDebugOutputFcn(%rip)
	movl	$10, %edx
	xorl	%ecx, %ecx
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	rex.W jmp	*__qDebugOutputFcn(%rip)
.L626:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.seh_endproc
	.globl	__qReg_16Bits
	.def	__qReg_16Bits;	.scl	2;	.type	32;	.endef
	.seh_proc	__qReg_16Bits
__qReg_16Bits:
	.seh_endprologue
	movzwl	(%rcx), %eax
	movb	%dl, %cl
	sarl	%cl, %eax
	andl	$1, %eax
	ret
	.seh_endproc
	.globl	__qReg_08Bits
	.def	__qReg_08Bits;	.scl	2;	.type	32;	.endef
	.seh_proc	__qReg_08Bits
__qReg_08Bits:
	.seh_endprologue
	movzbl	(%rcx), %eax
	movb	%dl, %cl
	sarl	%cl, %eax
	andl	$1, %eax
	ret
	.seh_endproc
	.globl	qEdgeCheck_Initialize
	.def	qEdgeCheck_Initialize;	.scl	2;	.type	32;	.endef
	.seh_proc	qEdgeCheck_Initialize
qEdgeCheck_Initialize:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L635
	testq	%rdx, %rdx
	movq	$0, (%rcx)
	movl	%r8d, 12(%rcx)
	jne	.L637
	leaq	__qReg_32Bits(%rip), %rdx
.L637:
	movq	%rdx, 16(%rbx)
	movb	$2, 24(%rbx)
	call	qSchedulerGetTick
	movl	%eax, 8(%rbx)
	movb	$1, %al
.L635:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
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
	je	.L641
	testq	%rcx, %rcx
	je	.L641
	movb	%r9b, (%rdx)
	movq	(%rcx), %rax
	movq	%r8, %rcx
	movq	%r8, 16(%rdx)
	movq	%rax, 8(%rdx)
	movzbl	%r9b, %edx
	call	*16(%rsi)
	movb	%al, 1(%rbx)
	movq	%rbx, (%rsi)
	movb	$1, %al
	jmp	.L639
.L641:
	xorl	%eax, %eax
.L639:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
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
	movq	%rcx, %rbx
	je	.L642
	cmpb	$0, 24(%rcx)
	jne	.L644
	call	qSchedulerGetTick
	subl	8(%rbx), %eax
	cmpl	12(%rbx), %eax
	jb	.L657
	movb	$1, 24(%rbx)
	jmp	.L657
.L644:
	movq	(%rcx), %rsi
.L646:
	testq	%rsi, %rsi
	je	.L658
	movzbl	(%rsi), %edx
	movq	16(%rsi), %rcx
	call	*16(%rbx)
	movb	24(%rbx), %dl
	cmpb	$1, %dl
	jbe	.L647
	cmpb	%al, 1(%rsi)
	je	.L648
	incl	%edx
	movb	$-1, 2(%rsi)
	movb	%dl, 24(%rbx)
	jmp	.L649
.L648:
	movb	%al, 2(%rsi)
	jmp	.L649
.L647:
	jne	.L649
	cmpb	%al, 1(%rsi)
	je	.L650
	testb	%al, %al
	sete	%dl
	addl	$3, %edx
	movb	%dl, 2(%rsi)
.L650:
	movb	%al, 1(%rsi)
.L649:
	movq	8(%rsi), %rsi
	jmp	.L646
.L658:
	cmpb	$1, 24(%rbx)
	jne	.L653
	movb	$2, 24(%rbx)
	call	qSchedulerGetTick
	movl	%eax, 8(%rbx)
.L653:
	cmpb	$2, 24(%rbx)
	jbe	.L657
	movb	$0, 24(%rbx)
.L657:
	movb	$1, %al
.L642:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.globl	qEdgeCheck_GetNodeStatus
	.def	qEdgeCheck_GetNodeStatus;	.scl	2;	.type	32;	.endef
	.seh_proc	qEdgeCheck_GetNodeStatus
qEdgeCheck_GetNodeStatus:
	.seh_endprologue
	movb	2(%rcx), %al
	ret
	.seh_endproc
	.globl	qATParser_Setup
	.def	qATParser_Setup;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_Setup
qATParser_Setup:
	pushq	%rdi
	.seh_pushreg	%rdi
	.seh_endprologue
	movl	56(%rsp), %r11d
	testq	%rcx, %rcx
	movq	%rcx, %r10
	je	.L662
	testq	%rdx, %rdx
	sete	%al
	je	.L662
	movq	%rdx, 48(%rcx)
	movq	64(%rsp), %rdx
	leaq	_qATPutc_Wrapper(%rip), %rdi
	movq	$0, (%rcx)
	movq	%rdi, 56(%rcx)
	leaq	_qATPuts_Wrapper(%rip), %rdi
	movq	%rdx, 32(%rcx)
	movq	72(%rsp), %rdx
	movq	%rdi, 64(%rcx)
	movq	%rdx, 8(%rcx)
	movq	80(%rsp), %rdx
	movq	%rdx, 16(%rcx)
	movq	88(%rsp), %rdx
	movq	%rdx, 24(%rcx)
	movq	96(%rsp), %rdx
	movq	%rdx, 40(%rcx)
	movzwl	100(%rcx), %ecx
	movq	104(%r10), %rdx
	movq	%rdx, %rdi
	rep stosb
	movzwl	88(%r10), %ecx
	movq	80(%r10), %rdi
	rep stosb
	movq	48(%rsp), %rax
	movq	%r8, 104(%r10)
	movw	%r11w, 88(%r10)
	movw	%r9w, 100(%r10)
	movq	$0, 72(%r10)
	movb	$0, 96(%r10)
	movq	%rax, 80(%r10)
	movw	$0, 98(%r10)
	movb	$1, %al
	jmp	.L660
.L662:
	xorl	%eax, %eax
.L660:
	popq	%rdi
	ret
	.seh_endproc
	.globl	qATParser_CmdSubscribe
	.def	qATParser_CmdSubscribe;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_CmdSubscribe
qATParser_CmdSubscribe:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movl	56(%rsp), %r11d
	testq	%rcx, %rcx
	movq	%rcx, %r10
	je	.L667
	testq	%rdx, %rdx
	jne	.L664
.L667:
	xorl	%eax, %eax
	jmp	.L663
.L664:
	testq	%r8, %r8
	je	.L667
	testq	%r9, %r9
	sete	%al
	je	.L667
	orq	$-1, %rcx
	movq	%r8, %rdi
	repnz scasb
	movq	%rcx, %rbx
	notq	%rbx
	movq	%rbx, %rcx
	decq	%rcx
	cmpw	$1, %cx
	movw	%cx, 26(%rdx)
	jbe	.L667
	cmpb	$97, (%r8)
	jne	.L667
	cmpb	$116, 1(%r8)
	jne	.L667
	movq	(%r10), %rax
	andw	$4095, %r11w
	movq	%r8, (%rdx)
	movq	%r9, 8(%rdx)
	movw	%r11w, 24(%rdx)
	movq	%rax, 16(%rdx)
	movq	%rdx, (%r10)
	movb	$1, %al
.L663:
	popq	%rbx
	popq	%rdi
	ret
	.seh_endproc
	.globl	qATParser_ISRHandler
	.def	qATParser_ISRHandler;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_ISRHandler
qATParser_ISRHandler:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movsbq	%dl, %rdi
	movq	%rcx, %rbx
	movl	%edx, %esi
	call	__locale_ctype_ptr
	testb	$23, 1(%rax,%rdi)
	je	.L670
	movb	96(%rbx), %al
	testb	%al, %al
	jne	.L670
	call	__locale_ctype_ptr
	movsbl	%sil, %ecx
	call	tolower
	movq	104(%rbx), %rcx
	movzwl	98(%rbx), %edx
	leal	1(%rdx), %r8d
	addq	%rcx, %rdx
	movw	%r8w, 98(%rbx)
	movb	%al, (%rdx)
	movq	104(%rbx), %rax
	movzwl	98(%rbx), %edx
	addq	%rdx, %rax
	movb	$0, (%rax)
	movzwl	98(%rbx), %edx
	movzwl	100(%rbx), %eax
	decl	%eax
	cmpl	%eax, %edx
	jl	.L670
	movw	$0, 98(%rbx)
.L670:
	xorl	%eax, %eax
	cmpb	$13, %sil
	jne	.L668
	movq	72(%rbx), %rdx
	movb	$1, 96(%rbx)
	movb	$1, %al
	movw	$0, 98(%rbx)
	testq	%rdx, %rdx
	je	.L668
	movb	$1, 69(%rdx)
	movq	$0, 16(%rdx)
.L668:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	qATParser_ISRHandlerBlock
	.def	qATParser_ISRHandlerBlock;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_ISRHandlerBlock
qATParser_ISRHandlerBlock:
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
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	movl	%r8d, %edi
	jne	.L676
.L678:
	xorl	%eax, %eax
	jmp	.L675
.L676:
	movw	100(%rcx), %ax
	cmpw	%r8w, %ax
	jbe	.L678
	movb	96(%rcx), %al
	testb	%al, %al
	jne	.L678
	decw	%r8w
	jne	.L679
	movsbl	(%rdx), %edx
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	jmp	qATParser_ISRHandler
.L679:
	call	__locale_ctype_ptr
	movsbq	(%rsi), %rdx
	testb	$23, 1(%rax,%rdx)
	je	.L678
	movl	$13, %edx
	movq	%rsi, %rcx
	call	strchr
	testq	%rax, %rax
	je	.L678
	movq	104(%rbx), %rcx
	movq	%rsi, %rdx
	movzwl	%di, %r8d
	call	strncpy
	movq	104(%rbx), %rcx
	call	_qATParser_FixInput
	movq	72(%rbx), %rdx
	movb	$1, 96(%rbx)
	movb	$1, %al
	movw	$0, 98(%rbx)
	testq	%rdx, %rdx
	je	.L675
	movb	$1, 69(%rdx)
	movq	$0, 16(%rdx)
.L675:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	qATParser_Raise
	.def	qATParser_Raise;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_Raise
qATParser_Raise:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	je	.L689
	testq	%rdx, %rdx
	je	.L689
	movb	96(%rcx), %cl
	xorl	%eax, %eax
	testb	%cl, %cl
	jne	.L687
	movzwl	100(%rbx), %r8d
	orq	$-1, %rcx
	movq	%rdx, %rdi
	repnz scasb
	notq	%rcx
	decl	%r8d
	decq	%rcx
	movslq	%r8d, %r8
	cmpq	%r8, %rcx
	ja	.L687
	movb	$1, 96(%rbx)
	movw	$0, 98(%rbx)
	movzwl	100(%rbx), %r8d
	movq	104(%rbx), %rcx
	call	strncpy
	movq	104(%rbx), %rcx
	call	_qATParser_FixInput
	movq	72(%rbx), %rdx
	movb	$1, %al
	testq	%rdx, %rdx
	je	.L687
	movb	$1, 69(%rdx)
	movq	$0, 16(%rdx)
	jmp	.L687
.L689:
	xorl	%eax, %eax
.L687:
	addq	$40, %rsp
	popq	%rbx
	popq	%rdi
	ret
	.seh_endproc
	.globl	qSchedulerAdd_ATParserTask
	.def	qSchedulerAdd_ATParserTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAdd_ATParserTask
qSchedulerAdd_ATParserTask:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	xorps	%xmm3, %xmm3
	movq	%rcx, 72(%rdx)
	movq	%rdx, 48(%rsp)
	leaq	qATParser_TaskCallback(%rip), %rdx
	movl	$0, 40(%rsp)
	movl	$1, 32(%rsp)
	movzbl	%r8b, %r8d
	call	qSchedulerAdd_Task
	addq	$72, %rsp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC14:
	.ascii "at\0"
.LC15:
	.ascii "atid\0"
	.text
	.globl	qATParser_Run
	.def	qATParser_Run;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_Run
qATParser_Run:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	testq	%rcx, %rcx
	movq	%rcx, %rbx
	jne	.L695
.L697:
	xorl	%eax, %eax
	jmp	.L694
.L695:
	movq	48(%rcx), %rax
	movq	%rax, ATOutCharFcn(%rip)
	movb	96(%rcx), %al
	testb	%al, %al
	je	.L697
	movq	104(%rcx), %rcx
	leaq	.LC14(%rip), %rdx
	call	strcmp
	testl	%eax, %eax
	movl	$1, %edx
	je	.L737
	movq	(%rbx), %rsi
.L700:
	testq	%rsi, %rsi
	movq	104(%rbx), %rcx
	je	.L738
	movq	(%rsi), %rdx
	call	strstr
	movq	104(%rbx), %rdx
	cmpq	%rdx, %rax
	jne	.L701
	movq	80(%rbx), %rax
	orq	$-1, %rcx
	movb	$0, (%rax)
	movq	104(%rbx), %rdx
	xorl	%eax, %eax
	movl	$0, 56(%rsp)
	movq	%rsi, 40(%rsp)
	movq	%rdx, %rdi
	repnz scasb
	movzwl	26(%rsi), %edi
	movw	$0, 62(%rsp)
	notq	%rcx
	decq	%rcx
	subl	%edi, %ecx
	addq	%rdx, %rdi
	testw	%cx, %cx
	movw	%cx, 60(%rsp)
	movq	%rdi, 48(%rsp)
	jne	.L702
	testb	$8, 25(%rsi)
	jne	.L703
.L707:
	movl	$-32767, %edi
	jmp	.L704
.L703:
	movl	$2048, 56(%rsp)
	jmp	.L705
.L702:
	movb	(%rdi), %al
	cmpb	$63, %al
	jne	.L706
	testb	$4, 25(%rsi)
	je	.L707
	movl	$1024, 56(%rsp)
	jmp	.L736
.L706:
	cmpw	$1, %cx
	je	.L705
	cmpb	$61, %al
	jne	.L707
	cmpb	$63, 1(%rdi)
	jne	.L708
	cmpw	$2, %cx
	jne	.L705
	testb	$2, 25(%rsi)
	je	.L707
	addq	$2, %rdi
	movl	$512, 56(%rsp)
	movw	$0, 60(%rsp)
	movq	%rdi, 48(%rsp)
	jmp	.L705
.L708:
	movl	24(%rsi), %eax
	testb	$1, %ah
	je	.L707
	movq	%rdi, %r9
	xorl	%r8d, %r8d
.L709:
	movb	(%r9), %r10b
	leal	1(%r8), %edx
	testb	%r10b, %r10b
	je	.L739
	incq	%r9
	cmpb	$44, %r10b
	cmove	%edx, %r8d
	jmp	.L709
.L739:
	movl	%eax, %r8d
	movw	%dx, 62(%rsp)
	shrw	$4, %r8w
	andl	$15, %r8d
	cmpw	%dx, %r8w
	jb	.L707
	andl	$15, %eax
	cmpw	%dx, %ax
	ja	.L707
	movl	$256, 56(%rsp)
.L736:
	incq	%rdi
	decl	%ecx
	movq	%rdi, 48(%rsp)
	movw	%cx, 60(%rsp)
.L705:
	cmpl	$0, 56(%rsp)
	movl	$-32768, %edi
	je	.L712
	leaq	40(%rsp), %rdx
	movq	%rbx, %rcx
	call	*8(%rsi)
	movl	%eax, %edi
.L712:
	movq	80(%rbx), %rax
	testq	%rax, %rax
	je	.L713
	cmpb	$0, (%rax)
	je	.L713
	movl	$32767, %edx
	movq	%rbx, %rcx
	call	_qATParser_HandleCommandResponse.part.12
.L713:
	testl	%edi, %edi
	je	.L699
.L704:
	movl	%edi, %edx
	jmp	.L737
.L701:
	movq	16(%rsi), %rsi
	jmp	.L700
.L738:
	leaq	.LC15(%rip), %rdx
	call	strcmp
	testl	%eax, %eax
	movl	$32765, %edx
	je	.L737
	movq	104(%rbx), %rdi
	xorl	%eax, %eax
	orq	$-1, %rcx
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	decq	%rax
	cmpq	$2, %rax
	jbe	.L699
	movl	$32766, %edx
.L737:
	movq	%rbx, %rcx
	call	_qATParser_HandleCommandResponse.part.12
.L699:
	movb	$0, 96(%rbx)
	movw	$0, 98(%rbx)
	movq	104(%rbx), %rax
	movb	$0, (%rax)
	movb	$1, %al
.L694:
	addq	$64, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.def	qATParser_TaskCallback;	.scl	3;	.type	32;	.endef
	.seh_proc	qATParser_TaskCallback
qATParser_TaskCallback:
	.seh_endprologue
	movq	(%rcx), %rcx
	jmp	qATParser_Run
	.seh_endproc
	.globl	qATParser_GetArgString
	.def	qATParser_GetArgString;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_GetArgString
qATParser_GetArgString:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	testq	%r8, %r8
	sete	%r9b
	testb	%dl, %dl
	setle	%al
	orb	%al, %r9b
	movl	$0, %eax
	jne	.L741
	testq	%rcx, %rcx
	je	.L741
	cmpl	$256, 16(%rcx)
	jne	.L741
	decl	%edx
	xorl	%ebx, %ebx
	xorl	%r9d, %r9d
	xorl	%r11d, %r11d
.L743:
	movq	8(%rcx), %r10
	movsbq	%r11b, %rsi
	movb	(%r10,%rsi), %r10b
	testb	%r10b, %r10b
	je	.L741
	cmpb	%dl, %bl
	jne	.L744
	cmpb	$44, %r10b
	je	.L749
	leal	1(%r9), %edi
	movb	%r10b, (%r8,%r9)
	movsbq	%dil, %rax
	movsbq	%dil, %r9
	movb	$0, (%r8,%rax)
	movq	%r8, %rax
.L744:
	movq	8(%rcx), %r10
	cmpb	$44, (%r10,%rsi)
	jne	.L745
	incl	%ebx
.L745:
	incl	%r11d
	jmp	.L743
.L749:
	movq	%r8, %rax
.L741:
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.globl	qATParser_GetArgPtr
	.def	qATParser_GetArgPtr;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_GetArgPtr
qATParser_GetArgPtr:
	.seh_endprologue
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.L750
	testb	%dl, %dl
	jle	.L750
	cmpl	$256, 16(%rcx)
	jne	.L750
	cmpb	$1, %dl
	movq	8(%rcx), %rax
	je	.L750
	decl	%edx
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	movzbl	%dl, %edx
.L752:
	movswq	%cx, %r10
	movb	(%rax,%r10), %r9b
	testb	%r9b, %r9b
	je	.L757
	cmpb	$44, %r9b
	jne	.L753
	incl	%r8d
	cmpw	%dx, %r8w
	jl	.L753
	leaq	1(%rax,%r10), %rax
	jmp	.L750
.L753:
	incl	%ecx
	jmp	.L752
.L757:
	xorl	%eax, %eax
.L750:
	ret
	.seh_endproc
	.globl	qATParser_GetArgInt
	.def	qATParser_GetArgInt;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_GetArgInt
qATParser_GetArgInt:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movsbl	%dl, %edx
	call	qATParser_GetArgPtr
	movq	%rax, %rcx
	addq	$40, %rsp
	jmp	qAtoI
	.seh_endproc
	.globl	qATParser_GetArgFlt
	.def	qATParser_GetArgFlt;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_GetArgFlt
qATParser_GetArgFlt:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movsbl	%dl, %edx
	call	qATParser_GetArgPtr
	movq	%rax, %rcx
	call	qAtoF
	cvtsd2ss	%xmm0, %xmm0
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	qATParser_GetArgHex
	.def	qATParser_GetArgHex;	.scl	2;	.type	32;	.endef
	.seh_proc	qATParser_GetArgHex
qATParser_GetArgHex:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movsbl	%dl, %edx
	call	qATParser_GetArgPtr
	movq	%rax, %rcx
	addq	$40, %rsp
	jmp	qXtoU32
	.seh_endproc
.lcomm ATOutCharFcn,8,8
	.data
	.align 8
ChainIterator.3545:
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
	.align 8
.LC1:
	.long	0
	.long	-1074790400
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	2576980378
	.long	1069128089
	.align 8
.LC5:
	.long	0
	.long	1076101120
	.align 16
.LC12:
	.long	2147483648
	.long	0
	.long	0
	.long	0
	.align 4
.LC13:
	.long	1092616192
	.ident	"GCC: (GNU) 7.3.0"
	.def	__locale_ctype_ptr;	.scl	2;	.type	32;	.endef
	.def	tolower;	.scl	2;	.type	32;	.endef
	.def	toupper;	.scl	2;	.type	32;	.endef
	.def	strchr;	.scl	2;	.type	32;	.endef
	.def	strncpy;	.scl	2;	.type	32;	.endef
	.def	strcmp;	.scl	2;	.type	32;	.endef
	.def	strstr;	.scl	2;	.type	32;	.endef
