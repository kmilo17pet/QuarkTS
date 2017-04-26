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
	movl	x.4505(%rip), %eax
	addl	$1, %eax
	movl	%eax, x.4505(%rip)
	movl	x.4505(%rip), %eax
	cmpl	$2, %eax
	jle	.L8
	.loc 1 39 0
	movl	$0, x.4505(%rip)
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
	leaq	Maquina1.4530(%rip), %rcx
	call	_qStateMachine_Init
.L16:
	.loc 1 75 0
	movq	%rbx, %rdx
	leaq	Maquina1.4530(%rip), %rcx
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
.LC10:
	.ascii "A\0"
.LC11:
	.ascii "B\0"
.LC12:
	.ascii "C\0"
.LC13:
	.ascii "D\0"
.LC14:
	.ascii "F\0"
.LC15:
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
	.loc 1 86 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	.loc 1 87 0
	movl	__qCurrentTaskState.4537(%rip), %eax
	cmpl	$92, %eax
	je	.L20
	cmpl	$92, %eax
	jg	.L21
	testl	%eax, %eax
	je	.L22
	cmpl	$89, %eax
	je	.L23
	.loc 1 109 0
	jmp	.L18
.L21:
	.loc 1 87 0
	cmpl	$99, %eax
	je	.L24
	cmpl	$102, %eax
	je	.L28
	cmpl	$96, %eax
	je	.L26
	.loc 1 109 0
	jmp	.L18
.L28:
	nop
.L22:
	.loc 1 88 0
	leaq	.LC10(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 89 0
	movl	$89, __qCurrentTaskState.4537(%rip)
	jmp	.L18
.L23:
	.loc 1 91 0
	leaq	.LC11(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 92 0
	movl	$92, __qCurrentTaskState.4537(%rip)
	jmp	.L18
.L20:
	.loc 1 94 0
	leaq	.LC12(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 95 0
	leaq	.LC13(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 96 0
	movl	$96, __qCurrentTaskState.4537(%rip)
	jmp	.L18
.L26:
	.loc 1 98 0
	leaq	.LC14(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 99 0
	movl	$99, __qCurrentTaskState.4537(%rip)
	jmp	.L18
.L24:
	.loc 1 101 0
	leaq	.LC15(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 102 0
	movl	$102, __qCurrentTaskState.4537(%rip)
	nop
.L18:
	.loc 1 110 0
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
	.loc 1 112 0
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
	.loc 1 113 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	nop
	.loc 1 115 0
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
	.loc 1 119 0
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
	.loc 1 122 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 124 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
	.section .rdata,"dr"
.LC16:
	.ascii "\15\12Scheduler Released\0"
	.text
	.globl	SchedReleaseCallback
	.def	SchedReleaseCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	SchedReleaseCallback
SchedReleaseCallback:
.LFB20:
	.loc 1 126 0
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
	.loc 1 127 0
	leaq	.LC16(%rip), %rcx
	call	puts
	nop
	.loc 1 128 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC18:
	.ascii "TASK1\0"
.LC20:
	.ascii "TASK2\0"
.LC22:
	.ascii "TASK3\0"
.LC24:
	.ascii "TASK4\0"
.LC26:
	.ascii "TASK5\0"
.LC28:
	.ascii "TASK6\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB21:
	.loc 1 130 0
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
	.loc 1 130 0
	call	__main
	.loc 1 131 0
	movl	$0, %r9d
	leaq	TimerInterruptEmulation(%rip), %r8
	movl	$0, %edx
	leaq	TimerEmulation(%rip), %rax
	movq	%rax, %rcx
	call	pthread_create
	.loc 1 132 0
	leaq	-160(%rbp), %rax
	movl	$10, %r9d
	movq	%rax, %r8
	leaq	IdleTaskCallback(%rip), %rdx
	movss	.LC17(%rip), %xmm0
	call	_qInitScheduler
	.loc 1 133 0
	movq	.refptr.QUARKTS(%rip), %rax
	leaq	SchedReleaseCallback(%rip), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 134 0
	leaq	.LC18(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$0, 40(%rsp)
	movl	$1, 32(%rsp)
	pxor	%xmm3, %xmm3
	movl	$254, %r8d
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 135 0
	leaq	.LC20(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	movss	.LC21(%rip), %xmm3
	movl	$20, %r8d
	leaq	Task2Callback(%rip), %rdx
	leaq	Task2(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 136 0
	leaq	Task2(%rip), %rax
	movb	$1, 68(%rax)
	.loc 1 137 0
	leaq	.LC22(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$2, 32(%rsp)
	movss	.LC23(%rip), %xmm3
	movl	$127, %r8d
	leaq	Task3Callback(%rip), %rdx
	leaq	Task3(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 138 0
	leaq	.LC24(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	movss	.LC25(%rip), %xmm3
	movl	$127, %r8d
	leaq	Task4Callback(%rip), %rdx
	leaq	Task4(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 139 0
	leaq	.LC26(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$1, 32(%rsp)
	movss	.LC27(%rip), %xmm3
	movl	$127, %r8d
	leaq	Task5Callback(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 140 0
	leaq	.LC28(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$5, 32(%rsp)
	pxor	%xmm3, %xmm3
	movl	$127, %r8d
	leaq	Task6Callback(%rip), %rdx
	leaq	Task6(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 141 0
	call	_qStart
	.loc 1 142 0
	movl	$0, %eax
	.loc 1 143 0
	addq	$224, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
.lcomm x.4505,4,4
.lcomm Maquina1.4530,32,32
.lcomm __qCurrentTaskState.4537,4,4
	.section .rdata,"dr"
	.align 4
.LC17:
	.long	1008981770
	.align 4
.LC21:
	.long	1056964608
	.align 4
.LC23:
	.long	1065353216
	.align 4
.LC25:
	.long	1069547520
	.align 4
.LC27:
	.long	1073741824
	.text
.Letext0:
	.file 2 "/usr/include/sys/_timespec.h"
	.file 3 "/usr/include/cygwin/types.h"
	.file 4 "/usr/include/sys/types.h"
	.file 5 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xb49
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
	.byte	0x4
	.byte	0x5
	.byte	0x1f
	.long	0x205
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
	.byte	0x1f
	.long	0x1bc
	.uleb128 0x5
	.ascii "qTime_t\0"
	.byte	0x5
	.byte	0x20
	.long	0x226
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x5
	.ascii "qClock_t\0"
	.byte	0x5
	.byte	0x21
	.long	0x23f
	.uleb128 0xa
	.long	0xe5
	.uleb128 0x5
	.ascii "qPriority_t\0"
	.byte	0x5
	.byte	0x22
	.long	0x8e
	.uleb128 0x5
	.ascii "qIteration_t\0"
	.byte	0x5
	.byte	0x23
	.long	0x8e
	.uleb128 0x5
	.ascii "qBool_t\0"
	.byte	0x5
	.byte	0x25
	.long	0x8e
	.uleb128 0xb
	.byte	0x20
	.byte	0x5
	.byte	0x32
	.long	0x2c3
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x5
	.byte	0x33
	.long	0x205
	.byte	0
	.uleb128 0xc
	.secrel32	.LASF0
	.byte	0x5
	.byte	0x34
	.long	0x102
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x5
	.byte	0x35
	.long	0x102
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x5
	.byte	0x36
	.long	0x26b
	.byte	0x18
	.byte	0
	.uleb128 0x5
	.ascii "qEvent_t\0"
	.byte	0x5
	.byte	0x37
	.long	0x27a
	.uleb128 0x5
	.ascii "qTaskFcn_t\0"
	.byte	0x5
	.byte	0x39
	.long	0x2e5
	.uleb128 0x4
	.byte	0x8
	.long	0x2eb
	.uleb128 0xd
	.long	0x2f6
	.uleb128 0xe
	.long	0x2c3
	.byte	0
	.uleb128 0xb
	.byte	0x5
	.byte	0x5
	.byte	0x3b
	.long	0x35a
	.uleb128 0x7
	.ascii "TimedTaskRun\0"
	.byte	0x5
	.byte	0x3c
	.long	0x35a
	.byte	0
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x5
	.byte	0x3d
	.long	0x35a
	.byte	0x1
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x5
	.byte	0x3e
	.long	0x35a
	.byte	0x2
	.uleb128 0x7
	.ascii "State\0"
	.byte	0x5
	.byte	0x3f
	.long	0x35a
	.byte	0x3
	.uleb128 0x7
	.ascii "IgnoreOveruns\0"
	.byte	0x5
	.byte	0x40
	.long	0x35a
	.byte	0x4
	.byte	0
	.uleb128 0xa
	.long	0x8e
	.uleb128 0x5
	.ascii "qTaskFlags_t\0"
	.byte	0x5
	.byte	0x41
	.long	0x2f6
	.uleb128 0x6
	.ascii "_qTask_t\0"
	.byte	0x50
	.byte	0x5
	.byte	0x43
	.long	0x426
	.uleb128 0xc
	.secrel32	.LASF0
	.byte	0x5
	.byte	0x44
	.long	0x102
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x5
	.byte	0x44
	.long	0x102
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x5
	.byte	0x45
	.long	0x22f
	.byte	0x10
	.uleb128 0x7
	.ascii "TimeElapsed\0"
	.byte	0x5
	.byte	0x45
	.long	0x22f
	.byte	0x18
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x5
	.byte	0x46
	.long	0x257
	.byte	0x20
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x5
	.byte	0x47
	.long	0xe5
	.byte	0x28
	.uleb128 0x7
	.ascii "Priority\0"
	.byte	0x5
	.byte	0x48
	.long	0x244
	.byte	0x30
	.uleb128 0x7
	.ascii "Callback\0"
	.byte	0x5
	.byte	0x49
	.long	0x2d3
	.byte	0x38
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x5
	.byte	0x4a
	.long	0x426
	.byte	0x40
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x5
	.byte	0x4b
	.long	0x42b
	.byte	0x48
	.byte	0
	.uleb128 0xa
	.long	0x35f
	.uleb128 0x4
	.byte	0x8
	.long	0x431
	.uleb128 0xa
	.long	0x373
	.uleb128 0xb
	.byte	0x10
	.byte	0x5
	.byte	0x4f
	.long	0x45e
	.uleb128 0x7
	.ascii "Task\0"
	.byte	0x5
	.byte	0x50
	.long	0x42b
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x5
	.byte	0x51
	.long	0x102
	.byte	0x8
	.byte	0
	.uleb128 0x5
	.ascii "qQueueStack_t\0"
	.byte	0x5
	.byte	0x52
	.long	0x436
	.uleb128 0xb
	.byte	0x4
	.byte	0x5
	.byte	0x54
	.long	0x4c6
	.uleb128 0x7
	.ascii "Init\0"
	.byte	0x5
	.byte	0x55
	.long	0x8e
	.byte	0
	.uleb128 0x7
	.ascii "FCallIdle\0"
	.byte	0x5
	.byte	0x56
	.long	0x8e
	.byte	0x1
	.uleb128 0x7
	.ascii "ReleaseSched\0"
	.byte	0x5
	.byte	0x57
	.long	0x8e
	.byte	0x2
	.uleb128 0x7
	.ascii "FCallReleased\0"
	.byte	0x5
	.byte	0x58
	.long	0x8e
	.byte	0x3
	.byte	0
	.uleb128 0x5
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x5
	.byte	0x59
	.long	0x473
	.uleb128 0xb
	.byte	0x58
	.byte	0x5
	.byte	0x5b
	.long	0x5a0
	.uleb128 0x7
	.ascii "IDLECallback\0"
	.byte	0x5
	.byte	0x5c
	.long	0x2d3
	.byte	0
	.uleb128 0x7
	.ascii "ReleaseSchedCallback\0"
	.byte	0x5
	.byte	0x5d
	.long	0x2d3
	.byte	0x8
	.uleb128 0x7
	.ascii "Tick\0"
	.byte	0x5
	.byte	0x5e
	.long	0x217
	.byte	0x10
	.uleb128 0x7
	.ascii "EventInfo\0"
	.byte	0x5
	.byte	0x5f
	.long	0x2c3
	.byte	0x18
	.uleb128 0x7
	.ascii "First\0"
	.byte	0x5
	.byte	0x60
	.long	0x42b
	.byte	0x38
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x5
	.byte	0x61
	.long	0x5a0
	.byte	0x40
	.uleb128 0x7
	.ascii "QueueStack\0"
	.byte	0x5
	.byte	0x62
	.long	0x5a5
	.byte	0x48
	.uleb128 0x7
	.ascii "QueueSize\0"
	.byte	0x5
	.byte	0x63
	.long	0x8e
	.byte	0x50
	.uleb128 0x7
	.ascii "QueueIndex\0"
	.byte	0x5
	.byte	0x63
	.long	0x8e
	.byte	0x51
	.uleb128 0x7
	.ascii "NotSafeQueue\0"
	.byte	0x5
	.byte	0x64
	.long	0x35a
	.byte	0x52
	.byte	0
	.uleb128 0xa
	.long	0x4c6
	.uleb128 0x4
	.byte	0x8
	.long	0x5ab
	.uleb128 0xa
	.long	0x45e
	.uleb128 0x5
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x5
	.byte	0x65
	.long	0x4de
	.uleb128 0xf
	.ascii "state\0"
	.byte	0x4
	.byte	0x5
	.byte	0x96
	.long	0x602
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
	.byte	0x96
	.long	0x5c9
	.uleb128 0x6
	.ascii "_qSM_t\0"
	.byte	0x20
	.byte	0x5
	.byte	0x98
	.long	0x677
	.uleb128 0x7
	.ascii "NextState\0"
	.byte	0x5
	.byte	0x99
	.long	0x691
	.byte	0
	.uleb128 0x7
	.ascii "PreviousState\0"
	.byte	0x5
	.byte	0x9a
	.long	0x691
	.byte	0x8
	.uleb128 0x7
	.ascii "PreviousReturnStatus\0"
	.byte	0x5
	.byte	0x9b
	.long	0x602
	.byte	0x10
	.uleb128 0xc
	.secrel32	.LASF0
	.byte	0x5
	.byte	0x9c
	.long	0x102
	.byte	0x18
	.byte	0
	.uleb128 0x10
	.long	0x602
	.long	0x686
	.uleb128 0xe
	.long	0x686
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.long	0x68c
	.uleb128 0xa
	.long	0x616
	.uleb128 0x4
	.byte	0x8
	.long	0x677
	.uleb128 0x11
	.ascii "primero\0"
	.byte	0x1
	.byte	0xe
	.long	0x602
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x6e3
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0xe
	.long	0x686
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "TaskEventData\0"
	.byte	0x1
	.byte	0xf
	.long	0x6e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.long	0x2c3
	.uleb128 0x11
	.ascii "segundo\0"
	.byte	0x1
	.byte	0x1c
	.long	0x602
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x71d
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x1c
	.long	0x686
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x11
	.ascii "tercero\0"
	.byte	0x1
	.byte	0x22
	.long	0x602
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x764
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x22
	.long	0x686
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
	.quad	x.4505
	.byte	0
	.uleb128 0x11
	.ascii "smerror\0"
	.byte	0x1
	.byte	0x2d
	.long	0x602
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x798
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x2d
	.long	0x686
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x11
	.ascii "smok\0"
	.byte	0x1
	.byte	0x31
	.long	0x602
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x7c9
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x31
	.long	0x686
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
	.long	0x821
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
	.long	0x857
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x42
	.long	0x2c3
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
	.long	0x8a7
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x46
	.long	0x2c3
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x13
	.ascii "Maquina1\0"
	.byte	0x1
	.byte	0x47
	.long	0x68c
	.uleb128 0x9
	.byte	0x3
	.quad	Maquina1.4530
	.byte	0
	.uleb128 0x15
	.ascii "Task3Callback\0"
	.byte	0x1
	.byte	0x4f
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0x8dd
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x4f
	.long	0x2c3
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
	.long	0x938
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x55
	.long	0x2c3
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x13
	.ascii "__qCurrentTaskState\0"
	.byte	0x1
	.byte	0x57
	.long	0xc2
	.uleb128 0x9
	.byte	0x3
	.quad	__qCurrentTaskState.4537
	.byte	0
	.uleb128 0x15
	.ascii "Task5Callback\0"
	.byte	0x1
	.byte	0x70
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0x96e
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x70
	.long	0x2c3
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "Task6Callback\0"
	.byte	0x1
	.byte	0x75
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x9a4
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x75
	.long	0x2c3
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.ascii "IdleTaskCallback\0"
	.byte	0x1
	.byte	0x7a
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0x9dd
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x7a
	.long	0x2c3
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "SchedReleaseCallback\0"
	.byte	0x1
	.byte	0x7e
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0xa1a
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x7e
	.long	0x2c3
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x11
	.ascii "main\0"
	.byte	0x1
	.byte	0x82
	.long	0xc2
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0xa73
	.uleb128 0x14
	.ascii "argc\0"
	.byte	0x1
	.byte	0x82
	.long	0xc2
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x14
	.ascii "argv\0"
	.byte	0x1
	.byte	0x82
	.long	0xa73
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x13
	.ascii "_qQueueStack\0"
	.byte	0x1
	.byte	0x84
	.long	0xa89
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.long	0x121
	.uleb128 0x17
	.long	0x45e
	.long	0xa89
	.uleb128 0x18
	.long	0x115
	.byte	0x9
	.byte	0
	.uleb128 0xa
	.long	0xa79
	.uleb128 0x19
	.ascii "QUARKTS\0"
	.byte	0x5
	.byte	0x66
	.long	0xa9d
	.uleb128 0xa
	.long	0x5b0
	.uleb128 0x1a
	.ascii "TimerEmulation\0"
	.byte	0x1
	.byte	0x37
	.long	0x1a5
	.uleb128 0x9
	.byte	0x3
	.quad	TimerEmulation
	.uleb128 0x1a
	.ascii "Task1\0"
	.byte	0x1
	.byte	0x40
	.long	0x431
	.uleb128 0x9
	.byte	0x3
	.quad	Task1
	.uleb128 0x1a
	.ascii "Task2\0"
	.byte	0x1
	.byte	0x40
	.long	0x431
	.uleb128 0x9
	.byte	0x3
	.quad	Task2
	.uleb128 0x1a
	.ascii "Task3\0"
	.byte	0x1
	.byte	0x40
	.long	0x431
	.uleb128 0x9
	.byte	0x3
	.quad	Task3
	.uleb128 0x1a
	.ascii "Task4\0"
	.byte	0x1
	.byte	0x40
	.long	0x431
	.uleb128 0x9
	.byte	0x3
	.quad	Task4
	.uleb128 0x1a
	.ascii "Task5\0"
	.byte	0x1
	.byte	0x40
	.long	0x431
	.uleb128 0x9
	.byte	0x3
	.quad	Task5
	.uleb128 0x1a
	.ascii "Task6\0"
	.byte	0x1
	.byte	0x40
	.long	0x431
	.uleb128 0x9
	.byte	0x3
	.quad	Task6
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
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
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
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
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
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x1a
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
.LASF2:
	.ascii "Data\0"
.LASF1:
	.ascii "Machine\0"
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
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	_qCreateTask;	.scl	2;	.type	32;	.endef
	.def	_qStart;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr.QUARKTS, "dr"
	.globl	.refptr.QUARKTS
	.linkonce	discard
.refptr.QUARKTS:
	.quad	QUARKTS
