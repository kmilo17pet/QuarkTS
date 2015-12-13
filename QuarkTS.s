	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QuarkTS, 64, 5
	.globl	__qSendEvent
	.def	__qSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	__qSendEvent
__qSendEvent:
.LFB0:
	.file 1 "QuarkTS.c"
	.loc 1 30 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	movl	%ecx, %eax
	movb	%al, 16(%rbp)
	.loc 1 31 0
	cmpb	$-1, 16(%rbp)
	je	.L1
	.loc 1 31 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzwl	28(%rax), %edx
	orb	$2, %dh
	movw	%dx, 28(%rax)
.L1:
	.loc 1 32 0 is_stmt 1
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.seh_endproc
	.globl	__qSetTaskState
	.def	__qSetTaskState;	.scl	2;	.type	32;	.endef
	.seh_proc	__qSetTaskState
__qSetTaskState:
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
	movl	%edx, %eax
	movb	%cl, 16(%rbp)
	movb	%al, 24(%rbp)
	.loc 1 35 0
	cmpb	$-1, 16(%rbp)
	jne	.L4
	.loc 1 35 0 is_stmt 0 discriminator 1
	jmp	.L3
.L4:
	.loc 1 36 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	cmpb	$1, 24(%rbp)
	sete	%dl
	movzbl	%dl, %ecx
	andl	$1, %ecx
	movl	%ecx, %r8d
	movzwl	28(%rax), %ecx
	andl	$-2, %ecx
	orl	%r8d, %ecx
	movw	%cx, 28(%rax)
	testb	%dl, %dl
	je	.L3
	.loc 1 37 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rcx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %r8
	subq	%rax, %r8
	movq	%r8, %rax
	addq	%rcx, %rax
	movl	44(%rax), %eax
	movl	%eax, 40(%rdx)
.L3:
	.loc 1 38 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.seh_endproc
	.globl	__qSetIdleTask
	.def	__qSetIdleTask;	.scl	2;	.type	32;	.endef
	.seh_proc	__qSetIdleTask
__qSetIdleTask:
.LFB2:
	.loc 1 40 0
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
	.loc 1 41 0
	leaq	QuarkTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 16(%rax)
	.loc 1 42 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.seh_endproc
	.globl	__qInit
	.def	__qInit;	.scl	2;	.type	32;	.endef
	.seh_proc	__qInit
__qInit:
.LFB3:
	.loc 1 44 0
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
	movl	%edx, %eax
	movq	%r8, 32(%rbp)
	movl	%r9d, %edx
	movb	%al, 24(%rbp)
	movb	%dl, 40(%rbp)
	.loc 1 46 0
	leaq	QuarkTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 47 0
	leaq	QuarkTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 48 0
	leaq	QuarkTS(%rip), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 29(%rax)
	.loc 1 49 0
	leaq	QuarkTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 30(%rax)
	.loc 1 50 0
	movb	$0, -1(%rbp)
	jmp	.L8
.L9:
	.loc 1 51 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 52 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzwl	28(%rax), %edx
	andl	$-2, %edx
	movw	%dx, 28(%rax)
	.loc 1 53 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movb	$0, 24(%rax)
	.loc 1 54 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzwl	28(%rax), %edx
	andw	$-511, %dx
	movw	%dx, 28(%rax)
	.loc 1 55 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	$0, 16(%rax)
	.loc 1 56 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzwl	28(%rax), %edx
	andb	$251, %dh
	movw	%dx, 28(%rax)
	.loc 1 57 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzwl	28(%rax), %edx
	andb	$253, %dh
	movw	%dx, 28(%rax)
	.loc 1 58 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	$0, 8(%rax)
	.loc 1 59 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movl	$0, 40(%rax)
	.loc 1 60 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movl	$0, 44(%rax)
	.loc 1 61 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	$0, 32(%rax)
	.loc 1 50 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L8:
	.loc 1 50 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movzbl	29(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L9
	.loc 1 63 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movb	$0, 31(%rax)
	.loc 1 64 0
	leaq	QuarkTS(%rip), %rax
	movq	56(%rbp), %rdx
	movq	%rdx, 16(%rax)
	.loc 1 65 0
	leaq	QuarkTS(%rip), %rdx
	movl	48(%rbp), %eax
	movl	%eax, 24(%rdx)
	.loc 1 66 0
	leaq	QuarkTS(%rip), %rax
	movzbl	32(%rax), %edx
	andl	$-2, %edx
	movb	%dl, 32(%rax)
	.loc 1 67 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.seh_endproc
	.globl	__qTaskAttach
	.def	__qTaskAttach;	.scl	2;	.type	32;	.endef
	.seh_proc	__qTaskAttach
__qTaskAttach:
.LFB4:
	.loc 1 69 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	subq	$4, %rsp
	.seh_stackalloc	4
	.cfi_def_cfa_offset 20
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -108
	.seh_endprologue
	movq	%rcx, -108(%rbp)
	movq	%rdx, -100(%rbp)
	movl	%r8d, -92(%rbp)
	movss	%xmm3, -84(%rbp)
	movl	-68(%rbp), %eax
	movb	%al, -128(%rbp)
	.loc 1 70 0
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	cmpb	$60, %al
	ja	.L11
	.loc 1 70 0 is_stmt 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %edx
	leaq	QuarkTS(%rip), %rax
	movzbl	29(%rax), %eax
	cmpb	%al, %dl
	jae	.L11
	.loc 1 70 0 discriminator 1
	movss	-84(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QuarkTS(%rip), %rax
	movss	24(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L12
	movss	-84(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jbe	.L12
.L11:
	movl	$255, %eax
	jmp	.L15
.L12:
	.loc 1 71 0 is_stmt 1
	movl	$60, %eax
	cmpl	$60, -92(%rbp)
	cmovbe	-92(%rbp), %eax
	movl	%eax, -92(%rbp)
	.loc 1 72 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rcx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %r8
	subq	%rax, %r8
	movq	%r8, %rax
	addq	%rax, %rcx
	movl	-76(%rbp), %eax
	movl	%eax, 44(%rcx)
	movl	%eax, 40(%rdx)
	.loc 1 73 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	movq	-100(%rbp), %rax
	movq	%rax, (%rdx)
	.loc 1 74 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	-128(%rbp), %edx
	andl	$1, %edx
	movzbl	%dl, %edx
	movl	%edx, %ecx
	andl	$1, %ecx
	movzwl	28(%rax), %edx
	andl	$-2, %edx
	orl	%ecx, %edx
	movw	%dx, 28(%rax)
	.loc 1 75 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	leaq	QuarkTS(%rip), %rax
	movss	24(%rax), %xmm1
	movss	-84(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC2(%rip), %xmm0
	jae	.L16
	cvttss2siq	%xmm0, %rax
	jmp	.L17
.L16:
	movss	.LC2(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rcx
	xorq	%rcx, %rax
.L17:
	movq	%rax, 8(%rdx)
	.loc 1 76 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	movl	-92(%rbp), %eax
	movb	%al, 24(%rdx)
	.loc 1 77 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	movq	-108(%rbp), %rax
	movq	%rax, 32(%rdx)
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	movq	-60(%rbp), %rax
	movq	%rax, 48(%rdx)
	.loc 1 78 0
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %edx
	movq	-108(%rbp), %rax
	movb	%dl, (%rax)
	.loc 1 79 0
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	leal	1(%rax), %edx
	leaq	QuarkTS(%rip), %rax
	movb	%dl, 31(%rax)
	.loc 1 80 0
	leaq	QuarkTS(%rip), %rax
	movzbl	32(%rax), %edx
	andl	$-2, %edx
	movb	%dl, 32(%rax)
	.loc 1 81 0
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
.L15:
	.loc 1 82 0
	addq	$4, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 4
	ret
	.cfi_endproc
.LFE4:
	.seh_endproc
	.globl	__qISRHandler
	.def	__qISRHandler;	.scl	2;	.type	32;	.endef
	.seh_proc	__qISRHandler
__qISRHandler:
.LFB5:
	.loc 1 84 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 85 0
	leaq	QuarkTS(%rip), %rax
	movq	32(%rax), %rax
	andl	$1, %eax
	testq	%rax, %rax
	jne	.L20
	.loc 1 85 0 is_stmt 0 discriminator 1
	jmp	.L19
.L20:
	.loc 1 86 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movzbl	32(%rax), %edx
	orl	$2, %edx
	movb	%dl, 32(%rax)
	.loc 1 87 0
	leaq	QuarkTS(%rip), %rax
	movb	$0, 36(%rax)
	jmp	.L22
.L24:
	.loc 1 88 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	24(%rax), %rdx
	movabsq	$4294967296, %rax
	andq	%rdx, %rax
	testq	%rax, %rax
	je	.L23
	.loc 1 88 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L23
	.loc 1 89 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	16(%rax), %rdx
	addq	$1, %rdx
	movq	%rdx, 16(%rax)
	.loc 1 90 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	16(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rcx
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %r8
	subq	%rax, %r8
	movq	%r8, %rax
	addq	%rcx, %rax
	movq	8(%rax), %rax
	cmpq	%rax, %rdx
	jb	.L23
	.loc 1 91 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	24(%rax), %rdx
	shrq	$33, %rdx
	andb	$255, %dh
	addl	$1, %edx
	movzbl	%dl, %edx
	leal	(%rdx,%rdx), %ecx
	movzwl	28(%rax), %edx
	andw	$-511, %dx
	orl	%ecx, %edx
	movw	%dx, 28(%rax)
	.loc 1 92 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	$0, 16(%rax)
.L23:
	.loc 1 87 0
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %eax
	leal	1(%rax), %edx
	leaq	QuarkTS(%rip), %rax
	movb	%dl, 36(%rax)
.L22:
	.loc 1 87 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movzbl	36(%rax), %edx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	cmpb	%al, %dl
	jb	.L24
	.loc 1 96 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movzbl	32(%rax), %edx
	andl	$-3, %edx
	movb	%dl, 32(%rax)
.L19:
	.loc 1 97 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.seh_endproc
	.def	__qSortByPriority;	.scl	3;	.type	32;	.endef
	.seh_proc	__qSortByPriority
__qSortByPriority:
.LFB6:
	.loc 1 99 0
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
	.loc 1 102 0
	movb	$0, -1(%rbp)
	jmp	.L26
.L30:
	.loc 1 103 0
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -2(%rbp)
	jmp	.L27
.L29:
	.loc 1 104 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	24(%rax), %edx
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rcx
	movzbl	-2(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %r8
	subq	%rax, %r8
	movq	%r8, %rax
	addq	%rcx, %rax
	movzbl	24(%rax), %eax
	cmpb	%al, %dl
	jae	.L28
	.loc 1 105 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	32(%rax), %rax
	movzbl	-2(%rbp), %edx
	movb	%dl, (%rax)
	.loc 1 106 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-2(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	32(%rax), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, (%rax)
	.loc 1 107 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movq	%rdx, -64(%rbp)
	movq	8(%rax), %rdx
	movq	%rdx, -56(%rbp)
	movq	16(%rax), %rdx
	movq	%rdx, -48(%rbp)
	movq	24(%rax), %rdx
	movq	%rdx, -40(%rbp)
	movq	32(%rax), %rdx
	movq	%rdx, -32(%rbp)
	movq	40(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movq	48(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 108 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	leaq	QuarkTS(%rip), %rdx
	movq	(%rdx), %rcx
	movzbl	-2(%rbp), %edx
	salq	$3, %rdx
	leaq	0(,%rdx,8), %r8
	subq	%rdx, %r8
	movq	%r8, %rdx
	addq	%rcx, %rdx
	movq	(%rdx), %rcx
	movq	%rcx, (%rax)
	movq	8(%rdx), %rcx
	movq	%rcx, 8(%rax)
	movq	16(%rdx), %rcx
	movq	%rcx, 16(%rax)
	movq	24(%rdx), %rcx
	movq	%rcx, 24(%rax)
	movq	32(%rdx), %rcx
	movq	%rcx, 32(%rax)
	movq	40(%rdx), %rcx
	movq	%rcx, 40(%rax)
	movq	48(%rdx), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 109 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-2(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	-64(%rbp), %rdx
	movq	%rdx, (%rax)
	movq	-56(%rbp), %rdx
	movq	%rdx, 8(%rax)
	movq	-48(%rbp), %rdx
	movq	%rdx, 16(%rax)
	movq	-40(%rbp), %rdx
	movq	%rdx, 24(%rax)
	movq	-32(%rbp), %rdx
	movq	%rdx, 32(%rax)
	movq	-24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	movq	-16(%rbp), %rdx
	movq	%rdx, 48(%rax)
.L28:
	.loc 1 103 0
	movzbl	-2(%rbp), %eax
	addl	$1, %eax
	movb	%al, -2(%rbp)
.L27:
	.loc 1 103 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	cmpb	-2(%rbp), %al
	ja	.L29
	.loc 1 102 0 is_stmt 1
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L26:
	.loc 1 102 0 is_stmt 0 discriminator 1
	movzbl	-1(%rbp), %edx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jl	.L30
	.loc 1 113 0 is_stmt 1
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.seh_endproc
	.def	__qQueueInit;	.scl	3;	.type	32;	.endef
	.seh_proc	__qQueueInit
__qQueueInit:
.LFB7:
	.loc 1 115 0
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
	.loc 1 117 0
	movb	$0, -1(%rbp)
	jmp	.L32
.L33:
	.loc 1 117 0 is_stmt 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L32:
	.loc 1 117 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movzbl	30(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L33
	.loc 1 118 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movb	$0, 28(%rax)
	.loc 1 119 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.seh_endproc
	.globl	__qQueueTaskEvent
	.def	__qQueueTaskEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	__qQueueTaskEvent
__qQueueTaskEvent:
.LFB8:
	.loc 1 121 0
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
	.loc 1 122 0
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %edx
	leaq	QuarkTS(%rip), %rax
	movzbl	30(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jg	.L35
	.loc 1 122 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$-1, %al
	jne	.L36
.L35:
	.loc 1 122 0 discriminator 1
	movl	$1, %eax
	jmp	.L45
.L36:
	.loc 1 123 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	24(%rax), %eax
	movb	%al, -2(%rbp)
	.loc 1 126 0
	movq	16(%rbp), %rax
	movq	%rax, -32(%rbp)
	.loc 1 127 0
	movq	24(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 128 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L38
	.loc 1 129 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	24(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L40
	.loc 1 130 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 131 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	jmp	.L40
.L38:
	.loc 1 134 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L40:
	.loc 1 136 0
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	leal	1(%rax), %edx
	leaq	QuarkTS(%rip), %rax
	movb	%dl, 28(%rax)
	.loc 1 137 0
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	cmpb	$1, %al
	jne	.L41
	.loc 1 137 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L45
.L41:
	.loc 1 139 0 is_stmt 1
	movb	$0, -1(%rbp)
	jmp	.L42
.L44:
	.loc 1 140 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L43
	.loc 1 141 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	24(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L43
	.loc 1 142 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 143 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	subq	$16, %rax
	leaq	(%rdx,%rax), %rcx
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 144 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L43:
	.loc 1 139 0
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L42:
	.loc 1 139 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movzbl	30(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L44
	.loc 1 148 0 is_stmt 1
	movl	$0, %eax
.L45:
	.loc 1 149 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.def	__qDequeue;	.scl	3;	.type	32;	.endef
	.seh_proc	__qDequeue
__qDequeue:
.LFB9:
	.loc 1 151 0
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
	.loc 1 154 0
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L47
.L51:
	.loc 1 155 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L48
	.loc 1 156 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	movb	%al, -5(%rbp)
	.loc 1 157 0
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 158 0
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	testb	%al, %al
	je	.L49
	.loc 1 158 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movzbl	28(%rax), %eax
	leal	-1(%rax), %edx
	leaq	QuarkTS(%rip), %rax
	movb	%dl, 28(%rax)
.L49:
	.loc 1 159 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	8(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movq	%rdx, 48(%rax)
	.loc 1 160 0
	movzbl	-5(%rbp), %eax
	jmp	.L50
.L48:
	.loc 1 154 0
	subl	$1, -4(%rbp)
.L47:
	.loc 1 154 0 is_stmt 0 discriminator 1
	cmpl	$0, -4(%rbp)
	jns	.L51
	.loc 1 163 0 is_stmt 1
	movl	$-1, %eax
.L50:
	.loc 1 164 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.def	__qTriggerEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	__qTriggerEvent
__qTriggerEvent:
.LFB10:
	.loc 1 166 0
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
	movl	%ecx, %eax
	movl	%edx, 24(%rbp)
	movb	%al, 16(%rbp)
	.loc 1 167 0
	movl	24(%rbp), %eax
	movl	%eax, %edx
	leaq	QuarkTS(%rip), %rax
	movb	%dl, 42(%rax)
	.loc 1 168 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	24(%rax), %rdx
	movabsq	$4398046511104, %rax
	andq	%rdx, %rax
	testq	%rax, %rax
	sete	%al
	movl	%eax, %edx
	leaq	QuarkTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 169 0
	cmpl	$2, 24(%rbp)
	jne	.L53
	.loc 1 169 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzwl	28(%rax), %edx
	andb	$253, %dh
	movw	%dx, 28(%rax)
.L53:
	.loc 1 170 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	48(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movq	%rdx, 56(%rax)
	.loc 1 171 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movq	40(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movq	48(%rax), %rcx
	movq	%rcx, -24(%rbp)
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, %rcx
	call	*%rdx
	.loc 1 172 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzwl	28(%rax), %edx
	orb	$4, %dh
	movw	%dx, 28(%rax)
	.loc 1 173 0
	movl	$0, %eax
	leaq	QuarkTS(%rip), %rdx
	movq	%rax, 56(%rdx)
	leaq	QuarkTS(%rip), %rdx
	movq	%rax, 48(%rdx)
	.loc 1 174 0
	leaq	QuarkTS(%rip), %rax
	movzbl	16(%rbp), %edx
	movb	%dl, 41(%rax)
	.loc 1 175 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.globl	__qChangeParameter
	.def	__qChangeParameter;	.scl	2;	.type	32;	.endef
	.seh_proc	__qChangeParameter
__qChangeParameter:
.LFB11:
	.loc 1 177 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	movl	%edx, %eax
	movss	%xmm2, 32(%rbp)
	movl	%r9d, 40(%rbp)
	movb	%cl, 16(%rbp)
	movb	%al, 24(%rbp)
	.loc 1 178 0
	cmpb	$-1, 16(%rbp)
	jne	.L55
	.loc 1 178 0 is_stmt 0 discriminator 1
	jmp	.L54
.L55:
	.loc 1 179 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L57
	.loc 1 179 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	leaq	QuarkTS(%rip), %rax
	movss	24(%rax), %xmm1
	movss	32(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC2(%rip), %xmm0
	jae	.L58
	cvttss2siq	%xmm0, %rax
	jmp	.L59
.L58:
	movss	.LC2(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rcx
	xorq	%rcx, %rax
.L59:
	movq	%rax, 8(%rdx)
.L57:
	.loc 1 180 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rax, %rdx
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rcx
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	movzbl	%al, %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %r8
	subq	%rax, %r8
	movq	%r8, %rax
	addq	%rax, %rcx
	movl	40(%rbp), %eax
	movl	%eax, 44(%rcx)
	movl	%eax, 40(%rdx)
	.loc 1 181 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	16(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	leaq	(%rdx,%rax), %rcx
	movl	$60, %eax
	movzbl	24(%rbp), %edx
	cmpb	$60, 24(%rbp)
	cmovbe	%edx, %eax
	movb	%al, 24(%rcx)
	.loc 1 182 0
	leaq	QuarkTS(%rip), %rax
	movzbl	32(%rax), %edx
	andl	$-2, %edx
	movb	%dl, 32(%rax)
.L54:
	.loc 1 183 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.globl	__qStartScheduler
	.def	__qStartScheduler;	.scl	2;	.type	32;	.endef
	.seh_proc	__qStartScheduler
__qStartScheduler:
.LFB12:
	.loc 1 185 0
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
	.loc 1 187 0
	movb	$0, -2(%rbp)
	.loc 1 188 0
	call	__qQueueInit
.L61:
	.loc 1 190 0
	leaq	QuarkTS(%rip), %rax
	movq	32(%rax), %rax
	andl	$1, %eax
	testq	%rax, %rax
	jne	.L62
	.loc 1 191 0
	call	__qSortByPriority
	.loc 1 192 0
	leaq	QuarkTS(%rip), %rax
	movzbl	32(%rax), %edx
	orl	$1, %edx
	movb	%dl, 32(%rax)
	.loc 1 193 0
	leaq	QuarkTS(%rip), %rax
	movb	$-1, 41(%rax)
.L62:
	.loc 1 195 0
	movb	$0, -1(%rbp)
	jmp	.L63
.L72:
	.loc 1 196 0
	call	__qDequeue
	movb	%al, -3(%rbp)
	cmpb	$-1, -3(%rbp)
	je	.L64
	.loc 1 196 0 is_stmt 0 discriminator 1
	movzbl	-3(%rbp), %eax
	movl	$3, %edx
	movl	%eax, %ecx
	call	__qTriggerEvent
.L64:
	.loc 1 197 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L65
	.loc 1 197 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	24(%rax), %rdx
	movabsq	$4294967296, %rax
	andq	%rdx, %rax
	testq	%rax, %rax
	je	.L65
	movzbl	-1(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	call	__qTriggerEvent
.L65:
	.loc 1 199 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	24(%rax), %rdx
	movabsq	$2190433320960, %rax
	andq	%rdx, %rax
	testq	%rax, %rax
	je	.L66
	.loc 1 199 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movl	40(%rax), %eax
	testl	%eax, %eax
	jne	.L67
	.loc 1 199 0 discriminator 2
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movl	40(%rax), %eax
	cmpl	$-1, %eax
	jne	.L66
.L67:
	.loc 1 199 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	24(%rax), %rdx
	movabsq	$4294967296, %rax
	andq	%rdx, %rax
	testq	%rax, %rax
	je	.L66
	.loc 1 200 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	24(%rax), %rdx
	shrq	$33, %rdx
	andb	$255, %dh
	subl	$1, %edx
	movzbl	%dl, %edx
	leal	(%rdx,%rdx), %ecx
	movzwl	28(%rax), %edx
	andw	$-511, %dx
	orl	%ecx, %edx
	movw	%dx, 28(%rax)
	.loc 1 201 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movl	40(%rax), %eax
	cmpl	$-1, %eax
	je	.L68
	.loc 1 201 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movl	40(%rax), %edx
	subl	$1, %edx
	movl	%edx, 40(%rax)
.L68:
	.loc 1 202 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movl	40(%rax), %eax
	testl	%eax, %eax
	jne	.L69
	.loc 1 202 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movzwl	28(%rax), %edx
	andl	$-2, %edx
	movw	%dx, 28(%rax)
.L69:
	.loc 1 203 0 is_stmt 1
	movzbl	-1(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	call	__qTriggerEvent
	jmp	.L70
.L66:
	.loc 1 205 0
	leaq	QuarkTS(%rip), %rax
	movq	(%rax), %rdx
	movzbl	-1(%rbp), %eax
	salq	$3, %rax
	leaq	0(,%rax,8), %rcx
	subq	%rax, %rcx
	movq	%rcx, %rax
	addq	%rdx, %rax
	movq	24(%rax), %rdx
	movabsq	$2199023255552, %rax
	andq	%rdx, %rax
	testq	%rax, %rax
	je	.L71
	.loc 1 205 0 is_stmt 0 discriminator 1
	movzbl	-1(%rbp), %eax
	movl	$2, %edx
	movl	%eax, %ecx
	call	__qTriggerEvent
	jmp	.L70
.L71:
	.loc 1 206 0 is_stmt 1
	leaq	QuarkTS(%rip), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L70
	.loc 1 207 0
	cmpb	$0, -2(%rbp)
	sete	%al
	movl	%eax, %edx
	leaq	QuarkTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 208 0
	leaq	QuarkTS(%rip), %rax
	movb	$0, 42(%rax)
	.loc 1 209 0
	leaq	QuarkTS(%rip), %rax
	movq	16(%rax), %rdx
	leaq	QuarkTS(%rip), %rax
	movq	40(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movq	48(%rax), %rcx
	movq	%rcx, -40(%rbp)
	movq	56(%rax), %rax
	movq	%rax, -32(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	call	*%rdx
	.loc 1 210 0
	movb	$1, -2(%rbp)
	.loc 1 211 0
	leaq	QuarkTS(%rip), %rax
	movb	$-1, 41(%rax)
.L70:
	.loc 1 195 0
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L63:
	.loc 1 195 0 is_stmt 0 discriminator 1
	leaq	QuarkTS(%rip), %rax
	movzbl	31(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L72
	.loc 1 214 0 is_stmt 1
	jmp	.L61
	.cfi_endproc
.LFE12:
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
	.long	0xa85
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
	.long	0xce
	.uleb128 0x3
	.ascii "LOWEST_Priority\0"
	.sleb128 0
	.uleb128 0x3
	.ascii "MEDIUM_Priority\0"
	.sleb128 30
	.uleb128 0x3
	.ascii "HIGH_Priority\0"
	.sleb128 61
	.byte	0
	.uleb128 0x4
	.ascii "qPriorityValue_t\0"
	.byte	0x2
	.byte	0x1f
	.long	0x91
	.uleb128 0x2
	.byte	0x4
	.byte	0x2
	.byte	0x20
	.long	0x129
	.uleb128 0x3
	.ascii "byPriority\0"
	.sleb128 0
	.uleb128 0x3
	.ascii "byTimeElapse\0"
	.sleb128 1
	.uleb128 0x3
	.ascii "byAsyncEvent\0"
	.sleb128 2
	.uleb128 0x3
	.ascii "byQueueEvent\0"
	.sleb128 3
	.byte	0
	.uleb128 0x4
	.ascii "qTrigger_t\0"
	.byte	0x2
	.byte	0x20
	.long	0xe6
	.uleb128 0x2
	.byte	0x4
	.byte	0x2
	.byte	0x21
	.long	0x172
	.uleb128 0x3
	.ascii "qQueueSuccess\0"
	.sleb128 0
	.uleb128 0x3
	.ascii "qQueueError\0"
	.sleb128 1
	.uleb128 0x3
	.ascii "qNoValidTask\0"
	.sleb128 255
	.byte	0
	.uleb128 0x4
	.ascii "qReturnValue_t\0"
	.byte	0x2
	.byte	0x21
	.long	0x13b
	.uleb128 0x2
	.byte	0x4
	.byte	0x2
	.byte	0x22
	.long	0x1a4
	.uleb128 0x3
	.ascii "qQueueEND_Empty\0"
	.sleb128 255
	.byte	0
	.uleb128 0x4
	.ascii "qIter_t\0"
	.byte	0x2
	.byte	0x23
	.long	0x1b3
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x4
	.ascii "qTaskID_t\0"
	.byte	0x2
	.byte	0x32
	.long	0x1d4
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x4
	.ascii "qPriority_t\0"
	.byte	0x2
	.byte	0x33
	.long	0x1d4
	.uleb128 0x4
	.ascii "qPeriod_t\0"
	.byte	0x2
	.byte	0x34
	.long	0x209
	.uleb128 0x5
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x4
	.ascii "qClock_t\0"
	.byte	0x2
	.byte	0x35
	.long	0x209
	.uleb128 0x4
	.ascii "qTime_t\0"
	.byte	0x2
	.byte	0x37
	.long	0x23d
	.uleb128 0x5
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x6
	.byte	0x18
	.byte	0x2
	.byte	0x39
	.long	0x29c
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x2
	.byte	0x3a
	.long	0x1d4
	.byte	0
	.uleb128 0x7
	.ascii "LastTaskID\0"
	.byte	0x2
	.byte	0x3a
	.long	0x1d4
	.byte	0x1
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x2
	.byte	0x3a
	.long	0x1d4
	.byte	0x2
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x3b
	.long	0x29c
	.byte	0x8
	.uleb128 0x8
	.secrel32	.LASF1
	.byte	0x2
	.byte	0x3b
	.long	0x29c
	.byte	0x10
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.uleb128 0x4
	.ascii "qEventInfo_t\0"
	.byte	0x2
	.byte	0x3c
	.long	0x246
	.uleb128 0x4
	.ascii "qTask\0"
	.byte	0x2
	.byte	0x3e
	.long	0x2bf
	.uleb128 0xa
	.byte	0x8
	.long	0x2c5
	.uleb128 0xb
	.long	0x2d0
	.uleb128 0xc
	.long	0x29e
	.byte	0
	.uleb128 0x6
	.byte	0x10
	.byte	0x2
	.byte	0x40
	.long	0x2f1
	.uleb128 0x8
	.secrel32	.LASF2
	.byte	0x2
	.byte	0x41
	.long	0x2f1
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x42
	.long	0x29c
	.byte	0x8
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x2f7
	.uleb128 0xd
	.long	0x1c3
	.uleb128 0x4
	.ascii "qQueueStack_t\0"
	.byte	0x2
	.byte	0x43
	.long	0x2d0
	.uleb128 0x6
	.byte	0x4
	.byte	0x2
	.byte	0x45
	.long	0x36f
	.uleb128 0xe
	.ascii "Enable\0"
	.byte	0x2
	.byte	0x46
	.long	0x1b3
	.byte	0x4
	.byte	0x1
	.byte	0x1f
	.byte	0
	.uleb128 0xe
	.ascii "TimedTaskRun\0"
	.byte	0x2
	.byte	0x47
	.long	0x1b3
	.byte	0x4
	.byte	0x8
	.byte	0x17
	.byte	0
	.uleb128 0xe
	.ascii "AsyncRun\0"
	.byte	0x2
	.byte	0x48
	.long	0x1b3
	.byte	0x4
	.byte	0x1
	.byte	0x16
	.byte	0
	.uleb128 0xe
	.ascii "FcnInitFlag\0"
	.byte	0x2
	.byte	0x49
	.long	0x1b3
	.byte	0x4
	.byte	0x1
	.byte	0x15
	.byte	0
	.byte	0
	.uleb128 0x4
	.ascii "qTaskFlags_t\0"
	.byte	0x2
	.byte	0x4a
	.long	0x311
	.uleb128 0x6
	.byte	0x38
	.byte	0x2
	.byte	0x4c
	.long	0x411
	.uleb128 0x7
	.ascii "Function\0"
	.byte	0x2
	.byte	0x4d
	.long	0x2b2
	.byte	0
	.uleb128 0x7
	.ascii "Period\0"
	.byte	0x2
	.byte	0x4e
	.long	0x1f8
	.byte	0x8
	.uleb128 0x7
	.ascii "TimeElapsed\0"
	.byte	0x2
	.byte	0x4f
	.long	0x411
	.byte	0x10
	.uleb128 0x8
	.secrel32	.LASF3
	.byte	0x2
	.byte	0x50
	.long	0x1e5
	.byte	0x18
	.uleb128 0x7
	.ascii "Flags\0"
	.byte	0x2
	.byte	0x51
	.long	0x416
	.byte	0x1c
	.uleb128 0x7
	.ascii "idptr\0"
	.byte	0x2
	.byte	0x52
	.long	0x2f1
	.byte	0x20
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x2
	.byte	0x53
	.long	0x41b
	.byte	0x28
	.uleb128 0x7
	.ascii "N\0"
	.byte	0x2
	.byte	0x53
	.long	0x41b
	.byte	0x2c
	.uleb128 0x8
	.secrel32	.LASF1
	.byte	0x2
	.byte	0x54
	.long	0x29c
	.byte	0x30
	.byte	0
	.uleb128 0xd
	.long	0x21e
	.uleb128 0xd
	.long	0x36f
	.uleb128 0xd
	.long	0x1a4
	.uleb128 0x4
	.ascii "qTaskStack_t\0"
	.byte	0x2
	.byte	0x55
	.long	0x383
	.uleb128 0x6
	.byte	0x4
	.byte	0x2
	.byte	0x57
	.long	0x463
	.uleb128 0xe
	.ascii "Init\0"
	.byte	0x2
	.byte	0x58
	.long	0x1b3
	.byte	0x4
	.byte	0x1
	.byte	0x1f
	.byte	0
	.uleb128 0xe
	.ascii "OnISRCheck\0"
	.byte	0x2
	.byte	0x59
	.long	0x1b3
	.byte	0x4
	.byte	0x1
	.byte	0x1e
	.byte	0
	.byte	0
	.uleb128 0x4
	.ascii "qCoreFlags_t\0"
	.byte	0x2
	.byte	0x5a
	.long	0x434
	.uleb128 0x6
	.byte	0x40
	.byte	0x2
	.byte	0x5c
	.long	0x543
	.uleb128 0x7
	.ascii "TaskStack\0"
	.byte	0x2
	.byte	0x5d
	.long	0x543
	.byte	0
	.uleb128 0x7
	.ascii "QueueStack\0"
	.byte	0x2
	.byte	0x5e
	.long	0x54e
	.byte	0x8
	.uleb128 0x7
	.ascii "IdleTaskCallback\0"
	.byte	0x2
	.byte	0x5f
	.long	0x2b2
	.byte	0x10
	.uleb128 0x7
	.ascii "KernelTick\0"
	.byte	0x2
	.byte	0x60
	.long	0x22e
	.byte	0x18
	.uleb128 0x7
	.ascii "QueueIndex\0"
	.byte	0x2
	.byte	0x61
	.long	0x1d4
	.byte	0x1c
	.uleb128 0x7
	.ascii "MaxTasks\0"
	.byte	0x2
	.byte	0x62
	.long	0x1d4
	.byte	0x1d
	.uleb128 0x7
	.ascii "QueueSize\0"
	.byte	0x2
	.byte	0x63
	.long	0x1d4
	.byte	0x1e
	.uleb128 0x7
	.ascii "TaskCnt\0"
	.byte	0x2
	.byte	0x64
	.long	0x1d4
	.byte	0x1f
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x65
	.long	0x463
	.byte	0x20
	.uleb128 0x7
	.ascii "iISR\0"
	.byte	0x2
	.byte	0x66
	.long	0x559
	.byte	0x24
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x2
	.byte	0x67
	.long	0x55e
	.byte	0x28
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x549
	.uleb128 0xd
	.long	0x420
	.uleb128 0xa
	.byte	0x8
	.long	0x554
	.uleb128 0xd
	.long	0x2fc
	.uleb128 0xd
	.long	0x1d4
	.uleb128 0xd
	.long	0x29e
	.uleb128 0x4
	.ascii "qCoreData_t\0"
	.byte	0x2
	.byte	0x68
	.long	0x477
	.uleb128 0xf
	.ascii "__qSendEvent\0"
	.byte	0x1
	.byte	0x1e
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x5ab
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1e
	.long	0x1c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0xf
	.ascii "__qSetTaskState\0"
	.byte	0x1
	.byte	0x22
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x5f3
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x22
	.long	0x1c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "state\0"
	.byte	0x1
	.byte	0x22
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "__qSetIdleTask\0"
	.byte	0x1
	.byte	0x28
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x637
	.uleb128 0x11
	.ascii "Idle_CallbackFcn\0"
	.byte	0x1
	.byte	0x28
	.long	0x2b2
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0xf
	.ascii "__qInit\0"
	.byte	0x1
	.byte	0x2c
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x6ee
	.uleb128 0x11
	.ascii "T_Stack\0"
	.byte	0x1
	.byte	0x2c
	.long	0x543
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "Size_T_Stack\0"
	.byte	0x1
	.byte	0x2c
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x11
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x2c
	.long	0x54e
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x2c
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x11
	.ascii "ISRTickPeriod\0"
	.byte	0x1
	.byte	0x2c
	.long	0x22e
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x11
	.ascii "IdleTask_CallbackFcn\0"
	.byte	0x1
	.byte	0x2c
	.long	0x2b2
	.uleb128 0x2
	.byte	0x91
	.sleb128 40
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x2d
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x13
	.ascii "__qTaskAttach\0"
	.byte	0x1
	.byte	0x45
	.long	0x172
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x790
	.uleb128 0x11
	.ascii "id\0"
	.byte	0x1
	.byte	0x45
	.long	0x2f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "Task_CallbackFcn\0"
	.byte	0x1
	.byte	0x45
	.long	0x2b2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x10
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x45
	.long	0xce
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "TimeInSec\0"
	.byte	0x1
	.byte	0x45
	.long	0x22e
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x11
	.ascii "n\0"
	.byte	0x1
	.byte	0x45
	.long	0x1a4
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x11
	.ascii "Enable\0"
	.byte	0x1
	.byte	0x45
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x11
	.ascii "data\0"
	.byte	0x1
	.byte	0x45
	.long	0x29c
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x14
	.ascii "__qISRHandler\0"
	.byte	0x1
	.byte	0x54
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x15
	.ascii "__qSortByPriority\0"
	.byte	0x1
	.byte	0x63
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x806
	.uleb128 0x12
	.ascii "tmp\0"
	.byte	0x1
	.byte	0x64
	.long	0x420
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x65
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x12
	.ascii "j\0"
	.byte	0x1
	.byte	0x65
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.byte	0
	.uleb128 0x15
	.ascii "__qQueueInit\0"
	.byte	0x1
	.byte	0x73
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x839
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x74
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x13
	.ascii "__qQueueTaskEvent\0"
	.byte	0x1
	.byte	0x79
	.long	0x172
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x8e2
	.uleb128 0x11
	.ascii "TaskIDtoQueue\0"
	.byte	0x1
	.byte	0x79
	.long	0x2f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "userdata\0"
	.byte	0x1
	.byte	0x79
	.long	0x29c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x12
	.ascii "PriorityValue\0"
	.byte	0x1
	.byte	0x7b
	.long	0x1e5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x12
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x7c
	.long	0x2fc
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x12
	.ascii "TaskID_FromQueue\0"
	.byte	0x1
	.byte	0x7d
	.long	0x2f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x8a
	.long	0x1c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x16
	.ascii "__qDequeue\0"
	.byte	0x1
	.byte	0x97
	.long	0x1c3
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x925
	.uleb128 0x12
	.ascii "i\0"
	.byte	0x1
	.byte	0x98
	.long	0x925
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x99
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -21
	.byte	0
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x18
	.ascii "__qTriggerEvent\0"
	.byte	0x1
	.byte	0xa6
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x976
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xa6
	.long	0x1c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "Trigger\0"
	.byte	0x1
	.byte	0xa6
	.long	0x129
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "__qChangeParameter\0"
	.byte	0x1
	.byte	0xb1
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x9ea
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xb1
	.long	0x1c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "NewPriority\0"
	.byte	0x1
	.byte	0xb1
	.long	0x1e5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x11
	.ascii "NewTimeInSec\0"
	.byte	0x1
	.byte	0xb1
	.long	0x22e
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "n\0"
	.byte	0x1
	.byte	0xb1
	.long	0x1a4
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x19
	.ascii "__qStartScheduler\0"
	.byte	0x1
	.byte	0xb9
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xa6a
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xba
	.long	0x1c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x12
	.ascii "dequeueTaskID\0"
	.byte	0x1
	.byte	0xba
	.long	0x1c3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.uleb128 0x12
	.ascii "fcal_idlefcn\0"
	.byte	0x1
	.byte	0xbb
	.long	0x1d4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1a
	.ascii "QuarkTSLoop\0"
	.byte	0x1
	.byte	0xbe
	.quad	.L61
	.byte	0
	.uleb128 0x1b
	.ascii "QuarkTS\0"
	.byte	0x1
	.byte	0x16
	.long	0xa83
	.uleb128 0x9
	.byte	0x3
	.quad	QuarkTS
	.uleb128 0xd
	.long	0x563
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
	.uleb128 0x9
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0
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
	.byte	0
	.byte	0
	.uleb128 0x15
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
	.uleb128 0x17
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
	.uleb128 0x2116
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
.LASF3:
	.ascii "Priority\0"
.LASF2:
	.ascii "TaskID\0"
.LASF1:
	.ascii "TaskData\0"
.LASF0:
	.ascii "UserData\0"
	.ident	"GCC: (GNU) 4.8.3"
