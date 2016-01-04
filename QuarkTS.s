	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 80, 5
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
	movzbl	73(%rax), %eax
	movzbl	%al, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
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
	movzbl	33(%rax), %eax
	movb	%al, -2(%rbp)
	.loc 1 33 0
	movq	16(%rbp), %rax
	movq	%rax, -32(%rbp)
	.loc 1 34 0
	movq	24(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 35 0
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
	je	.L4
	.loc 1 36 0
	movq	-16(%rbp), %rax
	movzbl	33(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L6
	.loc 1 37 0
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
	.loc 1 38 0
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
	jmp	.L6
.L4:
	.loc 1 41 0
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
.L6:
	.loc 1 43 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 73(%rax)
	.loc 1 44 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
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
	movq	64(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L9
	.loc 1 48 0
	movq	-16(%rbp), %rax
	movzbl	33(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L9
	.loc 1 49 0
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
	.loc 1 50 0
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
	.loc 1 51 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L9:
	.loc 1 46 0
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L8:
	.loc 1 46 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L10
	.loc 1 55 0 is_stmt 1
	movl	$0, %eax
.L11:
	.loc 1 56 0
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
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L13
.L17:
	.loc 1 62 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L14
	.loc 1 63 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 64 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 65 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 66 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	testb	%al, %al
	je	.L15
	.loc 1 66 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	leal	-1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 73(%rax)
.L15:
	.loc 1 67 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L16
.L14:
	.loc 1 61 0
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
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 8(%rdx)
	.loc 1 77 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 78 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 79 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 72(%rax)
	.loc 1 80 0
	movb	$0, -1(%rbp)
	jmp	.L19
.L20:
	.loc 1 80 0 is_stmt 0 discriminator 2
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L19:
	.loc 1 80 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L20
	.loc 1 81 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 73(%rax)
	.loc 1 82 0
	leaq	QUARKTS(%rip), %rax
	movzbl	56(%rax), %edx
	andl	$-2, %edx
	movb	%dl, 56(%rax)
	.loc 1 83 0
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
	.loc 1 85 0
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
	.loc 1 86 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	andl	$1, %eax
	testq	%rax, %rax
	jne	.L22
	.loc 1 86 0 is_stmt 0 discriminator 1
	jmp	.L21
.L22:
	.loc 1 87 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 88 0
	jmp	.L24
.L26:
	.loc 1 89 0
	movq	-8(%rbp), %rax
	movq	48(%rax), %rax
	andl	$1024, %eax
	testq	%rax, %rax
	je	.L25
	.loc 1 89 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L25
	.loc 1 90 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 24(%rax)
	.loc 1 91 0
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%rax, %rdx
	jb	.L25
	.loc 1 92 0
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 93 0
	movq	-8(%rbp), %rax
	movq	$0, 24(%rax)
.L25:
	.loc 1 96 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L24:
	.loc 1 88 0 discriminator 1
	cmpq	$0, -8(%rbp)
	jne	.L26
.L21:
	.loc 1 98 0
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
	.loc 1 100 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	subq	$8, %rsp
	.seh_stackalloc	8
	.cfi_def_cfa_offset 24
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -104
	.seh_endprologue
	movq	%rcx, -104(%rbp)
	movq	%rdx, -96(%rbp)
	movl	%r8d, %ecx
	movss	%xmm3, -80(%rbp)
	movl	-72(%rbp), %edx
	movl	-64(%rbp), %eax
	movb	%cl, -88(%rbp)
	movb	%dl, -124(%rbp)
	movb	%al, -128(%rbp)
	.loc 1 101 0
	movss	-80(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L28
	.loc 1 101 0 is_stmt 0 discriminator 1
	xorps	%xmm0, %xmm0
	ucomiss	-80(%rbp), %xmm0
	jp	.L30
	xorps	%xmm0, %xmm0
	ucomiss	-80(%rbp), %xmm0
	jne	.L30
.L28:
	.loc 1 101 0 discriminator 2
	cmpq	$0, -96(%rbp)
	jne	.L31
.L30:
	.loc 1 101 0 discriminator 1
	movl	$-1, %eax
	jmp	.L32
.L31:
	.loc 1 102 0 is_stmt 1
	movq	-104(%rbp), %rax
	movq	-96(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 103 0
	movq	-104(%rbp), %rax
	movq	$0, 24(%rax)
	.loc 1 104 0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	movss	-80(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC2(%rip), %xmm0
	jae	.L33
	cvttss2siq	%xmm0, %rax
	jmp	.L34
.L33:
	movss	.LC2(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L34:
	movq	-104(%rbp), %rdx
	movq	%rax, 16(%rdx)
	.loc 1 105 0
	movq	-104(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 106 0
	movq	-104(%rbp), %rax
	movzbl	-88(%rbp), %edx
	movb	%dl, 33(%rax)
	.loc 1 107 0
	movq	-104(%rbp), %rax
	movzbl	-124(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 108 0
	movq	-104(%rbp), %rax
	movb	$0, 48(%rax)
	movl	$0, %edx
	movq	-104(%rbp), %rax
	movzbl	%dl, %ecx
	andl	$1, %ecx
	sall	$8, %ecx
	movl	%ecx, %r8d
	movzwl	48(%rax), %ecx
	andb	$254, %ch
	orl	%r8d, %ecx
	movw	%cx, 48(%rax)
	movq	-104(%rbp), %rax
	movzbl	%dl, %edx
	andl	$1, %edx
	movl	%edx, %ecx
	sall	$9, %ecx
	movzwl	48(%rax), %edx
	andb	$253, %dh
	orl	%ecx, %edx
	movw	%dx, 48(%rax)
	.loc 1 109 0
	cmpb	$0, -128(%rbp)
	setne	%dl
	movq	-104(%rbp), %rax
	movzbl	%dl, %edx
	andl	$1, %edx
	movl	%edx, %ecx
	sall	$10, %ecx
	movzwl	48(%rax), %edx
	andb	$251, %dh
	orl	%ecx, %edx
	movw	%dx, 48(%rax)
	.loc 1 110 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rdx
	movq	-104(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 111 0
	leaq	QUARKTS(%rip), %rax
	movq	-104(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 112 0
	movl	$0, %eax
.L32:
	.loc 1 113 0
	addq	$8, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 0
	ret
	.cfi_endproc
.LFE4:
	.seh_endproc
	.def	_qTriggerEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerEvent
_qTriggerEvent:
.LFB5:
	.loc 1 115 0
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
	.loc 1 116 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 16(%rax)
	.loc 1 117 0
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	andl	$256, %eax
	testq	%rax, %rax
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 118 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 24(%rax)
	.loc 1 119 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L37
	.loc 1 119 0 is_stmt 0 discriminator 1
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
.L37:
	.loc 1 120 0 is_stmt 1
	movq	16(%rbp), %rax
	movzwl	48(%rax), %edx
	orb	$1, %dh
	movw	%dx, 48(%rax)
	.loc 1 121 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 32(%rax)
	.loc 1 122 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.seh_endproc
	.def	_qTaskChainbyPriority;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTaskChainbyPriority
_qTaskChainbyPriority:
.LFB6:
	.loc 1 124 0
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
	.loc 1 125 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 126 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 127 0
	jmp	.L39
.L46:
	.loc 1 128 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 129 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 130 0
	jmp	.L40
.L45:
	.loc 1 131 0
	movq	-8(%rbp), %rax
	movzbl	33(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	33(%rax), %eax
	cmpb	%al, %dl
	jae	.L41
	.loc 1 132 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 133 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 134 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L42
	.loc 1 134 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 48(%rax)
	jmp	.L43
.L42:
	.loc 1 135 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L43:
	.loc 1 136 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 137 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L44
.L41:
	.loc 1 140 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 141 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L44:
	.loc 1 143 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 144 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L40
	.loc 1 144 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L40:
	.loc 1 130 0 is_stmt 1 discriminator 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L45
.L39:
	.loc 1 127 0 discriminator 1
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L46
	.loc 1 147 0
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
	.loc 1 149 0
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
.L48:
	.loc 1 152 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	andl	$1, %eax
	testq	%rax, %rax
	jne	.L49
	.loc 1 153 0
	call	_qTaskChainbyPriority
	.loc 1 154 0
	leaq	QUARKTS(%rip), %rax
	movzbl	56(%rax), %edx
	orl	$1, %edx
	movb	%dl, 56(%rax)
.L49:
	.loc 1 156 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 157 0
	jmp	.L50
.L62:
	.loc 1 158 0
	call	_qDequeueTaskEvent
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L51
	.loc 1 158 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L51:
	.loc 1 159 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	jne	.L52
	.loc 1 159 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	js	.L53
	cvtsi2ssq	%rax, %xmm0
	jmp	.L54
.L53:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L54:
	xorps	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L55
	xorps	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L55
.L52:
	.loc 1 159 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	jne	.L57
	.loc 1 159 0 discriminator 2
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	$-1, %al
	jne	.L55
.L57:
	.loc 1 159 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	48(%rax), %rax
	andl	$1024, %eax
	testq	%rax, %rax
	je	.L55
	.loc 1 160 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 161 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	$-1, %al
	je	.L58
	.loc 1 161 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 32(%rax)
.L58:
	.loc 1 162 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	jne	.L59
	.loc 1 162 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzwl	48(%rax), %edx
	andb	$251, %dh
	movw	%dx, 48(%rax)
.L59:
	.loc 1 163 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L60
.L55:
	.loc 1 165 0
	movq	-8(%rbp), %rax
	movq	48(%rax), %rax
	andl	$512, %eax
	testq	%rax, %rax
	je	.L61
	.loc 1 166 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 167 0
	movq	-8(%rbp), %rax
	movzwl	48(%rax), %edx
	andb	$253, %dh
	movw	%dx, 48(%rax)
	.loc 1 168 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L60
.L61:
	.loc 1 170 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L60
	.loc 1 171 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	andl	$2, %eax
	testq	%rax, %rax
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 172 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 16(%rax)
	.loc 1 173 0
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
	.loc 1 174 0
	leaq	QUARKTS(%rip), %rax
	movzbl	56(%rax), %edx
	orl	$1, %edx
	movb	%dl, 56(%rax)
.L60:
	.loc 1 176 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L50:
	.loc 1 157 0 discriminator 1
	cmpq	$0, -8(%rbp)
	jne	.L62
	.loc 1 178 0
	jmp	.L48
	.cfi_endproc
.LFE7:
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
	.long	0x7fa
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C 4.8.3 -fpreprocessed -mtune=generic -march=x86-64 -g\0"
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
	.long	0xda
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
	.long	0x91
	.uleb128 0x4
	.ascii "qTime_t\0"
	.byte	0x2
	.byte	0x20
	.long	0xfb
	.uleb128 0x5
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x4
	.ascii "qClock_t\0"
	.byte	0x2
	.byte	0x21
	.long	0x114
	.uleb128 0x6
	.long	0x119
	.uleb128 0x5
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x4
	.ascii "qPriority_t\0"
	.byte	0x2
	.byte	0x22
	.long	0x141
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x4
	.ascii "qIteration_t\0"
	.byte	0x2
	.byte	0x23
	.long	0x141
	.uleb128 0x4
	.ascii "qState_t\0"
	.byte	0x2
	.byte	0x24
	.long	0x141
	.uleb128 0x4
	.ascii "qBool_t\0"
	.byte	0x2
	.byte	0x25
	.long	0x141
	.uleb128 0x7
	.byte	0x20
	.byte	0x2
	.byte	0x31
	.long	0x1ce
	.uleb128 0x8
	.ascii "Trigger\0"
	.byte	0x2
	.byte	0x32
	.long	0xda
	.byte	0
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x33
	.long	0x1ce
	.byte	0x8
	.uleb128 0x8
	.ascii "EventData\0"
	.byte	0x2
	.byte	0x34
	.long	0x1ce
	.byte	0x10
	.uleb128 0x8
	.ascii "FirstCall\0"
	.byte	0x2
	.byte	0x35
	.long	0x176
	.byte	0x18
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.uleb128 0x4
	.ascii "qEvent_t\0"
	.byte	0x2
	.byte	0x36
	.long	0x185
	.uleb128 0x4
	.ascii "qTaskFcn_t\0"
	.byte	0x2
	.byte	0x38
	.long	0x1f2
	.uleb128 0xb
	.byte	0x8
	.long	0x1f8
	.uleb128 0xc
	.long	0x203
	.uleb128 0xd
	.long	0x1d0
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.byte	0x2
	.byte	0x3a
	.long	0x25d
	.uleb128 0xe
	.ascii "TimedTaskRun\0"
	.byte	0x2
	.byte	0x3b
	.long	0x25d
	.byte	0x4
	.byte	0x8
	.byte	0x18
	.byte	0
	.uleb128 0xe
	.ascii "InitFlag\0"
	.byte	0x2
	.byte	0x3c
	.long	0x25d
	.byte	0x4
	.byte	0x1
	.byte	0x17
	.byte	0
	.uleb128 0xe
	.ascii "AsyncRun\0"
	.byte	0x2
	.byte	0x3d
	.long	0x25d
	.byte	0x4
	.byte	0x1
	.byte	0x16
	.byte	0
	.uleb128 0xe
	.ascii "State\0"
	.byte	0x2
	.byte	0x3e
	.long	0x25d
	.byte	0x4
	.byte	0x1
	.byte	0x15
	.byte	0
	.byte	0
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x4
	.ascii "qTaskFlags_t\0"
	.byte	0x2
	.byte	0x3f
	.long	0x203
	.uleb128 0xf
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x2
	.byte	0x41
	.long	0x320
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x42
	.long	0x1ce
	.byte	0
	.uleb128 0x8
	.ascii "AsyncData\0"
	.byte	0x2
	.byte	0x42
	.long	0x1ce
	.byte	0x8
	.uleb128 0x8
	.ascii "Interval\0"
	.byte	0x2
	.byte	0x43
	.long	0x104
	.byte	0x10
	.uleb128 0x8
	.ascii "TimeElapsed\0"
	.byte	0x2
	.byte	0x43
	.long	0x104
	.byte	0x18
	.uleb128 0x8
	.ascii "Iterations\0"
	.byte	0x2
	.byte	0x44
	.long	0x152
	.byte	0x20
	.uleb128 0x9
	.secrel32	.LASF1
	.byte	0x2
	.byte	0x45
	.long	0x12e
	.byte	0x21
	.uleb128 0x8
	.ascii "Callback\0"
	.byte	0x2
	.byte	0x46
	.long	0x1e0
	.byte	0x28
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x47
	.long	0x320
	.byte	0x30
	.uleb128 0x8
	.ascii "Next\0"
	.byte	0x2
	.byte	0x48
	.long	0x325
	.byte	0x38
	.byte	0
	.uleb128 0x6
	.long	0x26d
	.uleb128 0xb
	.byte	0x8
	.long	0x32b
	.uleb128 0x6
	.long	0x281
	.uleb128 0x7
	.byte	0x10
	.byte	0x2
	.byte	0x4c
	.long	0x357
	.uleb128 0x9
	.secrel32	.LASF2
	.byte	0x2
	.byte	0x4d
	.long	0x325
	.byte	0
	.uleb128 0x8
	.ascii "QueueData\0"
	.byte	0x2
	.byte	0x4e
	.long	0x1ce
	.byte	0x8
	.byte	0
	.uleb128 0x4
	.ascii "qQueueStack_t\0"
	.byte	0x2
	.byte	0x4f
	.long	0x330
	.uleb128 0x7
	.byte	0x4
	.byte	0x2
	.byte	0x51
	.long	0x39a
	.uleb128 0xe
	.ascii "Init\0"
	.byte	0x2
	.byte	0x52
	.long	0x25d
	.byte	0x4
	.byte	0x1
	.byte	0x1f
	.byte	0
	.uleb128 0xe
	.ascii "FCallIdle\0"
	.byte	0x2
	.byte	0x53
	.long	0x25d
	.byte	0x4
	.byte	0x1
	.byte	0x1e
	.byte	0
	.byte	0
	.uleb128 0x4
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x2
	.byte	0x54
	.long	0x36c
	.uleb128 0x7
	.byte	0x50
	.byte	0x2
	.byte	0x56
	.long	0x442
	.uleb128 0x8
	.ascii "IDLECallback\0"
	.byte	0x2
	.byte	0x57
	.long	0x1e0
	.byte	0
	.uleb128 0x8
	.ascii "Tick\0"
	.byte	0x2
	.byte	0x58
	.long	0xec
	.byte	0x8
	.uleb128 0x8
	.ascii "EventInfo\0"
	.byte	0x2
	.byte	0x59
	.long	0x1d0
	.byte	0x10
	.uleb128 0x8
	.ascii "First\0"
	.byte	0x2
	.byte	0x5a
	.long	0x325
	.byte	0x30
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x5b
	.long	0x39a
	.byte	0x38
	.uleb128 0x8
	.ascii "QueueStack\0"
	.byte	0x2
	.byte	0x5c
	.long	0x442
	.byte	0x40
	.uleb128 0x8
	.ascii "QueueSize\0"
	.byte	0x2
	.byte	0x5d
	.long	0x141
	.byte	0x48
	.uleb128 0x8
	.ascii "QueueIndex\0"
	.byte	0x2
	.byte	0x5d
	.long	0x141
	.byte	0x49
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x448
	.uleb128 0x6
	.long	0x357
	.uleb128 0x4
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x2
	.byte	0x5e
	.long	0x3b2
	.uleb128 0x10
	.ascii "_qEnqueueTaskEvent\0"
	.byte	0x1
	.byte	0x1c
	.long	0x50c
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x50c
	.uleb128 0x11
	.ascii "TasktoQueue\0"
	.byte	0x1
	.byte	0x1c
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "eventdata\0"
	.byte	0x1
	.byte	0x1c
	.long	0x1ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x12
	.ascii "PriorityValue\0"
	.byte	0x1
	.byte	0x1e
	.long	0x12e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x12
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x1f
	.long	0x357
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x12
	.ascii "TaskFromQueue\0"
	.byte	0x1
	.byte	0x20
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x2d
	.long	0x141
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x13
	.ascii "_qDequeueTaskEvent\0"
	.byte	0x1
	.byte	0x3a
	.long	0x325
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x55e
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x3b
	.long	0x50c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x3c
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x15
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0x49
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x5e6
	.uleb128 0x11
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0x49
	.long	0xec
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0x49
	.long	0x1e0
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x11
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x49
	.long	0x442
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x49
	.long	0x141
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x4a
	.long	0x141
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x15
	.ascii "_qISRHandler\0"
	.byte	0x1
	.byte	0x55
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x61b
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x57
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x10
	.ascii "_qCreateTask\0"
	.byte	0x1
	.byte	0x64
	.long	0x50c
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x6c2
	.uleb128 0x16
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x64
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "CallbackFcn\0"
	.byte	0x1
	.byte	0x64
	.long	0x1e0
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x16
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x64
	.long	0x12e
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "Time\0"
	.byte	0x1
	.byte	0x64
	.long	0xec
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x11
	.ascii "nExecutions\0"
	.byte	0x1
	.byte	0x64
	.long	0x152
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x11
	.ascii "InitialState\0"
	.byte	0x1
	.byte	0x64
	.long	0x166
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x11
	.ascii "arg\0"
	.byte	0x1
	.byte	0x64
	.long	0x1ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x17
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.byte	0x73
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x709
	.uleb128 0x16
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x73
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "Event\0"
	.byte	0x1
	.byte	0x73
	.long	0xda
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.byte	0x7c
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x786
	.uleb128 0x12
	.ascii "a\0"
	.byte	0x1
	.byte	0x7d
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x12
	.ascii "b\0"
	.byte	0x1
	.byte	0x7d
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x12
	.ascii "c\0"
	.byte	0x1
	.byte	0x7d
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x12
	.ascii "e\0"
	.byte	0x1
	.byte	0x7d
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x12
	.ascii "tmp\0"
	.byte	0x1
	.byte	0x7d
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x12
	.ascii "head\0"
	.byte	0x1
	.byte	0x7e
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x19
	.ascii "_qStart\0"
	.byte	0x1
	.byte	0x95
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x7df
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x96
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x12
	.ascii "qTask\0"
	.byte	0x1
	.byte	0x96
	.long	0x325
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.ascii "pMainSchedule\0"
	.byte	0x1
	.byte	0x97
	.quad	.L48
	.byte	0
	.uleb128 0x1b
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x16
	.long	0x7f8
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0x6
	.long	0x44d
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
	.ident	"GCC: (GNU) 4.8.3"
