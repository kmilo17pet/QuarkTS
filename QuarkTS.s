	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 80, 6
	.globl	_qSendEvent
	.def	_qSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSendEvent
_qSendEvent:
.LFB0:
	.file 1 "QuarkTS.c"
	.loc 1 29 0
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
	.loc 1 30 0
	movq	16(%rbp), %rax
	movb	$1, 50(%rax)
	.loc 1 31 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 32 0
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
	.loc 1 34 0
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
	.loc 1 35 0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC0(%rip), %xmm0
	jnb	.L3
	cvttss2siq	%xmm0, %rax
	jmp	.L4
.L3:
	movss	.LC0(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L4:
	movq	16(%rbp), %rdx
	movq	%rax, 16(%rdx)
	.loc 1 36 0
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
	.loc 1 38 0
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
	.loc 1 39 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 40 0
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
	.loc 1 42 0
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
	.loc 1 43 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 56(%rax)
	.loc 1 44 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 33(%rax)
	.loc 1 45 0
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
	.loc 1 47 0
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
	.loc 1 48 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 49 0
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
	.loc 1 51 0
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
	.loc 1 52 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 51(%rax)
	.loc 1 53 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.seh_endproc
	.globl	_qEnqueueTaskEvent
	.def	_qEnqueueTaskEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	_qEnqueueTaskEvent
_qEnqueueTaskEvent:
.LFB6:
	.loc 1 55 0
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
	movq	%rdx, 24(%rbp)
	.loc 1 56 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jle	.L10
	.loc 1 56 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L20
.L10:
	.loc 1 57 0 is_stmt 1
	nop
.L12:
	.loc 1 57 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	74(%rax), %eax
	testb	%al, %al
	jne	.L12
	.loc 1 58 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 74(%rax)
	.loc 1 59 0
	movq	16(%rbp), %rax
	movzbl	33(%rax), %eax
	movb	%al, -2(%rbp)
	.loc 1 62 0
	movq	16(%rbp), %rax
	movq	%rax, -32(%rbp)
	.loc 1 63 0
	movq	24(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 64 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L13
	.loc 1 65 0
	movq	-16(%rbp), %rax
	movzbl	33(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L15
	.loc 1 66 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 67 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	jmp	.L15
.L13:
	.loc 1 70 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L15:
	.loc 1 72 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 73(%rax)
	.loc 1 73 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	cmpb	$1, %al
	jne	.L16
	.loc 1 74 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 74(%rax)
	.loc 1 75 0
	movl	$0, %eax
	jmp	.L20
.L16:
	.loc 1 78 0
	movb	$0, -1(%rbp)
	jmp	.L17
.L19:
	.loc 1 79 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L18
	.loc 1 80 0
	movq	-16(%rbp), %rax
	movzbl	33(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L18
	.loc 1 81 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 82 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	leaq	(%rdx,%rax), %rcx
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 83 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L18:
	.loc 1 78 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L17:
	.loc 1 78 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L19
	.loc 1 87 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 74(%rax)
	.loc 1 88 0
	movl	$0, %eax
.L20:
	.loc 1 89 0 discriminator 1
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.seh_endproc
	.def	_qDequeueTaskEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qDequeueTaskEvent
_qDequeueTaskEvent:
.LFB7:
	.loc 1 91 0
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
	.loc 1 94 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L22
.L27:
	.loc 1 95 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L23
	.loc 1 96 0
	nop
.L24:
	.loc 1 96 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	74(%rax), %eax
	testb	%al, %al
	jne	.L24
	.loc 1 97 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 98 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 99 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 100 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	testb	%al, %al
	je	.L25
	.loc 1 100 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	leal	-1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 73(%rax)
.L25:
	.loc 1 101 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L26
.L23:
	.loc 1 94 0 discriminator 2
	subl	$1, -4(%rbp)
.L22:
	.loc 1 94 0 is_stmt 0 discriminator 1
	cmpl	$0, -4(%rbp)
	jns	.L27
	.loc 1 104 0 is_stmt 1
	movl	$0, %eax
.L26:
	.loc 1 105 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.seh_endproc
	.globl	_qInitScheduler
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qInitScheduler
_qInitScheduler:
.LFB8:
	.loc 1 107 0
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
	.loc 1 109 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 48(%rax)
	.loc 1 110 0
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 8(%rdx)
	.loc 1 111 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 112 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 113 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 72(%rax)
	.loc 1 114 0
	movb	$0, -1(%rbp)
	jmp	.L29
.L30:
	.loc 1 114 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L29:
	.loc 1 114 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L30
	.loc 1 115 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 73(%rax)
	.loc 1 116 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 56(%rax)
	.loc 1 117 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 74(%rax)
	.loc 1 118 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.globl	_qISRHandler
	.def	_qISRHandler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qISRHandler
_qISRHandler:
.LFB9:
	.loc 1 120 0
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
	.loc 1 121 0
	leaq	QUARKTS(%rip), %rax
	movzbl	56(%rax), %eax
	testb	%al, %al
	jne	.L32
	jmp	.L31
.L32:
	.loc 1 122 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 123 0
	jmp	.L34
.L36:
	.loc 1 124 0
	movq	-8(%rbp), %rax
	movzbl	51(%rax), %eax
	testb	%al, %al
	je	.L35
	.loc 1 124 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L35
	.loc 1 125 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 24(%rax)
	.loc 1 126 0
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%rax, %rdx
	jb	.L35
	.loc 1 127 0
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 128 0
	movq	-8(%rbp), %rax
	movq	$0, 24(%rax)
.L35:
	.loc 1 131 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L34:
	.loc 1 123 0
	cmpq	$0, -8(%rbp)
	jne	.L36
.L31:
	.loc 1 133 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.globl	_qCreateTask
	.def	_qCreateTask;	.scl	2;	.type	32;	.endef
	.seh_proc	_qCreateTask
_qCreateTask:
.LFB10:
	.loc 1 135 0
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
	.loc 1 136 0
	movss	40(%rbp), %xmm0
	movss	.LC1(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L38
	.loc 1 136 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L40
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L40
.L38:
	.loc 1 136 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L41
.L40:
	.loc 1 136 0 discriminator 5
	movl	$-1, %eax
	jmp	.L42
.L41:
	.loc 1 137 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 138 0
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
	.loc 1 139 0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC0(%rip), %xmm0
	jnb	.L43
	cvttss2siq	%xmm0, %rax
	jmp	.L44
.L43:
	movss	.LC0(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L44:
	movq	16(%rbp), %rdx
	movq	%rax, 16(%rdx)
	.loc 1 140 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 141 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 33(%rax)
	.loc 1 142 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 143 0
	movl	$0, %eax
	movq	16(%rbp), %rdx
	movb	%al, 48(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 49(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 50(%rdx)
	.loc 1 144 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 51(%rax)
	.loc 1 145 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 146 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 147 0
	movl	$0, %eax
.L42:
	.loc 1 148 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.def	_qTriggerEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerEvent
_qTriggerEvent:
.LFB11:
	.loc 1 150 0
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
	.loc 1 151 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 16(%rax)
	.loc 1 152 0
	movq	16(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 153 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 24(%rax)
	.loc 1 154 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L47
	.loc 1 154 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	16(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movq	24(%rax), %rcx
	movq	%rcx, -24(%rbp)
	movq	32(%rax), %rcx
	movq	%rcx, -16(%rbp)
	movq	40(%rax), %rax
	movq	%rax, -8(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, %rcx
	call	*%rdx
.L47:
	.loc 1 155 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 49(%rax)
	.loc 1 156 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 32(%rax)
	.loc 1 157 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.def	_qTaskChainbyPriority;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTaskChainbyPriority
_qTaskChainbyPriority:
.LFB12:
	.loc 1 159 0
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
	.loc 1 160 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 161 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 162 0
	jmp	.L49
.L56:
	.loc 1 163 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 164 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 165 0
	jmp	.L50
.L55:
	.loc 1 166 0
	movq	-8(%rbp), %rax
	movzbl	33(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	33(%rax), %eax
	cmpb	%al, %dl
	jnb	.L51
	.loc 1 167 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 168 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 169 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L52
	.loc 1 169 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 48(%rax)
	jmp	.L53
.L52:
	.loc 1 170 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L53:
	.loc 1 171 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 172 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L54
.L51:
	.loc 1 175 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 176 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L54:
	.loc 1 178 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 179 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L50
	.loc 1 179 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L50:
	.loc 1 165 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L55
.L49:
	.loc 1 162 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L56
	.loc 1 182 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.seh_endproc
	.globl	_qStart
	.def	_qStart;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStart
_qStart:
.LFB13:
	.loc 1 184 0
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
.L58:
	.loc 1 187 0
	leaq	QUARKTS(%rip), %rax
	movzbl	56(%rax), %eax
	testb	%al, %al
	jne	.L59
	.loc 1 188 0
	call	_qTaskChainbyPriority
	.loc 1 189 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 56(%rax)
.L59:
	.loc 1 191 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 192 0
	jmp	.L60
.L72:
	.loc 1 193 0
	call	_qDequeueTaskEvent
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L61
	.loc 1 193 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L61:
	.loc 1 194 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	jne	.L62
	.loc 1 194 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	js	.L63
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L64
.L63:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L64:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L65
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L65
.L62:
	.loc 1 194 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	jne	.L67
	.loc 1 194 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	$-1, %al
	jne	.L65
.L67:
	.loc 1 194 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	51(%rax), %eax
	testb	%al, %al
	je	.L65
	.loc 1 195 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 196 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	$-1, %al
	je	.L68
	.loc 1 196 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 32(%rax)
.L68:
	.loc 1 197 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	jne	.L69
	.loc 1 197 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 51(%rax)
.L69:
	.loc 1 198 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L70
.L65:
	.loc 1 200 0
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L71
	.loc 1 201 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 202 0
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
	.loc 1 203 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L70
.L71:
	.loc 1 205 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L70
	.loc 1 206 0
	leaq	QUARKTS(%rip), %rax
	movzbl	57(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 207 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 16(%rax)
	.loc 1 208 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	16(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movq	24(%rax), %rcx
	movq	%rcx, -40(%rbp)
	movq	32(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movq	40(%rax), %rax
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	call	*%rdx
	.loc 1 209 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 56(%rax)
.L70:
	.loc 1 211 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L60:
	.loc 1 192 0
	cmpq	$0, -8(%rbp)
	jne	.L72
	.loc 1 213 0
	jmp	.L58
	.cfi_endproc
.LFE13:
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1593835520
	.align 4
.LC1:
	.long	1073741824
	.text
.Letext0:
	.file 2 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x970
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C 4.9.3 -mtune=generic -march=x86-64 -g\0"
	.byte	0x1
	.ascii "QuarkTS.c\0"
	.ascii "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS\0"
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.secrel32	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x2
	.byte	0x1f
	.long	0xcb
	.uleb128 0x3
	.ascii "byTimeElapsed\0"
	.sleb128 0
	.uleb128 0x3
	.ascii "byPriority\0"
	.sleb128 1
	.uleb128 0x3
	.ascii "byQueueExtraction\0"
	.sleb128 2
	.uleb128 0x3
	.ascii "byAsyncEvent\0"
	.sleb128 3
	.byte	0
	.uleb128 0x4
	.ascii "qTrigger_t\0"
	.byte	0x2
	.byte	0x1f
	.long	0x82
	.uleb128 0x4
	.ascii "qTime_t\0"
	.byte	0x2
	.byte	0x20
	.long	0xec
	.uleb128 0x5
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x4
	.ascii "qClock_t\0"
	.byte	0x2
	.byte	0x21
	.long	0x105
	.uleb128 0x6
	.long	0x10a
	.uleb128 0x5
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x4
	.ascii "qPriority_t\0"
	.byte	0x2
	.byte	0x22
	.long	0x132
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x4
	.ascii "qIteration_t\0"
	.byte	0x2
	.byte	0x23
	.long	0x132
	.uleb128 0x4
	.ascii "qState_t\0"
	.byte	0x2
	.byte	0x24
	.long	0x132
	.uleb128 0x4
	.ascii "qBool_t\0"
	.byte	0x2
	.byte	0x25
	.long	0x132
	.uleb128 0x7
	.byte	0x20
	.byte	0x2
	.byte	0x31
	.long	0x1bf
	.uleb128 0x8
	.ascii "Trigger\0"
	.byte	0x2
	.byte	0x32
	.long	0xcb
	.byte	0
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x33
	.long	0x1bf
	.byte	0x8
	.uleb128 0x8
	.ascii "EventData\0"
	.byte	0x2
	.byte	0x34
	.long	0x1bf
	.byte	0x10
	.uleb128 0x8
	.ascii "FirstCall\0"
	.byte	0x2
	.byte	0x35
	.long	0x167
	.byte	0x18
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.uleb128 0x4
	.ascii "qEvent_t\0"
	.byte	0x2
	.byte	0x36
	.long	0x176
	.uleb128 0x4
	.ascii "qTaskFcn_t\0"
	.byte	0x2
	.byte	0x38
	.long	0x1e3
	.uleb128 0xb
	.byte	0x8
	.long	0x1e9
	.uleb128 0xc
	.long	0x1f4
	.uleb128 0xd
	.long	0x1c1
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.byte	0x2
	.byte	0x3a
	.long	0x242
	.uleb128 0x8
	.ascii "TimedTaskRun\0"
	.byte	0x2
	.byte	0x3b
	.long	0x242
	.byte	0
	.uleb128 0x8
	.ascii "InitFlag\0"
	.byte	0x2
	.byte	0x3c
	.long	0x242
	.byte	0x1
	.uleb128 0x8
	.ascii "AsyncRun\0"
	.byte	0x2
	.byte	0x3d
	.long	0x242
	.byte	0x2
	.uleb128 0x8
	.ascii "State\0"
	.byte	0x2
	.byte	0x3e
	.long	0x242
	.byte	0x3
	.byte	0
	.uleb128 0x6
	.long	0x132
	.uleb128 0x4
	.ascii "qTaskFlags_t\0"
	.byte	0x2
	.byte	0x3f
	.long	0x1f4
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x2
	.byte	0x41
	.long	0x2fa
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x42
	.long	0x1bf
	.byte	0
	.uleb128 0x8
	.ascii "AsyncData\0"
	.byte	0x2
	.byte	0x42
	.long	0x1bf
	.byte	0x8
	.uleb128 0x8
	.ascii "Interval\0"
	.byte	0x2
	.byte	0x43
	.long	0xf5
	.byte	0x10
	.uleb128 0x8
	.ascii "TimeElapsed\0"
	.byte	0x2
	.byte	0x43
	.long	0xf5
	.byte	0x18
	.uleb128 0x8
	.ascii "Iterations\0"
	.byte	0x2
	.byte	0x44
	.long	0x143
	.byte	0x20
	.uleb128 0x9
	.secrel32	.LASF1
	.byte	0x2
	.byte	0x45
	.long	0x11f
	.byte	0x21
	.uleb128 0x8
	.ascii "Callback\0"
	.byte	0x2
	.byte	0x46
	.long	0x1d1
	.byte	0x28
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x47
	.long	0x2fa
	.byte	0x30
	.uleb128 0x8
	.ascii "Next\0"
	.byte	0x2
	.byte	0x48
	.long	0x2ff
	.byte	0x38
	.byte	0
	.uleb128 0x6
	.long	0x247
	.uleb128 0xb
	.byte	0x8
	.long	0x305
	.uleb128 0x6
	.long	0x25b
	.uleb128 0x7
	.byte	0x10
	.byte	0x2
	.byte	0x4c
	.long	0x331
	.uleb128 0x9
	.secrel32	.LASF2
	.byte	0x2
	.byte	0x4d
	.long	0x2ff
	.byte	0
	.uleb128 0x8
	.ascii "QueueData\0"
	.byte	0x2
	.byte	0x4e
	.long	0x1bf
	.byte	0x8
	.byte	0
	.uleb128 0x4
	.ascii "qQueueStack_t\0"
	.byte	0x2
	.byte	0x4f
	.long	0x30a
	.uleb128 0x7
	.byte	0x2
	.byte	0x2
	.byte	0x51
	.long	0x36e
	.uleb128 0x8
	.ascii "Init\0"
	.byte	0x2
	.byte	0x52
	.long	0x132
	.byte	0
	.uleb128 0x8
	.ascii "FCallIdle\0"
	.byte	0x2
	.byte	0x53
	.long	0x132
	.byte	0x1
	.byte	0
	.uleb128 0x4
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x2
	.byte	0x54
	.long	0x346
	.uleb128 0x7
	.byte	0x50
	.byte	0x2
	.byte	0x57
	.long	0x42b
	.uleb128 0x8
	.ascii "IDLECallback\0"
	.byte	0x2
	.byte	0x58
	.long	0x1d1
	.byte	0
	.uleb128 0x8
	.ascii "Tick\0"
	.byte	0x2
	.byte	0x59
	.long	0xdd
	.byte	0x8
	.uleb128 0x8
	.ascii "EventInfo\0"
	.byte	0x2
	.byte	0x5a
	.long	0x1c1
	.byte	0x10
	.uleb128 0x8
	.ascii "First\0"
	.byte	0x2
	.byte	0x5b
	.long	0x2ff
	.byte	0x30
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x5c
	.long	0x42b
	.byte	0x38
	.uleb128 0x8
	.ascii "QueueStack\0"
	.byte	0x2
	.byte	0x5d
	.long	0x430
	.byte	0x40
	.uleb128 0x8
	.ascii "QueueSize\0"
	.byte	0x2
	.byte	0x5e
	.long	0x132
	.byte	0x48
	.uleb128 0x8
	.ascii "QueueIndex\0"
	.byte	0x2
	.byte	0x5e
	.long	0x132
	.byte	0x49
	.uleb128 0x8
	.ascii "NotSafeQueue\0"
	.byte	0x2
	.byte	0x5f
	.long	0x242
	.byte	0x4a
	.byte	0
	.uleb128 0x6
	.long	0x36e
	.uleb128 0xb
	.byte	0x8
	.long	0x436
	.uleb128 0x6
	.long	0x331
	.uleb128 0x4
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x2
	.byte	0x60
	.long	0x386
	.uleb128 0xf
	.ascii "_qSendEvent\0"
	.byte	0x1
	.byte	0x1d
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x496
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1d
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x1d
	.long	0x1bf
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "_qSetTime\0"
	.byte	0x1
	.byte	0x22
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x4d6
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x22
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x22
	.long	0xdd
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "_qSetIterations\0"
	.byte	0x1
	.byte	0x26
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x51c
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x26
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x26
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "_qSetPriority\0"
	.byte	0x1
	.byte	0x2a
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x560
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2a
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x2a
	.long	0x11f
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "_qSetCallback\0"
	.byte	0x1
	.byte	0x2f
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x5a4
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2f
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x2f
	.long	0x1d1
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "_qEnableDisable\0"
	.byte	0x1
	.byte	0x33
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x5ea
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x33
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x33
	.long	0x132
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qEnqueueTaskEvent\0"
	.byte	0x1
	.byte	0x37
	.long	0x68a
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x68a
	.uleb128 0x12
	.ascii "TasktoQueue\0"
	.byte	0x1
	.byte	0x37
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x37
	.long	0x1bf
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x13
	.ascii "PriorityValue\0"
	.byte	0x1
	.byte	0x3b
	.long	0x11f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x13
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x3c
	.long	0x331
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x13
	.ascii "TaskFromQueue\0"
	.byte	0x1
	.byte	0x3d
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x13
	.ascii "i\0"
	.byte	0x1
	.byte	0x4d
	.long	0x132
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x14
	.ascii "_qDequeueTaskEvent\0"
	.byte	0x1
	.byte	0x5b
	.long	0x2ff
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x6dc
	.uleb128 0x13
	.ascii "i\0"
	.byte	0x1
	.byte	0x5c
	.long	0x68a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x15
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x5d
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0xf
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0x6b
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x764
	.uleb128 0x12
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0x6b
	.long	0xdd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0x6b
	.long	0x1d1
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x12
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x6b
	.long	0x430
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x12
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x6b
	.long	0x132
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x13
	.ascii "i\0"
	.byte	0x1
	.byte	0x6c
	.long	0x132
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0xf
	.ascii "_qISRHandler\0"
	.byte	0x1
	.byte	0x78
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x799
	.uleb128 0x15
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x7a
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x11
	.ascii "_qCreateTask\0"
	.byte	0x1
	.byte	0x87
	.long	0x68a
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x838
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x87
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x87
	.long	0x1d1
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x10
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x87
	.long	0x11f
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x12
	.ascii "Time\0"
	.byte	0x1
	.byte	0x87
	.long	0xdd
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x12
	.ascii "nExecutions\0"
	.byte	0x1
	.byte	0x87
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x12
	.ascii "InitialState\0"
	.byte	0x1
	.byte	0x87
	.long	0x157
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x12
	.ascii "arg\0"
	.byte	0x1
	.byte	0x87
	.long	0x1bf
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x16
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.byte	0x96
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x87f
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x96
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.ascii "Event\0"
	.byte	0x1
	.byte	0x96
	.long	0xcb
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.byte	0x9f
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x8fc
	.uleb128 0x13
	.ascii "a\0"
	.byte	0x1
	.byte	0xa0
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x13
	.ascii "b\0"
	.byte	0x1
	.byte	0xa0
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x13
	.ascii "c\0"
	.byte	0x1
	.byte	0xa0
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x13
	.ascii "e\0"
	.byte	0x1
	.byte	0xa0
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x13
	.ascii "tmp\0"
	.byte	0x1
	.byte	0xa0
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x13
	.ascii "head\0"
	.byte	0x1
	.byte	0xa1
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x18
	.ascii "_qStart\0"
	.byte	0x1
	.byte	0xb8
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x955
	.uleb128 0x15
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xb9
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x13
	.ascii "qTask\0"
	.byte	0x1
	.byte	0xb9
	.long	0x2ff
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.ascii "pMainSchedule\0"
	.byte	0x1
	.byte	0xba
	.quad	.L58
	.byte	0
	.uleb128 0x1a
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x16
	.long	0x96e
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0x6
	.long	0x43b
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
	.uleb128 0x3
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0x4
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
	.uleb128 0x5
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
	.uleb128 0x10
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
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
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
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
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
	.ident	"GCC: (GNU) 4.9.3"
