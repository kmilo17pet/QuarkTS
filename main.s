	.file	"main.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "state machine init\0"
.LC2:
	.ascii "[%s] first\15\12\0"
.LC3:
	.ascii "[main.c:44] &tmr.Start=\0"
.LC4:
	.ascii "[main.c:45] tmr.Start=\0"
.LC5:
	.ascii "\15\12\0"
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
	movq	32(%rcx), %rbx
	movq	%rcx, %rsi
	cmpb	$0, 24(%rbx)
	jne	.L15
	cmpb	$0, 28(%rsi)
	jne	.L16
.L3:
	movq	.refptr.__qDebugOutputFcn(%rip), %rbx
	movq	(%rbx), %rcx
	testq	%rcx, %rcx
	je	.L5
	leaq	.LC3(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	4+tmr.4046(%rip), %r8
	xorl	%edx, %edx
	movl	$4, %r9d
	call	qPrintXData
	movq	(%rbx), %rcx
	testq	%rcx, %rcx
	je	.L5
	leaq	.LC4(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	4+tmr.4046(%rip), %ecx
	movl	$10, %r8d
	call	qItoA
	movq	(%rbx), %rcx
	movq	%rax, %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	.LC5(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
.L5:
	leaq	tmr.4046(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L7
	leaq	secondstate(%rip), %rax
	movq	%rax, (%rsi)
.L7:
	movl	$-32768, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L15:
	leaq	.LC0(%rip), %rcx
	call	puts
	cmpb	$0, 28(%rsi)
	je	.L3
.L16:
	leaq	tmr.4046(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rbx), %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	jmp	.L3
	.seh_endproc
	.section .rdata,"dr"
.LC6:
	.ascii "[%s] second\15\12\0"
.LC7:
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
	jne	.L23
.L18:
	leaq	tmr.4051(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L19
	leaq	firststate(%rip), %rax
	movq	%rax, (%rbx)
.L19:
	movl	$-32768, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L23:
	movq	32(%rcx), %rsi
	leaq	tmr.4051(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rsi), %rdx
	leaq	.LC6(%rip), %rcx
	call	printf
	leaq	.LC7(%rip), %rdx
	leaq	Task1(%rip), %rcx
	call	qTaskQueueEvent
	jmp	.L18
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
.L26:
	xorl	%edx, %edx
	movq	%rbx, %rcx
	call	nanosleep
	call	qSchedulerSysTick
	jmp	.L26
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
.LC8:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
.LC9:
	.ascii "FirstCall\0"
.LC10:
	.ascii "FirtsIteration\0"
.LC11:
	.ascii "LastIteration\0"
.LC12:
	.ascii "TASK1 BY ASYNC EVENT\0"
.LC13:
	.ascii "TASK1 BY QUEUE EXTRACTION\0"
.LC15:
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
	leaq	.LC8(%rip), %rcx
	movl	%eax, %r9d
	call	printf
	cmpb	$0, 24(%rbx)
	jne	.L35
.L29:
	cmpb	$0, 25(%rbx)
	jne	.L36
.L30:
	cmpb	$0, 26(%rbx)
	jne	.L37
	movl	(%rbx), %eax
	cmpl	$3, %eax
	je	.L38
.L32:
	cmpl	$2, %eax
	je	.L39
.L33:
	leaq	tmr.4055(%rip), %rcx
	movss	.LC14(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L40
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L40:
	leaq	.LC15(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	puts
	.p2align 4,,10
.L37:
	leaq	.LC11(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$3, %eax
	jne	.L32
.L38:
	leaq	.LC12(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$2, %eax
	jne	.L33
.L39:
	leaq	.LC13(%rip), %rcx
	call	puts
	jmp	.L33
	.p2align 4,,10
.L36:
	leaq	.LC10(%rip), %rcx
	call	puts
	jmp	.L30
	.p2align 4,,10
.L35:
	leaq	.LC9(%rip), %rcx
	call	puts
	jmp	.L29
	.seh_endproc
	.section .rdata,"dr"
.LC16:
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
	leaq	.LC16(%rip), %rcx
	jmp	printf
	.seh_endproc
	.section .rdata,"dr"
.LC17:
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
	leaq	.LC16(%rip), %rcx
	call	printf
	cmpl	$4, (%rbx)
	je	.L44
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L44:
	movq	16(%rbx), %rax
	leaq	.LC17(%rip), %rcx
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
.LC19:
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
	leaq	t.4075(%rip), %rcx
	movss	.LC18(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L50
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L50:
	leaq	Task1(%rip), %rbx
	leaq	.LC19(%rip), %rcx
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
.LC20:
	.ascii "led on\0"
.LC22:
	.ascii "led off\0"
.LC23:
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
	movl	_qCRTaskState_.4082(%rip), %eax
	cmpl	$140, %eax
	jg	.L53
	cmpl	$139, %eax
	jge	.L54
	cmpl	$136, %eax
	je	.L55
	cmpl	$138, %eax
	je	.L56
	cmpl	$-32766, %eax
	jne	.L51
.L57:
	leaq	.LC20(%rip), %rcx
	call	puts
.L55:
	leaq	tmr.4079(%rip), %rcx
	movss	.LC21(%rip), %xmm1
	call	qSTimerSet
	movl	$138, _qCRTaskState_.4082(%rip)
.L56:
	leaq	tmr.4079(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L51
	movl	$139, _qCRTaskState_.4082(%rip)
.L54:
	leaq	tmr.4079(%rip), %rcx
	movss	.LC21(%rip), %xmm1
	call	qSTimerSet
	leaq	.LC22(%rip), %rcx
	call	puts
	leaq	Task1(%rip), %rcx
	xorl	%edx, %edx
	call	qTaskSendEvent
	movl	$148, _qCRTaskState_.4082(%rip)
.L58:
	leaq	tmr.4079(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	jne	.L81
.L52:
.L51:
	addq	$40, %rsp
	ret
	.p2align 4,,10
.L53:
	cmpl	$148, %eax
	je	.L58
	cmpl	$151, %eax
	jne	.L51
	leaq	tmr.4079(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L51
	movl	$-32766, _qCRTaskState_.4082(%rip)
.L82:
	addq	$40, %rsp
	ret
	.p2align 4,,10
.L81:
	leaq	.LC23(%rip), %rcx
	call	puts
	leaq	tmr.4079(%rip), %rcx
	movss	.LC24(%rip), %xmm1
	call	qSTimerSet
	leaq	tmr.4079(%rip), %rcx
	movl	$151, _qCRTaskState_.4082(%rip)
	call	qSTimerExpired
	testb	%al, %al
	je	.L51
	movl	$-32766, _qCRTaskState_.4082(%rip)
	jmp	.L82
	.seh_endproc
	.p2align 4,,15
	.globl	qStringHash
	.def	qStringHash;	.scl	2;	.type	32;	.endef
	.seh_proc	qStringHash
qStringHash:
	.seh_endprologue
	cmpb	$1, %dl
	je	.L85
	jb	.L86
	cmpb	$2, %dl
	jne	.L101
	movsbl	(%rcx), %eax
	xorl	%edx, %edx
	testb	%al, %al
	je	.L101
	.p2align 4,,10
.L88:
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
	jne	.L88
	leal	(%rdx,%rdx,8), %edx
	movl	%edx, %eax
	shrl	$11, %eax
	xorl	%eax, %edx
	movl	%edx, %eax
	sall	$15, %eax
	addl	%edx, %eax
.L83:
	ret
	.p2align 4,,10
.L101:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L86:
	movzbl	(%rcx), %edx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L83
	.p2align 4,,10
.L91:
	movl	%eax, %r8d
	addq	$1, %rcx
	sall	$5, %r8d
	addl	%r8d, %eax
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	testb	%dl, %dl
	jne	.L91
	ret
	.p2align 4,,10
.L85:
	movzbl	(%rcx), %edx
	movl	$-2128831035, %eax
	testb	%dl, %dl
	je	.L83
	.p2align 4,,10
.L90:
	addq	$1, %rcx
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	imull	$16777619, %eax, %eax
	testb	%dl, %dl
	jne	.L90
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC25:
	.ascii "\15\12%d\15\12\0"
	.text
	.p2align 4,,15
	.globl	outputfcn
	.def	outputfcn;	.scl	2;	.type	32;	.endef
	.seh_proc	outputfcn
outputfcn:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%edx, %ebx
	movzwl	%cx, %edx
	leaq	.LC25(%rip), %rcx
	call	printf
	movsbl	%bl, %ecx
	addq	$32, %rsp
	popq	%rbx
	jmp	putchar
	.seh_endproc
	.p2align 4,,15
	.globl	inputfcn
	.def	inputfcn;	.scl	2;	.type	32;	.endef
	.seh_proc	inputfcn
inputfcn:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%edx, %ebx
	movl	%ecx, %edx
	leaq	.LC25(%rip), %rcx
	call	printf
	movsbl	%bl, %ecx
	addq	$32, %rsp
	popq	%rbx
	jmp	putchar
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC26:
	.ascii "[main.c:193] 7485=\0"
	.section	.text.startup,"x"
	.p2align 4,,15
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	movq	.refptr.__qDebugOutputFcn(%rip), %rbx
	leaq	putcharfcn(%rip), %rcx
	leaq	.LC26(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	movq	%rcx, (%rbx)
	call	qOutputString
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	$7485, %ecx
	call	qUtoA
	movq	(%rbx), %rcx
	movq	%rax, %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	.LC5(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
.lcomm tmr.4079,12,8
	.data
	.align 4
_qCRTaskState_.4082:
	.long	-32766
.lcomm t.4075,12,8
.lcomm tmr.4055,12,8
.lcomm tmr.4051,12,8
.lcomm tmr.4046,12,8
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
.LC14:
	.long	1056964608
	.align 4
.LC18:
	.long	1084227584
	.align 4
.LC21:
	.long	1065353216
	.align 4
.LC24:
	.long	1073741824
	.ident	"GCC: (GNU) 7.3.0"
	.def	qOutputString;	.scl	2;	.type	32;	.endef
	.def	qPrintXData;	.scl	2;	.type	32;	.endef
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	qSchedulerSysTick;	.scl	2;	.type	32;	.endef
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.def	qUtoA;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr.qDebugTrace_Buffer, "dr"
	.globl	.refptr.qDebugTrace_Buffer
	.linkonce	discard
.refptr.qDebugTrace_Buffer:
	.quad	qDebugTrace_Buffer
	.section	.rdata$.refptr.__qDebugOutputFcn, "dr"
	.globl	.refptr.__qDebugOutputFcn
	.linkonce	discard
.refptr.__qDebugOutputFcn:
	.quad	__qDebugOutputFcn
