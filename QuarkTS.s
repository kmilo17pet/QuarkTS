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
	cmpb	$0, 24(%rbp)
	je	.L9
	.loc 1 52 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
.L9:
	.loc 1 53 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 51(%rax)
	.loc 1 54 0
	cmpb	$0, 24(%rbp)
	jne	.L8
	.loc 1 54 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
.L8:
	.loc 1 55 0 is_stmt 1
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
	.loc 1 57 0
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
	.loc 1 58 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 59 0
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
	.loc 1 61 0
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
	.loc 1 62 0
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
	.loc 1 63 0
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
	.loc 1 65 0
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
	.loc 1 66 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jle	.L14
	.loc 1 66 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L18
.L14:
	.loc 1 67 0 is_stmt 1
	nop
.L16:
	.loc 1 67 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	74(%rax), %eax
	testb	%al, %al
	jne	.L16
	.loc 1 68 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 74(%rax)
	.loc 1 70 0
	movq	16(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 71 0
	movq	24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 83 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	leaq	(%rdx,%rax), %rcx
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	.loc 1 86 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	leal	1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 73(%rax)
	.loc 1 87 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	cmpb	$1, %al
	jne	.L17
	.loc 1 88 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 74(%rax)
	.loc 1 89 0
	movl	$0, %eax
	jmp	.L18
.L17:
	.loc 1 104 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 74(%rax)
	.loc 1 105 0
	movl	$0, %eax
.L18:
	.loc 1 106 0 discriminator 1
	addq	$16, %rsp
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
	.loc 1 126 0
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
	.loc 1 128 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L20
	.loc 1 129 0
	nop
.L21:
	.loc 1 129 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	74(%rax), %eax
	testb	%al, %al
	jne	.L21
	.loc 1 130 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 131 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 132 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movq	$0, (%rax)
	.loc 1 133 0
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	testb	%al, %al
	je	.L22
	.loc 1 133 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	73(%rax), %eax
	leal	-1(%rax), %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 73(%rax)
.L22:
	.loc 1 134 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
	movzbl	%al, %eax
	salq	$4, %rax
	movq	%rax, %rcx
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	leaq	16(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movq	%rcx, %r8
	movq	%rax, %rcx
	call	memmove
	.loc 1 135 0
	movq	-8(%rbp), %rax
	jmp	.L23
.L20:
	.loc 1 137 0
	movl	$0, %eax
.L23:
	.loc 1 138 0
	addq	$48, %rsp
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
	.loc 1 141 0
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
	.loc 1 143 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 48(%rax)
	.loc 1 144 0
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 8(%rdx)
	.loc 1 145 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 146 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 147 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 72(%rax)
	.loc 1 148 0
	movb	$0, -1(%rbp)
	jmp	.L25
.L26:
	.loc 1 148 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L25:
	.loc 1 148 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	72(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L26
	.loc 1 149 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$0, 73(%rax)
	.loc 1 150 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 56(%rax)
	.loc 1 151 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 74(%rax)
	.loc 1 152 0
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
	.loc 1 154 0
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
	.loc 1 155 0
	leaq	QUARKTS(%rip), %rax
	movzbl	56(%rax), %eax
	testb	%al, %al
	jne	.L28
	jmp	.L27
.L28:
	.loc 1 156 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 157 0
	jmp	.L30
.L32:
	.loc 1 158 0
	movq	-8(%rbp), %rax
	movzbl	51(%rax), %eax
	testb	%al, %al
	je	.L31
	.loc 1 158 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L31
	.loc 1 159 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 24(%rax)
	.loc 1 160 0
	movq	-8(%rbp), %rax
	movq	24(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%rax, %rdx
	jb	.L31
	.loc 1 161 0
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 162 0
	movq	-8(%rbp), %rax
	movq	$0, 24(%rax)
.L31:
	.loc 1 165 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L30:
	.loc 1 157 0
	cmpq	$0, -8(%rbp)
	jne	.L32
.L27:
	.loc 1 167 0
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
	.loc 1 169 0
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
	.loc 1 170 0
	movss	40(%rbp), %xmm0
	movss	.LC1(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L34
	.loc 1 170 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L36
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L36
.L34:
	.loc 1 170 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L37
.L36:
	.loc 1 170 0 discriminator 5
	movl	$-1, %eax
	jmp	.L38
.L37:
	.loc 1 171 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 172 0
	movq	16(%rbp), %rax
	movq	$0, 24(%rax)
	.loc 1 173 0
	leaq	QUARKTS(%rip), %rax
	movss	8(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	ucomiss	.LC0(%rip), %xmm0
	jnb	.L39
	cvttss2siq	%xmm0, %rax
	jmp	.L40
.L39:
	movss	.LC0(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L40:
	movq	16(%rbp), %rdx
	movq	%rax, 16(%rdx)
	.loc 1 174 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 175 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 33(%rax)
	.loc 1 176 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 177 0
	movl	$0, %eax
	movq	16(%rbp), %rdx
	movb	%al, 48(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 49(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 50(%rdx)
	.loc 1 178 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 51(%rax)
	.loc 1 179 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 180 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 181 0
	movl	$0, %eax
.L38:
	.loc 1 182 0
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
	.loc 1 184 0
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
	.loc 1 185 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 16(%rax)
	.loc 1 186 0
	movq	16(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 187 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 24(%rax)
	.loc 1 188 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L43
	.loc 1 188 0 is_stmt 0 discriminator 1
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
.L43:
	.loc 1 189 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 49(%rax)
	.loc 1 190 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 32(%rax)
	.loc 1 191 0
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
	.loc 1 193 0
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
	.loc 1 194 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 195 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 196 0
	jmp	.L45
.L52:
	.loc 1 197 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 198 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 199 0
	jmp	.L46
.L51:
	.loc 1 200 0
	movq	-8(%rbp), %rax
	movzbl	33(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	33(%rax), %eax
	cmpb	%al, %dl
	jnb	.L47
	.loc 1 201 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 202 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 203 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L48
	.loc 1 203 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 48(%rax)
	jmp	.L49
.L48:
	.loc 1 204 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L49:
	.loc 1 205 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 206 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L50
.L47:
	.loc 1 209 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 210 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L50:
	.loc 1 212 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 213 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L46
	.loc 1 213 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L46:
	.loc 1 199 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L51
.L45:
	.loc 1 196 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L52
	.loc 1 216 0
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
	.loc 1 218 0
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
.L54:
	.loc 1 221 0
	leaq	QUARKTS(%rip), %rax
	movzbl	56(%rax), %eax
	testb	%al, %al
	jne	.L55
	.loc 1 222 0
	call	_qTaskChainbyPriority
	.loc 1 223 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 56(%rax)
.L55:
	.loc 1 225 0
	leaq	QUARKTS(%rip), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 226 0
	jmp	.L56
.L68:
	.loc 1 227 0
	call	_qDequeueTaskEvent
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L57
	.loc 1 227 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L57:
	.loc 1 228 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	jne	.L58
	.loc 1 228 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	js	.L59
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L60
.L59:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L60:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L61
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L61
.L58:
	.loc 1 228 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	jne	.L63
	.loc 1 228 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	$-1, %al
	jne	.L61
.L63:
	.loc 1 228 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	51(%rax), %eax
	testb	%al, %al
	je	.L61
	.loc 1 229 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	48(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 48(%rax)
	.loc 1 230 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	$-1, %al
	je	.L64
	.loc 1 230 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 32(%rax)
.L64:
	.loc 1 231 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	jne	.L65
	.loc 1 231 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 51(%rax)
.L65:
	.loc 1 232 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L66
.L61:
	.loc 1 234 0
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L67
	.loc 1 235 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 236 0
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
	.loc 1 237 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L66
.L67:
	.loc 1 239 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L66
	.loc 1 240 0
	leaq	QUARKTS(%rip), %rax
	movzbl	57(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 40(%rax)
	.loc 1 241 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 16(%rax)
	.loc 1 242 0
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
	.loc 1 243 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 57(%rax)
.L66:
	.loc 1 245 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L56:
	.loc 1 226 0
	cmpq	$0, -8(%rbp)
	jne	.L68
	.loc 1 247 0
	jmp	.L54
	.cfi_endproc
.LFE15:
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
	.long	0xa33
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
	.byte	0x8
	.byte	0x5
	.ascii "long int\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
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
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
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
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x4
	.byte	0x4
	.byte	0x2
	.byte	0x21
	.long	0x187
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
	.uleb128 0x6
	.ascii "qTrigger_t\0"
	.byte	0x2
	.byte	0x21
	.long	0x13e
	.uleb128 0x6
	.ascii "qTime_t\0"
	.byte	0x2
	.byte	0x22
	.long	0x1a8
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x6
	.ascii "qClock_t\0"
	.byte	0x2
	.byte	0x23
	.long	0x1c1
	.uleb128 0x7
	.long	0x8e
	.uleb128 0x6
	.ascii "qPriority_t\0"
	.byte	0x2
	.byte	0x24
	.long	0xc8
	.uleb128 0x6
	.ascii "qIteration_t\0"
	.byte	0x2
	.byte	0x25
	.long	0xc8
	.uleb128 0x6
	.ascii "qState_t\0"
	.byte	0x2
	.byte	0x26
	.long	0xc8
	.uleb128 0x6
	.ascii "qBool_t\0"
	.byte	0x2
	.byte	0x27
	.long	0xc8
	.uleb128 0x8
	.byte	0x20
	.byte	0x2
	.byte	0x34
	.long	0x255
	.uleb128 0x9
	.ascii "Trigger\0"
	.byte	0x2
	.byte	0x35
	.long	0x187
	.byte	0
	.uleb128 0xa
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x36
	.long	0xfd
	.byte	0x8
	.uleb128 0x9
	.ascii "EventData\0"
	.byte	0x2
	.byte	0x37
	.long	0xfd
	.byte	0x10
	.uleb128 0x9
	.ascii "FirstCall\0"
	.byte	0x2
	.byte	0x38
	.long	0x1fd
	.byte	0x18
	.byte	0
	.uleb128 0x6
	.ascii "qEvent_t\0"
	.byte	0x2
	.byte	0x39
	.long	0x20c
	.uleb128 0x6
	.ascii "qTaskFcn_t\0"
	.byte	0x2
	.byte	0x3b
	.long	0x277
	.uleb128 0xb
	.byte	0x8
	.long	0x27d
	.uleb128 0xc
	.long	0x288
	.uleb128 0xd
	.long	0x255
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.byte	0x2
	.byte	0x3d
	.long	0x2d6
	.uleb128 0x9
	.ascii "TimedTaskRun\0"
	.byte	0x2
	.byte	0x3e
	.long	0x2d6
	.byte	0
	.uleb128 0x9
	.ascii "InitFlag\0"
	.byte	0x2
	.byte	0x3f
	.long	0x2d6
	.byte	0x1
	.uleb128 0x9
	.ascii "AsyncRun\0"
	.byte	0x2
	.byte	0x40
	.long	0x2d6
	.byte	0x2
	.uleb128 0x9
	.ascii "State\0"
	.byte	0x2
	.byte	0x41
	.long	0x2d6
	.byte	0x3
	.byte	0
	.uleb128 0x7
	.long	0xc8
	.uleb128 0x6
	.ascii "qTaskFlags_t\0"
	.byte	0x2
	.byte	0x42
	.long	0x288
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x40
	.byte	0x2
	.byte	0x44
	.long	0x38e
	.uleb128 0xa
	.secrel32	.LASF0
	.byte	0x2
	.byte	0x45
	.long	0xfd
	.byte	0
	.uleb128 0x9
	.ascii "AsyncData\0"
	.byte	0x2
	.byte	0x45
	.long	0xfd
	.byte	0x8
	.uleb128 0x9
	.ascii "Interval\0"
	.byte	0x2
	.byte	0x46
	.long	0x1b1
	.byte	0x10
	.uleb128 0x9
	.ascii "TimeElapsed\0"
	.byte	0x2
	.byte	0x46
	.long	0x1b1
	.byte	0x18
	.uleb128 0x9
	.ascii "Iterations\0"
	.byte	0x2
	.byte	0x47
	.long	0x1d9
	.byte	0x20
	.uleb128 0xa
	.secrel32	.LASF1
	.byte	0x2
	.byte	0x48
	.long	0x1c6
	.byte	0x21
	.uleb128 0x9
	.ascii "Callback\0"
	.byte	0x2
	.byte	0x49
	.long	0x265
	.byte	0x28
	.uleb128 0x9
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x4a
	.long	0x38e
	.byte	0x30
	.uleb128 0x9
	.ascii "Next\0"
	.byte	0x2
	.byte	0x4b
	.long	0x393
	.byte	0x38
	.byte	0
	.uleb128 0x7
	.long	0x2db
	.uleb128 0xb
	.byte	0x8
	.long	0x399
	.uleb128 0x7
	.long	0x2ef
	.uleb128 0x8
	.byte	0x10
	.byte	0x2
	.byte	0x4f
	.long	0x3c5
	.uleb128 0xa
	.secrel32	.LASF2
	.byte	0x2
	.byte	0x50
	.long	0x393
	.byte	0
	.uleb128 0x9
	.ascii "QueueData\0"
	.byte	0x2
	.byte	0x51
	.long	0xfd
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.ascii "qQueueStack_t\0"
	.byte	0x2
	.byte	0x52
	.long	0x39e
	.uleb128 0x8
	.byte	0x2
	.byte	0x2
	.byte	0x54
	.long	0x402
	.uleb128 0x9
	.ascii "Init\0"
	.byte	0x2
	.byte	0x55
	.long	0xc8
	.byte	0
	.uleb128 0x9
	.ascii "FCallIdle\0"
	.byte	0x2
	.byte	0x56
	.long	0xc8
	.byte	0x1
	.byte	0
	.uleb128 0x6
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x2
	.byte	0x57
	.long	0x3da
	.uleb128 0x8
	.byte	0x50
	.byte	0x2
	.byte	0x59
	.long	0x4bf
	.uleb128 0x9
	.ascii "IDLECallback\0"
	.byte	0x2
	.byte	0x5a
	.long	0x265
	.byte	0
	.uleb128 0x9
	.ascii "Tick\0"
	.byte	0x2
	.byte	0x5b
	.long	0x199
	.byte	0x8
	.uleb128 0x9
	.ascii "EventInfo\0"
	.byte	0x2
	.byte	0x5c
	.long	0x255
	.byte	0x10
	.uleb128 0x9
	.ascii "First\0"
	.byte	0x2
	.byte	0x5d
	.long	0x393
	.byte	0x30
	.uleb128 0x9
	.ascii "Flag\0"
	.byte	0x2
	.byte	0x5e
	.long	0x4bf
	.byte	0x38
	.uleb128 0x9
	.ascii "QueueStack\0"
	.byte	0x2
	.byte	0x5f
	.long	0x4c4
	.byte	0x40
	.uleb128 0x9
	.ascii "QueueSize\0"
	.byte	0x2
	.byte	0x60
	.long	0xc8
	.byte	0x48
	.uleb128 0x9
	.ascii "QueueIndex\0"
	.byte	0x2
	.byte	0x60
	.long	0xc8
	.byte	0x49
	.uleb128 0x9
	.ascii "NotSafeQueue\0"
	.byte	0x2
	.byte	0x61
	.long	0x2d6
	.byte	0x4a
	.byte	0
	.uleb128 0x7
	.long	0x402
	.uleb128 0xb
	.byte	0x8
	.long	0x4ca
	.uleb128 0x7
	.long	0x3c5
	.uleb128 0x6
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x2
	.byte	0x62
	.long	0x41a
	.uleb128 0xf
	.ascii "_qSendEvent\0"
	.byte	0x1
	.byte	0x1d
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x52a
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1d
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x1d
	.long	0xfd
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
	.long	0x56a
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x22
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x22
	.long	0x199
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
	.long	0x5b0
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x26
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x26
	.long	0x1d9
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
	.long	0x5f4
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2a
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x2a
	.long	0x1c6
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
	.long	0x638
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x2f
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x2f
	.long	0x265
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
	.long	0x67e
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x33
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x33
	.long	0xc8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "_qSetUserData\0"
	.byte	0x1
	.byte	0x39
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x6c2
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x39
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "arg\0"
	.byte	0x1
	.byte	0x39
	.long	0xfd
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xf
	.ascii "_qClearTimeElapse\0"
	.byte	0x1
	.byte	0x3d
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x6fc
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x3d
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x12
	.ascii "_qEnqueueTaskEvent\0"
	.byte	0x1
	.byte	0x41
	.long	0xe6
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x760
	.uleb128 0x11
	.ascii "TasktoQueue\0"
	.byte	0x1
	.byte	0x41
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF3
	.byte	0x1
	.byte	0x41
	.long	0xfd
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x13
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0x45
	.long	0x3c5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x14
	.ascii "_qDequeueTaskEvent\0"
	.byte	0x1
	.byte	0x7e
	.long	0x393
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x79f
	.uleb128 0x15
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x7f
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xf
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0x8d
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x827
	.uleb128 0x11
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0x8d
	.long	0x199
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0x8d
	.long	0x265
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x11
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0x8d
	.long	0x4c4
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0x8d
	.long	0xc8
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x13
	.ascii "i\0"
	.byte	0x1
	.byte	0x8e
	.long	0xc8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0xf
	.ascii "_qISRHandler\0"
	.byte	0x1
	.byte	0x9a
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x85c
	.uleb128 0x15
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x9c
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x12
	.ascii "_qCreateTask\0"
	.byte	0x1
	.byte	0xa9
	.long	0xe6
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x8fb
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xa9
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.secrel32	.LASF5
	.byte	0x1
	.byte	0xa9
	.long	0x265
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x10
	.secrel32	.LASF1
	.byte	0x1
	.byte	0xa9
	.long	0x1c6
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x11
	.ascii "Time\0"
	.byte	0x1
	.byte	0xa9
	.long	0x199
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x11
	.ascii "nExecutions\0"
	.byte	0x1
	.byte	0xa9
	.long	0x1d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x11
	.ascii "InitialState\0"
	.byte	0x1
	.byte	0xa9
	.long	0x1ed
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x11
	.ascii "arg\0"
	.byte	0x1
	.byte	0xa9
	.long	0xfd
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x16
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.byte	0xb8
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x942
	.uleb128 0x10
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xb8
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "Event\0"
	.byte	0x1
	.byte	0xb8
	.long	0x187
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.byte	0xc1
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x9bf
	.uleb128 0x13
	.ascii "a\0"
	.byte	0x1
	.byte	0xc2
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x13
	.ascii "b\0"
	.byte	0x1
	.byte	0xc2
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x13
	.ascii "c\0"
	.byte	0x1
	.byte	0xc2
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x13
	.ascii "e\0"
	.byte	0x1
	.byte	0xc2
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x13
	.ascii "tmp\0"
	.byte	0x1
	.byte	0xc2
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x13
	.ascii "head\0"
	.byte	0x1
	.byte	0xc3
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x18
	.ascii "_qStart\0"
	.byte	0x1
	.byte	0xda
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xa18
	.uleb128 0x15
	.secrel32	.LASF2
	.byte	0x1
	.byte	0xdb
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x13
	.ascii "qTask\0"
	.byte	0x1
	.byte	0xdb
	.long	0x393
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.ascii "pMainSchedule\0"
	.byte	0x1
	.byte	0xdc
	.quad	.L54
	.byte	0
	.uleb128 0x1a
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x16
	.long	0xa31
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0x7
	.long	0x4cf
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
	.uleb128 0x7
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0x2116
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
	.def	memmove;	.scl	2;	.type	32;	.endef
