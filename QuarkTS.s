	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 96, 6
.lcomm __qSM_Failure,8,8
.lcomm __qSM_Success,8,8
.lcomm __qSM_Unexpected,8,8
	.globl	_qSendEvent
	.def	_qSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	_qSendEvent
_qSendEvent:
.LFB0:
	.file 1 "QuarkTS.c"
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
	movq	%rdx, 24(%rbp)
	.loc 1 35 0
	movq	16(%rbp), %rax
	movb	$1, 66(%rax)
	.loc 1 36 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 37 0
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
	movss	%xmm1, 24(%rbp)
	.loc 1 40 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
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
	.loc 1 41 0
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
	.loc 1 43 0
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
	.loc 1 44 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 45 0
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
	movl	%edx, %eax
	movb	%al, 24(%rbp)
	.loc 1 48 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 64(%rax)
	.loc 1 49 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 48(%rax)
	.loc 1 50 0
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
	.loc 1 52 0
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
	.loc 1 53 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 54 0
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
	.loc 1 56 0
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
	.loc 1 57 0
	cmpb	$0, 24(%rbp)
	je	.L9
	.loc 1 57 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
.L9:
	.loc 1 58 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 67(%rax)
	.loc 1 59 0
	cmpb	$0, 24(%rbp)
	jne	.L8
	.loc 1 59 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
.L8:
	.loc 1 60 0 is_stmt 1
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
	.loc 1 62 0
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
	.loc 1 63 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 64 0
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
	.loc 1 66 0
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
	.loc 1 67 0
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
	.loc 1 68 0
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
	.loc 1 70 0
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
	.loc 1 71 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jle	.L14
	.loc 1 71 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L24
.L14:
	.loc 1 72 0 is_stmt 1
	nop
.L16:
	.loc 1 72 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	jne	.L16
	.loc 1 73 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 82(%rax)
	.loc 1 75 0
	movq	16(%rbp), %rax
	movq	%rax, -32(%rbp)
	.loc 1 76 0
	movq	24(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 79 0
	movq	16(%rbp), %rax
	movzbl	48(%rax), %eax
	movb	%al, -2(%rbp)
	.loc 1 80 0
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
	je	.L17
	.loc 1 81 0
	movq	-16(%rbp), %rax
	movzbl	48(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L19
	.loc 1 82 0
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
	.loc 1 83 0
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
	jmp	.L19
.L17:
	.loc 1 86 0
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
.L19:
	.loc 1 91 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 81(%rax)
	.loc 1 92 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	cmpb	$1, %al
	jne	.L20
	.loc 1 93 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 94 0
	movl	$0, %eax
	jmp	.L24
.L20:
	.loc 1 99 0
	movb	$0, -1(%rbp)
	jmp	.L21
.L23:
	.loc 1 100 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L22
	.loc 1 101 0
	movq	-16(%rbp), %rax
	movzbl	48(%rax), %eax
	cmpb	-2(%rbp), %al
	jb	.L22
	.loc 1 102 0
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
	.loc 1 103 0
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
	.loc 1 104 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
.L22:
	.loc 1 99 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L21:
	.loc 1 99 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L23
	.loc 1 109 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 110 0
	movl	$0, %eax
.L24:
	.loc 1 111 0 discriminator 1
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
	.loc 1 114 0
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
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L26
.L31:
	.loc 1 118 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L27
	.loc 1 119 0
	nop
.L28:
	.loc 1 119 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	jne	.L28
	.loc 1 120 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 121 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 122 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 123 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	je	.L29
	.loc 1 123 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	leal	-1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 81(%rax)
.L29:
	.loc 1 124 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L30
.L27:
	.loc 1 117 0 discriminator 2
	subl	$1, -4(%rbp)
.L26:
	.loc 1 117 0 is_stmt 0 discriminator 1
	cmpl	$0, -4(%rbp)
	jns	.L31
	.loc 1 127 0 is_stmt 1
	movl	$0, %eax
.L30:
	.loc 1 128 0
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
	.loc 1 146 0
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
	.loc 1 148 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 56(%rax)
	.loc 1 149 0
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 16(%rdx)
	.loc 1 150 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 151 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 8(%rax)
	.loc 1 152 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 153 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 80(%rax)
	.loc 1 154 0
	movb	$0, -1(%rbp)
	jmp	.L33
.L34:
	.loc 1 154 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L33:
	.loc 1 154 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L34
	.loc 1 155 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 81(%rax)
	.loc 1 156 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 64(%rax)
	.loc 1 157 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 158 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 66(%rax)
	.loc 1 159 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 67(%rax)
	.loc 1 161 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	leaq	1(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 88(%rax)
	.loc 1 163 0
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
	.loc 1 165 0
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
	.loc 1 166 0
	leaq	QUARKTS(%rip), %rax
	movzbl	64(%rax), %eax
	testb	%al, %al
	jne	.L36
	jmp	.L35
.L36:
	.loc 1 167 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 168 0
	jmp	.L38
.L42:
	.loc 1 169 0
	movq	-8(%rbp), %rax
	movzbl	67(%rax), %eax
	testb	%al, %al
	je	.L39
	.loc 1 169 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L39
	.loc 1 170 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 24(%rax)
	.loc 1 171 0
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%rax, %rdx
	jb	.L39
	.loc 1 172 0
	movq	-8(%rbp), %rax
	movzbl	68(%rax), %eax
	testb	%al, %al
	jne	.L40
	.loc 1 172 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	64(%rax), %eax
	leal	1(%rax), %edx
	jmp	.L41
.L40:
	.loc 1 172 0 discriminator 2
	movl	$1, %edx
.L41:
	.loc 1 172 0 discriminator 4
	movq	-8(%rbp), %rax
	movb	%dl, 64(%rax)
	.loc 1 173 0 is_stmt 1 discriminator 4
	movq	-8(%rbp), %rax
	movq	$0, 24(%rax)
.L39:
	.loc 1 176 0
	movq	-8(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, -8(%rbp)
.L38:
	.loc 1 168 0
	cmpq	$0, -8(%rbp)
	jne	.L42
	.loc 1 179 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	leaq	1(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 88(%rax)
.L35:
	.loc 1 182 0
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
	.loc 1 184 0
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
	.loc 1 185 0
	movss	40(%rbp), %xmm0
	movss	.LC1(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L44
	.loc 1 185 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L46
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L46
.L44:
	.loc 1 185 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L47
.L46:
	.loc 1 185 0 discriminator 5
	movl	$-1, %eax
	jmp	.L48
.L47:
	.loc 1 186 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 187 0
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
	.loc 1 188 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC0(%rip), %xmm0
	jnb	.L49
	cvttss2siq	%xmm0, %rax
	jmp	.L50
.L49:
	movss	.LC0(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L50:
	movq	16(%rbp), %rdx
	movq	%rax, 16(%rdx)
	.loc 1 189 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 190 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 48(%rax)
	.loc 1 191 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 192 0
	movl	$0, %eax
	movq	16(%rbp), %rdx
	movb	%al, 64(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 65(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 66(%rdx)
	.loc 1 193 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 67(%rax)
	.loc 1 194 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 72(%rax)
	.loc 1 195 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 196 0
	movq	16(%rbp), %rax
	movq	$0, 40(%rax)
	.loc 1 197 0
	movl	$0, %eax
.L48:
	.loc 1 198 0
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
	.loc 1 200 0
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
	.loc 1 201 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 24(%rax)
	.loc 1 202 0
	movq	16(%rbp), %rax
	movzbl	65(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 203 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 204 0
	movq	16(%rbp), %rax
	movq	56(%rax), %rax
	testq	%rax, %rax
	je	.L53
	.loc 1 204 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	56(%rax), %rdx
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
.L53:
	.loc 1 205 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 65(%rax)
	.loc 1 206 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 40(%rax)
	.loc 1 207 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	leaq	1(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 40(%rax)
	.loc 1 208 0
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
	.loc 1 210 0
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
	.loc 1 211 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 212 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 213 0
	jmp	.L55
.L62:
	.loc 1 214 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 215 0
	movq	-8(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 216 0
	jmp	.L56
.L61:
	.loc 1 217 0
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	48(%rax), %eax
	cmpb	%al, %dl
	jnb	.L57
	.loc 1 218 0
	movq	-16(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 219 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 220 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L58
	.loc 1 220 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L59
.L58:
	.loc 1 221 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 72(%rax)
.L59:
	.loc 1 222 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 223 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 72(%rax)
	jmp	.L60
.L57:
	.loc 1 226 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 227 0
	movq	-8(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, -8(%rbp)
.L60:
	.loc 1 229 0
	movq	-8(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 230 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L56
	.loc 1 230 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L56:
	.loc 1 216 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L61
.L55:
	.loc 1 213 0
	movq	-40(%rbp), %rax
	movq	72(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L62
	.loc 1 233 0
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
	.loc 1 235 0
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
.L64:
	.loc 1 238 0
	leaq	QUARKTS(%rip), %rax
	movzbl	66(%rax), %eax
	testb	%al, %al
	je	.L65
	nop
.L66:
	.loc 1 267 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 64(%rax)
	.loc 1 268 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 66(%rax)
	.loc 1 269 0
	leaq	QUARKTS(%rip), %rax
	movzbl	67(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 270 0
	leaq	QUARKTS(%rip), %rax
	movl	$3, 24(%rax)
	.loc 1 271 0
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L81
	jmp	.L82
.L65:
	.loc 1 239 0
	leaq	QUARKTS(%rip), %rax
	movzbl	64(%rax), %eax
	testb	%al, %al
	jne	.L67
	.loc 1 240 0
	call	_qTaskChainbyPriority
	.loc 1 241 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 64(%rax)
.L67:
	.loc 1 243 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 244 0
	jmp	.L68
.L80:
	.loc 1 245 0
	call	_qDequeueTaskEvent
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L69
	.loc 1 245 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L69:
	.loc 1 246 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	64(%rax), %eax
	testb	%al, %al
	jne	.L70
	.loc 1 246 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	js	.L71
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L72
.L71:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L72:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L73
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L73
.L70:
	.loc 1 246 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	jne	.L75
	.loc 1 246 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	$-1, %al
	jne	.L73
.L75:
	.loc 1 246 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	67(%rax), %eax
	testb	%al, %al
	je	.L73
	.loc 1 247 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	64(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 64(%rax)
	.loc 1 248 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	$-1, %al
	je	.L76
	.loc 1 248 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 32(%rax)
.L76:
	.loc 1 249 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	jne	.L77
	.loc 1 249 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 67(%rax)
.L77:
	.loc 1 250 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L78
.L73:
	.loc 1 252 0
	movq	-8(%rbp), %rax
	movzbl	66(%rax), %eax
	testb	%al, %al
	je	.L79
	.loc 1 253 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 254 0
	movq	-8(%rbp), %rax
	movb	$0, 66(%rax)
	.loc 1 255 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L78
.L79:
	.loc 1 257 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L78
	.loc 1 258 0
	leaq	QUARKTS(%rip), %rax
	movzbl	65(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 259 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 24(%rax)
	.loc 1 260 0
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
	.loc 1 261 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 65(%rax)
.L78:
	.loc 1 263 0
	movq	-8(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, -8(%rbp)
.L68:
	.loc 1 244 0
	cmpq	$0, -8(%rbp)
	jne	.L80
	.loc 1 265 0
	jmp	.L64
.L82:
	.loc 1 271 0 discriminator 1
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
.L81:
	.loc 1 272 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 65(%rax)
	.loc 1 273 0
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
	.loc 1 275 0
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
	.loc 1 276 0
	cmpq	$0, 24(%rbp)
	jne	.L84
	.loc 1 276 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L85
.L84:
	.loc 1 277 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 278 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 279 0
	movq	40(%rbp), %rax
	movq	%rax, __qSM_Failure(%rip)
	.loc 1 280 0
	movq	32(%rbp), %rax
	movq	%rax, __qSM_Success(%rip)
	.loc 1 281 0
	movq	48(%rbp), %rax
	movq	%rax, __qSM_Unexpected(%rip)
	.loc 1 282 0
	movl	$0, %eax
.L85:
	.loc 1 283 0
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
	.loc 1 285 0
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
	.loc 1 286 0
	movq	$0, -8(%rbp)
	.loc 1 287 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 288 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L87
	.loc 1 289 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 290 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 291 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L88
.L87:
	.loc 1 293 0
	movq	16(%rbp), %rax
	movl	$-32767, 16(%rax)
.L88:
	.loc 1 295 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$-32768, %eax
	je	.L90
	cmpl	$-32767, %eax
	jne	.L96
	.loc 1 297 0
	movq	__qSM_Failure(%rip), %rax
	testq	%rax, %rax
	je	.L92
	.loc 1 297 0 is_stmt 0 discriminator 1
	movq	__qSM_Failure(%rip), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 298 0 is_stmt 1 discriminator 1
	jmp	.L86
.L92:
	.loc 1 298 0 is_stmt 0
	jmp	.L86
.L90:
	.loc 1 300 0 is_stmt 1
	movq	__qSM_Success(%rip), %rax
	testq	%rax, %rax
	je	.L94
	.loc 1 300 0 is_stmt 0 discriminator 1
	movq	__qSM_Success(%rip), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 301 0 is_stmt 1 discriminator 1
	jmp	.L86
.L94:
	.loc 1 301 0 is_stmt 0
	jmp	.L86
.L96:
	.loc 1 303 0 is_stmt 1
	movq	__qSM_Unexpected(%rip), %rax
	testq	%rax, %rax
	je	.L95
	.loc 1 303 0 is_stmt 0 discriminator 1
	movq	__qSM_Unexpected(%rip), %rax
	movq	16(%rbp), %rcx
	call	*%rax
.L95:
	.loc 1 304 0 is_stmt 1
	nop
.L86:
	.loc 1 306 0
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
	.loc 1 310 0
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
	.loc 1 311 0
	movss	24(%rbp), %xmm0
	movss	.LC1(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L104
	.loc 1 311 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L100
.L104:
	.loc 1 312 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC0(%rip), %xmm0
	jnb	.L101
	cvttss2siq	%xmm0, %rax
	jmp	.L102
.L101:
	movss	.LC0(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L102:
	movq	16(%rbp), %rdx
	movq	%rax, 16(%rdx)
	.loc 1 313 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 8(%rax)
	.loc 1 314 0
	movq	16(%rbp), %rax
	movb	$1, (%rax)
	.loc 1 315 0
	movl	$0, %eax
.L100:
	.loc 1 316 0
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
	.loc 1 318 0
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
	.loc 1 319 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L106
	.loc 1 319 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L107
.L106:
	.loc 1 320 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rdx
	movq	16(%rbp), %rax
	movq	8(%rax), %rax
	subq	%rax, %rdx
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%rax, %rdx
	seta	%al
.L107:
	.loc 1 321 0
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
	.long	1593835520
	.align 4
.LC1:
	.long	1073741824
	.text
.Letext0:
	.file 2 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xd93
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
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x3
	.byte	0x4
	.byte	0x2
	.byte	0x38
	.long	0xd2
	.uleb128 0x4
	.ascii "byTimeElapsed\0"
	.sleb128 0
	.uleb128 0x4
	.ascii "byPriority\0"
	.sleb128 1
	.uleb128 0x4
	.ascii "byQueueExtraction\0"
	.sleb128 2
	.uleb128 0x4
	.ascii "byAsyncEvent\0"
	.sleb128 3
	.byte	0
	.uleb128 0x5
	.ascii "qTrigger_t\0"
	.byte	0x2
	.byte	0x38
	.long	0x89
	.uleb128 0x5
	.ascii "qTime_t\0"
	.byte	0x2
	.byte	0x39
	.long	0xf3
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x5
	.ascii "qClock_t\0"
	.byte	0x2
	.byte	0x3a
	.long	0x10c
	.uleb128 0x6
	.long	0x111
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x5
	.ascii "qPriority_t\0"
	.byte	0x2
	.byte	0x3b
	.long	0x139
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x5
	.ascii "qIteration_t\0"
	.byte	0x2
	.byte	0x3c
	.long	0x139
	.uleb128 0x5
	.ascii "qState_t\0"
	.byte	0x2
	.byte	0x3d
	.long	0x139
	.uleb128 0x5
	.ascii "qBool_t\0"
	.byte	0x2
	.byte	0x3e
	.long	0x139
	.uleb128 0x7
	.byte	0x20
	.byte	0x2
	.byte	0x4c
	.long	0x1c6
	.uleb128 0x8
	.ascii "Trigger\0"
	.byte	0x2
	.byte	0x4d
	.long	0xd2
	.byte	0
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x4e
	.long	0x1c6
	.byte	0x8
	.uleb128 0x8
	.ascii "EventData\0"
	.byte	0x2
	.byte	0x4f
	.long	0x1c6
	.byte	0x10
	.uleb128 0x8
	.ascii "FirstCall\0"
	.byte	0x2
	.byte	0x50
	.long	0x16e
	.byte	0x18
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.uleb128 0x5
	.ascii "qEvent_t\0"
	.byte	0x2
	.byte	0x51
	.long	0x17d
	.uleb128 0x5
	.ascii "qTaskFcn_t\0"
	.byte	0x2
	.byte	0x53
	.long	0x1ea
	.uleb128 0xb
	.byte	0x8
	.long	0x1f0
	.uleb128 0xc
	.long	0x1fb
	.uleb128 0xd
	.long	0x1c8
	.byte	0
	.uleb128 0x7
	.byte	0x5
	.byte	0x2
	.byte	0x55
	.long	0x25f
	.uleb128 0x8
	.ascii "TimedTaskRun\0"
	.byte	0x2
	.byte	0x56
	.long	0x25f
	.byte	0
	.uleb128 0x8
	.ascii "InitFlag\0"
	.byte	0x2
	.byte	0x57
	.long	0x25f
	.byte	0x1
	.uleb128 0x8
	.ascii "AsyncRun\0"
	.byte	0x2
	.byte	0x58
	.long	0x25f
	.byte	0x2
	.uleb128 0x8
	.ascii "State\0"
	.byte	0x2
	.byte	0x59
	.long	0x25f
	.byte	0x3
	.uleb128 0x8
	.ascii "IgnoreOveruns\0"
	.byte	0x2
	.byte	0x5a
	.long	0x25f
	.byte	0x4
	.byte	0
	.uleb128 0x6
	.long	0x139
	.uleb128 0x5
	.ascii "qTaskFlags_t\0"
	.byte	0x2
	.byte	0x5b
	.long	0x1fb
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x50
	.byte	0x2
	.byte	0x5d
	.long	0x326
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x5e
	.long	0x1c6
	.byte	0
	.uleb128 0x8
	.ascii "AsyncData\0"
	.byte	0x2
	.byte	0x5e
	.long	0x1c6
	.byte	0x8
	.uleb128 0x8
	.ascii "Interval\0"
	.byte	0x2
	.byte	0x5f
	.long	0xfc
	.byte	0x10
	.uleb128 0x8
	.ascii "TimeElapsed\0"
	.byte	0x2
	.byte	0x5f
	.long	0xfc
	.byte	0x18
	.uleb128 0x8
	.ascii "Iterations\0"
	.byte	0x2
	.byte	0x60
	.long	0x14a
	.byte	0x20
	.uleb128 0x8
	.ascii "Cycles\0"
	.byte	0x2
	.byte	0x61
	.long	0x111
	.byte	0x28
	.uleb128 0x9
	.secrel32	.LASF1
	.byte	0x2
	.byte	0x62
	.long	0x126
	.byte	0x30
	.uleb128 0x8
	.ascii "Callback\0"
	.byte	0x2
	.byte	0x63
	.long	0x1d8
	.byte	0x38
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x64
	.long	0x326
	.byte	0x40
	.uleb128 0x8
	.ascii "Next\0"
	.byte	0x2
	.byte	0x65
	.long	0x32b
	.byte	0x48
	.byte	0
	.uleb128 0x6
	.long	0x264
	.uleb128 0xb
	.byte	0x8
	.long	0x331
	.uleb128 0x6
	.long	0x278
	.uleb128 0x7
	.byte	0x10
	.byte	0x2
	.byte	0x69
	.long	0x35d
	.uleb128 0x9
	.secrel32	.LASF2
	.byte	0x2
	.byte	0x6a
	.long	0x32b
	.byte	0
	.uleb128 0x8
	.ascii "QueueData\0"
	.byte	0x2
	.byte	0x6b
	.long	0x1c6
	.byte	0x8
	.byte	0
	.uleb128 0x5
	.ascii "qQueueStack_t\0"
	.byte	0x2
	.byte	0x6c
	.long	0x336
	.uleb128 0x7
	.byte	0x4
	.byte	0x2
	.byte	0x6e
	.long	0x3c5
	.uleb128 0x8
	.ascii "Init\0"
	.byte	0x2
	.byte	0x6f
	.long	0x139
	.byte	0
	.uleb128 0x8
	.ascii "FCallIdle\0"
	.byte	0x2
	.byte	0x70
	.long	0x139
	.byte	0x1
	.uleb128 0x8
	.ascii "ReleaseSched\0"
	.byte	0x2
	.byte	0x71
	.long	0x139
	.byte	0x2
	.uleb128 0x8
	.ascii "FCallReleased\0"
	.byte	0x2
	.byte	0x72
	.long	0x139
	.byte	0x3
	.byte	0
	.uleb128 0x5
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x2
	.byte	0x73
	.long	0x372
	.uleb128 0x7
	.byte	0x60
	.byte	0x2
	.byte	0x76
	.long	0x4ae
	.uleb128 0x8
	.ascii "IDLECallback\0"
	.byte	0x2
	.byte	0x77
	.long	0x1d8
	.byte	0
	.uleb128 0x8
	.ascii "ReleaseSchedCallback\0"
	.byte	0x2
	.byte	0x78
	.long	0x1d8
	.byte	0x8
	.uleb128 0x8
	.ascii "Tick\0"
	.byte	0x2
	.byte	0x79
	.long	0xe4
	.byte	0x10
	.uleb128 0x8
	.ascii "EventInfo\0"
	.byte	0x2
	.byte	0x7a
	.long	0x1c8
	.byte	0x18
	.uleb128 0x8
	.ascii "First\0"
	.byte	0x2
	.byte	0x7b
	.long	0x32b
	.byte	0x38
	.uleb128 0x8
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x7c
	.long	0x4ae
	.byte	0x40
	.uleb128 0x8
	.ascii "QueueStack\0"
	.byte	0x2
	.byte	0x7d
	.long	0x4b3
	.byte	0x48
	.uleb128 0x8
	.ascii "QueueSize\0"
	.byte	0x2
	.byte	0x7e
	.long	0x139
	.byte	0x50
	.uleb128 0x8
	.ascii "QueueIndex\0"
	.byte	0x2
	.byte	0x7e
	.long	0x139
	.byte	0x51
	.uleb128 0x8
	.ascii "NotSafeQueue\0"
	.byte	0x2
	.byte	0x7f
	.long	0x25f
	.byte	0x52
	.uleb128 0x8
	.ascii "epochs\0"
	.byte	0x2
	.byte	0x81
	.long	0xfc
	.byte	0x58
	.byte	0
	.uleb128 0x6
	.long	0x3c5
	.uleb128 0xb
	.byte	0x8
	.long	0x4b9
	.uleb128 0x6
	.long	0x35d
	.uleb128 0x5
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x2
	.byte	0x83
	.long	0x3dd
	.uleb128 0xf
	.ascii "state\0"
	.byte	0x4
	.byte	0x2
	.byte	0xb4
	.long	0x510
	.uleb128 0x4
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0x4
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x5
	.ascii "qSM_Status_t\0"
	.byte	0x2
	.byte	0xb4
	.long	0x4d7
	.uleb128 0xe
	.ascii "_qSM_t\0"
	.byte	0x20
	.byte	0x2
	.byte	0xb6
	.long	0x585
	.uleb128 0x8
	.ascii "NextState\0"
	.byte	0x2
	.byte	0xb7
	.long	0x59f
	.byte	0
	.uleb128 0x8
	.ascii "PreviousState\0"
	.byte	0x2
	.byte	0xb8
	.long	0x59f
	.byte	0x8
	.uleb128 0x8
	.ascii "PreviousReturnStatus\0"
	.byte	0x2
	.byte	0xb9
	.long	0x510
	.byte	0x10
	.uleb128 0x9
	.secrel32	.LASF0
	.byte	0x2
	.byte	0xba
	.long	0x1c6
	.byte	0x18
	.byte	0
	.uleb128 0x10
	.long	0x510
	.long	0x594
	.uleb128 0xd
	.long	0x594
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x59a
	.uleb128 0x6
	.long	0x524
	.uleb128 0xb
	.byte	0x8
	.long	0x585
	.uleb128 0x5
	.ascii "qSM_State_t\0"
	.byte	0x2
	.byte	0xbe
	.long	0x59f
	.uleb128 0x7
	.byte	0x18
	.byte	0x2
	.byte	0xd3
	.long	0x5e5
	.uleb128 0x8
	.ascii "SR\0"
	.byte	0x2
	.byte	0xd4
	.long	0x139
	.byte	0
	.uleb128 0x8
	.ascii "Start\0"
	.byte	0x2
	.byte	0xd5
	.long	0xfc
	.byte	0x8
	.uleb128 0x8
	.ascii "TV\0"
	.byte	0x2
	.byte	0xd6
	.long	0xfc
	.byte	0x10
	.byte	0
	.uleb128 0x5
	.ascii "qSTimer_t\0"
	.byte	0x2
	.byte	0xd7
	.long	0x5b8
	.uleb128 0x11
	.ascii "_qSendEvent\0"
	.byte	0x1
	.byte	0x22
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x638
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x22
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x22
	.long	0x1c6
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetTime\0"
	.byte	0x1
	.byte	0x27
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x678
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x27
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x27
	.long	0xe4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetIterations\0"
	.byte	0x1
	.byte	0x2b
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x6be
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2b
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x2b
	.long	0x14a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetPriority\0"
	.byte	0x1
	.byte	0x2f
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x702
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2f
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x2f
	.long	0x126
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetCallback\0"
	.byte	0x1
	.byte	0x34
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x746
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x34
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x34
	.long	0x1d8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qEnableDisable\0"
	.byte	0x1
	.byte	0x38
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x78c
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x38
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x38
	.long	0x139
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qSetUserData\0"
	.byte	0x1
	.byte	0x3e
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x7d0
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x3e
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "arg\0"
	.byte	0x1
	.byte	0x3e
	.long	0x1c6
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x11
	.ascii "_qClearTimeElapse\0"
	.byte	0x1
	.byte	0x42
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x80a
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x42
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x14
	.ascii "_qEnqueueTaskEvent\0"
	.byte	0x1
	.byte	0x46
	.long	0x82
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x8aa
	.uleb128 0x13
	.ascii "TasktoQueue\0"
	.byte	0x1
	.byte	0x46
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x46
	.long	0x1c6
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x15
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x4a
	.long	0x35d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x15
	.ascii "TaskFromQueue\0"
	.byte	0x1
	.byte	0x4e
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x15
	.ascii "PriorityValue\0"
	.byte	0x1
	.byte	0x4f
	.long	0x126
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x15
	.ascii "i\0"
	.byte	0x1
	.byte	0x62
	.long	0x139
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x16
	.ascii "_qDequeueTaskEvent\0"
	.byte	0x1
	.byte	0x72
	.long	0x32b
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x8f5
	.uleb128 0x15
	.ascii "i\0"
	.byte	0x1
	.byte	0x73
	.long	0x82
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x74
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x11
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0x92
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x97d
	.uleb128 0x13
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0x92
	.long	0xe4
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0x92
	.long	0x1d8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x13
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x92
	.long	0x4b3
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x13
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x92
	.long	0x139
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x15
	.ascii "i\0"
	.byte	0x1
	.byte	0x93
	.long	0x139
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x11
	.ascii "_qISRHandler\0"
	.byte	0x1
	.byte	0xa5
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x9b2
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xa7
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x14
	.ascii "_qCreateTask\0"
	.byte	0x1
	.byte	0xb8
	.long	0x82
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xa51
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xb8
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.secrel32	.LASF5
	.byte	0x1
	.byte	0xb8
	.long	0x1d8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x12
	.secrel32	.LASF1
	.byte	0x1
	.byte	0xb8
	.long	0x126
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x13
	.ascii "Time\0"
	.byte	0x1
	.byte	0xb8
	.long	0xe4
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x13
	.ascii "nExecutions\0"
	.byte	0x1
	.byte	0xb8
	.long	0x14a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x13
	.ascii "InitialState\0"
	.byte	0x1
	.byte	0xb8
	.long	0x15e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x13
	.ascii "arg\0"
	.byte	0x1
	.byte	0xb8
	.long	0x1c6
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x18
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.byte	0xc8
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xa98
	.uleb128 0x12
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xc8
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x13
	.ascii "Event\0"
	.byte	0x1
	.byte	0xc8
	.long	0xd2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.byte	0xd2
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xb15
	.uleb128 0x15
	.ascii "a\0"
	.byte	0x1
	.byte	0xd3
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x15
	.ascii "b\0"
	.byte	0x1
	.byte	0xd3
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x15
	.ascii "c\0"
	.byte	0x1
	.byte	0xd3
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x15
	.ascii "e\0"
	.byte	0x1
	.byte	0xd3
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x15
	.ascii "tmp\0"
	.byte	0x1
	.byte	0xd3
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x15
	.ascii "head\0"
	.byte	0x1
	.byte	0xd4
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x1a
	.ascii "_qStart\0"
	.byte	0x1
	.byte	0xeb
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xb8c
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xec
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x15
	.ascii "qTask\0"
	.byte	0x1
	.byte	0xec
	.long	0x32b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1b
	.ascii "pMainSchedule\0"
	.byte	0x1
	.byte	0xed
	.quad	.L64
	.uleb128 0x1c
	.ascii "pReleasedSchedule\0"
	.byte	0x1
	.word	0x10a
	.quad	.L66
	.byte	0
	.uleb128 0x1d
	.ascii "_qStateMachine_Init\0"
	.byte	0x1
	.word	0x113
	.long	0x82
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xc2e
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x113
	.long	0x594
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "InitState\0"
	.byte	0x1
	.word	0x113
	.long	0x5a5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.ascii "SuccessState\0"
	.byte	0x1
	.word	0x113
	.long	0x5a5
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1e
	.ascii "FailureState\0"
	.byte	0x1
	.word	0x113
	.long	0x5a5
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1e
	.ascii "UnexpectedState\0"
	.byte	0x1
	.word	0x113
	.long	0x5a5
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0x1f
	.ascii "_qStateMachine_Run\0"
	.byte	0x1
	.word	0x11d
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xc8a
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x11d
	.long	0x594
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.secrel32	.LASF0
	.byte	0x1
	.word	0x11d
	.long	0x1c6
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x21
	.ascii "prev\0"
	.byte	0x1
	.word	0x11e
	.long	0x5a5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1d
	.ascii "_qSTimerSet\0"
	.byte	0x1
	.word	0x136
	.long	0x82
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0xcd4
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x136
	.long	0xcd4
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "Time\0"
	.byte	0x1
	.word	0x136
	.long	0xe4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x5e5
	.uleb128 0x1d
	.ascii "_qSTimerExpired\0"
	.byte	0x1
	.word	0x13e
	.long	0x139
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0xd18
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x13e
	.long	0xcd4
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "__qSM_Failure\0"
	.byte	0x1
	.byte	0x1c
	.long	0x59f
	.uleb128 0x9
	.byte	0x3
	.quad	__qSM_Failure
	.uleb128 0x15
	.ascii "__qSM_Success\0"
	.byte	0x1
	.byte	0x1d
	.long	0x59f
	.uleb128 0x9
	.byte	0x3
	.quad	__qSM_Success
	.uleb128 0x15
	.ascii "__qSM_Unexpected\0"
	.byte	0x1
	.byte	0x1e
	.long	0x59f
	.uleb128 0x9
	.byte	0x3
	.quad	__qSM_Unexpected
	.uleb128 0x22
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x16
	.long	0xd91
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0x6
	.long	0x4be
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
	.uleb128 0x4
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
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
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
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
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
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
