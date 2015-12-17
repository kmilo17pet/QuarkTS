	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 88, 6
	.globl	_qEnqueueTaskEvent
	.def	_qEnqueueTaskEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	_qEnqueueTaskEvent
_qEnqueueTaskEvent:
.LFB0:
	.file 1 "QuarkTS.c"
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
	movq	%rdx, 24(%rbp)
	.loc 1 29 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jle	.L2
	.loc 1 29 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L11
.L2:
	.loc 1 30 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	34(%rax), %eax
	movb	%al, -2(%rbp)
	.loc 1 33 0
	movq	16(%rbp), %rax
	movq	%rax, -32(%rbp)
	.loc 1 34 0
	movq	24(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 35 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L4
	.loc 1 36 0
	movq	-16(%rbp), %rax
	movzbl	34(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L6
	.loc 1 37 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 38 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	jmp	.L6
.L4:
	.loc 1 41 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L6:
	.loc 1 43 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 81(%rax)
	.loc 1 44 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	cmpb	$1, %al
	jne	.L7
	.loc 1 44 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L11
.L7:
	.loc 1 46 0 is_stmt 1
	movb	$0, -1(%rbp)
	jmp	.L8
.L10:
	.loc 1 47 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L9
	.loc 1 48 0
	movq	-16(%rbp), %rax
	movzbl	34(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L9
	.loc 1 49 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 50 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	leaq	(%rdx,%rax), %rcx
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 51 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L9:
	.loc 1 46 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L8:
	.loc 1 46 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L10
	.loc 1 55 0 is_stmt 1
	movl	$0, %eax
.L11:
	.loc 1 56 0 discriminator 1
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.seh_endproc
	.def	_qDequeueTaskEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qDequeueTaskEvent
_qDequeueTaskEvent:
.LFB1:
	.loc 1 58 0
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
	.loc 1 61 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L13
.L17:
	.loc 1 62 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L14
	.loc 1 63 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 64 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 65 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 66 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	je	.L15
	.loc 1 66 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	leal	-1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 81(%rax)
.L15:
	.loc 1 67 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L16
.L14:
	.loc 1 61 0 discriminator 2
	subl	$1, -4(%rbp)
.L13:
	.loc 1 61 0 is_stmt 0 discriminator 1
	cmpl	$0, -4(%rbp)
	jns	.L17
	.loc 1 70 0 is_stmt 1
	movl	$0, %eax
.L16:
	.loc 1 71 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.seh_endproc
	.globl	_qInitScheduler
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qInitScheduler
_qInitScheduler:
.LFB2:
	.loc 1 73 0
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
	.loc 1 75 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 48(%rax)
	.loc 1 76 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 56(%rax)
	.loc 1 77 0
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 8(%rdx)
	.loc 1 78 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 80 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 81 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 80(%rax)
	.loc 1 82 0
	movb	$0, -1(%rbp)
	jmp	.L19
.L20:
	.loc 1 82 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L19:
	.loc 1 82 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L20
	.loc 1 83 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 81(%rax)
	.loc 1 84 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.seh_endproc
	.globl	_qISRHandler
	.def	_qISRHandler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qISRHandler
_qISRHandler:
.LFB3:
	.loc 1 86 0
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
	.loc 1 87 0
	leaq	QUARKTS(%rip), %rax
	movzbl	64(%rax), %eax
	testb	%al, %al
	jne	.L22
	jmp	.L21
.L22:
	.loc 1 88 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 89 0
	jmp	.L24
.L26:
	.loc 1 90 0
	movq	-8(%rbp), %rax
	movl	52(%rax), %eax
	testl	%eax, %eax
	je	.L25
	.loc 1 90 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L25
	.loc 1 91 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 24(%rax)
	.loc 1 92 0
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%rax, %rdx
	jb	.L25
	.loc 1 93 0
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 94 0
	movq	-8(%rbp), %rax
	movq	$0, 24(%rax)
.L25:
	.loc 1 97 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L24:
	.loc 1 89 0
	cmpq	$0, -8(%rbp)
	jne	.L26
.L21:
	.loc 1 99 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.seh_endproc
	.globl	_qCreateTask
	.def	_qCreateTask;	.scl	2;	.type	32;	.endef
	.seh_proc	_qCreateTask
_qCreateTask:
.LFB4:
	.loc 1 101 0
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
	movl	%r8d, %edx
	movss	%xmm3, 40(%rbp)
	movl	48(%rbp), %eax
	movb	%dl, 32(%rbp)
	movw	%ax, -4(%rbp)
	.loc 1 102 0
	movss	40(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L28
	.loc 1 102 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L37
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	je	.L28
.L37:
	.loc 1 102 0 discriminator 2
	movl	$-1, %eax
	jmp	.L31
.L28:
	.loc 1 103 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 104 0
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
	.loc 1 105 0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC2(%rip), %xmm0
	jnb	.L32
	cvttss2siq	%xmm0, %rax
	jmp	.L33
.L32:
	movss	.LC2(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L33:
	movq	16(%rbp), %rdx
	movq	%rax, 16(%rdx)
	.loc 1 106 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 107 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 34(%rax)
	.loc 1 108 0
	movq	16(%rbp), %rax
	movzwl	-4(%rbp), %edx
	movw	%dx, 32(%rax)
	.loc 1 109 0
	movq	16(%rbp), %rax
	movb	$0, 48(%rax)
	movl	$0, %edx
	movq	16(%rbp), %rax
	movzbl	%dl, %ecx
	andl	$1, %ecx
	sall	$8, %ecx
	movl	%ecx, %r8d
	movzwl	48(%rax), %ecx
	andb	$254, %ch
	orl	%r8d, %ecx
	movw	%cx, 48(%rax)
	movq	16(%rbp), %rax
	movzbl	%dl, %edx
	andl	$1, %edx
	movl	%edx, %ecx
	sall	$9, %ecx
	movzwl	48(%rax), %edx
	andb	$253, %dh
	orl	%ecx, %edx
	movw	%dx, 48(%rax)
	.loc 1 110 0
	cmpl	$0, 56(%rbp)
	setne	%al
	movzbl	%al, %edx
	movq	16(%rbp), %rax
	movl	%edx, 52(%rax)
	.loc 1 111 0
	movq	16(%rbp), %rax
	movq	$0, 56(%rax)
	.loc 1 112 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	jne	.L34
	.loc 1 113 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 114 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L35
.L34:
	.loc 1 117 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 118 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L35:
	.loc 1 120 0
	movl	$0, %eax
.L31:
	.loc 1 121 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.seh_endproc
	.def	_qTriggerEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerEvent
_qTriggerEvent:
.LFB5:
	.loc 1 123 0
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
	.loc 1 124 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 16(%rax)
	.loc 1 125 0
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	shrq	$8, %rax
	andl	$1, %eax
	xorl	$1, %eax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 126 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 24(%rax)
	.loc 1 127 0
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
	.loc 1 128 0
	movq	16(%rbp), %rax
	movzwl	48(%rax), %edx
	orb	$1, %dh
	movw	%dx, 48(%rax)
	.loc 1 129 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 32(%rax)
	.loc 1 130 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.seh_endproc
	.def	_qTaskChainSortbyPriority;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTaskChainSortbyPriority
_qTaskChainSortbyPriority:
.LFB6:
	.loc 1 132 0
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
	.loc 1 133 0
	movq	$0, -8(%rbp)
	.loc 1 134 0
	movq	$0, -16(%rbp)
	.loc 1 135 0
	movq	$0, -24(%rbp)
	.loc 1 136 0
	movq	$0, -32(%rbp)
	.loc 1 137 0
	movq	$0, -48(%rbp)
	.loc 1 138 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 139 0
	jmp	.L40
.L47:
	.loc 1 140 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 141 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 142 0
	jmp	.L41
.L46:
	.loc 1 143 0
	movq	-8(%rbp), %rax
	movzbl	34(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	34(%rax), %eax
	cmpb	%al, %dl
	jnb	.L42
	.loc 1 144 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 145 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 146 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L43
	.loc 1 146 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 48(%rax)
	jmp	.L44
.L43:
	.loc 1 147 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L44:
	.loc 1 148 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 149 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L45
.L42:
	.loc 1 152 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 153 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L45:
	.loc 1 155 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 156 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L41
	.loc 1 157 0
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L41:
	.loc 1 142 0
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L46
.L40:
	.loc 1 139 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L47
	.loc 1 160 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.seh_endproc
	.globl	_qStart
	.def	_qStart;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStart
_qStart:
.LFB7:
	.loc 1 162 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	.seh_stackalloc	96
	.seh_endprologue
	.loc 1 164 0
	movb	$0, -9(%rbp)
.L49:
	.loc 1 166 0
	leaq	QUARKTS(%rip), %rax
	movzbl	64(%rax), %eax
	testb	%al, %al
	jne	.L50
	.loc 1 167 0
	call	_qTaskChainSortbyPriority
	.loc 1 168 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 64(%rax)
.L50:
	.loc 1 170 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 171 0
	jmp	.L51
.L59:
	.loc 1 172 0
	call	_qDequeueTaskEvent
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L52
	.loc 1 172 0 is_stmt 0 discriminator 1
	movq	-24(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L52:
	.loc 1 173 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	je	.L53
	.loc 1 173 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzwl	32(%rax), %eax
	testw	%ax, %ax
	jne	.L54
	.loc 1 173 0 discriminator 3
	movq	-8(%rbp), %rax
	movzwl	32(%rax), %eax
	cmpw	$-1, %ax
	jne	.L53
.L54:
	.loc 1 173 0 discriminator 4
	movq	-8(%rbp), %rax
	movl	52(%rax), %eax
	testl	%eax, %eax
	je	.L53
	.loc 1 174 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 175 0
	movq	-8(%rbp), %rax
	movzwl	32(%rax), %eax
	cmpw	$-1, %ax
	je	.L55
	.loc 1 175 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzwl	32(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movw	%dx, 32(%rax)
.L55:
	.loc 1 176 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzwl	32(%rax), %eax
	testw	%ax, %ax
	jne	.L56
	.loc 1 176 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movl	$0, 52(%rax)
.L56:
	.loc 1 177 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L57
.L53:
	.loc 1 179 0
	movq	-8(%rbp), %rax
	movq	48(%rax), %rax
	shrq	$9, %rax
	andl	$1, %eax
	testb	%al, %al
	je	.L58
	.loc 1 180 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 181 0
	movq	-8(%rbp), %rax
	movzwl	48(%rax), %edx
	andb	$253, %dh
	movw	%dx, 48(%rax)
	.loc 1 182 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L57
.L58:
	.loc 1 184 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L57
	.loc 1 185 0
	cmpb	$0, -9(%rbp)
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 186 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 16(%rax)
	.loc 1 187 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	16(%rax), %rcx
	movq	%rcx, -64(%rbp)
	movq	24(%rax), %rcx
	movq	%rcx, -56(%rbp)
	movq	32(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movq	40(%rax), %rax
	movq	%rax, -40(%rbp)
	leaq	-64(%rbp), %rax
	movq	%rax, %rcx
	call	*%rdx
	.loc 1 188 0
	movb	$1, -9(%rbp)
.L57:
	.loc 1 190 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L51:
	.loc 1 171 0
	cmpq	$0, -8(%rbp)
	jne	.L59
	.loc 1 192 0
	jmp	.L49
	.cfi_endproc
.LFE7:
	.seh_endproc
	.globl	_qSendEvent
	.def	_qSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSendEvent
_qSendEvent:
.LFB8:
	.loc 1 195 0
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
	.loc 1 196 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 197 0
	movq	16(%rbp), %rax
	movzwl	48(%rax), %edx
	orb	$2, %dh
	movw	%dx, 48(%rax)
	.loc 1 198 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1073741824
	.align 4
.LC2:
	.long	1593835520
	.text
.Letext0:
	.file 2 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x86f
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
	.byte	0x21
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
	.byte	0x21
	.long	0x82
	.uleb128 0x2
	.byte	0x4
	.byte	0x2
	.byte	0x22
	.long	0x102
	.uleb128 0x3
	.ascii "QueueSuccess\0"
	.sleb128 0
	.uleb128 0x3
	.ascii "QueueError\0"
	.sleb128 -1
	.byte	0
	.uleb128 0x4
	.ascii "qReturnValue_t\0"
	.byte	0x2
	.byte	0x22
	.long	0xdd
	.uleb128 0x4
	.ascii "qTime_t\0"
	.byte	0x2
	.byte	0x23
	.long	0x127
	.uleb128 0x5
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x4
	.ascii "qClock_t\0"
	.byte	0x2
	.byte	0x24
	.long	0x140
	.uleb128 0x6
	.long	0x145
	.uleb128 0x5
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x4
	.ascii "qPriority_t\0"
	.byte	0x2
	.byte	0x25
	.long	0x16d
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x4
	.ascii "qIteration_t\0"
	.byte	0x2
	.byte	0x26
	.long	0x192
	.uleb128 0x5
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x2
	.byte	0x4
	.byte	0x2
	.byte	0x27
	.long	0x1c4
	.uleb128 0x3
	.ascii "DISABLE\0"
	.sleb128 0
	.uleb128 0x3
	.ascii "ENABLE\0"
	.sleb128 1
	.byte	0
	.uleb128 0x4
	.ascii "qState_t\0"
	.byte	0x2
	.byte	0x27
	.long	0x1a8
	.uleb128 0x7
	.byte	0x20
	.byte	0x2
	.byte	0x30
	.long	0x21d
	.uleb128 0x8
	.ascii "Trigger\0"
	.byte	0x2
	.byte	0x31
	.long	0xcb
	.byte	0
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x32
	.long	0x21d
	.byte	0x8
	.uleb128 0x8
	.ascii "EventData\0"
	.byte	0x2
	.byte	0x33
	.long	0x21d
	.byte	0x10
	.uleb128 0x8
	.ascii "FirstCall\0"
	.byte	0x2
	.byte	0x34
	.long	0x16d
	.byte	0x18
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.uleb128 0x4
	.ascii "qEvent_t\0"
	.byte	0x2
	.byte	0x35
	.long	0x1d4
	.uleb128 0x4
	.ascii "qTaskFcn_t\0"
	.byte	0x2
	.byte	0x37
	.long	0x241
	.uleb128 0xb
	.byte	0x8
	.long	0x247
	.uleb128 0xc
	.long	0x252
	.uleb128 0xd
	.long	0x21f
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.byte	0x2
	.byte	0x39
	.long	0x29b
	.uleb128 0xe
	.ascii "TimedTaskRun\0"
	.byte	0x2
	.byte	0x3a
	.long	0x29b
	.byte	0x4
	.byte	0x8
	.byte	0x18
	.byte	0
	.uleb128 0xe
	.ascii "InitFlag\0"
	.byte	0x2
	.byte	0x3b
	.long	0x29b
	.byte	0x4
	.byte	0x1
	.byte	0x17
	.byte	0
	.uleb128 0xe
	.ascii "AsyncRun\0"
	.byte	0x2
	.byte	0x3c
	.long	0x29b
	.byte	0x4
	.byte	0x1
	.byte	0x16
	.byte	0
	.byte	0
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x4
	.ascii "qTaskFlags_t\0"
	.byte	0x2
	.byte	0x3d
	.long	0x252
	.uleb128 0xf
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x2
	.byte	0x3f
	.long	0x36c
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x40
	.long	0x21d
	.byte	0
	.uleb128 0x8
	.ascii "AsyncData\0"
	.byte	0x2
	.byte	0x40
	.long	0x21d
	.byte	0x8
	.uleb128 0x8
	.ascii "Interval\0"
	.byte	0x2
	.byte	0x41
	.long	0x130
	.byte	0x10
	.uleb128 0x8
	.ascii "TimeElapsed\0"
	.byte	0x2
	.byte	0x41
	.long	0x130
	.byte	0x18
	.uleb128 0x8
	.ascii "Iterations\0"
	.byte	0x2
	.byte	0x42
	.long	0x17e
	.byte	0x20
	.uleb128 0x9
	.secrel32	.LASF1
	.byte	0x2
	.byte	0x43
	.long	0x15a
	.byte	0x22
	.uleb128 0x8
	.ascii "Callback\0"
	.byte	0x2
	.byte	0x44
	.long	0x22f
	.byte	0x28
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x45
	.long	0x36c
	.byte	0x30
	.uleb128 0x8
	.ascii "State\0"
	.byte	0x2
	.byte	0x46
	.long	0x371
	.byte	0x34
	.uleb128 0x8
	.ascii "Next\0"
	.byte	0x2
	.byte	0x47
	.long	0x376
	.byte	0x38
	.byte	0
	.uleb128 0x6
	.long	0x2ab
	.uleb128 0x6
	.long	0x1c4
	.uleb128 0xb
	.byte	0x8
	.long	0x37c
	.uleb128 0x6
	.long	0x2bf
	.uleb128 0x7
	.byte	0x10
	.byte	0x2
	.byte	0x4b
	.long	0x3a8
	.uleb128 0x9
	.secrel32	.LASF2
	.byte	0x2
	.byte	0x4c
	.long	0x376
	.byte	0
	.uleb128 0x8
	.ascii "QueueData\0"
	.byte	0x2
	.byte	0x4d
	.long	0x21d
	.byte	0x8
	.byte	0
	.uleb128 0x4
	.ascii "qQueueStack_t\0"
	.byte	0x2
	.byte	0x4e
	.long	0x381
	.uleb128 0x7
	.byte	0x58
	.byte	0x2
	.byte	0x50
	.long	0x45a
	.uleb128 0x8
	.ascii "IDLECallback\0"
	.byte	0x2
	.byte	0x51
	.long	0x22f
	.byte	0
	.uleb128 0x8
	.ascii "Tick\0"
	.byte	0x2
	.byte	0x52
	.long	0x118
	.byte	0x8
	.uleb128 0x8
	.ascii "EventInfo\0"
	.byte	0x2
	.byte	0x53
	.long	0x21f
	.byte	0x10
	.uleb128 0x8
	.ascii "First\0"
	.byte	0x2
	.byte	0x54
	.long	0x376
	.byte	0x30
	.uleb128 0x8
	.ascii "Last\0"
	.byte	0x2
	.byte	0x54
	.long	0x376
	.byte	0x38
	.uleb128 0x8
	.ascii "Init\0"
	.byte	0x2
	.byte	0x55
	.long	0x16d
	.byte	0x40
	.uleb128 0x8
	.ascii "QueueStack\0"
	.byte	0x2
	.byte	0x56
	.long	0x45a
	.byte	0x48
	.uleb128 0x8
	.ascii "QueueSize\0"
	.byte	0x2
	.byte	0x57
	.long	0x16d
	.byte	0x50
	.uleb128 0x8
	.ascii "QueueIndex\0"
	.byte	0x2
	.byte	0x58
	.long	0x16d
	.byte	0x51
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x460
	.uleb128 0x6
	.long	0x3a8
	.uleb128 0x4
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x2
	.byte	0x59
	.long	0x47e
	.uleb128 0x6
	.long	0x3bd
	.uleb128 0x10
	.ascii "_qEnqueueTaskEvent\0"
	.byte	0x1
	.byte	0x1c
	.long	0x102
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x529
	.uleb128 0x11
	.ascii "TasktoQueue\0"
	.byte	0x1
	.byte	0x1c
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "eventdata\0"
	.byte	0x1
	.byte	0x1c
	.long	0x21d
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x12
	.ascii "PriorityValue\0"
	.byte	0x1
	.byte	0x1e
	.long	0x15a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x12
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x1f
	.long	0x3a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x12
	.ascii "TaskFromQueue\0"
	.byte	0x1
	.byte	0x20
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x2d
	.long	0x16d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x13
	.ascii "_qDequeueTaskEvent\0"
	.byte	0x1
	.byte	0x3a
	.long	0x376
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x574
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x3b
	.long	0x574
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x3c
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x15
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0x49
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x603
	.uleb128 0x11
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0x49
	.long	0x118
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0x49
	.long	0x22f
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x11
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x49
	.long	0x45a
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x49
	.long	0x16d
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x4a
	.long	0x16d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x15
	.ascii "_qISRHandler\0"
	.byte	0x1
	.byte	0x56
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x638
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x58
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x10
	.ascii "_qCreateTask\0"
	.byte	0x1
	.byte	0x65
	.long	0x574
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x6df
	.uleb128 0x16
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x65
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "CallbackFcn\0"
	.byte	0x1
	.byte	0x65
	.long	0x22f
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x16
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x65
	.long	0x15a
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "Time\0"
	.byte	0x1
	.byte	0x65
	.long	0x118
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x11
	.ascii "nExecutions\0"
	.byte	0x1
	.byte	0x65
	.long	0x17e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x11
	.ascii "InitialState\0"
	.byte	0x1
	.byte	0x65
	.long	0x1c4
	.uleb128 0x2
	.byte	0x91
	.sleb128 40
	.uleb128 0x11
	.ascii "arg\0"
	.byte	0x1
	.byte	0x65
	.long	0x21d
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x17
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.byte	0x7b
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x726
	.uleb128 0x16
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x7b
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "Event\0"
	.byte	0x1
	.byte	0x7b
	.long	0xcb
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "_qTaskChainSortbyPriority\0"
	.byte	0x1
	.byte	0x84
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x7a7
	.uleb128 0x12
	.ascii "a\0"
	.byte	0x1
	.byte	0x85
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x12
	.ascii "b\0"
	.byte	0x1
	.byte	0x86
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x12
	.ascii "c\0"
	.byte	0x1
	.byte	0x87
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x12
	.ascii "e\0"
	.byte	0x1
	.byte	0x88
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x12
	.ascii "tmp\0"
	.byte	0x1
	.byte	0x89
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x12
	.ascii "head\0"
	.byte	0x1
	.byte	0x8a
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x19
	.ascii "_qStart\0"
	.byte	0x1
	.byte	0xa2
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x817
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xa3
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x12
	.ascii "qTask\0"
	.byte	0x1
	.byte	0xa3
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x12
	.ascii "fcal_idlefcn\0"
	.byte	0x1
	.byte	0xa4
	.long	0x16d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -25
	.uleb128 0x1a
	.ascii "pMainSchedule\0"
	.byte	0x1
	.byte	0xa5
	.quad	.L49
	.byte	0
	.uleb128 0x15
	.ascii "_qSendEvent\0"
	.byte	0x1
	.byte	0xc3
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x859
	.uleb128 0x16
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xc3
	.long	0x376
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x16
	.secrel32	.LASF0
	.byte	0x1
	.byte	0xc3
	.long	0x21d
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1b
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x16
	.long	0x465
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
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
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
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
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
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
	.uleb128 0x14
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
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
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
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
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
	.ascii "Priority\0"
.LASF2:
	.ascii "Task\0"
.LASF0:
	.ascii "UserData\0"
	.ident	"GCC: (GNU) 4.9.3"
