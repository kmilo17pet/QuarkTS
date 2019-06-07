	.file	"test.c"
	.text
	.globl	GetTickCountMs
	.def	GetTickCountMs;	.scl	2;	.type	32;	.endef
	.seh_proc	GetTickCountMs
GetTickCountMs:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movl	$4, %ecx
	leaq	32(%rsp), %rdx
	call	clock_gettime
	movq	40(%rsp), %rax
	movl	$1000000, %ecx
	cqto
	idivq	%rcx
	imull	$1000, 32(%rsp), %edx
	addl	%edx, %eax
	addq	$56, %rsp
	ret
	.seh_endproc
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
.L3:
	xorl	%edx, %edx
	movq	%rbx, %rcx
	call	nanosleep
	jmp	.L3
	.seh_endproc
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
	cmpb	$0, 20(%rsi)
	je	.L7
	leaq	.LC0(%rip), %rcx
	call	puts
.L7:
	cmpb	$0, 28(%rbx)
	je	.L8
	leaq	tmr.4254(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	(%rsi), %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
.L8:
	leaq	tmr.4254(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L9
	leaq	secondstate(%rip), %rax
	movq	%rax, (%rbx)
.L9:
	movl	$-32768, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC3:
	.ascii "[%s] second\15\12\0"
.LC4:
	.ascii "HELLO\0"
	.text
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
	je	.L14
	movq	32(%rcx), %rsi
	leaq	tmr.4259(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	(%rsi), %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	leaq	.LC4(%rip), %rdx
	leaq	Task1(%rip), %rcx
	call	qTaskQueueEvent
.L14:
	leaq	tmr.4259(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L15
	leaq	firststate(%rip), %rax
	movq	%rax, (%rbx)
.L15:
	movl	$-32768, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC5:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
.LC6:
	.ascii "FirstCall\0"
.LC7:
	.ascii "FirstIteration\0"
.LC8:
	.ascii "LastIteration\0"
.LC9:
	.ascii "TASK1 BY ASYNC EVENT\0"
.LC10:
	.ascii "TASK1 BY QUEUE EXTRACTION\0"
.LC12:
	.ascii "Timer expired\0"
	.text
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
	movq	8(%rbx), %r8
	movq	(%rbx), %rdx
	leaq	.LC5(%rip), %rcx
	movl	%eax, %r9d
	call	printf
	cmpb	$0, 20(%rbx)
	je	.L20
	leaq	.LC6(%rip), %rcx
	call	puts
.L20:
	cmpb	$0, 21(%rbx)
	je	.L21
	leaq	.LC7(%rip), %rcx
	call	puts
.L21:
	cmpb	$0, 22(%rbx)
	je	.L22
	leaq	.LC8(%rip), %rcx
	call	puts
.L22:
	cmpl	$3, 16(%rbx)
	jne	.L23
	leaq	.LC9(%rip), %rcx
	call	puts
.L23:
	cmpl	$2, 16(%rbx)
	jne	.L24
	leaq	.LC10(%rip), %rcx
	call	puts
.L24:
	leaq	tmr.4263(%rip), %rcx
	movss	.LC11(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	je	.L19
	leaq	.LC12(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	puts
.L19:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC13:
	.ascii "CR:A\0"
.LC14:
	.ascii "CR:B\0"
.LC15:
	.ascii "CR:C\0"
.LC16:
	.ascii "CR:D\0"
.LC17:
	.ascii "CR:E\0"
.LC19:
	.ascii "count=\0"
.LC20:
	.ascii "[src/test/test.c:162] \0"
.LC21:
	.ascii "CR:F\0"
.LC22:
	.ascii "CR:G\0"
.LC23:
	.ascii "CR:H\0"
.LC25:
	.ascii "CR:I\0"
.LC26:
	.ascii "CR:J\0"
	.text
	.globl	blinktaskCallback
	.def	blinktaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	blinktaskCallback
blinktaskCallback:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movl	_qCRTaskState_.4292(%rip), %eax
	cmpl	$158, %eax
	je	.L28
	jg	.L29
	cmpl	$-32766, %eax
	jne	.L26
	leaq	.LC13(%rip), %rcx
	call	puts
	leaq	.LC14(%rip), %rcx
	call	puts
	leaq	.LC15(%rip), %rcx
	call	puts
	movl	$158, state.4289(%rip)
	jmp	.L28
.L29:
	cmpl	$161, %eax
	je	.L31
	cmpl	$167, %eax
	je	.L32
	jmp	.L26
.L28:
	leaq	.LC16(%rip), %rcx
	call	puts
	leaq	.LC17(%rip), %rcx
	call	puts
	call	qSchedulerGetTick
	movl	$161, _qCRTaskState_.4292(%rip)
	movl	%eax, 4+_qCRTaskState_.4292(%rip)
.L31:
	leaq	_qCRTaskState_.4292(%rip), %rcx
	movss	.LC18(%rip), %xmm1
	call	__qCRDelay_Reached
	testb	%al, %al
	je	.L26
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	count.4291(%rip), %ecx
	movl	$10, %r8d
	call	qItoA
	leaq	.LC19(%rip), %r8
	leaq	__FUNCTION__.4297(%rip), %rdx
	leaq	.LC20(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC21(%rip), %rcx
	call	puts
	leaq	.LC22(%rip), %rcx
	call	puts
	movl	count.4291(%rip), %eax
	incl	%eax
	cmpl	$10, %eax
	movl	%eax, count.4291(%rip)
	jle	.L34
	movl	state.4289(%rip), %eax
	movl	%eax, _qCRTaskState_.4292(%rip)
	jmp	.L26
.L34:
	leaq	.LC23(%rip), %rcx
	call	puts
	movl	$167, _qCRTaskState_.4292(%rip)
.L32:
	leaq	tmr.4288(%rip), %rcx
	movss	.LC24(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	je	.L26
	leaq	.LC25(%rip), %rcx
	call	puts
	leaq	.LC26(%rip), %rcx
	call	puts
	movl	$-32766, _qCRTaskState_.4292(%rip)
.L27:
.L26:
	addq	$56, %rsp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC27:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
.LC28:
	.ascii "ring extracted data %d\15\12\0"
	.text
	.globl	Task3Callback
	.def	Task3Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task3Callback
Task3Callback:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	8(%rcx), %r8
	movq	(%rcx), %rdx
	movq	%rcx, %rbx
	leaq	.LC27(%rip), %rcx
	call	printf
	cmpl	$4, 16(%rbx)
	jne	.L48
	movq	8(%rbx), %rax
	leaq	.LC28(%rip), %rcx
	movl	(%rax), %edx
	addq	$32, %rsp
	popq	%rbx
	jmp	printf
.L48:
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.globl	IdleTaskCallback
	.def	IdleTaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	IdleTaskCallback
IdleTaskCallback:
	.seh_endprologue
	ret
	.seh_endproc
	.globl	datacapture
	.def	datacapture;	.scl	2;	.type	32;	.endef
	.seh_proc	datacapture
datacapture:
	.seh_endprologue
	ret
	.seh_endproc
	.globl	Task2Callback
	.def	Task2Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task2Callback
Task2Callback:
	.seh_endprologue
	movq	8(%rcx), %r8
	movq	(%rcx), %rdx
	leaq	.LC27(%rip), %rcx
	jmp	printf
	.seh_endproc
	.globl	Task4Callback
	.def	Task4Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task4Callback
Task4Callback:
	.seh_endprologue
	jmp	Task2Callback
	.seh_endproc
	.globl	Task5Callback
	.def	Task5Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task5Callback
Task5Callback:
	.seh_endprologue
	jmp	Task2Callback
	.seh_endproc
	.globl	Task6Callback
	.def	Task6Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task6Callback
Task6Callback:
	.seh_endprologue
	jmp	Task2Callback
	.seh_endproc
	.globl	qStringHash
	.def	qStringHash;	.scl	2;	.type	32;	.endef
	.seh_proc	qStringHash
qStringHash:
	.seh_endprologue
	cmpb	$1, %dl
	je	.L68
	jb	.L67
	cmpb	$2, %dl
	je	.L69
	cmpb	$3, %dl
	jne	.L72
	xorl	%eax, %eax
	jmp	.L61
.L69:
	xorl	%eax, %eax
.L60:
	movsbl	(%rcx), %edx
	testb	%dl, %dl
	je	.L73
	imull	$1025, %eax, %eax
	incq	%rcx
	addl	%edx, %eax
	movl	%eax, %edx
	shrl	$6, %edx
	xorl	%edx, %eax
	jmp	.L60
.L73:
	leal	(%rax,%rax,8), %eax
	movl	%eax, %edx
	shrl	$11, %edx
	xorl	%edx, %eax
	imull	$32769, %eax, %eax
	jmp	.L56
.L67:
	movl	$5381, %eax
.L59:
	movzbl	(%rcx), %edx
	testb	%dl, %dl
	je	.L56
	imull	$33, %eax, %eax
	incq	%rcx
	xorl	%edx, %eax
	jmp	.L59
.L68:
	movl	$-2128831035, %eax
.L58:
	movzbl	(%rcx), %edx
	testb	%dl, %dl
	je	.L56
	xorl	%edx, %eax
	incq	%rcx
	imull	$16777619, %eax, %eax
	jmp	.L58
.L61:
	movsbl	(%rcx), %edx
	testb	%dl, %dl
	je	.L56
	imull	$65599, %eax, %eax
	incq	%rcx
	addl	%edx, %eax
	jmp	.L61
.L72:
	xorl	%eax, %eax
.L56:
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC29:
	.ascii "yy=\0"
.LC30:
	.ascii "[src/test/test.c:215] \0"
.LC31:
	.ascii "test\0"
.LC32:
	.ascii "\0"
.LC33:
	.ascii "[src/test/test.c:216] \0"
.LC34:
	.ascii "48765=\0"
.LC35:
	.ascii "[src/test/test.c:217] \0"
.LC36:
	.ascii "yy=0b\0"
.LC37:
	.ascii "[src/test/test.c:218] \0"
.LC38:
	.ascii "yy=0x\0"
.LC39:
	.ascii "[src/test/test.c:219] \0"
.LC40:
	.ascii "[src/test/test.c:220] \0"
.LC41:
	.ascii "0=0x\0"
.LC42:
	.ascii "[src/test/test.c:221] \0"
.LC43:
	.ascii "0b01001101=0b\0"
.LC44:
	.ascii "[src/test/test.c:222] \0"
.LC45:
	.ascii "Var=\0"
.LC46:
	.ascii "[src/test/test.c:223] \0"
.LC48:
	.ascii "3.1416=\0"
.LC49:
	.ascii "[src/test/test.c:224] \0"
.LC50:
	.ascii "aloh\0"
.LC51:
	.ascii "qStringHash(\"aloh\", 0)=\0"
.LC52:
	.ascii "[src/test/test.c:225] \0"
.LC53:
	.ascii "hola\0"
.LC54:
	.ascii "qStringHash(\"hola\", 0)=\0"
.LC55:
	.ascii "[src/test/test.c:226] \0"
.LC56:
	.ascii "hannah\0"
.LC57:
	.ascii "qStringHash(\"hannah\", 0)=\0"
.LC58:
	.ascii "[src/test/test.c:227] \0"
.LC59:
	.ascii "[src/test/test.c:228] \0"
.LC61:
	.ascii "blink\0"
.LC63:
	.ascii "TASK1\0"
.LC64:
	.ascii "TASK3\0"
.LC65:
	.ascii "some message\0"
.LC66:
	.ascii "\"some message\"=\0"
.LC67:
	.ascii "TASK4\0"
.LC68:
	.ascii "TASK5\0"
.LC69:
	.ascii "TASK6\0"
.LC70:
	.ascii "smtask\0"
	.section	.text.startup,"x"
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$368, %rsp
	.seh_stackalloc	368
	.seh_endprologue
	leaq	INPUTS(%rip), %rbx
	leaq	putcharfcn(%rip), %rdi
	call	__main
	movq	.refptr.__qDebugOutputFcn(%rip), %rax
	leaq	__qReg_32Bits(%rip), %rdx
	movq	%rbx, %rcx
	movl	$10, %r8d
	movl	$-128, 104(%rsp)
	movl	$5, 108(%rsp)
	movl	$6, 112(%rsp)
	leaq	112(%rsp), %rsi
	movq	%rdi, (%rax)
	leaq	168(%rsp), %rdi
	call	qEdgeCheck_Initialize
	leaq	PORTA(%rip), %r8
	leaq	buton1(%rip), %rdx
	xorl	%r9d, %r9d
	movq	%rbx, %rcx
	call	qEdgeCheck_InsertNode
	leaq	PORTA(%rip), %r8
	leaq	buton2(%rip), %rdx
	movq	%rbx, %rcx
	movl	$1, %r9d
	call	qEdgeCheck_InsertNode
	leaq	PORTA(%rip), %r8
	leaq	sensor1(%rip), %rdx
	movq	%rbx, %rcx
	movl	$2, %r9d
	call	qEdgeCheck_InsertNode
	leaq	PORTA(%rip), %r8
	leaq	sensor2(%rip), %rdx
	movq	%rbx, %rcx
	movl	$3, %r9d
	leaq	128(%rsp), %rbx
	call	qEdgeCheck_InsertNode
	leaq	TimerInterruptEmulation(%rip), %r8
	leaq	TimerEmulation(%rip), %rcx
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	call	pthread_create
	movl	104(%rsp), %ecx
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	call	qItoA
	leaq	.LC29(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC30(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC31(%rip), %r9
	leaq	.LC32(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC33(%rip), %rcx
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	$48765, %ecx
	call	qUtoA
	leaq	.LC34(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC35(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movl	104(%rsp), %ecx
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$2, %r8d
	call	qItoA
	leaq	.LC36(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC37(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movl	104(%rsp), %ecx
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$16, %r8d
	call	qUtoA
	leaq	.LC38(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC39(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movl	104(%rsp), %ecx
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$2, %r8d
	call	qUtoA
	leaq	.LC36(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC40(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	xorl	%ecx, %ecx
	movl	$16, %r8d
	call	qUtoA
	leaq	.LC41(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC42(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$2, %r8d
	movl	$77, %ecx
	call	qItoA
	leaq	.LC43(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC44(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	104(%rsp), %rax
	leaq	.LC46(%rip), %rcx
	leaq	.LC45(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	xorl	%r9d, %r9d
	movl	$4, 40(%rsp)
	movq	%rax, 32(%rsp)
	call	__qtrace_func
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movss	.LC47(%rip), %xmm0
	movl	$10, %r8d
	call	qFtoA
	leaq	.LC48(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC49(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC50(%rip), %rcx
	xorl	%edx, %edx
	call	qStringHash
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	%eax, %ecx
	call	qUtoA
	leaq	.LC51(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC52(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC53(%rip), %rcx
	xorl	%edx, %edx
	call	qStringHash
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	%eax, %ecx
	call	qUtoA
	leaq	.LC54(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC55(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC56(%rip), %rcx
	xorl	%edx, %edx
	call	qStringHash
	movq	.refptr.qDebugTrace_Buffer(%rip), %rdx
	movl	$10, %r8d
	movl	%eax, %ecx
	call	qUtoA
	leaq	.LC57(%rip), %r8
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC58(%rip), %rcx
	movq	%rax, %r9
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC32(%rip), %r9
	leaq	__FUNCTION__.4330(%rip), %rdx
	leaq	.LC59(%rip), %rcx
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	movq	%r9, %r8
	call	__qtrace_func
	xorl	%eax, %eax
	movl	$10, %ecx
	movl	$40, %edx
	rep stosl
	leaq	118(%rsp), %rdi
	movl	$10, %ecx
	movw	$4, 160(%rsp)
	movb	$10, 162(%rsp)
	rep stosb
	leaq	118(%rsp), %rax
	leaq	144(%rsp), %rcx
	movq	%rax, 144(%rsp)
	leaq	168(%rsp), %rax
	movq	%rax, 152(%rsp)
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
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	movl	$-7, 112(%rsp)
	call	qRBufferPush
	leaq	208(%rsp), %r9
	leaq	IdleTaskCallback(%rip), %r8
	leaq	GetTickCountMs(%rip), %rcx
	movss	.LC60(%rip), %xmm1
	movl	$10, 32(%rsp)
	call	_qInitScheduler
	leaq	.LC61(%rip), %rax
	leaq	blinktaskCallback(%rip), %rdx
	leaq	blinktask(%rip), %rcx
	xorl	%r8d, %r8d
	movl	$1, 40(%rsp)
	movl	$-32768, 32(%rsp)
	movq	%rax, 48(%rsp)
	movss	.LC62(%rip), %xmm3
	call	qSchedulerAdd_Task
	leaq	.LC63(%rip), %rax
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rcx
	movss	.LC11(%rip), %xmm3
	leaq	Task3(%rip), %rsi
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$254, %r8d
	movl	$5, 32(%rsp)
	call	qSchedulerAdd_Task
	leaq	.LC64(%rip), %r9
	leaq	Task3Callback(%rip), %rdx
	movq	%rsi, %rcx
	movl	$127, %r8d
	call	qSchedulerAdd_EventTask
	movq	%rbx, %rdx
	movq	%rsi, %rcx
	movl	$1, %r9d
	movl	$3, %r8d
	call	qTaskLinkRBuffer
	leaq	.LC65(%rip), %r9
	leaq	.LC66(%rip), %r8
	leaq	.LC32(%rip), %rcx
	xorl	%edx, %edx
	movl	$0, 40(%rsp)
	movq	$0, 32(%rsp)
	call	__qtrace_func
	leaq	.LC67(%rip), %r9
	leaq	Task4Callback(%rip), %rdx
	leaq	Task4(%rip), %rcx
	movl	$10, %r8d
	call	qSchedulerAdd_EventTask
	leaq	.LC68(%rip), %r9
	leaq	Task5Callback(%rip), %rdx
	leaq	Task5(%rip), %rcx
	movl	$80, %r8d
	call	qSchedulerAdd_EventTask
	leaq	.LC69(%rip), %r9
	leaq	Task6Callback(%rip), %rdx
	leaq	Task6(%rip), %rcx
	movl	$10, %r8d
	call	qSchedulerAdd_EventTask
	leaq	.LC70(%rip), %rax
	leaq	statemachine(%rip), %r9
	leaq	SMTask(%rip), %rcx
	movss	.LC18(%rip), %xmm2
	movl	$254, %edx
	movq	%rax, 80(%rsp)
	leaq	firststate(%rip), %rax
	movl	$1, 72(%rsp)
	movq	$0, 64(%rsp)
	movq	$0, 56(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 40(%rsp)
	movq	%rax, 32(%rsp)
	call	qSchedulerAdd_StateMachineTask
	call	qSchedulerRun
	xorl	%eax, %eax
	addq	$368, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.section .rdata,"dr"
__FUNCTION__.4330:
	.ascii "main\0"
.lcomm tmr.4288,12,8
	.align 16
__FUNCTION__.4297:
	.ascii "blinktaskCallback\0"
.lcomm count.4291,4,4
.lcomm state.4289,4,4
	.data
	.align 8
_qCRTaskState_.4292:
	.long	-32766
	.space 4
.lcomm tmr.4263,12,8
.lcomm tmr.4259,12,8
.lcomm tmr.4254,12,8
	.comm	SMTask2, 80, 5
	.comm	SMTask, 80, 5
	.comm	blinktask, 80, 5
	.comm	TaskTestST, 80, 5
	.comm	Task6, 80, 5
	.comm	Task5, 80, 5
	.comm	Task4, 80, 5
	.comm	Task3, 80, 5
	.comm	Task2, 80, 5
	.comm	Task1, 80, 5
	.comm	TimerEmulation, 8, 3
	.comm	statemachine, 72, 5
	.comm	sensor2, 24, 4
	.comm	buton2, 24, 4
	.comm	sensor1, 24, 4
	.comm	buton1, 24, 4
	.comm	INPUTS, 32, 5
	.globl	PORTA
	.align 4
PORTA:
	.long	10
	.section .rdata,"dr"
	.align 4
.LC1:
	.long	1075838976
	.align 4
.LC11:
	.long	1056964608
	.align 4
.LC18:
	.long	1036831949
	.align 4
.LC24:
	.long	1073741824
	.align 4
.LC47:
	.long	1078530041
	.align 4
.LC60:
	.long	981668463
	.align 4
.LC62:
	.long	1028443341
	.ident	"GCC: (GNU) 7.3.0"
	.def	clock_gettime;	.scl	2;	.type	32;	.endef
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.def	qSchedulerGetTick;	.scl	2;	.type	32;	.endef
	.def	__qCRDelay_Reached;	.scl	2;	.type	32;	.endef
	.def	qItoA;	.scl	2;	.type	32;	.endef
	.def	__qtrace_func;	.scl	2;	.type	32;	.endef
	.def	__qReg_32Bits;	.scl	2;	.type	32;	.endef
	.def	qEdgeCheck_Initialize;	.scl	2;	.type	32;	.endef
	.def	qEdgeCheck_InsertNode;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	qUtoA;	.scl	2;	.type	32;	.endef
	.def	qFtoA;	.scl	2;	.type	32;	.endef
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAdd_Task;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAdd_EventTask;	.scl	2;	.type	32;	.endef
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAdd_StateMachineTask;	.scl	2;	.type	32;	.endef
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr.__qReg_32Bits, "dr"
	.globl	.refptr.__qReg_32Bits
	.linkonce	discard
.refptr.__qReg_32Bits:
	.quad	__qReg_32Bits
	.section	.rdata$.refptr.__qDebugOutputFcn, "dr"
	.globl	.refptr.__qDebugOutputFcn
	.linkonce	discard
.refptr.__qDebugOutputFcn:
	.quad	__qDebugOutputFcn
	.section	.rdata$.refptr.qDebugTrace_Buffer, "dr"
	.globl	.refptr.qDebugTrace_Buffer
	.linkonce	discard
.refptr.qDebugTrace_Buffer:
	.quad	qDebugTrace_Buffer
