	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 88, 6
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
	movb	$0, 64(%rax)
	.loc 1 41 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 42 0
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
	jne	.L6
	.loc 1 51 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movl	$0, 20(%rax)
.L6:
	.loc 1 52 0 is_stmt 1
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
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	.loc 1 63 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jle	.L12
	.loc 1 63 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L22
.L12:
	.loc 1 64 0 is_stmt 1
	nop
.L14:
	.loc 1 64 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	jne	.L14
	.loc 1 65 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 82(%rax)
	.loc 1 67 0
	movq	16(%rbp), %rax
	movq	%rax, -32(%rbp)
	.loc 1 68 0
	movq	24(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 71 0
	movq	16(%rbp), %rax
	movzbl	32(%rax), %eax
	movb	%al, -2(%rbp)
	.loc 1 72 0
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
	je	.L15
	.loc 1 73 0
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L17
	.loc 1 74 0
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
	.loc 1 75 0
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
	jmp	.L17
.L15:
	.loc 1 78 0
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
.L17:
	.loc 1 82 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 81(%rax)
	.loc 1 83 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	cmpb	$1, %al
	jne	.L18
	.loc 1 84 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 85 0
	movl	$0, %eax
	jmp	.L22
.L18:
	.loc 1 89 0
	movb	$0, -1(%rbp)
	jmp	.L19
.L21:
	.loc 1 90 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L20
	.loc 1 91 0
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L20
	.loc 1 92 0
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
	.loc 1 93 0
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
	.loc 1 94 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L20:
	.loc 1 89 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L19:
	.loc 1 89 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L21
	.loc 1 99 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 100 0
	movl	$0, %eax
.L22:
	.loc 1 101 0 discriminator 1
	addq	$32, %rsp
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
	.loc 1 104 0
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
	.loc 1 107 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L24
.L29:
	.loc 1 108 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L25
	.loc 1 109 0
	nop
.L26:
	.loc 1 109 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	jne	.L26
	.loc 1 110 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 111 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 112 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 113 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	je	.L27
	.loc 1 113 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	leal	-1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 81(%rax)
.L27:
	.loc 1 114 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L28
.L25:
	.loc 1 107 0 discriminator 2
	subl	$1, -4(%rbp)
.L24:
	.loc 1 107 0 is_stmt 0 discriminator 1
	cmpl	$0, -4(%rbp)
	jns	.L29
	.loc 1 117 0 is_stmt 1
	movl	$0, %eax
.L28:
	.loc 1 118 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.globl	_qInitScheduler
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qInitScheduler
_qInitScheduler:
.LFB10:
	.loc 1 136 0
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
	.loc 1 138 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 56(%rax)
	.loc 1 139 0
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 16(%rdx)
	.loc 1 140 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 141 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 8(%rax)
	.loc 1 142 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 143 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 80(%rax)
	.loc 1 144 0
	movb	$0, -1(%rbp)
	jmp	.L31
.L32:
	.loc 1 144 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L31:
	.loc 1 144 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L32
	.loc 1 145 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 81(%rax)
	.loc 1 146 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 64(%rax)
	.loc 1 147 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 148 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 66(%rax)
	.loc 1 149 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 67(%rax)
	.loc 1 151 0
	leaq	QUARKTS(%rip), %rax
	movl	84(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
	.loc 1 153 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.globl	_qISRHandler
	.def	_qISRHandler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qISRHandler
_qISRHandler:
.LFB11:
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
	.loc 1 156 0
	leaq	QUARKTS(%rip), %rax
	movzbl	64(%rax), %eax
	testb	%al, %al
	jne	.L34
	jmp	.L33
.L34:
	.loc 1 157 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 158 0
	jmp	.L36
.L40:
	.loc 1 159 0
	movq	-8(%rbp), %rax
	movzbl	52(%rax), %eax
	testb	%al, %al
	je	.L37
	.loc 1 159 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	testl	%eax, %eax
	je	.L37
	.loc 1 160 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	20(%rax), %eax
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 161 0
	movq	-8(%rbp), %rax
	movl	20(%rax), %edx
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	%eax, %edx
	jb	.L37
	.loc 1 162 0
	movq	-8(%rbp), %rax
	movzbl	51(%rax), %eax
	testb	%al, %al
	jne	.L38
	.loc 1 162 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	1(%rax), %edx
	jmp	.L39
.L38:
	.loc 1 162 0 discriminator 2
	movl	$1, %edx
.L39:
	.loc 1 162 0 discriminator 4
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 163 0 is_stmt 1 discriminator 4
	movq	-8(%rbp), %rax
	movl	$0, 20(%rax)
.L37:
	.loc 1 166 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L36:
	.loc 1 158 0
	cmpq	$0, -8(%rbp)
	jne	.L40
	.loc 1 169 0
	leaq	QUARKTS(%rip), %rax
	movl	84(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L33:
	.loc 1 171 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.globl	_qCreateTask
	.def	_qCreateTask;	.scl	2;	.type	32;	.endef
	.seh_proc	_qCreateTask
_qCreateTask:
.LFB12:
	.loc 1 173 0
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
	.loc 1 174 0
	movss	40(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L42
	.loc 1 174 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L44
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L44
.L42:
	.loc 1 174 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L45
.L44:
	.loc 1 174 0 discriminator 5
	movl	$-1, %eax
	jmp	.L46
.L45:
	.loc 1 175 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 176 0
	movq	16(%rbp), %rax
	movl	$0, 20(%rax)
	.loc 1 177 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 178 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 179 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 180 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 181 0
	movl	$0, %eax
	movq	16(%rbp), %rdx
	movb	%al, 48(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 49(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 50(%rdx)
	.loc 1 182 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 52(%rax)
	.loc 1 183 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 184 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 185 0
	movq	16(%rbp), %rax
	movl	$0, 28(%rax)
	.loc 1 186 0
	movl	$0, %eax
.L46:
	.loc 1 187 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.seh_endproc
	.def	_qTriggerEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerEvent
_qTriggerEvent:
.LFB13:
	.loc 1 189 0
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
	.loc 1 190 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 24(%rax)
	.loc 1 191 0
	movq	16(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 192 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 193 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L49
	.loc 1 193 0 is_stmt 0 discriminator 1
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
.L49:
	.loc 1 194 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 49(%rax)
	.loc 1 195 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 40(%rax)
	.loc 1 196 0
	movq	16(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 28(%rax)
	.loc 1 197 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.seh_endproc
	.def	_qTaskChainbyPriority;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTaskChainbyPriority
_qTaskChainbyPriority:
.LFB14:
	.loc 1 199 0
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
	.loc 1 200 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 201 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 202 0
	jmp	.L51
.L58:
	.loc 1 203 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 204 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 205 0
	jmp	.L52
.L57:
	.loc 1 206 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	%al, %dl
	jnb	.L53
	.loc 1 207 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 208 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 209 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L54
	.loc 1 209 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L55
.L54:
	.loc 1 210 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L55:
	.loc 1 211 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 212 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L56
.L53:
	.loc 1 215 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 216 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L56:
	.loc 1 218 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 219 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L52
	.loc 1 219 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L52:
	.loc 1 205 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L57
.L51:
	.loc 1 202 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L58
	.loc 1 222 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.globl	_qStart
	.def	_qStart;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStart
_qStart:
.LFB15:
	.loc 1 224 0
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
.L60:
	.loc 1 227 0
	leaq	QUARKTS(%rip), %rax
	movzbl	66(%rax), %eax
	testb	%al, %al
	je	.L61
	nop
.L62:
	.loc 1 257 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 64(%rax)
	.loc 1 258 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 66(%rax)
	.loc 1 259 0
	leaq	QUARKTS(%rip), %rax
	movzbl	67(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 260 0
	leaq	QUARKTS(%rip), %rax
	movl	$3, 24(%rax)
	.loc 1 261 0
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L77
	jmp	.L78
.L61:
	.loc 1 228 0
	leaq	QUARKTS(%rip), %rax
	movzbl	64(%rax), %eax
	testb	%al, %al
	jne	.L63
	.loc 1 229 0
	call	_qTaskChainbyPriority
	.loc 1 230 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 64(%rax)
.L63:
	.loc 1 232 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 233 0
	jmp	.L64
.L76:
	.loc 1 234 0
	call	_qDequeueTaskEvent
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L65
	.loc 1 234 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L65:
	.loc 1 236 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	jne	.L66
	.loc 1 236 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L67
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L68
.L67:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L68:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L69
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L69
.L66:
	.loc 1 236 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L71
	.loc 1 236 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	jne	.L69
.L71:
	.loc 1 236 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	52(%rax), %eax
	testb	%al, %al
	je	.L69
	.loc 1 237 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 238 0
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	je	.L72
	.loc 1 238 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 24(%rax)
.L72:
	.loc 1 239 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L73
	.loc 1 239 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 52(%rax)
.L73:
	.loc 1 240 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L74
.L69:
	.loc 1 242 0
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L75
	.loc 1 243 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 244 0
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
	.loc 1 245 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L74
.L75:
	.loc 1 247 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L74
	.loc 1 248 0
	leaq	QUARKTS(%rip), %rax
	movzbl	65(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 249 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 24(%rax)
	.loc 1 250 0
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
	.loc 1 251 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 65(%rax)
.L74:
	.loc 1 253 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L64:
	.loc 1 233 0
	cmpq	$0, -8(%rbp)
	jne	.L76
	.loc 1 255 0
	jmp	.L60
.L78:
	.loc 1 261 0 discriminator 1
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
.L77:
	.loc 1 262 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 65(%rax)
	.loc 1 263 0
	addq	$80, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.seh_endproc
	.globl	_qStateMachine_Init
	.def	_qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStateMachine_Init
_qStateMachine_Init:
.LFB16:
	.loc 1 265 0
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
	.loc 1 266 0
	cmpq	$0, 24(%rbp)
	jne	.L80
	.loc 1 266 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L81
.L80:
	.loc 1 267 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 268 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 269 0
	movq	16(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 32(%rax)
	.loc 1 270 0
	movq	16(%rbp), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 271 0
	movq	16(%rbp), %rax
	movq	48(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 272 0
	movl	$0, %eax
.L81:
	.loc 1 273 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.globl	_qStateMachine_Run
	.def	_qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStateMachine_Run
_qStateMachine_Run:
.LFB17:
	.loc 1 275 0
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
	.loc 1 276 0
	movq	$0, -8(%rbp)
	.loc 1 277 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 278 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L83
	.loc 1 279 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 20(%rax)
	.loc 1 280 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 281 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 282 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L84
.L83:
	.loc 1 284 0
	movq	16(%rbp), %rax
	movl	$-32767, 16(%rax)
.L84:
	.loc 1 286 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$-32768, %eax
	je	.L86
	cmpl	$-32767, %eax
	jne	.L92
	.loc 1 288 0
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	testq	%rax, %rax
	je	.L88
	.loc 1 288 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 289 0 is_stmt 1 discriminator 1
	jmp	.L82
.L88:
	.loc 1 289 0 is_stmt 0
	jmp	.L82
.L86:
	.loc 1 291 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L90
	.loc 1 291 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 292 0 is_stmt 1 discriminator 1
	jmp	.L82
.L90:
	.loc 1 292 0 is_stmt 0
	jmp	.L82
.L92:
	.loc 1 294 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	je	.L91
	.loc 1 294 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
.L91:
	.loc 1 295 0 is_stmt 1
	nop
.L82:
	.loc 1 297 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.globl	_qSTimerSet
	.def	_qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSTimerSet
_qSTimerSet:
.LFB18:
	.loc 1 300 0
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
	.loc 1 301 0
	movss	24(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L98
	.loc 1 301 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L96
.L98:
	.loc 1 302 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 8(%rax)
	.loc 1 303 0
	leaq	QUARKTS(%rip), %rax
	movl	84(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 4(%rax)
	.loc 1 304 0
	movq	16(%rbp), %rax
	movb	$1, (%rax)
	.loc 1 305 0
	movl	$0, %eax
.L96:
	.loc 1 306 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.globl	_qSTimerExpired
	.def	_qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSTimerExpired
_qSTimerExpired:
.LFB19:
	.loc 1 308 0
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
	.loc 1 309 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L100
	.loc 1 309 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L101
.L100:
	.loc 1 310 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movl	84(%rax), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	%eax, %edx
	setnb	%al
.L101:
	.loc 1 311 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC0:
	.long	1073741824
	.text
.Letext0:
	.file 2 "/usr/include/machine/_default_types.h"
	.file 3 "/usr/include/sys/_stdint.h"
	.file 4 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xe19
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
	.byte	0x1
	.byte	0x6
	.ascii "signed char\0"
	.uleb128 0x3
	.ascii "__uint8_t\0"
	.byte	0x2
	.byte	0x1d
	.long	0xa2
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
	.long	0xef
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
	.byte	0x14
	.long	0x91
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x20
	.long	0xdd
	.uleb128 0x4
	.byte	0x4
	.byte	0x4
	.byte	0x38
	.long	0x188
	.uleb128 0x5
	.ascii "byTimeElapsed\0"
	.sleb128 0
	.uleb128 0x5
	.ascii "byPriority\0"
	.sleb128 1
	.uleb128 0x5
	.ascii "byQueueExtraction\0"
	.sleb128 2
	.uleb128 0x5
	.ascii "byAsyncEvent\0"
	.sleb128 3
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x4
	.byte	0x38
	.long	0x13f
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x4
	.byte	0x39
	.long	0x1a9
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x4
	.byte	0x3a
	.long	0x1c2
	.uleb128 0x6
	.long	0x12f
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x4
	.byte	0x3b
	.long	0x120
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x4
	.byte	0x3c
	.long	0x120
	.uleb128 0x3
	.ascii "qState_t\0"
	.byte	0x4
	.byte	0x3d
	.long	0x120
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x4
	.byte	0x3e
	.long	0x120
	.uleb128 0x7
	.byte	0x20
	.byte	0x4
	.byte	0x4c
	.long	0x256
	.uleb128 0x8
	.ascii "Trigger\0"
	.byte	0x4
	.byte	0x4d
	.long	0x188
	.byte	0
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x4e
	.long	0x256
	.byte	0x8
	.uleb128 0x8
	.ascii "EventData\0"
	.byte	0x4
	.byte	0x4f
	.long	0x256
	.byte	0x10
	.uleb128 0x8
	.ascii "FirstCall\0"
	.byte	0x4
	.byte	0x50
	.long	0x1fe
	.byte	0x18
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x4
	.byte	0x51
	.long	0x20d
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x4
	.byte	0x53
	.long	0x27a
	.uleb128 0xb
	.byte	0x8
	.long	0x280
	.uleb128 0xc
	.long	0x28b
	.uleb128 0xd
	.long	0x258
	.byte	0
	.uleb128 0x7
	.byte	0x5
	.byte	0x4
	.byte	0x54
	.long	0x2f1
	.uleb128 0x8
	.ascii "TimedTaskRun\0"
	.byte	0x4
	.byte	0x55
	.long	0x2f1
	.byte	0
	.uleb128 0x8
	.ascii "InitFlag\0"
	.byte	0x4
	.byte	0x55
	.long	0x2f1
	.byte	0x1
	.uleb128 0x8
	.ascii "AsyncRun\0"
	.byte	0x4
	.byte	0x55
	.long	0x2f1
	.byte	0x2
	.uleb128 0x8
	.ascii "IgnoreOveruns\0"
	.byte	0x4
	.byte	0x55
	.long	0x2f1
	.byte	0x3
	.uleb128 0x8
	.ascii "Enabled\0"
	.byte	0x4
	.byte	0x55
	.long	0x2f1
	.byte	0x4
	.byte	0
	.uleb128 0x6
	.long	0x120
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x4
	.byte	0x56
	.long	0x28b
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x4
	.byte	0x5a
	.long	0x3b8
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x5b
	.long	0x256
	.byte	0
	.uleb128 0x8
	.ascii "AsyncData\0"
	.byte	0x4
	.byte	0x5b
	.long	0x256
	.byte	0x8
	.uleb128 0x8
	.ascii "Interval\0"
	.byte	0x4
	.byte	0x5c
	.long	0x1b2
	.byte	0x10
	.uleb128 0x8
	.ascii "TimeElapsed\0"
	.byte	0x4
	.byte	0x5c
	.long	0x1b2
	.byte	0x14
	.uleb128 0x8
	.ascii "Iterations\0"
	.byte	0x4
	.byte	0x5d
	.long	0x1da
	.byte	0x18
	.uleb128 0x8
	.ascii "Cycles\0"
	.byte	0x4
	.byte	0x5e
	.long	0x12f
	.byte	0x1c
	.uleb128 0x9
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x5f
	.long	0x1c7
	.byte	0x20
	.uleb128 0x8
	.ascii "Callback\0"
	.byte	0x4
	.byte	0x60
	.long	0x268
	.byte	0x28
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x61
	.long	0x3b8
	.byte	0x30
	.uleb128 0x8
	.ascii "Next\0"
	.byte	0x4
	.byte	0x62
	.long	0x3bd
	.byte	0x38
	.byte	0
	.uleb128 0x6
	.long	0x2f6
	.uleb128 0xb
	.byte	0x8
	.long	0x3c3
	.uleb128 0x6
	.long	0x30a
	.uleb128 0x7
	.byte	0x10
	.byte	0x4
	.byte	0x66
	.long	0x3ef
	.uleb128 0x9
	.secrel32	.LASF2
	.byte	0x4
	.byte	0x67
	.long	0x3bd
	.byte	0
	.uleb128 0x8
	.ascii "QueueData\0"
	.byte	0x4
	.byte	0x68
	.long	0x256
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x4
	.byte	0x69
	.long	0x3c8
	.uleb128 0x7
	.byte	0x4
	.byte	0x4
	.byte	0x6b
	.long	0x457
	.uleb128 0x8
	.ascii "Init\0"
	.byte	0x4
	.byte	0x6c
	.long	0x120
	.byte	0
	.uleb128 0x8
	.ascii "FCallIdle\0"
	.byte	0x4
	.byte	0x6c
	.long	0x120
	.byte	0x1
	.uleb128 0x8
	.ascii "ReleaseSched\0"
	.byte	0x4
	.byte	0x6c
	.long	0x120
	.byte	0x2
	.uleb128 0x8
	.ascii "FCallReleased\0"
	.byte	0x4
	.byte	0x6c
	.long	0x120
	.byte	0x3
	.byte	0
	.uleb128 0x3
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x4
	.byte	0x6d
	.long	0x404
	.uleb128 0x7
	.byte	0x58
	.byte	0x4
	.byte	0x6f
	.long	0x540
	.uleb128 0x8
	.ascii "IDLECallback\0"
	.byte	0x4
	.byte	0x70
	.long	0x268
	.byte	0
	.uleb128 0x8
	.ascii "ReleaseSchedCallback\0"
	.byte	0x4
	.byte	0x71
	.long	0x268
	.byte	0x8
	.uleb128 0x8
	.ascii "Tick\0"
	.byte	0x4
	.byte	0x72
	.long	0x19a
	.byte	0x10
	.uleb128 0x8
	.ascii "EventInfo\0"
	.byte	0x4
	.byte	0x73
	.long	0x258
	.byte	0x18
	.uleb128 0x8
	.ascii "First\0"
	.byte	0x4
	.byte	0x74
	.long	0x3bd
	.byte	0x38
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x75
	.long	0x540
	.byte	0x40
	.uleb128 0x8
	.ascii "QueueStack\0"
	.byte	0x4
	.byte	0x76
	.long	0x545
	.byte	0x48
	.uleb128 0x8
	.ascii "QueueSize\0"
	.byte	0x4
	.byte	0x77
	.long	0x120
	.byte	0x50
	.uleb128 0x8
	.ascii "QueueIndex\0"
	.byte	0x4
	.byte	0x77
	.long	0x120
	.byte	0x51
	.uleb128 0x8
	.ascii "NotSafeQueue\0"
	.byte	0x4
	.byte	0x78
	.long	0x2f1
	.byte	0x52
	.uleb128 0x8
	.ascii "epochs\0"
	.byte	0x4
	.byte	0x7a
	.long	0x1b2
	.byte	0x54
	.byte	0
	.uleb128 0x6
	.long	0x457
	.uleb128 0xb
	.byte	0x8
	.long	0x54b
	.uleb128 0x6
	.long	0x3ef
	.uleb128 0x3
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x4
	.byte	0x7c
	.long	0x46f
	.uleb128 0xf
	.ascii "state\0"
	.byte	0x4
	.byte	0x4
	.byte	0xad
	.long	0x5a2
	.uleb128 0x5
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0x5
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x3
	.ascii "qSM_Status_t\0"
	.byte	0x4
	.byte	0xad
	.long	0x569
	.uleb128 0xe
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x4
	.byte	0xb0
	.long	0x66a
	.uleb128 0x8
	.ascii "NextState\0"
	.byte	0x4
	.byte	0xb1
	.long	0x684
	.byte	0
	.uleb128 0x8
	.ascii "PreviousState\0"
	.byte	0x4
	.byte	0xb2
	.long	0x684
	.byte	0x8
	.uleb128 0x8
	.ascii "PreviousReturnStatus\0"
	.byte	0x4
	.byte	0xb3
	.long	0x5a2
	.byte	0x10
	.uleb128 0x8
	.ascii "StateJustChanged\0"
	.byte	0x4
	.byte	0xb4
	.long	0x1fe
	.byte	0x14
	.uleb128 0x8
	.ascii "Data\0"
	.byte	0x4
	.byte	0xb5
	.long	0x256
	.byte	0x18
	.uleb128 0x8
	.ascii "__Failure\0"
	.byte	0x4
	.byte	0xb6
	.long	0x684
	.byte	0x20
	.uleb128 0x8
	.ascii "__Success\0"
	.byte	0x4
	.byte	0xb7
	.long	0x684
	.byte	0x28
	.uleb128 0x8
	.ascii "__Unexpected\0"
	.byte	0x4
	.byte	0xb8
	.long	0x684
	.byte	0x30
	.byte	0
	.uleb128 0x10
	.long	0x5a2
	.long	0x679
	.uleb128 0xd
	.long	0x679
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x67f
	.uleb128 0x6
	.long	0x5b6
	.uleb128 0xb
	.byte	0x8
	.long	0x66a
	.uleb128 0x3
	.ascii "qSM_State_t\0"
	.byte	0x4
	.byte	0xba
	.long	0x684
	.uleb128 0x7
	.byte	0xc
	.byte	0x4
	.byte	0xcf
	.long	0x6ca
	.uleb128 0x8
	.ascii "SR\0"
	.byte	0x4
	.byte	0xd0
	.long	0x120
	.byte	0
	.uleb128 0x8
	.ascii "Start\0"
	.byte	0x4
	.byte	0xd1
	.long	0x1b2
	.byte	0x4
	.uleb128 0x8
	.ascii "TV\0"
	.byte	0x4
	.byte	0xd1
	.long	0x1b2
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qSTimer_t\0"
	.byte	0x4
	.byte	0xd2
	.long	0x69d
	.uleb128 0x11
	.ascii "_qSendEvent\0"
	.byte	0x1
	.byte	0x1a
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x71d
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1a
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x1a
	.long	0x256
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetTime\0"
	.byte	0x1
	.byte	0x1f
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x75d
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1f
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x1f
	.long	0x19a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetIterations\0"
	.byte	0x1
	.byte	0x23
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x7a3
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x23
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x23
	.long	0x1da
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetPriority\0"
	.byte	0x1
	.byte	0x27
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x7e7
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x27
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x27
	.long	0x1c7
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetCallback\0"
	.byte	0x1
	.byte	0x2c
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x82b
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2c
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x2c
	.long	0x268
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qEnableDisable\0"
	.byte	0x1
	.byte	0x30
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x871
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x30
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x30
	.long	0xa2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetUserData\0"
	.byte	0x1
	.byte	0x36
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x8b5
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x36
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "arg\0"
	.byte	0x1
	.byte	0x36
	.long	0x256
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qClearTimeElapse\0"
	.byte	0x1
	.byte	0x3a
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x8ef
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x3a
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x14
	.ascii "_qEnqueueTaskEvent\0"
	.byte	0x1
	.byte	0x3e
	.long	0xd6
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x98f
	.uleb128 0x13
	.ascii "TasktoQueue\0"
	.byte	0x1
	.byte	0x3e
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x3e
	.long	0x256
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x15
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x42
	.long	0x3ef
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x15
	.ascii "TaskFromQueue\0"
	.byte	0x1
	.byte	0x46
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x15
	.ascii "PriorityValue\0"
	.byte	0x1
	.byte	0x47
	.long	0x1c7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x15
	.ascii "i\0"
	.byte	0x1
	.byte	0x58
	.long	0xa2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x16
	.ascii "_qDequeueTaskEvent\0"
	.byte	0x1
	.byte	0x68
	.long	0x3bd
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x9da
	.uleb128 0x15
	.ascii "i\0"
	.byte	0x1
	.byte	0x69
	.long	0xd6
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x6a
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x11
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0x88
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xa62
	.uleb128 0x13
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0x88
	.long	0x19a
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0x88
	.long	0x268
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x13
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x88
	.long	0x545
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x13
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x88
	.long	0xa2
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x15
	.ascii "i\0"
	.byte	0x1
	.byte	0x89
	.long	0xa2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x11
	.ascii "_qISRHandler\0"
	.byte	0x1
	.byte	0x9b
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xa97
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x9d
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x14
	.ascii "_qCreateTask\0"
	.byte	0x1
	.byte	0xad
	.long	0xd6
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xb36
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xad
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF5
	.byte	0x1
	.byte	0xad
	.long	0x268
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0xad
	.long	0x1c7
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x13
	.ascii "Time\0"
	.byte	0x1
	.byte	0xad
	.long	0x19a
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x13
	.ascii "nExecutions\0"
	.byte	0x1
	.byte	0xad
	.long	0x1da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x13
	.ascii "InitialState\0"
	.byte	0x1
	.byte	0xad
	.long	0x1ee
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x13
	.ascii "arg\0"
	.byte	0x1
	.byte	0xad
	.long	0x256
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x18
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.byte	0xbd
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xb7d
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xbd
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "Event\0"
	.byte	0x1
	.byte	0xbd
	.long	0x188
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.byte	0xc7
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xbfa
	.uleb128 0x15
	.ascii "a\0"
	.byte	0x1
	.byte	0xc8
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x15
	.ascii "b\0"
	.byte	0x1
	.byte	0xc8
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x15
	.ascii "c\0"
	.byte	0x1
	.byte	0xc8
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x15
	.ascii "e\0"
	.byte	0x1
	.byte	0xc8
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x15
	.ascii "tmp\0"
	.byte	0x1
	.byte	0xc8
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x15
	.ascii "head\0"
	.byte	0x1
	.byte	0xc9
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x1a
	.ascii "_qStart\0"
	.byte	0x1
	.byte	0xe0
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xc71
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xe1
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x15
	.ascii "qTask\0"
	.byte	0x1
	.byte	0xe1
	.long	0x3bd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1b
	.ascii "qMainSchedule\0"
	.byte	0x1
	.byte	0xe2
	.quad	.L60
	.uleb128 0x1c
	.ascii "qReleasedSchedule\0"
	.byte	0x1
	.word	0x100
	.quad	.L62
	.byte	0
	.uleb128 0x1d
	.ascii "_qStateMachine_Init\0"
	.byte	0x1
	.word	0x109
	.long	0xd6
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xd13
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x109
	.long	0x679
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "InitState\0"
	.byte	0x1
	.word	0x109
	.long	0x68a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.ascii "SuccessState\0"
	.byte	0x1
	.word	0x109
	.long	0x68a
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1e
	.ascii "FailureState\0"
	.byte	0x1
	.word	0x109
	.long	0x68a
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1e
	.ascii "UnexpectedState\0"
	.byte	0x1
	.word	0x109
	.long	0x68a
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0x1f
	.ascii "_qStateMachine_Run\0"
	.byte	0x1
	.word	0x113
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xd70
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x113
	.long	0x679
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "Data\0"
	.byte	0x1
	.word	0x113
	.long	0x256
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x20
	.ascii "prev\0"
	.byte	0x1
	.word	0x114
	.long	0x68a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1d
	.ascii "_qSTimerSet\0"
	.byte	0x1
	.word	0x12c
	.long	0xd6
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0xdba
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x12c
	.long	0xdba
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "Time\0"
	.byte	0x1
	.word	0x12c
	.long	0x19a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x6ca
	.uleb128 0x1d
	.ascii "_qSTimerExpired\0"
	.byte	0x1
	.word	0x134
	.long	0xa2
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0xdfe
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x134
	.long	0xdba
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x15
	.long	0xe17
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0x6
	.long	0x550
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
	.uleb128 0xd
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
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x1c
	.uleb128 0xa
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x11
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x1d
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
	.uleb128 0x1e
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
	.uleb128 0x1f
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
	.uleb128 0x20
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
