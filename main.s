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
	.comm	Task1, 80, 5
	.comm	Task2, 80, 5
	.comm	Task3, 80, 5
	.comm	Task4, 80, 5
	.comm	Task5, 80, 5
	.comm	Task6, 80, 5
	.comm	TaskTestST, 80, 5
	.comm	blinktask, 80, 5
	.comm	SMTask, 80, 5
	.globl	datacapture
	.def	datacapture;	.scl	2;	.type	32;	.endef
	.seh_proc	datacapture
datacapture:
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
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	.loc 1 29 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "[%s] first\15\12\0"
	.text
	.globl	firststate
	.def	firststate;	.scl	2;	.type	32;	.endef
	.seh_proc	firststate
firststate:
.LFB9:
	.loc 1 32 0
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
	.loc 1 33 0
	movq	16(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 35 0
	movq	16(%rbp), %rax
	movzbl	20(%rax), %eax
	testb	%al, %al
	je	.L5
	.loc 1 36 0
	movss	.LC0(%rip), %xmm1
	leaq	tmr.4007(%rip), %rcx
	call	qSTimerSet
	.loc 1 37 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdx
	leaq	.LC1(%rip), %rcx
	call	printf
.L5:
	.loc 1 39 0
	leaq	tmr.4007(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L6
	.loc 1 40 0
	movq	16(%rbp), %rax
	leaq	secondstate(%rip), %rdx
	movq	%rdx, (%rax)
.L6:
	.loc 1 42 0
	movl	$-32768, %eax
	.loc 1 43 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.section .rdata,"dr"
.LC3:
	.ascii "[%s] second\15\12\0"
	.text
	.globl	secondstate
	.def	secondstate;	.scl	2;	.type	32;	.endef
	.seh_proc	secondstate
secondstate:
.LFB10:
	.loc 1 44 0
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
	.loc 1 45 0
	movq	16(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 47 0
	movq	16(%rbp), %rax
	movzbl	20(%rax), %eax
	testb	%al, %al
	je	.L9
	.loc 1 48 0
	movss	.LC2(%rip), %xmm1
	leaq	tmr.4012(%rip), %rcx
	call	qSTimerSet
	.loc 1 49 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
.L9:
	.loc 1 51 0
	leaq	tmr.4012(%rip), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L10
	.loc 1 52 0
	movq	16(%rbp), %rax
	leaq	firststate(%rip), %rdx
	movq	%rdx, (%rax)
.L10:
	.loc 1 54 0
	movl	$-32768, %eax
	.loc 1 55 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC4:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
.LC5:
	.ascii "Timer expired\0"
	.text
	.globl	Task1Callback
	.def	Task1Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task1Callback
Task1Callback:
.LFB11:
	.loc 1 58 0
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
	.loc 1 60 0
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
	.loc 1 78 0
	movss	.LC2(%rip), %xmm1
	leaq	tmr.4016(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	je	.L14
	.loc 1 79 0
	leaq	.LC5(%rip), %rcx
	call	puts
.L14:
	.loc 1 81 0
	nop
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
.LC6:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
	.text
	.globl	Task2Callback
	.def	Task2Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task2Callback
Task2Callback:
.LFB12:
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
	leaq	.LC6(%rip), %rcx
	call	printf
	.loc 1 85 0
	nop
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE12:
	.seh_endproc
	.section .rdata,"dr"
.LC7:
	.ascii "ring extracted data %d\15\12\0"
	.text
	.globl	Task3Callback
	.def	Task3Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task3Callback
Task3Callback:
.LFB13:
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
	subq	$56, %rsp
	.seh_stackalloc	56
	.cfi_def_cfa_offset 80
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -48
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 88 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC6(%rip), %rcx
	call	printf
	.loc 1 89 0
	movl	(%rbx), %eax
	cmpl	$5, %eax
	jne	.L18
.LBB2:
	.loc 1 90 0
	movq	16(%rbx), %rax
	movq	%rax, -88(%rbp)
	.loc 1 91 0
	movq	-88(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	leaq	.LC7(%rip), %rcx
	call	printf
.L18:
.LBE2:
	.loc 1 93 0
	nop
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE13:
	.seh_endproc
	.globl	Task4Callback
	.def	Task4Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task4Callback
Task4Callback:
.LFB14:
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -64
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 96 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC6(%rip), %rcx
	call	printf
	.loc 1 97 0
	nop
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
	.globl	Task5Callback
	.def	Task5Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task5Callback
Task5Callback:
.LFB15:
	.loc 1 99 0
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
	.loc 1 100 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC6(%rip), %rcx
	call	printf
	.loc 1 101 0
	nop
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
	.globl	Task6Callback
	.def	Task6Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task6Callback
Task6Callback:
.LFB16:
	.loc 1 103 0
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
	.loc 1 104 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC6(%rip), %rcx
	call	printf
	.loc 1 105 0
	nop
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.globl	IdleTaskCallback
	.def	IdleTaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	IdleTaskCallback
IdleTaskCallback:
.LFB17:
	.loc 1 107 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 109 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.section .rdata,"dr"
.LC8:
	.ascii "led on\0"
.LC10:
	.ascii "led off\0"
	.text
	.globl	blinktaskCallback
	.def	blinktaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	blinktaskCallback
blinktaskCallback:
.LFB18:
	.loc 1 111 0
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
	.loc 1 113 0
	movl	_qCRTaskState_.4040(%rip), %eax
	cmpl	$115, %eax
	je	.L25
	cmpl	$117, %eax
	je	.L26
	cmpl	$-32766, %eax
	je	.L27
	.loc 1 118 0
	jmp	.L23
.L32:
	nop
.L27:
	.loc 1 114 0
	leaq	.LC8(%rip), %rcx
	call	puts
	.loc 1 115 0
	movl	$115, _qCRTaskState_.4040(%rip)
.L25:
	.loc 1 115 0 is_stmt 0 discriminator 1
	movss	.LC9(%rip), %xmm1
	leaq	tmr.4039(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	je	.L31
	.loc 1 116 0 is_stmt 1
	leaq	.LC10(%rip), %rcx
	call	puts
	.loc 1 117 0
	movl	$117, _qCRTaskState_.4040(%rip)
.L26:
	.loc 1 117 0 is_stmt 0 discriminator 1
	movss	.LC11(%rip), %xmm1
	leaq	tmr.4039(%rip), %rcx
	call	qSTimerFreeRun
	testb	%al, %al
	jne	.L32
	.loc 1 117 0
	jmp	.L23
.L31:
	.loc 1 115 0 is_stmt 1
	nop
.L23:
	.loc 1 119 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC13:
	.ascii "TASK1\0"
.LC14:
	.ascii "TASK3\0"
.LC15:
	.ascii "TASK4\0"
.LC16:
	.ascii "TASK5\0"
.LC17:
	.ascii "TASK6\0"
.LC18:
	.ascii "blink\0"
.LC20:
	.ascii "smtask\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB19:
	.loc 1 122 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	subq	$464, %rsp
	.seh_stackalloc	464
	.cfi_def_cfa_offset 480
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, 352
	.seh_endprologue
	movl	%ecx, 352(%rbp)
	movq	%rdx, 360(%rbp)
	.loc 1 122 0
	call	__main
	.loc 1 128 0
	movl	$0, %r9d
	leaq	TimerInterruptEmulation(%rip), %r8
	movl	$0, %edx
	leaq	TimerEmulation(%rip), %rax
	movq	%rax, %rcx
	call	pthread_create
	.loc 1 129 0
	movq	$0, 256(%rbp)
	movq	$0, 264(%rbp)
	movq	$0, 272(%rbp)
	movq	$0, 280(%rbp)
	movq	$0, 288(%rbp)
	movq	$0, 240(%rbp)
	movw	$0, 248(%rbp)
	movw	$4, 208(%rbp)
	movb	$10, 210(%rbp)
	leaq	240(%rbp), %rax
	movq	%rax, 216(%rbp)
	leaq	256(%rbp), %rax
	movq	%rax, 224(%rbp)
	.loc 1 132 0
	movl	$5, 140(%rbp)
	movl	$6, 136(%rbp)
	.loc 1 133 0
	leaq	208(%rbp), %rax
	movl	$40, %edx
	movq	%rax, %rcx
	call	qMemoryAlloc
	movq	%rax, 328(%rbp)
	.loc 1 134 0
	movq	328(%rbp), %rdx
	leaq	304(%rbp), %rax
	movl	$4, %r9d
	movl	$10, %r8d
	movq	%rax, %rcx
	call	qRBufferInit
	.loc 1 135 0
	leaq	140(%rbp), %rdx
	leaq	304(%rbp), %rax
	movq	%rax, %rcx
	call	qRBufferPush
	.loc 1 136 0
	leaq	136(%rbp), %rdx
	leaq	304(%rbp), %rax
	movq	%rax, %rcx
	call	qRBufferPush
	.loc 1 137 0
	leaq	-32(%rbp), %rax
	movl	$10, %r9d
	movq	%rax, %r8
	leaq	IdleTaskCallback(%rip), %rdx
	movss	.LC12(%rip), %xmm0
	call	_qInitScheduler
	.loc 1 138 0
	leaq	.LC13(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	movss	.LC0(%rip), %xmm3
	movl	$254, %r8d
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddxTask
	.loc 1 139 0
	leaq	.LC14(%rip), %r9
	movl	$50, %r8d
	leaq	Task3Callback(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 140 0
	leaq	304(%rbp), %rax
	movl	$1, %r9d
	movl	$0, %r8d
	movq	%rax, %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	qTaskLinkRBuffer
	.loc 1 141 0
	leaq	.LC15(%rip), %r9
	movl	$10, %r8d
	leaq	Task4Callback(%rip), %rdx
	leaq	Task4(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 142 0
	leaq	.LC16(%rip), %r9
	movl	$80, %r8d
	leaq	Task5Callback(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 143 0
	leaq	.LC17(%rip), %r9
	movl	$10, %r8d
	leaq	Task6Callback(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddeTask
	.loc 1 144 0
	leaq	.LC18(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	pxor	%xmm3, %xmm3
	movl	$254, %r8d
	leaq	blinktaskCallback(%rip), %rdx
	leaq	blinktask(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddxTask
	.loc 1 145 0
	leaq	144(%rbp), %rdx
	leaq	.LC20(%rip), %rax
	movq	%rax, 80(%rsp)
	movl	$1, 72(%rsp)
	movq	$0, 64(%rsp)
	movq	$0, 56(%rsp)
	movq	$0, 48(%rsp)
	movq	$0, 40(%rsp)
	leaq	firststate(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	%rdx, %r9
	movss	.LC0(%rip), %xmm2
	movl	$254, %edx
	leaq	SMTask(%rip), %rax
	movq	%rax, %rcx
	call	qSchedulerAddSMTask
	.loc 1 146 0
	call	qSchedulerRun
	.loc 1 147 0
	movl	$0, %eax
	.loc 1 148 0
	addq	$464, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -456
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
.lcomm tmr.4007,12,8
.lcomm tmr.4012,12,8
.lcomm tmr.4016,12,8
	.data
	.align 4
_qCRTaskState_.4040:
	.long	-32766
.lcomm tmr.4039,12,8
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1036831949
	.align 4
.LC2:
	.long	1056964608
	.align 4
.LC9:
	.long	1045220557
	.align 4
.LC11:
	.long	1065353216
	.align 4
.LC12:
	.long	1008981770
	.text
.Letext0:
	.file 2 "/usr/include/machine/_default_types.h"
	.file 3 "/usr/include/sys/_stdint.h"
	.file 4 "/usr/include/sys/types.h"
	.file 5 "/usr/include/sys/_pthreadtypes.h"
	.file 6 "/usr/include/sys/_timespec.h"
	.file 7 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xf1e
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C99 5.4.0 -mtune=generic -march=x86-64 -g -std=c99\0"
	.byte	0xc
	.ascii "main.c\0"
	.ascii "/cygdrive/c/Users/TECREA/Documents/QuarkTS\0"
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
	.byte	0x2b
	.long	0xaa
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
	.byte	0x39
	.long	0xda
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x3
	.ascii "__int32_t\0"
	.byte	0x2
	.byte	0x4d
	.long	0x101
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x3
	.ascii "__uint32_t\0"
	.byte	0x2
	.byte	0x4f
	.long	0x11a
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
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.ascii "long long int\0"
	.uleb128 0x4
	.byte	0x8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "sizetype\0"
	.uleb128 0x5
	.byte	0x8
	.long	0x14b
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x3
	.ascii "uint8_t\0"
	.byte	0x3
	.byte	0x18
	.long	0x99
	.uleb128 0x3
	.ascii "uint16_t\0"
	.byte	0x3
	.byte	0x24
	.long	0xc8
	.uleb128 0x3
	.ascii "int32_t\0"
	.byte	0x3
	.byte	0x2c
	.long	0xf0
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x30
	.long	0x108
	.uleb128 0x3
	.ascii "time_t\0"
	.byte	0x4
	.byte	0x81
	.long	0x12a
	.uleb128 0x6
	.ascii "__pthread_t\0"
	.byte	0x1
	.byte	0x5
	.byte	0xf
	.long	0x203
	.uleb128 0x7
	.ascii "__dummy\0"
	.byte	0x5
	.byte	0xf
	.long	0x14b
	.byte	0
	.byte	0
	.uleb128 0x3
	.ascii "pthread_t\0"
	.byte	0x5
	.byte	0xf
	.long	0x214
	.uleb128 0x5
	.byte	0x8
	.long	0x1de
	.uleb128 0x6
	.ascii "timespec\0"
	.byte	0x10
	.byte	0x6
	.byte	0x2d
	.long	0x24b
	.uleb128 0x7
	.ascii "tv_sec\0"
	.byte	0x6
	.byte	0x2e
	.long	0x1d0
	.byte	0
	.uleb128 0x7
	.ascii "tv_nsec\0"
	.byte	0x6
	.byte	0x2f
	.long	0x12a
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "_qTaskPC_t\0"
	.byte	0x7
	.byte	0x2b
	.long	0x1b1
	.uleb128 0x8
	.byte	0x4
	.long	0x11a
	.byte	0x7
	.byte	0x3e
	.long	0x2f1
	.uleb128 0x9
	.ascii "_Q_NO_VALID_TRIGGER_\0"
	.byte	0
	.uleb128 0x9
	.ascii "byTimeElapsed\0"
	.byte	0x1
	.uleb128 0x9
	.ascii "byPriority\0"
	.byte	0x2
	.uleb128 0x9
	.ascii "byQueueExtraction\0"
	.byte	0x3
	.uleb128 0x9
	.ascii "byAsyncEvent\0"
	.byte	0x4
	.uleb128 0x9
	.ascii "byRBufferPop\0"
	.byte	0x5
	.uleb128 0x9
	.ascii "byRBufferFull\0"
	.byte	0x6
	.uleb128 0x9
	.ascii "byRBufferCount\0"
	.byte	0x7
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x7
	.byte	0x3e
	.long	0x25d
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x7
	.byte	0x3f
	.long	0x312
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x7
	.byte	0x40
	.long	0x1c0
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x7
	.byte	0x41
	.long	0x192
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x7
	.byte	0x42
	.long	0x192
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x7
	.byte	0x44
	.long	0x192
	.uleb128 0x3
	.ascii "qSize_t\0"
	.byte	0x7
	.byte	0x45
	.long	0x1a1
	.uleb128 0xa
	.byte	0x20
	.byte	0x7
	.byte	0x4f
	.long	0x3b9
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x7
	.byte	0x62
	.long	0x2f1
	.byte	0
	.uleb128 0xb
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x66
	.long	0x164
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x7
	.byte	0x6a
	.long	0x164
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x7
	.byte	0x6f
	.long	0x352
	.byte	0x18
	.byte	0
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x7
	.byte	0x70
	.long	0x370
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x7
	.byte	0x72
	.long	0x3db
	.uleb128 0x5
	.byte	0x8
	.long	0x3e1
	.uleb128 0xc
	.long	0x3ec
	.uleb128 0xd
	.long	0x3b9
	.byte	0
	.uleb128 0xa
	.byte	0x6
	.byte	0x7
	.byte	0x73
	.long	0x458
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x7
	.byte	0x74
	.long	0x458
	.byte	0
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x7
	.byte	0x74
	.long	0x458
	.byte	0x1
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x7
	.byte	0x74
	.long	0x458
	.byte	0x2
	.uleb128 0x7
	.ascii "RBAutoPop\0"
	.byte	0x7
	.byte	0x74
	.long	0x458
	.byte	0x3
	.uleb128 0x7
	.ascii "RBFull\0"
	.byte	0x7
	.byte	0x74
	.long	0x458
	.byte	0x4
	.uleb128 0x7
	.ascii "RBCount\0"
	.byte	0x7
	.byte	0x74
	.long	0x458
	.byte	0x5
	.byte	0
	.uleb128 0xe
	.long	0x192
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x7
	.byte	0x75
	.long	0x3ec
	.uleb128 0xa
	.byte	0x10
	.byte	0x7
	.byte	0x79
	.long	0x4ca
	.uleb128 0x7
	.ascii "data\0"
	.byte	0x7
	.byte	0x7a
	.long	0x4ca
	.byte	0
	.uleb128 0x7
	.ascii "ElementSize\0"
	.byte	0x7
	.byte	0x7b
	.long	0x4d0
	.byte	0x8
	.uleb128 0x7
	.ascii "Elementcount\0"
	.byte	0x7
	.byte	0x7c
	.long	0x4d0
	.byte	0xa
	.uleb128 0x7
	.ascii "head\0"
	.byte	0x7
	.byte	0x7d
	.long	0x4d0
	.byte	0xc
	.uleb128 0x7
	.ascii "tail\0"
	.byte	0x7
	.byte	0x7e
	.long	0x4d0
	.byte	0xe
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x458
	.uleb128 0xe
	.long	0x361
	.uleb128 0x3
	.ascii "qRBuffer_t\0"
	.byte	0x7
	.byte	0x7f
	.long	0x471
	.uleb128 0x8
	.byte	0x4
	.long	0x101
	.byte	0x7
	.byte	0x81
	.long	0x51e
	.uleb128 0xf
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0xf
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x3
	.ascii "qSM_Status_t\0"
	.byte	0x7
	.byte	0x81
	.long	0x4e7
	.uleb128 0xa
	.byte	0x20
	.byte	0x7
	.byte	0x9a
	.long	0x58d
	.uleb128 0x7
	.ascii "__Failure\0"
	.byte	0x7
	.byte	0x9b
	.long	0x628
	.byte	0
	.uleb128 0x7
	.ascii "__Success\0"
	.byte	0x7
	.byte	0x9c
	.long	0x628
	.byte	0x8
	.uleb128 0x7
	.ascii "__Unexpected\0"
	.byte	0x7
	.byte	0x9d
	.long	0x628
	.byte	0x10
	.uleb128 0x7
	.ascii "__BeforeAnyState\0"
	.byte	0x7
	.byte	0x9e
	.long	0x628
	.byte	0x18
	.byte	0
	.uleb128 0xc
	.long	0x598
	.uleb128 0xd
	.long	0x598
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x623
	.uleb128 0x6
	.ascii "_qSM_t\0"
	.byte	0x40
	.byte	0x7
	.byte	0x85
	.long	0x623
	.uleb128 0x7
	.ascii "NextState\0"
	.byte	0x7
	.byte	0x89
	.long	0x63d
	.byte	0
	.uleb128 0x7
	.ascii "PreviousState\0"
	.byte	0x7
	.byte	0x8d
	.long	0x63d
	.byte	0x8
	.uleb128 0x7
	.ascii "PreviousReturnStatus\0"
	.byte	0x7
	.byte	0x91
	.long	0x51e
	.byte	0x10
	.uleb128 0x7
	.ascii "StateJustChanged\0"
	.byte	0x7
	.byte	0x95
	.long	0x352
	.byte	0x14
	.uleb128 0x7
	.ascii "Data\0"
	.byte	0x7
	.byte	0x99
	.long	0x164
	.byte	0x18
	.uleb128 0x7
	.ascii "_\0"
	.byte	0x7
	.byte	0xa0
	.long	0x532
	.byte	0x20
	.byte	0
	.uleb128 0xe
	.long	0x59e
	.uleb128 0x5
	.byte	0x8
	.long	0x58d
	.uleb128 0x10
	.long	0x51e
	.long	0x63d
	.uleb128 0xd
	.long	0x598
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x62e
	.uleb128 0x6
	.ascii "_qTask_t\0"
	.byte	0x50
	.byte	0x7
	.byte	0xa5
	.long	0x71b
	.uleb128 0xb
	.secrel32	.LASF0
	.byte	0x7
	.byte	0xa6
	.long	0x164
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x7
	.byte	0xa6
	.long	0x164
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x7
	.byte	0xa7
	.long	0x71b
	.byte	0x10
	.uleb128 0x7
	.ascii "ClockStart\0"
	.byte	0x7
	.byte	0xa7
	.long	0x71b
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x7
	.byte	0xa8
	.long	0x33e
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x7
	.byte	0xa9
	.long	0x1c0
	.byte	0x1c
	.uleb128 0x7
	.ascii "Priority\0"
	.byte	0x7
	.byte	0xaa
	.long	0x32b
	.byte	0x20
	.uleb128 0x7
	.ascii "Callback\0"
	.byte	0x7
	.byte	0xab
	.long	0x3c9
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x7
	.byte	0xac
	.long	0x720
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x7
	.byte	0xad
	.long	0x725
	.byte	0x38
	.uleb128 0x7
	.ascii "RingBuff\0"
	.byte	0x7
	.byte	0xae
	.long	0x730
	.byte	0x40
	.uleb128 0x7
	.ascii "StateMachine\0"
	.byte	0x7
	.byte	0xaf
	.long	0x598
	.byte	0x48
	.byte	0
	.uleb128 0xe
	.long	0x31b
	.uleb128 0xe
	.long	0x45d
	.uleb128 0x5
	.byte	0x8
	.long	0x72b
	.uleb128 0xe
	.long	0x643
	.uleb128 0x5
	.byte	0x8
	.long	0x4d5
	.uleb128 0xa
	.byte	0x10
	.byte	0x7
	.byte	0xb3
	.long	0x75e
	.uleb128 0x7
	.ascii "Task\0"
	.byte	0x7
	.byte	0xb4
	.long	0x725
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x7
	.byte	0xb5
	.long	0x164
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x7
	.byte	0xb6
	.long	0x736
	.uleb128 0xe
	.long	0x75e
	.uleb128 0x8
	.byte	0x4
	.long	0x11a
	.byte	0x7
	.byte	0xd7
	.long	0x7a7
	.uleb128 0x9
	.ascii "RB_AUTOPOP\0"
	.byte	0
	.uleb128 0x9
	.ascii "RB_FULL\0"
	.byte	0x1
	.uleb128 0x9
	.ascii "RB_COUNT\0"
	.byte	0x2
	.byte	0
	.uleb128 0x11
	.byte	0xc
	.byte	0x7
	.word	0x160
	.long	0x7d8
	.uleb128 0x12
	.ascii "SR\0"
	.byte	0x7
	.word	0x161
	.long	0x352
	.byte	0
	.uleb128 0x12
	.ascii "Start\0"
	.byte	0x7
	.word	0x162
	.long	0x31b
	.byte	0x4
	.uleb128 0x12
	.ascii "TV\0"
	.byte	0x7
	.word	0x162
	.long	0x31b
	.byte	0x8
	.byte	0
	.uleb128 0x13
	.ascii "qSTimer_t\0"
	.byte	0x7
	.word	0x163
	.long	0x7a7
	.uleb128 0x11
	.byte	0x18
	.byte	0x7
	.word	0x173
	.long	0x849
	.uleb128 0x12
	.ascii "BlockSize\0"
	.byte	0x7
	.word	0x174
	.long	0x1a1
	.byte	0
	.uleb128 0x12
	.ascii "NumberofBlocks\0"
	.byte	0x7
	.word	0x175
	.long	0x192
	.byte	0x2
	.uleb128 0x12
	.ascii "BlockDescriptors\0"
	.byte	0x7
	.word	0x176
	.long	0x849
	.byte	0x8
	.uleb128 0x12
	.ascii "Blocks\0"
	.byte	0x7
	.word	0x177
	.long	0x849
	.byte	0x10
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x192
	.uleb128 0x13
	.ascii "qMemoryPool_t\0"
	.byte	0x7
	.word	0x178
	.long	0x7ea
	.uleb128 0x14
	.byte	0x4
	.long	0x11a
	.byte	0x7
	.word	0x17a
	.long	0x966
	.uleb128 0x9
	.ascii "MEMBLOCK_4_BYTE\0"
	.byte	0x4
	.uleb128 0x9
	.ascii "MEMBLOCK_8_BYTE\0"
	.byte	0x8
	.uleb128 0x9
	.ascii "MEMBLOCK_16_BYTE\0"
	.byte	0x10
	.uleb128 0x9
	.ascii "MEMBLOCK_32_BYTE\0"
	.byte	0x20
	.uleb128 0x9
	.ascii "MEMBLOCK_64_BYTE\0"
	.byte	0x40
	.uleb128 0x9
	.ascii "MEMBLOCK_128_BYTE\0"
	.byte	0x80
	.uleb128 0x15
	.ascii "MEMBLOCK_256_BYTE\0"
	.word	0x100
	.uleb128 0x15
	.ascii "MEMBLOCK_512_BYTE\0"
	.word	0x200
	.uleb128 0x15
	.ascii "MEMBLOCK_1024_BYTE\0"
	.word	0x400
	.uleb128 0x15
	.ascii "MEMBLOCK_2048_BYTE\0"
	.word	0x800
	.uleb128 0x15
	.ascii "MEMBLOCK_4096_BYTE\0"
	.word	0x1000
	.uleb128 0x15
	.ascii "MEMBLOCK_8192_BYTE\0"
	.word	0x2000
	.byte	0
	.uleb128 0x16
	.ascii "TimerInterruptEmulation\0"
	.byte	0x1
	.byte	0xd
	.long	0x164
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x9be
	.uleb128 0x17
	.ascii "varargin\0"
	.byte	0x1
	.byte	0xd
	.long	0x164
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "tick\0"
	.byte	0x1
	.byte	0xe
	.long	0x21a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x19
	.ascii "datacapture\0"
	.byte	0x1
	.byte	0x1b
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x9f2
	.uleb128 0x17
	.ascii "fsm\0"
	.byte	0x1
	.byte	0x1b
	.long	0x598
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.ascii "firststate\0"
	.byte	0x1
	.byte	0x20
	.long	0x51e
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xa4a
	.uleb128 0x17
	.ascii "fsm\0"
	.byte	0x1
	.byte	0x20
	.long	0x598
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "e\0"
	.byte	0x1
	.byte	0x21
	.long	0xa4a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x22
	.long	0x7d8
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4007
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x3b9
	.uleb128 0x16
	.ascii "secondstate\0"
	.byte	0x1
	.byte	0x2c
	.long	0x51e
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xaa9
	.uleb128 0x17
	.ascii "fsm\0"
	.byte	0x1
	.byte	0x2c
	.long	0x598
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "e\0"
	.byte	0x1
	.byte	0x2d
	.long	0xa4a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x2e
	.long	0x7d8
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4012
	.byte	0
	.uleb128 0x1a
	.ascii "Task1Callback\0"
	.byte	0x1
	.byte	0x3a
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xaf2
	.uleb128 0x17
	.ascii "e\0"
	.byte	0x1
	.byte	0x3a
	.long	0x3b9
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x18
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x3b
	.long	0x7d8
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4016
	.byte	0
	.uleb128 0x1a
	.ascii "Task2Callback\0"
	.byte	0x1
	.byte	0x53
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xb26
	.uleb128 0x17
	.ascii "e\0"
	.byte	0x1
	.byte	0x53
	.long	0x3b9
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task3Callback\0"
	.byte	0x1
	.byte	0x57
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xb7a
	.uleb128 0x17
	.ascii "e\0"
	.byte	0x1
	.byte	0x57
	.long	0x3b9
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x1b
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x18
	.ascii "ptr\0"
	.byte	0x1
	.byte	0x5a
	.long	0xb7a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x101
	.uleb128 0x1a
	.ascii "Task4Callback\0"
	.byte	0x1
	.byte	0x5f
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xbb4
	.uleb128 0x17
	.ascii "e\0"
	.byte	0x1
	.byte	0x5f
	.long	0x3b9
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task5Callback\0"
	.byte	0x1
	.byte	0x63
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xbe8
	.uleb128 0x17
	.ascii "e\0"
	.byte	0x1
	.byte	0x63
	.long	0x3b9
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task6Callback\0"
	.byte	0x1
	.byte	0x67
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xc1c
	.uleb128 0x17
	.ascii "e\0"
	.byte	0x1
	.byte	0x67
	.long	0x3b9
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "IdleTaskCallback\0"
	.byte	0x1
	.byte	0x6b
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xc53
	.uleb128 0x17
	.ascii "e\0"
	.byte	0x1
	.byte	0x6b
	.long	0x3b9
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "blinktaskCallback\0"
	.byte	0x1
	.byte	0x6f
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0xcd7
	.uleb128 0x17
	.ascii "e\0"
	.byte	0x1
	.byte	0x6f
	.long	0x3b9
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x18
	.ascii "tmr\0"
	.byte	0x1
	.byte	0x70
	.long	0x7d8
	.uleb128 0x9
	.byte	0x3
	.quad	tmr.4039
	.uleb128 0x18
	.ascii "_qCRTaskState_\0"
	.byte	0x1
	.byte	0x71
	.long	0x24b
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4040
	.uleb128 0x1c
	.ascii "_qCR_BEGIN_\0"
	.byte	0x1
	.byte	0x71
	.quad	.L27
	.byte	0
	.uleb128 0x16
	.ascii "main\0"
	.byte	0x1
	.byte	0x7a
	.long	0x101
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0xdd4
	.uleb128 0x17
	.ascii "argc\0"
	.byte	0x1
	.byte	0x7a
	.long	0x101
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.ascii "argv\0"
	.byte	0x1
	.byte	0x7a
	.long	0xdd4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x18
	.ascii "ringBuffer\0"
	.byte	0x1
	.byte	0x7b
	.long	0x4d5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x18
	.ascii "qMEM_AREA_mtxheap\0"
	.byte	0x1
	.byte	0x81
	.long	0xdda
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x18
	.ascii "qMEM_DESmtxheap\0"
	.byte	0x1
	.byte	0x81
	.long	0xdea
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x18
	.ascii "mtxheap\0"
	.byte	0x1
	.byte	0x81
	.long	0x84f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x18
	.ascii "statemachine\0"
	.byte	0x1
	.byte	0x82
	.long	0x623
	.uleb128 0x3
	.byte	0x91
	.sleb128 -208
	.uleb128 0x18
	.ascii "memtest\0"
	.byte	0x1
	.byte	0x83
	.long	0x164
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.ascii "x\0"
	.byte	0x1
	.byte	0x84
	.long	0x101
	.uleb128 0x3
	.byte	0x91
	.sleb128 -212
	.uleb128 0x18
	.ascii "y\0"
	.byte	0x1
	.byte	0x84
	.long	0x101
	.uleb128 0x3
	.byte	0x91
	.sleb128 -216
	.uleb128 0x18
	.ascii "_qQueueStack\0"
	.byte	0x1
	.byte	0x89
	.long	0xe0a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -384
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x172
	.uleb128 0x1d
	.long	0x1c0
	.long	0xdea
	.uleb128 0x1e
	.long	0x166
	.byte	0x9
	.byte	0
	.uleb128 0x1d
	.long	0x192
	.long	0xdfa
	.uleb128 0x1e
	.long	0x166
	.byte	0x9
	.byte	0
	.uleb128 0x1d
	.long	0x773
	.long	0xe0a
	.uleb128 0x1e
	.long	0x166
	.byte	0x9
	.byte	0
	.uleb128 0xe
	.long	0xdfa
	.uleb128 0x1f
	.ascii "_qSysTick_Epochs_\0"
	.byte	0x7
	.byte	0xcb
	.long	0x71b
	.uleb128 0x20
	.ascii "TimerEmulation\0"
	.byte	0x1
	.byte	0xc
	.long	0x203
	.uleb128 0x9
	.byte	0x3
	.quad	TimerEmulation
	.uleb128 0x20
	.ascii "Task1\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	Task1
	.uleb128 0x20
	.ascii "Task2\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	Task2
	.uleb128 0x20
	.ascii "Task3\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	Task3
	.uleb128 0x20
	.ascii "Task4\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	Task4
	.uleb128 0x20
	.ascii "Task5\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	Task5
	.uleb128 0x20
	.ascii "Task6\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	Task6
	.uleb128 0x20
	.ascii "TaskTestST\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	TaskTestST
	.uleb128 0x20
	.ascii "blinktask\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	blinktask
	.uleb128 0x20
	.ascii "SMTask\0"
	.byte	0x1
	.byte	0x15
	.long	0x72b
	.uleb128 0x9
	.byte	0x3
	.quad	SMTask
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
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0xb
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
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0x10
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
	.uleb128 0x14
	.uleb128 0x4
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0x5
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
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
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
.LASF0:
	.ascii "TaskData\0"
	.ident	"GCC: (GNU) 5.4.0"
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
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
	.section	.rdata$.refptr._qSysTick_Epochs_, "dr"
	.globl	.refptr._qSysTick_Epochs_
	.linkonce	discard
.refptr._qSysTick_Epochs_:
	.quad	_qSysTick_Epochs_
