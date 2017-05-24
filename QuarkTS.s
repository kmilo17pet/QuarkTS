	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 104, 5
	.globl	_qSendEvent
	.def	_qSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSendEvent
_qSendEvent:
.LFB0:
	.file 1 "QuarkTS.c"
	.loc 1 26 0
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
	movq	%rdx, 24(%rbp)
	.loc 1 27 0
	movq	16(%rbp), %rax
	movb	$1, 50(%rax)
	.loc 1 28 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 29 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.seh_endproc
	.globl	_qSetTime
	.def	_qSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSetTime
_qSetTime:
.LFB1:
	.loc 1 31 0
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
	movss	%xmm1, 24(%rbp)
	.loc 1 32 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 33 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.seh_endproc
	.globl	_qSetIterations
	.def	_qSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSetIterations
_qSetIterations:
.LFB2:
	.loc 1 35 0
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
	movl	%edx, %eax
	movb	%al, 24(%rbp)
	.loc 1 36 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 37 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.seh_endproc
	.globl	_qSetPriority
	.def	_qSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSetPriority
_qSetPriority:
.LFB3:
	.loc 1 39 0
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
	movl	%edx, %eax
	movb	%al, 24(%rbp)
	.loc 1 40 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 41 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 42 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.seh_endproc
	.globl	_qSetCallback
	.def	_qSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSetCallback
_qSetCallback:
.LFB4:
	.loc 1 44 0
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
	movq	%rdx, 24(%rbp)
	.loc 1 45 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 46 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.seh_endproc
	.globl	_qEnableDisable
	.def	_qEnableDisable;	.scl	2;	.type	32;	.endef
	.seh_proc	_qEnableDisable
_qEnableDisable:
.LFB5:
	.loc 1 48 0
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
	movl	%edx, %eax
	movb	%al, 24(%rbp)
	.loc 1 49 0
	cmpb	$0, 24(%rbp)
	je	.L7
	.loc 1 49 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movl	$0, 20(%rax)
.L7:
	.loc 1 50 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 52(%rax)
	.loc 1 51 0
	cmpb	$0, 24(%rbp)
	jne	.L9
	.loc 1 51 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movl	$0, 20(%rax)
.L9:
	.loc 1 52 0 is_stmt 1
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.seh_endproc
	.globl	_qSetUserData
	.def	_qSetUserData;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSetUserData
_qSetUserData:
.LFB6:
	.loc 1 54 0
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
	movq	%rdx, 24(%rbp)
	.loc 1 55 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 56 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.seh_endproc
	.globl	_qClearTimeElapse
	.def	_qClearTimeElapse;	.scl	2;	.type	32;	.endef
	.seh_proc	_qClearTimeElapse
_qClearTimeElapse:
.LFB7:
	.loc 1 58 0
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
	.loc 1 59 0
	movq	16(%rbp), %rax
	movl	$0, 20(%rax)
	.loc 1 60 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.seh_endproc
	.globl	_qEnqueueTaskEvent
	.def	_qEnqueueTaskEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	_qEnqueueTaskEvent
_qEnqueueTaskEvent:
.LFB8:
	.loc 1 62 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	.loc 1 63 0
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jle	.L13
	.loc 1 63 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L25
.L13:
	.loc 1 64 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L15
	.loc 1 64 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
.L15:
	.loc 1 65 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 98(%rax)
	.loc 1 67 0
	movq	16(%rbp), %rax
	movq	%rax, -32(%rbp)
	.loc 1 68 0
	movq	24(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 70 0
	movq	16(%rbp), %rax
	movzbl	32(%rax), %eax
	movb	%al, -2(%rbp)
	.loc 1 71 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L16
	.loc 1 72 0
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L18
	.loc 1 73 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 74 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	jmp	.L18
.L16:
	.loc 1 77 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L18:
	.loc 1 78 0
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 97(%rax)
	.loc 1 79 0
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	cmpb	$1, %al
	jne	.L19
	.loc 1 80 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L20
	.loc 1 80 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	call	*%rax
.L20:
	.loc 1 81 0 is_stmt 1
	movl	$0, %eax
	jmp	.L25
.L19:
	.loc 1 84 0
	movb	$0, -1(%rbp)
	jmp	.L21
.L23:
	.loc 1 85 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L22
	.loc 1 86 0
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L22
	.loc 1 87 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 88 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	leaq	(%rdx,%rax), %rcx
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 89 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L22:
	.loc 1 84 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L21:
	.loc 1 84 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L23
	.loc 1 93 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L24
	.loc 1 93 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	call	*%rax
.L24:
	.loc 1 94 0 is_stmt 1
	movl	$0, %eax
.L25:
	.loc 1 95 0 discriminator 1
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.def	_qDequeueTaskEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qDequeueTaskEvent
_qDequeueTaskEvent:
.LFB9:
	.loc 1 97 0
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
	.loc 1 99 0
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	subl	$1, %eax
	movb	%al, -1(%rbp)
	.loc 1 100 0
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	testb	%al, %al
	jne	.L27
	.loc 1 100 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L28
.L27:
	.loc 1 101 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L29
	.loc 1 102 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L30
	.loc 1 102 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
.L30:
	.loc 1 103 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 104 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 105 0
	cmpb	$0, -1(%rbp)
	je	.L31
	.loc 1 105 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	97(%rax), %eax
	leal	-1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 97(%rax)
.L31:
	.loc 1 106 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L32
	.loc 1 106 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	call	*%rax
.L32:
	.loc 1 107 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L28
.L29:
	.loc 1 109 0
	movl	$0, %eax
.L28:
	.loc 1 110 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.globl	_qSetInterruptsED
	.def	_qSetInterruptsED;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSetInterruptsED
_qSetInterruptsED:
.LFB10:
	.loc 1 112 0
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
	movq	%rdx, 24(%rbp)
	.loc 1 113 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 114 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 115 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.globl	_qInitScheduler
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qInitScheduler
_qInitScheduler:
.LFB11:
	.loc 1 117 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movss	%xmm0, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	%r8, 32(%rbp)
	movl	%r9d, %eax
	movb	%al, 40(%rbp)
	.loc 1 119 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 56(%rax)
	.loc 1 120 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rbp), %xmm0
	movss	%xmm0, 16(%rax)
	.loc 1 121 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 122 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 8(%rax)
	.loc 1 123 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 88(%rax)
	.loc 1 124 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 96(%rax)
	.loc 1 125 0
	movb	$0, -1(%rbp)
	jmp	.L35
.L36:
	.loc 1 125 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L35:
	.loc 1 125 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L36
	.loc 1 126 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 97(%rax)
	.loc 1 127 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 128 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 98(%rax)
	.loc 1 129 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 130 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 83(%rax)
	.loc 1 131 0
	movl	$0, %eax
	leaq	QUARKTS(%rip), %rdx
	movq	%rax, 64(%rdx)
	leaq	QUARKTS(%rip), %rdx
	movq	%rax, 72(%rdx)
	.loc 1 133 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 100(%rax)
	.loc 1 135 0
	nop
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.globl	_qISRHandler
	.def	_qISRHandler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qISRHandler
_qISRHandler:
.LFB12:
	.loc 1 137 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	.loc 1 138 0
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	testb	%al, %al
	je	.L45
	.loc 1 139 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 140 0
	jmp	.L40
.L44:
	.loc 1 141 0
	movq	-8(%rbp), %rax
	movzbl	52(%rax), %eax
	testb	%al, %al
	je	.L41
	.loc 1 141 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	testl	%eax, %eax
	je	.L41
	.loc 1 142 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	20(%rax), %eax
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 143 0
	movq	-8(%rbp), %rax
	movl	20(%rax), %edx
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	%eax, %edx
	jb	.L41
	.loc 1 144 0
	movq	-8(%rbp), %rax
	movzbl	51(%rax), %eax
	testb	%al, %al
	jne	.L42
	.loc 1 144 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	1(%rax), %edx
	jmp	.L43
.L42:
	.loc 1 144 0 discriminator 2
	movl	$1, %edx
.L43:
	.loc 1 144 0 discriminator 4
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 145 0 is_stmt 1 discriminator 4
	movq	-8(%rbp), %rax
	movl	$0, 20(%rax)
.L41:
	.loc 1 148 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L40:
	.loc 1 140 0
	cmpq	$0, -8(%rbp)
	jne	.L44
	.loc 1 151 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 100(%rax)
	jmp	.L37
.L45:
	.loc 1 138 0
	nop
.L37:
	.loc 1 153 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.seh_endproc
	.globl	_qCreateTask
	.def	_qCreateTask;	.scl	2;	.type	32;	.endef
	.seh_proc	_qCreateTask
_qCreateTask:
.LFB13:
	.loc 1 155 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movl	%r8d, %ecx
	movss	%xmm3, 40(%rbp)
	movl	48(%rbp), %edx
	movl	56(%rbp), %eax
	movb	%cl, 32(%rbp)
	movb	%dl, -4(%rbp)
	movb	%al, -8(%rbp)
	.loc 1 156 0
	movss	40(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L47
	.loc 1 156 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L49
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L49
.L47:
	.loc 1 156 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L50
.L49:
	.loc 1 156 0 discriminator 5
	movl	$-1, %eax
	jmp	.L51
.L50:
	.loc 1 157 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 158 0
	movq	16(%rbp), %rax
	movl	$0, 20(%rax)
	.loc 1 159 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 160 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 161 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 162 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 163 0
	movl	$0, %eax
	movq	16(%rbp), %rdx
	movb	%al, 48(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 49(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 50(%rdx)
	.loc 1 164 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 52(%rax)
	.loc 1 165 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 166 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 167 0
	movq	16(%rbp), %rax
	movl	$0, 28(%rax)
	.loc 1 168 0
	movl	$0, %eax
.L51:
	.loc 1 169 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.seh_endproc
	.def	_qTriggerEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerEvent
_qTriggerEvent:
.LFB14:
	.loc 1 171 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	%edx, 24(%rbp)
	.loc 1 172 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 24(%rax)
	.loc 1 173 0
	movq	16(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 174 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 175 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L54
	.loc 1 175 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	24(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movq	32(%rax), %rcx
	movq	%rcx, -24(%rbp)
	movq	40(%rax), %rcx
	movq	%rcx, -16(%rbp)
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, %rcx
	call	*%rdx
.L54:
	.loc 1 176 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 49(%rax)
	.loc 1 177 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 40(%rax)
	.loc 1 178 0
	movq	16(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 28(%rax)
	.loc 1 179 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.def	_qTaskChainbyPriority;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTaskChainbyPriority
_qTaskChainbyPriority:
.LFB15:
	.loc 1 181 0
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
	.loc 1 182 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 183 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 184 0
	jmp	.L56
.L63:
	.loc 1 185 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 186 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 187 0
	jmp	.L57
.L62:
	.loc 1 188 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	%al, %dl
	jnb	.L58
	.loc 1 189 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 190 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 191 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L59
	.loc 1 191 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L60
.L59:
	.loc 1 192 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L60:
	.loc 1 193 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 194 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L61
.L58:
	.loc 1 197 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 198 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L61:
	.loc 1 200 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 201 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L57
	.loc 1 201 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L57:
	.loc 1 187 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L62
.L56:
	.loc 1 184 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L63
	.loc 1 204 0
	nop
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.seh_endproc
	.globl	_qStart
	.def	_qStart;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStart
_qStart:
.LFB16:
	.loc 1 206 0
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
	.seh_endprologue
.L65:
	.loc 1 209 0
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	jne	.L84
	.loc 1 210 0
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	testb	%al, %al
	jne	.L68
	.loc 1 211 0
	call	_qTaskChainbyPriority
	.loc 1 212 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 80(%rax)
.L68:
	.loc 1 214 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 215 0
	jmp	.L69
.L81:
	.loc 1 216 0
	call	_qDequeueTaskEvent
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L70
	.loc 1 216 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L70:
	.loc 1 218 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	jne	.L71
	.loc 1 218 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L72
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L73
.L72:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L73:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L74
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L74
.L71:
	.loc 1 218 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L76
	.loc 1 218 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	jne	.L74
.L76:
	.loc 1 218 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	52(%rax), %eax
	testb	%al, %al
	je	.L74
	.loc 1 219 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 220 0
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	je	.L77
	.loc 1 220 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 24(%rax)
.L77:
	.loc 1 221 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L78
	.loc 1 221 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 52(%rax)
.L78:
	.loc 1 222 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L79
.L74:
	.loc 1 224 0
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L80
	.loc 1 225 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 226 0
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
	.loc 1 227 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L79
.L80:
	.loc 1 229 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L79
	.loc 1 230 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 231 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 24(%rax)
	.loc 1 232 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	24(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movq	32(%rax), %rcx
	movq	%rcx, -40(%rbp)
	movq	40(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movq	48(%rax), %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	call	*%rdx
	.loc 1 233 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
.L79:
	.loc 1 235 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L69:
	.loc 1 215 0
	cmpq	$0, -8(%rbp)
	jne	.L81
	.loc 1 237 0
	jmp	.L65
.L84:
	.loc 1 209 0
	nop
.L67:
	.loc 1 239 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 240 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 241 0
	leaq	QUARKTS(%rip), %rax
	movzbl	83(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 242 0
	leaq	QUARKTS(%rip), %rax
	movl	$3, 24(%rax)
	.loc 1 243 0
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L82
	.loc 1 243 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	24(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movq	32(%rax), %rcx
	movq	%rcx, -40(%rbp)
	movq	40(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movq	48(%rax), %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	call	*%rdx
.L82:
	.loc 1 244 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 245 0
	nop
	addq	$80, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.globl	_qStateMachine_Init
	.def	_qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStateMachine_Init
_qStateMachine_Init:
.LFB17:
	.loc 1 247 0
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
	movq	%rdx, 24(%rbp)
	movq	%r8, 32(%rbp)
	movq	%r9, 40(%rbp)
	.loc 1 248 0
	cmpq	$0, 24(%rbp)
	jne	.L86
	.loc 1 248 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L87
.L86:
	.loc 1 249 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 250 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 251 0
	movq	16(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 32(%rax)
	.loc 1 252 0
	movq	16(%rbp), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 253 0
	movq	16(%rbp), %rax
	movq	48(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 254 0
	movl	$0, %eax
.L87:
	.loc 1 255 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.globl	_qStateMachine_Run
	.def	_qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStateMachine_Run
_qStateMachine_Run:
.LFB18:
	.loc 1 257 0
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
	movq	%rdx, 24(%rbp)
	.loc 1 258 0
	movq	$0, -8(%rbp)
	.loc 1 259 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 260 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L89
	.loc 1 261 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 20(%rax)
	.loc 1 262 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 263 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 264 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L90
.L89:
	.loc 1 266 0
	movq	16(%rbp), %rax
	movl	$-32767, 16(%rax)
.L90:
	.loc 1 268 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$-32768, %eax
	je	.L92
	cmpl	$-32767, %eax
	jne	.L98
	.loc 1 270 0
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	testq	%rax, %rax
	je	.L99
	.loc 1 270 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 271 0 is_stmt 1 discriminator 1
	jmp	.L99
.L92:
	.loc 1 273 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L100
	.loc 1 273 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 274 0 is_stmt 1 discriminator 1
	jmp	.L100
.L98:
	.loc 1 276 0
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	je	.L101
	.loc 1 276 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 277 0 is_stmt 1 discriminator 1
	jmp	.L101
.L99:
	.loc 1 271 0
	nop
	jmp	.L95
.L100:
	.loc 1 274 0
	nop
	jmp	.L95
.L101:
	.loc 1 277 0
	nop
.L95:
	.loc 1 279 0
	nop
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.globl	_qSTimerSet
	.def	_qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSTimerSet
_qSTimerSet:
.LFB19:
	.loc 1 282 0
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
	movss	%xmm1, 24(%rbp)
	movl	%r8d, %eax
	movb	%al, 32(%rbp)
	.loc 1 283 0
	cmpb	$0, 32(%rbp)
	je	.L103
	.loc 1 283 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L103
	.loc 1 284 0 is_stmt 1
	movq	16(%rbp), %rcx
	call	_qSTimerExpired
	testb	%al, %al
	je	.L104
	.loc 1 285 0
	movq	16(%rbp), %rax
	movb	$0, (%rax)
	.loc 1 286 0
	movl	$1, %eax
	jmp	.L105
.L104:
	.loc 1 288 0
	movl	$0, %eax
	jmp	.L105
.L103:
	.loc 1 290 0
	cvtss2sd	24(%rbp), %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	ucomisd	%xmm1, %xmm0
	jbe	.L109
	.loc 1 290 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L105
.L109:
	.loc 1 291 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 8(%rax)
	.loc 1 292 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 4(%rax)
	.loc 1 293 0
	movq	16(%rbp), %rax
	movb	$1, (%rax)
	.loc 1 294 0
	movl	$0, %eax
.L105:
	.loc 1 295 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
	.globl	_qSTimerExpired
	.def	_qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSTimerExpired
_qSTimerExpired:
.LFB20:
	.loc 1 297 0
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
	.loc 1 298 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L111
	.loc 1 298 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L112
.L111:
	.loc 1 299 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	%eax, %edx
	setnb	%al
.L112:
	.loc 1 300 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.seh_endproc
	.globl	_qSTimerElapsed
	.def	_qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSTimerElapsed
_qSTimerElapsed:
.LFB21:
	.loc 1 302 0
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
	.loc 1 303 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	.loc 1 304 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
	.globl	_qSTimerRemaining
	.def	_qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSTimerRemaining
_qSTimerRemaining:
.LFB22:
	.loc 1 306 0
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
	.loc 1 307 0
	movq	16(%rbp), %rcx
	call	_qSTimerElapsed
	movl	%eax, -4(%rbp)
	.loc 1 308 0
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L116
	.loc 1 308 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rax
	movl	8(%rax), %edx
	movl	-4(%rbp), %eax
	cmpl	%eax, %edx
	jnb	.L117
.L116:
	.loc 1 308 0 discriminator 3
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	jmp	.L118
.L117:
	.loc 1 308 0 discriminator 4
	movq	16(%rbp), %rax
	movl	8(%rax), %edx
	movl	-4(%rbp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
.L118:
	.loc 1 309 0 is_stmt 1 discriminator 6
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1073741824
	.align 8
.LC2:
	.long	0
	.long	1073741824
	.text
.Letext0:
	.file 2 "/usr/include/machine/_default_types.h"
	.file 3 "/usr/include/sys/_stdint.h"
	.file 4 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xf88
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C11 5.4.0 -mtune=generic -march=x86-64 -g\0"
	.byte	0xc
	.ascii "QuarkTS.c\0"
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
	.long	0xa4
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
	.long	0xf1
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
	.uleb128 0x3
	.ascii "uint8_t\0"
	.byte	0x3
	.byte	0x18
	.long	0x93
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x30
	.long	0xdf
	.uleb128 0x4
	.byte	0x4
	.long	0xf1
	.byte	0x4
	.byte	0x38
	.long	0x18e
	.uleb128 0x5
	.ascii "byTimeElapsed\0"
	.byte	0
	.uleb128 0x5
	.ascii "byPriority\0"
	.byte	0x1
	.uleb128 0x5
	.ascii "byQueueExtraction\0"
	.byte	0x2
	.uleb128 0x5
	.ascii "byAsyncEvent\0"
	.byte	0x3
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x4
	.byte	0x38
	.long	0x141
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x4
	.byte	0x39
	.long	0x1af
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x4
	.byte	0x3a
	.long	0x1c8
	.uleb128 0x6
	.long	0x131
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x4
	.byte	0x3b
	.long	0x122
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x4
	.byte	0x3c
	.long	0x122
	.uleb128 0x3
	.ascii "qState_t\0"
	.byte	0x4
	.byte	0x3d
	.long	0x122
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x4
	.byte	0x3e
	.long	0x122
	.uleb128 0x7
	.byte	0x20
	.byte	0x4
	.byte	0x4c
	.long	0x25c
	.uleb128 0x8
	.ascii "Trigger\0"
	.byte	0x4
	.byte	0x5f
	.long	0x18e
	.byte	0
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x63
	.long	0x25c
	.byte	0x8
	.uleb128 0x8
	.ascii "EventData\0"
	.byte	0x4
	.byte	0x67
	.long	0x25c
	.byte	0x10
	.uleb128 0x8
	.ascii "FirstCall\0"
	.byte	0x4
	.byte	0x6c
	.long	0x204
	.byte	0x18
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x4
	.byte	0x6d
	.long	0x213
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x4
	.byte	0x6f
	.long	0x280
	.uleb128 0xb
	.byte	0x8
	.long	0x286
	.uleb128 0xc
	.long	0x291
	.uleb128 0xd
	.long	0x25e
	.byte	0
	.uleb128 0x7
	.byte	0x5
	.byte	0x4
	.byte	0x70
	.long	0x2f7
	.uleb128 0x8
	.ascii "TimedTaskRun\0"
	.byte	0x4
	.byte	0x71
	.long	0x2f7
	.byte	0
	.uleb128 0x8
	.ascii "InitFlag\0"
	.byte	0x4
	.byte	0x71
	.long	0x2f7
	.byte	0x1
	.uleb128 0x8
	.ascii "AsyncRun\0"
	.byte	0x4
	.byte	0x71
	.long	0x2f7
	.byte	0x2
	.uleb128 0x8
	.ascii "IgnoreOveruns\0"
	.byte	0x4
	.byte	0x71
	.long	0x2f7
	.byte	0x3
	.uleb128 0x8
	.ascii "Enabled\0"
	.byte	0x4
	.byte	0x71
	.long	0x2f7
	.byte	0x4
	.byte	0
	.uleb128 0x6
	.long	0x122
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x4
	.byte	0x72
	.long	0x291
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x4
	.byte	0x76
	.long	0x3be
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x77
	.long	0x25c
	.byte	0
	.uleb128 0x8
	.ascii "AsyncData\0"
	.byte	0x4
	.byte	0x77
	.long	0x25c
	.byte	0x8
	.uleb128 0x8
	.ascii "Interval\0"
	.byte	0x4
	.byte	0x78
	.long	0x1b8
	.byte	0x10
	.uleb128 0x8
	.ascii "TimeElapsed\0"
	.byte	0x4
	.byte	0x78
	.long	0x1b8
	.byte	0x14
	.uleb128 0x8
	.ascii "Iterations\0"
	.byte	0x4
	.byte	0x79
	.long	0x1e0
	.byte	0x18
	.uleb128 0x8
	.ascii "Cycles\0"
	.byte	0x4
	.byte	0x7a
	.long	0x131
	.byte	0x1c
	.uleb128 0x9
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x7b
	.long	0x1cd
	.byte	0x20
	.uleb128 0x8
	.ascii "Callback\0"
	.byte	0x4
	.byte	0x7c
	.long	0x26e
	.byte	0x28
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x7d
	.long	0x3be
	.byte	0x30
	.uleb128 0x8
	.ascii "Next\0"
	.byte	0x4
	.byte	0x7e
	.long	0x3c3
	.byte	0x38
	.byte	0
	.uleb128 0x6
	.long	0x2fc
	.uleb128 0xb
	.byte	0x8
	.long	0x3c9
	.uleb128 0x6
	.long	0x310
	.uleb128 0x7
	.byte	0x10
	.byte	0x4
	.byte	0x82
	.long	0x3f5
	.uleb128 0x9
	.secrel32	.LASF2
	.byte	0x4
	.byte	0x83
	.long	0x3c3
	.byte	0
	.uleb128 0x8
	.ascii "QueueData\0"
	.byte	0x4
	.byte	0x84
	.long	0x25c
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x4
	.byte	0x85
	.long	0x3ce
	.uleb128 0x7
	.byte	0x4
	.byte	0x4
	.byte	0x87
	.long	0x45d
	.uleb128 0x8
	.ascii "Init\0"
	.byte	0x4
	.byte	0x88
	.long	0x122
	.byte	0
	.uleb128 0x8
	.ascii "FCallIdle\0"
	.byte	0x4
	.byte	0x88
	.long	0x122
	.byte	0x1
	.uleb128 0x8
	.ascii "ReleaseSched\0"
	.byte	0x4
	.byte	0x88
	.long	0x122
	.byte	0x2
	.uleb128 0x8
	.ascii "FCallReleased\0"
	.byte	0x4
	.byte	0x88
	.long	0x122
	.byte	0x3
	.byte	0
	.uleb128 0x3
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x4
	.byte	0x89
	.long	0x40a
	.uleb128 0x7
	.byte	0x68
	.byte	0x4
	.byte	0x8b
	.long	0x56a
	.uleb128 0x8
	.ascii "IDLECallback\0"
	.byte	0x4
	.byte	0x8c
	.long	0x26e
	.byte	0
	.uleb128 0x8
	.ascii "ReleaseSchedCallback\0"
	.byte	0x4
	.byte	0x8d
	.long	0x26e
	.byte	0x8
	.uleb128 0x8
	.ascii "Tick\0"
	.byte	0x4
	.byte	0x8e
	.long	0x1a0
	.byte	0x10
	.uleb128 0x8
	.ascii "EventInfo\0"
	.byte	0x4
	.byte	0x8f
	.long	0x25e
	.byte	0x18
	.uleb128 0x8
	.ascii "First\0"
	.byte	0x4
	.byte	0x90
	.long	0x3c3
	.byte	0x38
	.uleb128 0x8
	.ascii "I_Disable\0"
	.byte	0x4
	.byte	0x91
	.long	0x56b
	.byte	0x40
	.uleb128 0x8
	.ascii "I_Enabler\0"
	.byte	0x4
	.byte	0x92
	.long	0x56b
	.byte	0x48
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x93
	.long	0x571
	.byte	0x50
	.uleb128 0x8
	.ascii "QueueStack\0"
	.byte	0x4
	.byte	0x94
	.long	0x576
	.byte	0x58
	.uleb128 0x8
	.ascii "QueueSize\0"
	.byte	0x4
	.byte	0x95
	.long	0x122
	.byte	0x60
	.uleb128 0x8
	.ascii "QueueIndex\0"
	.byte	0x4
	.byte	0x95
	.long	0x122
	.byte	0x61
	.uleb128 0x8
	.ascii "NotSafeQueue\0"
	.byte	0x4
	.byte	0x96
	.long	0x2f7
	.byte	0x62
	.uleb128 0x8
	.ascii "epochs\0"
	.byte	0x4
	.byte	0x98
	.long	0x1b8
	.byte	0x64
	.byte	0
	.uleb128 0xf
	.uleb128 0xb
	.byte	0x8
	.long	0x56a
	.uleb128 0x6
	.long	0x45d
	.uleb128 0xb
	.byte	0x8
	.long	0x57c
	.uleb128 0x6
	.long	0x3f5
	.uleb128 0x3
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x4
	.byte	0x9a
	.long	0x475
	.uleb128 0x10
	.ascii "state\0"
	.byte	0x4
	.long	0xd8
	.byte	0x4
	.word	0x1e5
	.long	0x5d8
	.uleb128 0x11
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0x11
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x12
	.ascii "qSM_Status_t\0"
	.byte	0x4
	.word	0x1e5
	.long	0x59a
	.uleb128 0x13
	.byte	0x18
	.byte	0x4
	.word	0x1fe
	.long	0x633
	.uleb128 0x14
	.ascii "__Failure\0"
	.byte	0x4
	.word	0x1ff
	.long	0x6d5
	.byte	0
	.uleb128 0x14
	.ascii "__Success\0"
	.byte	0x4
	.word	0x200
	.long	0x6d5
	.byte	0x8
	.uleb128 0x14
	.ascii "__Unexpected\0"
	.byte	0x4
	.word	0x201
	.long	0x6d5
	.byte	0x10
	.byte	0
	.uleb128 0xc
	.long	0x63e
	.uleb128 0xd
	.long	0x63e
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x6d0
	.uleb128 0x15
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x4
	.word	0x1e9
	.long	0x6d0
	.uleb128 0x14
	.ascii "NextState\0"
	.byte	0x4
	.word	0x1ed
	.long	0x6ea
	.byte	0
	.uleb128 0x14
	.ascii "PreviousState\0"
	.byte	0x4
	.word	0x1f1
	.long	0x6ea
	.byte	0x8
	.uleb128 0x14
	.ascii "PreviousReturnStatus\0"
	.byte	0x4
	.word	0x1f5
	.long	0x5d8
	.byte	0x10
	.uleb128 0x14
	.ascii "StateJustChanged\0"
	.byte	0x4
	.word	0x1f9
	.long	0x204
	.byte	0x14
	.uleb128 0x14
	.ascii "Data\0"
	.byte	0x4
	.word	0x1fd
	.long	0x25c
	.byte	0x18
	.uleb128 0x14
	.ascii "_\0"
	.byte	0x4
	.word	0x202
	.long	0x5ed
	.byte	0x20
	.byte	0
	.uleb128 0x6
	.long	0x644
	.uleb128 0xb
	.byte	0x8
	.long	0x633
	.uleb128 0x16
	.long	0x5d8
	.long	0x6ea
	.uleb128 0xd
	.long	0x63e
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x6db
	.uleb128 0x12
	.ascii "qSM_State_t\0"
	.byte	0x4
	.word	0x204
	.long	0x6ea
	.uleb128 0x12
	.ascii "qSM_ExState_t\0"
	.byte	0x4
	.word	0x205
	.long	0x6d5
	.uleb128 0x13
	.byte	0xc
	.byte	0x4
	.word	0x263
	.long	0x74b
	.uleb128 0x14
	.ascii "SR\0"
	.byte	0x4
	.word	0x264
	.long	0x122
	.byte	0
	.uleb128 0x14
	.ascii "Start\0"
	.byte	0x4
	.word	0x265
	.long	0x1b8
	.byte	0x4
	.uleb128 0x14
	.ascii "TV\0"
	.byte	0x4
	.word	0x265
	.long	0x1b8
	.byte	0x8
	.byte	0
	.uleb128 0x12
	.ascii "qSTimer_t\0"
	.byte	0x4
	.word	0x266
	.long	0x71a
	.uleb128 0x17
	.ascii "_qSendEvent\0"
	.byte	0x1
	.byte	0x1a
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x79f
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1a
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x1a
	.long	0x25c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qSetTime\0"
	.byte	0x1
	.byte	0x1f
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x7df
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1f
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x1f
	.long	0x1a0
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qSetIterations\0"
	.byte	0x1
	.byte	0x23
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x825
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x23
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x23
	.long	0x1e0
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qSetPriority\0"
	.byte	0x1
	.byte	0x27
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x869
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x27
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x27
	.long	0x1cd
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qSetCallback\0"
	.byte	0x1
	.byte	0x2c
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x8ad
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2c
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x2c
	.long	0x26e
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qEnableDisable\0"
	.byte	0x1
	.byte	0x30
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x8f3
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x30
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x30
	.long	0x204
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qSetUserData\0"
	.byte	0x1
	.byte	0x36
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x937
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x36
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "arg\0"
	.byte	0x1
	.byte	0x36
	.long	0x25c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qClearTimeElapse\0"
	.byte	0x1
	.byte	0x3a
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x971
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x3a
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.ascii "_qEnqueueTaskEvent\0"
	.byte	0x1
	.byte	0x3e
	.long	0xd8
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xa11
	.uleb128 0x19
	.ascii "TasktoQueue\0"
	.byte	0x1
	.byte	0x3e
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x3e
	.long	0x25c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1b
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x42
	.long	0x3f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1b
	.ascii "TaskFromQueue\0"
	.byte	0x1
	.byte	0x45
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1b
	.ascii "PriorityValue\0"
	.byte	0x1
	.byte	0x46
	.long	0x1cd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1b
	.ascii "i\0"
	.byte	0x1
	.byte	0x53
	.long	0x122
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x1c
	.ascii "_qDequeueTaskEvent\0"
	.byte	0x1
	.byte	0x61
	.long	0x3c3
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xa60
	.uleb128 0x1d
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x62
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1b
	.ascii "index\0"
	.byte	0x1
	.byte	0x63
	.long	0x122
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x17
	.ascii "_qSetInterruptsED\0"
	.byte	0x1
	.byte	0x70
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xab1
	.uleb128 0x19
	.ascii "Enabler\0"
	.byte	0x1
	.byte	0x70
	.long	0x56b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Disabler\0"
	.byte	0x1
	.byte	0x70
	.long	0x56b
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0x75
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xb39
	.uleb128 0x19
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0x75
	.long	0x1a0
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0x75
	.long	0x26e
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x75
	.long	0x576
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x19
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x75
	.long	0x122
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1b
	.ascii "i\0"
	.byte	0x1
	.byte	0x76
	.long	0x122
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x17
	.ascii "_qISRHandler\0"
	.byte	0x1
	.byte	0x89
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xb6e
	.uleb128 0x1d
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x8b
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1e
	.ascii "_qCreateTask\0"
	.byte	0x1
	.byte	0x9b
	.long	0xd8
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xc0d
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x9b
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x9b
	.long	0x26e
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x18
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x9b
	.long	0x1cd
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x19
	.ascii "Time\0"
	.byte	0x1
	.byte	0x9b
	.long	0x1a0
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x19
	.ascii "nExecutions\0"
	.byte	0x1
	.byte	0x9b
	.long	0x1e0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.ascii "InitialState\0"
	.byte	0x1
	.byte	0x9b
	.long	0x1f4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.ascii "arg\0"
	.byte	0x1
	.byte	0x9b
	.long	0x25c
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x1f
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.byte	0xab
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xc54
	.uleb128 0x18
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xab
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Event\0"
	.byte	0x1
	.byte	0xab
	.long	0x18e
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x20
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.byte	0xb5
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xcd1
	.uleb128 0x1b
	.ascii "a\0"
	.byte	0x1
	.byte	0xb6
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1b
	.ascii "b\0"
	.byte	0x1
	.byte	0xb6
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1b
	.ascii "c\0"
	.byte	0x1
	.byte	0xb6
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1b
	.ascii "e\0"
	.byte	0x1
	.byte	0xb6
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1b
	.ascii "tmp\0"
	.byte	0x1
	.byte	0xb6
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1b
	.ascii "head\0"
	.byte	0x1
	.byte	0xb7
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x21
	.ascii "_qStart\0"
	.byte	0x1
	.byte	0xce
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xd47
	.uleb128 0x1d
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xcf
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1b
	.ascii "qTask\0"
	.byte	0x1
	.byte	0xcf
	.long	0x3c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x22
	.ascii "qMainSchedule\0"
	.byte	0x1
	.byte	0xd0
	.quad	.L65
	.uleb128 0x22
	.ascii "qReleasedSchedule\0"
	.byte	0x1
	.byte	0xee
	.quad	.L67
	.byte	0
	.uleb128 0x1e
	.ascii "_qStateMachine_Init\0"
	.byte	0x1
	.byte	0xf7
	.long	0xd8
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xde3
	.uleb128 0x19
	.ascii "obj\0"
	.byte	0x1
	.byte	0xf7
	.long	0x63e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "InitState\0"
	.byte	0x1
	.byte	0xf7
	.long	0x6f0
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.ascii "SuccessState\0"
	.byte	0x1
	.byte	0xf7
	.long	0x704
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x19
	.ascii "FailureState\0"
	.byte	0x1
	.byte	0xf7
	.long	0x704
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x19
	.ascii "UnexpectedState\0"
	.byte	0x1
	.byte	0xf7
	.long	0x704
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0x23
	.ascii "_qStateMachine_Run\0"
	.byte	0x1
	.word	0x101
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0xe40
	.uleb128 0x24
	.ascii "obj\0"
	.byte	0x1
	.word	0x101
	.long	0x63e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x24
	.ascii "Data\0"
	.byte	0x1
	.word	0x101
	.long	0x25c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x25
	.ascii "prev\0"
	.byte	0x1
	.word	0x102
	.long	0x6f0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x26
	.ascii "_qSTimerSet\0"
	.byte	0x1
	.word	0x11a
	.long	0xd8
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0xe98
	.uleb128 0x24
	.ascii "obj\0"
	.byte	0x1
	.word	0x11a
	.long	0xe98
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x24
	.ascii "Time\0"
	.byte	0x1
	.word	0x11a
	.long	0x1a0
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x24
	.ascii "fr\0"
	.byte	0x1
	.word	0x11a
	.long	0x204
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x74b
	.uleb128 0x27
	.ascii "_qSTimerExpired\0"
	.byte	0x1
	.word	0x129
	.long	0x204
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0xedc
	.uleb128 0x24
	.ascii "obj\0"
	.byte	0x1
	.word	0x129
	.long	0xe98
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x27
	.ascii "_qSTimerElapsed\0"
	.byte	0x1
	.word	0x12e
	.long	0x1b8
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0xf1a
	.uleb128 0x24
	.ascii "obj\0"
	.byte	0x1
	.word	0x12e
	.long	0xe98
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x26
	.ascii "_qSTimerRemaining\0"
	.byte	0x1
	.word	0x132
	.long	0x1b8
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0xf6d
	.uleb128 0x24
	.ascii "obj\0"
	.byte	0x1
	.word	0x132
	.long	0xe98
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x25
	.ascii "elapsed\0"
	.byte	0x1
	.word	0x133
	.long	0x1b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x28
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x15
	.long	0xf86
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0x6
	.long	0x581
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
	.uleb128 0x5
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
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
	.uleb128 0xa
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0xf
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
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
	.uleb128 0x11
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.uleb128 0x13
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
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x1d
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
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x22
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
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
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
	.uleb128 0x24
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
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
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
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
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
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
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
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
.LASF3:
	.ascii "eventdata\0"
.LASF2:
	.ascii "Task\0"
.LASF4:
	.ascii "Value\0"
.LASF5:
	.ascii "CallbackFcn\0"
.LASF1:
	.ascii "Priority\0"
.LASF0:
	.ascii "UserData\0"
	.ident	"GCC: (GNU) 5.4.0"
