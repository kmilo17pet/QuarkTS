	.file	"main.c"
	.text
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
.L2:
	xorl	%edx, %edx
	movq	%rbx, %rcx
	call	nanosleep
	call	qSchedulerSysTick
	jmp	.L2
	.seh_endproc
	.p2align 4,,15
	.globl	putcharfcn
	.def	putcharfcn;	.scl	2;	.type	32;	.endef
	.seh_proc	putcharfcn
putcharfcn:
	.seh_endprologue
	movsbl	%dl, %ecx
	jmp	putchar
	.seh_endproc
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
	jne	.L12
	cmpb	$0, 28(%rbx)
	jne	.L13
.L7:
	leaq	tmr.4059(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L8
	leaq	secondstate(%rip), %rax
	movq	%rax, (%rbx)
.L8:
	movl	$-32768, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L12:
	leaq	.LC0(%rip), %rcx
	call	puts
	cmpb	$0, 28(%rbx)
	je	.L7
.L13:
	leaq	tmr.4059(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rsi), %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	jmp	.L7
	.seh_endproc
	.section .rdata,"dr"
.LC3:
	.ascii "[%s] second\15\12\0"
.LC4:
	.ascii "HELLO\0"
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
	jne	.L20
.L15:
	leaq	tmr.4064(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L16
	leaq	firststate(%rip), %rax
	movq	%rax, (%rbx)
.L16:
	movl	$-32768, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L20:
	movq	32(%rcx), %rsi
	leaq	tmr.4064(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rsi), %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	leaq	.LC4(%rip), %rdx
	leaq	Task1(%rip), %rcx
	call	qTaskQueueEvent
	jmp	.L15
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
.LC5:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
.LC6:
	.ascii "FirstCall\0"
.LC7:
	.ascii "FirtsIteration\0"
.LC8:
	.ascii "LastIteration\0"
.LC9:
	.ascii "TASK1 BY ASYNC EVENT\0"
.LC10:
	.ascii "TASK1 BY QUEUE EXTRACTION\0"
.LC12:
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
	leaq	.LC5(%rip), %rcx
	movl	%eax, %r9d
	call	printf
	cmpb	$0, 24(%rbx)
	jne	.L29
.L23:
	cmpb	$0, 25(%rbx)
	jne	.L30
.L24:
	cmpb	$0, 26(%rbx)
	jne	.L31
	movl	(%rbx), %eax
	cmpl	$3, %eax
	je	.L32
.L26:
	cmpl	$2, %eax
	je	.L33
.L27:
	leaq	tmr.4068(%rip), %rcx
	movss	.LC11(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L34
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L34:
	leaq	.LC12(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	puts
	.p2align 4,,10
.L31:
	leaq	.LC8(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$3, %eax
	jne	.L26
.L32:
	leaq	.LC9(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$2, %eax
	jne	.L27
.L33:
	leaq	.LC10(%rip), %rcx
	call	puts
	jmp	.L27
	.p2align 4,,10
.L30:
	leaq	.LC7(%rip), %rcx
	call	puts
	jmp	.L24
	.p2align 4,,10
.L29:
	leaq	.LC6(%rip), %rcx
	call	puts
	jmp	.L23
	.seh_endproc
	.section .rdata,"dr"
.LC13:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
	.text
	.p2align 4,,15
	.globl	Task2Callback
	.def	Task2Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task2Callback
Task2Callback:
	.seh_endprologue
	movq	8(%rcx), %rdx
	movq	16(%rcx), %r8
	leaq	.LC13(%rip), %rcx
	jmp	printf
	.seh_endproc
	.section .rdata,"dr"
.LC14:
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
	leaq	.LC13(%rip), %rcx
	call	printf
	cmpl	$4, (%rbx)
	je	.L38
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L38:
	movq	16(%rbx), %rax
	leaq	.LC14(%rip), %rcx
	movl	(%rax), %edx
	addq	$32, %rsp
	popq	%rbx
	jmp	printf
	.seh_endproc
	.p2align 4,,15
	.globl	Task4Callback
	.def	Task4Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task4Callback
Task4Callback:
	.seh_endprologue
	jmp	Task2Callback
	.seh_endproc
	.p2align 4,,15
	.globl	Task5Callback
	.def	Task5Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task5Callback
Task5Callback:
	.seh_endprologue
	jmp	Task2Callback
	.seh_endproc
	.p2align 4,,15
	.globl	Task6Callback
	.def	Task6Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task6Callback
Task6Callback:
	.seh_endprologue
	jmp	Task2Callback
	.seh_endproc
	.section .rdata,"dr"
.LC16:
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
	leaq	t.4088(%rip), %rcx
	movss	.LC15(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L44
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L44:
	leaq	Task1(%rip), %rbx
	leaq	.LC16(%rip), %rcx
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
.LC17:
	.ascii "led on\0"
.LC19:
	.ascii "led off\0"
.LC20:
	.ascii "led fuck\0"
	.text
	.p2align 4,,15
	.globl	blinktaskCallback
	.def	blinktaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	blinktaskCallback
blinktaskCallback:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	_qCRTaskState_.4095(%rip), %eax
	cmpl	$141, %eax
	jg	.L47
	cmpl	$140, %eax
	jge	.L48
	cmpl	$137, %eax
	je	.L49
	cmpl	$139, %eax
	je	.L50
	cmpl	$-32766, %eax
	jne	.L45
.L51:
	leaq	.LC17(%rip), %rcx
	call	puts
.L49:
	leaq	tmr.4092(%rip), %rcx
	movss	.LC18(%rip), %xmm1
	call	qSTimerSet
	movl	$139, _qCRTaskState_.4095(%rip)
.L50:
	leaq	tmr.4092(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L45
	movl	$140, _qCRTaskState_.4095(%rip)
.L48:
	leaq	tmr.4092(%rip), %rcx
	movss	.LC18(%rip), %xmm1
	call	qSTimerSet
	leaq	.LC19(%rip), %rcx
	call	puts
	leaq	Task1(%rip), %rcx
	xorl	%edx, %edx
	call	qTaskSendEvent
	movl	$149, _qCRTaskState_.4095(%rip)
.L52:
	leaq	tmr.4092(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	jne	.L75
.L46:
.L45:
	addq	$40, %rsp
	ret
	.p2align 4,,10
.L47:
	cmpl	$149, %eax
	je	.L52
	cmpl	$152, %eax
	jne	.L45
	leaq	tmr.4092(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L45
	movl	$-32766, _qCRTaskState_.4095(%rip)
.L76:
	addq	$40, %rsp
	ret
	.p2align 4,,10
.L75:
	leaq	.LC20(%rip), %rcx
	call	puts
	leaq	tmr.4092(%rip), %rcx
	movss	.LC21(%rip), %xmm1
	call	qSTimerSet
	leaq	tmr.4092(%rip), %rcx
	movl	$152, _qCRTaskState_.4095(%rip)
	call	qSTimerExpired
	testb	%al, %al
	je	.L45
	movl	$-32766, _qCRTaskState_.4095(%rip)
	jmp	.L76
	.seh_endproc
	.p2align 4,,15
	.globl	qStringHash
	.def	qStringHash;	.scl	2;	.type	32;	.endef
	.seh_proc	qStringHash
qStringHash:
	.seh_endprologue
	cmpb	$1, %dl
	je	.L79
	jb	.L80
	cmpb	$2, %dl
	jne	.L95
	movsbl	(%rcx), %eax
	xorl	%edx, %edx
	testb	%al, %al
	je	.L95
	.p2align 4,,10
.L82:
	movl	%edx, %r8d
	addl	%edx, %eax
	addq	$1, %rcx
	sall	$10, %r8d
	leal	(%r8,%rax), %edx
	movl	%edx, %eax
	shrl	$6, %eax
	xorl	%eax, %edx
	movsbl	(%rcx), %eax
	testb	%al, %al
	jne	.L82
	leal	(%rdx,%rdx,8), %edx
	movl	%edx, %eax
	shrl	$11, %eax
	xorl	%eax, %edx
	movl	%edx, %eax
	sall	$15, %eax
	addl	%edx, %eax
.L77:
	ret
	.p2align 4,,10
.L95:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L80:
	movzbl	(%rcx), %edx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L77
	.p2align 4,,10
.L85:
	movl	%eax, %r8d
	addq	$1, %rcx
	sall	$5, %r8d
	addl	%r8d, %eax
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	testb	%dl, %dl
	jne	.L85
	ret
	.p2align 4,,10
.L79:
	movzbl	(%rcx), %edx
	movl	$-2128831035, %eax
	testb	%dl, %dl
	je	.L77
	.p2align 4,,10
.L84:
	addq	$1, %rcx
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	imull	$16777619, %eax, %eax
	testb	%dl, %dl
	jne	.L84
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC22:
	.ascii "0==1\0"
.LC23:
	.ascii "main.c\0"
	.section	.text.startup,"x"
	.p2align 4,,15
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$136, %rsp
	.seh_stackalloc	136
	.seh_endprologue
	call	__main
	movq	.refptr.__qDebugOutputFcn(%rip), %rax
	leaq	putcharfcn(%rip), %rdx
	leaq	TimerInterruptEmulation(%rip), %r8
	leaq	TimerEmulation(%rip), %rcx
	xorl	%r9d, %r9d
	movq	%rdx, (%rax)
	xorl	%edx, %edx
	call	pthread_create
	xorl	%eax, %eax
	movl	$4, %edx
	leaq	48(%rsp), %rcx
	movw	%ax, 46(%rsp)
	leaq	38(%rsp), %rax
	movw	%dx, 48(%rsp)
	movl	$40, %edx
	movq	$0, 80(%rsp)
	movq	$0, 88(%rsp)
	movq	%rax, 56(%rsp)
	leaq	80(%rsp), %rax
	movq	$0, 96(%rsp)
	movq	$0, 104(%rsp)
	movq	$0, 112(%rsp)
	movq	$0, 38(%rsp)
	movb	$10, 50(%rsp)
	movq	%rax, 64(%rsp)
	call	qMemoryAlloc
	leaq	.LC22(%rip), %r9
	leaq	__FUNCTION__.4135(%rip), %r8
	leaq	.LC23(%rip), %rcx
	movl	$186, %edx
	call	__assert_func
	nop
	.seh_endproc
	.section .rdata,"dr"
__FUNCTION__.4135:
	.ascii "main\0"
.lcomm tmr.4092,12,8
	.data
	.align 4
_qCRTaskState_.4095:
	.long	-32766
.lcomm t.4088,12,8
.lcomm tmr.4068,12,8
.lcomm tmr.4064,12,8
.lcomm tmr.4059,12,8
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
.LC11:
	.long	1056964608
	.align 4
.LC15:
	.long	1084227584
	.align 4
.LC18:
	.long	1065353216
	.align 4
.LC21:
	.long	1073741824
	.ident	"GCC: (GNU) 7.3.0"
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	qSchedulerSysTick;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.def	__assert_func;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr.__qDebugOutputFcn, "dr"
	.globl	.refptr.__qDebugOutputFcn
	.linkonce	discard
.refptr.__qDebugOutputFcn:
	.quad	__qDebugOutputFcn
