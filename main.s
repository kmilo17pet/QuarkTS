	.file	"main.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section .rdata,"dr"
.LC0:
	.ascii "%s %s \15\12\0"
.LC1:
	.ascii "Running by first time.\0"
.LC2:
	.ascii "Sequence started again.\0"
.LC3:
	.ascii "1\0"
	.text
	.globl	primero
	.def	primero;	.scl	2;	.type	32;	.endef
	.seh_proc	primero
primero:
.LFB7:
	.file 1 "main.c"
	.loc 1 14 0
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
	.loc 1 15 0
	movq	16(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 16 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC0(%rip), %rcx
	call	printf
	.loc 1 17 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L2
	.loc 1 18 0
	leaq	.LC1(%rip), %rcx
	call	puts
.L2:
	.loc 1 20 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	tercero(%rip), %rax
	cmpq	%rax, %rdx
	jne	.L3
	.loc 1 21 0
	leaq	.LC2(%rip), %rcx
	call	puts
.L3:
	.loc 1 23 0
	leaq	.LC3(%rip), %rcx
	call	puts
	.loc 1 24 0
	movq	16(%rbp), %rax
	leaq	segundo(%rip), %rdx
	movq	%rdx, (%rax)
	.loc 1 25 0
	movl	$-32768, %eax
	.loc 1 26 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.seh_endproc
	.section .rdata,"dr"
.LC4:
	.ascii "2\0"
	.text
	.globl	segundo
	.def	segundo;	.scl	2;	.type	32;	.endef
	.seh_proc	segundo
segundo:
.LFB8:
	.loc 1 28 0
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
	leaq	.LC4(%rip), %rcx
	call	puts
	.loc 1 30 0
	movq	16(%rbp), %rax
	leaq	tercero(%rip), %rdx
	movq	%rdx, (%rax)
	.loc 1 31 0
	movl	$-32768, %eax
	.loc 1 32 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.section .rdata,"dr"
.LC5:
	.ascii "3\0"
	.text
	.globl	tercero
	.def	tercero;	.scl	2;	.type	32;	.endef
	.seh_proc	tercero
tercero:
.LFB9:
	.loc 1 34 0
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
	.loc 1 36 0
	leaq	.LC5(%rip), %rcx
	call	puts
	.loc 1 37 0
	movq	16(%rbp), %rax
	leaq	primero(%rip), %rdx
	movq	%rdx, (%rax)
	.loc 1 38 0
	movl	x.4519(%rip), %eax
	addl	$1, %eax
	movl	%eax, x.4519(%rip)
	movl	x.4519(%rip), %eax
	cmpl	$2, %eax
	jle	.L8
	.loc 1 39 0
	movl	$0, x.4519(%rip)
	.loc 1 40 0
	movl	$-32767, %eax
	jmp	.L9
.L8:
	.loc 1 42 0
	movl	$-32768, %eax
.L9:
	.loc 1 43 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.section .rdata,"dr"
.LC6:
	.ascii "error\0"
	.text
	.globl	smerror
	.def	smerror;	.scl	2;	.type	32;	.endef
	.seh_proc	smerror
smerror:
.LFB10:
	.loc 1 45 0
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
	.loc 1 46 0
	leaq	.LC6(%rip), %rcx
	call	puts
	.loc 1 47 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.section .rdata,"dr"
.LC7:
	.ascii "ok...\0"
	.text
	.globl	smok
	.def	smok;	.scl	2;	.type	32;	.endef
	.seh_proc	smok
smok:
.LFB11:
	.loc 1 49 0
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
	.loc 1 50 0
	leaq	.LC7(%rip), %rcx
	call	puts
	.loc 1 51 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.comm	TimerEmulation, 8, 3
	.globl	TimerInterruptEmulation
	.def	TimerInterruptEmulation;	.scl	2;	.type	32;	.endef
	.seh_proc	TimerInterruptEmulation
TimerInterruptEmulation:
.LFB12:
	.loc 1 56 0
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
	.loc 1 57 0
	movq	$0, -16(%rbp)
	movq	$10000000, -8(%rbp)
.L13:
	.loc 1 59 0 discriminator 1
	leaq	-16(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	nanosleep
	.loc 1 60 0 discriminator 1
	call	_qISRHandler
	.loc 1 61 0 discriminator 1
	jmp	.L13
	.cfi_endproc
.LFE12:
	.seh_endproc
	.comm	Task1, 80, 6
	.comm	Task2, 80, 6
	.comm	Task3, 80, 6
	.comm	Task4, 80, 6
	.comm	Task5, 80, 6
	.comm	Task6, 80, 6
	.comm	TaskTestST, 80, 6
	.section .rdata,"dr"
.LC8:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
	.text
	.globl	Task1Callback
	.def	Task1Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task1Callback
Task1Callback:
.LFB13:
	.loc 1 66 0
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
	.loc 1 67 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	nop
	.loc 1 68 0
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
	.section .rdata,"dr"
	.align 8
.LC9:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
	.text
	.globl	Task2Callback
	.def	Task2Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task2Callback
Task2Callback:
.LFB14:
	.loc 1 70 0
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
	.loc 1 72 0
	movzbl	24(%rbx), %eax
	testb	%al, %al
	je	.L16
	.loc 1 73 0
	movq	$0, 32(%rsp)
	leaq	smerror(%rip), %r9
	leaq	smok(%rip), %r8
	leaq	primero(%rip), %rdx
	leaq	Maquina1.4545(%rip), %rcx
	call	_qStateMachine_Init
.L16:
	.loc 1 75 0
	movq	%rbx, %rdx
	leaq	Maquina1.4545(%rip), %rcx
	call	_qStateMachine_Run
	.loc 1 76 0
	leaq	Task2(%rip), %rax
	movq	40(%rax), %rcx
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rcx, %r9
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC9(%rip), %rcx
	call	printf
	nop
	.loc 1 77 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.globl	Task3Callback
	.def	Task3Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task3Callback
Task3Callback:
.LFB15:
	.loc 1 79 0
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
	.loc 1 80 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	nop
	.loc 1 83 0
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
	.section .rdata,"dr"
	.align 8
.LC11:
	.ascii "Userdata : %s  Eventdata:%s    %d\15\12\0"
.LC12:
	.ascii "A\0"
.LC13:
	.ascii "B\0"
.LC15:
	.ascii "C\0"
.LC16:
	.ascii "D\0"
.LC18:
	.ascii "F\0"
.LC19:
	.ascii "G\0"
	.text
	.globl	Task4Callback
	.def	Task4Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task4Callback
Task4Callback:
.LFB16:
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
	.loc 1 87 0
	movzbl	24(%rbx), %eax
	testb	%al, %al
	je	.L19
	.loc 1 88 0
	movss	.LC10(%rip), %xmm1
	leaq	Timer.4552(%rip), %rcx
	call	_qSTimerSet
.L19:
	.loc 1 90 0
	leaq	Task4(%rip), %rax
	movq	40(%rax), %rcx
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rcx, %r9
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC11(%rip), %rcx
	call	printf
	.loc 1 91 0
	movl	_qCRTaskState_.4553(%rip), %eax
	cmpl	$98, %eax
	je	.L21
	cmpl	$98, %eax
	jg	.L22
	cmpl	$93, %eax
	je	.L23
	cmpl	$96, %eax
	je	.L24
	cmpl	$-32766, %eax
	je	.L25
	.loc 1 111 0
	jmp	.L18
.L22:
	.loc 1 91 0
	cmpl	$107, %eax
	je	.L26
	cmpl	$110, %eax
	je	.L32
	cmpl	$103, %eax
	je	.L28
	.loc 1 111 0
	jmp	.L18
.L32:
	nop
.L25:
	.loc 1 92 0
	leaq	.LC12(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 93 0
	movl	$93, _qCRTaskState_.4553(%rip)
	jmp	.L18
.L23:
	.loc 1 95 0
	leaq	.LC13(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 96 0
	movl	$96, _qCRTaskState_.4553(%rip)
	jmp	.L18
.L24:
	.loc 1 98 0
	movl	$98, _qCRTaskState_.4553(%rip)
.L21:
	.loc 1 98 0 is_stmt 0 discriminator 1
	leaq	Timer.4552(%rip), %rcx
	call	_qSTimerExpired
	testb	%al, %al
	jne	.L30
	.loc 1 98 0
	jmp	.L18
.L30:
	.loc 1 99 0 is_stmt 1
	movss	.LC14(%rip), %xmm1
	leaq	Timer.4552(%rip), %rcx
	call	_qSTimerSet
	.loc 1 100 0
	leaq	.LC15(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 101 0
	leaq	.LC16(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 102 0
	movss	.LC17(%rip), %xmm1
	leaq	Timer.4552(%rip), %rcx
	call	_qSTimerSet
	.loc 1 103 0
	movl	$103, _qCRTaskState_.4553(%rip)
	jmp	.L18
.L28:
	.loc 1 105 0
	leaq	.LC18(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 107 0
	movl	$107, _qCRTaskState_.4553(%rip)
.L26:
	.loc 1 107 0 is_stmt 0 discriminator 1
	leaq	Timer.4552(%rip), %rcx
	call	_qSTimerExpired
	testb	%al, %al
	jne	.L31
	.loc 1 107 0 discriminator 2
	jmp	.L18
.L31:
	.loc 1 109 0 is_stmt 1
	leaq	.LC19(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 110 0
	movl	$110, _qCRTaskState_.4553(%rip)
	nop
.L18:
	.loc 1 112 0
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
	.globl	Task5Callback
	.def	Task5Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task5Callback
Task5Callback:
.LFB17:
	.loc 1 114 0
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
	.loc 1 115 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	nop
	.loc 1 117 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.globl	Task6Callback
	.def	Task6Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task6Callback
Task6Callback:
.LFB18:
	.loc 1 119 0
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
	.loc 1 120 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	nop
	.loc 1 121 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.globl	IdleTaskCallback
	.def	IdleTaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	IdleTaskCallback
IdleTaskCallback:
.LFB19:
	.loc 1 124 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 126 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
	.section .rdata,"dr"
.LC20:
	.ascii "\15\12Scheduler Released\0"
	.text
	.globl	SchedReleaseCallback
	.def	SchedReleaseCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	SchedReleaseCallback
SchedReleaseCallback:
.LFB20:
	.loc 1 128 0
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
	.loc 1 129 0
	leaq	.LC20(%rip), %rcx
	call	puts
	nop
	.loc 1 130 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.seh_endproc
	.globl	TaskTestSTCallback
	.def	TaskTestSTCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	TaskTestSTCallback
TaskTestSTCallback:
.LFB21:
	.loc 1 132 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 135 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
	.comm	TaskX, 80, 6
	.comm	TaskY, 80, 6
	.globl	TaskX_Callback
	.def	TaskX_Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	TaskX_Callback
TaskX_Callback:
.LFB22:
	.loc 1 138 0
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
	.loc 1 139 0
	movl	_qCRTaskState_.4582(%rip), %eax
	cmpl	$141, %eax
	je	.L40
	cmpl	$141, %eax
	jg	.L41
	cmpl	$-32766, %eax
	je	.L42
	.loc 1 147 0
	jmp	.L38
.L41:
	.loc 1 139 0
	cmpl	$143, %eax
	je	.L43
	cmpl	$145, %eax
	je	.L46
	.loc 1 147 0
	jmp	.L38
.L46:
	nop
.L42:
	.loc 1 140 0
	movl	$97, %ecx
	call	putchar
	.loc 1 141 0
	movl	$141, _qCRTaskState_.4582(%rip)
	jmp	.L38
.L40:
	.loc 1 142 0
	movl	$98, %ecx
	call	putchar
	.loc 1 143 0
	movl	$143, _qCRTaskState_.4582(%rip)
	jmp	.L38
.L43:
	.loc 1 144 0
	movl	$99, %ecx
	call	putchar
	.loc 1 145 0
	movl	$145, _qCRTaskState_.4582(%rip)
	nop
.L38:
	.loc 1 148 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.seh_endproc
	.globl	TaskY_Callback
	.def	TaskY_Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	TaskY_Callback
TaskY_Callback:
.LFB23:
	.loc 1 150 0
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
	.loc 1 152 0
	movl	_qCRTaskState_.4592(%rip), %eax
	cmpl	$154, %eax
	je	.L49
	cmpl	$154, %eax
	jg	.L50
	cmpl	$-32766, %eax
	je	.L51
	.loc 1 160 0
	jmp	.L47
.L50:
	.loc 1 152 0
	cmpl	$156, %eax
	je	.L52
	cmpl	$158, %eax
	je	.L55
	.loc 1 160 0
	jmp	.L47
.L55:
	nop
.L51:
	.loc 1 153 0
	movl	$49, %ecx
	call	putchar
	.loc 1 154 0
	movl	$154, _qCRTaskState_.4592(%rip)
	jmp	.L47
.L49:
	.loc 1 155 0
	movl	$50, %ecx
	call	putchar
	.loc 1 156 0
	movl	$156, _qCRTaskState_.4592(%rip)
	jmp	.L47
.L52:
	.loc 1 157 0
	leaq	.LC5(%rip), %rcx
	call	puts
	.loc 1 158 0
	movl	$158, _qCRTaskState_.4592(%rip)
	nop
.L47:
	.loc 1 161 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC22:
	.ascii "TASK1\0"
.LC24:
	.ascii "TASK2\0"
.LC26:
	.ascii "TASK3\0"
.LC28:
	.ascii "TASK4\0"
.LC30:
	.ascii "TASK5\0"
.LC31:
	.ascii "TASK6\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB24:
	.loc 1 163 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	.seh_stackalloc	224
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	.loc 1 163 0
	call	__main
	.loc 1 164 0
	movl	$0, %r9d
	leaq	TimerInterruptEmulation(%rip), %r8
	movl	$0, %edx
	leaq	TimerEmulation(%rip), %rax
	movq	%rax, %rcx
	call	pthread_create
	.loc 1 165 0
	leaq	-160(%rbp), %rax
	movl	$10, %r9d
	movq	%rax, %r8
	leaq	IdleTaskCallback(%rip), %rdx
	movss	.LC21(%rip), %xmm0
	call	_qInitScheduler
	.loc 1 167 0
	leaq	.LC22(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$0, 40(%rsp)
	movl	$1, 32(%rsp)
	pxor	%xmm3, %xmm3
	movl	$254, %r8d
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 168 0
	leaq	.LC24(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	movss	.LC25(%rip), %xmm3
	movl	$20, %r8d
	leaq	Task2Callback(%rip), %rdx
	leaq	Task2(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 169 0
	leaq	Task2(%rip), %rax
	movb	$1, 68(%rax)
	.loc 1 170 0
	leaq	.LC26(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$2, 32(%rsp)
	movss	.LC27(%rip), %xmm3
	movl	$127, %r8d
	leaq	Task3Callback(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 171 0
	leaq	.LC28(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	movss	.LC29(%rip), %xmm3
	movl	$127, %r8d
	leaq	Task4Callback(%rip), %rdx
	leaq	Task4(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 172 0
	leaq	.LC30(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$1, 32(%rsp)
	movss	.LC14(%rip), %xmm3
	movl	$127, %r8d
	leaq	Task5Callback(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 173 0
	leaq	.LC31(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$5, 32(%rsp)
	pxor	%xmm3, %xmm3
	movl	$127, %r8d
	leaq	Task6Callback(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 178 0
	call	_qStart
	.loc 1 179 0
	movl	$0, %eax
	.loc 1 180 0
	addq	$224, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.seh_endproc
.lcomm x.4519,4,4
.lcomm Maquina1.4545,32,32
.lcomm Timer.4552,24,16
	.data
	.align 4
_qCRTaskState_.4553:
	.long	-32766
	.align 4
_qCRTaskState_.4582:
	.long	-32766
	.align 4
_qCRTaskState_.4592:
	.long	-32766
	.section .rdata,"dr"
	.align 4
.LC10:
	.long	1084227584
	.align 4
.LC14:
	.long	1073741824
	.align 4
.LC17:
	.long	1082130432
	.align 4
.LC21:
	.long	1008981770
	.align 4
.LC25:
	.long	1056964608
	.align 4
.LC27:
	.long	1065353216
	.align 4
.LC29:
	.long	1036831949
	.text
.Letext0:
	.file 2 "/usr/include/sys/_timespec.h"
	.file 3 "/usr/include/cygwin/types.h"
	.file 4 "/usr/include/sys/types.h"
	.file 5 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xbaf
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
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.ascii "short int\0"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
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
	.uleb128 0x3
	.byte	0x8
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.ascii "long long int\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "sizetype\0"
	.uleb128 0x4
	.byte	0x8
	.long	0xfa
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x5
	.ascii "time_t\0"
	.byte	0x4
	.byte	0x7c
	.long	0xd9
	.uleb128 0x6
	.ascii "timespec\0"
	.byte	0x10
	.byte	0x2
	.byte	0x2c
	.long	0x180
	.uleb128 0x7
	.ascii "tv_sec\0"
	.byte	0x2
	.byte	0x2d
	.long	0x141
	.byte	0
	.uleb128 0x7
	.ascii "tv_nsec\0"
	.byte	0x2
	.byte	0x2e
	.long	0xd9
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.ascii "__pthread_t\0"
	.byte	0x1
	.byte	0x3
	.byte	0xb3
	.long	0x1a5
	.uleb128 0x7
	.ascii "__dummy\0"
	.byte	0x3
	.byte	0xb3
	.long	0xfa
	.byte	0
	.byte	0
	.uleb128 0x5
	.ascii "pthread_t\0"
	.byte	0x3
	.byte	0xb3
	.long	0x1b6
	.uleb128 0x4
	.byte	0x8
	.long	0x180
	.uleb128 0x8
	.ascii "qTaskPC_t_\0"
	.byte	0x4
	.byte	0x5
	.byte	0x23
	.long	0x1e2
	.uleb128 0x9
	.ascii "qCR_PCInitVal\0"
	.sleb128 -32766
	.byte	0
	.uleb128 0x5
	.ascii "_qTaskPC_t\0"
	.byte	0x5
	.byte	0x23
	.long	0x1bc
	.uleb128 0xa
	.byte	0x4
	.byte	0x5
	.byte	0x37
	.long	0x23d
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
	.byte	0
	.uleb128 0x5
	.ascii "qTrigger_t\0"
	.byte	0x5
	.byte	0x37
	.long	0x1f4
	.uleb128 0x5
	.ascii "qTime_t\0"
	.byte	0x5
	.byte	0x38
	.long	0x25e
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x5
	.ascii "qClock_t\0"
	.byte	0x5
	.byte	0x39
	.long	0x277
	.uleb128 0xb
	.long	0xe5
	.uleb128 0x5
	.ascii "qPriority_t\0"
	.byte	0x5
	.byte	0x3a
	.long	0x8e
	.uleb128 0x5
	.ascii "qIteration_t\0"
	.byte	0x5
	.byte	0x3b
	.long	0x8e
	.uleb128 0x5
	.ascii "qBool_t\0"
	.byte	0x5
	.byte	0x3d
	.long	0x8e
	.uleb128 0xc
	.byte	0x20
	.byte	0x5
	.byte	0x4b
	.long	0x2fb
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x5
	.byte	0x4c
	.long	0x23d
	.byte	0
	.uleb128 0xd
	.secrel32	.LASF0
	.byte	0x5
	.byte	0x4d
	.long	0x102
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x5
	.byte	0x4e
	.long	0x102
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x5
	.byte	0x4f
	.long	0x2a3
	.byte	0x18
	.byte	0
	.uleb128 0x5
	.ascii "qEvent_t\0"
	.byte	0x5
	.byte	0x50
	.long	0x2b2
	.uleb128 0x5
	.ascii "qTaskFcn_t\0"
	.byte	0x5
	.byte	0x52
	.long	0x31d
	.uleb128 0x4
	.byte	0x8
	.long	0x323
	.uleb128 0xe
	.long	0x32e
	.uleb128 0xf
	.long	0x2fb
	.byte	0
	.uleb128 0xc
	.byte	0x5
	.byte	0x5
	.byte	0x54
	.long	0x392
	.uleb128 0x7
	.ascii "TimedTaskRun\0"
	.byte	0x5
	.byte	0x55
	.long	0x392
	.byte	0
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x5
	.byte	0x56
	.long	0x392
	.byte	0x1
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x5
	.byte	0x57
	.long	0x392
	.byte	0x2
	.uleb128 0x7
	.ascii "State\0"
	.byte	0x5
	.byte	0x58
	.long	0x392
	.byte	0x3
	.uleb128 0x7
	.ascii "IgnoreOveruns\0"
	.byte	0x5
	.byte	0x59
	.long	0x392
	.byte	0x4
	.byte	0
	.uleb128 0xb
	.long	0x8e
	.uleb128 0x5
	.ascii "qTaskFlags_t\0"
	.byte	0x5
	.byte	0x5a
	.long	0x32e
	.uleb128 0x6
	.ascii "_qTask_t\0"
	.byte	0x50
	.byte	0x5
	.byte	0x5c
	.long	0x45e
	.uleb128 0xd
	.secrel32	.LASF0
	.byte	0x5
	.byte	0x5d
	.long	0x102
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x5
	.byte	0x5d
	.long	0x102
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x5
	.byte	0x5e
	.long	0x267
	.byte	0x10
	.uleb128 0x7
	.ascii "TimeElapsed\0"
	.byte	0x5
	.byte	0x5e
	.long	0x267
	.byte	0x18
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x5
	.byte	0x5f
	.long	0x28f
	.byte	0x20
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x5
	.byte	0x60
	.long	0xe5
	.byte	0x28
	.uleb128 0x7
	.ascii "Priority\0"
	.byte	0x5
	.byte	0x61
	.long	0x27c
	.byte	0x30
	.uleb128 0x7
	.ascii "Callback\0"
	.byte	0x5
	.byte	0x62
	.long	0x30b
	.byte	0x38
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x5
	.byte	0x63
	.long	0x45e
	.byte	0x40
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x5
	.byte	0x64
	.long	0x463
	.byte	0x48
	.byte	0
	.uleb128 0xb
	.long	0x397
	.uleb128 0x4
	.byte	0x8
	.long	0x469
	.uleb128 0xb
	.long	0x3ab
	.uleb128 0xc
	.byte	0x10
	.byte	0x5
	.byte	0x68
	.long	0x496
	.uleb128 0x7
	.ascii "Task\0"
	.byte	0x5
	.byte	0x69
	.long	0x463
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x5
	.byte	0x6a
	.long	0x102
	.byte	0x8
	.byte	0
	.uleb128 0x5
	.ascii "qQueueStack_t\0"
	.byte	0x5
	.byte	0x6b
	.long	0x46e
	.uleb128 0x8
	.ascii "state\0"
	.byte	0x4
	.byte	0x5
	.byte	0xb4
	.long	0x4e4
	.uleb128 0x9
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0x9
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x5
	.ascii "qSM_Status_t\0"
	.byte	0x5
	.byte	0xb4
	.long	0x4ab
	.uleb128 0x6
	.ascii "_qSM_t\0"
	.byte	0x20
	.byte	0x5
	.byte	0xb6
	.long	0x559
	.uleb128 0x7
	.ascii "NextState\0"
	.byte	0x5
	.byte	0xb7
	.long	0x573
	.byte	0
	.uleb128 0x7
	.ascii "PreviousState\0"
	.byte	0x5
	.byte	0xb8
	.long	0x573
	.byte	0x8
	.uleb128 0x7
	.ascii "PreviousReturnStatus\0"
	.byte	0x5
	.byte	0xb9
	.long	0x4e4
	.byte	0x10
	.uleb128 0xd
	.secrel32	.LASF0
	.byte	0x5
	.byte	0xba
	.long	0x102
	.byte	0x18
	.byte	0
	.uleb128 0x10
	.long	0x4e4
	.long	0x568
	.uleb128 0xf
	.long	0x568
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.long	0x56e
	.uleb128 0xb
	.long	0x4f8
	.uleb128 0x4
	.byte	0x8
	.long	0x559
	.uleb128 0xc
	.byte	0x18
	.byte	0x5
	.byte	0xd3
	.long	0x5a6
	.uleb128 0x7
	.ascii "SR\0"
	.byte	0x5
	.byte	0xd4
	.long	0x8e
	.byte	0
	.uleb128 0x7
	.ascii "Start\0"
	.byte	0x5
	.byte	0xd5
	.long	0x267
	.byte	0x8
	.uleb128 0x7
	.ascii "TV\0"
	.byte	0x5
	.byte	0xd5
	.long	0x267
	.byte	0x10
	.byte	0
	.uleb128 0x5
	.ascii "qSTimer_t\0"
	.byte	0x5
	.byte	0xd6
	.long	0x579
	.uleb128 0x11
	.ascii "primero\0"
	.byte	0x1
	.byte	0xe
	.long	0x4e4
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x603
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0xe
	.long	0x568
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "TaskEventData\0"
	.byte	0x1
	.byte	0xf
	.long	0x603
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.long	0x2fb
	.uleb128 0x11
	.ascii "segundo\0"
	.byte	0x1
	.byte	0x1c
	.long	0x4e4
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x63d
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x1c
	.long	0x568
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x11
	.ascii "tercero\0"
	.byte	0x1
	.byte	0x22
	.long	0x4e4
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x684
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x22
	.long	0x568
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "x\0"
	.byte	0x1
	.byte	0x23
	.long	0xc2
	.uleb128 0x9
	.byte	0x3
	.quad	x.4519
	.byte	0
	.uleb128 0x11
	.ascii "smerror\0"
	.byte	0x1
	.byte	0x2d
	.long	0x4e4
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x6b8
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x2d
	.long	0x568
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x11
	.ascii "smok\0"
	.byte	0x1
	.byte	0x31
	.long	0x4e4
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x6e9
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x31
	.long	0x568
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x11
	.ascii "TimerInterruptEmulation\0"
	.byte	0x1
	.byte	0x38
	.long	0x102
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x741
	.uleb128 0x14
	.ascii "varargin\0"
	.byte	0x1
	.byte	0x38
	.long	0x102
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "tick\0"
	.byte	0x1
	.byte	0x39
	.long	0x14f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x15
	.ascii "Task1Callback\0"
	.byte	0x1
	.byte	0x42
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x777
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x42
	.long	0x2fb
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "Task2Callback\0"
	.byte	0x1
	.byte	0x46
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x7c7
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x46
	.long	0x2fb
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x13
	.ascii "Maquina1\0"
	.byte	0x1
	.byte	0x47
	.long	0x56e
	.uleb128 0x9
	.byte	0x3
	.quad	Maquina1.4545
	.byte	0
	.uleb128 0x15
	.ascii "Task3Callback\0"
	.byte	0x1
	.byte	0x4f
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0x7fd
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x4f
	.long	0x2fb
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "Task4Callback\0"
	.byte	0x1
	.byte	0x55
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0x86e
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x55
	.long	0x2fb
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x13
	.ascii "Timer\0"
	.byte	0x1
	.byte	0x56
	.long	0x5a6
	.uleb128 0x9
	.byte	0x3
	.quad	Timer.4552
	.uleb128 0x16
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x5b
	.long	0x1e2
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4553
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x5b
	.quad	.L25
	.byte	0
	.uleb128 0x15
	.ascii "Task5Callback\0"
	.byte	0x1
	.byte	0x72
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0x8a4
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x72
	.long	0x2fb
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "Task6Callback\0"
	.byte	0x1
	.byte	0x77
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x8da
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x77
	.long	0x2fb
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x18
	.ascii "IdleTaskCallback\0"
	.byte	0x1
	.byte	0x7c
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0x913
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x7c
	.long	0x2fb
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "SchedReleaseCallback\0"
	.byte	0x1
	.byte	0x80
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0x950
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x80
	.long	0x2fb
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x18
	.ascii "TaskTestSTCallback\0"
	.byte	0x1
	.byte	0x84
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0x98b
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x84
	.long	0x2fb
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "TaskX_Callback\0"
	.byte	0x1
	.byte	0x8a
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x9e6
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x8a
	.long	0x2fb
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x16
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x8b
	.long	0x1e2
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4582
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x8b
	.quad	.L42
	.byte	0
	.uleb128 0x15
	.ascii "TaskY_Callback\0"
	.byte	0x1
	.byte	0x96
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0xa4a
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x96
	.long	0x2fb
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x19
	.ascii "i\0"
	.byte	0x1
	.byte	0x97
	.long	0xc2
	.uleb128 0x16
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x98
	.long	0x1e2
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4592
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x98
	.quad	.L51
	.byte	0
	.uleb128 0x11
	.ascii "main\0"
	.byte	0x1
	.byte	0xa3
	.long	0xc2
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0xaa3
	.uleb128 0x14
	.ascii "argc\0"
	.byte	0x1
	.byte	0xa3
	.long	0xc2
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x14
	.ascii "argv\0"
	.byte	0x1
	.byte	0xa3
	.long	0xaa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x13
	.ascii "_qQueueStack\0"
	.byte	0x1
	.byte	0xa5
	.long	0xab9
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.long	0x121
	.uleb128 0x1a
	.long	0x496
	.long	0xab9
	.uleb128 0x1b
	.long	0x115
	.byte	0x9
	.byte	0
	.uleb128 0xb
	.long	0xaa9
	.uleb128 0x1c
	.ascii "TimerEmulation\0"
	.byte	0x1
	.byte	0x37
	.long	0x1a5
	.uleb128 0x9
	.byte	0x3
	.quad	TimerEmulation
	.uleb128 0x1c
	.ascii "Task1\0"
	.byte	0x1
	.byte	0x40
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	Task1
	.uleb128 0x1c
	.ascii "Task2\0"
	.byte	0x1
	.byte	0x40
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	Task2
	.uleb128 0x1c
	.ascii "Task3\0"
	.byte	0x1
	.byte	0x40
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	Task3
	.uleb128 0x1c
	.ascii "Task4\0"
	.byte	0x1
	.byte	0x40
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	Task4
	.uleb128 0x1c
	.ascii "Task5\0"
	.byte	0x1
	.byte	0x40
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	Task5
	.uleb128 0x1c
	.ascii "Task6\0"
	.byte	0x1
	.byte	0x40
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	Task6
	.uleb128 0x1c
	.ascii "TaskTestST\0"
	.byte	0x1
	.byte	0x40
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	TaskTestST
	.uleb128 0x1c
	.ascii "TaskX\0"
	.byte	0x1
	.byte	0x89
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	TaskX
	.uleb128 0x1c
	.ascii "TaskY\0"
	.byte	0x1
	.byte	0x89
	.long	0x469
	.uleb128 0x9
	.byte	0x3
	.quad	TaskY
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
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
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
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x12
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
	.uleb128 0x13
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
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x16
	.uleb128 0x34
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
	.uleb128 0x17
	.uleb128 0xa
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x18
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
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
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
.LASF4:
	.ascii "_qCR_BEGIN_\0"
.LASF2:
	.ascii "Data\0"
.LASF1:
	.ascii "Machine\0"
.LASF3:
	.ascii "_qCRTaskState_\0"
.LASF0:
	.ascii "UserData\0"
	.ident	"GCC: (GNU) 4.9.3"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	_qISRHandler;	.scl	2;	.type	32;	.endef
	.def	_qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.def	_qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.def	_qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	_qEnqueueTaskEvent;	.scl	2;	.type	32;	.endef
	.def	_qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	_qCreateTask;	.scl	2;	.type	32;	.endef
	.def	_qStart;	.scl	2;	.type	32;	.endef
