	.file	"main.c"
	.section .rdata,"dr"
.LC0:
	.ascii "state machine init\0"
.LC2:
	.ascii "[%s] first\15\12\0"
	.text
	.p2align 4,,15
	.globl	firststate
	.def	firststate;	.scl	2;	.type	32;	.endef
	.seh_proc	firststate
firststate:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	32(%rcx), %rsi
	movq	%rcx, %rbx
	cmpb	$0, 24(%rsi)
	jne	.L9
	cmpb	$0, 28(%rbx)
	jne	.L10
.L3:
	leaq	tmr.3908(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L4
	leaq	secondstate(%rip), %rax
	movq	%rax, (%rbx)
.L4:
	movl	$-32768, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L9:
	leaq	.LC0(%rip), %rcx
	call	puts
	cmpb	$0, 28(%rbx)
	je	.L3
.L10:
	leaq	tmr.3908(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rsi), %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	jmp	.L3
	.seh_endproc
	.section .rdata,"dr"
.LC3:
	.ascii "[%s] second\15\12\0"
	.text
	.p2align 4,,15
	.globl	secondstate
	.def	secondstate;	.scl	2;	.type	32;	.endef
	.seh_proc	secondstate
secondstate:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	cmpb	$0, 28(%rcx)
	movq	%rcx, %rbx
	jne	.L17
.L12:
	leaq	tmr.3913(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L13
	leaq	firststate(%rip), %rax
	movq	%rax, (%rbx)
.L13:
	movl	$-32768, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L17:
	movq	32(%rcx), %rsi
	leaq	tmr.3913(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rsi), %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	jmp	.L12
	.seh_endproc
	.p2align 4,,15
	.globl	TimerInterruptEmulation
	.def	TimerInterruptEmulation;	.scl	2;	.type	32;	.endef
	.seh_proc	TimerInterruptEmulation
TimerInterruptEmulation:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	leaq	32(%rsp), %rbx
	movq	$0, 32(%rsp)
	movq	$10000000, 40(%rsp)
	.p2align 4,,10
.L19:
	xorl	%edx, %edx
	movq	%rbx, %rcx
	call	nanosleep
	call	qSchedulerSysTick
	jmp	.L19
	.seh_endproc
	.p2align 4,,15
	.globl	datacapture
	.def	datacapture;	.scl	2;	.type	32;	.endef
	.seh_proc	datacapture
datacapture:
	.seh_endprologue
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC4:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
.LC5:
	.ascii "FirstCall\0"
.LC6:
	.ascii "FirtsIteration\0"
.LC7:
	.ascii "LastIteration\0"
.LC8:
	.ascii "TASK1 BY ASYNC EVENT\0"
.LC10:
	.ascii "Timer expired\0"
	.text
	.p2align 4,,15
	.globl	Task1Callback
	.def	Task1Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task1Callback
Task1Callback:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	leaq	Task1(%rip), %rcx
	call	qTaskGetCycles
	movq	8(%rbx), %rdx
	movq	16(%rbx), %r8
	leaq	.LC4(%rip), %rcx
	movl	%eax, %r9d
	call	printf
	cmpb	$0, 24(%rbx)
	jne	.L27
.L22:
	cmpb	$0, 25(%rbx)
	jne	.L28
.L23:
	cmpb	$0, 26(%rbx)
	jne	.L29
	cmpl	$3, (%rbx)
	je	.L30
.L25:
	leaq	tmr.3917(%rip), %rcx
	movss	.LC9(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L31
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L31:
	leaq	.LC10(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	puts
	.p2align 4,,10
.L29:
	leaq	.LC7(%rip), %rcx
	call	puts
	cmpl	$3, (%rbx)
	jne	.L25
.L30:
	leaq	.LC8(%rip), %rcx
	call	puts
	jmp	.L25
	.p2align 4,,10
.L28:
	leaq	.LC6(%rip), %rcx
	call	puts
	jmp	.L23
	.p2align 4,,10
.L27:
	leaq	.LC5(%rip), %rcx
	call	puts
	jmp	.L22
	.seh_endproc
	.section .rdata,"dr"
.LC11:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
.LC12:
	.ascii "ring extracted data %d\15\12\0"
	.text
	.p2align 4,,15
	.globl	Task3Callback
	.def	Task3Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task3Callback
Task3Callback:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	8(%rcx), %rdx
	movq	16(%rcx), %r8
	movq	%rcx, %rbx
	leaq	.LC11(%rip), %rcx
	call	printf
	cmpl	$4, (%rbx)
	je	.L34
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L34:
	movq	16(%rbx), %rax
	leaq	.LC12(%rip), %rcx
	movl	(%rax), %edx
	addq	$32, %rsp
	popq	%rbx
	jmp	printf
	.seh_endproc
	.p2align 4,,15
	.globl	Task6Callback
	.def	Task6Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task6Callback
Task6Callback:
	.seh_endprologue
	movq	8(%rcx), %rdx
	movq	16(%rcx), %r8
	leaq	.LC11(%rip), %rcx
	jmp	printf
	.seh_endproc
	.p2align 4,,15
	.globl	Task5Callback
	.def	Task5Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task5Callback
Task5Callback:
	.seh_endprologue
	jmp	Task6Callback
	.seh_endproc
	.p2align 4,,15
	.globl	Task4Callback
	.def	Task4Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task4Callback
Task4Callback:
	.seh_endprologue
	jmp	Task6Callback
	.seh_endproc
	.p2align 4,,15
	.globl	Task2Callback
	.def	Task2Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task2Callback
Task2Callback:
	.seh_endprologue
	jmp	Task6Callback
	.seh_endproc
	.section .rdata,"dr"
.LC14:
	.ascii "hi\0"
	.text
	.p2align 4,,15
	.globl	IdleTaskCallback
	.def	IdleTaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	IdleTaskCallback
IdleTaskCallback:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leaq	t.3937(%rip), %rcx
	movss	.LC13(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L41
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L41:
	leaq	Task1(%rip), %rbx
	leaq	.LC14(%rip), %rcx
	call	puts
	movq	%rbx, %rcx
	movl	$6, %edx
	call	qTaskSetIterations
	movl	$1, %edx
	movq	%rbx, %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	qTaskSetState
	.seh_endproc
	.section .rdata,"dr"
.LC15:
	.ascii "led on\0"
	.text
	.p2align 4,,15
	.globl	blinktaskCallback
	.def	blinktaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	blinktaskCallback
blinktaskCallback:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	_qCRTaskState_.3944(%rip), %eax
	cmpl	$128, %eax
	je	.L44
	jle	.L68
	cmpl	$130, %eax
	je	.L48
	jl	.L49
	cmpl	$136, %eax
	jne	.L42
	leaq	tmr.3941(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L42
.L46:
	leaq	.LC15(%rip), %rcx
	call	puts
	movl	$126, state.3942(%rip)
.L47:
	leaq	tmr.3941(%rip), %rcx
	movss	.LC16(%rip), %xmm1
	call	qSTimerSet
	movl	$128, _qCRTaskState_.3944(%rip)
.L44:
	leaq	tmr.3941(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L42
	movl	$129, _qCRTaskState_.3944(%rip)
.L49:
	movl	$130, state.3942(%rip)
.L48:
	leaq	tmr.3941(%rip), %rcx
	movss	.LC16(%rip), %xmm1
	call	qSTimerSet
	movl	state.3942(%rip), %eax
	movl	%eax, _qCRTaskState_.3944(%rip)
.L42:
	addq	$40, %rsp
	ret
	.p2align 4,,10
.L68:
	cmpl	$-32766, %eax
	je	.L46
	cmpl	$126, %eax
	je	.L47
	jmp	.L42
	.seh_endproc
	.p2align 4,,15
	.globl	qStringHash
	.def	qStringHash;	.scl	2;	.type	32;	.endef
	.seh_proc	qStringHash
qStringHash:
	.seh_endprologue
	cmpb	$1, %dl
	je	.L71
	jb	.L72
	cmpb	$2, %dl
	jne	.L87
	movzbl	(%rcx), %eax
	xorl	%r8d, %r8d
	testb	%al, %al
	je	.L87
	.p2align 4,,10
.L83:
	movsbl	%al, %edx
	movl	%r8d, %r9d
	addq	$1, %rcx
	leal	(%rdx,%r8), %eax
	sall	$10, %r9d
	addl	%r9d, %eax
	movl	%eax, %r8d
	shrl	$6, %r8d
	xorl	%eax, %r8d
	movzbl	(%rcx), %eax
	testb	%al, %al
	jne	.L83
	leal	(%r8,%r8,8), %edx
	movl	%edx, %eax
	shrl	$11, %eax
	xorl	%eax, %edx
	movl	%edx, %eax
	sall	$15, %eax
	addl	%edx, %eax
	ret
	.p2align 4,,10
.L87:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L72:
	movzbl	(%rcx), %edx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L81
	.p2align 4,,10
.L77:
	movl	%eax, %r8d
	addq	$1, %rcx
	sall	$5, %r8d
	addl	%r8d, %eax
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	testb	%dl, %dl
	jne	.L77
	rep ret
	.p2align 4,,10
.L71:
	movzbl	(%rcx), %edx
	movl	$-2128831035, %eax
	testb	%dl, %dl
	je	.L88
	.p2align 4,,10
.L82:
	addq	$1, %rcx
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	imull	$16777619, %eax, %eax
	testb	%dl, %dl
	jne	.L82
	rep ret
.L81:
	rep ret
.L88:
	rep ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section	.text.startup,"x"
	.p2align 4,,15
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$136, %rsp
	.seh_stackalloc	136
	.seh_endprologue
	leaq	32(%rsp), %rsi
	leaq	80(%rsp), %rbx
	call	__main
	movq	%rsi, %rdx
	movl	$2, %r8d
	movl	$1567, %ecx
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 56(%rsp)
	movq	$0, 64(%rsp)
	movq	$0, 80(%rsp)
	movq	$0, 88(%rsp)
	movq	$0, 96(%rsp)
	movq	$0, 104(%rsp)
	movq	$0, 112(%rsp)
	call	qItoA
	movl	$5, %r8d
	movq	%rbx, %rdx
	movl	$844, %ecx
	call	qU32toX
	movq	%rsi, %rcx
	call	puts
	movq	%rbx, %rcx
	call	puts
	xorl	%eax, %eax
	addq	$136, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
.lcomm tmr.3941,12,8
.lcomm state.3942,4,4
	.data
	.align 4
_qCRTaskState_.3944:
	.long	-32766
.lcomm t.3937,12,8
.lcomm tmr.3917,12,8
.lcomm tmr.3913,12,8
.lcomm tmr.3908,12,8
	.comm	SMTask2, 88, 5
	.comm	SMTask, 88, 5
	.comm	blinktask, 88, 5
	.comm	TaskTestST, 88, 5
	.comm	Task6, 88, 5
	.comm	Task5, 88, 5
	.comm	Task4, 88, 5
	.comm	Task3, 88, 5
	.comm	Task2, 88, 5
	.comm	Task1, 88, 5
	.comm	TimerEmulation, 8, 3
	.section .rdata,"dr"
	.align 4
.LC1:
	.long	1075838976
	.align 4
.LC9:
	.long	1056964608
	.align 4
.LC13:
	.long	1084227584
	.align 4
.LC16:
	.long	1065353216
	.ident	"GCC: (GNU) 6.4.0"
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	qSchedulerSysTick;	.scl	2;	.type	32;	.endef
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.def	qU32toX;	.scl	2;	.type	32;	.endef
