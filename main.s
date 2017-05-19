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
	movq	16(%rbp), %rax
	movzbl	20(%rax), %eax
	.loc 1 41 0
	leaq	.LC5(%rip), %rcx
	call	puts
	.loc 1 42 0
	movq	16(%rbp), %rax
	leaq	primero(%rip), %rdx
	movq	%rdx, (%rax)
	.loc 1 43 0
	movl	x.4553(%rip), %eax
	addl	$1, %eax
	movl	%eax, x.4553(%rip)
	movl	x.4553(%rip), %eax
	cmpl	$2, %eax
	jle	.L8
	.loc 1 44 0
	movl	$0, x.4553(%rip)
	.loc 1 45 0
	movl	$-32767, %eax
	jmp	.L9
.L8:
	.loc 1 47 0
	movl	$-32768, %eax
.L9:
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
.LC6:
	.ascii "error\0"
	.text
	.globl	smerror
	.def	smerror;	.scl	2;	.type	32;	.endef
	.seh_proc	smerror
smerror:
.LFB10:
	.loc 1 50 0
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
	.loc 1 51 0
	leaq	.LC6(%rip), %rcx
	call	puts
	nop
	.loc 1 52 0
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
	.loc 1 54 0
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
	.loc 1 55 0
	leaq	.LC7(%rip), %rcx
	call	puts
	nop
	.loc 1 56 0
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
	.loc 1 60 0
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
	.loc 1 61 0
	movq	$0, -16(%rbp)
	movq	$10000000, -8(%rbp)
.L13:
	.loc 1 63 0 discriminator 1
	leaq	-16(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	nanosleep
	.loc 1 64 0 discriminator 1
	call	_qISRHandler
	.loc 1 65 0 discriminator 1
	jmp	.L13
	.cfi_endproc
.LFE12:
	.seh_endproc
	.comm	Task1, 64, 6
	.comm	Task2, 64, 6
	.comm	Task3, 64, 6
	.comm	Task4, 64, 6
	.comm	Task5, 64, 6
	.comm	Task6, 64, 6
	.comm	TaskTestST, 64, 6
	.section .rdata,"dr"
.LC8:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
	.text
	.globl	Task1Callback
	.def	Task1Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task1Callback
Task1Callback:
.LFB13:
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -64
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 71 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	nop
	.loc 1 72 0
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
	.loc 1 74 0
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
	movzbl	24(%rbx), %eax
	testb	%al, %al
	je	.L16
	.loc 1 77 0
	movq	$0, 32(%rsp)
	leaq	smerror(%rip), %r9
	leaq	smok(%rip), %r8
	leaq	primero(%rip), %rdx
	leaq	Maquina1.4579(%rip), %rcx
	call	_qStateMachine_Init
.L16:
	.loc 1 79 0
	movq	%rbx, %rdx
	leaq	Maquina1.4579(%rip), %rcx
	call	_qStateMachine_Run
	.loc 1 80 0
	leaq	Task2(%rip), %rax
	movl	28(%rax), %ecx
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movl	%ecx, %r9d
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC9(%rip), %rcx
	call	printf
	nop
	.loc 1 81 0
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
	leaq	.LC8(%rip), %rcx
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
.LFE15:
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC10:
	.ascii "Userdata : %s  Eventdata:%s    %d  \15\12\0"
.LC11:
	.ascii "A\0"
.LC12:
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
	.loc 1 94 0
	leaq	Task4(%rip), %rax
	movl	28(%rax), %ecx
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movl	%ecx, %r9d
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC10(%rip), %rcx
	call	printf
	.loc 1 95 0
	movl	_qCRTaskState_.4587(%rip), %eax
	cmpl	$102, %eax
	je	.L20
	cmpl	$102, %eax
	jg	.L21
	cmpl	$97, %eax
	je	.L22
	cmpl	$100, %eax
	je	.L23
	cmpl	$-32766, %eax
	je	.L24
	.loc 1 114 0
	jmp	.L18
.L21:
	.loc 1 95 0
	cmpl	$110, %eax
	je	.L25
	cmpl	$113, %eax
	je	.L31
	cmpl	$107, %eax
	je	.L27
	.loc 1 114 0
	jmp	.L18
.L31:
	nop
.L24:
	.loc 1 96 0
	leaq	.LC11(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 97 0
	movl	$97, _qCRTaskState_.4587(%rip)
	jmp	.L18
.L22:
	.loc 1 99 0
	leaq	.LC12(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 100 0
	movl	$100, _qCRTaskState_.4587(%rip)
	jmp	.L18
.L23:
	.loc 1 101 0
	movss	.LC13(%rip), %xmm1
	leaq	Timer.4586(%rip), %rcx
	call	_qSTimerSet
	.loc 1 102 0
	movl	$102, _qCRTaskState_.4587(%rip)
.L20:
	.loc 1 102 0 is_stmt 0 discriminator 1
	leaq	Timer.4586(%rip), %rcx
	call	_qSTimerExpired
	testb	%al, %al
	jne	.L29
	.loc 1 102 0
	jmp	.L18
.L29:
	.loc 1 103 0 is_stmt 1
	movss	.LC14(%rip), %xmm1
	leaq	Timer.4586(%rip), %rcx
	call	_qSTimerSet
	.loc 1 104 0
	leaq	.LC15(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 105 0
	leaq	.LC16(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 106 0
	movss	.LC17(%rip), %xmm1
	leaq	Timer.4586(%rip), %rcx
	call	_qSTimerSet
	.loc 1 107 0
	movl	$107, _qCRTaskState_.4587(%rip)
	jmp	.L18
.L27:
	.loc 1 108 0
	leaq	.LC18(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 110 0
	movl	$110, _qCRTaskState_.4587(%rip)
.L25:
	.loc 1 110 0 is_stmt 0 discriminator 1
	leaq	Timer.4586(%rip), %rcx
	call	_qSTimerExpired
	testb	%al, %al
	jne	.L30
	.loc 1 110 0 discriminator 2
	jmp	.L18
.L30:
	.loc 1 112 0 is_stmt 1
	leaq	.LC19(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 113 0
	movl	$113, _qCRTaskState_.4587(%rip)
	nop
.L18:
	.loc 1 115 0
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
	.loc 1 117 0
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
	.loc 1 118 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	nop
	.loc 1 120 0
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
	.loc 1 122 0
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
	.loc 1 123 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	nop
	.loc 1 124 0
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
	.loc 1 126 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 128 0
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
	.loc 1 130 0
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
	.loc 1 131 0
	leaq	.LC20(%rip), %rcx
	call	puts
	nop
	.loc 1 132 0
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
	.loc 1 134 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 137 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
	.comm	TaskX, 64, 6
	.comm	TaskY, 64, 6
	.globl	TaskX_Callback
	.def	TaskX_Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	TaskX_Callback
TaskX_Callback:
.LFB22:
	.loc 1 140 0
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
	.loc 1 141 0
	movl	_qCRTaskState_.4616(%rip), %eax
	cmpl	$143, %eax
	je	.L39
	cmpl	$143, %eax
	jg	.L40
	cmpl	$-32766, %eax
	je	.L41
	.loc 1 149 0
	jmp	.L37
.L40:
	.loc 1 141 0
	cmpl	$145, %eax
	je	.L42
	cmpl	$147, %eax
	je	.L45
	.loc 1 149 0
	jmp	.L37
.L45:
	nop
.L41:
	.loc 1 142 0
	movl	$97, %ecx
	call	putchar
	.loc 1 143 0
	movl	$143, _qCRTaskState_.4616(%rip)
	jmp	.L37
.L39:
	.loc 1 144 0
	movl	$98, %ecx
	call	putchar
	.loc 1 145 0
	movl	$145, _qCRTaskState_.4616(%rip)
	jmp	.L37
.L42:
	.loc 1 146 0
	movl	$99, %ecx
	call	putchar
	.loc 1 147 0
	movl	$147, _qCRTaskState_.4616(%rip)
	nop
.L37:
	.loc 1 150 0
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
	.loc 1 152 0
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
	.loc 1 154 0
	movl	_qCRTaskState_.4626(%rip), %eax
	cmpl	$156, %eax
	je	.L48
	cmpl	$156, %eax
	jg	.L49
	cmpl	$-32766, %eax
	je	.L50
	.loc 1 162 0
	jmp	.L46
.L49:
	.loc 1 154 0
	cmpl	$158, %eax
	je	.L51
	cmpl	$160, %eax
	je	.L54
	.loc 1 162 0
	jmp	.L46
.L54:
	nop
.L50:
	.loc 1 155 0
	movl	$49, %ecx
	call	putchar
	.loc 1 156 0
	movl	$156, _qCRTaskState_.4626(%rip)
	jmp	.L46
.L48:
	.loc 1 157 0
	movl	$50, %ecx
	call	putchar
	.loc 1 158 0
	movl	$158, _qCRTaskState_.4626(%rip)
	jmp	.L46
.L51:
	.loc 1 159 0
	leaq	.LC5(%rip), %rcx
	call	puts
	.loc 1 160 0
	movl	$160, _qCRTaskState_.4626(%rip)
	nop
.L46:
	.loc 1 163 0
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
	.loc 1 165 0
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
	.loc 1 165 0
	call	__main
	.loc 1 166 0
	movl	$0, %r9d
	leaq	TimerInterruptEmulation(%rip), %r8
	movl	$0, %edx
	leaq	TimerEmulation(%rip), %rax
	movq	%rax, %rcx
	call	pthread_create
	.loc 1 167 0
	leaq	-160(%rbp), %rax
	movl	$10, %r9d
	movq	%rax, %r8
	leaq	IdleTaskCallback(%rip), %rdx
	movss	.LC21(%rip), %xmm0
	call	_qInitScheduler
	.loc 1 169 0
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
	.loc 1 170 0
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
	.loc 1 171 0
	leaq	Task2(%rip), %rax
	movb	$1, 51(%rax)
	.loc 1 172 0
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
	.loc 1 173 0
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
	.loc 1 174 0
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
	.loc 1 175 0
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
	.loc 1 179 0
	call	_qStart
	.loc 1 180 0
	movl	$0, %eax
	.loc 1 181 0
	addq	$224, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.seh_endproc
.lcomm x.4553,4,4
.lcomm Maquina1.4579,56,32
	.data
	.align 4
_qCRTaskState_.4587:
	.long	-32766
.lcomm Timer.4586,12,4
	.align 4
_qCRTaskState_.4616:
	.long	-32766
	.align 4
_qCRTaskState_.4626:
	.long	-32766
	.section .rdata,"dr"
	.align 4
.LC13:
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
	.file 2 "/usr/include/machine/_default_types.h"
	.file 3 "/usr/include/sys/_stdint.h"
	.file 4 "/usr/include/sys/types.h"
	.file 5 "/usr/include/sys/_timespec.h"
	.file 6 "/usr/include/cygwin/types.h"
	.file 7 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xc73
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
	.long	0xec
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
	.long	0x11d
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
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x20
	.long	0xda
	.uleb128 0x3
	.ascii "time_t\0"
	.byte	0x4
	.byte	0x7c
	.long	0xfc
	.uleb128 0x6
	.ascii "timespec\0"
	.byte	0x10
	.byte	0x5
	.byte	0x2c
	.long	0x1c2
	.uleb128 0x7
	.ascii "tv_sec\0"
	.byte	0x5
	.byte	0x2d
	.long	0x183
	.byte	0
	.uleb128 0x7
	.ascii "tv_nsec\0"
	.byte	0x5
	.byte	0x2e
	.long	0xfc
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.ascii "__pthread_t\0"
	.byte	0x1
	.byte	0x6
	.byte	0xb3
	.long	0x1e7
	.uleb128 0x7
	.ascii "__dummy\0"
	.byte	0x6
	.byte	0xb3
	.long	0x11d
	.byte	0
	.byte	0
	.uleb128 0x3
	.ascii "pthread_t\0"
	.byte	0x6
	.byte	0xb3
	.long	0x1f8
	.uleb128 0x5
	.byte	0x8
	.long	0x1c2
	.uleb128 0x8
	.ascii "qTaskPC_t_\0"
	.byte	0x4
	.byte	0x7
	.byte	0x26
	.long	0x224
	.uleb128 0x9
	.ascii "qCR_PCInitVal\0"
	.sleb128 -32766
	.byte	0
	.uleb128 0x3
	.ascii "_qTaskPC_t\0"
	.byte	0x7
	.byte	0x26
	.long	0x1fe
	.uleb128 0xa
	.byte	0x4
	.byte	0x7
	.byte	0x38
	.long	0x27f
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
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x7
	.byte	0x38
	.long	0x236
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x7
	.byte	0x39
	.long	0x2a0
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x7
	.byte	0x3a
	.long	0x2b9
	.uleb128 0xb
	.long	0x173
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x7
	.byte	0x3b
	.long	0x164
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x7
	.byte	0x3c
	.long	0x164
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x7
	.byte	0x3e
	.long	0x164
	.uleb128 0xc
	.byte	0x20
	.byte	0x7
	.byte	0x4c
	.long	0x33d
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x7
	.byte	0x5f
	.long	0x27f
	.byte	0
	.uleb128 0xd
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x63
	.long	0x125
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x7
	.byte	0x67
	.long	0x125
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x7
	.byte	0x6c
	.long	0x2e5
	.byte	0x18
	.byte	0
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x7
	.byte	0x6d
	.long	0x2f4
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x7
	.byte	0x6f
	.long	0x35f
	.uleb128 0x5
	.byte	0x8
	.long	0x365
	.uleb128 0xe
	.long	0x370
	.uleb128 0xf
	.long	0x33d
	.byte	0
	.uleb128 0xc
	.byte	0x5
	.byte	0x7
	.byte	0x70
	.long	0x3d6
	.uleb128 0x7
	.ascii "TimedTaskRun\0"
	.byte	0x7
	.byte	0x71
	.long	0x3d6
	.byte	0
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x7
	.byte	0x71
	.long	0x3d6
	.byte	0x1
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x7
	.byte	0x71
	.long	0x3d6
	.byte	0x2
	.uleb128 0x7
	.ascii "IgnoreOveruns\0"
	.byte	0x7
	.byte	0x71
	.long	0x3d6
	.byte	0x3
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x7
	.byte	0x71
	.long	0x3d6
	.byte	0x4
	.byte	0
	.uleb128 0xb
	.long	0x164
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x7
	.byte	0x72
	.long	0x370
	.uleb128 0x6
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x7
	.byte	0x76
	.long	0x4a2
	.uleb128 0xd
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x77
	.long	0x125
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x7
	.byte	0x77
	.long	0x125
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x7
	.byte	0x78
	.long	0x2a9
	.byte	0x10
	.uleb128 0x7
	.ascii "TimeElapsed\0"
	.byte	0x7
	.byte	0x78
	.long	0x2a9
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x7
	.byte	0x79
	.long	0x2d1
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x7
	.byte	0x7a
	.long	0x173
	.byte	0x1c
	.uleb128 0x7
	.ascii "Priority\0"
	.byte	0x7
	.byte	0x7b
	.long	0x2be
	.byte	0x20
	.uleb128 0x7
	.ascii "Callback\0"
	.byte	0x7
	.byte	0x7c
	.long	0x34d
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x7
	.byte	0x7d
	.long	0x4a2
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x7
	.byte	0x7e
	.long	0x4a7
	.byte	0x38
	.byte	0
	.uleb128 0xb
	.long	0x3db
	.uleb128 0x5
	.byte	0x8
	.long	0x4ad
	.uleb128 0xb
	.long	0x3ef
	.uleb128 0xc
	.byte	0x10
	.byte	0x7
	.byte	0x82
	.long	0x4da
	.uleb128 0x7
	.ascii "Task\0"
	.byte	0x7
	.byte	0x83
	.long	0x4a7
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x7
	.byte	0x84
	.long	0x125
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x7
	.byte	0x85
	.long	0x4b2
	.uleb128 0x10
	.ascii "state\0"
	.byte	0x4
	.byte	0x7
	.word	0x1e2
	.long	0x529
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
	.word	0x1e2
	.long	0x4ef
	.uleb128 0x12
	.byte	0x18
	.byte	0x7
	.word	0x1fb
	.long	0x584
	.uleb128 0x13
	.ascii "__Failure\0"
	.byte	0x7
	.word	0x1fc
	.long	0x625
	.byte	0
	.uleb128 0x13
	.ascii "__Success\0"
	.byte	0x7
	.word	0x1fd
	.long	0x625
	.byte	0x8
	.uleb128 0x13
	.ascii "__Unexpected\0"
	.byte	0x7
	.word	0x1fe
	.long	0x625
	.byte	0x10
	.byte	0
	.uleb128 0xe
	.long	0x58f
	.uleb128 0xf
	.long	0x58f
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x595
	.uleb128 0xb
	.long	0x59a
	.uleb128 0x14
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x7
	.word	0x1e6
	.long	0x625
	.uleb128 0x13
	.ascii "NextState\0"
	.byte	0x7
	.word	0x1ea
	.long	0x63a
	.byte	0
	.uleb128 0x13
	.ascii "PreviousState\0"
	.byte	0x7
	.word	0x1ee
	.long	0x63a
	.byte	0x8
	.uleb128 0x13
	.ascii "PreviousReturnStatus\0"
	.byte	0x7
	.word	0x1f2
	.long	0x529
	.byte	0x10
	.uleb128 0x13
	.ascii "StateJustChanged\0"
	.byte	0x7
	.word	0x1f6
	.long	0x2e5
	.byte	0x14
	.uleb128 0x15
	.secrel32	.LASF1
	.byte	0x7
	.word	0x1fa
	.long	0x125
	.byte	0x18
	.uleb128 0x13
	.ascii "_\0"
	.byte	0x7
	.word	0x1ff
	.long	0x53e
	.byte	0x20
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x584
	.uleb128 0x16
	.long	0x529
	.long	0x63a
	.uleb128 0xf
	.long	0x58f
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x62b
	.uleb128 0x12
	.byte	0xc
	.byte	0x7
	.word	0x25f
	.long	0x671
	.uleb128 0x13
	.ascii "SR\0"
	.byte	0x7
	.word	0x260
	.long	0x164
	.byte	0
	.uleb128 0x13
	.ascii "Start\0"
	.byte	0x7
	.word	0x261
	.long	0x2a9
	.byte	0x4
	.uleb128 0x13
	.ascii "TV\0"
	.byte	0x7
	.word	0x261
	.long	0x2a9
	.byte	0x8
	.byte	0
	.uleb128 0x11
	.ascii "qSTimer_t\0"
	.byte	0x7
	.word	0x262
	.long	0x640
	.uleb128 0x17
	.ascii "primero\0"
	.byte	0x1
	.byte	0xe
	.long	0x529
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x6cf
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xe
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "TaskEventData\0"
	.byte	0x1
	.byte	0xf
	.long	0x6cf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x33d
	.uleb128 0x17
	.ascii "segundo\0"
	.byte	0x1
	.byte	0x1c
	.long	0x529
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x709
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1c
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x17
	.ascii "tercero\0"
	.byte	0x1
	.byte	0x22
	.long	0x529
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x750
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x22
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "x\0"
	.byte	0x1
	.byte	0x23
	.long	0xd3
	.uleb128 0x9
	.byte	0x3
	.quad	x.4553
	.byte	0
	.uleb128 0x1a
	.ascii "smerror\0"
	.byte	0x1
	.byte	0x32
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x780
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x32
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "smok\0"
	.byte	0x1
	.byte	0x36
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x7ad
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x36
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x17
	.ascii "TimerInterruptEmulation\0"
	.byte	0x1
	.byte	0x3c
	.long	0x125
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x805
	.uleb128 0x1b
	.ascii "varargin\0"
	.byte	0x1
	.byte	0x3c
	.long	0x125
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "tick\0"
	.byte	0x1
	.byte	0x3d
	.long	0x191
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1a
	.ascii "Task1Callback\0"
	.byte	0x1
	.byte	0x46
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x83b
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x46
	.long	0x33d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task2Callback\0"
	.byte	0x1
	.byte	0x4a
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x88b
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x4a
	.long	0x33d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x19
	.ascii "Maquina1\0"
	.byte	0x1
	.byte	0x4b
	.long	0x595
	.uleb128 0x9
	.byte	0x3
	.quad	Maquina1.4579
	.byte	0
	.uleb128 0x1a
	.ascii "Task3Callback\0"
	.byte	0x1
	.byte	0x53
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0x8c1
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x53
	.long	0x33d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task4Callback\0"
	.byte	0x1
	.byte	0x59
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0x932
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x59
	.long	0x33d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x19
	.ascii "Timer\0"
	.byte	0x1
	.byte	0x5a
	.long	0x671
	.uleb128 0x9
	.byte	0x3
	.quad	Timer.4586
	.uleb128 0x1c
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x5f
	.long	0x224
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4587
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x5f
	.quad	.L24
	.byte	0
	.uleb128 0x1a
	.ascii "Task5Callback\0"
	.byte	0x1
	.byte	0x75
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0x968
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x75
	.long	0x33d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "Task6Callback\0"
	.byte	0x1
	.byte	0x7a
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x99e
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x7a
	.long	0x33d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1e
	.ascii "IdleTaskCallback\0"
	.byte	0x1
	.byte	0x7e
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0x9d7
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x7e
	.long	0x33d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "SchedReleaseCallback\0"
	.byte	0x1
	.byte	0x82
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0xa14
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x82
	.long	0x33d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x1e
	.ascii "TaskTestSTCallback\0"
	.byte	0x1
	.byte	0x86
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0xa4f
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x86
	.long	0x33d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "TaskX_Callback\0"
	.byte	0x1
	.byte	0x8c
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0xaaa
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x8c
	.long	0x33d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x1c
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x8d
	.long	0x224
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4616
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x8d
	.quad	.L41
	.byte	0
	.uleb128 0x1a
	.ascii "TaskY_Callback\0"
	.byte	0x1
	.byte	0x98
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0xb0e
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x98
	.long	0x33d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x1f
	.ascii "i\0"
	.byte	0x1
	.byte	0x99
	.long	0xd3
	.uleb128 0x1c
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x9a
	.long	0x224
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4626
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x9a
	.quad	.L50
	.byte	0
	.uleb128 0x17
	.ascii "main\0"
	.byte	0x1
	.byte	0xa5
	.long	0xd3
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0xb67
	.uleb128 0x1b
	.ascii "argc\0"
	.byte	0x1
	.byte	0xa5
	.long	0xd3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1b
	.ascii "argv\0"
	.byte	0x1
	.byte	0xa5
	.long	0xb67
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.ascii "_qQueueStack\0"
	.byte	0x1
	.byte	0xa7
	.long	0xb7d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x144
	.uleb128 0x20
	.long	0x4da
	.long	0xb7d
	.uleb128 0x21
	.long	0x138
	.byte	0x9
	.byte	0
	.uleb128 0xb
	.long	0xb6d
	.uleb128 0x22
	.ascii "TimerEmulation\0"
	.byte	0x1
	.byte	0x3b
	.long	0x1e7
	.uleb128 0x9
	.byte	0x3
	.quad	TimerEmulation
	.uleb128 0x22
	.ascii "Task1\0"
	.byte	0x1
	.byte	0x44
	.long	0x4ad
	.uleb128 0x9
	.byte	0x3
	.quad	Task1
	.uleb128 0x22
	.ascii "Task2\0"
	.byte	0x1
	.byte	0x44
	.long	0x4ad
	.uleb128 0x9
	.byte	0x3
	.quad	Task2
	.uleb128 0x22
	.ascii "Task3\0"
	.byte	0x1
	.byte	0x44
	.long	0x4ad
	.uleb128 0x9
	.byte	0x3
	.quad	Task3
	.uleb128 0x22
	.ascii "Task4\0"
	.byte	0x1
	.byte	0x44
	.long	0x4ad
	.uleb128 0x9
	.byte	0x3
	.quad	Task4
	.uleb128 0x22
	.ascii "Task5\0"
	.byte	0x1
	.byte	0x44
	.long	0x4ad
	.uleb128 0x9
	.byte	0x3
	.quad	Task5
	.uleb128 0x22
	.ascii "Task6\0"
	.byte	0x1
	.byte	0x44
	.long	0x4ad
	.uleb128 0x9
	.byte	0x3
	.quad	Task6
	.uleb128 0x22
	.ascii "TaskTestST\0"
	.byte	0x1
	.byte	0x44
	.long	0x4ad
	.uleb128 0x9
	.byte	0x3
	.quad	TaskTestST
	.uleb128 0x22
	.ascii "TaskX\0"
	.byte	0x1
	.byte	0x8b
	.long	0x4ad
	.uleb128 0x9
	.byte	0x3
	.quad	TaskX
	.uleb128 0x22
	.ascii "TaskY\0"
	.byte	0x1
	.byte	0x8b
	.long	0x4ad
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
	.uleb128 0x4
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
	.uleb128 0x1c
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
	.uleb128 0x1d
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
	.uleb128 0x1e
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
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
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
.LASF4:
	.ascii "_qCR_BEGIN_\0"
.LASF1:
	.ascii "Data\0"
.LASF2:
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
	.def	_qEnqueueTaskEvent;	.scl	2;	.type	32;	.endef
	.def	_qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	_qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	_qCreateTask;	.scl	2;	.type	32;	.endef
	.def	_qStart;	.scl	2;	.type	32;	.endef
