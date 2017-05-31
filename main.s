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
	.loc 1 13 0
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
	.loc 1 14 0
	movq	$0, -16(%rbp)
	movq	$10000000, -8(%rbp)
.L2:
	.loc 1 16 0 discriminator 1
	leaq	-16(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	nanosleep
	.loc 1 17 0 discriminator 1
	movq	.refptr._qSysTick_Epochs_(%rip), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	.refptr._qSysTick_Epochs_(%rip), %rax
	movl	%edx, (%rax)
	.loc 1 18 0 discriminator 1
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
	.loc 1 27 0
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
	.loc 1 29 0
	movq	16(%rbp), %rax
	movzbl	20(%rax), %eax
	testb	%al, %al
	je	.L4
	.loc 1 30 0
	movss	.LC0(%rip), %xmm1
	leaq	tmr.4123(%rip), %rcx
	call	qSTimerSet
	.loc 1 31 0
	leaq	.LC1(%rip), %rcx
	call	puts
.L4:
	.loc 1 33 0
	leaq	tmr.4123(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L5
	.loc 1 34 0
	movq	16(%rbp), %rax
	leaq	secondstate(%rip), %rdx
	movq	%rdx, (%rax)
.L5:
	.loc 1 36 0
	movl	$-32768, %eax
	.loc 1 37 0
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
	.loc 1 38 0
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
	.loc 1 40 0
	movq	16(%rbp), %rax
	movzbl	20(%rax), %eax
	testb	%al, %al
	je	.L8
	.loc 1 41 0
	movss	.LC2(%rip), %xmm1
	leaq	tmr.4127(%rip), %rcx
	call	qSTimerSet
	.loc 1 42 0
	leaq	.LC3(%rip), %rcx
	call	puts
.L8:
	.loc 1 44 0
	leaq	tmr.4127(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L9
	.loc 1 45 0
	movq	16(%rbp), %rax
	leaq	firststate(%rip), %rdx
	movq	%rdx, (%rax)
.L9:
	.loc 1 47 0
	movl	$-32768, %eax
	.loc 1 48 0
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
	.loc 1 51 0
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
	.loc 1 53 0
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
	.loc 1 54 0
	leaq	.LC5(%rip), %rdx
	leaq	Task2(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 55 0
	leaq	.LC6(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 56 0
	leaq	.LC7(%rip), %rdx
	leaq	Task4(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 57 0
	leaq	.LC8(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 58 0
	leaq	.LC9(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 59 0
	leaq	.LC10(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 60 0
	leaq	.LC11(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 61 0
	leaq	.LC12(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 62 0
	leaq	.LC13(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 63 0
	leaq	.LC14(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 64 0
	leaq	.LC15(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskQueueEvent
	.loc 1 65 0
	leaq	.LC16(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	qTaskSendEvent
	.loc 1 66 0
	leaq	.LC17(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qTaskSendEvent
	.loc 1 67 0
	leaq	.LC18(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qTaskSendEvent
	.loc 1 68 0
	movss	.LC2(%rip), %xmm1
	leaq	tmr.4131(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	je	.L11
	.loc 1 69 0
	leaq	.LC19(%rip), %rcx
	call	puts
	nop
.L11:
	.loc 1 71 0
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
	.loc 1 73 0
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
	.loc 1 74 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
	.loc 1 75 0
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
	.loc 1 77 0
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
	.loc 1 78 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	.loc 1 79 0
	movl	(%rbx), %eax
	cmpl	$5, %eax
	jne	.L14
.LBB2:
	.loc 1 80 0
	movq	16(%rbx), %rax
	movq	%rax, -88(%rbp)
	.loc 1 81 0
	movq	-88(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	leaq	.LC21(%rip), %rcx
	call	printf
	nop
.L14:
.LBE2:
	.loc 1 83 0
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
	.loc 1 85 0
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
	.loc 1 86 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
	.loc 1 87 0
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
	.loc 1 89 0
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
	.loc 1 90 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
	.loc 1 91 0
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
	.loc 1 93 0
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
	.loc 1 94 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC20(%rip), %rcx
	call	printf
	nop
	.loc 1 95 0
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
	.loc 1 97 0
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
	.loc 1 99 0
	movzbl	24(%rbx), %eax
	testb	%al, %al
	je	.L20
	.loc 1 100 0
	movq	$0, 32(%rsp)
	movl	$0, %r9d
	movl	$0, %r8d
	leaq	firststate(%rip), %rdx
	leaq	statemachine.4151(%rip), %rcx
	call	qStateMachine_Init
.L20:
	.loc 1 102 0
	movl	$0, %edx
	leaq	statemachine.4151(%rip), %rcx
	call	qStateMachine_Run
	nop
	.loc 1 103 0
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
	.loc 1 105 0
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
	.loc 1 107 0
	movl	_qCRTaskState_.4156(%rip), %eax
	cmpl	$109, %eax
	je	.L23
	cmpl	$111, %eax
	je	.L24
	cmpl	$-32766, %eax
	je	.L25
	.loc 1 112 0
	jmp	.L21
.L25:
	.loc 1 108 0
	leaq	.LC22(%rip), %rcx
	call	puts
	.loc 1 109 0
	movl	$109, _qCRTaskState_.4156(%rip)
.L23:
	.loc 1 109 0 is_stmt 0 discriminator 1
	movss	.LC23(%rip), %xmm1
	leaq	tmr.4155(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L26
	.loc 1 109 0
	jmp	.L21
.L26:
	.loc 1 110 0 is_stmt 1
	leaq	.LC24(%rip), %rcx
	call	puts
	.loc 1 111 0
	movl	$111, _qCRTaskState_.4156(%rip)
.L24:
	.loc 1 111 0 is_stmt 0 discriminator 1
	movss	.LC25(%rip), %xmm1
	leaq	tmr.4155(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L28
	.loc 1 111 0 discriminator 2
	jmp	.L21
.L28:
	.loc 1 112 0 is_stmt 1
	jmp	.L25
.L21:
	.loc 1 113 0
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
.LC27:
	.ascii "TASK1\0"
.LC28:
	.ascii "TASK3\0"
.LC29:
	.ascii "TASK4\0"
.LC30:
	.ascii "TASK5\0"
.LC31:
	.ascii "TASK6\0"
.LC32:
	.ascii "blink\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB18:
	.loc 1 115 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	subq	$336, %rsp
	.seh_stackalloc	336
	.cfi_def_cfa_offset 352
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, 224
	.seh_endprologue
	movl	%ecx, 224(%rbp)
	movq	%rdx, 232(%rbp)
	.loc 1 115 0
	call	__main
	.loc 1 121 0
	movl	$0, %r9d
	leaq	TimerInterruptEmulation(%rip), %r8
	movl	$0, %edx
	leaq	TimerEmulation(%rip), %rax
	movq	%rax, %rcx
	call	pthread_create
	.loc 1 122 0
	movq	$0, 160(%rbp)
	movl	$0, 168(%rbp)
	movw	$0, 144(%rbp)
	movb	$0, 146(%rbp)
	movw	$4, 112(%rbp)
	movb	$3, 114(%rbp)
	leaq	144(%rbp), %rax
	movq	%rax, 120(%rbp)
	leaq	160(%rbp), %rax
	movq	%rax, 128(%rbp)
	.loc 1 125 0
	movl	$5, 108(%rbp)
	movl	$6, 104(%rbp)
	.loc 1 126 0
	leaq	112(%rbp), %rax
	movl	$10, %edx
	movq	%rax, %rcx
	call	qMemoryAlloc
	movq	%rax, 200(%rbp)
	.loc 1 127 0
	movq	200(%rbp), %rdx
	leaq	176(%rbp), %rax
	movl	$4, %r9d
	movl	$10, %r8d
	movq	%rax, %rcx
	call	qRBufferInit
	.loc 1 128 0
	leaq	108(%rbp), %rdx
	leaq	176(%rbp), %rax
	movq	%rax, %rcx
	call	qRBufferPush
	.loc 1 129 0
	leaq	104(%rbp), %rdx
	leaq	176(%rbp), %rax
	movq	%rax, %rcx
	call	qRBufferPush
	.loc 1 130 0
	leaq	-64(%rbp), %rax
	movl	$10, %r9d
	movq	%rax, %r8
	leaq	IdleTaskCallback(%rip), %rdx
	movss	.LC26(%rip), %xmm0
	call	_qInitScheduler
	.loc 1 131 0
	leaq	.LC27(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	movss	.LC0(%rip), %xmm3
	movl	$254, %r8d
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddxTask
	.loc 1 132 0
	leaq	.LC28(%rip), %r9
	movl	$50, %r8d
	leaq	Task3Callback(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 133 0
	leaq	176(%rbp), %rax
	movl	$1, %r9d
	movl	$0, %r8d
	movq	%rax, %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qTaskLinkRBuffer
	.loc 1 134 0
	leaq	.LC29(%rip), %r9
	movl	$10, %r8d
	leaq	Task4Callback(%rip), %rdx
	leaq	Task4(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 135 0
	leaq	.LC30(%rip), %r9
	movl	$80, %r8d
	leaq	Task5Callback(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 136 0
	leaq	.LC31(%rip), %r9
	movl	$10, %r8d
	leaq	Task6Callback(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 137 0
	leaq	.LC32(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	pxor	%xmm3, %xmm3
	movl	$254, %r8d
	leaq	blinktaskCallback(%rip), %rdx
	leaq	blinktask(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddxTask
	.loc 1 138 0
	call	qSchedulerRun
	.loc 1 139 0
	movl	$0, %eax
	.loc 1 140 0
	addq	$336, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -328
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
.lcomm tmr.4123,12,4
.lcomm tmr.4127,12,4
.lcomm tmr.4131,12,4
.lcomm statemachine.4151,56,32
	.data
	.align 4
_qCRTaskState_.4156:
	.long	-32766
.lcomm tmr.4155,12,4
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
.LC26:
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
	.long	0xe9b
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C 4.9.3 -mtune=generic -march=x86-64 -g -std=c99\0"
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
	.long	0xa8
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
	.long	0xd8
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x3
	.ascii "__int32_t\0"
	.byte	0x2
	.byte	0x3f
	.long	0xff
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x3
	.ascii "__uint32_t\0"
	.byte	0x2
	.byte	0x41
	.long	0x118
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
	.long	0x149
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x3
	.ascii "uint8_t\0"
	.byte	0x3
	.byte	0x14
	.long	0x97
	.uleb128 0x3
	.ascii "uint16_t\0"
	.byte	0x3
	.byte	0x1a
	.long	0xc6
	.uleb128 0x3
	.ascii "int32_t\0"
	.byte	0x3
	.byte	0x1f
	.long	0xee
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x20
	.long	0x106
	.uleb128 0x3
	.ascii "time_t\0"
	.byte	0x4
	.byte	0x7c
	.long	0x128
	.uleb128 0x6
	.ascii "timespec\0"
	.byte	0x10
	.byte	0x5
	.byte	0x2c
	.long	0x20d
	.uleb128 0x7
	.ascii "tv_sec\0"
	.byte	0x5
	.byte	0x2d
	.long	0x1ce
	.byte	0
	.uleb128 0x7
	.ascii "tv_nsec\0"
	.byte	0x5
	.byte	0x2e
	.long	0x128
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.ascii "__pthread_t\0"
	.byte	0x1
	.byte	0x6
	.byte	0xb3
	.long	0x232
	.uleb128 0x7
	.ascii "__dummy\0"
	.byte	0x6
	.byte	0xb3
	.long	0x149
	.byte	0
	.byte	0
	.uleb128 0x3
	.ascii "pthread_t\0"
	.byte	0x6
	.byte	0xb3
	.long	0x243
	.uleb128 0x5
	.byte	0x8
	.long	0x20d
	.uleb128 0x3
	.ascii "_qTaskPC_t\0"
	.byte	0x7
	.byte	0x2b
	.long	0x1af
	.uleb128 0x8
	.byte	0x4
	.byte	0x7
	.byte	0x3e
	.long	0x2eb
	.uleb128 0x9
	.ascii "_Q_NO_VALID_TRIGGER_\0"
	.sleb128 0
	.uleb128 0x9
	.ascii "byTimeElapsed\0"
	.sleb128 1
	.uleb128 0x9
	.ascii "byPriority\0"
	.sleb128 2
	.uleb128 0x9
	.ascii "byQueueExtraction\0"
	.sleb128 3
	.uleb128 0x9
	.ascii "byAsyncEvent\0"
	.sleb128 4
	.uleb128 0x9
	.ascii "byRBufferPop\0"
	.sleb128 5
	.uleb128 0x9
	.ascii "byRBufferFull\0"
	.sleb128 6
	.uleb128 0x9
	.ascii "byRBufferCount\0"
	.sleb128 7
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x7
	.byte	0x3e
	.long	0x25b
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x7
	.byte	0x3f
	.long	0x30c
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x7
	.byte	0x40
	.long	0x1be
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x7
	.byte	0x41
	.long	0x190
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x7
	.byte	0x42
	.long	0x190
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x7
	.byte	0x44
	.long	0x190
	.uleb128 0xa
	.byte	0x20
	.byte	0x7
	.byte	0x4f
	.long	0x3a4
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x7
	.byte	0x62
	.long	0x2eb
	.byte	0
	.uleb128 0xb
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x66
	.long	0x151
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x7
	.byte	0x6a
	.long	0x151
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x7
	.byte	0x6f
	.long	0x34c
	.byte	0x18
	.byte	0
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x7
	.byte	0x70
	.long	0x35b
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x7
	.byte	0x72
	.long	0x3c6
	.uleb128 0x5
	.byte	0x8
	.long	0x3cc
	.uleb128 0xc
	.long	0x3d7
	.uleb128 0xd
	.long	0x3a4
	.byte	0
	.uleb128 0xa
	.byte	0x6
	.byte	0x7
	.byte	0x73
	.long	0x443
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x7
	.byte	0x74
	.long	0x443
	.byte	0
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x7
	.byte	0x74
	.long	0x443
	.byte	0x1
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x7
	.byte	0x74
	.long	0x443
	.byte	0x2
	.uleb128 0x7
	.ascii "RBAutoPop\0"
	.byte	0x7
	.byte	0x74
	.long	0x443
	.byte	0x3
	.uleb128 0x7
	.ascii "RBFull\0"
	.byte	0x7
	.byte	0x74
	.long	0x443
	.byte	0x4
	.uleb128 0x7
	.ascii "RBCount\0"
	.byte	0x7
	.byte	0x74
	.long	0x443
	.byte	0x5
	.byte	0
	.uleb128 0xe
	.long	0x190
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x7
	.byte	0x75
	.long	0x3d7
	.uleb128 0xa
	.byte	0x10
	.byte	0x7
	.byte	0x79
	.long	0x4b5
	.uleb128 0x7
	.ascii "data\0"
	.byte	0x7
	.byte	0x7a
	.long	0x4b5
	.byte	0
	.uleb128 0x7
	.ascii "ElementSize\0"
	.byte	0x7
	.byte	0x7b
	.long	0x4bb
	.byte	0x8
	.uleb128 0x7
	.ascii "Elementcount\0"
	.byte	0x7
	.byte	0x7c
	.long	0x4bb
	.byte	0xa
	.uleb128 0x7
	.ascii "head\0"
	.byte	0x7
	.byte	0x7d
	.long	0x4bb
	.byte	0xc
	.uleb128 0x7
	.ascii "tail\0"
	.byte	0x7
	.byte	0x7e
	.long	0x4bb
	.byte	0xe
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x443
	.uleb128 0xe
	.long	0x19f
	.uleb128 0x3
	.ascii "qRBuffer_t\0"
	.byte	0x7
	.byte	0x7f
	.long	0x45c
	.uleb128 0x6
	.ascii "_qTask_t\0"
	.byte	0x48
	.byte	0x7
	.byte	0x81
	.long	0x595
	.uleb128 0xb
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x82
	.long	0x151
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x7
	.byte	0x82
	.long	0x151
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x7
	.byte	0x83
	.long	0x595
	.byte	0x10
	.uleb128 0x7
	.ascii "ClockStart\0"
	.byte	0x7
	.byte	0x83
	.long	0x595
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x7
	.byte	0x84
	.long	0x338
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x7
	.byte	0x85
	.long	0x1be
	.byte	0x1c
	.uleb128 0x7
	.ascii "Priority\0"
	.byte	0x7
	.byte	0x86
	.long	0x325
	.byte	0x20
	.uleb128 0x7
	.ascii "Callback\0"
	.byte	0x7
	.byte	0x87
	.long	0x3b4
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x7
	.byte	0x88
	.long	0x59a
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x7
	.byte	0x89
	.long	0x59f
	.byte	0x38
	.uleb128 0x7
	.ascii "RingBuff\0"
	.byte	0x7
	.byte	0x8a
	.long	0x5aa
	.byte	0x40
	.byte	0
	.uleb128 0xe
	.long	0x315
	.uleb128 0xe
	.long	0x448
	.uleb128 0x5
	.byte	0x8
	.long	0x5a5
	.uleb128 0xe
	.long	0x4d2
	.uleb128 0x5
	.byte	0x8
	.long	0x4c0
	.uleb128 0xa
	.byte	0x10
	.byte	0x7
	.byte	0x8e
	.long	0x5d8
	.uleb128 0x7
	.ascii "Task\0"
	.byte	0x7
	.byte	0x8f
	.long	0x59f
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x7
	.byte	0x90
	.long	0x151
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x7
	.byte	0x91
	.long	0x5b0
	.uleb128 0x8
	.byte	0x4
	.byte	0x7
	.byte	0xaf
	.long	0x618
	.uleb128 0x9
	.ascii "RB_AUTOPOP\0"
	.sleb128 0
	.uleb128 0x9
	.ascii "RB_FULL\0"
	.sleb128 1
	.uleb128 0x9
	.ascii "RB_COUNT\0"
	.sleb128 2
	.byte	0
	.uleb128 0xf
	.byte	0x4
	.byte	0x7
	.word	0x106
	.long	0x64c
	.uleb128 0x9
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0x9
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x10
	.ascii "qSM_Status_t\0"
	.byte	0x7
	.word	0x106
	.long	0x618
	.uleb128 0x11
	.byte	0x18
	.byte	0x7
	.word	0x11f
	.long	0x6a7
	.uleb128 0x12
	.ascii "__Failure\0"
	.byte	0x7
	.word	0x120
	.long	0x748
	.byte	0
	.uleb128 0x12
	.ascii "__Success\0"
	.byte	0x7
	.word	0x121
	.long	0x748
	.byte	0x8
	.uleb128 0x12
	.ascii "__Unexpected\0"
	.byte	0x7
	.word	0x122
	.long	0x748
	.byte	0x10
	.byte	0
	.uleb128 0xc
	.long	0x6b2
	.uleb128 0xd
	.long	0x6b2
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x6b8
	.uleb128 0xe
	.long	0x6bd
	.uleb128 0x13
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x7
	.word	0x10a
	.long	0x748
	.uleb128 0x12
	.ascii "NextState\0"
	.byte	0x7
	.word	0x10e
	.long	0x75d
	.byte	0
	.uleb128 0x12
	.ascii "PreviousState\0"
	.byte	0x7
	.word	0x112
	.long	0x75d
	.byte	0x8
	.uleb128 0x12
	.ascii "PreviousReturnStatus\0"
	.byte	0x7
	.word	0x116
	.long	0x64c
	.byte	0x10
	.uleb128 0x12
	.ascii "StateJustChanged\0"
	.byte	0x7
	.word	0x11a
	.long	0x34c
	.byte	0x14
	.uleb128 0x14
	.secrel32	.LASF1
	.byte	0x7
	.word	0x11e
	.long	0x151
	.byte	0x18
	.uleb128 0x12
	.ascii "_\0"
	.byte	0x7
	.word	0x123
	.long	0x661
	.byte	0x20
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x6a7
	.uleb128 0x15
	.long	0x64c
	.long	0x75d
	.uleb128 0xd
	.long	0x6b2
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x74e
	.uleb128 0x11
	.byte	0xc
	.byte	0x7
	.word	0x159
	.long	0x794
	.uleb128 0x12
	.ascii "SR\0"
	.byte	0x7
	.word	0x15a
	.long	0x34c
	.byte	0
	.uleb128 0x12
	.ascii "Start\0"
	.byte	0x7
	.word	0x15b
	.long	0x315
	.byte	0x4
	.uleb128 0x12
	.ascii "TV\0"
	.byte	0x7
	.word	0x15b
	.long	0x315
	.byte	0x8
	.byte	0
	.uleb128 0x10
	.ascii "qSTimer_t\0"
	.byte	0x7
	.word	0x15c
	.long	0x763
	.uleb128 0x11
	.byte	0x18
	.byte	0x7
	.word	0x16c
	.long	0x805
	.uleb128 0x12
	.ascii "BlockSize\0"
	.byte	0x7
	.word	0x16d
	.long	0x19f
	.byte	0
	.uleb128 0x12
	.ascii "NumberofBlocks\0"
	.byte	0x7
	.word	0x16e
	.long	0x190
	.byte	0x2
	.uleb128 0x12
	.ascii "BlockDescriptors\0"
	.byte	0x7
	.word	0x16f
	.long	0x805
	.byte	0x8
	.uleb128 0x12
	.ascii "Blocks\0"
	.byte	0x7
	.word	0x170
	.long	0x805
	.byte	0x10
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x190
	.uleb128 0x10
	.ascii "qMemoryPool_t\0"
	.byte	0x7
	.word	0x171
	.long	0x7a6
	.uleb128 0xf
	.byte	0x4
	.byte	0x7
	.word	0x173
	.long	0x921
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
	.uleb128 0x16
	.ascii "TimerInterruptEmulation\0"
	.byte	0x1
	.byte	0xd
	.long	0x151
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x979
	.uleb128 0x17
	.ascii "varargin\0"
	.byte	0x1
	.byte	0xd
	.long	0x151
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "tick\0"
	.byte	0x1
	.byte	0xe
	.long	0x1dc
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x16
	.ascii "firststate\0"
	.byte	0x1
	.byte	0x1b
	.long	0x64c
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x9c5
	.uleb128 0x17
	.ascii "fsm\0"
	.byte	0x1
	.byte	0x1b
	.long	0x6b2
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x1c
	.long	0x794
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4123
	.byte	0
	.uleb128 0x16
	.ascii "secondstate\0"
	.byte	0x1
	.byte	0x26
	.long	0x64c
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xa12
	.uleb128 0x17
	.ascii "fsm\0"
	.byte	0x1
	.byte	0x26
	.long	0x6b2
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x27
	.long	0x794
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4127
	.byte	0
	.uleb128 0x19
	.ascii "Task1Callback\0"
	.byte	0x1
	.byte	0x33
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xa5d
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x33
	.long	0x3a4
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x18
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x34
	.long	0x794
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4131
	.byte	0
	.uleb128 0x19
	.ascii "Task2Callback\0"
	.byte	0x1
	.byte	0x49
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xa93
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x49
	.long	0x3a4
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "Task3Callback\0"
	.byte	0x1
	.byte	0x4d
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xae9
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x4d
	.long	0x3a4
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x1b
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x18
	.ascii "ptr\0"
	.byte	0x1
	.byte	0x50
	.long	0xae9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0xff
	.uleb128 0x19
	.ascii "Task4Callback\0"
	.byte	0x1
	.byte	0x55
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xb25
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x55
	.long	0x3a4
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "Task5Callback\0"
	.byte	0x1
	.byte	0x59
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xb5b
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x59
	.long	0x3a4
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "Task6Callback\0"
	.byte	0x1
	.byte	0x5d
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xb91
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x5d
	.long	0x3a4
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "IdleTaskCallback\0"
	.byte	0x1
	.byte	0x61
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xbe8
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x61
	.long	0x3a4
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x18
	.ascii "statemachine\0"
	.byte	0x1
	.byte	0x62
	.long	0x6b8
	.uleb128 0x9
	.byte	0x3
	.quad	statemachine.4151
	.byte	0
	.uleb128 0x19
	.ascii "blinktaskCallback\0"
	.byte	0x1
	.byte	0x69
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xc6e
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x69
	.long	0x3a4
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x18
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x6a
	.long	0x794
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4155
	.uleb128 0x18
	.ascii "_qCRTaskState_\0"
	.byte	0x1
	.byte	0x6b
	.long	0x249
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4156
	.uleb128 0x1c
	.ascii "_qCR_BEGIN_\0"
	.byte	0x1
	.byte	0x6b
	.quad	.L25
	.byte	0
	.uleb128 0x16
	.ascii "main\0"
	.byte	0x1
	.byte	0x73
	.long	0xff
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0xd52
	.uleb128 0x17
	.ascii "argc\0"
	.byte	0x1
	.byte	0x73
	.long	0xff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.ascii "argv\0"
	.byte	0x1
	.byte	0x73
	.long	0xd52
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x18
	.ascii "ringBuffer\0"
	.byte	0x1
	.byte	0x74
	.long	0x4c0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x18
	.ascii "qMEM_AREA_mtxheap\0"
	.byte	0x1
	.byte	0x7a
	.long	0xd58
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x18
	.ascii "qMEM_DESmtxheap\0"
	.byte	0x1
	.byte	0x7a
	.long	0xd68
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x18
	.ascii "mtxheap\0"
	.byte	0x1
	.byte	0x7a
	.long	0x80b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x18
	.ascii "memtest\0"
	.byte	0x1
	.byte	0x7c
	.long	0x151
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.ascii "x\0"
	.byte	0x1
	.byte	0x7d
	.long	0xff
	.uleb128 0x3
	.byte	0x91
	.sleb128 -116
	.uleb128 0x18
	.ascii "y\0"
	.byte	0x1
	.byte	0x7d
	.long	0xff
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x18
	.ascii "_qQueueStack\0"
	.byte	0x1
	.byte	0x82
	.long	0xd88
	.uleb128 0x3
	.byte	0x91
	.sleb128 -288
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x170
	.uleb128 0x1d
	.long	0x1be
	.long	0xd68
	.uleb128 0x1e
	.long	0x164
	.byte	0x2
	.byte	0
	.uleb128 0x1d
	.long	0x190
	.long	0xd78
	.uleb128 0x1e
	.long	0x164
	.byte	0x2
	.byte	0
	.uleb128 0x1d
	.long	0x5d8
	.long	0xd88
	.uleb128 0x1e
	.long	0x164
	.byte	0x9
	.byte	0
	.uleb128 0xe
	.long	0xd78
	.uleb128 0x1f
	.ascii "_qSysTick_Epochs_\0"
	.byte	0x7
	.byte	0xa6
	.long	0x595
	.uleb128 0x20
	.ascii "TimerEmulation\0"
	.byte	0x1
	.byte	0xc
	.long	0x232
	.uleb128 0x9
	.byte	0x3
	.quad	TimerEmulation
	.uleb128 0x20
	.ascii "Task1\0"
	.byte	0x1
	.byte	0x15
	.long	0x5a5
	.uleb128 0x9
	.byte	0x3
	.quad	Task1
	.uleb128 0x20
	.ascii "Task2\0"
	.byte	0x1
	.byte	0x15
	.long	0x5a5
	.uleb128 0x9
	.byte	0x3
	.quad	Task2
	.uleb128 0x20
	.ascii "Task3\0"
	.byte	0x1
	.byte	0x15
	.long	0x5a5
	.uleb128 0x9
	.byte	0x3
	.quad	Task3
	.uleb128 0x20
	.ascii "Task4\0"
	.byte	0x1
	.byte	0x15
	.long	0x5a5
	.uleb128 0x9
	.byte	0x3
	.quad	Task4
	.uleb128 0x20
	.ascii "Task5\0"
	.byte	0x1
	.byte	0x15
	.long	0x5a5
	.uleb128 0x9
	.byte	0x3
	.quad	Task5
	.uleb128 0x20
	.ascii "Task6\0"
	.byte	0x1
	.byte	0x15
	.long	0x5a5
	.uleb128 0x9
	.byte	0x3
	.quad	Task6
	.uleb128 0x20
	.ascii "TaskTestST\0"
	.byte	0x1
	.byte	0x15
	.long	0x5a5
	.uleb128 0x9
	.byte	0x3
	.quad	TaskTestST
	.uleb128 0x20
	.ascii "blinktask\0"
	.byte	0x1
	.byte	0x15
	.long	0x5a5
	.uleb128 0x9
	.byte	0x3
	.quad	blinktask
	.uleb128 0x20
	.ascii "taskx\0"
	.byte	0x1
	.byte	0x16
	.long	0x59f
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
	.uleb128 0xb
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
	.uleb128 0xc
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
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
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
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
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
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
	.uleb128 0x18
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
	.uleb128 0x19
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
	.uleb128 0x1a
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
	.uleb128 0x1b
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1f
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
	.uleb128 0x20
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
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddxTask;	.scl	2;	.type	32;	.endef
	.def	qSchedulerAddeTask;	.scl	2;	.type	32;	.endef
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr._qSysTick_Epochs_, "dr"
	.globl	.refptr._qSysTick_Epochs_
	.linkonce	discard
.refptr._qSysTick_Epochs_:
	.quad	_qSysTick_Epochs_
