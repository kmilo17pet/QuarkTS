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
	jne	.L11
	cmpb	$0, 28(%rbx)
	jne	.L12
.L6:
	leaq	tmr.3953(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L7
	leaq	secondstate(%rip), %rax
	movq	%rax, (%rbx)
.L7:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L11:
	leaq	.LC0(%rip), %rcx
	call	puts
	cmpb	$0, 28(%rbx)
	je	.L6
.L12:
	leaq	tmr.3953(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rsi), %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	jmp	.L6
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
	jne	.L19
.L14:
	leaq	tmr.3958(%rip), %rcx
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
	.p2align 4,,10
.L19:
	movq	32(%rcx), %rsi
	leaq	tmr.3958(%rip), %rcx
	movss	.LC1(%rip), %xmm1
	call	qSTimerSet
	movq	8(%rsi), %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	leaq	.LC4(%rip), %rdx
	leaq	Task1(%rip), %rcx
	call	qTaskQueueEvent
	jmp	.L14
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
	jne	.L27
.L21:
	cmpb	$0, 25(%rbx)
	jne	.L28
.L22:
	cmpb	$0, 26(%rbx)
	jne	.L29
	movl	(%rbx), %eax
	cmpl	$3, %eax
	je	.L30
.L24:
	cmpl	$2, %eax
	je	.L31
.L25:
	leaq	tmr.3962(%rip), %rcx
	movss	.LC11(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L32
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L32:
	leaq	.LC12(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	puts
	.p2align 4,,10
.L29:
	leaq	.LC8(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$3, %eax
	jne	.L24
.L30:
	leaq	.LC9(%rip), %rcx
	call	puts
	movl	(%rbx), %eax
	cmpl	$2, %eax
	jne	.L25
.L31:
	leaq	.LC10(%rip), %rcx
	call	puts
	jmp	.L25
	.p2align 4,,10
.L28:
	leaq	.LC7(%rip), %rcx
	call	puts
	jmp	.L22
	.p2align 4,,10
.L27:
	leaq	.LC6(%rip), %rcx
	call	puts
	jmp	.L21
	.seh_endproc
	.section .rdata,"dr"
.LC13:
	.ascii "led on\0"
.LC15:
	.ascii "led off\0"
.LC16:
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
	movl	_qCRTaskState_.3989(%rip), %eax
	cmpl	$134, %eax
	je	.L48
	jle	.L59
	cmpl	$143, %eax
	je	.L50
	cmpl	$146, %eax
	je	.L51
	cmpl	$135, %eax
	je	.L60
.L34:
.L33:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L59:
	cmpl	$131, %eax
	je	.L46
	cmpl	$133, %eax
	je	.L47
	cmpl	$-32766, %eax
	jne	.L33
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L39
	.p2align 4,,10
.L61:
	leaq	.LC16(%rip), %rcx
	call	puts
	leaq	tmr.3986(%rip), %rcx
	movss	.LC17(%rip), %xmm1
	call	qSTimerSet
	movl	$146, _qCRTaskState_.3989(%rip)
.L41:
	leaq	tmr.3986(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L33
.L39:
	leaq	.LC13(%rip), %rcx
	call	puts
.L37:
	leaq	tmr.3986(%rip), %rcx
	movss	.LC14(%rip), %xmm1
	call	qSTimerSet
	movl	$133, _qCRTaskState_.3989(%rip)
.L38:
	leaq	tmr.3986(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L33
	movl	$134, _qCRTaskState_.3989(%rip)
.L35:
	cmpl	%esi, %ebx
	je	.L33
	addl	$1, %esi
	addl	$1, %ebx
.L42:
	leaq	tmr.3986(%rip), %rcx
	movss	.LC14(%rip), %xmm1
	call	qSTimerSet
	leaq	.LC15(%rip), %rcx
	call	puts
	leaq	Task1(%rip), %rcx
	xorl	%edx, %edx
	call	qTaskSendEvent
	movl	$143, _qCRTaskState_.3989(%rip)
.L40:
	leaq	tmr.3986(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	jne	.L61
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L51:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L41
	.p2align 4,,10
.L47:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L38
	.p2align 4,,10
.L50:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L40
	.p2align 4,,10
.L60:
	movl	$2, %ebx
	xorl	%esi, %esi
	jmp	.L42
	.p2align 4,,10
.L46:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L37
	.p2align 4,,10
.L48:
	xorl	%esi, %esi
	movl	$1, %ebx
	jmp	.L35
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
	je	.L64
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L64:
	movq	16(%rbx), %rax
	leaq	.LC19(%rip), %rcx
	movl	(%rax), %edx
	addq	$32, %rsp
	popq	%rbx
	jmp	printf
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
	leaq	t.3982(%rip), %rcx
	movss	.LC20(%rip), %xmm1
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L67
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L67:
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
	je	.L75
	jb	.L76
	cmpb	$2, %dl
	jne	.L91
	movsbl	(%rcx), %eax
	xorl	%edx, %edx
	testb	%al, %al
	je	.L91
	.p2align 4,,10
.L78:
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
	jne	.L78
	leal	(%rdx,%rdx,8), %edx
	movl	%edx, %eax
	shrl	$11, %eax
	xorl	%eax, %edx
	movl	%edx, %eax
	sall	$15, %eax
	addl	%edx, %eax
.L73:
	ret
	.p2align 4,,10
.L91:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L76:
	movzbl	(%rcx), %edx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L73
	.p2align 4,,10
.L81:
	movl	%eax, %r8d
	addq	$1, %rcx
	sall	$5, %r8d
	addl	%r8d, %eax
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	testb	%dl, %dl
	jne	.L81
	ret
	.p2align 4,,10
.L75:
	movzbl	(%rcx), %edx
	movl	$-2128831035, %eax
	testb	%dl, %dl
	je	.L73
	.p2align 4,,10
.L80:
	addq	$1, %rcx
	xorl	%edx, %eax
	movzbl	(%rcx), %edx
	imull	$16777619, %eax, %eax
	testb	%dl, %dl
	jne	.L80
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC22:
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
	leaq	.LC22(%rip), %rcx
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
	leaq	.LC22(%rip), %rcx
	call	printf
	movsbl	%bl, %ecx
	addq	$32, %rsp
	popq	%rbx
	jmp	putchar
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC24:
	.ascii "blink\0"
.LC26:
	.ascii "TASK1\0"
.LC27:
	.ascii "TASK3\0"
.LC28:
	.ascii "TASK4\0"
.LC29:
	.ascii "TASK5\0"
.LC30:
	.ascii "TASK6\0"
.LC31:
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
	call	__main
	leaq	TimerInterruptEmulation(%rip), %r8
	leaq	TimerEmulation(%rip), %rcx
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	leaq	128(%rsp), %rbx
	leaq	112(%rsp), %rsi
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
	movss	.LC23(%rip), %xmm0
	leaq	Task3(%rip), %rsi
	call	_qInitScheduler
	leaq	.LC24(%rip), %rax
	leaq	blinktaskCallback(%rip), %rdx
	leaq	blinktask(%rip), %rcx
	xorl	%r8d, %r8d
	movl	$1, 40(%rsp)
	movl	$-32768, 32(%rsp)
	movq	%rax, 48(%rsp)
	movss	.LC25(%rip), %xmm3
	call	qSchedulerAddxTask
	leaq	.LC26(%rip), %rax
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rcx
	movss	.LC11(%rip), %xmm3
	movl	$1, 40(%rsp)
	movq	%rax, 48(%rsp)
	movl	$5, 32(%rsp)
	movl	$254, %r8d
	call	qSchedulerAddxTask
	leaq	.LC27(%rip), %r9
	leaq	Task3Callback(%rip), %rdx
	movq	%rsi, %rcx
	movl	$127, %r8d
	call	qSchedulerAddeTask
	movq	%rbx, %rdx
	movq	%rsi, %rcx
	movl	$1, %r9d
	movl	$3, %r8d
	call	qTaskLinkRBuffer
	leaq	.LC28(%rip), %r9
	leaq	Task4Callback(%rip), %rdx
	leaq	Task4(%rip), %rcx
	movl	$10, %r8d
	call	qSchedulerAddeTask
	leaq	.LC29(%rip), %r9
	leaq	Task5Callback(%rip), %rdx
	leaq	Task5(%rip), %rcx
	movl	$80, %r8d
	call	qSchedulerAddeTask
	leaq	.LC30(%rip), %r9
	leaq	Task6Callback(%rip), %rdx
	leaq	Task6(%rip), %rcx
	movl	$10, %r8d
	call	qSchedulerAddeTask
	leaq	.LC31(%rip), %rax
	leaq	224(%rsp), %r9
	leaq	SMTask(%rip), %rcx
	movss	.LC32(%rip), %xmm2
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
	call	qSchedulePrintChain
	call	qSchedulerRun
	xorl	%eax, %eax
	addq	$472, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
.lcomm tmr.3986,12,8
	.data
	.align 4
_qCRTaskState_.3989:
	.long	-32766
.lcomm t.3982,12,8
.lcomm tmr.3962,12,8
.lcomm tmr.3958,12,8
.lcomm tmr.3953,12,8
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
.LC14:
	.long	1065353216
	.align 4
.LC17:
	.long	1073741824
	.align 4
.LC20:
	.long	1084227584
	.align 4
.LC23:
	.long	1008981770
	.align 4
.LC25:
	.long	1028443341
	.align 4
.LC32:
	.long	1036831949
	.ident	"GCC: (GNU) 7.3.0"
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	qSchedulerSysTick;	.scl	2;	.type	32;	.endef
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddxTask;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddeTask;	.scl	2;	.type	32;	.endef
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddSMTask;	.scl	2;	.type	32;	.endef
	.def	qSchedulePrintChain;	.scl	2;	.type	32;	.endef
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
