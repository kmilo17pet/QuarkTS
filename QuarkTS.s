	.file	"QuarkTS.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	QUARKTS, 104, 6
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
	je	.L9
	.loc 1 139 0
	jmp	.L8
.L9:
	.loc 1 140 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 50(%rax)
	.loc 1 141 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
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
	jl	.L14
	.loc 1 192 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L16
.L14:
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
.L16:
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
	jns	.L19
	.loc 1 221 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L20
.L19:
	.loc 1 222 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L21
	.loc 1 222 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L21:
	.loc 1 223 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	movb	%al, -3(%rbp)
	.loc 1 224 0
	movb	$1, -1(%rbp)
	jmp	.L22
.L26:
	.loc 1 225 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L23
	jmp	.L24
.L23:
	.loc 1 226 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	cmpb	-3(%rbp), %al
	jbe	.L25
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
.L25:
	.loc 1 224 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L22:
	.loc 1 224 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L26
.L24:
	.loc 1 231 0 is_stmt 1
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
	jmp	.L27
.L28:
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
.L27:
	.loc 1 234 0 discriminator 1
	movzbl	-1(%rbp), %edx
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	cwtl
	cmpl	%eax, %edx
	jl	.L28
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
	je	.L29
	.loc 1 236 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L29:
	.loc 1 237 0 is_stmt 1
	movq	-16(%rbp), %rax
.L20:
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
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 16(%rdx)
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
	jmp	.L31
.L32:
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
.L31:
	.loc 1 248 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L32
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
	jbe	.L34
	.loc 1 297 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L36
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L36
.L34:
	.loc 1 297 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L37
.L36:
	.loc 1 297 0 discriminator 5
	movl	$-1, %eax
	jmp	.L38
.L37:
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
.L38:
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
	je	.L43
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
.L43:
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
	je	.L45
	.loc 1 357 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L45:
	.loc 1 358 0 is_stmt 1
	jmp	.L46
.L53:
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
	jmp	.L47
.L52:
	.loc 1 362 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	%al, %dl
	jnb	.L48
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
	jne	.L49
	.loc 1 365 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L50
.L49:
	.loc 1 366 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L50:
	.loc 1 367 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 368 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L51
.L48:
	.loc 1 371 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 372 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L51:
	.loc 1 374 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 375 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L47
	.loc 1 375 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L47:
	.loc 1 361 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L52
.L46:
	.loc 1 358 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L53
	.loc 1 378 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L44
	.loc 1 378 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
	nop
.L44:
	.loc 1 379 0 is_stmt 1
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
	.loc 1 396 0
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
	.loc 1 397 0
	cmpq	$0, 24(%rbp)
	jne	.L56
	.loc 1 397 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L57
.L56:
	.loc 1 398 0 is_stmt 1
	movq	24(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L58
	.loc 1 398 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L57
.L58:
	.loc 1 399 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 400 0
	movl	$0, %eax
.L57:
	.loc 1 401 0
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
	.loc 1 403 0
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
	.loc 1 404 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 405 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 406 0
	leaq	QUARKTS(%rip), %rax
	movzbl	83(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 407 0
	leaq	QUARKTS(%rip), %rax
	movl	$3, 24(%rax)
	.loc 1 408 0
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L60
	.loc 1 408 0 is_stmt 0 discriminator 1
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
.L60:
	.loc 1 409 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 410 0
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
	.loc 1 412 0
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
	.loc 1 413 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 414 0
	leaq	QUARKTS(%rip), %rax
	movl	$1, 24(%rax)
	.loc 1 415 0
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
	.loc 1 416 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 417 0
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
	.loc 1 426 0
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
	.loc 1 428 0
	movq	$0, -16(%rbp)
.L63:
	.loc 1 430 0
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	je	.L64
	jmp	.L81
.L64:
	.loc 1 431 0
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	testb	%al, %al
	jne	.L66
	.loc 1 432 0
	call	_qTaskChainbyPriority
	.loc 1 433 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 80(%rax)
.L66:
	.loc 1 435 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 436 0
	jmp	.L67
.L80:
	.loc 1 437 0
	call	_qPrioQueueExtract
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L68
	.loc 1 437 0 is_stmt 0 discriminator 1
	movq	-24(%rbp), %rax
	movl	$2, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L68:
	.loc 1 438 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	-8(%rbp), %rax
	movl	20(%rax), %eax
	subl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	%eax, %edx
	jnb	.L69
	.loc 1 438 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L70
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L71
.L70:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L71:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L72
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L72
.L69:
	.loc 1 438 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L74
	.loc 1 438 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	jne	.L72
.L74:
	.loc 1 438 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L72
	.loc 1 439 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 440 0
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	je	.L75
	.loc 1 440 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 24(%rax)
.L75:
	.loc 1 441 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L76
	.loc 1 441 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
.L76:
	.loc 1 442 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L77
.L72:
	.loc 1 444 0
	movq	-8(%rbp), %rax
	movq	64(%rax), %rax
	movq	%rax, %rcx
	call	qRBufferPopFront
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L78
	.loc 1 445 0
	leaq	QUARKTS(%rip), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 446 0
	movq	-8(%rbp), %rax
	movl	$4, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L77
.L78:
	.loc 1 448 0
	movq	-8(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	je	.L79
	.loc 1 449 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 450 0
	movq	-8(%rbp), %rax
	movb	$0, 49(%rax)
	.loc 1 451 0
	movq	-8(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L77
.L79:
	.loc 1 453 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L77
	.loc 1 453 0 is_stmt 0 discriminator 1
	call	_qTriggerIdleTask
.L77:
	.loc 1 454 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L67:
	.loc 1 436 0
	cmpq	$0, -8(%rbp)
	jne	.L80
	.loc 1 456 0
	jmp	.L63
.L81:
.L65:
	.loc 1 457 0
	call	_qTriggerReleaseSchedEvent
	nop
	.loc 1 458 0
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
	.loc 1 489 0
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
	.loc 1 490 0
	cmpq	$0, 24(%rbp)
	jne	.L83
	.loc 1 490 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L84
.L83:
	.loc 1 491 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 492 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 493 0
	movq	16(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 32(%rax)
	.loc 1 494 0
	movq	16(%rbp), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 495 0
	movq	16(%rbp), %rax
	movq	48(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 496 0
	movl	$0, %eax
.L84:
	.loc 1 497 0
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
	.loc 1 512 0
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
	.loc 1 513 0
	movq	$0, -8(%rbp)
	.loc 1 514 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 515 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L86
	.loc 1 516 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 20(%rax)
	.loc 1 517 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 518 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 519 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L87
.L86:
	.loc 1 521 0
	movq	16(%rbp), %rax
	movl	$-32767, 16(%rax)
.L87:
	.loc 1 523 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$-32768, %eax
	je	.L89
	cmpl	$-32767, %eax
	jne	.L95
	.loc 1 525 0
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	testq	%rax, %rax
	je	.L91
	.loc 1 525 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 526 0 is_stmt 1 discriminator 1
	jmp	.L85
.L91:
	.loc 1 526 0 is_stmt 0
	jmp	.L85
.L89:
	.loc 1 528 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L93
	.loc 1 528 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 529 0 is_stmt 1 discriminator 1
	jmp	.L85
.L93:
	.loc 1 529 0 is_stmt 0
	jmp	.L85
.L95:
	.loc 1 531 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	je	.L94
	.loc 1 531 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
.L94:
	.loc 1 532 0 is_stmt 1
	nop
.L85:
	.loc 1 534 0
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
	.loc 1 555 0
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
	.loc 1 556 0
	cvtss2sd	24(%rbp), %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	ucomisd	%xmm1, %xmm0
	jbe	.L101
	.loc 1 556 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L99
.L101:
	.loc 1 557 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 8(%rax)
	.loc 1 558 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 4(%rax)
	.loc 1 559 0
	movq	16(%rbp), %rax
	movb	$1, (%rax)
	.loc 1 560 0
	movl	$0, %eax
.L99:
	.loc 1 561 0
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
	.loc 1 584 0
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
	movss	%xmm1, 24(%rbp)
	.loc 1 585 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L103
	.loc 1 586 0
	movq	16(%rbp), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L104
	.loc 1 587 0
	movq	16(%rbp), %rcx
	call	qSTimerDisarm
	.loc 1 588 0
	movl	$1, %eax
	jmp	.L105
.L104:
	.loc 1 590 0
	movl	$0, %eax
	jmp	.L105
.L103:
	.loc 1 592 0
	movl	24(%rbp), %eax
	movl	%eax, -4(%rbp)
	movss	-4(%rbp), %xmm1
	movq	16(%rbp), %rcx
	call	qSTimerSet
.L105:
	.loc 1 593 0
	addq	$48, %rsp
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
	.loc 1 609 0
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
	.loc 1 610 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L107
	.loc 1 610 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L108
.L107:
	.loc 1 611 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	%eax, %edx
	setnb	%al
.L108:
	.loc 1 612 0
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
	.loc 1 626 0
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
	.loc 1 627 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	.loc 1 628 0
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
	.loc 1 642 0
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
	.loc 1 643 0
	movq	16(%rbp), %rcx
	call	qSTimerElapsed
	movl	%eax, -4(%rbp)
	.loc 1 644 0
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L112
	.loc 1 644 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	-4(%rbp), %eax
	jnb	.L113
.L112:
	.loc 1 644 0 discriminator 3
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	jmp	.L114
.L113:
	.loc 1 644 0 discriminator 4
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	subl	-4(%rbp), %eax
.L114:
	.loc 1 645 0 is_stmt 1 discriminator 6
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
	.loc 1 655 0
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
	.loc 1 656 0
	movq	16(%rbp), %rax
	movb	$0, (%rax)
	.loc 1 657 0
	movq	16(%rbp), %rax
	movl	$0, 4(%rax)
	.loc 1 658 0
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
	.loc 1 676 0
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
	.loc 1 679 0
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 680 0
	movb	$0, -2(%rbp)
	.loc 1 681 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L118
	.loc 1 681 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L118:
	.loc 1 682 0 is_stmt 1
	jmp	.L119
.L132:
	.loc 1 683 0
	movw	$0, -6(%rbp)
	.loc 1 684 0
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	.loc 1 685 0
	jmp	.L120
.L123:
	.loc 1 686 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L121
	.loc 1 687 0
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
	.loc 1 688 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	addb	%al, -1(%rbp)
	.loc 1 689 0
	jmp	.L120
.L121:
	.loc 1 691 0
	jmp	.L122
.L120:
	.loc 1 685 0
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L123
.L122:
	.loc 1 693 0
	movzbl	-1(%rbp), %eax
	movb	%al, -2(%rbp)
	.loc 1 694 0
	movb	$1, -3(%rbp)
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	jmp	.L124
.L130:
	.loc 1 695 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L125
	.loc 1 696 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movzbl	-1(%rbp), %eax
	addl	%edx, %eax
	movb	%al, -2(%rbp)
	.loc 1 697 0
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 698 0
	movzbl	-2(%rbp), %edx
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	cltq
	addq	%rax, -16(%rbp)
	.loc 1 699 0
	jmp	.L126
.L125:
	.loc 1 701 0
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	addw	%ax, -6(%rbp)
	.loc 1 702 0
	movzwl	-6(%rbp), %eax
	cmpw	24(%rbp), %ax
	jb	.L127
	.loc 1 703 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-2(%rbp), %eax
	addq	%rax, %rdx
	movzbl	-3(%rbp), %eax
	movb	%al, (%rdx)
	.loc 1 704 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L128
	.loc 1 704 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L128:
	.loc 1 705 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L129
.L127:
	.loc 1 694 0 discriminator 2
	movzbl	-3(%rbp), %eax
	addl	$1, %eax
	movb	%al, -3(%rbp)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L124:
	.loc 1 694 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L130
.L126:
	.loc 1 708 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	jne	.L119
	jmp	.L131
.L119:
	.loc 1 682 0
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-2(%rbp), %al
	ja	.L132
.L131:
	.loc 1 710 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L133
	.loc 1 710 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L133:
	.loc 1 711 0 is_stmt 1
	movl	$0, %eax
.L129:
	.loc 1 712 0
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
	.loc 1 726 0
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
	.loc 1 728 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L135
	.loc 1 728 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L135:
	.loc 1 729 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 730 0
	movb	$0, -1(%rbp)
	jmp	.L136
.L139:
	.loc 1 731 0
	movq	-16(%rbp), %rax
	cmpq	24(%rbp), %rax
	jne	.L137
	.loc 1 732 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movb	$0, (%rax)
	.loc 1 733 0
	jmp	.L138
.L137:
	.loc 1 735 0 discriminator 2
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	addq	%rax, -16(%rbp)
	.loc 1 730 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L136:
	.loc 1 730 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L139
.L138:
	.loc 1 737 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L134
	.loc 1 737 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
	nop
.L134:
	.loc 1 738 0 is_stmt 1
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
	.loc 1 747 0
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
	.loc 1 749 0
	movzwl	16(%rbp), %eax
	leal	-1(%rax), %edx
	movzwl	16(%rbp), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	je	.L142
	.loc 1 750 0
	movzwl	16(%rbp), %eax
	subl	$1, %eax
	movw	%ax, 16(%rbp)
	.loc 1 751 0
	movw	$1, -2(%rbp)
	jmp	.L143
.L144:
	.loc 1 751 0 is_stmt 0 discriminator 3
	movzwl	16(%rbp), %edx
	movzwl	-2(%rbp), %eax
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movzwl	16(%rbp), %eax
	orl	%edx, %eax
	movw	%ax, 16(%rbp)
	salw	-2(%rbp)
.L143:
	.loc 1 751 0 discriminator 1
	cmpw	$15, -2(%rbp)
	jbe	.L144
	.loc 1 752 0 is_stmt 1
	movzwl	16(%rbp), %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%rbp)
.L142:
	.loc 1 754 0
	movzwl	16(%rbp), %eax
	.loc 1 755 0
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
	.loc 1 757 0
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
	.loc 1 758 0
	cmpq	$0, 16(%rbp)
	je	.L147
	.loc 1 758 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzwl	12(%rax), %edx
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	.L148
.L147:
	.loc 1 758 0 discriminator 2
	movl	$0, %eax
.L148:
	.loc 1 759 0 is_stmt 1 discriminator 4
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
	.loc 1 761 0
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
	.loc 1 762 0
	cmpq	$0, 16(%rbp)
	je	.L151
	.loc 1 762 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rcx
	call	_qRBufferCount
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movzwl	10(%rax), %eax
	cmpw	%ax, %dx
	sete	%al
	movzbl	%al, %eax
	jmp	.L152
.L151:
	.loc 1 762 0 discriminator 2
	movl	$1, %eax
.L152:
	.loc 1 763 0 is_stmt 1 discriminator 4
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
	.loc 1 782 0
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
	.loc 1 783 0
	cmpq	$0, 16(%rbp)
	je	.L154
	.loc 1 784 0
	movq	16(%rbp), %rax
	movw	$0, 12(%rax)
	.loc 1 785 0
	movq	16(%rbp), %rax
	movw	$0, 14(%rax)
	.loc 1 786 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 787 0
	movq	16(%rbp), %rax
	movzwl	32(%rbp), %edx
	movw	%dx, 8(%rax)
	.loc 1 788 0
	movzwl	40(%rbp), %eax
	movl	%eax, %ecx
	call	_qRBufferValidPowerOfTwo
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movw	%dx, 10(%rax)
.L154:
	.loc 1 790 0
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
	.loc 1 804 0
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
	.loc 1 805 0
	cmpq	$0, 16(%rbp)
	je	.L157
	.loc 1 805 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rcx
	call	_qRBufferCount
	testw	%ax, %ax
	sete	%al
	movzbl	%al, %eax
	jmp	.L158
.L157:
	.loc 1 805 0 discriminator 2
	movl	$1, %eax
.L158:
	.loc 1 806 0 is_stmt 1 discriminator 4
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
	.loc 1 820 0
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
	.loc 1 821 0
	cmpq	$0, 16(%rbp)
	je	.L161
	.loc 1 822 0
	movq	16(%rbp), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L162
	.loc 1 822 0 is_stmt 0 discriminator 1
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
	jmp	.L164
.L162:
	.loc 1 822 0 discriminator 2
	movl	$0, %eax
	jmp	.L164
.L161:
	.loc 1 824 0 is_stmt 1
	movl	$0, %eax
.L164:
	.loc 1 825 0
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
	.loc 1 839 0
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
	.loc 1 840 0
	cmpq	$0, 16(%rbp)
	jne	.L166
	.loc 1 840 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L167
.L166:
	.loc 1 841 0 is_stmt 1
	movq	$0, -8(%rbp)
	.loc 1 842 0
	movq	16(%rbp), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L168
	.loc 1 843 0
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
	.loc 1 844 0
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movw	%dx, 14(%rax)
.L168:
	.loc 1 846 0
	movq	-8(%rbp), %rax
.L167:
	.loc 1 847 0
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
	.loc 1 862 0
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
	.loc 1 863 0
	movb	$0, -1(%rbp)
	.loc 1 864 0
	movq	24(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 865 0
	movq	$0, -24(%rbp)
	.loc 1 868 0
	cmpq	$0, 16(%rbp)
	je	.L170
	.loc 1 868 0 is_stmt 0 discriminator 1
	cmpq	$0, -16(%rbp)
	je	.L170
	.loc 1 869 0 is_stmt 1
	movq	16(%rbp), %rcx
	call	_qRBufferFull
	testb	%al, %al
	jne	.L170
	.loc 1 870 0
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
	.loc 1 871 0
	movw	$0, -4(%rbp)
	jmp	.L171
.L172:
	.loc 1 871 0 is_stmt 0 discriminator 3
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
.L171:
	.loc 1 871 0 discriminator 1
	movq	16(%rbp), %rax
	movzwl	8(%rax), %eax
	cmpw	-4(%rbp), %ax
	ja	.L172
	.loc 1 872 0 is_stmt 1
	movq	16(%rbp), %rax
	movzwl	12(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movw	%dx, 12(%rax)
	.loc 1 873 0
	movb	$1, -1(%rbp)
.L170:
	.loc 1 876 0
	movzbl	-1(%rbp), %eax
	.loc 1 877 0
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
	.long	0x1635
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
	.uleb128 0x3
	.ascii "__uint16_t\0"
	.byte	0x2
	.byte	0x2b
	.long	0xe3
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
	.long	0x112
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
	.ascii "uint16_t\0"
	.byte	0x3
	.byte	0x1a
	.long	0xd1
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x20
	.long	0x100
	.uleb128 0x4
	.byte	0x4
	.byte	0x4
	.byte	0x3b
	.long	0x1d9
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
	.uleb128 0x5
	.ascii "byRBufferPop\0"
	.sleb128 4
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x4
	.byte	0x3b
	.long	0x181
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x4
	.byte	0x3c
	.long	0x1fa
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x4
	.byte	0x3d
	.long	0x171
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x4
	.byte	0x3e
	.long	0x143
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x4
	.byte	0x3f
	.long	0x143
	.uleb128 0x3
	.ascii "qState_t\0"
	.byte	0x4
	.byte	0x40
	.long	0x143
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x4
	.byte	0x41
	.long	0x143
	.uleb128 0x6
	.byte	0x20
	.byte	0x4
	.byte	0x4c
	.long	0x2a2
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x4
	.byte	0x5f
	.long	0x1d9
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x63
	.long	0x2a2
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x4
	.byte	0x67
	.long	0x2a2
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x4
	.byte	0x6c
	.long	0x24a
	.byte	0x18
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x4
	.byte	0x6d
	.long	0x259
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x4
	.byte	0x6f
	.long	0x2c6
	.uleb128 0xa
	.byte	0x8
	.long	0x2cc
	.uleb128 0xb
	.long	0x2d7
	.uleb128 0xc
	.long	0x2a4
	.byte	0
	.uleb128 0x6
	.byte	0x3
	.byte	0x4
	.byte	0x70
	.long	0x312
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x4
	.byte	0x71
	.long	0x312
	.byte	0
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x4
	.byte	0x71
	.long	0x312
	.byte	0x1
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x4
	.byte	0x71
	.long	0x312
	.byte	0x2
	.byte	0
	.uleb128 0xd
	.long	0x143
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x4
	.byte	0x72
	.long	0x2d7
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0x76
	.long	0x37c
	.uleb128 0x7
	.ascii "data\0"
	.byte	0x4
	.byte	0x77
	.long	0x37c
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x78
	.long	0x382
	.byte	0x8
	.uleb128 0x7
	.ascii "Elementcount\0"
	.byte	0x4
	.byte	0x79
	.long	0x382
	.byte	0xa
	.uleb128 0x7
	.ascii "head\0"
	.byte	0x4
	.byte	0x7a
	.long	0x382
	.byte	0xc
	.uleb128 0x7
	.ascii "tail\0"
	.byte	0x4
	.byte	0x7b
	.long	0x382
	.byte	0xe
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x312
	.uleb128 0xd
	.long	0x161
	.uleb128 0x3
	.ascii "qRBuffer_t\0"
	.byte	0x4
	.byte	0x7c
	.long	0x32b
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x48
	.byte	0x4
	.byte	0x7e
	.long	0x452
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x7f
	.long	0x2a2
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x4
	.byte	0x7f
	.long	0x2a2
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x4
	.byte	0x80
	.long	0x452
	.byte	0x10
	.uleb128 0x7
	.ascii "ClockStart\0"
	.byte	0x4
	.byte	0x80
	.long	0x452
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x4
	.byte	0x81
	.long	0x226
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x4
	.byte	0x82
	.long	0x171
	.byte	0x1c
	.uleb128 0x8
	.secrel32	.LASF2
	.byte	0x4
	.byte	0x83
	.long	0x213
	.byte	0x20
	.uleb128 0x8
	.secrel32	.LASF3
	.byte	0x4
	.byte	0x84
	.long	0x2b4
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x85
	.long	0x457
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x4
	.byte	0x86
	.long	0x45c
	.byte	0x38
	.uleb128 0x7
	.ascii "RingBuff\0"
	.byte	0x4
	.byte	0x87
	.long	0x467
	.byte	0x40
	.byte	0
	.uleb128 0xd
	.long	0x203
	.uleb128 0xd
	.long	0x317
	.uleb128 0xa
	.byte	0x8
	.long	0x462
	.uleb128 0xd
	.long	0x399
	.uleb128 0xa
	.byte	0x8
	.long	0x387
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0x8b
	.long	0x494
	.uleb128 0x8
	.secrel32	.LASF4
	.byte	0x4
	.byte	0x8c
	.long	0x45c
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x4
	.byte	0x8d
	.long	0x2a2
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x4
	.byte	0x8e
	.long	0x46d
	.uleb128 0x6
	.byte	0x8
	.byte	0x4
	.byte	0x90
	.long	0x50d
	.uleb128 0x7
	.ascii "Init\0"
	.byte	0x4
	.byte	0x91
	.long	0x143
	.byte	0
	.uleb128 0x7
	.ascii "FCallIdle\0"
	.byte	0x4
	.byte	0x91
	.long	0x143
	.byte	0x1
	.uleb128 0x7
	.ascii "ReleaseSched\0"
	.byte	0x4
	.byte	0x91
	.long	0x143
	.byte	0x2
	.uleb128 0x7
	.ascii "FCallReleased\0"
	.byte	0x4
	.byte	0x91
	.long	0x143
	.byte	0x3
	.uleb128 0x7
	.ascii "IntFlags\0"
	.byte	0x4
	.byte	0x92
	.long	0x171
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x4
	.byte	0x93
	.long	0x4a9
	.uleb128 0x6
	.byte	0x68
	.byte	0x4
	.byte	0x95
	.long	0x5f7
	.uleb128 0x7
	.ascii "IDLECallback\0"
	.byte	0x4
	.byte	0x96
	.long	0x2b4
	.byte	0
	.uleb128 0x7
	.ascii "ReleaseSchedCallback\0"
	.byte	0x4
	.byte	0x97
	.long	0x2b4
	.byte	0x8
	.uleb128 0x7
	.ascii "Tick\0"
	.byte	0x4
	.byte	0x98
	.long	0x1eb
	.byte	0x10
	.uleb128 0x7
	.ascii "EventInfo\0"
	.byte	0x4
	.byte	0x99
	.long	0x2a4
	.byte	0x18
	.uleb128 0x7
	.ascii "First\0"
	.byte	0x4
	.byte	0x9a
	.long	0x45c
	.byte	0x38
	.uleb128 0x7
	.ascii "I_Disable\0"
	.byte	0x4
	.byte	0x9b
	.long	0x5fc
	.byte	0x40
	.uleb128 0x7
	.ascii "I_Restorer\0"
	.byte	0x4
	.byte	0x9c
	.long	0x60d
	.byte	0x48
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x9d
	.long	0x613
	.byte	0x50
	.uleb128 0x7
	.ascii "QueueStack\0"
	.byte	0x4
	.byte	0x9e
	.long	0x618
	.byte	0x58
	.uleb128 0x7
	.ascii "QueueSize\0"
	.byte	0x4
	.byte	0x9f
	.long	0x143
	.byte	0x60
	.uleb128 0x7
	.ascii "QueueIndex\0"
	.byte	0x4
	.byte	0xa0
	.long	0x152
	.byte	0x62
	.byte	0
	.uleb128 0xf
	.long	0x171
	.uleb128 0xa
	.byte	0x8
	.long	0x5f7
	.uleb128 0xb
	.long	0x60d
	.uleb128 0xc
	.long	0x171
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x602
	.uleb128 0xd
	.long	0x50d
	.uleb128 0xa
	.byte	0x8
	.long	0x61e
	.uleb128 0xd
	.long	0x494
	.uleb128 0x3
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x4
	.byte	0xa1
	.long	0x525
	.uleb128 0x10
	.byte	0x4
	.byte	0x4
	.word	0x100
	.long	0x670
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
	.word	0x100
	.long	0x63c
	.uleb128 0x12
	.byte	0x18
	.byte	0x4
	.word	0x119
	.long	0x6cb
	.uleb128 0x13
	.ascii "__Failure\0"
	.byte	0x4
	.word	0x11a
	.long	0x76d
	.byte	0
	.uleb128 0x13
	.ascii "__Success\0"
	.byte	0x4
	.word	0x11b
	.long	0x76d
	.byte	0x8
	.uleb128 0x13
	.ascii "__Unexpected\0"
	.byte	0x4
	.word	0x11c
	.long	0x76d
	.byte	0x10
	.byte	0
	.uleb128 0xb
	.long	0x6d6
	.uleb128 0xc
	.long	0x6d6
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x6dc
	.uleb128 0xd
	.long	0x6e1
	.uleb128 0x14
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x4
	.word	0x104
	.long	0x76d
	.uleb128 0x13
	.ascii "NextState\0"
	.byte	0x4
	.word	0x108
	.long	0x782
	.byte	0
	.uleb128 0x13
	.ascii "PreviousState\0"
	.byte	0x4
	.word	0x10c
	.long	0x782
	.byte	0x8
	.uleb128 0x13
	.ascii "PreviousReturnStatus\0"
	.byte	0x4
	.word	0x110
	.long	0x670
	.byte	0x10
	.uleb128 0x13
	.ascii "StateJustChanged\0"
	.byte	0x4
	.word	0x114
	.long	0x24a
	.byte	0x14
	.uleb128 0x13
	.ascii "Data\0"
	.byte	0x4
	.word	0x118
	.long	0x2a2
	.byte	0x18
	.uleb128 0x13
	.ascii "_\0"
	.byte	0x4
	.word	0x11d
	.long	0x685
	.byte	0x20
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x6cb
	.uleb128 0x15
	.long	0x670
	.long	0x782
	.uleb128 0xc
	.long	0x6d6
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x773
	.uleb128 0x11
	.ascii "qSM_State_t\0"
	.byte	0x4
	.word	0x11f
	.long	0x782
	.uleb128 0x11
	.ascii "qSM_ExState_t\0"
	.byte	0x4
	.word	0x120
	.long	0x76d
	.uleb128 0x12
	.byte	0xc
	.byte	0x4
	.word	0x153
	.long	0x7e3
	.uleb128 0x13
	.ascii "SR\0"
	.byte	0x4
	.word	0x154
	.long	0x24a
	.byte	0
	.uleb128 0x13
	.ascii "Start\0"
	.byte	0x4
	.word	0x155
	.long	0x203
	.byte	0x4
	.uleb128 0x13
	.ascii "TV\0"
	.byte	0x4
	.word	0x155
	.long	0x203
	.byte	0x8
	.byte	0
	.uleb128 0x11
	.ascii "qSTimer_t\0"
	.byte	0x4
	.word	0x156
	.long	0x7b2
	.uleb128 0x12
	.byte	0x18
	.byte	0x4
	.word	0x166
	.long	0x854
	.uleb128 0x13
	.ascii "BlockSize\0"
	.byte	0x4
	.word	0x167
	.long	0x161
	.byte	0
	.uleb128 0x13
	.ascii "NumberofBlocks\0"
	.byte	0x4
	.word	0x168
	.long	0x143
	.byte	0x2
	.uleb128 0x13
	.ascii "BlockDescriptors\0"
	.byte	0x4
	.word	0x169
	.long	0x854
	.byte	0x8
	.uleb128 0x13
	.ascii "Blocks\0"
	.byte	0x4
	.word	0x16a
	.long	0x854
	.byte	0x10
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x143
	.uleb128 0x11
	.ascii "qMemoryPool_t\0"
	.byte	0x4
	.word	0x16b
	.long	0x7f5
	.uleb128 0x16
	.ascii "qTaskGetCycles\0"
	.byte	0x1
	.byte	0x2a
	.long	0x171
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x8ab
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x2a
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSendEvent\0"
	.byte	0x1
	.byte	0x3c
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x8f0
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x3c
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x3c
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetTime\0"
	.byte	0x1
	.byte	0x4c
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x935
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x4c
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Value\0"
	.byte	0x1
	.byte	0x4c
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetIterations\0"
	.byte	0x1
	.byte	0x5f
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x980
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x5f
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Value\0"
	.byte	0x1
	.byte	0x5f
	.long	0x226
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetPriority\0"
	.byte	0x1
	.byte	0x6d
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x9c9
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x6d
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Value\0"
	.byte	0x1
	.byte	0x6d
	.long	0x213
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetCallback\0"
	.byte	0x1
	.byte	0x7d
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0xa10
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x7d
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF6
	.byte	0x1
	.byte	0x7d
	.long	0x2b4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetState\0"
	.byte	0x1
	.byte	0x8a
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0xa56
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x8a
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "State\0"
	.byte	0x1
	.byte	0x8a
	.long	0x23a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetUserData\0"
	.byte	0x1
	.byte	0x9c
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0xa9d
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x9c
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "arg\0"
	.byte	0x1
	.byte	0x9c
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskClearTimeElapsed\0"
	.byte	0x1
	.byte	0xa8
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xadb
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xa8
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.ascii "qTaskQueueEvent\0"
	.byte	0x1
	.byte	0xbf
	.long	0xf9
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xb34
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xbf
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF5
	.byte	0x1
	.byte	0xbf
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1a
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0xc1
	.long	0x494
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x18
	.ascii "qSchedulerSetInterruptsED\0"
	.byte	0x1
	.byte	0xd4
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xb8e
	.uleb128 0x19
	.ascii "Restorer\0"
	.byte	0x1
	.byte	0xd4
	.long	0x60d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Disabler\0"
	.byte	0x1
	.byte	0xd4
	.long	0x5fc
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1b
	.ascii "_qPrioQueueExtract\0"
	.byte	0x1
	.byte	0xd9
	.long	0x45c
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xc0a
	.uleb128 0x1c
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xda
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.ascii "i\0"
	.byte	0x1
	.byte	0xdb
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1a
	.ascii "IndexTaskToExtract\0"
	.byte	0x1
	.byte	0xdc
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1a
	.ascii "MaxpValue\0"
	.byte	0x1
	.byte	0xdf
	.long	0x213
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.byte	0
	.uleb128 0x18
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0xf0
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xc92
	.uleb128 0x19
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0xf0
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0xf0
	.long	0x2b4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0xf0
	.long	0x618
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x19
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0xf0
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1a
	.ascii "i\0"
	.byte	0x1
	.byte	0xf1
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x1d
	.ascii "qSchedulerAddxTask\0"
	.byte	0x1
	.word	0x128
	.long	0xf9
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xd3f
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x128
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.secrel32	.LASF6
	.byte	0x1
	.word	0x128
	.long	0x2b4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.secrel32	.LASF2
	.byte	0x1
	.word	0x128
	.long	0x213
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "Time\0"
	.byte	0x1
	.word	0x128
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1f
	.ascii "nExecutions\0"
	.byte	0x1
	.word	0x128
	.long	0x226
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1f
	.ascii "InitialState\0"
	.byte	0x1
	.word	0x128
	.long	0x23a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1f
	.ascii "arg\0"
	.byte	0x1
	.word	0x128
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x20
	.ascii "qSchedulerAddeTask\0"
	.byte	0x1
	.word	0x154
	.long	0xf9
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xdad
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x154
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.secrel32	.LASF3
	.byte	0x1
	.word	0x154
	.long	0x2b4
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.secrel32	.LASF2
	.byte	0x1
	.word	0x154
	.long	0x213
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "arg\0"
	.byte	0x1
	.word	0x154
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x21
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.word	0x158
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xdf7
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x158
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "Event\0"
	.byte	0x1
	.word	0x158
	.long	0x1d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x21
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.word	0x162
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xe7b
	.uleb128 0x22
	.ascii "a\0"
	.byte	0x1
	.word	0x163
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x22
	.ascii "b\0"
	.byte	0x1
	.word	0x163
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x22
	.ascii "c\0"
	.byte	0x1
	.word	0x163
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.ascii "e\0"
	.byte	0x1
	.word	0x163
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x22
	.ascii "tmp\0"
	.byte	0x1
	.word	0x163
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x22
	.ascii "head\0"
	.byte	0x1
	.word	0x164
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x1d
	.ascii "qTaskLinkRingBuffer\0"
	.byte	0x1
	.word	0x18c
	.long	0xf9
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xed3
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x18c
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "RingBuffer\0"
	.byte	0x1
	.word	0x18c
	.long	0x467
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x23
	.ascii "_qTriggerReleaseSchedEvent\0"
	.byte	0x1
	.word	0x193
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x23
	.ascii "_qTriggerIdleTask\0"
	.byte	0x1
	.word	0x19c
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x24
	.ascii "qSchedulerRun\0"
	.byte	0x1
	.word	0x1aa
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0xfc2
	.uleb128 0x25
	.secrel32	.LASF4
	.byte	0x1
	.word	0x1ab
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x22
	.ascii "qTask\0"
	.byte	0x1
	.word	0x1ab
	.long	0x45c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.ascii "RBuffData\0"
	.byte	0x1
	.word	0x1ac
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x26
	.ascii "qMainSchedule\0"
	.byte	0x1
	.word	0x1ad
	.quad	.L63
	.uleb128 0x26
	.ascii "qReleasedSchedule\0"
	.byte	0x1
	.word	0x1c9
	.quad	.L65
	.byte	0
	.uleb128 0x1d
	.ascii "qStateMachine_Init\0"
	.byte	0x1
	.word	0x1e9
	.long	0xf9
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0x1063
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x1e9
	.long	0x6d6
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "InitState\0"
	.byte	0x1
	.word	0x1e9
	.long	0x788
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1f
	.ascii "SuccessState\0"
	.byte	0x1
	.word	0x1e9
	.long	0x79c
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "FailureState\0"
	.byte	0x1
	.word	0x1e9
	.long	0x79c
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1f
	.ascii "UnexpectedState\0"
	.byte	0x1
	.word	0x1e9
	.long	0x79c
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0x24
	.ascii "qStateMachine_Run\0"
	.byte	0x1
	.word	0x200
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x10bf
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x200
	.long	0x6d6
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "Data\0"
	.byte	0x1
	.word	0x200
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x22
	.ascii "prev\0"
	.byte	0x1
	.word	0x201
	.long	0x788
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1d
	.ascii "qSTimerSet\0"
	.byte	0x1
	.word	0x22b
	.long	0x24a
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x1108
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x22b
	.long	0x1108
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "Time\0"
	.byte	0x1
	.word	0x22b
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x7e3
	.uleb128 0x20
	.ascii "qSTimerFreeRun\0"
	.byte	0x1
	.word	0x248
	.long	0x24a
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x115b
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x248
	.long	0x1108
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "Time\0"
	.byte	0x1
	.word	0x248
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1d
	.ascii "qSTimerExpired\0"
	.byte	0x1
	.word	0x261
	.long	0x24a
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0x1198
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x261
	.long	0x1108
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1d
	.ascii "qSTimerElapsed\0"
	.byte	0x1
	.word	0x272
	.long	0x203
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.long	0x11d5
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x272
	.long	0x1108
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "qSTimerRemaining\0"
	.byte	0x1
	.word	0x282
	.long	0x203
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.long	0x1227
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x282
	.long	0x1108
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x22
	.ascii "elapsed\0"
	.byte	0x1
	.word	0x283
	.long	0x203
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x27
	.ascii "qSTimerDisarm\0"
	.byte	0x1
	.word	0x28f
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.long	0x125f
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x28f
	.long	0x1108
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "qMemoryAlloc\0"
	.byte	0x1
	.word	0x2a4
	.long	0x2a2
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.long	0x12f2
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x2a4
	.long	0x12f2
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "size\0"
	.byte	0x1
	.word	0x2a4
	.long	0x161
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x22
	.ascii "i\0"
	.byte	0x1
	.word	0x2a5
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x22
	.ascii "j\0"
	.byte	0x1
	.word	0x2a5
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x22
	.ascii "k\0"
	.byte	0x1
	.word	0x2a5
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.uleb128 0x22
	.ascii "sum\0"
	.byte	0x1
	.word	0x2a6
	.long	0x161
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x22
	.ascii "offset\0"
	.byte	0x1
	.word	0x2a7
	.long	0x854
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x85a
	.uleb128 0x24
	.ascii "qMemoryFree\0"
	.byte	0x1
	.word	0x2d6
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.uleb128 0x1
	.byte	0x9c
	.long	0x1358
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x2d6
	.long	0x12f2
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "pmem\0"
	.byte	0x1
	.word	0x2d6
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x22
	.ascii "i\0"
	.byte	0x1
	.word	0x2d7
	.long	0x143
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x22
	.ascii "p\0"
	.byte	0x1
	.word	0x2d7
	.long	0x854
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x28
	.ascii "_qRBufferValidPowerOfTwo\0"
	.byte	0x1
	.word	0x2eb
	.long	0x161
	.quad	.LFB31
	.quad	.LFE31-.LFB31
	.uleb128 0x1
	.byte	0x9c
	.long	0x13aa
	.uleb128 0x1f
	.ascii "k\0"
	.byte	0x1
	.word	0x2eb
	.long	0x161
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x22
	.ascii "i\0"
	.byte	0x1
	.word	0x2ec
	.long	0x161
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.byte	0
	.uleb128 0x28
	.ascii "_qRBufferCount\0"
	.byte	0x1
	.word	0x2f5
	.long	0x161
	.quad	.LFB32
	.quad	.LFE32-.LFB32
	.uleb128 0x1
	.byte	0x9c
	.long	0x13e7
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x2f5
	.long	0x467
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x29
	.ascii "_qRBufferFull\0"
	.byte	0x1
	.word	0x2f9
	.long	0x24a
	.quad	.LFB33
	.quad	.LFE33-.LFB33
	.uleb128 0x1
	.byte	0x9c
	.long	0x1423
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x2f9
	.long	0x467
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x24
	.ascii "qRBufferInit\0"
	.byte	0x1
	.word	0x30e
	.quad	.LFB34
	.quad	.LFE34-.LFB34
	.uleb128 0x1
	.byte	0x9c
	.long	0x1496
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x30e
	.long	0x467
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "DataBlock\0"
	.byte	0x1
	.word	0x30e
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.secrel32	.LASF1
	.byte	0x1
	.word	0x30e
	.long	0x161
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "ElementCount\0"
	.byte	0x1
	.word	0x30e
	.long	0x161
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x20
	.ascii "qRBufferEmpty\0"
	.byte	0x1
	.word	0x324
	.long	0x24a
	.quad	.LFB35
	.quad	.LFE35-.LFB35
	.uleb128 0x1
	.byte	0x9c
	.long	0x14d2
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x324
	.long	0x467
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "qRBufferGetFront\0"
	.byte	0x1
	.word	0x334
	.long	0x2a2
	.quad	.LFB36
	.quad	.LFE36-.LFB36
	.uleb128 0x1
	.byte	0x9c
	.long	0x1511
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x334
	.long	0x467
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "qRBufferPopFront\0"
	.byte	0x1
	.word	0x347
	.long	0x2a2
	.quad	.LFB37
	.quad	.LFE37-.LFB37
	.uleb128 0x1
	.byte	0x9c
	.long	0x1560
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x347
	.long	0x467
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x22
	.ascii "data\0"
	.byte	0x1
	.word	0x349
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.ascii "qRBufferPush\0"
	.byte	0x1
	.word	0x35e
	.long	0x24a
	.quad	.LFB38
	.quad	.LFE38-.LFB38
	.uleb128 0x1
	.byte	0x9c
	.long	0x15f7
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x35e
	.long	0x467
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "data\0"
	.byte	0x1
	.word	0x35e
	.long	0x2a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x22
	.ascii "status\0"
	.byte	0x1
	.word	0x35f
	.long	0x24a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x22
	.ascii "data_element\0"
	.byte	0x1
	.word	0x360
	.long	0x854
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x22
	.ascii "ring_data\0"
	.byte	0x1
	.word	0x361
	.long	0x37c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.ascii "i\0"
	.byte	0x1
	.word	0x362
	.long	0x161
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x2a
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x15
	.long	0x1610
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0xd
	.long	0x623
	.uleb128 0x2a
	.ascii "_qSysTick_Epochs_\0"
	.byte	0x1
	.byte	0x16
	.long	0x452
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
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x4
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
	.uleb128 0x1f
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
	.uleb128 0x20
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
	.uleb128 0x21
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
	.uleb128 0x22
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
	.uleb128 0x23
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
	.uleb128 0x26
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
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
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
	.ident	"GCC: (GNU) 4.9.3"
