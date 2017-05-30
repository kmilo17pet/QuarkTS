	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 104, 5
	.globl	_qSysTick_Epochs_
	.bss
	.align 4
_qSysTick_Epochs_:
	.space 4
	.text
	.globl	qTaskGetCycles
	.def	qTaskGetCycles;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskGetCycles
qTaskGetCycles:
.LFB0:
	.file 1 "QuarkTS.c"
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
	.loc 1 43 0
	movq	16(%rbp), %rax
	movl	28(%rax), %eax
	.loc 1 44 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.seh_endproc
	.globl	qTaskSendEvent
	.def	qTaskSendEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSendEvent
qTaskSendEvent:
.LFB1:
	.loc 1 60 0
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
	.loc 1 61 0
	movq	16(%rbp), %rax
	movb	$1, 49(%rax)
	.loc 1 62 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 63 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.seh_endproc
	.globl	qTaskSetTime
	.def	qTaskSetTime;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetTime
qTaskSetTime:
.LFB2:
	.loc 1 76 0
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
	.loc 1 77 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 78 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.seh_endproc
	.globl	qTaskSetIterations
	.def	qTaskSetIterations;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetIterations
qTaskSetIterations:
.LFB3:
	.loc 1 95 0
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
	.loc 1 96 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 97 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.seh_endproc
	.globl	qTaskSetPriority
	.def	qTaskSetPriority;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetPriority
qTaskSetPriority:
.LFB4:
	.loc 1 109 0
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
	.loc 1 110 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 111 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 112 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.seh_endproc
	.globl	qTaskSetCallback
	.def	qTaskSetCallback;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetCallback
qTaskSetCallback:
.LFB5:
	.loc 1 125 0
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
	.loc 1 126 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 127 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.seh_endproc
	.globl	qTaskSetState
	.def	qTaskSetState;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetState
qTaskSetState:
.LFB6:
	.loc 1 138 0
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
	.loc 1 139 0
	cmpb	$0, 24(%rbp)
	je	.L9
	.loc 1 139 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	jne	.L11
.L9:
	.loc 1 140 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 50(%rax)
	.loc 1 141 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	jmp	.L8
.L11:
	.loc 1 139 0
	nop
.L8:
	.loc 1 142 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.seh_endproc
	.globl	qTaskSetUserData
	.def	qTaskSetUserData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetUserData
qTaskSetUserData:
.LFB7:
	.loc 1 156 0
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
	.loc 1 157 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 158 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.seh_endproc
	.globl	qTaskClearTimeElapsed
	.def	qTaskClearTimeElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskClearTimeElapsed
qTaskClearTimeElapsed:
.LFB8:
	.loc 1 168 0
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
	.loc 1 169 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 170 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.globl	qTaskQueueEvent
	.def	qTaskQueueEvent;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskQueueEvent
qTaskQueueEvent:
.LFB9:
	.loc 1 191 0
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
	.loc 1 192 0
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	movswl	%ax, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jl	.L15
	.loc 1 192 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L17
.L15:
	.loc 1 194 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 195 0
	movq	24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 196 0
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
	.loc 1 197 0
	movl	$0, %eax
.L17:
	.loc 1 198 0 discriminator 1
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.globl	qSchedulerSetInterruptsED
	.def	qSchedulerSetInterruptsED;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerSetInterruptsED
qSchedulerSetInterruptsED:
.LFB10:
	.loc 1 212 0
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
	.loc 1 213 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 214 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 215 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.def	_qPrioQueueExtract;	.scl	3;	.type	32;	.endef
	.seh_proc	_qPrioQueueExtract
_qPrioQueueExtract:
.LFB11:
	.loc 1 217 0
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
	.loc 1 218 0
	movq	$0, -16(%rbp)
	.loc 1 220 0
	movb	$0, -2(%rbp)
	.loc 1 221 0
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	testw	%ax, %ax
	jns	.L20
	.loc 1 221 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L21
.L20:
	.loc 1 222 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L22
	.loc 1 222 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L22:
	.loc 1 223 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	movb	%al, -3(%rbp)
	.loc 1 224 0
	movb	$1, -1(%rbp)
	jmp	.L23
.L27:
	.loc 1 225 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L31
	.loc 1 226 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	cmpb	-3(%rbp), %al
	jbe	.L26
	.loc 1 227 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	movb	%al, -3(%rbp)
	.loc 1 228 0
	movzbl	-1(%rbp), %eax
	movb	%al, -2(%rbp)
.L26:
	.loc 1 224 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L23:
	.loc 1 224 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L27
	jmp	.L25
.L31:
	.loc 1 225 0 is_stmt 1
	nop
.L25:
	.loc 1 231 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 232 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 233 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 234 0
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	jmp	.L28
.L29:
	.loc 1 234 0 is_stmt 0 discriminator 3
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
.L28:
	.loc 1 234 0 discriminator 1
	movzbl	-1(%rbp), %edx
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	cwtl
	cmpl	%eax, %edx
	jl	.L29
	.loc 1 235 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	subl	$1, %eax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movw	%dx, 98(%rax)
	.loc 1 236 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L30
	.loc 1 236 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L30:
	.loc 1 237 0 is_stmt 1
	movq	-16(%rbp), %rax
.L21:
	.loc 1 238 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.globl	_qInitScheduler
	.def	_qInitScheduler;	.scl	2;	.type	32;	.endef
	.seh_proc	_qInitScheduler
_qInitScheduler:
.LFB12:
	.loc 1 240 0
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
	.loc 1 242 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 56(%rax)
	.loc 1 243 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rbp), %xmm0
	movss	%xmm0, 16(%rax)
	.loc 1 244 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 245 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 8(%rax)
	.loc 1 246 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 88(%rax)
	.loc 1 247 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 96(%rax)
	.loc 1 248 0
	movb	$0, -1(%rbp)
	jmp	.L33
.L34:
	.loc 1 248 0 is_stmt 0 discriminator 3
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L33:
	.loc 1 248 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L34
	.loc 1 249 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movw	$-1, 98(%rax)
	.loc 1 250 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 251 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 252 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 83(%rax)
	.loc 1 253 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 72(%rax)
	.loc 1 254 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 64(%rax)
	.loc 1 255 0
	movl	$0, _qSysTick_Epochs_(%rip)
	.loc 1 256 0
	nop
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.seh_endproc
	.globl	qSchedulerAddxTask
	.def	qSchedulerAddxTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddxTask
qSchedulerAddxTask:
.LFB13:
	.loc 1 296 0
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
	.loc 1 297 0
	movss	40(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L36
	.loc 1 297 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L38
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L38
.L36:
	.loc 1 297 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L39
.L38:
	.loc 1 297 0 discriminator 5
	movl	$-1, %eax
	jmp	.L40
.L39:
	.loc 1 298 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 299 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 300 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 301 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 302 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 303 0
	movl	$0, %eax
	movq	16(%rbp), %rdx
	movb	%al, 48(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 49(%rdx)
	.loc 1 304 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 50(%rax)
	.loc 1 305 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 306 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 307 0
	movq	16(%rbp), %rax
	movl	$0, 28(%rax)
	.loc 1 308 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 309 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 310 0
	movq	16(%rbp), %rax
	movq	$0, 64(%rax)
	.loc 1 311 0
	movl	$0, %eax
.L40:
	.loc 1 312 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.seh_endproc
	.globl	qSchedulerAddeTask
	.def	qSchedulerAddeTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddeTask
qSchedulerAddeTask:
.LFB14:
	.loc 1 340 0
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
	movl	%r8d, %eax
	movq	%r9, 40(%rbp)
	movb	%al, 32(%rbp)
	.loc 1 341 0
	movzbl	32(%rbp), %ecx
	movq	24(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 48(%rsp)
	movl	$0, 40(%rsp)
	movl	$1, 32(%rsp)
	pxor	%xmm3, %xmm3
	movl	%ecx, %r8d
	movq	%rax, %rdx
	movq	16(%rbp), %rcx
	call	qSchedulerAddxTask
	.loc 1 342 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.def	_qTriggerEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerEvent
_qTriggerEvent:
.LFB15:
	.loc 1 344 0
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
	.loc 1 345 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 24(%rax)
	.loc 1 346 0
	movq	16(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 347 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 348 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L45
	.loc 1 348 0 is_stmt 0 discriminator 1
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
.L45:
	.loc 1 349 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 48(%rax)
	.loc 1 350 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 40(%rax)
	.loc 1 351 0
	movq	16(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 28(%rax)
	.loc 1 352 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.seh_endproc
	.def	_qTaskChainbyPriority;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTaskChainbyPriority
_qTaskChainbyPriority:
.LFB16:
	.loc 1 354 0
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
	.loc 1 355 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 356 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 357 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L48
	.loc 1 357 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
	.loc 1 358 0 is_stmt 1 discriminator 1
	jmp	.L48
.L55:
	.loc 1 359 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 360 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 361 0
	jmp	.L49
.L54:
	.loc 1 362 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	%al, %dl
	jnb	.L50
	.loc 1 363 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 364 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 365 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L51
	.loc 1 365 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L52
.L51:
	.loc 1 366 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L52:
	.loc 1 367 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 368 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L53
.L50:
	.loc 1 371 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 372 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L53:
	.loc 1 374 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 375 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L49
	.loc 1 375 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L49:
	.loc 1 361 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L54
.L48:
	.loc 1 358 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L55
	.loc 1 378 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L57
	.loc 1 378 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L57:
	.loc 1 379 0 is_stmt 1
	nop
	addq	$80, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.globl	qTaskLinkRingBuffer
	.def	qTaskLinkRingBuffer;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskLinkRingBuffer
qTaskLinkRingBuffer:
.LFB17:
	.loc 1 397 0
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
	.loc 1 398 0
	cmpq	$0, 24(%rbp)
	jne	.L59
	.loc 1 398 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L60
.L59:
	.loc 1 399 0 is_stmt 1
	movq	24(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L61
	.loc 1 399 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L60
.L61:
	.loc 1 400 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 401 0
	movl	$0, %eax
.L60:
	.loc 1 402 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.def	_qTriggerReleaseSchedEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerReleaseSchedEvent
_qTriggerReleaseSchedEvent:
.LFB18:
	.loc 1 404 0
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
	.loc 1 405 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 406 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 407 0
	leaq	QUARKTS(%rip), %rax
	movzbl	83(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 408 0
	leaq	QUARKTS(%rip), %rax
	movl	$3, 24(%rax)
	.loc 1 409 0
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L63
	.loc 1 409 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rdx
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
.L63:
	.loc 1 410 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 411 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.def	_qTriggerIdleTask;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerIdleTask
_qTriggerIdleTask:
.LFB19:
	.loc 1 413 0
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
	.loc 1 414 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 415 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 24(%rax)
	.loc 1 416 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rdx
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
	.loc 1 417 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 418 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
	.globl	qSchedulerRun
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRun
qSchedulerRun:
.LFB20:
	.loc 1 427 0
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
	.loc 1 429 0
	movq	$0, -16(%rbp)
.L66:
	.loc 1 431 0
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	jne	.L85
	.loc 1 432 0
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	testb	%al, %al
	jne	.L69
	.loc 1 433 0
	call	_qTaskChainbyPriority
	.loc 1 434 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 80(%rax)
.L69:
	.loc 1 436 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 437 0
	jmp	.L70
.L83:
	.loc 1 438 0
	call	_qPrioQueueExtract
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L71
	.loc 1 438 0 is_stmt 0 discriminator 1
	movq	-24(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L71:
	.loc 1 439 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	-8(%rbp), %rax
	movl	20(%rax), %eax
	subl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	%eax, %edx
	jnb	.L72
	.loc 1 439 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L73
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L74
.L73:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L74:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L75
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L75
.L72:
	.loc 1 439 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L77
	.loc 1 439 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	jne	.L75
.L77:
	.loc 1 439 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L75
	.loc 1 440 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 441 0
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	je	.L78
	.loc 1 441 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 24(%rax)
.L78:
	.loc 1 442 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L79
	.loc 1 442 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
.L79:
	.loc 1 443 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L80
.L75:
	.loc 1 445 0
	movq	-8(%rbp), %rax
	movq	64(%rax), %rax
	movq	%rax, %rcx
	call	qRBufferPopFront
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L81
	.loc 1 446 0
	leaq	QUARKTS(%rip), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 447 0
	movq	-8(%rbp), %rax
	movl	$4, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L80
.L81:
	.loc 1 449 0
	movq	-8(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	je	.L82
	.loc 1 450 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 451 0
	movq	-8(%rbp), %rax
	movb	$0, 49(%rax)
	.loc 1 452 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L80
.L82:
	.loc 1 454 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L80
	.loc 1 454 0 is_stmt 0 discriminator 1
	call	_qTriggerIdleTask
.L80:
	.loc 1 455 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L70:
	.loc 1 437 0
	cmpq	$0, -8(%rbp)
	jne	.L83
	.loc 1 457 0
	jmp	.L66
.L85:
	.loc 1 431 0
	nop
.L68:
	.loc 1 458 0
	call	_qTriggerReleaseSchedEvent
	.loc 1 459 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.seh_endproc
	.globl	qStateMachine_Init
	.def	qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Init
qStateMachine_Init:
.LFB21:
	.loc 1 490 0
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
	.loc 1 491 0
	cmpq	$0, 24(%rbp)
	jne	.L87
	.loc 1 491 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L88
.L87:
	.loc 1 492 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 493 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 494 0
	movq	16(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 32(%rax)
	.loc 1 495 0
	movq	16(%rbp), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 496 0
	movq	16(%rbp), %rax
	movq	48(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 497 0
	movl	$0, %eax
.L88:
	.loc 1 498 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
	.globl	qStateMachine_Run
	.def	qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Run
qStateMachine_Run:
.LFB22:
	.loc 1 513 0
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
	.loc 1 514 0
	movq	$0, -8(%rbp)
	.loc 1 515 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 516 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L90
	.loc 1 517 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 20(%rax)
	.loc 1 518 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 519 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 520 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L91
.L90:
	.loc 1 522 0
	movq	16(%rbp), %rax
	movl	$-32767, 16(%rax)
.L91:
	.loc 1 524 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$-32768, %eax
	je	.L93
	cmpl	$-32767, %eax
	jne	.L99
	.loc 1 526 0
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	testq	%rax, %rax
	je	.L100
	.loc 1 526 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 527 0 is_stmt 1 discriminator 1
	jmp	.L100
.L93:
	.loc 1 529 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L101
	.loc 1 529 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 530 0 is_stmt 1 discriminator 1
	jmp	.L101
.L99:
	.loc 1 532 0
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	je	.L102
	.loc 1 532 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 533 0 is_stmt 1 discriminator 1
	jmp	.L102
.L100:
	.loc 1 527 0
	nop
	jmp	.L96
.L101:
	.loc 1 530 0
	nop
	jmp	.L96
.L102:
	.loc 1 533 0
	nop
.L96:
	.loc 1 535 0
	nop
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.seh_endproc
	.globl	qSTimerSet
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerSet
qSTimerSet:
.LFB23:
	.loc 1 556 0
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
	.loc 1 557 0
	cvtss2sd	24(%rbp), %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	ucomisd	%xmm1, %xmm0
	jbe	.L108
	.loc 1 557 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L106
.L108:
	.loc 1 558 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 8(%rax)
	.loc 1 559 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 4(%rax)
	.loc 1 560 0
	movq	16(%rbp), %rax
	movb	$1, (%rax)
	.loc 1 561 0
	movl	$0, %eax
.L106:
	.loc 1 562 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.seh_endproc
	.globl	qSTimerFreeRun
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerFreeRun
qSTimerFreeRun:
.LFB24:
	.loc 1 585 0
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
	.loc 1 586 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L110
	.loc 1 587 0
	movq	16(%rbp), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L111
	.loc 1 588 0
	movq	16(%rbp), %rcx
	call	qSTimerDisarm
	.loc 1 589 0
	movl	$1, %eax
	jmp	.L112
.L111:
	.loc 1 591 0
	movl	$0, %eax
	jmp	.L112
.L110:
	.loc 1 593 0
	movss	24(%rbp), %xmm0
	movaps	%xmm0, %xmm1
	movq	16(%rbp), %rcx
	call	qSTimerSet
.L112:
	.loc 1 594 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.seh_endproc
	.globl	qSTimerExpired
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerExpired
qSTimerExpired:
.LFB25:
	.loc 1 610 0
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
	.loc 1 611 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L114
	.loc 1 611 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L115
.L114:
	.loc 1 612 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	%eax, %edx
	setnb	%al
.L115:
	.loc 1 613 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.seh_endproc
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
.LFB26:
	.loc 1 627 0
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
	.loc 1 628 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	.loc 1 629 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.seh_endproc
	.globl	qSTimerRemaining
	.def	qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerRemaining
qSTimerRemaining:
.LFB27:
	.loc 1 643 0
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
	.loc 1 644 0
	movq	16(%rbp), %rcx
	call	qSTimerElapsed
	movl	%eax, -4(%rbp)
	.loc 1 645 0
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L119
	.loc 1 645 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	-4(%rbp), %eax
	jnb	.L120
.L119:
	.loc 1 645 0 discriminator 3
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	jmp	.L121
.L120:
	.loc 1 645 0 discriminator 4
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	subl	-4(%rbp), %eax
.L121:
	.loc 1 646 0 is_stmt 1 discriminator 6
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.seh_endproc
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
.LFB28:
	.loc 1 656 0
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
	.loc 1 657 0
	movq	16(%rbp), %rax
	movb	$0, (%rax)
	.loc 1 658 0
	movq	16(%rbp), %rax
	movl	$0, 4(%rax)
	.loc 1 659 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.seh_endproc
	.globl	qMemoryAlloc
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryAlloc
qMemoryAlloc:
.LFB29:
	.loc 1 677 0
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
	movl	%edx, %eax
	movw	%ax, 24(%rbp)
	.loc 1 680 0
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 681 0
	movb	$0, -2(%rbp)
	.loc 1 682 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L126
	.loc 1 682 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
	.loc 1 683 0 is_stmt 1 discriminator 1
	jmp	.L126
.L139:
	.loc 1 684 0
	movw	$0, -6(%rbp)
	.loc 1 685 0
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	.loc 1 686 0
	jmp	.L127
.L130:
	.loc 1 687 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L141
	.loc 1 688 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	cltq
	addq	%rax, -16(%rbp)
	.loc 1 689 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	addb	%al, -1(%rbp)
	.loc 1 690 0
	nop
.L127:
	.loc 1 686 0
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L130
	jmp	.L129
.L141:
	.loc 1 692 0
	nop
.L129:
	.loc 1 694 0
	movzbl	-1(%rbp), %eax
	movb	%al, -2(%rbp)
	.loc 1 695 0
	movb	$1, -3(%rbp)
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	jmp	.L131
.L137:
	.loc 1 696 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L132
	.loc 1 697 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movzbl	-1(%rbp), %eax
	addl	%edx, %eax
	movb	%al, -2(%rbp)
	.loc 1 698 0
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 699 0
	movzbl	-2(%rbp), %edx
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	cltq
	addq	%rax, -16(%rbp)
	.loc 1 700 0
	jmp	.L133
.L132:
	.loc 1 702 0
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	addw	%ax, -6(%rbp)
	.loc 1 703 0
	movzwl	-6(%rbp), %eax
	cmpw	24(%rbp), %ax
	jb	.L134
	.loc 1 704 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-2(%rbp), %eax
	addq	%rax, %rdx
	movzbl	-3(%rbp), %eax
	movb	%al, (%rdx)
	.loc 1 705 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L135
	.loc 1 705 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L135:
	.loc 1 706 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L136
.L134:
	.loc 1 695 0 discriminator 2
	movzbl	-3(%rbp), %eax
	addl	$1, %eax
	movb	%al, -3(%rbp)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L131:
	.loc 1 695 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L137
.L133:
	.loc 1 709 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	je	.L142
.L126:
	.loc 1 683 0
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-2(%rbp), %al
	ja	.L139
	jmp	.L138
.L142:
	.loc 1 709 0
	nop
.L138:
	.loc 1 711 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L140
	.loc 1 711 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L140:
	.loc 1 712 0 is_stmt 1
	movl	$0, %eax
.L136:
	.loc 1 713 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.seh_endproc
	.globl	qMemoryFree
	.def	qMemoryFree;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryFree
qMemoryFree:
.LFB30:
	.loc 1 727 0
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
	.loc 1 729 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L144
	.loc 1 729 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L144:
	.loc 1 730 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 731 0
	movb	$0, -1(%rbp)
	jmp	.L145
.L148:
	.loc 1 732 0
	movq	-16(%rbp), %rax
	cmpq	24(%rbp), %rax
	jne	.L146
	.loc 1 733 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movb	$0, (%rax)
	.loc 1 734 0
	jmp	.L147
.L146:
	.loc 1 736 0 discriminator 2
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	addq	%rax, -16(%rbp)
	.loc 1 731 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L145:
	.loc 1 731 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L148
.L147:
	.loc 1 738 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L150
	.loc 1 738 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L150:
	.loc 1 739 0 is_stmt 1
	nop
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.seh_endproc
	.def	_qRBufferValidPowerOfTwo;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferValidPowerOfTwo
_qRBufferValidPowerOfTwo:
.LFB31:
	.loc 1 748 0
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
	movl	%ecx, %eax
	movw	%ax, 16(%rbp)
	.loc 1 750 0
	movzwl	16(%rbp), %eax
	leal	-1(%rax), %edx
	movzwl	16(%rbp), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	je	.L152
	.loc 1 751 0
	movzwl	16(%rbp), %eax
	subl	$1, %eax
	movw	%ax, 16(%rbp)
	.loc 1 752 0
	movl	$1, -4(%rbp)
	jmp	.L153
.L154:
	.loc 1 752 0 is_stmt 0 discriminator 3
	movzwl	16(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movzwl	16(%rbp), %eax
	orl	%edx, %eax
	movw	%ax, 16(%rbp)
	sall	-4(%rbp)
.L153:
	.loc 1 752 0 discriminator 1
	movl	-4(%rbp), %eax
	cmpl	$15, %eax
	jbe	.L154
	.loc 1 753 0 is_stmt 1
	movzwl	16(%rbp), %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%rbp)
.L152:
	.loc 1 755 0
	movzwl	16(%rbp), %eax
	.loc 1 756 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.seh_endproc
	.def	_qRBufferCount;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferCount
_qRBufferCount:
.LFB32:
	.loc 1 758 0
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
	.loc 1 759 0
	cmpq	$0, 16(%rbp)
	je	.L157
	.loc 1 759 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzwl	12(%rax), %eax
	movzwl	%ax, %edx
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	movzwl	%ax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	.L159
.L157:
	.loc 1 759 0 discriminator 2
	movl	$0, %eax
.L159:
	.loc 1 760 0 is_stmt 1 discriminator 5
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.seh_endproc
	.def	_qRBufferFull;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferFull
_qRBufferFull:
.LFB33:
	.loc 1 762 0
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
	.loc 1 763 0
	cmpq	$0, 16(%rbp)
	je	.L161
	.loc 1 763 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rcx
	call	_qRBufferCount
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movzwl	10(%rax), %eax
	movzwl	%ax, %eax
	cmpl	%eax, %edx
	jne	.L162
.L161:
	.loc 1 763 0 discriminator 3
	movl	$1, %eax
	jmp	.L163
.L162:
	.loc 1 763 0 discriminator 4
	movl	$0, %eax
.L163:
	.loc 1 764 0 is_stmt 1 discriminator 6
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.seh_endproc
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
.LFB34:
	.loc 1 783 0
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
	movl	%r8d, %edx
	movl	%r9d, %eax
	movw	%dx, 32(%rbp)
	movw	%ax, 40(%rbp)
	.loc 1 784 0
	cmpq	$0, 16(%rbp)
	je	.L167
	.loc 1 785 0
	movq	16(%rbp), %rax
	movw	$0, 12(%rax)
	.loc 1 786 0
	movq	16(%rbp), %rax
	movw	$0, 14(%rax)
	.loc 1 787 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 788 0
	movzwl	40(%rbp), %eax
	movl	%eax, %ecx
	call	_qRBufferValidPowerOfTwo
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movw	%dx, 8(%rax)
	.loc 1 789 0
	movq	16(%rbp), %rax
	movzwl	40(%rbp), %edx
	movw	%dx, 10(%rax)
.L167:
	.loc 1 791 0
	nop
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.seh_endproc
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
.LFB35:
	.loc 1 805 0
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
	.loc 1 806 0
	cmpq	$0, 16(%rbp)
	je	.L169
	.loc 1 806 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rcx
	call	_qRBufferCount
	testl	%eax, %eax
	jne	.L170
.L169:
	.loc 1 806 0 discriminator 3
	movl	$1, %eax
	jmp	.L171
.L170:
	.loc 1 806 0 discriminator 4
	movl	$0, %eax
.L171:
	.loc 1 807 0 is_stmt 1 discriminator 6
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.seh_endproc
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
.LFB36:
	.loc 1 821 0
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
	.loc 1 822 0
	cmpq	$0, 16(%rbp)
	je	.L174
	.loc 1 823 0
	movq	16(%rbp), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L175
	.loc 1 823 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	(%rax), %rcx
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	movq	16(%rbp), %rdx
	movzwl	10(%rdx), %r8d
	movl	$0, %edx
	divw	%r8w
	movl	%edx, %eax
	movzwl	%ax, %edx
	movq	16(%rbp), %rax
	movzwl	8(%rax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	cltq
	addq	%rcx, %rax
	jmp	.L177
.L175:
	.loc 1 823 0 discriminator 2
	movl	$0, %eax
	jmp	.L177
.L174:
	.loc 1 825 0 is_stmt 1
	movl	$0, %eax
.L177:
	.loc 1 826 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.seh_endproc
	.globl	qRBufferPopFront
	.def	qRBufferPopFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPopFront
qRBufferPopFront:
.LFB37:
	.loc 1 840 0
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
	.loc 1 841 0
	cmpq	$0, 16(%rbp)
	jne	.L179
	.loc 1 841 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L180
.L179:
	.loc 1 842 0 is_stmt 1
	movq	$0, -8(%rbp)
	.loc 1 843 0
	movq	16(%rbp), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L181
	.loc 1 844 0
	movq	16(%rbp), %rax
	movq	(%rax), %rcx
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	movq	16(%rbp), %rdx
	movzwl	10(%rdx), %r8d
	movl	$0, %edx
	divw	%r8w
	movl	%edx, %eax
	movzwl	%ax, %edx
	movq	16(%rbp), %rax
	movzwl	8(%rax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	cltq
	addq	%rcx, %rax
	movq	%rax, -8(%rbp)
	.loc 1 845 0
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movw	%dx, 14(%rax)
.L181:
	.loc 1 847 0
	movq	-8(%rbp), %rax
.L180:
	.loc 1 848 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.seh_endproc
	.globl	qRBufferPush
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPush
qRBufferPush:
.LFB38:
	.loc 1 863 0
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
	.loc 1 864 0
	movb	$0, -1(%rbp)
	.loc 1 865 0
	movq	24(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 866 0
	movq	$0, -24(%rbp)
	.loc 1 869 0
	cmpq	$0, 16(%rbp)
	je	.L183
	.loc 1 869 0 is_stmt 0 discriminator 1
	cmpq	$0, -16(%rbp)
	je	.L183
	.loc 1 870 0 is_stmt 1
	movq	16(%rbp), %rcx
	call	_qRBufferFull
	testb	%al, %al
	jne	.L183
	.loc 1 871 0
	movq	16(%rbp), %rax
	movq	(%rax), %rcx
	movq	16(%rbp), %rax
	movzwl	12(%rax), %eax
	movq	16(%rbp), %rdx
	movzwl	10(%rdx), %r8d
	movl	$0, %edx
	divw	%r8w
	movl	%edx, %eax
	movzwl	%ax, %edx
	movq	16(%rbp), %rax
	movzwl	8(%rax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	cltq
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	.loc 1 872 0
	movw	$0, -4(%rbp)
	jmp	.L184
.L185:
	.loc 1 872 0 is_stmt 0 discriminator 3
	movzwl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movzwl	-4(%rbp), %ecx
	movq	-16(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	movzwl	-4(%rbp), %eax
	addl	$1, %eax
	movw	%ax, -4(%rbp)
.L184:
	.loc 1 872 0 discriminator 1
	movq	16(%rbp), %rax
	movzwl	8(%rax), %eax
	cmpw	-4(%rbp), %ax
	ja	.L185
	.loc 1 873 0 is_stmt 1
	movq	16(%rbp), %rax
	movzwl	12(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movw	%dx, 12(%rax)
	.loc 1 874 0
	movb	$1, -1(%rbp)
.L183:
	.loc 1 877 0
	movzbl	-1(%rbp), %eax
	.loc 1 878 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
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
	.long	0x163f
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
	.uleb128 0x3
	.ascii "__int16_t\0"
	.byte	0x2
	.byte	0x37
	.long	0xc6
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.ascii "short int\0"
	.uleb128 0x3
	.ascii "__uint16_t\0"
	.byte	0x2
	.byte	0x39
	.long	0xe5
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
	.long	0x114
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
	.ascii "int16_t\0"
	.byte	0x3
	.byte	0x20
	.long	0xb5
	.uleb128 0x3
	.ascii "uint16_t\0"
	.byte	0x3
	.byte	0x24
	.long	0xd3
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x30
	.long	0x102
	.uleb128 0x4
	.byte	0x4
	.long	0x114
	.byte	0x4
	.byte	0x3b
	.long	0x1df
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
	.uleb128 0x5
	.ascii "byRBufferPop\0"
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x4
	.byte	0x3b
	.long	0x183
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x4
	.byte	0x3c
	.long	0x200
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x4
	.byte	0x3d
	.long	0x173
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x4
	.byte	0x3e
	.long	0x145
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x4
	.byte	0x3f
	.long	0x145
	.uleb128 0x3
	.ascii "qState_t\0"
	.byte	0x4
	.byte	0x40
	.long	0x145
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x4
	.byte	0x41
	.long	0x145
	.uleb128 0x6
	.byte	0x20
	.byte	0x4
	.byte	0x4c
	.long	0x2a8
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x4
	.byte	0x5f
	.long	0x1df
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x63
	.long	0x2a8
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x4
	.byte	0x67
	.long	0x2a8
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x4
	.byte	0x6c
	.long	0x250
	.byte	0x18
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x4
	.byte	0x6d
	.long	0x25f
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x4
	.byte	0x6f
	.long	0x2cc
	.uleb128 0xa
	.byte	0x8
	.long	0x2d2
	.uleb128 0xb
	.long	0x2dd
	.uleb128 0xc
	.long	0x2aa
	.byte	0
	.uleb128 0x6
	.byte	0x3
	.byte	0x4
	.byte	0x70
	.long	0x318
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x4
	.byte	0x71
	.long	0x318
	.byte	0
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x4
	.byte	0x71
	.long	0x318
	.byte	0x1
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x4
	.byte	0x71
	.long	0x318
	.byte	0x2
	.byte	0
	.uleb128 0xd
	.long	0x145
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x4
	.byte	0x72
	.long	0x2dd
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0x76
	.long	0x382
	.uleb128 0x7
	.ascii "data\0"
	.byte	0x4
	.byte	0x77
	.long	0x382
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x78
	.long	0x388
	.byte	0x8
	.uleb128 0x7
	.ascii "Elementcount\0"
	.byte	0x4
	.byte	0x79
	.long	0x388
	.byte	0xa
	.uleb128 0x7
	.ascii "head\0"
	.byte	0x4
	.byte	0x7a
	.long	0x388
	.byte	0xc
	.uleb128 0x7
	.ascii "tail\0"
	.byte	0x4
	.byte	0x7b
	.long	0x388
	.byte	0xe
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x318
	.uleb128 0xd
	.long	0x163
	.uleb128 0x3
	.ascii "qRBuffer_t\0"
	.byte	0x4
	.byte	0x7c
	.long	0x331
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x48
	.byte	0x4
	.byte	0x7e
	.long	0x458
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x7f
	.long	0x2a8
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x4
	.byte	0x7f
	.long	0x2a8
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x4
	.byte	0x80
	.long	0x458
	.byte	0x10
	.uleb128 0x7
	.ascii "ClockStart\0"
	.byte	0x4
	.byte	0x80
	.long	0x458
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x4
	.byte	0x81
	.long	0x22c
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x4
	.byte	0x82
	.long	0x173
	.byte	0x1c
	.uleb128 0x8
	.secrel32	.LASF2
	.byte	0x4
	.byte	0x83
	.long	0x219
	.byte	0x20
	.uleb128 0x8
	.secrel32	.LASF3
	.byte	0x4
	.byte	0x84
	.long	0x2ba
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x85
	.long	0x45d
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x4
	.byte	0x86
	.long	0x462
	.byte	0x38
	.uleb128 0x7
	.ascii "RingBuff\0"
	.byte	0x4
	.byte	0x87
	.long	0x46d
	.byte	0x40
	.byte	0
	.uleb128 0xd
	.long	0x209
	.uleb128 0xd
	.long	0x31d
	.uleb128 0xa
	.byte	0x8
	.long	0x468
	.uleb128 0xd
	.long	0x39f
	.uleb128 0xa
	.byte	0x8
	.long	0x38d
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0x8b
	.long	0x49a
	.uleb128 0x8
	.secrel32	.LASF4
	.byte	0x4
	.byte	0x8c
	.long	0x462
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x4
	.byte	0x8d
	.long	0x2a8
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x4
	.byte	0x8e
	.long	0x473
	.uleb128 0x6
	.byte	0x8
	.byte	0x4
	.byte	0x90
	.long	0x513
	.uleb128 0x7
	.ascii "Init\0"
	.byte	0x4
	.byte	0x91
	.long	0x145
	.byte	0
	.uleb128 0x7
	.ascii "FCallIdle\0"
	.byte	0x4
	.byte	0x91
	.long	0x145
	.byte	0x1
	.uleb128 0x7
	.ascii "ReleaseSched\0"
	.byte	0x4
	.byte	0x91
	.long	0x145
	.byte	0x2
	.uleb128 0x7
	.ascii "FCallReleased\0"
	.byte	0x4
	.byte	0x91
	.long	0x145
	.byte	0x3
	.uleb128 0x7
	.ascii "IntFlags\0"
	.byte	0x4
	.byte	0x92
	.long	0x173
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x4
	.byte	0x93
	.long	0x4af
	.uleb128 0x6
	.byte	0x68
	.byte	0x4
	.byte	0x95
	.long	0x5fd
	.uleb128 0x7
	.ascii "IDLECallback\0"
	.byte	0x4
	.byte	0x96
	.long	0x2ba
	.byte	0
	.uleb128 0x7
	.ascii "ReleaseSchedCallback\0"
	.byte	0x4
	.byte	0x97
	.long	0x2ba
	.byte	0x8
	.uleb128 0x7
	.ascii "Tick\0"
	.byte	0x4
	.byte	0x98
	.long	0x1f1
	.byte	0x10
	.uleb128 0x7
	.ascii "EventInfo\0"
	.byte	0x4
	.byte	0x99
	.long	0x2aa
	.byte	0x18
	.uleb128 0x7
	.ascii "First\0"
	.byte	0x4
	.byte	0x9a
	.long	0x462
	.byte	0x38
	.uleb128 0x7
	.ascii "I_Disable\0"
	.byte	0x4
	.byte	0x9b
	.long	0x602
	.byte	0x40
	.uleb128 0x7
	.ascii "I_Restorer\0"
	.byte	0x4
	.byte	0x9c
	.long	0x613
	.byte	0x48
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x9d
	.long	0x619
	.byte	0x50
	.uleb128 0x7
	.ascii "QueueStack\0"
	.byte	0x4
	.byte	0x9e
	.long	0x61e
	.byte	0x58
	.uleb128 0x7
	.ascii "QueueSize\0"
	.byte	0x4
	.byte	0x9f
	.long	0x145
	.byte	0x60
	.uleb128 0x7
	.ascii "QueueIndex\0"
	.byte	0x4
	.byte	0xa0
	.long	0x154
	.byte	0x62
	.byte	0
	.uleb128 0xf
	.long	0x173
	.uleb128 0xa
	.byte	0x8
	.long	0x5fd
	.uleb128 0xb
	.long	0x613
	.uleb128 0xc
	.long	0x173
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x608
	.uleb128 0xd
	.long	0x513
	.uleb128 0xa
	.byte	0x8
	.long	0x624
	.uleb128 0xd
	.long	0x49a
	.uleb128 0x3
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x4
	.byte	0xa1
	.long	0x52b
	.uleb128 0x10
	.byte	0x4
	.long	0xfb
	.byte	0x4
	.word	0x100
	.long	0x67a
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
	.word	0x100
	.long	0x642
	.uleb128 0x13
	.byte	0x18
	.byte	0x4
	.word	0x119
	.long	0x6d5
	.uleb128 0x14
	.ascii "__Failure\0"
	.byte	0x4
	.word	0x11a
	.long	0x777
	.byte	0
	.uleb128 0x14
	.ascii "__Success\0"
	.byte	0x4
	.word	0x11b
	.long	0x777
	.byte	0x8
	.uleb128 0x14
	.ascii "__Unexpected\0"
	.byte	0x4
	.word	0x11c
	.long	0x777
	.byte	0x10
	.byte	0
	.uleb128 0xb
	.long	0x6e0
	.uleb128 0xc
	.long	0x6e0
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x772
	.uleb128 0x15
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x4
	.word	0x104
	.long	0x772
	.uleb128 0x14
	.ascii "NextState\0"
	.byte	0x4
	.word	0x108
	.long	0x78c
	.byte	0
	.uleb128 0x14
	.ascii "PreviousState\0"
	.byte	0x4
	.word	0x10c
	.long	0x78c
	.byte	0x8
	.uleb128 0x14
	.ascii "PreviousReturnStatus\0"
	.byte	0x4
	.word	0x110
	.long	0x67a
	.byte	0x10
	.uleb128 0x14
	.ascii "StateJustChanged\0"
	.byte	0x4
	.word	0x114
	.long	0x250
	.byte	0x14
	.uleb128 0x14
	.ascii "Data\0"
	.byte	0x4
	.word	0x118
	.long	0x2a8
	.byte	0x18
	.uleb128 0x14
	.ascii "_\0"
	.byte	0x4
	.word	0x11d
	.long	0x68f
	.byte	0x20
	.byte	0
	.uleb128 0xd
	.long	0x6e6
	.uleb128 0xa
	.byte	0x8
	.long	0x6d5
	.uleb128 0x16
	.long	0x67a
	.long	0x78c
	.uleb128 0xc
	.long	0x6e0
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x77d
	.uleb128 0x12
	.ascii "qSM_State_t\0"
	.byte	0x4
	.word	0x11f
	.long	0x78c
	.uleb128 0x12
	.ascii "qSM_ExState_t\0"
	.byte	0x4
	.word	0x120
	.long	0x777
	.uleb128 0x13
	.byte	0xc
	.byte	0x4
	.word	0x153
	.long	0x7ed
	.uleb128 0x14
	.ascii "SR\0"
	.byte	0x4
	.word	0x154
	.long	0x250
	.byte	0
	.uleb128 0x14
	.ascii "Start\0"
	.byte	0x4
	.word	0x155
	.long	0x209
	.byte	0x4
	.uleb128 0x14
	.ascii "TV\0"
	.byte	0x4
	.word	0x155
	.long	0x209
	.byte	0x8
	.byte	0
	.uleb128 0x12
	.ascii "qSTimer_t\0"
	.byte	0x4
	.word	0x156
	.long	0x7bc
	.uleb128 0x13
	.byte	0x18
	.byte	0x4
	.word	0x166
	.long	0x85e
	.uleb128 0x14
	.ascii "BlockSize\0"
	.byte	0x4
	.word	0x167
	.long	0x163
	.byte	0
	.uleb128 0x14
	.ascii "NumberofBlocks\0"
	.byte	0x4
	.word	0x168
	.long	0x145
	.byte	0x2
	.uleb128 0x14
	.ascii "BlockDescriptors\0"
	.byte	0x4
	.word	0x169
	.long	0x85e
	.byte	0x8
	.uleb128 0x14
	.ascii "Blocks\0"
	.byte	0x4
	.word	0x16a
	.long	0x85e
	.byte	0x10
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x145
	.uleb128 0x12
	.ascii "qMemoryPool_t\0"
	.byte	0x4
	.word	0x16b
	.long	0x7ff
	.uleb128 0x17
	.ascii "qTaskGetCycles\0"
	.byte	0x1
	.byte	0x2a
	.long	0x173
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x8b5
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x2a
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.ascii "qTaskSendEvent\0"
	.byte	0x1
	.byte	0x3c
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x8fa
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x3c
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x3c
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "qTaskSetTime\0"
	.byte	0x1
	.byte	0x4c
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x93f
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x4c
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1a
	.ascii "Value\0"
	.byte	0x1
	.byte	0x4c
	.long	0x1f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "qTaskSetIterations\0"
	.byte	0x1
	.byte	0x5f
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x98a
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x5f
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1a
	.ascii "Value\0"
	.byte	0x1
	.byte	0x5f
	.long	0x22c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "qTaskSetPriority\0"
	.byte	0x1
	.byte	0x6d
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x9d3
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x6d
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1a
	.ascii "Value\0"
	.byte	0x1
	.byte	0x6d
	.long	0x219
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "qTaskSetCallback\0"
	.byte	0x1
	.byte	0x7d
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0xa1a
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x7d
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF6
	.byte	0x1
	.byte	0x7d
	.long	0x2ba
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "qTaskSetState\0"
	.byte	0x1
	.byte	0x8a
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0xa60
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x8a
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1a
	.ascii "State\0"
	.byte	0x1
	.byte	0x8a
	.long	0x240
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "qTaskSetUserData\0"
	.byte	0x1
	.byte	0x9c
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0xaa7
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x9c
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1a
	.ascii "arg\0"
	.byte	0x1
	.byte	0x9c
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x19
	.ascii "qTaskClearTimeElapsed\0"
	.byte	0x1
	.byte	0xa8
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xae5
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xa8
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x17
	.ascii "qTaskQueueEvent\0"
	.byte	0x1
	.byte	0xbf
	.long	0xfb
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xb3e
	.uleb128 0x18
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xbf
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.secrel32	.LASF5
	.byte	0x1
	.byte	0xbf
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1b
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0xc1
	.long	0x49a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x19
	.ascii "qSchedulerSetInterruptsED\0"
	.byte	0x1
	.byte	0xd4
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xb98
	.uleb128 0x1a
	.ascii "Restorer\0"
	.byte	0x1
	.byte	0xd4
	.long	0x613
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1a
	.ascii "Disabler\0"
	.byte	0x1
	.byte	0xd4
	.long	0x602
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1c
	.ascii "_qPrioQueueExtract\0"
	.byte	0x1
	.byte	0xd9
	.long	0x462
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xc14
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xda
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1b
	.ascii "i\0"
	.byte	0x1
	.byte	0xdb
	.long	0x145
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1b
	.ascii "IndexTaskToExtract\0"
	.byte	0x1
	.byte	0xdc
	.long	0x145
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1b
	.ascii "MaxpValue\0"
	.byte	0x1
	.byte	0xdf
	.long	0x219
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.byte	0
	.uleb128 0x19
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0xf0
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xc9c
	.uleb128 0x1a
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0xf0
	.long	0x1f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1a
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0xf0
	.long	0x2ba
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1a
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0xf0
	.long	0x61e
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1a
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0xf0
	.long	0x145
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1b
	.ascii "i\0"
	.byte	0x1
	.byte	0xf1
	.long	0x145
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x1e
	.ascii "qSchedulerAddxTask\0"
	.byte	0x1
	.word	0x128
	.long	0xfb
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xd49
	.uleb128 0x1f
	.secrel32	.LASF4
	.byte	0x1
	.word	0x128
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.secrel32	.LASF6
	.byte	0x1
	.word	0x128
	.long	0x2ba
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1f
	.secrel32	.LASF2
	.byte	0x1
	.word	0x128
	.long	0x219
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x20
	.ascii "Time\0"
	.byte	0x1
	.word	0x128
	.long	0x1f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x20
	.ascii "nExecutions\0"
	.byte	0x1
	.word	0x128
	.long	0x22c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x20
	.ascii "InitialState\0"
	.byte	0x1
	.word	0x128
	.long	0x240
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x20
	.ascii "arg\0"
	.byte	0x1
	.word	0x128
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x21
	.ascii "qSchedulerAddeTask\0"
	.byte	0x1
	.word	0x154
	.long	0xfb
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xdb7
	.uleb128 0x1f
	.secrel32	.LASF4
	.byte	0x1
	.word	0x154
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.secrel32	.LASF3
	.byte	0x1
	.word	0x154
	.long	0x2ba
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1f
	.secrel32	.LASF2
	.byte	0x1
	.word	0x154
	.long	0x219
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x20
	.ascii "arg\0"
	.byte	0x1
	.word	0x154
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x22
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.word	0x158
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xe01
	.uleb128 0x1f
	.secrel32	.LASF4
	.byte	0x1
	.word	0x158
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "Event\0"
	.byte	0x1
	.word	0x158
	.long	0x1df
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x22
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.word	0x162
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xe85
	.uleb128 0x23
	.ascii "a\0"
	.byte	0x1
	.word	0x163
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x23
	.ascii "b\0"
	.byte	0x1
	.word	0x163
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x23
	.ascii "c\0"
	.byte	0x1
	.word	0x163
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x23
	.ascii "e\0"
	.byte	0x1
	.word	0x163
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x23
	.ascii "tmp\0"
	.byte	0x1
	.word	0x163
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x23
	.ascii "head\0"
	.byte	0x1
	.word	0x164
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x1e
	.ascii "qTaskLinkRingBuffer\0"
	.byte	0x1
	.word	0x18d
	.long	0xfb
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xedd
	.uleb128 0x1f
	.secrel32	.LASF4
	.byte	0x1
	.word	0x18d
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "RingBuffer\0"
	.byte	0x1
	.word	0x18d
	.long	0x46d
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x24
	.ascii "_qTriggerReleaseSchedEvent\0"
	.byte	0x1
	.word	0x194
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x24
	.ascii "_qTriggerIdleTask\0"
	.byte	0x1
	.word	0x19d
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x25
	.ascii "qSchedulerRun\0"
	.byte	0x1
	.word	0x1ab
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0xfcc
	.uleb128 0x26
	.secrel32	.LASF4
	.byte	0x1
	.word	0x1ac
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x23
	.ascii "qTask\0"
	.byte	0x1
	.word	0x1ac
	.long	0x462
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x23
	.ascii "RBuffData\0"
	.byte	0x1
	.word	0x1ad
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x27
	.ascii "qMainSchedule\0"
	.byte	0x1
	.word	0x1ae
	.quad	.L66
	.uleb128 0x27
	.ascii "qReleasedSchedule\0"
	.byte	0x1
	.word	0x1ca
	.quad	.L68
	.byte	0
	.uleb128 0x1e
	.ascii "qStateMachine_Init\0"
	.byte	0x1
	.word	0x1ea
	.long	0xfb
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0x106d
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x1ea
	.long	0x6e0
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "InitState\0"
	.byte	0x1
	.word	0x1ea
	.long	0x792
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x20
	.ascii "SuccessState\0"
	.byte	0x1
	.word	0x1ea
	.long	0x7a6
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x20
	.ascii "FailureState\0"
	.byte	0x1
	.word	0x1ea
	.long	0x7a6
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x20
	.ascii "UnexpectedState\0"
	.byte	0x1
	.word	0x1ea
	.long	0x7a6
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0x25
	.ascii "qStateMachine_Run\0"
	.byte	0x1
	.word	0x201
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x10c9
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x201
	.long	0x6e0
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "Data\0"
	.byte	0x1
	.word	0x201
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x23
	.ascii "prev\0"
	.byte	0x1
	.word	0x202
	.long	0x792
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1e
	.ascii "qSTimerSet\0"
	.byte	0x1
	.word	0x22c
	.long	0x250
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x1112
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x22c
	.long	0x1112
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "Time\0"
	.byte	0x1
	.word	0x22c
	.long	0x1f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x7ed
	.uleb128 0x21
	.ascii "qSTimerFreeRun\0"
	.byte	0x1
	.word	0x249
	.long	0x250
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x1165
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x249
	.long	0x1112
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "Time\0"
	.byte	0x1
	.word	0x249
	.long	0x1f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1e
	.ascii "qSTimerExpired\0"
	.byte	0x1
	.word	0x262
	.long	0x250
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0x11a2
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x262
	.long	0x1112
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1e
	.ascii "qSTimerElapsed\0"
	.byte	0x1
	.word	0x273
	.long	0x209
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.long	0x11df
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x273
	.long	0x1112
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.ascii "qSTimerRemaining\0"
	.byte	0x1
	.word	0x283
	.long	0x209
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.long	0x1231
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x283
	.long	0x1112
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x23
	.ascii "elapsed\0"
	.byte	0x1
	.word	0x284
	.long	0x209
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x28
	.ascii "qSTimerDisarm\0"
	.byte	0x1
	.word	0x290
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.long	0x1269
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x290
	.long	0x1112
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.ascii "qMemoryAlloc\0"
	.byte	0x1
	.word	0x2a5
	.long	0x2a8
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.long	0x12fc
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x2a5
	.long	0x12fc
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "size\0"
	.byte	0x1
	.word	0x2a5
	.long	0x163
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x23
	.ascii "i\0"
	.byte	0x1
	.word	0x2a6
	.long	0x145
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x23
	.ascii "j\0"
	.byte	0x1
	.word	0x2a6
	.long	0x145
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x23
	.ascii "k\0"
	.byte	0x1
	.word	0x2a6
	.long	0x145
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.uleb128 0x23
	.ascii "sum\0"
	.byte	0x1
	.word	0x2a7
	.long	0x163
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x23
	.ascii "offset\0"
	.byte	0x1
	.word	0x2a8
	.long	0x85e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x864
	.uleb128 0x25
	.ascii "qMemoryFree\0"
	.byte	0x1
	.word	0x2d7
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.uleb128 0x1
	.byte	0x9c
	.long	0x1362
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x2d7
	.long	0x12fc
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "pmem\0"
	.byte	0x1
	.word	0x2d7
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x23
	.ascii "i\0"
	.byte	0x1
	.word	0x2d8
	.long	0x145
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x23
	.ascii "p\0"
	.byte	0x1
	.word	0x2d8
	.long	0x85e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x29
	.ascii "_qRBufferValidPowerOfTwo\0"
	.byte	0x1
	.word	0x2ec
	.long	0x163
	.quad	.LFB31
	.quad	.LFE31-.LFB31
	.uleb128 0x1
	.byte	0x9c
	.long	0x13b4
	.uleb128 0x20
	.ascii "k\0"
	.byte	0x1
	.word	0x2ec
	.long	0x163
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x23
	.ascii "i\0"
	.byte	0x1
	.word	0x2ed
	.long	0xfb
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x29
	.ascii "_qRBufferCount\0"
	.byte	0x1
	.word	0x2f6
	.long	0x114
	.quad	.LFB32
	.quad	.LFE32-.LFB32
	.uleb128 0x1
	.byte	0x9c
	.long	0x13f1
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x2f6
	.long	0x46d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x2a
	.ascii "_qRBufferFull\0"
	.byte	0x1
	.word	0x2fa
	.long	0x250
	.quad	.LFB33
	.quad	.LFE33-.LFB33
	.uleb128 0x1
	.byte	0x9c
	.long	0x142d
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x2fa
	.long	0x46d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x25
	.ascii "qRBufferInit\0"
	.byte	0x1
	.word	0x30f
	.quad	.LFB34
	.quad	.LFE34-.LFB34
	.uleb128 0x1
	.byte	0x9c
	.long	0x14a0
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x30f
	.long	0x46d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "DataBlock\0"
	.byte	0x1
	.word	0x30f
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1f
	.secrel32	.LASF1
	.byte	0x1
	.word	0x30f
	.long	0x163
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x20
	.ascii "ElementCount\0"
	.byte	0x1
	.word	0x30f
	.long	0x163
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x21
	.ascii "qRBufferEmpty\0"
	.byte	0x1
	.word	0x325
	.long	0x250
	.quad	.LFB35
	.quad	.LFE35-.LFB35
	.uleb128 0x1
	.byte	0x9c
	.long	0x14dc
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x325
	.long	0x46d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.ascii "qRBufferGetFront\0"
	.byte	0x1
	.word	0x335
	.long	0x2a8
	.quad	.LFB36
	.quad	.LFE36-.LFB36
	.uleb128 0x1
	.byte	0x9c
	.long	0x151b
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x335
	.long	0x46d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.ascii "qRBufferPopFront\0"
	.byte	0x1
	.word	0x348
	.long	0x2a8
	.quad	.LFB37
	.quad	.LFE37-.LFB37
	.uleb128 0x1
	.byte	0x9c
	.long	0x156a
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x348
	.long	0x46d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x23
	.ascii "data\0"
	.byte	0x1
	.word	0x34a
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x21
	.ascii "qRBufferPush\0"
	.byte	0x1
	.word	0x35f
	.long	0x250
	.quad	.LFB38
	.quad	.LFE38-.LFB38
	.uleb128 0x1
	.byte	0x9c
	.long	0x1601
	.uleb128 0x20
	.ascii "obj\0"
	.byte	0x1
	.word	0x35f
	.long	0x46d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x20
	.ascii "data\0"
	.byte	0x1
	.word	0x35f
	.long	0x2a8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x23
	.ascii "status\0"
	.byte	0x1
	.word	0x360
	.long	0x250
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x23
	.ascii "data_element\0"
	.byte	0x1
	.word	0x361
	.long	0x85e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x23
	.ascii "ring_data\0"
	.byte	0x1
	.word	0x362
	.long	0x382
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x23
	.ascii "i\0"
	.byte	0x1
	.word	0x363
	.long	0x163
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x2b
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x15
	.long	0x161a
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0xd
	.long	0x629
	.uleb128 0x2b
	.ascii "_qSysTick_Epochs_\0"
	.byte	0x1
	.byte	0x16
	.long	0x458
	.uleb128 0x9
	.byte	0x3
	.quad	_qSysTick_Epochs_
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
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x4
	.byte	0x1
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
	.uleb128 0x1a
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
	.uleb128 0x1f
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
	.uleb128 0x20
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
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x23
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
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0
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
	.byte	0
	.byte	0
	.uleb128 0x25
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
	.uleb128 0x26
	.uleb128 0x34
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
	.uleb128 0x27
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
	.uleb128 0x28
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
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x2b
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
.LASF6:
	.ascii "CallbackFcn\0"
.LASF1:
	.ascii "ElementSize\0"
.LASF2:
	.ascii "Priority\0"
.LASF3:
	.ascii "Callback\0"
.LASF5:
	.ascii "eventdata\0"
.LASF0:
	.ascii "UserData\0"
.LASF4:
	.ascii "Task\0"
	.ident	"GCC: (GNU) 5.4.0"
