	.file	"main.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "state machine init\0"
.LC2:
	.ascii "[%s] first\15\12\0"
.LC3:
	.ascii ">(main.c)@43:{\0"
.LC4:
	.ascii "} &tmr.Start = \0"
.LC5:
	.ascii ">(main.c)@44:{\0"
.LC6:
	.ascii "} tmr.Start = \0"
.LC7:
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
	leaq	__FUNCTION__.3969(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	.LC4(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	4+tmr.3968(%rip), %r8
	xorl	%edx, %edx
	movl	$4, %r9d
	call	qPrintXData
	movq	(%rbx), %rcx
	testq	%rcx, %rcx
	je	.L5
	leaq	.LC5(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	__FUNCTION__.3969(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	.LC6(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	4+tmr.3968(%rip), %ecx
	movl	$10, %r8d
	call	qItoA
	movq	(%rbx), %rcx
	movq	%rax, %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	.LC7(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
.L5:
	leaq	tmr.3968(%rip), %rcx
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
	leaq	tmr.3968(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rbx), %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	jmp	.L3
	.seh_endproc
	.section .rdata,"dr"
.LC8:
	.ascii "[%s] second\15\12\0"
.LC9:
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
	leaq	tmr.3974(%rip), %rcx
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
	leaq	tmr.3974(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rsi), %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	leaq	.LC9(%rip), %rdx
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
.LC10:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
.LC11:
	.ascii "FirstCall\0"
.LC12:
	.ascii "FirtsIteration\0"
.LC13:
	.ascii "LastIteration\0"
.LC14:
	.ascii "TASK1 BY ASYNC EVENT\0"
.LC15:
	.ascii "TASK1 BY QUEUE EXTRACTION\0"
.LC17:
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
	leaq	.LC10(%rip), %rcx
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
	leaq	tmr.3978(%rip), %rcx
	movss	.LC16(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L40
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L40:
	leaq	.LC17(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	puts
	.p2align 4,,10
.L37:
	leaq	.LC13(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$3, %eax
	jne	.L32
.L38:
	leaq	.LC14(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$2, %eax
	jne	.L33
.L39:
	leaq	.LC15(%rip), %rcx
	call	puts
	jmp	.L33
	.p2align 4,,10
.L36:
	leaq	.LC12(%rip), %rcx
	call	puts
	jmp	.L30
	.p2align 4,,10
.L35:
	leaq	.LC11(%rip), %rcx
	call	puts
	jmp	.L29
	.seh_endproc
	.section .rdata,"dr"
.LC18:
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
	leaq	.LC18(%rip), %rcx
	jmp	printf
	.seh_endproc
	.section .rdata,"dr"
.LC19:
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
	leaq	.LC18(%rip), %rcx
	call	printf
	cmpl	$4, (%rbx)
	je	.L44
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L44:
	movq	16(%rbx), %rax
	leaq	.LC19(%rip), %rcx
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
.LC21:
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
	leaq	t.3998(%rip), %rcx
	movss	.LC20(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L50
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L50:
	leaq	Task1(%rip), %rbx
	leaq	.LC21(%rip), %rcx
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
.LC22:
	.ascii "led on\0"
.LC24:
	.ascii "led off\0"
.LC25:
	.ascii "led fuck\0"
	.text
	.p2align 4,,15
	.globl	blinktaskCallback
	.def	blinktaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	blinktaskCallback
blinktaskCallback:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	_qCRTaskState_.4005(%rip), %eax
	cmpl	$138, %eax
	je	.L66
	jle	.L77
	cmpl	$147, %eax
	je	.L68
	cmpl	$150, %eax
	je	.L69
	cmpl	$139, %eax
	je	.L78
.L52:
.L51:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L77:
	cmpl	$135, %eax
	je	.L64
	cmpl	$137, %eax
	je	.L65
	cmpl	$-32766, %eax
	jne	.L51
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L57
	.p2align 4,,10
.L79:
	leaq	.LC25(%rip), %rcx
	call	puts
	leaq	tmr.4002(%rip), %rcx
	movss	.LC26(%rip), %xmm1
	call	qSTimerSet
	movl	$150, _qCRTaskState_.4005(%rip)
.L59:
	leaq	tmr.4002(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L51
.L57:
	leaq	.LC22(%rip), %rcx
	call	puts
.L55:
	leaq	tmr.4002(%rip), %rcx
	movss	.LC23(%rip), %xmm1
	call	qSTimerSet
	movl	$137, _qCRTaskState_.4005(%rip)
.L56:
	leaq	tmr.4002(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L51
	movl	$138, _qCRTaskState_.4005(%rip)
.L53:
	cmpl	%esi, %ebx
	je	.L51
	addl	$1, %esi
	addl	$1, %ebx
.L60:
	leaq	tmr.4002(%rip), %rcx
	movss	.LC23(%rip), %xmm1
	call	qSTimerSet
	leaq	.LC24(%rip), %rcx
	call	puts
	leaq	Task1(%rip), %rcx
	xorl	%edx, %edx
	call	qTaskSendEvent
	movl	$147, _qCRTaskState_.4005(%rip)
.L58:
	leaq	tmr.4002(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	jne	.L79
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L69:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L59
	.p2align 4,,10
.L65:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L56
	.p2align 4,,10
.L68:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L58
	.p2align 4,,10
.L78:
	movl	$2, %ebx
	xorl	%esi, %esi
	jmp	.L60
	.p2align 4,,10
.L64:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L55
	.p2align 4,,10
.L66:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L53
	.seh_endproc
	.p2align 4,,15
	.globl	qStringHash
	.def	qStringHash;	.scl	2;	.type	32;	.endef
	.seh_proc	qStringHash
qStringHash:
	.seh_endprologue
	cmpb	$1, %dl
	je	.L82
	jb	.L83
	cmpb	$2, %dl
	jne	.L98
	movsbl	(%rcx), %eax
	xorl	%edx, %edx
	testb	%al, %al
	je	.L98
	.p2align 4,,10
.L85:
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
	jne	.L85
	leal	(%rdx,%rdx,8), %edx
	movl	%edx, %eax
	shrl	$11, %eax
	xorl	%eax, %edx
	movl	%edx, %eax
	sall	$15, %eax
	addl	%edx, %eax
.L80:
	ret
	.p2align 4,,10
.L98:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L83:
	movzbl	(%rcx), %edx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L80
	.p2align 4,,10
.L88:
	movl	%eax, %r8d
	addq	$1, %rcx
	sall	$5, %r8d
	addl	%r8d, %eax
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	testb	%dl, %dl
	jne	.L88
	ret
	.p2align 4,,10
.L82:
	movzbl	(%rcx), %edx
	movl	$-2128831035, %eax
	testb	%dl, %dl
	je	.L80
	.p2align 4,,10
.L87:
	addq	$1, %rcx
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	imull	$16777619, %eax, %eax
	testb	%dl, %dl
	jne	.L87
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC27:
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
	leaq	.LC27(%rip), %rcx
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
	leaq	.LC27(%rip), %rcx
	call	printf
	movsbl	%bl, %ecx
	addq	$32, %rsp
	popq	%rbx
	jmp	putchar
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC28:
	.ascii ">(main.c)@191:{\0"
.LC29:
	.ascii "} qXtoU32(\"0FA3423\") = \0"
.LC30:
	.ascii "0FA3423\0"
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
	leaq	.LC28(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	movq	%rcx, (%rbx)
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	__FUNCTION__.4049(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	.LC29(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	leaq	.LC30(%rip), %rcx
	call	qXtoU32
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$16, %r8d
	movl	%eax, %ecx
	call	qItoA
	movq	(%rbx), %rcx
	movq	%rax, %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	movq	(%rbx), %rcx
	leaq	.LC7(%rip), %r8
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	qOutputString
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section .rdata,"dr"
__FUNCTION__.4049:
	.ascii "main\0"
.lcomm tmr.4002,12,8
	.data
	.align 4
_qCRTaskState_.4005:
	.long	-32766
.lcomm t.3998,12,8
.lcomm tmr.3978,12,8
.lcomm tmr.3974,12,8
	.section .rdata,"dr"
	.align 8
__FUNCTION__.3969:
	.ascii "firststate\0"
.lcomm tmr.3968,12,8
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
	.align 4
.LC1:
	.long	1075838976
	.align 4
.LC16:
	.long	1056964608
	.align 4
.LC20:
	.long	1084227584
	.align 4
.LC23:
	.long	1065353216
	.align 4
.LC26:
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
	.def	qXtoU32;	.scl	2;	.type	32;	.endef
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
