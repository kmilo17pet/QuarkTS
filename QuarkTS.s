	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 104, 6
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
	movb	$1, 49(%rax)
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
	movb	$0, 80(%rax)
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
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L7
	.loc 1 49 0
	jmp	.L6
.L7:
	.loc 1 50 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 50(%rax)
	.loc 1 51 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
.L6:
	.loc 1 52 0
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
	.globl	_qClearTimeElapsed
	.def	_qClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	_qClearTimeElapsed
_qClearTimeElapsed:
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
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 60 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.seh_endproc
	.globl	_qPrioQueueInsert
	.def	_qPrioQueueInsert;	.scl	2;	.type	32;	.endef
	.seh_proc	_qPrioQueueInsert
_qPrioQueueInsert:
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
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	.loc 1 63 0
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	movswl	%ax, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jl	.L12
	.loc 1 63 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L14
.L12:
	.loc 1 65 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 66 0
	movq	24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 67 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rcx
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	addl	$1, %eax
	leaq	QUARKTS(%rip), %rdx
	movw	%ax, 98(%rdx)
	movswq	%ax, %rax
	salq	$4, %rax
	addq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 68 0
	movl	$0, %eax
.L14:
	.loc 1 69 0 discriminator 1
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.def	_qPrioQueueExtract;	.scl	3;	.type	32;	.endef
	.seh_proc	_qPrioQueueExtract
_qPrioQueueExtract:
.LFB9:
	.loc 1 71 0
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
	movq	$0, -16(%rbp)
	.loc 1 74 0
	movb	$0, -2(%rbp)
	.loc 1 75 0
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	testw	%ax, %ax
	jns	.L16
	.loc 1 75 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L17
.L16:
	.loc 1 76 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L18
	.loc 1 76 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
.L18:
	.loc 1 77 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	movb	%al, -3(%rbp)
	.loc 1 78 0
	movb	$1, -1(%rbp)
	jmp	.L19
.L23:
	.loc 1 79 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L20
	jmp	.L21
.L20:
	.loc 1 80 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	cmpb	-3(%rbp), %al
	jbe	.L22
	.loc 1 81 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	movb	%al, -3(%rbp)
	.loc 1 82 0
	movzbl	-1(%rbp), %eax
	movb	%al, -2(%rbp)
.L22:
	.loc 1 78 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L19:
	.loc 1 78 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L23
.L21:
	.loc 1 85 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 86 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 87 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 88 0
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	jmp	.L24
.L25:
	.loc 1 88 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	addq	$1, %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L24:
	.loc 1 88 0 discriminator 1
	movzbl	-1(%rbp), %edx
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	cwtl
	cmpl	%eax, %edx
	jl	.L25
	.loc 1 89 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	subl	$1, %eax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movw	%dx, 98(%rax)
	.loc 1 90 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L26
	.loc 1 90 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	call	*%rax
.L26:
	.loc 1 91 0 is_stmt 1
	movq	-16(%rbp), %rax
.L17:
	.loc 1 92 0
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
	.loc 1 94 0
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
	.loc 1 95 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 96 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 97 0
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
	.loc 1 99 0
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
	.loc 1 101 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 56(%rax)
	.loc 1 102 0
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 16(%rdx)
	.loc 1 103 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 104 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 8(%rax)
	.loc 1 105 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 88(%rax)
	.loc 1 106 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 96(%rax)
	.loc 1 107 0
	movb	$0, -1(%rbp)
	jmp	.L29
.L30:
	.loc 1 107 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L29:
	.loc 1 107 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L30
	.loc 1 108 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movw	$-1, 98(%rax)
	.loc 1 109 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 110 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 111 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 83(%rax)
	.loc 1 112 0
	movl	$0, %eax
	leaq	QUARKTS(%rip), %rdx
	movq	%rax, 64(%rdx)
	leaq	QUARKTS(%rip), %rdx
	movq	%rax, 72(%rdx)
	.loc 1 114 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 100(%rax)
	.loc 1 116 0
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
	.loc 1 118 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 119 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 100(%rax)
	.loc 1 120 0
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
	.loc 1 122 0
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
	.loc 1 123 0
	movss	40(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L33
	.loc 1 123 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L35
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L35
.L33:
	.loc 1 123 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L36
.L35:
	.loc 1 123 0 discriminator 5
	movl	$-1, %eax
	jmp	.L37
.L36:
	.loc 1 124 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 125 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 126 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 127 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 128 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 129 0
	movl	$0, %eax
	movq	16(%rbp), %rdx
	movb	%al, 48(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 49(%rdx)
	.loc 1 130 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 50(%rax)
	.loc 1 131 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 132 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 133 0
	movq	16(%rbp), %rax
	movl	$0, 28(%rax)
	.loc 1 134 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 135 0
	movl	$0, %eax
.L37:
	.loc 1 136 0
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
	.loc 1 138 0
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
	.loc 1 139 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 24(%rax)
	.loc 1 140 0
	movq	16(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 141 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 142 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L40
	.loc 1 142 0 is_stmt 0 discriminator 1
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
.L40:
	.loc 1 143 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 48(%rax)
	.loc 1 144 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 40(%rax)
	.loc 1 145 0
	movq	16(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 28(%rax)
	.loc 1 146 0
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
	.loc 1 148 0
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
	.loc 1 149 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 150 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 151 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L42
	.loc 1 151 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
.L42:
	.loc 1 152 0 is_stmt 1
	jmp	.L43
.L50:
	.loc 1 153 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 154 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 155 0
	jmp	.L44
.L49:
	.loc 1 156 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	%al, %dl
	jnb	.L45
	.loc 1 157 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 158 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 159 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L46
	.loc 1 159 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L47
.L46:
	.loc 1 160 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L47:
	.loc 1 161 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 162 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L48
.L45:
	.loc 1 165 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 166 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L48:
	.loc 1 168 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 169 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L44
	.loc 1 169 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L44:
	.loc 1 155 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L49
.L43:
	.loc 1 152 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L50
	.loc 1 172 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L41
	.loc 1 172 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	call	*%rax
	nop
.L41:
	.loc 1 173 0 is_stmt 1
	addq	$80, %rsp
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
	.loc 1 175 0
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
.L53:
	.loc 1 178 0
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	je	.L54
	nop
.L55:
	.loc 1 207 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 208 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 209 0
	leaq	QUARKTS(%rip), %rax
	movzbl	83(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 210 0
	leaq	QUARKTS(%rip), %rax
	movl	$3, 24(%rax)
	.loc 1 211 0
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L70
	jmp	.L71
.L54:
	.loc 1 179 0
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	testb	%al, %al
	jne	.L56
	.loc 1 180 0
	call	_qTaskChainbyPriority
	.loc 1 181 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 80(%rax)
.L56:
	.loc 1 183 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 184 0
	jmp	.L57
.L69:
	.loc 1 185 0
	call	_qPrioQueueExtract
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L58
	.loc 1 185 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L58:
	.loc 1 186 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	-8(%rbp), %rax
	movl	20(%rax), %eax
	subl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	%eax, %edx
	jnb	.L59
	.loc 1 186 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L60
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L61
.L60:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L61:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L62
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L62
.L59:
	.loc 1 186 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L64
	.loc 1 186 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	jne	.L62
.L64:
	.loc 1 186 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L62
	.loc 1 187 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 188 0
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	je	.L65
	.loc 1 188 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 24(%rax)
.L65:
	.loc 1 189 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L66
	.loc 1 189 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
.L66:
	.loc 1 190 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L67
.L62:
	.loc 1 192 0
	movq	-8(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	je	.L68
	.loc 1 193 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 194 0
	movq	-8(%rbp), %rax
	movb	$0, 49(%rax)
	.loc 1 195 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L67
.L68:
	.loc 1 197 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L67
	.loc 1 198 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 199 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 24(%rax)
	.loc 1 200 0
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
	.loc 1 201 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
.L67:
	.loc 1 203 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L57:
	.loc 1 184 0
	cmpq	$0, -8(%rbp)
	jne	.L69
	.loc 1 205 0
	jmp	.L53
.L71:
	.loc 1 211 0 discriminator 1
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
.L70:
	.loc 1 212 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 213 0
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
	.loc 1 215 0
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
	.loc 1 216 0
	cmpq	$0, 24(%rbp)
	jne	.L73
	.loc 1 216 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L74
.L73:
	.loc 1 217 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 218 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 219 0
	movq	16(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 32(%rax)
	.loc 1 220 0
	movq	16(%rbp), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 221 0
	movq	16(%rbp), %rax
	movq	48(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 222 0
	movl	$0, %eax
.L74:
	.loc 1 223 0
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
	.loc 1 225 0
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
	.loc 1 226 0
	movq	$0, -8(%rbp)
	.loc 1 227 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 228 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L76
	.loc 1 229 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 20(%rax)
	.loc 1 230 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 231 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 232 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L77
.L76:
	.loc 1 234 0
	movq	16(%rbp), %rax
	movl	$-32767, 16(%rax)
.L77:
	.loc 1 236 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$-32768, %eax
	je	.L79
	cmpl	$-32767, %eax
	jne	.L85
	.loc 1 238 0
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	testq	%rax, %rax
	je	.L81
	.loc 1 238 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 239 0 is_stmt 1 discriminator 1
	jmp	.L75
.L81:
	.loc 1 239 0 is_stmt 0
	jmp	.L75
.L79:
	.loc 1 241 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L83
	.loc 1 241 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 242 0 is_stmt 1 discriminator 1
	jmp	.L75
.L83:
	.loc 1 242 0 is_stmt 0
	jmp	.L75
.L85:
	.loc 1 244 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	je	.L84
	.loc 1 244 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
.L84:
	.loc 1 245 0 is_stmt 1
	nop
.L75:
	.loc 1 247 0
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
	.loc 1 250 0
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
	.loc 1 251 0
	cmpb	$0, 32(%rbp)
	je	.L87
	.loc 1 251 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L87
	.loc 1 252 0 is_stmt 1
	movq	16(%rbp), %rcx
	call	_qSTimerExpired
	testb	%al, %al
	je	.L88
	.loc 1 253 0
	movq	16(%rbp), %rax
	movb	$0, (%rax)
	.loc 1 254 0
	movl	$1, %eax
	jmp	.L89
.L88:
	.loc 1 256 0
	movl	$0, %eax
	jmp	.L89
.L87:
	.loc 1 258 0
	cvtss2sd	24(%rbp), %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	ucomisd	%xmm1, %xmm0
	jbe	.L93
	.loc 1 258 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L89
.L93:
	.loc 1 259 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 8(%rax)
	.loc 1 260 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 4(%rax)
	.loc 1 261 0
	movq	16(%rbp), %rax
	movb	$1, (%rax)
	.loc 1 262 0
	movl	$0, %eax
.L89:
	.loc 1 263 0
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
	.loc 1 266 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L95
	.loc 1 266 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L96
.L95:
	.loc 1 267 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	%eax, %edx
	setnb	%al
.L96:
	.loc 1 268 0
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
	.loc 1 270 0
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
	.loc 1 271 0
	leaq	QUARKTS(%rip), %rax
	movl	100(%rax), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	.loc 1 272 0
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
	.loc 1 274 0
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
	.loc 1 275 0
	movq	16(%rbp), %rcx
	call	_qSTimerElapsed
	movl	%eax, -4(%rbp)
	.loc 1 276 0
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L100
	.loc 1 276 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	-4(%rbp), %eax
	jnb	.L101
.L100:
	.loc 1 276 0 discriminator 3
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	jmp	.L102
.L101:
	.loc 1 276 0 discriminator 4
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	subl	-4(%rbp), %eax
.L102:
	.loc 1 277 0 is_stmt 1 discriminator 6
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
	.long	0xf33
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
	.uleb128 0x3
	.ascii "__int16_t\0"
	.byte	0x2
	.byte	0x29
	.long	0xc4
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
	.long	0x100
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
	.ascii "int16_t\0"
	.byte	0x3
	.byte	0x19
	.long	0xb3
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x20
	.long	0xee
	.uleb128 0x4
	.byte	0x4
	.byte	0x4
	.byte	0x37
	.long	0x1a8
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
	.byte	0x37
	.long	0x15f
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x4
	.byte	0x38
	.long	0x1c9
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x4
	.byte	0x39
	.long	0x14f
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x4
	.byte	0x3a
	.long	0x131
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x4
	.byte	0x3b
	.long	0x131
	.uleb128 0x3
	.ascii "qState_t\0"
	.byte	0x4
	.byte	0x3c
	.long	0x131
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x4
	.byte	0x3d
	.long	0x131
	.uleb128 0x6
	.byte	0x20
	.byte	0x4
	.byte	0x4b
	.long	0x271
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x4
	.byte	0x5e
	.long	0x1a8
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x62
	.long	0x271
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x4
	.byte	0x66
	.long	0x271
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x4
	.byte	0x6b
	.long	0x219
	.byte	0x18
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x4
	.byte	0x6c
	.long	0x228
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x4
	.byte	0x6e
	.long	0x295
	.uleb128 0xa
	.byte	0x8
	.long	0x29b
	.uleb128 0xb
	.long	0x2a6
	.uleb128 0xc
	.long	0x273
	.byte	0
	.uleb128 0x6
	.byte	0x3
	.byte	0x4
	.byte	0x6f
	.long	0x2e1
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x4
	.byte	0x70
	.long	0x2e1
	.byte	0
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x4
	.byte	0x70
	.long	0x2e1
	.byte	0x1
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x4
	.byte	0x70
	.long	0x2e1
	.byte	0x2
	.byte	0
	.uleb128 0xd
	.long	0x131
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x4
	.byte	0x71
	.long	0x2a6
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x4
	.byte	0x75
	.long	0x3a7
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x76
	.long	0x271
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x4
	.byte	0x76
	.long	0x271
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x4
	.byte	0x77
	.long	0x3a7
	.byte	0x10
	.uleb128 0x7
	.ascii "ClockStart\0"
	.byte	0x4
	.byte	0x77
	.long	0x3a7
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x4
	.byte	0x78
	.long	0x1f5
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x4
	.byte	0x79
	.long	0x14f
	.byte	0x1c
	.uleb128 0x8
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x7a
	.long	0x1e2
	.byte	0x20
	.uleb128 0x7
	.ascii "Callback\0"
	.byte	0x4
	.byte	0x7b
	.long	0x283
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x7c
	.long	0x3ac
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x4
	.byte	0x7d
	.long	0x3b1
	.byte	0x38
	.byte	0
	.uleb128 0xd
	.long	0x1d2
	.uleb128 0xd
	.long	0x2e6
	.uleb128 0xa
	.byte	0x8
	.long	0x3b7
	.uleb128 0xd
	.long	0x2fa
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0x81
	.long	0x3e3
	.uleb128 0x8
	.secrel32	.LASF2
	.byte	0x4
	.byte	0x82
	.long	0x3b1
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x4
	.byte	0x83
	.long	0x271
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x4
	.byte	0x84
	.long	0x3bc
	.uleb128 0x6
	.byte	0x4
	.byte	0x4
	.byte	0x86
	.long	0x44b
	.uleb128 0x7
	.ascii "Init\0"
	.byte	0x4
	.byte	0x87
	.long	0x131
	.byte	0
	.uleb128 0x7
	.ascii "FCallIdle\0"
	.byte	0x4
	.byte	0x87
	.long	0x131
	.byte	0x1
	.uleb128 0x7
	.ascii "ReleaseSched\0"
	.byte	0x4
	.byte	0x87
	.long	0x131
	.byte	0x2
	.uleb128 0x7
	.ascii "FCallReleased\0"
	.byte	0x4
	.byte	0x87
	.long	0x131
	.byte	0x3
	.byte	0
	.uleb128 0x3
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x4
	.byte	0x88
	.long	0x3f8
	.uleb128 0x6
	.byte	0x68
	.byte	0x4
	.byte	0x8a
	.long	0x543
	.uleb128 0x7
	.ascii "IDLECallback\0"
	.byte	0x4
	.byte	0x8b
	.long	0x283
	.byte	0
	.uleb128 0x7
	.ascii "ReleaseSchedCallback\0"
	.byte	0x4
	.byte	0x8c
	.long	0x283
	.byte	0x8
	.uleb128 0x7
	.ascii "Tick\0"
	.byte	0x4
	.byte	0x8d
	.long	0x1ba
	.byte	0x10
	.uleb128 0x7
	.ascii "EventInfo\0"
	.byte	0x4
	.byte	0x8e
	.long	0x273
	.byte	0x18
	.uleb128 0x7
	.ascii "First\0"
	.byte	0x4
	.byte	0x8f
	.long	0x3b1
	.byte	0x38
	.uleb128 0x7
	.ascii "I_Disable\0"
	.byte	0x4
	.byte	0x90
	.long	0x544
	.byte	0x40
	.uleb128 0x7
	.ascii "I_Enabler\0"
	.byte	0x4
	.byte	0x91
	.long	0x544
	.byte	0x48
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x92
	.long	0x54a
	.byte	0x50
	.uleb128 0x7
	.ascii "QueueStack\0"
	.byte	0x4
	.byte	0x93
	.long	0x54f
	.byte	0x58
	.uleb128 0x7
	.ascii "QueueSize\0"
	.byte	0x4
	.byte	0x94
	.long	0x131
	.byte	0x60
	.uleb128 0x7
	.ascii "QueueIndex\0"
	.byte	0x4
	.byte	0x95
	.long	0x140
	.byte	0x62
	.uleb128 0x7
	.ascii "epochs\0"
	.byte	0x4
	.byte	0x97
	.long	0x3a7
	.byte	0x64
	.byte	0
	.uleb128 0xf
	.uleb128 0xa
	.byte	0x8
	.long	0x543
	.uleb128 0xd
	.long	0x44b
	.uleb128 0xa
	.byte	0x8
	.long	0x555
	.uleb128 0xd
	.long	0x3e3
	.uleb128 0x3
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x4
	.byte	0x99
	.long	0x463
	.uleb128 0x10
	.ascii "state\0"
	.byte	0x4
	.byte	0x4
	.word	0x1df
	.long	0x5ad
	.uleb128 0x5
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0x5
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x11
	.ascii "qSM_Status_t\0"
	.byte	0x4
	.word	0x1df
	.long	0x573
	.uleb128 0x12
	.byte	0x18
	.byte	0x4
	.word	0x1f8
	.long	0x608
	.uleb128 0x13
	.ascii "__Failure\0"
	.byte	0x4
	.word	0x1f9
	.long	0x6aa
	.byte	0
	.uleb128 0x13
	.ascii "__Success\0"
	.byte	0x4
	.word	0x1fa
	.long	0x6aa
	.byte	0x8
	.uleb128 0x13
	.ascii "__Unexpected\0"
	.byte	0x4
	.word	0x1fb
	.long	0x6aa
	.byte	0x10
	.byte	0
	.uleb128 0xb
	.long	0x613
	.uleb128 0xc
	.long	0x613
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x619
	.uleb128 0xd
	.long	0x61e
	.uleb128 0x14
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x4
	.word	0x1e3
	.long	0x6aa
	.uleb128 0x13
	.ascii "NextState\0"
	.byte	0x4
	.word	0x1e7
	.long	0x6bf
	.byte	0
	.uleb128 0x13
	.ascii "PreviousState\0"
	.byte	0x4
	.word	0x1eb
	.long	0x6bf
	.byte	0x8
	.uleb128 0x13
	.ascii "PreviousReturnStatus\0"
	.byte	0x4
	.word	0x1ef
	.long	0x5ad
	.byte	0x10
	.uleb128 0x13
	.ascii "StateJustChanged\0"
	.byte	0x4
	.word	0x1f3
	.long	0x219
	.byte	0x14
	.uleb128 0x13
	.ascii "Data\0"
	.byte	0x4
	.word	0x1f7
	.long	0x271
	.byte	0x18
	.uleb128 0x13
	.ascii "_\0"
	.byte	0x4
	.word	0x1fc
	.long	0x5c2
	.byte	0x20
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x608
	.uleb128 0x15
	.long	0x5ad
	.long	0x6bf
	.uleb128 0xc
	.long	0x613
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x6b0
	.uleb128 0x11
	.ascii "qSM_State_t\0"
	.byte	0x4
	.word	0x1fe
	.long	0x6bf
	.uleb128 0x11
	.ascii "qSM_ExState_t\0"
	.byte	0x4
	.word	0x1ff
	.long	0x6aa
	.uleb128 0x12
	.byte	0xc
	.byte	0x4
	.word	0x25d
	.long	0x720
	.uleb128 0x13
	.ascii "SR\0"
	.byte	0x4
	.word	0x25e
	.long	0x131
	.byte	0
	.uleb128 0x13
	.ascii "Start\0"
	.byte	0x4
	.word	0x25f
	.long	0x1d2
	.byte	0x4
	.uleb128 0x13
	.ascii "TV\0"
	.byte	0x4
	.word	0x25f
	.long	0x1d2
	.byte	0x8
	.byte	0
	.uleb128 0x11
	.ascii "qSTimer_t\0"
	.byte	0x4
	.word	0x260
	.long	0x6ef
	.uleb128 0x16
	.ascii "_qSendEvent\0"
	.byte	0x1
	.byte	0x1a
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x774
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1a
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x1a
	.long	0x271
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x16
	.ascii "_qSetTime\0"
	.byte	0x1
	.byte	0x1f
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x7b4
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1f
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x1f
	.long	0x1ba
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x16
	.ascii "_qSetIterations\0"
	.byte	0x1
	.byte	0x23
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x7fa
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x23
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x23
	.long	0x1f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x16
	.ascii "_qSetPriority\0"
	.byte	0x1
	.byte	0x27
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x83e
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x27
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x27
	.long	0x1e2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x16
	.ascii "_qSetCallback\0"
	.byte	0x1
	.byte	0x2c
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x882
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2c
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x2c
	.long	0x283
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x16
	.ascii "_qEnableDisable\0"
	.byte	0x1
	.byte	0x30
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x8c8
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x30
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x30
	.long	0x219
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x16
	.ascii "_qSetUserData\0"
	.byte	0x1
	.byte	0x36
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x90c
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x36
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "arg\0"
	.byte	0x1
	.byte	0x36
	.long	0x271
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x16
	.ascii "_qClearTimeElapsed\0"
	.byte	0x1
	.byte	0x3a
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x947
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x3a
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "_qPrioQueueInsert\0"
	.byte	0x1
	.byte	0x3e
	.long	0xe7
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x9aa
	.uleb128 0x18
	.ascii "TasktoQueue\0"
	.byte	0x1
	.byte	0x3e
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x3e
	.long	0x271
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1a
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x40
	.long	0x3e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1b
	.ascii "_qPrioQueueExtract\0"
	.byte	0x1
	.byte	0x47
	.long	0x3b1
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xa26
	.uleb128 0x1c
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x48
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.ascii "i\0"
	.byte	0x1
	.byte	0x49
	.long	0x131
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1a
	.ascii "IndexTaskToExtract\0"
	.byte	0x1
	.byte	0x4a
	.long	0x131
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1a
	.ascii "MaxpValue\0"
	.byte	0x1
	.byte	0x4d
	.long	0x1e2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.byte	0
	.uleb128 0x16
	.ascii "_qSetInterruptsED\0"
	.byte	0x1
	.byte	0x5e
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xa77
	.uleb128 0x18
	.ascii "Enabler\0"
	.byte	0x1
	.byte	0x5e
	.long	0x544
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "Disabler\0"
	.byte	0x1
	.byte	0x5e
	.long	0x544
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x16
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0x63
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xaff
	.uleb128 0x18
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0x63
	.long	0x1ba
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0x63
	.long	0x283
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x18
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x63
	.long	0x54f
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x18
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x63
	.long	0x131
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1a
	.ascii "i\0"
	.byte	0x1
	.byte	0x64
	.long	0x131
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x1d
	.ascii "_qISRHandler\0"
	.byte	0x1
	.byte	0x76
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x19
	.ascii "_qCreateTask\0"
	.byte	0x1
	.byte	0x7a
	.long	0xe7
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xbc0
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x7a
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x7a
	.long	0x283
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x17
	.secrel32	.LASF1
	.byte	0x1
	.byte	0x7a
	.long	0x1e2
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x18
	.ascii "Time\0"
	.byte	0x1
	.byte	0x7a
	.long	0x1ba
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x18
	.ascii "nExecutions\0"
	.byte	0x1
	.byte	0x7a
	.long	0x1f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x18
	.ascii "InitialState\0"
	.byte	0x1
	.byte	0x7a
	.long	0x209
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.ascii "arg\0"
	.byte	0x1
	.byte	0x7a
	.long	0x271
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x1e
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.byte	0x8a
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xc07
	.uleb128 0x17
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x8a
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "Event\0"
	.byte	0x1
	.byte	0x8a
	.long	0x1a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1e
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.byte	0x94
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xc84
	.uleb128 0x1a
	.ascii "a\0"
	.byte	0x1
	.byte	0x95
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.ascii "b\0"
	.byte	0x1
	.byte	0x95
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.ascii "c\0"
	.byte	0x1
	.byte	0x95
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1a
	.ascii "e\0"
	.byte	0x1
	.byte	0x95
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1a
	.ascii "tmp\0"
	.byte	0x1
	.byte	0x95
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1a
	.ascii "head\0"
	.byte	0x1
	.byte	0x96
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x1f
	.ascii "_qStart\0"
	.byte	0x1
	.byte	0xaf
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xcfa
	.uleb128 0x1c
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xb0
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.ascii "qTask\0"
	.byte	0x1
	.byte	0xb0
	.long	0x3b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x20
	.ascii "qMainSchedule\0"
	.byte	0x1
	.byte	0xb1
	.quad	.L53
	.uleb128 0x20
	.ascii "qReleasedSchedule\0"
	.byte	0x1
	.byte	0xce
	.quad	.L55
	.byte	0
	.uleb128 0x19
	.ascii "_qStateMachine_Init\0"
	.byte	0x1
	.byte	0xd7
	.long	0xe7
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xd96
	.uleb128 0x18
	.ascii "obj\0"
	.byte	0x1
	.byte	0xd7
	.long	0x613
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "InitState\0"
	.byte	0x1
	.byte	0xd7
	.long	0x6c5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x18
	.ascii "SuccessState\0"
	.byte	0x1
	.byte	0xd7
	.long	0x6d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x18
	.ascii "FailureState\0"
	.byte	0x1
	.byte	0xd7
	.long	0x6d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x18
	.ascii "UnexpectedState\0"
	.byte	0x1
	.byte	0xd7
	.long	0x6d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0x1f
	.ascii "_qStateMachine_Run\0"
	.byte	0x1
	.byte	0xe1
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0xdef
	.uleb128 0x18
	.ascii "obj\0"
	.byte	0x1
	.byte	0xe1
	.long	0x613
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "Data\0"
	.byte	0x1
	.byte	0xe1
	.long	0x271
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1a
	.ascii "prev\0"
	.byte	0x1
	.byte	0xe2
	.long	0x6c5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x21
	.ascii "_qSTimerSet\0"
	.byte	0x1
	.byte	0xfa
	.long	0xe7
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0xe43
	.uleb128 0x18
	.ascii "obj\0"
	.byte	0x1
	.byte	0xfa
	.long	0xe43
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "Time\0"
	.byte	0x1
	.byte	0xfa
	.long	0x1ba
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x18
	.ascii "fr\0"
	.byte	0x1
	.byte	0xfa
	.long	0x219
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x720
	.uleb128 0x22
	.ascii "_qSTimerExpired\0"
	.byte	0x1
	.word	0x109
	.long	0x219
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0xe87
	.uleb128 0x23
	.ascii "obj\0"
	.byte	0x1
	.word	0x109
	.long	0xe43
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x22
	.ascii "_qSTimerElapsed\0"
	.byte	0x1
	.word	0x10e
	.long	0x1d2
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0xec5
	.uleb128 0x23
	.ascii "obj\0"
	.byte	0x1
	.word	0x10e
	.long	0xe43
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x24
	.ascii "_qSTimerRemaining\0"
	.byte	0x1
	.word	0x112
	.long	0x1d2
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0xf18
	.uleb128 0x23
	.ascii "obj\0"
	.byte	0x1
	.word	0x112
	.long	0xe43
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x25
	.ascii "elapsed\0"
	.byte	0x1
	.word	0x113
	.long	0x1d2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x26
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x15
	.long	0xf31
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0xd
	.long	0x55a
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
	.uleb128 0x18
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
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
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
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
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
	.uleb128 0x1e
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
	.uleb128 0x22
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
	.uleb128 0x23
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
	.uleb128 0x24
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
