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
	leaq	tmr.4073(%rip), %rcx
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
	leaq	tmr.4073(%rip), %rcx
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
	leaq	tmr.4078(%rip), %rcx
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
	leaq	tmr.4078(%rip), %rcx
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
	jne	.L28
.L22:
	cmpb	$0, 25(%rbx)
	jne	.L29
.L23:
	cmpb	$0, 26(%rbx)
	jne	.L30
	movl	(%rbx), %eax
	cmpl	$3, %eax
	je	.L31
.L25:
	cmpl	$2, %eax
	je	.L32
.L26:
	leaq	tmr.4082(%rip), %rcx
	movss	.LC11(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L33
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L33:
	leaq	.LC12(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	puts
	.p2align 4,,10
.L30:
	leaq	.LC8(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$3, %eax
	jne	.L25
.L31:
	leaq	.LC9(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$2, %eax
	jne	.L26
.L32:
	leaq	.LC10(%rip), %rcx
	call	puts
	jmp	.L26
	.p2align 4,,10
.L29:
	leaq	.LC7(%rip), %rcx
	call	puts
	jmp	.L23
	.p2align 4,,10
.L28:
	leaq	.LC6(%rip), %rcx
	call	puts
	jmp	.L22
	.seh_endproc
	.p2align 4,,15
	.globl	IdleTaskCallback
	.def	IdleTaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	IdleTaskCallback
IdleTaskCallback:
	.seh_endprologue
	leaq	t.4102(%rip), %rcx
	movss	.LC13(%rip), %xmm1
	jmp	qSTimerFreeRun
	.seh_endproc
	.section .rdata,"dr"
.LC14:
	.ascii ">>>>>>>>>>>>>>led on\0"
.LC16:
	.ascii ">>>>>>>>>>>>>>led off\0"
.LC17:
	.ascii ">>>>>>>>>>>>>>led fuck\0"
	.text
	.p2align 4,,15
	.globl	blinktaskCallback
	.def	blinktaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	blinktaskCallback
blinktaskCallback:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	_qCRTaskState_.4109(%rip), %eax
	cmpl	$141, %eax
	jg	.L37
	cmpl	$140, %eax
	jge	.L38
	cmpl	$137, %eax
	je	.L39
	cmpl	$139, %eax
	je	.L40
	cmpl	$-32766, %eax
	jne	.L35
	leaq	.LC14(%rip), %rcx
	call	puts
.L39:
	leaq	tmr.4106(%rip), %rcx
	movss	.LC15(%rip), %xmm1
	call	qSTimerSet
	movl	$139, _qCRTaskState_.4109(%rip)
.L40:
	leaq	tmr.4106(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L35
	movl	$140, _qCRTaskState_.4109(%rip)
.L38:
	leaq	tmr.4106(%rip), %rcx
	movss	.LC15(%rip), %xmm1
	call	qSTimerSet
	leaq	.LC16(%rip), %rcx
	call	puts
	leaq	Task1(%rip), %rcx
	xorl	%edx, %edx
	call	qTaskSendEvent
	movl	$149, _qCRTaskState_.4109(%rip)
.L42:
	leaq	tmr.4106(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	jne	.L65
.L36:
.L35:
	addq	$40, %rsp
	ret
	.p2align 4,,10
.L37:
	cmpl	$149, %eax
	je	.L42
	cmpl	$152, %eax
	jne	.L35
	leaq	tmr.4106(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L35
	movl	$-32766, _qCRTaskState_.4109(%rip)
.L66:
	addq	$40, %rsp
	ret
	.p2align 4,,10
.L65:
	leaq	.LC17(%rip), %rcx
	call	puts
	leaq	tmr.4106(%rip), %rcx
	movss	.LC11(%rip), %xmm1
	call	qSTimerSet
	leaq	tmr.4106(%rip), %rcx
	movl	$152, _qCRTaskState_.4109(%rip)
	call	qSTimerExpired
	testb	%al, %al
	je	.L35
	movl	$-32766, _qCRTaskState_.4109(%rip)
	jmp	.L66
	.seh_endproc
	.section .rdata,"dr"
.LC18:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
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
	je	.L69
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L69:
	movq	16(%rbx), %rax
	leaq	.LC19(%rip), %rcx
	movl	(%rax), %edx
	addq	$32, %rsp
	popq	%rbx
	jmp	printf
	.seh_endproc
	.p2align 4,,15
	.globl	datacapture
	.def	datacapture;	.scl	2;	.type	32;	.endef
	.seh_proc	datacapture
datacapture:
	.seh_endprologue
	ret
	.seh_endproc
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
	.p2align 4,,15
	.globl	qStringHash
	.def	qStringHash;	.scl	2;	.type	32;	.endef
	.seh_proc	qStringHash
qStringHash:
	.seh_endprologue
	cmpb	$1, %dl
	je	.L77
	jb	.L78
	cmpb	$2, %dl
	je	.L79
	cmpb	$3, %dl
	jne	.L99
	movsbl	(%rcx), %edx
	xorl	%eax, %eax
	testb	%dl, %dl
	je	.L75
	.p2align 4,,10
.L81:
	imull	$65599, %eax, %eax
	addq	$1, %rcx
	addl	%edx, %eax
	movsbl	(%rcx), %edx
	testb	%dl, %dl
	jne	.L81
.L75:
	ret
	.p2align 4,,10
.L79:
	movzbl	(%rcx), %eax
	xorl	%r8d, %r8d
	testb	%al, %al
	je	.L99
	.p2align 4,,10
.L82:
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
	jne	.L82
	leal	(%r8,%r8,8), %edx
	movl	%edx, %eax
	shrl	$11, %eax
	xorl	%eax, %edx
	movl	%edx, %eax
	sall	$15, %eax
	addl	%edx, %eax
	ret
	.p2align 4,,10
.L99:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L78:
	movzbl	(%rcx), %edx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L75
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
	jmp	.L75
	.p2align 4,,10
.L77:
	movzbl	(%rcx), %edx
	movl	$-2128831035, %eax
	testb	%dl, %dl
	je	.L75
	.p2align 4,,10
.L84:
	addq	$1, %rcx
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	imull	$16777619, %eax, %eax
	testb	%dl, %dl
	jne	.L84
	jmp	.L75
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC20:
	.ascii "yy=\0"
.LC21:
	.ascii "[main.c:182] \0"
.LC22:
	.ascii "test\0"
.LC23:
	.ascii "\0"
.LC24:
	.ascii "[main.c:183] \0"
.LC25:
	.ascii "48765=\0"
.LC26:
	.ascii "[main.c:184] \0"
.LC27:
	.ascii "[main.c:185] \0"
.LC28:
	.ascii "[main.c:186] \0"
.LC29:
	.ascii "[main.c:187] \0"
.LC30:
	.ascii "0=\0"
.LC31:
	.ascii "[main.c:188] \0"
.LC32:
	.ascii "0b01001101=\0"
.LC33:
	.ascii "[main.c:189] \0"
.LC35:
	.ascii "3.1416=\0"
.LC36:
	.ascii "[main.c:191] \0"
.LC37:
	.ascii "aloh\0"
.LC38:
	.ascii "qStringHash(\"aloh\", 0)=\0"
.LC39:
	.ascii "[main.c:192] \0"
.LC40:
	.ascii "hola\0"
.LC41:
	.ascii "qStringHash(\"hola\", 0)=\0"
.LC42:
	.ascii "[main.c:193] \0"
.LC43:
	.ascii "hannah\0"
.LC44:
	.ascii "qStringHash(\"hannah\", 0)=\0"
.LC45:
	.ascii "[main.c:194] \0"
.LC47:
	.ascii "blink\0"
.LC49:
	.ascii "TASK1\0"
.LC50:
	.ascii "TASK3\0"
.LC51:
	.ascii "TASK4\0"
.LC52:
	.ascii "TASK5\0"
.LC53:
	.ascii "TASK6\0"
.LC54:
	.ascii "smtask\0"
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
	subq	$472, %rsp
	.seh_stackalloc	472
	.seh_endprologue
	leaq	putcharfcn(%rip), %rbx
	call	__main
	movq	.refptr.__qDebugOutputFcn(%rip), %rax
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	$-128, %ecx
	leaq	112(%rsp), %rsi
	movq	%rbx, (%rax)
	leaq	128(%rsp), %rbx
	call	qItoA
	leaq	.LC20(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC21(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC22(%rip), %r9
	leaq	.LC23(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC24(%rip), %rcx
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	$48765, %ecx
	call	qUtoA
	leaq	.LC25(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC26(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$2, %r8d
	movl	$-128, %ecx
	call	qItoA
	leaq	.LC20(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC27(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$16, %r8d
	movl	$-128, %ecx
	call	qUtoA
	leaq	.LC20(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC28(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$2, %r8d
	movl	$-128, %ecx
	call	qUtoA
	leaq	.LC20(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC29(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	xorl	%ecx, %ecx
	movl	$16, %r8d
	call	qUtoA
	leaq	.LC30(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC31(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$2, %r8d
	movl	$77, %ecx
	call	qItoA
	leaq	.LC33(%rip), %rcx
	leaq	.LC32(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movss	.LC34(%rip), %xmm0
	movl	$10, %r8d
	call	qFtoA
	leaq	.LC35(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC36(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC37(%rip), %rcx
	xorl	%edx, %edx
	call	qStringHash
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	%eax, %ecx
	call	qUtoA
	leaq	.LC38(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC39(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC40(%rip), %rcx
	xorl	%edx, %edx
	call	qStringHash
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	%eax, %ecx
	call	qUtoA
	leaq	.LC41(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC42(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC43(%rip), %rcx
	xorl	%edx, %edx
	call	qStringHash
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	%eax, %ecx
	call	qUtoA
	leaq	.LC44(%rip), %r8
	leaq	__FUNCTION__.4145(%rip), %rdx
	leaq	.LC45(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	TimerInterruptEmulation(%rip), %r8
	leaq	TimerEmulation(%rip), %rcx
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	pthread_create
	xorl	%eax, %eax
	leaq	144(%rsp), %rcx
	movl	$4, %edx
	movw	%ax, 126(%rsp)
	leaq	118(%rsp), %rax
	movw	%dx, 144(%rsp)
	movl	$40, %edx
	movq	$0, 176(%rsp)
	movq	$0, 184(%rsp)
	movq	%rax, 152(%rsp)
	leaq	176(%rsp), %rax
	movq	$0, 192(%rsp)
	movq	$0, 200(%rsp)
	movq	$0, 208(%rsp)
	movq	$0, 118(%rsp)
	movb	$10, 146(%rsp)
	movq	%rax, 160(%rsp)
	movl	$5, 108(%rsp)
	movl	$6, 112(%rsp)
	call	qMemoryAlloc
	movl	$10, %r9d
	movl	$4, %r8d
	movq	%rax, %rdx
	movq	%rbx, %rcx
	call	qRBufferInit
	leaq	108(%rsp), %rdx
	movq	%rbx, %rcx
	call	qRBufferPush
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	call	qRBufferPush
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	movl	$1, 112(%rsp)
	call	qRBufferPush
	movq	%rbx, %rcx
	movq	%rsi, %rdx
	movl	$-7, 112(%rsp)
	call	qRBufferPush
	leaq	304(%rsp), %r8
	leaq	IdleTaskCallback(%rip), %rdx
	movl	$10, %r9d
	movss	.LC46(%rip), %xmm0
	leaq	Task3(%rip), %rsi
	call	_qInitScheduler
	leaq	.LC47(%rip), %rax
	leaq	blinktaskCallback(%rip), %rdx
	leaq	blinktask(%rip), %rcx
	xorl	%r8d, %r8d
	movl	$1, 40(%rsp)
	movl	$-32768, 32(%rsp)
	movq	%rax, 48(%rsp)
	movss	.LC48(%rip), %xmm3
	call	qSchedulerAddxTask
	leaq	.LC49(%rip), %rax
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rcx
	movss	.LC11(%rip), %xmm3
	movl	$1, 40(%rsp)
	movq	%rax, 48(%rsp)
	movl	$5, 32(%rsp)
	movl	$254, %r8d
	call	qSchedulerAddxTask
	leaq	.LC50(%rip), %r9
	leaq	Task3Callback(%rip), %rdx
	movq	%rsi, %rcx
	movl	$127, %r8d
	call	qSchedulerAddeTask
	movq	%rbx, %rdx
	movq	%rsi, %rcx
	movl	$1, %r9d
	movl	$3, %r8d
	call	qTaskLinkRBuffer
	leaq	.LC51(%rip), %r9
	leaq	Task4Callback(%rip), %rdx
	leaq	Task4(%rip), %rcx
	movl	$10, %r8d
	call	qSchedulerAddeTask
	leaq	.LC52(%rip), %r9
	leaq	Task5Callback(%rip), %rdx
	leaq	Task5(%rip), %rcx
	movl	$80, %r8d
	call	qSchedulerAddeTask
	leaq	.LC53(%rip), %r9
	leaq	Task6Callback(%rip), %rdx
	leaq	Task6(%rip), %rcx
	movl	$10, %r8d
	call	qSchedulerAddeTask
	leaq	.LC54(%rip), %rax
	leaq	224(%rsp), %r9
	leaq	SMTask(%rip), %rcx
	movss	.LC55(%rip), %xmm2
	movl	$254, %edx
	movq	%rax, 80(%rsp)
	leaq	firststate(%rip), %rax
	movl	$1, 72(%rsp)
	movq	$0, 64(%rsp)
	movq	$0, 56(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 40(%rsp)
	movq	%rax, 32(%rsp)
	call	qSchedulerAddSMTask
	call	qSchedulerRun
	xorl	%eax, %eax
	addq	$472, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
__FUNCTION__.4145:
	.ascii "main\0"
.lcomm tmr.4106,12,8
	.data
	.align 4
_qCRTaskState_.4109:
	.long	-32766
.lcomm t.4102,12,8
.lcomm tmr.4082,12,8
.lcomm tmr.4078,12,8
.lcomm tmr.4073,12,8
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
.LC13:
	.long	1084227584
	.align 4
.LC15:
	.long	1065353216
	.align 4
.LC34:
	.long	1078530041
	.align 4
.LC46:
	.long	1008981770
	.align 4
.LC48:
	.long	1028443341
	.align 4
.LC55:
	.long	1036831949
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
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.def	__qtrace_func;	.scl	2;	.type	32;	.endef
	.def	qUtoA;	.scl	2;	.type	32;	.endef
	.def	qFtoA;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddxTask;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddeTask;	.scl	2;	.type	32;	.endef
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddSMTask;	.scl	2;	.type	32;	.endef
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
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
