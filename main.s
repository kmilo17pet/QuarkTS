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
.LFB10:
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
.LFE10:
	.seh_endproc
	.section .rdata,"dr"
.LC4:
	.ascii "2\0"
	.text
	.globl	segundo
	.def	segundo;	.scl	2;	.type	32;	.endef
	.seh_proc	segundo
segundo:
.LFB11:
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
.LFE11:
	.seh_endproc
	.section .rdata,"dr"
.LC5:
	.ascii "3\0"
	.text
	.globl	tercero
	.def	tercero;	.scl	2;	.type	32;	.endef
	.seh_proc	tercero
tercero:
.LFB12:
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
	movl	x.4613(%rip), %eax
	addl	$1, %eax
	movl	%eax, x.4613(%rip)
	movl	x.4613(%rip), %eax
	cmpl	$2, %eax
	jle	.L8
	.loc 1 44 0
	movl	$0, x.4613(%rip)
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
.LFE12:
	.seh_endproc
	.section .rdata,"dr"
.LC6:
	.ascii "error\0"
	.text
	.globl	smerror
	.def	smerror;	.scl	2;	.type	32;	.endef
	.seh_proc	smerror
smerror:
.LFB13:
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
	.loc 1 52 0
	nop
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.seh_endproc
	.section .rdata,"dr"
.LC7:
	.ascii "ok...\0"
	.text
	.globl	smok
	.def	smok;	.scl	2;	.type	32;	.endef
	.seh_proc	smok
smok:
.LFB14:
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
	.loc 1 56 0
	nop
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.comm	TimerEmulation, 8, 3
	.globl	TimerInterruptEmulation
	.def	TimerInterruptEmulation;	.scl	2;	.type	32;	.endef
	.seh_proc	TimerInterruptEmulation
TimerInterruptEmulation:
.LFB15:
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
.LFE15:
	.seh_endproc
	.comm	Task1, 64, 5
	.comm	Task2, 64, 5
	.comm	Task3, 64, 5
	.comm	Task4, 64, 5
	.comm	Task5, 64, 5
	.comm	Task6, 64, 5
	.comm	TaskTestST, 64, 5
	.section .rdata,"dr"
.LC8:
	.ascii "\15\12 (%d)\0"
.LC9:
	.ascii "/ %d\0"
.LC10:
	.ascii "\0"
	.text
	.globl	printqueue
	.def	printqueue;	.scl	2;	.type	32;	.endef
	.seh_proc	printqueue
printqueue:
.LFB16:
	.loc 1 70 0
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
	.loc 1 72 0
	movq	.refptr.QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %edx
	leaq	.LC8(%rip), %rcx
	call	printf
	.loc 1 73 0
	movl	$0, -4(%rbp)
	jmp	.L15
.L16:
	.loc 1 74 0 discriminator 3
	movq	.refptr.QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdx
	leaq	.LC9(%rip), %rcx
	call	printf
	.loc 1 73 0 discriminator 3
	addl	$1, -4(%rbp)
.L15:
	.loc 1 73 0 is_stmt 0 discriminator 1
	cmpl	$9, -4(%rbp)
	jle	.L16
	.loc 1 76 0 is_stmt 1
	leaq	.LC10(%rip), %rcx
	call	puts
	.loc 1 77 0
	nop
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.section .rdata,"dr"
.LC12:
	.ascii "%d  %f  %f\15\12\0"
	.text
	.globl	Task1Callback
	.def	Task1Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task1Callback
Task1Callback:
.LFB17:
	.loc 1 81 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	.seh_stackalloc	80
	movaps	%xmm6, -32(%rbp)
	.seh_savexmm	%xmm6, 48
	movaps	%xmm7, -16(%rbp)
	.seh_savexmm	%xmm7, 64
	.cfi_offset 23, -48
	.cfi_offset 24, -32
	.seh_endprologue
	.loc 1 83 0
	movl	$1, %r8d
	movss	.LC11(%rip), %xmm1
	leaq	x.4643(%rip), %rcx
	call	_qSTimerSet
	.loc 1 84 0
	movq	.refptr.QUARKTS(%rip), %rax
	movss	16(%rax), %xmm6
	leaq	x.4643(%rip), %rcx
	call	_qSTimerElapsed
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L18
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L19
.L18:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L19:
	mulss	%xmm6, %xmm0
	cvtss2sd	%xmm0, %xmm7
	movq	.refptr.QUARKTS(%rip), %rax
	movss	16(%rax), %xmm6
	leaq	x.4643(%rip), %rcx
	call	_qSTimerRemaining
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L20
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L21
.L20:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L21:
	mulss	%xmm6, %xmm0
	cvtss2sd	%xmm0, %xmm0
	movl	8+x.4643(%rip), %eax
	movq	%xmm7, %rdx
	movq	%rdx, %rcx
	movq	%rcx, -40(%rbp)
	movsd	-40(%rbp), %xmm3
	movq	%rdx, -40(%rbp)
	movsd	-40(%rbp), %xmm1
	movq	%xmm0, %rdx
	movq	%rdx, %rcx
	movq	%rcx, -40(%rbp)
	movsd	-40(%rbp), %xmm2
	movq	%rdx, -40(%rbp)
	movsd	-40(%rbp), %xmm0
	movq	%xmm1, %r9
	movq	%xmm0, %r8
	movl	%eax, %edx
	leaq	.LC12(%rip), %rcx
	call	printf
	.loc 1 85 0
	nop
	movaps	-32(%rbp), %xmm6
	movaps	-16(%rbp), %xmm7
	addq	$80, %rsp
	.cfi_restore 24
	.cfi_restore 23
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC13:
	.ascii "Userdata : %s  Eventdata:%s   %d\15\12\0"
	.text
	.globl	Task2Callback
	.def	Task2Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task2Callback
Task2Callback:
.LFB18:
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
	.loc 1 89 0
	movzbl	24(%rbx), %eax
	testb	%al, %al
	je	.L23
	.loc 1 90 0
	movq	$0, 32(%rsp)
	leaq	smerror(%rip), %r9
	leaq	smok(%rip), %r8
	leaq	primero(%rip), %rdx
	leaq	Maquina1.4647(%rip), %rcx
	call	_qStateMachine_Init
.L23:
	.loc 1 92 0
	movq	%rbx, %rdx
	leaq	Maquina1.4647(%rip), %rcx
	call	_qStateMachine_Run
	.loc 1 93 0
	leaq	Task2(%rip), %rax
	movl	28(%rax), %ecx
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movl	%ecx, %r9d
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC13(%rip), %rcx
	call	printf
	.loc 1 94 0
	nop
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.section .rdata,"dr"
.LC14:
	.ascii "Userdata : %s  Eventdata:%s\15\12\0"
	.text
	.globl	Task3Callback
	.def	Task3Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task3Callback
Task3Callback:
.LFB19:
	.loc 1 96 0
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
	.loc 1 97 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC14(%rip), %rcx
	call	printf
	.loc 1 102 0
	nop
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC15:
	.ascii "Userdata : %s  Eventdata:%s    %d  \15\12\0"
.LC16:
	.ascii "A\0"
.LC17:
	.ascii "B\0"
.LC20:
	.ascii "C\0"
.LC21:
	.ascii "D\0"
.LC23:
	.ascii "F\0"
.LC24:
	.ascii "G\0"
	.text
	.globl	Task4Callback
	.def	Task4Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task4Callback
Task4Callback:
.LFB20:
	.loc 1 104 0
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
	.loc 1 109 0
	leaq	Task4(%rip), %rax
	movl	28(%rax), %ecx
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movl	%ecx, %r9d
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC15(%rip), %rcx
	call	printf
	.loc 1 110 0
	movl	_qCRTaskState_.4655(%rip), %eax
	cmpl	$117, %eax
	je	.L27
	cmpl	$117, %eax
	jg	.L28
	cmpl	$112, %eax
	je	.L29
	cmpl	$115, %eax
	je	.L30
	cmpl	$-32766, %eax
	je	.L31
	.loc 1 129 0
	jmp	.L25
.L28:
	.loc 1 110 0
	cmpl	$125, %eax
	je	.L32
	cmpl	$128, %eax
	je	.L38
	cmpl	$122, %eax
	je	.L34
	.loc 1 129 0
	jmp	.L25
.L38:
	nop
.L31:
	.loc 1 111 0
	leaq	.LC16(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 112 0
	movl	$112, _qCRTaskState_.4655(%rip)
	jmp	.L25
.L29:
	.loc 1 114 0
	leaq	.LC17(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 115 0
	movl	$115, _qCRTaskState_.4655(%rip)
	jmp	.L25
.L30:
	.loc 1 116 0
	movl	$0, %r8d
	movss	.LC18(%rip), %xmm1
	leaq	Timer.4654(%rip), %rcx
	call	_qSTimerSet
	.loc 1 117 0
	movl	$117, _qCRTaskState_.4655(%rip)
.L27:
	.loc 1 117 0 is_stmt 0 discriminator 1
	leaq	Timer.4654(%rip), %rcx
	call	_qSTimerExpired
	testb	%al, %al
	je	.L39
	.loc 1 118 0 is_stmt 1
	movl	$0, %r8d
	movss	.LC19(%rip), %xmm1
	leaq	Timer.4654(%rip), %rcx
	call	_qSTimerSet
	.loc 1 119 0
	leaq	.LC20(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 120 0
	leaq	.LC21(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 121 0
	movl	$0, %r8d
	movss	.LC22(%rip), %xmm1
	leaq	Timer.4654(%rip), %rcx
	call	_qSTimerSet
	.loc 1 122 0
	movl	$122, _qCRTaskState_.4655(%rip)
	jmp	.L25
.L34:
	.loc 1 123 0
	leaq	.LC23(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 125 0
	movl	$125, _qCRTaskState_.4655(%rip)
.L32:
	.loc 1 125 0 is_stmt 0 discriminator 1
	leaq	Timer.4654(%rip), %rcx
	call	_qSTimerExpired
	testb	%al, %al
	je	.L40
	.loc 1 127 0 is_stmt 1
	leaq	.LC24(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 128 0
	movl	$128, _qCRTaskState_.4655(%rip)
	jmp	.L25
.L39:
	.loc 1 117 0
	nop
	jmp	.L25
.L40:
	.loc 1 125 0
	nop
.L25:
	.loc 1 130 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE20:
	.seh_endproc
	.globl	Task5Callback
	.def	Task5Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task5Callback
Task5Callback:
.LFB21:
	.loc 1 132 0
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
	.loc 1 134 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC14(%rip), %rcx
	call	printf
	.loc 1 136 0
	nop
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
	.globl	Task6Callback
	.def	Task6Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	Task6Callback
Task6Callback:
.LFB22:
	.loc 1 138 0
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
	.loc 1 139 0
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC14(%rip), %rcx
	call	printf
	.loc 1 140 0
	nop
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE22:
	.seh_endproc
	.globl	IdleTaskCallback
	.def	IdleTaskCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	IdleTaskCallback
IdleTaskCallback:
.LFB23:
	.loc 1 142 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 144 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.seh_endproc
	.section .rdata,"dr"
.LC25:
	.ascii "\15\12Scheduler Released\0"
	.text
	.globl	SchedReleaseCallback
	.def	SchedReleaseCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	SchedReleaseCallback
SchedReleaseCallback:
.LFB24:
	.loc 1 146 0
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
	.loc 1 147 0
	leaq	.LC25(%rip), %rcx
	call	puts
	.loc 1 148 0
	nop
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.seh_endproc
	.globl	TaskTestSTCallback
	.def	TaskTestSTCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	TaskTestSTCallback
TaskTestSTCallback:
.LFB25:
	.loc 1 150 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 153 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.seh_endproc
	.comm	TaskX, 64, 5
	.comm	TaskY, 64, 5
	.globl	TaskX_Callback
	.def	TaskX_Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	TaskX_Callback
TaskX_Callback:
.LFB26:
	.loc 1 156 0
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
	.loc 1 157 0
	movl	_qCRTaskState_.4684(%rip), %eax
	cmpl	$159, %eax
	je	.L48
	cmpl	$159, %eax
	jg	.L49
	cmpl	$-32766, %eax
	je	.L50
	.loc 1 165 0
	jmp	.L46
.L49:
	.loc 1 157 0
	cmpl	$161, %eax
	je	.L51
	cmpl	$163, %eax
	je	.L54
	.loc 1 165 0
	jmp	.L46
.L54:
	nop
.L50:
	.loc 1 158 0
	movl	$97, %ecx
	call	putchar
	.loc 1 159 0
	movl	$159, _qCRTaskState_.4684(%rip)
	jmp	.L46
.L48:
	.loc 1 160 0
	movl	$98, %ecx
	call	putchar
	.loc 1 161 0
	movl	$161, _qCRTaskState_.4684(%rip)
	jmp	.L46
.L51:
	.loc 1 162 0
	movl	$99, %ecx
	call	putchar
	.loc 1 163 0
	movl	$163, _qCRTaskState_.4684(%rip)
	nop
.L46:
	.loc 1 166 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.seh_endproc
	.globl	TaskY_Callback
	.def	TaskY_Callback;	.scl	2;	.type	32;	.endef
	.seh_proc	TaskY_Callback
TaskY_Callback:
.LFB27:
	.loc 1 168 0
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
	.loc 1 170 0
	movl	_qCRTaskState_.4694(%rip), %eax
	cmpl	$172, %eax
	je	.L57
	cmpl	$172, %eax
	jg	.L58
	cmpl	$-32766, %eax
	je	.L59
	.loc 1 178 0
	jmp	.L55
.L58:
	.loc 1 170 0
	cmpl	$174, %eax
	je	.L60
	cmpl	$176, %eax
	je	.L63
	.loc 1 178 0
	jmp	.L55
.L63:
	nop
.L59:
	.loc 1 171 0
	movl	$49, %ecx
	call	putchar
	.loc 1 172 0
	movl	$172, _qCRTaskState_.4694(%rip)
	jmp	.L55
.L57:
	.loc 1 173 0
	movl	$50, %ecx
	call	putchar
	.loc 1 174 0
	movl	$174, _qCRTaskState_.4694(%rip)
	jmp	.L55
.L60:
	.loc 1 175 0
	leaq	.LC5(%rip), %rcx
	call	puts
	.loc 1 176 0
	movl	$176, _qCRTaskState_.4694(%rip)
	nop
.L55:
	.loc 1 179 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.seh_endproc
	.section .rdata,"dr"
.LC26:
	.ascii "SIGALRM!\0"
	.text
	.globl	alarm_signal
	.def	alarm_signal;	.scl	2;	.type	32;	.endef
	.seh_proc	alarm_signal
alarm_signal:
.LFB28:
	.loc 1 180 0
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
	movl	%ecx, 16(%rbp)
	.loc 1 181 0
	leaq	.LC26(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 182 0
	call	printqueue
	.loc 1 183 0
	movl	$1, %ecx
	call	alarm
	.loc 1 184 0
	nop
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.seh_endproc
	.section .rdata,"dr"
.LC27:
	.ascii "SIGINT\0"
	.text
	.globl	sigint_signal
	.def	sigint_signal;	.scl	2;	.type	32;	.endef
	.seh_proc	sigint_signal
sigint_signal:
.LFB29:
	.loc 1 185 0
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
	movl	%ecx, 16(%rbp)
	.loc 1 186 0
	leaq	.LC27(%rip), %rdx
	leaq	Task5(%rip), %rax
	movq	%rax, %rcx
	call	_qEnqueueTaskEvent
	.loc 1 187 0
	call	printqueue
	.loc 1 188 0
	movl	$1, %ecx
	call	alarm
	.loc 1 189 0
	nop
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC29:
	.ascii "TASK1\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB30:
	.loc 1 191 0
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
	.loc 1 191 0
	call	__main
	.loc 1 194 0
	movl	$0, %r9d
	leaq	TimerInterruptEmulation(%rip), %r8
	movl	$0, %edx
	leaq	TimerEmulation(%rip), %rax
	movq	%rax, %rcx
	call	pthread_create
	.loc 1 195 0
	leaq	-160(%rbp), %rax
	movl	$10, %r9d
	movq	%rax, %r8
	leaq	IdleTaskCallback(%rip), %rdx
	movss	.LC28(%rip), %xmm0
	call	_qInitScheduler
	.loc 1 197 0
	leaq	.LC29(%rip), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$255, 32(%rsp)
	movss	.LC30(%rip), %xmm3
	movl	$254, %r8d
	leaq	Task1Callback(%rip), %rdx
	leaq	Task1(%rip), %rax
	movq	%rax, %rcx
	call	_qCreateTask
	.loc 1 208 0
	call	_qStart
	.loc 1 209 0
	movl	$0, %eax
	.loc 1 210 0
	addq	$224, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.seh_endproc
.lcomm x.4613,4,4
.lcomm x.4643,12,8
.lcomm Maquina1.4647,56,32
	.data
	.align 4
_qCRTaskState_.4655:
	.long	-32766
.lcomm Timer.4654,12,8
	.align 4
_qCRTaskState_.4684:
	.long	-32766
	.align 4
_qCRTaskState_.4694:
	.long	-32766
	.section .rdata,"dr"
	.align 4
.LC11:
	.long	1077936128
	.align 4
.LC18:
	.long	1084227584
	.align 4
.LC19:
	.long	1073741824
	.align 4
.LC22:
	.long	1082130432
	.align 4
.LC28:
	.long	1008981770
	.align 4
.LC30:
	.long	1036831949
	.text
.Letext0:
	.file 2 "/usr/include/machine/_default_types.h"
	.file 3 "/usr/include/sys/_stdint.h"
	.file 4 "/usr/include/sys/_timeval.h"
	.file 5 "/usr/include/sys/_timespec.h"
	.file 6 "/usr/include/sys/_pthreadtypes.h"
	.file 7 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xedf
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C11 5.4.0 -mtune=generic -march=x86-64 -g\0"
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
	.long	0xa1
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
	.byte	0x4f
	.long	0xee
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
	.byte	0x8
	.byte	0x5
	.ascii "long long int\0"
	.uleb128 0x2
	.byte	0x10
	.byte	0x4
	.ascii "long double\0"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
	.uleb128 0x4
	.byte	0x8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "sizetype\0"
	.uleb128 0x5
	.byte	0x8
	.long	0x15b
	.uleb128 0x6
	.uleb128 0x5
	.byte	0x8
	.long	0x13f
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x3
	.ascii "uint8_t\0"
	.byte	0x3
	.byte	0x18
	.long	0x90
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x30
	.long	0xdc
	.uleb128 0x3
	.ascii "time_t\0"
	.byte	0x4
	.byte	0x28
	.long	0xfe
	.uleb128 0x7
	.ascii "timespec\0"
	.byte	0x10
	.byte	0x5
	.byte	0x2d
	.long	0x1da
	.uleb128 0x8
	.ascii "tv_sec\0"
	.byte	0x5
	.byte	0x2e
	.long	0x19b
	.byte	0
	.uleb128 0x8
	.ascii "tv_nsec\0"
	.byte	0x5
	.byte	0x2f
	.long	0xfe
	.byte	0x8
	.byte	0
	.uleb128 0x7
	.ascii "__pthread_t\0"
	.byte	0x1
	.byte	0x6
	.byte	0xf
	.long	0x1ff
	.uleb128 0x8
	.ascii "__dummy\0"
	.byte	0x6
	.byte	0xf
	.long	0x13f
	.byte	0
	.byte	0
	.uleb128 0x3
	.ascii "pthread_t\0"
	.byte	0x6
	.byte	0xf
	.long	0x210
	.uleb128 0x5
	.byte	0x8
	.long	0x1da
	.uleb128 0x9
	.ascii "qTaskPC_t_\0"
	.byte	0x4
	.long	0xd5
	.byte	0x7
	.byte	0x26
	.long	0x240
	.uleb128 0xa
	.ascii "qCR_PCInitVal\0"
	.sleb128 -32766
	.byte	0
	.uleb128 0x3
	.ascii "_qTaskPC_t\0"
	.byte	0x7
	.byte	0x26
	.long	0x216
	.uleb128 0xb
	.byte	0x4
	.long	0xee
	.byte	0x7
	.byte	0x38
	.long	0x29f
	.uleb128 0xc
	.ascii "byTimeElapsed\0"
	.byte	0
	.uleb128 0xc
	.ascii "byPriority\0"
	.byte	0x1
	.uleb128 0xc
	.ascii "byQueueExtraction\0"
	.byte	0x2
	.uleb128 0xc
	.ascii "byAsyncEvent\0"
	.byte	0x3
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x7
	.byte	0x38
	.long	0x252
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x7
	.byte	0x39
	.long	0x2c0
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x7
	.byte	0x3a
	.long	0x2d9
	.uleb128 0xd
	.long	0x18b
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x7
	.byte	0x3b
	.long	0x17c
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x7
	.byte	0x3c
	.long	0x17c
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x7
	.byte	0x3e
	.long	0x17c
	.uleb128 0xe
	.byte	0x20
	.byte	0x7
	.byte	0x4c
	.long	0x35d
	.uleb128 0x8
	.ascii "Trigger\0"
	.byte	0x7
	.byte	0x5f
	.long	0x29f
	.byte	0
	.uleb128 0xf
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x63
	.long	0x147
	.byte	0x8
	.uleb128 0x8
	.ascii "EventData\0"
	.byte	0x7
	.byte	0x67
	.long	0x147
	.byte	0x10
	.uleb128 0x8
	.ascii "FirstCall\0"
	.byte	0x7
	.byte	0x6c
	.long	0x305
	.byte	0x18
	.byte	0
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x7
	.byte	0x6d
	.long	0x314
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x7
	.byte	0x6f
	.long	0x37f
	.uleb128 0x5
	.byte	0x8
	.long	0x385
	.uleb128 0x10
	.long	0x390
	.uleb128 0x11
	.long	0x35d
	.byte	0
	.uleb128 0xe
	.byte	0x5
	.byte	0x7
	.byte	0x70
	.long	0x3f6
	.uleb128 0x8
	.ascii "TimedTaskRun\0"
	.byte	0x7
	.byte	0x71
	.long	0x3f6
	.byte	0
	.uleb128 0x8
	.ascii "InitFlag\0"
	.byte	0x7
	.byte	0x71
	.long	0x3f6
	.byte	0x1
	.uleb128 0x8
	.ascii "AsyncRun\0"
	.byte	0x7
	.byte	0x71
	.long	0x3f6
	.byte	0x2
	.uleb128 0x8
	.ascii "IgnoreOveruns\0"
	.byte	0x7
	.byte	0x71
	.long	0x3f6
	.byte	0x3
	.uleb128 0x8
	.ascii "Enabled\0"
	.byte	0x7
	.byte	0x71
	.long	0x3f6
	.byte	0x4
	.byte	0
	.uleb128 0xd
	.long	0x17c
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x7
	.byte	0x72
	.long	0x390
	.uleb128 0x7
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x7
	.byte	0x76
	.long	0x4c2
	.uleb128 0xf
	.secrel32	.LASF0
	.byte	0x7
	.byte	0x77
	.long	0x147
	.byte	0
	.uleb128 0x8
	.ascii "AsyncData\0"
	.byte	0x7
	.byte	0x77
	.long	0x147
	.byte	0x8
	.uleb128 0x8
	.ascii "Interval\0"
	.byte	0x7
	.byte	0x78
	.long	0x2c9
	.byte	0x10
	.uleb128 0x8
	.ascii "TimeElapsed\0"
	.byte	0x7
	.byte	0x78
	.long	0x2c9
	.byte	0x14
	.uleb128 0x8
	.ascii "Iterations\0"
	.byte	0x7
	.byte	0x79
	.long	0x2f1
	.byte	0x18
	.uleb128 0x8
	.ascii "Cycles\0"
	.byte	0x7
	.byte	0x7a
	.long	0x18b
	.byte	0x1c
	.uleb128 0x8
	.ascii "Priority\0"
	.byte	0x7
	.byte	0x7b
	.long	0x2de
	.byte	0x20
	.uleb128 0x8
	.ascii "Callback\0"
	.byte	0x7
	.byte	0x7c
	.long	0x36d
	.byte	0x28
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x7
	.byte	0x7d
	.long	0x4c2
	.byte	0x30
	.uleb128 0x8
	.ascii "Next\0"
	.byte	0x7
	.byte	0x7e
	.long	0x4c7
	.byte	0x38
	.byte	0
	.uleb128 0xd
	.long	0x3fb
	.uleb128 0x5
	.byte	0x8
	.long	0x4cd
	.uleb128 0xd
	.long	0x40f
	.uleb128 0xe
	.byte	0x10
	.byte	0x7
	.byte	0x82
	.long	0x4fa
	.uleb128 0x8
	.ascii "Task\0"
	.byte	0x7
	.byte	0x83
	.long	0x4c7
	.byte	0
	.uleb128 0x8
	.ascii "QueueData\0"
	.byte	0x7
	.byte	0x84
	.long	0x147
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x7
	.byte	0x85
	.long	0x4d2
	.uleb128 0xe
	.byte	0x4
	.byte	0x7
	.byte	0x87
	.long	0x562
	.uleb128 0x8
	.ascii "Init\0"
	.byte	0x7
	.byte	0x88
	.long	0x17c
	.byte	0
	.uleb128 0x8
	.ascii "FCallIdle\0"
	.byte	0x7
	.byte	0x88
	.long	0x17c
	.byte	0x1
	.uleb128 0x8
	.ascii "ReleaseSched\0"
	.byte	0x7
	.byte	0x88
	.long	0x17c
	.byte	0x2
	.uleb128 0x8
	.ascii "FCallReleased\0"
	.byte	0x7
	.byte	0x88
	.long	0x17c
	.byte	0x3
	.byte	0
	.uleb128 0x3
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x7
	.byte	0x89
	.long	0x50f
	.uleb128 0xe
	.byte	0x68
	.byte	0x7
	.byte	0x8b
	.long	0x66f
	.uleb128 0x8
	.ascii "IDLECallback\0"
	.byte	0x7
	.byte	0x8c
	.long	0x36d
	.byte	0
	.uleb128 0x8
	.ascii "ReleaseSchedCallback\0"
	.byte	0x7
	.byte	0x8d
	.long	0x36d
	.byte	0x8
	.uleb128 0x8
	.ascii "Tick\0"
	.byte	0x7
	.byte	0x8e
	.long	0x2b1
	.byte	0x10
	.uleb128 0x8
	.ascii "EventInfo\0"
	.byte	0x7
	.byte	0x8f
	.long	0x35d
	.byte	0x18
	.uleb128 0x8
	.ascii "First\0"
	.byte	0x7
	.byte	0x90
	.long	0x4c7
	.byte	0x38
	.uleb128 0x8
	.ascii "I_Disable\0"
	.byte	0x7
	.byte	0x91
	.long	0x155
	.byte	0x40
	.uleb128 0x8
	.ascii "I_Enabler\0"
	.byte	0x7
	.byte	0x92
	.long	0x155
	.byte	0x48
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x7
	.byte	0x93
	.long	0x66f
	.byte	0x50
	.uleb128 0x8
	.ascii "QueueStack\0"
	.byte	0x7
	.byte	0x94
	.long	0x674
	.byte	0x58
	.uleb128 0x8
	.ascii "QueueSize\0"
	.byte	0x7
	.byte	0x95
	.long	0x17c
	.byte	0x60
	.uleb128 0x8
	.ascii "QueueIndex\0"
	.byte	0x7
	.byte	0x95
	.long	0x17c
	.byte	0x61
	.uleb128 0x8
	.ascii "NotSafeQueue\0"
	.byte	0x7
	.byte	0x96
	.long	0x3f6
	.byte	0x62
	.uleb128 0x8
	.ascii "epochs\0"
	.byte	0x7
	.byte	0x98
	.long	0x2c9
	.byte	0x64
	.byte	0
	.uleb128 0xd
	.long	0x562
	.uleb128 0x5
	.byte	0x8
	.long	0x67a
	.uleb128 0xd
	.long	0x4fa
	.uleb128 0x3
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x7
	.byte	0x9a
	.long	0x57a
	.uleb128 0x12
	.ascii "state\0"
	.byte	0x4
	.long	0xd5
	.byte	0x7
	.word	0x1e5
	.long	0x6d6
	.uleb128 0xa
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0xa
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x13
	.ascii "qSM_Status_t\0"
	.byte	0x7
	.word	0x1e5
	.long	0x698
	.uleb128 0x14
	.byte	0x18
	.byte	0x7
	.word	0x1fe
	.long	0x731
	.uleb128 0x15
	.ascii "__Failure\0"
	.byte	0x7
	.word	0x1ff
	.long	0x7d2
	.byte	0
	.uleb128 0x15
	.ascii "__Success\0"
	.byte	0x7
	.word	0x200
	.long	0x7d2
	.byte	0x8
	.uleb128 0x15
	.ascii "__Unexpected\0"
	.byte	0x7
	.word	0x201
	.long	0x7d2
	.byte	0x10
	.byte	0
	.uleb128 0x10
	.long	0x73c
	.uleb128 0x11
	.long	0x73c
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x7cd
	.uleb128 0x16
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x7
	.word	0x1e9
	.long	0x7cd
	.uleb128 0x15
	.ascii "NextState\0"
	.byte	0x7
	.word	0x1ed
	.long	0x7e7
	.byte	0
	.uleb128 0x15
	.ascii "PreviousState\0"
	.byte	0x7
	.word	0x1f1
	.long	0x7e7
	.byte	0x8
	.uleb128 0x15
	.ascii "PreviousReturnStatus\0"
	.byte	0x7
	.word	0x1f5
	.long	0x6d6
	.byte	0x10
	.uleb128 0x15
	.ascii "StateJustChanged\0"
	.byte	0x7
	.word	0x1f9
	.long	0x305
	.byte	0x14
	.uleb128 0x17
	.secrel32	.LASF1
	.byte	0x7
	.word	0x1fd
	.long	0x147
	.byte	0x18
	.uleb128 0x15
	.ascii "_\0"
	.byte	0x7
	.word	0x202
	.long	0x6eb
	.byte	0x20
	.byte	0
	.uleb128 0xd
	.long	0x742
	.uleb128 0x5
	.byte	0x8
	.long	0x731
	.uleb128 0x18
	.long	0x6d6
	.long	0x7e7
	.uleb128 0x11
	.long	0x73c
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x7d8
	.uleb128 0x14
	.byte	0xc
	.byte	0x7
	.word	0x263
	.long	0x81e
	.uleb128 0x15
	.ascii "SR\0"
	.byte	0x7
	.word	0x264
	.long	0x17c
	.byte	0
	.uleb128 0x15
	.ascii "Start\0"
	.byte	0x7
	.word	0x265
	.long	0x2c9
	.byte	0x4
	.uleb128 0x15
	.ascii "TV\0"
	.byte	0x7
	.word	0x265
	.long	0x2c9
	.byte	0x8
	.byte	0
	.uleb128 0x13
	.ascii "qSTimer_t\0"
	.byte	0x7
	.word	0x266
	.long	0x7ed
	.uleb128 0x19
	.ascii "primero\0"
	.byte	0x1
	.byte	0xe
	.long	0x6d6
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x87c
	.uleb128 0x1a
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xe
	.long	0x73c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1b
	.ascii "TaskEventData\0"
	.byte	0x1
	.byte	0xf
	.long	0x87c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x35d
	.uleb128 0x19
	.ascii "segundo\0"
	.byte	0x1
	.byte	0x1c
	.long	0x6d6
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x8b6
	.uleb128 0x1a
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1c
	.long	0x73c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "tercero\0"
	.byte	0x1
	.byte	0x22
	.long	0x6d6
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x8fd
	.uleb128 0x1a
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x22
	.long	0x73c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1b
	.ascii "x\0"
	.byte	0x1
	.byte	0x23
	.long	0xd5
	.uleb128 0x9
	.byte	0x3
	.quad	x.4613
	.byte	0
	.uleb128 0x1c
	.ascii "smerror\0"
	.byte	0x1
	.byte	0x32
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x92d
	.uleb128 0x1a
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x32
	.long	0x73c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1c
	.ascii "smok\0"
	.byte	0x1
	.byte	0x36
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x95a
	.uleb128 0x1a
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x36
	.long	0x73c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "TimerInterruptEmulation\0"
	.byte	0x1
	.byte	0x3c
	.long	0x147
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0x9b2
	.uleb128 0x1d
	.ascii "varargin\0"
	.byte	0x1
	.byte	0x3c
	.long	0x147
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1b
	.ascii "tick\0"
	.byte	0x1
	.byte	0x3d
	.long	0x1a9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1c
	.ascii "printqueue\0"
	.byte	0x1
	.byte	0x46
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0x9e3
	.uleb128 0x1b
	.ascii "i\0"
	.byte	0x1
	.byte	0x47
	.long	0xd5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x1c
	.ascii "Task1Callback\0"
	.byte	0x1
	.byte	0x51
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xa2c
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x51
	.long	0x35d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x1b
	.ascii "x\0"
	.byte	0x1
	.byte	0x52
	.long	0x81e
	.uleb128 0x9
	.byte	0x3
	.quad	x.4643
	.byte	0
	.uleb128 0x1c
	.ascii "Task2Callback\0"
	.byte	0x1
	.byte	0x57
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0xa7c
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x57
	.long	0x35d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x1b
	.ascii "Maquina1\0"
	.byte	0x1
	.byte	0x58
	.long	0x7cd
	.uleb128 0x9
	.byte	0x3
	.quad	Maquina1.4647
	.byte	0
	.uleb128 0x1c
	.ascii "Task3Callback\0"
	.byte	0x1
	.byte	0x60
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0xab2
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x60
	.long	0x35d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1c
	.ascii "Task4Callback\0"
	.byte	0x1
	.byte	0x68
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0xb23
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x68
	.long	0x35d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x1b
	.ascii "Timer\0"
	.byte	0x1
	.byte	0x69
	.long	0x81e
	.uleb128 0x9
	.byte	0x3
	.quad	Timer.4654
	.uleb128 0x1e
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x6e
	.long	0x240
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4655
	.uleb128 0x1f
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x6e
	.quad	.L31
	.byte	0
	.uleb128 0x1c
	.ascii "Task5Callback\0"
	.byte	0x1
	.byte	0x84
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0xb59
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x84
	.long	0x35d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x1c
	.ascii "Task6Callback\0"
	.byte	0x1
	.byte	0x8a
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0xb8f
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x8a
	.long	0x35d
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "IdleTaskCallback\0"
	.byte	0x1
	.byte	0x8e
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0xbc8
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x8e
	.long	0x35d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x1c
	.ascii "SchedReleaseCallback\0"
	.byte	0x1
	.byte	0x92
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0xc05
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x92
	.long	0x35d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "TaskTestSTCallback\0"
	.byte	0x1
	.byte	0x96
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0xc40
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x96
	.long	0x35d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x1c
	.ascii "TaskX_Callback\0"
	.byte	0x1
	.byte	0x9c
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.long	0xc9b
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x9c
	.long	0x35d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x1e
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x9d
	.long	0x240
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4684
	.uleb128 0x1f
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x9d
	.quad	.L50
	.byte	0
	.uleb128 0x1c
	.ascii "TaskY_Callback\0"
	.byte	0x1
	.byte	0xa8
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.long	0xcff
	.uleb128 0x1a
	.secrel32	.LASF1
	.byte	0x1
	.byte	0xa8
	.long	0x35d
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x21
	.ascii "i\0"
	.byte	0x1
	.byte	0xa9
	.long	0xd5
	.uleb128 0x1e
	.secrel32	.LASF3
	.byte	0x1
	.byte	0xaa
	.long	0x240
	.uleb128 0x9
	.byte	0x3
	.quad	_qCRTaskState_.4694
	.uleb128 0x1f
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xaa
	.quad	.L59
	.byte	0
	.uleb128 0x1c
	.ascii "alarm_signal\0"
	.byte	0x1
	.byte	0xb4
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.long	0xd32
	.uleb128 0x1d
	.ascii "x\0"
	.byte	0x1
	.byte	0xb4
	.long	0xd5
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1c
	.ascii "sigint_signal\0"
	.byte	0x1
	.byte	0xb9
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.long	0xd66
	.uleb128 0x1d
	.ascii "x\0"
	.byte	0x1
	.byte	0xb9
	.long	0xd5
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "main\0"
	.byte	0x1
	.byte	0xbf
	.long	0xd5
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.uleb128 0x1
	.byte	0x9c
	.long	0xdbf
	.uleb128 0x1d
	.ascii "argc\0"
	.byte	0x1
	.byte	0xbf
	.long	0xd5
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1d
	.ascii "argv\0"
	.byte	0x1
	.byte	0xbf
	.long	0xdbf
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1b
	.ascii "_qQueueStack\0"
	.byte	0x1
	.byte	0xc3
	.long	0xdd5
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x15c
	.uleb128 0x22
	.long	0x67a
	.long	0xdd5
	.uleb128 0x23
	.long	0x149
	.byte	0x9
	.byte	0
	.uleb128 0xd
	.long	0xdc5
	.uleb128 0x24
	.ascii "QUARKTS\0"
	.byte	0x7
	.byte	0x9b
	.long	0xde9
	.uleb128 0xd
	.long	0x67f
	.uleb128 0x25
	.ascii "TimerEmulation\0"
	.byte	0x1
	.byte	0x3b
	.long	0x1ff
	.uleb128 0x9
	.byte	0x3
	.quad	TimerEmulation
	.uleb128 0x25
	.ascii "Task1\0"
	.byte	0x1
	.byte	0x44
	.long	0x4cd
	.uleb128 0x9
	.byte	0x3
	.quad	Task1
	.uleb128 0x25
	.ascii "Task2\0"
	.byte	0x1
	.byte	0x44
	.long	0x4cd
	.uleb128 0x9
	.byte	0x3
	.quad	Task2
	.uleb128 0x25
	.ascii "Task3\0"
	.byte	0x1
	.byte	0x44
	.long	0x4cd
	.uleb128 0x9
	.byte	0x3
	.quad	Task3
	.uleb128 0x25
	.ascii "Task4\0"
	.byte	0x1
	.byte	0x44
	.long	0x4cd
	.uleb128 0x9
	.byte	0x3
	.quad	Task4
	.uleb128 0x25
	.ascii "Task5\0"
	.byte	0x1
	.byte	0x44
	.long	0x4cd
	.uleb128 0x9
	.byte	0x3
	.quad	Task5
	.uleb128 0x25
	.ascii "Task6\0"
	.byte	0x1
	.byte	0x44
	.long	0x4cd
	.uleb128 0x9
	.byte	0x3
	.quad	Task6
	.uleb128 0x25
	.ascii "TaskTestST\0"
	.byte	0x1
	.byte	0x44
	.long	0x4cd
	.uleb128 0x9
	.byte	0x3
	.quad	TaskTestST
	.uleb128 0x25
	.ascii "TaskX\0"
	.byte	0x1
	.byte	0x9b
	.long	0x4cd
	.uleb128 0x9
	.byte	0x3
	.quad	TaskX
	.uleb128 0x25
	.ascii "TaskY\0"
	.byte	0x1
	.byte	0x9b
	.long	0x4cd
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
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
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
	.uleb128 0xa
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0xb
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
	.uleb128 0xc
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
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
	.uleb128 0xf
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
	.uleb128 0x10
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
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
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
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
	.uleb128 0x18
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
	.uleb128 0x1c
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
	.uleb128 0x1d
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
	.uleb128 0x1e
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
	.uleb128 0x1f
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
	.uleb128 0x20
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
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x24
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
	.uleb128 0x25
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
	.ascii "Machine\0"
.LASF1:
	.ascii "Data\0"
.LASF4:
	.ascii "_qCR_BEGIN_\0"
.LASF3:
	.ascii "_qCRTaskState_\0"
.LASF0:
	.ascii "UserData\0"
	.ident	"GCC: (GNU) 5.4.0"
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	_qISRHandler;	.scl	2;	.type	32;	.endef
	.def	_qSTimerSet;	.scl	2;	.type	32;	.endef
	.def	_qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.def	_qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.def	_qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.def	_qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.def	_qEnqueueTaskEvent;	.scl	2;	.type	32;	.endef
	.def	_qSTimerExpired;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	alarm;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.def	_qCreateTask;	.scl	2;	.type	32;	.endef
	.def	_qStart;	.scl	2;	.type	32;	.endef
	.section	.rdata$.refptr.QUARKTS, "dr"
	.globl	.refptr.QUARKTS
	.linkonce	discard
.refptr.QUARKTS:
	.quad	QUARKTS
