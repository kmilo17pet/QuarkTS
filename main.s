	.file	"main.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	TimerEmulation, 8, 3
	.globl	TimerInterruptEmulation
	.def	TimerInterruptEmulation;	.scl	2;	.type	32;	.endef
	.seh_proc	TimerInterruptEmulation
TimerInterruptEmulation:
.LFB7:
	.file 1 "main.c"
	.loc 1 11 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	.loc 1 12 0
	movq	$0, -16(%rbp)
	movq	$10000000, -8(%rbp)
.L2:
	.loc 1 14 0 discriminator 1
	leaq	-16(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	nanosleep
	.loc 1 15 0 discriminator 1
	movq	.refptr._qSysTick_Epochs_(%rip), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	.refptr._qSysTick_Epochs_(%rip), %rax
	movl	%edx, (%rax)
	.loc 1 16 0 discriminator 1
	jmp	.L2
	.cfi_endproc
.LFE7:
	.seh_endproc
	.comm	Task1, 72, 6
	.comm	Task2, 72, 6
	.comm	Task3, 72, 6
	.comm	Task4, 72, 6
	.comm	Task5, 72, 6
	.comm	Task6, 72, 6
	.comm	TaskTestST, 72, 6
	.comm	blinktask, 72, 6
	.comm	taskx, 8, 3
	.section .rdata,"dr"
.LC1:
	.ascii "first\0"
	.text
	.globl	firststate
	.def	firststate;	.scl	2;	.type	32;	.endef
	.seh_proc	firststate
firststate:
.LFB8:
	.loc 1 25 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	.loc 1 27 0
	movq	16(%rbp), %rax
	movzbl	20(%rax), %eax
	testb	%al, %al
	je	.L4
	.loc 1 28 0
	movss	.LC0(%rip), %xmm1
	leaq	tmr.4632(%rip), %rcx
	call	qSTimerSet
	.loc 1 29 0
	leaq	.LC1(%rip), %rcx
	call	puts
.L4:
	.loc 1 31 0
	leaq	tmr.4632(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L5
	.loc 1 32 0
	movq	16(%rbp), %rax
	leaq	secondstate(%rip), %rdx
	movq	%rdx, (%rax)
.L5:
	.loc 1 34 0
	movl	$-32768, %eax
	.loc 1 35 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.section .rdata,"dr"
.LC3:
	.ascii "second\0"
	.text
	.globl	secondstate
	.def	secondstate;	.scl	2;	.type	32;	.endef
	.seh_proc	secondstate
secondstate:
.LFB9:
	.loc 1 36 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	.loc 1 38 0
	movq	16(%rbp), %rax
	movzbl	20(%rax), %eax
	testb	%al, %al
	je	.L8
	.loc 1 39 0
	movss	.LC2(%rip), %xmm1
	leaq	tmr.4636(%rip), %rcx
	call	qSTimerSet
	.loc 1 40 0
	leaq	.LC3(%rip), %rcx
	call	puts
.L8:
	.loc 1 42 0
	leaq	tmr.4636(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L9
	.loc 1 43 0
	movq	16(%rbp), %rax
	leaq	firststate(%rip), %rdx
	movq	%rdx, (%rax)
.L9:
	.loc 1 45 0
	movl	$-32768, %eax
	.loc 1 46 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC4:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
.LC5:
	.ascii "A\0"
.LC6:
	.ascii "B\0"
.LC7:
	.ascii "C\0"
.LC8:
	.ascii "D\0"
.LC9:
	.ascii "E\0"
.LC10:
	.ascii "F\0"
.LC11:
	.ascii "G\0"
.LC12:
	.ascii "H\0"
.LC13:
	.ascii "I\0"
.LC14:
	.ascii "J\0"
.LC15:
	.ascii "K\0"
.LC16:
	.ascii "fuck\0"
.LC17:
	.ascii "shit\0"
.LC18:
	.ascii "dam\0"
.LC19:
	.ascii "Timer expired\0"
	.text
	.globl	Task1Callback
	.def	Task1Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task1Callback
Task1Callback:
.LFB10:
	.loc 1 49 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -64
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 51 0
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	qTaskGetCycles
	movl	%eax, %ecx
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movl	%ecx, %r9d
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC4(%rip), %rcx
	call	printf
	.loc 1 52 0
	leaq	.LC5(%rip), %rdx
	leaq	Task2(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 53 0
	leaq	.LC6(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 54 0
	leaq	.LC7(%rip), %rdx
	leaq	Task4(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 55 0
	leaq	.LC8(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 56 0
	leaq	.LC9(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 57 0
	leaq	.LC10(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 58 0
	leaq	.LC11(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 59 0
	leaq	.LC12(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 60 0
	leaq	.LC13(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 61 0
	leaq	.LC14(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 62 0
	leaq	.LC15(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 63 0
	leaq	.LC16(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	qTaskSendEvent
	.loc 1 64 0
	leaq	.LC17(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskSendEvent
	.loc 1 65 0
	leaq	.LC18(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qTaskSendEvent
	.loc 1 66 0
	movss	.LC2(%rip), %xmm1
	leaq	tmr.4640(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	je	.L11
	.loc 1 67 0
	leaq	.LC19(%rip), %rcx
	call	puts
	nop
.L11:
	.loc 1 69 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.section .rdata,"dr"
.LC20:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
	.text
	.globl	Task2Callback
	.def	Task2Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task2Callback
Task2Callback:
.LFB11:
	.loc 1 71 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -64
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 72 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
	.loc 1 73 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.section .rdata,"dr"
.LC21:
	.ascii "ring extracted data %d\15\12\0"
	.text
	.globl	Task3Callback
	.def	Task3Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task3Callback
Task3Callback:
.LFB12:
	.loc 1 75 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$56, %rsp
	.seh_stackalloc	56
	.cfi_def_cfa_offset 80
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -48
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 76 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	.loc 1 77 0
	movl	(%rbx), %eax
	cmpl	$4, %eax
	jne	.L14
.LBB2:
	.loc 1 78 0
	movq	16(%rbx), %rax
	movq	%rax, -88(%rbp)
	.loc 1 79 0
	movq	-88(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	leaq	.LC21(%rip), %rcx
	call	printf
	nop
.L14:
.LBE2:
	.loc 1 81 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE12:
	.seh_endproc
	.globl	Task4Callback
	.def	Task4Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task4Callback
Task4Callback:
.LFB13:
	.loc 1 83 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -64
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 84 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
	.loc 1 85 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE13:
	.seh_endproc
	.globl	Task5Callback
	.def	Task5Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task5Callback
Task5Callback:
.LFB14:
	.loc 1 87 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -64
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 88 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
	.loc 1 89 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.globl	Task6Callback
	.def	Task6Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task6Callback
Task6Callback:
.LFB15:
	.loc 1 91 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -64
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 92 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
	.loc 1 93 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE15:
	.seh_endproc
	.globl	IdleTaskCallback
	.def	IdleTaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	IdleTaskCallback
IdleTaskCallback:
.LFB16:
	.loc 1 95 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$56, %rsp
	.seh_stackalloc	56
	.cfi_def_cfa_offset 80
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -48
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 97 0
	movzbl	24(%rbx), %eax
	testb	%al, %al
	je	.L20
	.loc 1 98 0
	movq	$0, 32(%rsp)
	movl	$0, %r9d
	movl	$0, %r8d
	leaq	firststate(%rip), %rdx
	leaq	statemachine.4660(%rip), %rcx
	call	qStateMachine_Init
.L20:
	.loc 1 100 0
	movl	$0, %edx
	leaq	statemachine.4660(%rip), %rcx
	call	qStateMachine_Run
	nop
	.loc 1 101 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.section .rdata,"dr"
.LC22:
	.ascii "led on\0"
.LC24:
	.ascii "led off\0"
	.text
	.globl	blinktaskCallback
	.def	blinktaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	blinktaskCallback
blinktaskCallback:
.LFB17:
	.loc 1 103 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	.loc 1 105 0
	movl	_qCRTaskState_.4665(%rip), %eax
	cmpl	$107, %eax
	je	.L23
	cmpl	$109, %eax
	je	.L24
	cmpl	$-32766, %eax
	je	.L25
	.loc 1 110 0
	jmp	.L21
.L25:
	.loc 1 106 0
	leaq	.LC22(%rip), %rcx
	call	puts
	.loc 1 107 0
	movl	$107, _qCRTaskState_.4665(%rip)
.L23:
	.loc 1 107 0 is_stmt 0 discriminator 1
	movss	.LC23(%rip), %xmm1
	leaq	tmr.4664(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L26
	.loc 1 107 0
	jmp	.L21
.L26:
	.loc 1 108 0 is_stmt 1
	leaq	.LC24(%rip), %rcx
	call	puts
	.loc 1 109 0
	movl	$109, _qCRTaskState_.4665(%rip)
.L24:
	.loc 1 109 0 is_stmt 0 discriminator 1
	movss	.LC25(%rip), %xmm1
	leaq	tmr.4664(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L28
	.loc 1 109 0 discriminator 2
	jmp	.L21
.L28:
	.loc 1 110 0 is_stmt 1
	jmp	.L25
.L21:
	.loc 1 111 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC26:
	.ascii "sizeof qTask_t %d\15\12\0"
.LC28:
	.ascii "TASK1\0"
.LC29:
	.ascii "TASK3\0"
.LC30:
	.ascii "TASK4\0"
.LC31:
	.ascii "TASK5\0"
.LC32:
	.ascii "TASK6\0"
.LC33:
	.ascii "blink\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB18:
	.loc 1 113 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rdi
	.seh_pushreg	%rdi
	.cfi_def_cfa_offset 24
	.cfi_offset 5, -24
	subq	$1336, %rsp
	.seh_stackalloc	1336
	.cfi_def_cfa_offset 1360
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, 1232
	.seh_endprologue
	movl	%ecx, 1232(%rbp)
	movq	%rdx, 1240(%rbp)
	.loc 1 113 0
	call	__main
	.loc 1 115 0
	movl	$72, %edx
	leaq	.LC26(%rip), %rcx
	call	printf
	.loc 1 118 0
	movl	$0, %r9d
	leaq	TimerInterruptEmulation(%rip), %r8
	movl	$0, %edx
	leaq	TimerEmulation(%rip), %rax
	movq	%rax, %rcx
	call	pthread_create
	.loc 1 119 0
	leaq	144(%rbp), %rdx
	movl	$0, %eax
	movl	$128, %ecx
	movq	%rdx, %rdi
	rep stosq
	movb	$0, 143(%rbp)
	movw	$1024, 112(%rbp)
	movb	$1, 114(%rbp)
	leaq	143(%rbp), %rax
	movq	%rax, 120(%rbp)
	leaq	144(%rbp), %rax
	movq	%rax, 128(%rbp)
	.loc 1 122 0
	movl	$5, 108(%rbp)
	movl	$6, 104(%rbp)
	.loc 1 124 0
	leaq	112(%rbp), %rax
	movl	$72, %edx
	movq	%rax, %rcx
	call	qMemoryAlloc
	movq	%rax, 1192(%rbp)
	.loc 1 125 0
	movq	1192(%rbp), %rdx
	leaq	112(%rbp), %rax
	movq	%rax, %rcx
	call	qMemoryFree
	.loc 1 126 0
	movq	1192(%rbp), %rdx
	leaq	1168(%rbp), %rax
	movl	$4, %r9d
	movl	$10, %r8d
	movq	%rax, %rcx
	call	qRBufferInit
	.loc 1 127 0
	leaq	108(%rbp), %rdx
	leaq	1168(%rbp), %rax
	movq	%rax, %rcx
	call	qRBufferPush
	.loc 1 128 0
	leaq	104(%rbp), %rdx
	leaq	1168(%rbp), %rax
	movq	%rax, %rcx
	call	qRBufferPush
	.loc 1 129 0
	leaq	-64(%rbp), %rax
	movl	$10, %r9d
	movq	%rax, %r8
	leaq	IdleTaskCallback(%rip), %rdx
	movss	.LC27(%rip), %xmm0
	call	_qInitScheduler
	.loc 1 130 0
	leaq	.LC28(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	movss	.LC0(%rip), %xmm3
	movl	$254, %r8d
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddxTask
	.loc 1 131 0
	leaq	.LC29(%rip), %r9
	movl	$50, %r8d
	leaq	Task3Callback(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 132 0
	leaq	1168(%rbp), %rax
	movq	%rax, %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qTaskLinkRingBuffer
	.loc 1 133 0
	leaq	.LC30(%rip), %r9
	movl	$10, %r8d
	leaq	Task4Callback(%rip), %rdx
	leaq	Task4(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 134 0
	leaq	.LC31(%rip), %r9
	movl	$80, %r8d
	leaq	Task5Callback(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 135 0
	leaq	.LC32(%rip), %r9
	movl	$10, %r8d
	leaq	Task6Callback(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 136 0
	leaq	.LC33(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	pxor	%xmm3, %xmm3
	movl	$254, %r8d
	leaq	blinktaskCallback(%rip), %rdx
	leaq	blinktask(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddxTask
	.loc 1 137 0
	call	qSchedulerRun
	.loc 1 138 0
	movl	$0, %eax
	.loc 1 139 0
	addq	$1336, %rsp
	popq	%rdi
	.cfi_restore 5
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -1320
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
.lcomm tmr.4632,12,4
.lcomm tmr.4636,12,4
.lcomm tmr.4640,12,4
.lcomm statemachine.4660,56,32
	.data
	.align 4
_qCRTaskState_.4665:
	.long	-32766
.lcomm tmr.4664,12,4
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1036831949
	.align 4
.LC2:
	.long	1056964608
	.align 4
.LC23:
	.long	1045220557
	.align 4
.LC25:
	.long	1065353216
	.align 4
.LC27:
	.long	1008981770
	.text
.Letext0:
	.file 2 "/usr/include/machine/_default_types.h"
	.file 3 "/usr/include/sys/_stdint.h"
	.file 4 "/usr/include/sys/types.h"
	.file 5 "/usr/include/sys/_timespec.h"
	.file 6 "/usr/include/cygwin/types.h"
	.file 7 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xe10
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C 4.9.3 -mtune=generic -march=x86-64 -g\0"
	.byte	0x1
	.ascii "main.c\0"
	.ascii "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS\0"
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.secrel32	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.ascii "signed char\0"
	.uleb128 0x3
	.ascii "__uint8_t\0"
	.byte	0x2
	.byte	0x1d
	.long	0x9f
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.ascii "short int\0"
	.uleb128 0x3
	.ascii "__uint16_t\0"
	.byte	0x2
	.byte	0x2b
	.long	0xcf
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x3
	.ascii "__uint32_t\0"
	.byte	0x2
	.byte	0x41
	.long	0xfe
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.ascii "long int\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
	.uleb128 0x4
	.byte	0x8
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.ascii "long long int\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "sizetype\0"
	.uleb128 0x5
	.byte	0x8
	.long	0x12f
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x3
	.ascii "uint8_t\0"
	.byte	0x3
	.byte	0x14
	.long	0x8e
	.uleb128 0x3
	.ascii "uint16_t\0"
	.byte	0x3
	.byte	0x1a
	.long	0xbd
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x20
	.long	0xec
	.uleb128 0x3
	.ascii "time_t\0"
	.byte	0x4
	.byte	0x7c
	.long	0x10e
	.uleb128 0x6
	.ascii "timespec\0"
	.byte	0x10
	.byte	0x5
	.byte	0x2c
	.long	0x1e4
	.uleb128 0x7
	.ascii "tv_sec\0"
	.byte	0x5
	.byte	0x2d
	.long	0x1a5
	.byte	0
	.uleb128 0x7
	.ascii "tv_nsec\0"
	.byte	0x5
	.byte	0x2e
	.long	0x10e
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.ascii "__pthread_t\0"
	.byte	0x1
	.byte	0x6
	.byte	0xb3
	.long	0x209
	.uleb128 0x7
	.ascii "__dummy\0"
	.byte	0x6
	.byte	0xb3
	.long	0x12f
	.byte	0
	.byte	0
	.uleb128 0x3
	.ascii "pthread_t\0"
	.byte	0x6
	.byte	0xb3
	.long	0x21a
	.uleb128 0x5
	.byte	0x8
	.long	0x1e4
	.uleb128 0x8
	.ascii "qTaskPC_t_\0"
	.byte	0x4
	.byte	0x7
	.byte	0x29
	.long	0x246
	.uleb128 0x9
	.ascii "qCR_PCInitVal\0"
	.sleb128 -32766
	.byte	0
	.uleb128 0x3
	.ascii "_qTaskPC_t\0"
	.byte	0x7
	.byte	0x29
	.long	0x220
	.uleb128 0xa
	.byte	0x4
	.byte	0x7
	.byte	0x3b
	.long	0x2b0
	.uleb128 0x9
	.ascii "byTimeElapsed\0"
	.sleb128 0
	.uleb128 0x9
	.ascii "byPriority\0"
	.sleb128 1
	.uleb128 0x9
	.ascii "byQueueExtraction\0"
	.sleb128 2
	.uleb128 0x9
	.ascii "byAsyncEvent\0"
	.sleb128 3
	.uleb128 0x9
	.ascii "byRBufferPop\0"
	.sleb128 4
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x7
	.byte	0x3b
	.long	0x258
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x7
	.byte	0x3c
	.long	0x2d1
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x7
	.byte	0x3d
	.long	0x195
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x7
	.byte	0x3e
	.long	0x176
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x7
	.byte	0x3f
	.long	0x176
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x7
	.byte	0x41
	.long	0x176
	.uleb128 0xb
	.byte	0x20
	.byte	0x7
	.byte	0x4c
	.long	0x369
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x7
	.byte	0x5f
	.long	0x2b0
	.byte	0
	.uleb128 0xc
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x63
	.long	0x137
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x7
	.byte	0x67
	.long	0x137
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x7
	.byte	0x6c
	.long	0x311
	.byte	0x18
	.byte	0
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x7
	.byte	0x6d
	.long	0x320
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x7
	.byte	0x6f
	.long	0x38b
	.uleb128 0x5
	.byte	0x8
	.long	0x391
	.uleb128 0xd
	.long	0x39c
	.uleb128 0xe
	.long	0x369
	.byte	0
	.uleb128 0xb
	.byte	0x3
	.byte	0x7
	.byte	0x70
	.long	0x3d7
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x7
	.byte	0x71
	.long	0x3d7
	.byte	0
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x7
	.byte	0x71
	.long	0x3d7
	.byte	0x1
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x7
	.byte	0x71
	.long	0x3d7
	.byte	0x2
	.byte	0
	.uleb128 0xf
	.long	0x176
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x7
	.byte	0x72
	.long	0x39c
	.uleb128 0xb
	.byte	0x10
	.byte	0x7
	.byte	0x76
	.long	0x449
	.uleb128 0x7
	.ascii "data\0"
	.byte	0x7
	.byte	0x77
	.long	0x449
	.byte	0
	.uleb128 0x7
	.ascii "ElementSize\0"
	.byte	0x7
	.byte	0x78
	.long	0x44f
	.byte	0x8
	.uleb128 0x7
	.ascii "Elementcount\0"
	.byte	0x7
	.byte	0x79
	.long	0x44f
	.byte	0xa
	.uleb128 0x7
	.ascii "head\0"
	.byte	0x7
	.byte	0x7a
	.long	0x44f
	.byte	0xc
	.uleb128 0x7
	.ascii "tail\0"
	.byte	0x7
	.byte	0x7b
	.long	0x44f
	.byte	0xe
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x3d7
	.uleb128 0xf
	.long	0x185
	.uleb128 0x3
	.ascii "qRBuffer_t\0"
	.byte	0x7
	.byte	0x7c
	.long	0x3f0
	.uleb128 0x6
	.ascii "_qTask_t\0"
	.byte	0x48
	.byte	0x7
	.byte	0x7e
	.long	0x529
	.uleb128 0xc
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x7f
	.long	0x137
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x7
	.byte	0x7f
	.long	0x137
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x7
	.byte	0x80
	.long	0x529
	.byte	0x10
	.uleb128 0x7
	.ascii "ClockStart\0"
	.byte	0x7
	.byte	0x80
	.long	0x529
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x7
	.byte	0x81
	.long	0x2fd
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x7
	.byte	0x82
	.long	0x195
	.byte	0x1c
	.uleb128 0x7
	.ascii "Priority\0"
	.byte	0x7
	.byte	0x83
	.long	0x2ea
	.byte	0x20
	.uleb128 0x7
	.ascii "Callback\0"
	.byte	0x7
	.byte	0x84
	.long	0x379
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x7
	.byte	0x85
	.long	0x52e
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x7
	.byte	0x86
	.long	0x533
	.byte	0x38
	.uleb128 0x7
	.ascii "RingBuff\0"
	.byte	0x7
	.byte	0x87
	.long	0x53e
	.byte	0x40
	.byte	0
	.uleb128 0xf
	.long	0x2da
	.uleb128 0xf
	.long	0x3dc
	.uleb128 0x5
	.byte	0x8
	.long	0x539
	.uleb128 0xf
	.long	0x466
	.uleb128 0x5
	.byte	0x8
	.long	0x454
	.uleb128 0xb
	.byte	0x10
	.byte	0x7
	.byte	0x8b
	.long	0x56c
	.uleb128 0x7
	.ascii "Task\0"
	.byte	0x7
	.byte	0x8c
	.long	0x533
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x7
	.byte	0x8d
	.long	0x137
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x7
	.byte	0x8e
	.long	0x544
	.uleb128 0x10
	.byte	0x4
	.byte	0x7
	.word	0x100
	.long	0x5b5
	.uleb128 0x9
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0x9
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x11
	.ascii "qSM_Status_t\0"
	.byte	0x7
	.word	0x100
	.long	0x581
	.uleb128 0x12
	.byte	0x18
	.byte	0x7
	.word	0x119
	.long	0x610
	.uleb128 0x13
	.ascii "__Failure\0"
	.byte	0x7
	.word	0x11a
	.long	0x6b1
	.byte	0
	.uleb128 0x13
	.ascii "__Success\0"
	.byte	0x7
	.word	0x11b
	.long	0x6b1
	.byte	0x8
	.uleb128 0x13
	.ascii "__Unexpected\0"
	.byte	0x7
	.word	0x11c
	.long	0x6b1
	.byte	0x10
	.byte	0
	.uleb128 0xd
	.long	0x61b
	.uleb128 0xe
	.long	0x61b
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x621
	.uleb128 0xf
	.long	0x626
	.uleb128 0x14
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x7
	.word	0x104
	.long	0x6b1
	.uleb128 0x13
	.ascii "NextState\0"
	.byte	0x7
	.word	0x108
	.long	0x6c6
	.byte	0
	.uleb128 0x13
	.ascii "PreviousState\0"
	.byte	0x7
	.word	0x10c
	.long	0x6c6
	.byte	0x8
	.uleb128 0x13
	.ascii "PreviousReturnStatus\0"
	.byte	0x7
	.word	0x110
	.long	0x5b5
	.byte	0x10
	.uleb128 0x13
	.ascii "StateJustChanged\0"
	.byte	0x7
	.word	0x114
	.long	0x311
	.byte	0x14
	.uleb128 0x15
	.secrel32	.LASF1
	.byte	0x7
	.word	0x118
	.long	0x137
	.byte	0x18
	.uleb128 0x13
	.ascii "_\0"
	.byte	0x7
	.word	0x11d
	.long	0x5ca
	.byte	0x20
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x610
	.uleb128 0x16
	.long	0x5b5
	.long	0x6c6
	.uleb128 0xe
	.long	0x61b
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x6b7
	.uleb128 0x12
	.byte	0xc
	.byte	0x7
	.word	0x153
	.long	0x6fd
	.uleb128 0x13
	.ascii "SR\0"
	.byte	0x7
	.word	0x154
	.long	0x311
	.byte	0
	.uleb128 0x13
	.ascii "Start\0"
	.byte	0x7
	.word	0x155
	.long	0x2da
	.byte	0x4
	.uleb128 0x13
	.ascii "TV\0"
	.byte	0x7
	.word	0x155
	.long	0x2da
	.byte	0x8
	.byte	0
	.uleb128 0x11
	.ascii "qSTimer_t\0"
	.byte	0x7
	.word	0x156
	.long	0x6cc
	.uleb128 0x12
	.byte	0x18
	.byte	0x7
	.word	0x166
	.long	0x76e
	.uleb128 0x13
	.ascii "BlockSize\0"
	.byte	0x7
	.word	0x167
	.long	0x185
	.byte	0
	.uleb128 0x13
	.ascii "NumberofBlocks\0"
	.byte	0x7
	.word	0x168
	.long	0x176
	.byte	0x2
	.uleb128 0x13
	.ascii "BlockDescriptors\0"
	.byte	0x7
	.word	0x169
	.long	0x76e
	.byte	0x8
	.uleb128 0x13
	.ascii "Blocks\0"
	.byte	0x7
	.word	0x16a
	.long	0x76e
	.byte	0x10
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x176
	.uleb128 0x11
	.ascii "qMemoryPool_t\0"
	.byte	0x7
	.word	0x16b
	.long	0x70f
	.uleb128 0x10
	.byte	0x4
	.byte	0x7
	.word	0x16d
	.long	0x88a
	.uleb128 0x9
	.ascii "MEMBLOCK_4_BYTE\0"
	.sleb128 4
	.uleb128 0x9
	.ascii "MEMBLOCK_8_BYTE\0"
	.sleb128 8
	.uleb128 0x9
	.ascii "MEMBLOCK_16_BYTE\0"
	.sleb128 16
	.uleb128 0x9
	.ascii "MEMBLOCK_32_BYTE\0"
	.sleb128 32
	.uleb128 0x9
	.ascii "MEMBLOCK_64_BYTE\0"
	.sleb128 64
	.uleb128 0x9
	.ascii "MEMBLOCK_128_BYTE\0"
	.sleb128 128
	.uleb128 0x9
	.ascii "MEMBLOCK_256_BYTE\0"
	.sleb128 256
	.uleb128 0x9
	.ascii "MEMBLOCK_512_BYTE\0"
	.sleb128 512
	.uleb128 0x9
	.ascii "MEMBLOCK_1024_BYTE\0"
	.sleb128 1024
	.uleb128 0x9
	.ascii "MEMBLOCK_2048_BYTE\0"
	.sleb128 2048
	.uleb128 0x9
	.ascii "MEMBLOCK_4096_BYTE\0"
	.sleb128 4096
	.uleb128 0x9
	.ascii "MEMBLOCK_8192_BYTE\0"
	.sleb128 8192
	.byte	0
	.uleb128 0x17
	.ascii "TimerInterruptEmulation\0"
	.byte	0x1
	.byte	0xb
	.long	0x137
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x8e2
	.uleb128 0x18
	.ascii "varargin\0"
	.byte	0x1
	.byte	0xb
	.long	0x137
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "tick\0"
	.byte	0x1
	.byte	0xc
	.long	0x1b3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x17
	.ascii "firststate\0"
	.byte	0x1
	.byte	0x19
	.long	0x5b5
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x92e
	.uleb128 0x18
	.ascii "fsm\0"
	.byte	0x1
	.byte	0x19
	.long	0x61b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x1a
	.long	0x6fd
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4632
	.byte	0
	.uleb128 0x17
	.ascii "secondstate\0"
	.byte	0x1
	.byte	0x24
	.long	0x5b5
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x97b
	.uleb128 0x18
	.ascii "fsm\0"
	.byte	0x1
	.byte	0x24
	.long	0x61b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x25
	.long	0x6fd
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4636
	.byte	0
	.uleb128 0x1a
	.ascii "Task1Callback\0"
	.byte	0x1
	.byte	0x31
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x9c6
	.uleb128 0x1b
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x31
	.long	0x369
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x19
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x32
	.long	0x6fd
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4640
	.byte	0
	.uleb128 0x1a
	.ascii "Task2Callback\0"
	.byte	0x1
	.byte	0x47
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x9fc
	.uleb128 0x1b
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x47
	.long	0x369
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task3Callback\0"
	.byte	0x1
	.byte	0x4b
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xa52
	.uleb128 0x1b
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x4b
	.long	0x369
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x1c
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x19
	.ascii "ptr\0"
	.byte	0x1
	.byte	0x4e
	.long	0xa52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0xe5
	.uleb128 0x1a
	.ascii "Task4Callback\0"
	.byte	0x1
	.byte	0x53
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xa8e
	.uleb128 0x1b
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x53
	.long	0x369
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task5Callback\0"
	.byte	0x1
	.byte	0x57
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xac4
	.uleb128 0x1b
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x57
	.long	0x369
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task6Callback\0"
	.byte	0x1
	.byte	0x5b
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xafa
	.uleb128 0x1b
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x5b
	.long	0x369
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "IdleTaskCallback\0"
	.byte	0x1
	.byte	0x5f
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xb51
	.uleb128 0x1b
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x5f
	.long	0x369
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x19
	.ascii "statemachine\0"
	.byte	0x1
	.byte	0x60
	.long	0x621
	.uleb128 0x9
	.byte	0x3
	.quad	statemachine.4660
	.byte	0
	.uleb128 0x1a
	.ascii "blinktaskCallback\0"
	.byte	0x1
	.byte	0x67
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xbd7
	.uleb128 0x1b
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x67
	.long	0x369
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x19
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x68
	.long	0x6fd
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4664
	.uleb128 0x19
	.ascii "_qCRTaskState_\0"
	.byte	0x1
	.byte	0x69
	.long	0x246
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4665
	.uleb128 0x1d
	.ascii "_qCR_BEGIN_\0"
	.byte	0x1
	.byte	0x69
	.quad	.L25
	.byte	0
	.uleb128 0x17
	.ascii "main\0"
	.byte	0x1
	.byte	0x71
	.long	0xe5
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0xcc7
	.uleb128 0x18
	.ascii "argc\0"
	.byte	0x1
	.byte	0x71
	.long	0xe5
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "argv\0"
	.byte	0x1
	.byte	0x71
	.long	0xcc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.ascii "ringBuffer\0"
	.byte	0x1
	.byte	0x72
	.long	0x454
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x19
	.ascii "qMEM_AREA_mtxheap\0"
	.byte	0x1
	.byte	0x77
	.long	0xccd
	.uleb128 0x3
	.byte	0x91
	.sleb128 -1088
	.uleb128 0x19
	.ascii "qMEM_DESmtxheap\0"
	.byte	0x1
	.byte	0x77
	.long	0xcdd
	.uleb128 0x3
	.byte	0x91
	.sleb128 -1089
	.uleb128 0x19
	.ascii "mtxheap\0"
	.byte	0x1
	.byte	0x77
	.long	0x774
	.uleb128 0x3
	.byte	0x91
	.sleb128 -1120
	.uleb128 0x19
	.ascii "memtest\0"
	.byte	0x1
	.byte	0x79
	.long	0x137
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.ascii "x\0"
	.byte	0x1
	.byte	0x7a
	.long	0xe5
	.uleb128 0x3
	.byte	0x91
	.sleb128 -1124
	.uleb128 0x19
	.ascii "y\0"
	.byte	0x1
	.byte	0x7a
	.long	0xe5
	.uleb128 0x3
	.byte	0x91
	.sleb128 -1128
	.uleb128 0x1e
	.ascii "ptr\0"
	.byte	0x1
	.byte	0x7b
	.long	0xa52
	.uleb128 0x19
	.ascii "_qQueueStack\0"
	.byte	0x1
	.byte	0x81
	.long	0xcfd
	.uleb128 0x3
	.byte	0x91
	.sleb128 -1296
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x156
	.uleb128 0x1f
	.long	0x195
	.long	0xcdd
	.uleb128 0x20
	.long	0x14a
	.byte	0xff
	.byte	0
	.uleb128 0x1f
	.long	0x176
	.long	0xced
	.uleb128 0x20
	.long	0x14a
	.byte	0
	.byte	0
	.uleb128 0x1f
	.long	0x56c
	.long	0xcfd
	.uleb128 0x20
	.long	0x14a
	.byte	0x9
	.byte	0
	.uleb128 0xf
	.long	0xced
	.uleb128 0x21
	.ascii "_qSysTick_Epochs_\0"
	.byte	0x7
	.byte	0xa3
	.long	0x529
	.uleb128 0x22
	.ascii "TimerEmulation\0"
	.byte	0x1
	.byte	0xa
	.long	0x209
	.uleb128 0x9
	.byte	0x3
	.quad	TimerEmulation
	.uleb128 0x22
	.ascii "Task1\0"
	.byte	0x1
	.byte	0x13
	.long	0x539
	.uleb128 0x9
	.byte	0x3
	.quad	Task1
	.uleb128 0x22
	.ascii "Task2\0"
	.byte	0x1
	.byte	0x13
	.long	0x539
	.uleb128 0x9
	.byte	0x3
	.quad	Task2
	.uleb128 0x22
	.ascii "Task3\0"
	.byte	0x1
	.byte	0x13
	.long	0x539
	.uleb128 0x9
	.byte	0x3
	.quad	Task3
	.uleb128 0x22
	.ascii "Task4\0"
	.byte	0x1
	.byte	0x13
	.long	0x539
	.uleb128 0x9
	.byte	0x3
	.quad	Task4
	.uleb128 0x22
	.ascii "Task5\0"
	.byte	0x1
	.byte	0x13
	.long	0x539
	.uleb128 0x9
	.byte	0x3
	.quad	Task5
	.uleb128 0x22
	.ascii "Task6\0"
	.byte	0x1
	.byte	0x13
	.long	0x539
	.uleb128 0x9
	.byte	0x3
	.quad	Task6
	.uleb128 0x22
	.ascii "TaskTestST\0"
	.byte	0x1
	.byte	0x13
	.long	0x539
	.uleb128 0x9
	.byte	0x3
	.quad	TaskTestST
	.uleb128 0x22
	.ascii "blinktask\0"
	.byte	0x1
	.byte	0x13
	.long	0x539
	.uleb128 0x9
	.byte	0x3
	.quad	blinktask
	.uleb128 0x22
	.ascii "taskx\0"
	.byte	0x1
	.byte	0x14
	.long	0x533
	.uleb128 0x9
	.byte	0x3
	.quad	taskx
	.byte	0
	.section	.debug_abbrev,"dr"
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x4
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x4
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xa
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"dr"
	.long	0x2c
	.word	0x2
	.secrel32	.Ldebug_info0
	.byte	0x8
	.byte	0
	.word	0
	.word	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"dr"
.Ldebug_line0:
	.section	.debug_str,"dr"
.LASF1:
	.ascii "Data\0"
.LASF0:
	.ascii "UserData\0"
	.ident	"GCC: (GNU) 4.9.3"
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.def	qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.def	qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.def	qMemoryFree;	.scl	2;	.type	32;	.endef
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddxTask;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddeTask;	.scl	2;	.type	32;	.endef
	.def	qTaskLinkRingBuffer;	.scl	2;	.type	32;	.endef
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr._qSysTick_Epochs_, "dr"
	.globl	.refptr._qSysTick_Epochs_
	.linkonce	discard
.refptr._qSysTick_Epochs_:
	.quad	_qSysTick_Epochs_
