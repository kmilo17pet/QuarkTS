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
	.loc 1 49 0
	movq	16(%rbp), %rax
	movl	28(%rax), %eax
	.loc 1 50 0
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
	movq	%rdx, 24(%rbp)
	.loc 1 67 0
	movq	16(%rbp), %rax
	movb	$1, 49(%rax)
	.loc 1 68 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 69 0
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
	.loc 1 82 0
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
	.loc 1 83 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 84 0
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
	.loc 1 101 0
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
	.loc 1 102 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 103 0
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
	.loc 1 115 0
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
	.loc 1 116 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 117 0
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 118 0
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
	.loc 1 131 0
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
	.loc 1 132 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 133 0
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
	.loc 1 144 0
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
	.loc 1 145 0
	cmpb	$0, 24(%rbp)
	je	.L9
	.loc 1 145 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L9
	.loc 1 145 0
	jmp	.L8
.L9:
	.loc 1 146 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 50(%rax)
	.loc 1 147 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
.L8:
	.loc 1 148 0
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
	.loc 1 162 0
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
	.loc 1 163 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 164 0
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
	.loc 1 174 0
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
	.loc 1 175 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 176 0
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
	.loc 1 197 0
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
	.loc 1 198 0
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	movswl	%ax, %edx
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	movzbl	%al, %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jl	.L14
	.loc 1 198 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L16
.L14:
	.loc 1 200 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 201 0
	movq	24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 202 0
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
	.loc 1 203 0
	movl	$0, %eax
.L16:
	.loc 1 204 0 discriminator 1
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
	.loc 1 218 0
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
	.loc 1 219 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 220 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 64(%rax)
	.loc 1 221 0
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
	.loc 1 223 0
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
	.loc 1 224 0
	movq	$0, -16(%rbp)
	.loc 1 226 0
	movb	$0, -2(%rbp)
	.loc 1 227 0
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	testw	%ax, %ax
	jns	.L19
	.loc 1 227 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L20
.L19:
	.loc 1 228 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L21
	.loc 1 228 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L21:
	.loc 1 229 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	movb	%al, -3(%rbp)
	.loc 1 230 0
	movb	$1, -1(%rbp)
	jmp	.L22
.L26:
	.loc 1 231 0
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
	.loc 1 232 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	cmpb	-3(%rbp), %al
	jbe	.L25
	.loc 1 233 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	movb	%al, -3(%rbp)
	.loc 1 234 0
	movzbl	-1(%rbp), %eax
	movb	%al, -2(%rbp)
.L25:
	.loc 1 230 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L22:
	.loc 1 230 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L26
.L24:
	.loc 1 237 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 238 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 239 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-2(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	$0, (%rax)
	.loc 1 240 0
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	jmp	.L27
.L28:
	.loc 1 240 0 is_stmt 0 discriminator 3
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
	.loc 1 240 0 discriminator 1
	movzbl	-1(%rbp), %edx
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	cwtl
	cmpl	%eax, %edx
	jl	.L28
	.loc 1 241 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	subl	$1, %eax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movw	%dx, 98(%rax)
	.loc 1 242 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L29
	.loc 1 242 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L29:
	.loc 1 243 0 is_stmt 1
	movq	-16(%rbp), %rax
.L20:
	.loc 1 244 0
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
	.loc 1 246 0
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
	.loc 1 248 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 56(%rax)
	.loc 1 249 0
	leaq	QUARKTS(%rip), %rdx
	movl	16(%rbp), %eax
	movl	%eax, 16(%rdx)
	.loc 1 250 0
	leaq	QUARKTS(%rip), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 251 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 8(%rax)
	.loc 1 252 0
	leaq	QUARKTS(%rip), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 88(%rax)
	.loc 1 253 0
	leaq	QUARKTS(%rip), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 96(%rax)
	.loc 1 254 0
	movb	$0, -1(%rbp)
	jmp	.L31
.L32:
	.loc 1 254 0 is_stmt 0 discriminator 3
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
	.loc 1 254 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L32
	.loc 1 255 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movw	$-1, 98(%rax)
	.loc 1 256 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 257 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 258 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 83(%rax)
	.loc 1 259 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 72(%rax)
	.loc 1 260 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 64(%rax)
	.loc 1 261 0
	movl	$0, _qSysTick_Epochs_(%rip)
	.loc 1 262 0
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
	.loc 1 302 0
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
	.loc 1 303 0
	movss	40(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L34
	.loc 1 303 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L36
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L36
.L34:
	.loc 1 303 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L37
.L36:
	.loc 1 303 0 discriminator 5
	movl	$-1, %eax
	jmp	.L38
.L37:
	.loc 1 304 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 305 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 306 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 307 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 308 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 309 0
	movl	$0, %eax
	movq	16(%rbp), %rdx
	movb	%al, 53(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 53(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 51(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 48(%rdx)
	movq	16(%rbp), %rdx
	movb	%al, 49(%rdx)
	.loc 1 310 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 50(%rax)
	.loc 1 311 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 312 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 313 0
	movq	16(%rbp), %rax
	movl	$0, 28(%rax)
	.loc 1 314 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 315 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 316 0
	movq	16(%rbp), %rax
	movq	$0, 64(%rax)
	.loc 1 317 0
	movl	$0, %eax
.L38:
	.loc 1 318 0
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
	.loc 1 346 0
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
	.loc 1 347 0
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
	.loc 1 348 0
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
	.loc 1 350 0
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
	.loc 1 351 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 24(%rax)
	.loc 1 352 0
	movq	16(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 353 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 354 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L43
	.loc 1 354 0 is_stmt 0 discriminator 1
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
	.loc 1 355 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 48(%rax)
	.loc 1 356 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 40(%rax)
	.loc 1 357 0
	movq	16(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 28(%rax)
	.loc 1 358 0
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
	.loc 1 360 0
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
	.loc 1 361 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 362 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 363 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L45
	.loc 1 363 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L45:
	.loc 1 364 0 is_stmt 1
	jmp	.L46
.L53:
	.loc 1 365 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 366 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 367 0
	jmp	.L47
.L52:
	.loc 1 368 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	%al, %dl
	jnb	.L48
	.loc 1 369 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 370 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 371 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L49
	.loc 1 371 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L50
.L49:
	.loc 1 372 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L50:
	.loc 1 373 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 374 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L51
.L48:
	.loc 1 377 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 378 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L51:
	.loc 1 380 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 381 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L47
	.loc 1 381 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L47:
	.loc 1 367 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L52
.L46:
	.loc 1 364 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L53
	.loc 1 384 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L44
	.loc 1 384 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
	nop
.L44:
	.loc 1 385 0 is_stmt 1
	addq	$80, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.globl	qTaskLinkRBuffer
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskLinkRBuffer
qTaskLinkRBuffer:
.LFB17:
	.loc 1 423 0
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
	movl	%r8d, 32(%rbp)
	movl	%r9d, %eax
	movb	%al, 40(%rbp)
	.loc 1 424 0
	cmpq	$0, 24(%rbp)
	jne	.L56
	.loc 1 424 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L57
.L56:
	.loc 1 425 0 is_stmt 1
	movq	24(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L58
	.loc 1 425 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L57
.L58:
	.loc 1 426 0 is_stmt 1
	movl	32(%rbp), %eax
	cmpl	$1, %eax
	je	.L60
	cmpl	$1, %eax
	jb	.L61
	cmpl	$2, %eax
	je	.L62
	jmp	.L66
.L61:
	.loc 1 428 0
	movq	16(%rbp), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 51(%rax)
	.loc 1 429 0
	jmp	.L63
.L60:
	.loc 1 431 0
	movq	16(%rbp), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 52(%rax)
	.loc 1 432 0
	jmp	.L63
.L62:
	.loc 1 434 0
	movq	16(%rbp), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 53(%rax)
	.loc 1 435 0
	jmp	.L63
.L66:
	.loc 1 436 0
	movl	$-1, %eax
	jmp	.L57
.L63:
	.loc 1 438 0
	cmpb	$0, 40(%rbp)
	je	.L64
	.loc 1 438 0 is_stmt 0 discriminator 1
	movq	24(%rbp), %rax
	jmp	.L65
.L64:
	.loc 1 438 0 discriminator 2
	movl	$0, %eax
.L65:
	.loc 1 438 0 discriminator 4
	movq	16(%rbp), %rdx
	movq	%rax, 64(%rdx)
	.loc 1 439 0 is_stmt 1 discriminator 4
	movl	$0, %eax
.L57:
	.loc 1 440 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.def	_qCheckRBufferEvents;	.scl	3;	.type	32;	.endef
	.seh_proc	_qCheckRBufferEvents
_qCheckRBufferEvents:
.LFB18:
	.loc 1 442 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$56, %rsp
	.seh_stackalloc	56
	.cfi_def_cfa_offset 80
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -48
	.seh_endprologue
	movq	%rcx, -48(%rbp)
	.loc 1 443 0
	movq	-48(%rbp), %rax
	movq	64(%rax), %rax
	movq	%rax, -88(%rbp)
	.loc 1 444 0
	movq	$0, -96(%rbp)
	.loc 1 445 0
	cmpq	$0, -88(%rbp)
	jne	.L68
	.loc 1 445 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L69
.L68:
	.loc 1 446 0 is_stmt 1
	movq	-48(%rbp), %rax
	movzbl	52(%rax), %eax
	testb	%al, %al
	je	.L70
	.loc 1 446 0 is_stmt 0 discriminator 1
	movq	-88(%rbp), %rax
	movq	%rax, %rcx
	call	_qRBufferFull
	testb	%al, %al
	je	.L70
	.loc 1 447 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 448 0
	movl	$6, %eax
	jmp	.L69
.L70:
	.loc 1 450 0
	movq	-48(%rbp), %rax
	movzbl	53(%rax), %eax
	testb	%al, %al
	je	.L71
	.loc 1 450 0 is_stmt 0 discriminator 1
	movq	-48(%rbp), %rax
	movzbl	53(%rax), %eax
	movzbl	%al, %ebx
	movq	-88(%rbp), %rax
	movq	%rax, %rcx
	call	_qRBufferCount
	cmpw	%ax, %bx
	jb	.L71
	.loc 1 451 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 452 0
	movl	$7, %eax
	jmp	.L69
.L71:
	.loc 1 454 0
	movq	-48(%rbp), %rax
	movzbl	51(%rax), %eax
	testb	%al, %al
	je	.L72
	.loc 1 455 0
	movq	-88(%rbp), %rax
	movq	%rax, %rcx
	call	qRBufferPopFront
	movq	%rax, -96(%rbp)
	cmpq	$0, -96(%rbp)
	je	.L72
	.loc 1 456 0
	leaq	QUARKTS(%rip), %rax
	movq	-96(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 457 0
	movl	$5, %eax
	jmp	.L69
.L72:
	.loc 1 460 0
	movl	$0, %eax
.L69:
	.loc 1 461 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.def	_qTriggerReleaseSchedEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerReleaseSchedEvent
_qTriggerReleaseSchedEvent:
.LFB19:
	.loc 1 463 0
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
	.loc 1 464 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 465 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 466 0
	leaq	QUARKTS(%rip), %rax
	movzbl	83(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 467 0
	leaq	QUARKTS(%rip), %rax
	movl	$4, 24(%rax)
	.loc 1 468 0
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L74
	.loc 1 468 0 is_stmt 0 discriminator 1
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
.L74:
	.loc 1 469 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 470 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
	.def	_qTriggerIdleTask;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerIdleTask
_qTriggerIdleTask:
.LFB20:
	.loc 1 472 0
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
	.loc 1 473 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 474 0
	leaq	QUARKTS(%rip), %rax
	movl	$2, 24(%rax)
	.loc 1 475 0
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
	.loc 1 476 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 477 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.seh_endproc
	.globl	qSchedulerRun
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRun
qSchedulerRun:
.LFB21:
	.loc 1 486 0
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
	.loc 1 488 0
	movl	$0, -12(%rbp)
.L77:
	.loc 1 490 0
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	je	.L78
	jmp	.L95
.L78:
	.loc 1 491 0
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	testb	%al, %al
	jne	.L80
	.loc 1 492 0
	call	_qTaskChainbyPriority
	.loc 1 493 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 80(%rax)
.L80:
	.loc 1 495 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 496 0
	jmp	.L81
.L94:
	.loc 1 497 0
	call	_qPrioQueueExtract
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L82
	.loc 1 497 0 is_stmt 0 discriminator 1
	movq	-24(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L82:
	.loc 1 498 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	-8(%rbp), %rax
	movl	20(%rax), %eax
	subl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	%eax, %edx
	jnb	.L83
	.loc 1 498 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L84
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L85
.L84:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L85:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L86
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L86
.L83:
	.loc 1 498 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L88
	.loc 1 498 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	jne	.L86
.L88:
	.loc 1 498 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L86
	.loc 1 499 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 500 0
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	je	.L89
	.loc 1 500 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 24(%rax)
.L89:
	.loc 1 501 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L90
	.loc 1 501 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
.L90:
	.loc 1 502 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$1, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L91
.L86:
	.loc 1 504 0
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	_qCheckRBufferEvents
	movl	%eax, -12(%rbp)
	cmpl	$0, -12(%rbp)
	je	.L92
	.loc 1 504 0 is_stmt 0 discriminator 1
	movl	-12(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L91
.L92:
	.loc 1 505 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	je	.L93
	.loc 1 506 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 507 0
	movq	-8(%rbp), %rax
	movb	$0, 49(%rax)
	.loc 1 508 0
	movq	-8(%rbp), %rax
	movl	$4, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L91
.L93:
	.loc 1 510 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L91
	.loc 1 510 0 is_stmt 0 discriminator 1
	call	_qTriggerIdleTask
.L91:
	.loc 1 511 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L81:
	.loc 1 496 0
	cmpq	$0, -8(%rbp)
	jne	.L94
	.loc 1 513 0
	jmp	.L77
.L95:
.L79:
	.loc 1 514 0
	call	_qTriggerReleaseSchedEvent
	nop
	.loc 1 515 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
	.globl	qStateMachine_Init
	.def	qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Init
qStateMachine_Init:
.LFB22:
	.loc 1 546 0
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
	.loc 1 547 0
	cmpq	$0, 24(%rbp)
	jne	.L97
	.loc 1 547 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L98
.L97:
	.loc 1 548 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 549 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 550 0
	movq	16(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 32(%rax)
	.loc 1 551 0
	movq	16(%rbp), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 552 0
	movq	16(%rbp), %rax
	movq	48(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 553 0
	movl	$0, %eax
.L98:
	.loc 1 554 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.seh_endproc
	.globl	qStateMachine_Run
	.def	qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Run
qStateMachine_Run:
.LFB23:
	.loc 1 569 0
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
	.loc 1 570 0
	movq	$0, -8(%rbp)
	.loc 1 571 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 572 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L100
	.loc 1 573 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 20(%rax)
	.loc 1 574 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 575 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 576 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L101
.L100:
	.loc 1 578 0
	movq	16(%rbp), %rax
	movl	$-32767, 16(%rax)
.L101:
	.loc 1 580 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$-32768, %eax
	je	.L103
	cmpl	$-32767, %eax
	jne	.L109
	.loc 1 582 0
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	testq	%rax, %rax
	je	.L105
	.loc 1 582 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 583 0 is_stmt 1 discriminator 1
	jmp	.L99
.L105:
	.loc 1 583 0 is_stmt 0
	jmp	.L99
.L103:
	.loc 1 585 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L107
	.loc 1 585 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 586 0 is_stmt 1 discriminator 1
	jmp	.L99
.L107:
	.loc 1 586 0 is_stmt 0
	jmp	.L99
.L109:
	.loc 1 588 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	je	.L108
	.loc 1 588 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
.L108:
	.loc 1 589 0 is_stmt 1
	nop
.L99:
	.loc 1 591 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.seh_endproc
	.globl	qSTimerSet
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerSet
qSTimerSet:
.LFB24:
	.loc 1 612 0
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
	.loc 1 613 0
	cvtss2sd	24(%rbp), %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	ucomisd	%xmm1, %xmm0
	jbe	.L115
	.loc 1 613 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L113
.L115:
	.loc 1 614 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 8(%rax)
	.loc 1 615 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 4(%rax)
	.loc 1 616 0
	movq	16(%rbp), %rax
	movb	$1, (%rax)
	.loc 1 617 0
	movl	$0, %eax
.L113:
	.loc 1 618 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.seh_endproc
	.globl	qSTimerFreeRun
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerFreeRun
qSTimerFreeRun:
.LFB25:
	.loc 1 641 0
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
	.loc 1 642 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L117
	.loc 1 643 0
	movq	16(%rbp), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L118
	.loc 1 644 0
	movq	16(%rbp), %rcx
	call	qSTimerDisarm
	.loc 1 645 0
	movl	$1, %eax
	jmp	.L119
.L118:
	.loc 1 647 0
	movl	$0, %eax
	jmp	.L119
.L117:
	.loc 1 649 0
	movl	24(%rbp), %eax
	movl	%eax, -4(%rbp)
	movss	-4(%rbp), %xmm1
	movq	16(%rbp), %rcx
	call	qSTimerSet
.L119:
	.loc 1 650 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.seh_endproc
	.globl	qSTimerExpired
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerExpired
qSTimerExpired:
.LFB26:
	.loc 1 666 0
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
	.loc 1 667 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L121
	.loc 1 667 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L122
.L121:
	.loc 1 668 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	%eax, %edx
	setnb	%al
.L122:
	.loc 1 669 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.seh_endproc
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
.LFB27:
	.loc 1 683 0
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
	.loc 1 684 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	.loc 1 685 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.seh_endproc
	.globl	qSTimerRemaining
	.def	qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerRemaining
qSTimerRemaining:
.LFB28:
	.loc 1 699 0
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
	.loc 1 700 0
	movq	16(%rbp), %rcx
	call	qSTimerElapsed
	movl	%eax, -4(%rbp)
	.loc 1 701 0
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L126
	.loc 1 701 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	-4(%rbp), %eax
	jnb	.L127
.L126:
	.loc 1 701 0 discriminator 3
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	jmp	.L128
.L127:
	.loc 1 701 0 discriminator 4
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	subl	-4(%rbp), %eax
.L128:
	.loc 1 702 0 is_stmt 1 discriminator 6
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.seh_endproc
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
.LFB29:
	.loc 1 712 0
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
	.loc 1 713 0
	movq	16(%rbp), %rax
	movb	$0, (%rax)
	.loc 1 714 0
	movq	16(%rbp), %rax
	movl	$0, 4(%rax)
	.loc 1 715 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.seh_endproc
	.globl	qMemoryAlloc
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryAlloc
qMemoryAlloc:
.LFB30:
	.loc 1 733 0
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
	.loc 1 736 0
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 737 0
	movb	$0, -2(%rbp)
	.loc 1 738 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L132
	.loc 1 738 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L132:
	.loc 1 739 0 is_stmt 1
	jmp	.L133
.L146:
	.loc 1 740 0
	movw	$0, -6(%rbp)
	.loc 1 741 0
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	.loc 1 742 0
	jmp	.L134
.L137:
	.loc 1 743 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L135
	.loc 1 744 0
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
	.loc 1 745 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	addb	%al, -1(%rbp)
	.loc 1 746 0
	jmp	.L134
.L135:
	.loc 1 748 0
	jmp	.L136
.L134:
	.loc 1 742 0
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L137
.L136:
	.loc 1 750 0
	movzbl	-1(%rbp), %eax
	movb	%al, -2(%rbp)
	.loc 1 751 0
	movb	$1, -3(%rbp)
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	jmp	.L138
.L144:
	.loc 1 752 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L139
	.loc 1 753 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movzbl	-1(%rbp), %eax
	addl	%edx, %eax
	movb	%al, -2(%rbp)
	.loc 1 754 0
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 755 0
	movzbl	-2(%rbp), %edx
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	cltq
	addq	%rax, -16(%rbp)
	.loc 1 756 0
	jmp	.L140
.L139:
	.loc 1 758 0
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	addw	%ax, -6(%rbp)
	.loc 1 759 0
	movzwl	-6(%rbp), %eax
	cmpw	24(%rbp), %ax
	jb	.L141
	.loc 1 760 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-2(%rbp), %eax
	addq	%rax, %rdx
	movzbl	-3(%rbp), %eax
	movb	%al, (%rdx)
	.loc 1 761 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L142
	.loc 1 761 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L142:
	.loc 1 762 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L143
.L141:
	.loc 1 751 0 discriminator 2
	movzbl	-3(%rbp), %eax
	addl	$1, %eax
	movb	%al, -3(%rbp)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L138:
	.loc 1 751 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L144
.L140:
	.loc 1 765 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	jne	.L133
	jmp	.L145
.L133:
	.loc 1 739 0
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-2(%rbp), %al
	ja	.L146
.L145:
	.loc 1 767 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L147
	.loc 1 767 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L147:
	.loc 1 768 0 is_stmt 1
	movl	$0, %eax
.L143:
	.loc 1 769 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.seh_endproc
	.globl	qMemoryFree
	.def	qMemoryFree;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryFree
qMemoryFree:
.LFB31:
	.loc 1 783 0
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
	.loc 1 785 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L149
	.loc 1 785 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L149:
	.loc 1 786 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 787 0
	movb	$0, -1(%rbp)
	jmp	.L150
.L153:
	.loc 1 788 0
	movq	-16(%rbp), %rax
	cmpq	24(%rbp), %rax
	jne	.L151
	.loc 1 789 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movb	$0, (%rax)
	.loc 1 790 0
	jmp	.L152
.L151:
	.loc 1 792 0 discriminator 2
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	addq	%rax, -16(%rbp)
	.loc 1 787 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L150:
	.loc 1 787 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L153
.L152:
	.loc 1 794 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L148
	.loc 1 794 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
	nop
.L148:
	.loc 1 795 0 is_stmt 1
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.seh_endproc
	.def	_qRBufferValidPowerOfTwo;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferValidPowerOfTwo
_qRBufferValidPowerOfTwo:
.LFB32:
	.loc 1 800 0
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
	.loc 1 802 0
	movzwl	16(%rbp), %eax
	leal	-1(%rax), %edx
	movzwl	16(%rbp), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	je	.L156
	.loc 1 803 0
	movzwl	16(%rbp), %eax
	subl	$1, %eax
	movw	%ax, 16(%rbp)
	.loc 1 804 0
	movw	$1, -2(%rbp)
	jmp	.L157
.L158:
	.loc 1 804 0 is_stmt 0 discriminator 3
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
.L157:
	.loc 1 804 0 discriminator 1
	cmpw	$15, -2(%rbp)
	jbe	.L158
	.loc 1 805 0 is_stmt 1
	movzwl	16(%rbp), %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%rbp)
.L156:
	.loc 1 807 0
	movzwl	16(%rbp), %eax
	.loc 1 808 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.seh_endproc
	.def	_qRBufferCount;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferCount
_qRBufferCount:
.LFB33:
	.loc 1 810 0
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
	.loc 1 811 0
	cmpq	$0, 16(%rbp)
	je	.L161
	.loc 1 811 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzwl	12(%rax), %edx
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	.L162
.L161:
	.loc 1 811 0 discriminator 2
	movl	$0, %eax
.L162:
	.loc 1 812 0 is_stmt 1 discriminator 4
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.seh_endproc
	.def	_qRBufferFull;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferFull
_qRBufferFull:
.LFB34:
	.loc 1 814 0
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
	.loc 1 815 0
	cmpq	$0, 16(%rbp)
	je	.L165
	.loc 1 815 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rcx
	call	_qRBufferCount
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movzwl	10(%rax), %eax
	cmpw	%ax, %dx
	sete	%al
	movzbl	%al, %eax
	jmp	.L166
.L165:
	.loc 1 815 0 discriminator 2
	movl	$1, %eax
.L166:
	.loc 1 816 0 is_stmt 1 discriminator 4
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.seh_endproc
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
.LFB35:
	.loc 1 835 0
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
	.loc 1 836 0
	cmpq	$0, 16(%rbp)
	je	.L168
	.loc 1 837 0
	movq	16(%rbp), %rax
	movw	$0, 12(%rax)
	.loc 1 838 0
	movq	16(%rbp), %rax
	movw	$0, 14(%rax)
	.loc 1 839 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 840 0
	movq	16(%rbp), %rax
	movzwl	32(%rbp), %edx
	movw	%dx, 8(%rax)
	.loc 1 841 0
	movzwl	40(%rbp), %eax
	movl	%eax, %ecx
	call	_qRBufferValidPowerOfTwo
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movw	%dx, 10(%rax)
.L168:
	.loc 1 843 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.seh_endproc
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
.LFB36:
	.loc 1 857 0
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
	.loc 1 858 0
	cmpq	$0, 16(%rbp)
	je	.L171
	.loc 1 858 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rcx
	call	_qRBufferCount
	testw	%ax, %ax
	sete	%al
	movzbl	%al, %eax
	jmp	.L172
.L171:
	.loc 1 858 0 discriminator 2
	movl	$1, %eax
.L172:
	.loc 1 859 0 is_stmt 1 discriminator 4
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.seh_endproc
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
.LFB37:
	.loc 1 873 0
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
	.loc 1 874 0
	cmpq	$0, 16(%rbp)
	je	.L175
	.loc 1 875 0
	movq	16(%rbp), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L176
	.loc 1 875 0 is_stmt 0 discriminator 1
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
	jmp	.L178
.L176:
	.loc 1 875 0 discriminator 2
	movl	$0, %eax
	jmp	.L178
.L175:
	.loc 1 877 0 is_stmt 1
	movl	$0, %eax
.L178:
	.loc 1 878 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.seh_endproc
	.globl	qRBufferPopFront
	.def	qRBufferPopFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPopFront
qRBufferPopFront:
.LFB38:
	.loc 1 892 0
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
	.loc 1 893 0
	cmpq	$0, 16(%rbp)
	jne	.L180
	.loc 1 893 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L181
.L180:
	.loc 1 894 0 is_stmt 1
	movq	$0, -8(%rbp)
	.loc 1 895 0
	movq	16(%rbp), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L182
	.loc 1 896 0
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
	.loc 1 897 0
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movw	%dx, 14(%rax)
.L182:
	.loc 1 899 0
	movq	-8(%rbp), %rax
.L181:
	.loc 1 900 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.seh_endproc
	.globl	qRBufferPush
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPush
qRBufferPush:
.LFB39:
	.loc 1 915 0
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
	.loc 1 916 0
	movb	$0, -1(%rbp)
	.loc 1 917 0
	movq	24(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 918 0
	movq	$0, -24(%rbp)
	.loc 1 921 0
	cmpq	$0, 16(%rbp)
	je	.L184
	.loc 1 921 0 is_stmt 0 discriminator 1
	cmpq	$0, -16(%rbp)
	je	.L184
	.loc 1 922 0 is_stmt 1
	movq	16(%rbp), %rcx
	call	_qRBufferFull
	testb	%al, %al
	jne	.L184
	.loc 1 923 0
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
	.loc 1 924 0
	movw	$0, -4(%rbp)
	jmp	.L185
.L186:
	.loc 1 924 0 is_stmt 0 discriminator 3
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
.L185:
	.loc 1 924 0 discriminator 1
	movq	16(%rbp), %rax
	movzwl	8(%rax), %eax
	cmpw	-4(%rbp), %ax
	ja	.L186
	.loc 1 925 0 is_stmt 1
	movq	16(%rbp), %rax
	movzwl	12(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movw	%dx, 12(%rax)
	.loc 1 926 0
	movb	$1, -1(%rbp)
.L184:
	.loc 1 929 0
	movzbl	-1(%rbp), %eax
	.loc 1 930 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
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
	.long	0x1761
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C 4.9.3 -mtune=generic -march=x86-64 -g -std=c99\0"
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
	.long	0xab
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x3
	.ascii "__int16_t\0"
	.byte	0x2
	.byte	0x29
	.long	0xcd
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.ascii "short int\0"
	.uleb128 0x3
	.ascii "__uint16_t\0"
	.byte	0x2
	.byte	0x2b
	.long	0xec
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
	.long	0x11b
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
	.long	0x9a
	.uleb128 0x3
	.ascii "int16_t\0"
	.byte	0x3
	.byte	0x19
	.long	0xbc
	.uleb128 0x3
	.ascii "uint16_t\0"
	.byte	0x3
	.byte	0x1a
	.long	0xda
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x20
	.long	0x109
	.uleb128 0x4
	.byte	0x4
	.byte	0x4
	.byte	0x3e
	.long	0x21a
	.uleb128 0x5
	.ascii "_Q_NO_VALID_TRIGGER_\0"
	.sleb128 0
	.uleb128 0x5
	.ascii "byTimeElapsed\0"
	.sleb128 1
	.uleb128 0x5
	.ascii "byPriority\0"
	.sleb128 2
	.uleb128 0x5
	.ascii "byQueueExtraction\0"
	.sleb128 3
	.uleb128 0x5
	.ascii "byAsyncEvent\0"
	.sleb128 4
	.uleb128 0x5
	.ascii "byRBufferPop\0"
	.sleb128 5
	.uleb128 0x5
	.ascii "byRBufferFull\0"
	.sleb128 6
	.uleb128 0x5
	.ascii "byRBufferCount\0"
	.sleb128 7
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x4
	.byte	0x3e
	.long	0x18a
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x4
	.byte	0x3f
	.long	0x23b
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x4
	.byte	0x40
	.long	0x17a
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x4
	.byte	0x41
	.long	0x14c
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x4
	.byte	0x42
	.long	0x14c
	.uleb128 0x3
	.ascii "qState_t\0"
	.byte	0x4
	.byte	0x43
	.long	0x14c
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x4
	.byte	0x44
	.long	0x14c
	.uleb128 0x6
	.byte	0x20
	.byte	0x4
	.byte	0x4f
	.long	0x2e3
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x4
	.byte	0x62
	.long	0x21a
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x66
	.long	0x2e3
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x4
	.byte	0x6a
	.long	0x2e3
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x4
	.byte	0x6f
	.long	0x28b
	.byte	0x18
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x4
	.byte	0x70
	.long	0x29a
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x4
	.byte	0x72
	.long	0x307
	.uleb128 0xa
	.byte	0x8
	.long	0x30d
	.uleb128 0xb
	.long	0x318
	.uleb128 0xc
	.long	0x2e5
	.byte	0
	.uleb128 0x6
	.byte	0x6
	.byte	0x4
	.byte	0x73
	.long	0x384
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x4
	.byte	0x74
	.long	0x384
	.byte	0
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x4
	.byte	0x74
	.long	0x384
	.byte	0x1
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x4
	.byte	0x74
	.long	0x384
	.byte	0x2
	.uleb128 0x7
	.ascii "RBAutoPop\0"
	.byte	0x4
	.byte	0x74
	.long	0x384
	.byte	0x3
	.uleb128 0x7
	.ascii "RBFull\0"
	.byte	0x4
	.byte	0x74
	.long	0x384
	.byte	0x4
	.uleb128 0x7
	.ascii "RBCount\0"
	.byte	0x4
	.byte	0x74
	.long	0x384
	.byte	0x5
	.byte	0
	.uleb128 0xd
	.long	0x14c
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x4
	.byte	0x75
	.long	0x318
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0x79
	.long	0x3ee
	.uleb128 0x7
	.ascii "data\0"
	.byte	0x4
	.byte	0x7a
	.long	0x3ee
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x7b
	.long	0x3f4
	.byte	0x8
	.uleb128 0x7
	.ascii "Elementcount\0"
	.byte	0x4
	.byte	0x7c
	.long	0x3f4
	.byte	0xa
	.uleb128 0x7
	.ascii "head\0"
	.byte	0x4
	.byte	0x7d
	.long	0x3f4
	.byte	0xc
	.uleb128 0x7
	.ascii "tail\0"
	.byte	0x4
	.byte	0x7e
	.long	0x3f4
	.byte	0xe
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x384
	.uleb128 0xd
	.long	0x16a
	.uleb128 0x3
	.ascii "qRBuffer_t\0"
	.byte	0x4
	.byte	0x7f
	.long	0x39d
	.uleb128 0xe
	.ascii "_qTask_t\0"
	.byte	0x48
	.byte	0x4
	.byte	0x81
	.long	0x4c4
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x82
	.long	0x2e3
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x4
	.byte	0x82
	.long	0x2e3
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x4
	.byte	0x83
	.long	0x4c4
	.byte	0x10
	.uleb128 0x7
	.ascii "ClockStart\0"
	.byte	0x4
	.byte	0x83
	.long	0x4c4
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x4
	.byte	0x84
	.long	0x267
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x4
	.byte	0x85
	.long	0x17a
	.byte	0x1c
	.uleb128 0x8
	.secrel32	.LASF2
	.byte	0x4
	.byte	0x86
	.long	0x254
	.byte	0x20
	.uleb128 0x8
	.secrel32	.LASF3
	.byte	0x4
	.byte	0x87
	.long	0x2f5
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0x88
	.long	0x4c9
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x4
	.byte	0x89
	.long	0x4ce
	.byte	0x38
	.uleb128 0x7
	.ascii "RingBuff\0"
	.byte	0x4
	.byte	0x8a
	.long	0x4d9
	.byte	0x40
	.byte	0
	.uleb128 0xd
	.long	0x244
	.uleb128 0xd
	.long	0x389
	.uleb128 0xa
	.byte	0x8
	.long	0x4d4
	.uleb128 0xd
	.long	0x40b
	.uleb128 0xa
	.byte	0x8
	.long	0x3f9
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0x8e
	.long	0x506
	.uleb128 0x8
	.secrel32	.LASF4
	.byte	0x4
	.byte	0x8f
	.long	0x4ce
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x4
	.byte	0x90
	.long	0x2e3
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x4
	.byte	0x91
	.long	0x4df
	.uleb128 0x6
	.byte	0x8
	.byte	0x4
	.byte	0x93
	.long	0x57f
	.uleb128 0x7
	.ascii "Init\0"
	.byte	0x4
	.byte	0x94
	.long	0x14c
	.byte	0
	.uleb128 0x7
	.ascii "FCallIdle\0"
	.byte	0x4
	.byte	0x94
	.long	0x14c
	.byte	0x1
	.uleb128 0x7
	.ascii "ReleaseSched\0"
	.byte	0x4
	.byte	0x94
	.long	0x14c
	.byte	0x2
	.uleb128 0x7
	.ascii "FCallReleased\0"
	.byte	0x4
	.byte	0x94
	.long	0x14c
	.byte	0x3
	.uleb128 0x7
	.ascii "IntFlags\0"
	.byte	0x4
	.byte	0x95
	.long	0x17a
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x4
	.byte	0x96
	.long	0x51b
	.uleb128 0x6
	.byte	0x68
	.byte	0x4
	.byte	0x98
	.long	0x669
	.uleb128 0x7
	.ascii "IDLECallback\0"
	.byte	0x4
	.byte	0x99
	.long	0x2f5
	.byte	0
	.uleb128 0x7
	.ascii "ReleaseSchedCallback\0"
	.byte	0x4
	.byte	0x9a
	.long	0x2f5
	.byte	0x8
	.uleb128 0x7
	.ascii "Tick\0"
	.byte	0x4
	.byte	0x9b
	.long	0x22c
	.byte	0x10
	.uleb128 0x7
	.ascii "EventInfo\0"
	.byte	0x4
	.byte	0x9c
	.long	0x2e5
	.byte	0x18
	.uleb128 0x7
	.ascii "First\0"
	.byte	0x4
	.byte	0x9d
	.long	0x4ce
	.byte	0x38
	.uleb128 0x7
	.ascii "I_Disable\0"
	.byte	0x4
	.byte	0x9e
	.long	0x66e
	.byte	0x40
	.uleb128 0x7
	.ascii "I_Restorer\0"
	.byte	0x4
	.byte	0x9f
	.long	0x67f
	.byte	0x48
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0xa0
	.long	0x685
	.byte	0x50
	.uleb128 0x7
	.ascii "QueueStack\0"
	.byte	0x4
	.byte	0xa1
	.long	0x68a
	.byte	0x58
	.uleb128 0x7
	.ascii "QueueSize\0"
	.byte	0x4
	.byte	0xa2
	.long	0x14c
	.byte	0x60
	.uleb128 0x7
	.ascii "QueueIndex\0"
	.byte	0x4
	.byte	0xa3
	.long	0x15b
	.byte	0x62
	.byte	0
	.uleb128 0xf
	.long	0x17a
	.uleb128 0xa
	.byte	0x8
	.long	0x669
	.uleb128 0xb
	.long	0x67f
	.uleb128 0xc
	.long	0x17a
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x674
	.uleb128 0xd
	.long	0x57f
	.uleb128 0xa
	.byte	0x8
	.long	0x690
	.uleb128 0xd
	.long	0x506
	.uleb128 0x3
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x4
	.byte	0xa4
	.long	0x597
	.uleb128 0x4
	.byte	0x4
	.byte	0x4
	.byte	0xaf
	.long	0x6d9
	.uleb128 0x5
	.ascii "RB_AUTOPOP\0"
	.sleb128 0
	.uleb128 0x5
	.ascii "RB_FULL\0"
	.sleb128 1
	.uleb128 0x5
	.ascii "RB_COUNT\0"
	.sleb128 2
	.byte	0
	.uleb128 0x3
	.ascii "qRBLinkMode_t\0"
	.byte	0x4
	.byte	0xaf
	.long	0x6ae
	.uleb128 0x10
	.byte	0x4
	.byte	0x4
	.word	0x106
	.long	0x722
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
	.word	0x106
	.long	0x6ee
	.uleb128 0x12
	.byte	0x18
	.byte	0x4
	.word	0x11f
	.long	0x77d
	.uleb128 0x13
	.ascii "__Failure\0"
	.byte	0x4
	.word	0x120
	.long	0x81f
	.byte	0
	.uleb128 0x13
	.ascii "__Success\0"
	.byte	0x4
	.word	0x121
	.long	0x81f
	.byte	0x8
	.uleb128 0x13
	.ascii "__Unexpected\0"
	.byte	0x4
	.word	0x122
	.long	0x81f
	.byte	0x10
	.byte	0
	.uleb128 0xb
	.long	0x788
	.uleb128 0xc
	.long	0x788
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x78e
	.uleb128 0xd
	.long	0x793
	.uleb128 0x14
	.ascii "_qSM_t\0"
	.byte	0x38
	.byte	0x4
	.word	0x10a
	.long	0x81f
	.uleb128 0x13
	.ascii "NextState\0"
	.byte	0x4
	.word	0x10e
	.long	0x834
	.byte	0
	.uleb128 0x13
	.ascii "PreviousState\0"
	.byte	0x4
	.word	0x112
	.long	0x834
	.byte	0x8
	.uleb128 0x13
	.ascii "PreviousReturnStatus\0"
	.byte	0x4
	.word	0x116
	.long	0x722
	.byte	0x10
	.uleb128 0x13
	.ascii "StateJustChanged\0"
	.byte	0x4
	.word	0x11a
	.long	0x28b
	.byte	0x14
	.uleb128 0x13
	.ascii "Data\0"
	.byte	0x4
	.word	0x11e
	.long	0x2e3
	.byte	0x18
	.uleb128 0x13
	.ascii "_\0"
	.byte	0x4
	.word	0x123
	.long	0x737
	.byte	0x20
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x77d
	.uleb128 0x15
	.long	0x722
	.long	0x834
	.uleb128 0xc
	.long	0x788
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x825
	.uleb128 0x11
	.ascii "qSM_State_t\0"
	.byte	0x4
	.word	0x125
	.long	0x834
	.uleb128 0x11
	.ascii "qSM_ExState_t\0"
	.byte	0x4
	.word	0x126
	.long	0x81f
	.uleb128 0x12
	.byte	0xc
	.byte	0x4
	.word	0x159
	.long	0x895
	.uleb128 0x13
	.ascii "SR\0"
	.byte	0x4
	.word	0x15a
	.long	0x28b
	.byte	0
	.uleb128 0x13
	.ascii "Start\0"
	.byte	0x4
	.word	0x15b
	.long	0x244
	.byte	0x4
	.uleb128 0x13
	.ascii "TV\0"
	.byte	0x4
	.word	0x15b
	.long	0x244
	.byte	0x8
	.byte	0
	.uleb128 0x11
	.ascii "qSTimer_t\0"
	.byte	0x4
	.word	0x15c
	.long	0x864
	.uleb128 0x12
	.byte	0x18
	.byte	0x4
	.word	0x16c
	.long	0x906
	.uleb128 0x13
	.ascii "BlockSize\0"
	.byte	0x4
	.word	0x16d
	.long	0x16a
	.byte	0
	.uleb128 0x13
	.ascii "NumberofBlocks\0"
	.byte	0x4
	.word	0x16e
	.long	0x14c
	.byte	0x2
	.uleb128 0x13
	.ascii "BlockDescriptors\0"
	.byte	0x4
	.word	0x16f
	.long	0x906
	.byte	0x8
	.uleb128 0x13
	.ascii "Blocks\0"
	.byte	0x4
	.word	0x170
	.long	0x906
	.byte	0x10
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x14c
	.uleb128 0x11
	.ascii "qMemoryPool_t\0"
	.byte	0x4
	.word	0x171
	.long	0x8a7
	.uleb128 0x16
	.ascii "qTaskGetCycles\0"
	.byte	0x1
	.byte	0x30
	.long	0x17a
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x95d
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x30
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSendEvent\0"
	.byte	0x1
	.byte	0x42
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x9a2
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x42
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x42
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetTime\0"
	.byte	0x1
	.byte	0x52
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x9e7
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x52
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Value\0"
	.byte	0x1
	.byte	0x52
	.long	0x22c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetIterations\0"
	.byte	0x1
	.byte	0x65
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0xa32
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x65
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Value\0"
	.byte	0x1
	.byte	0x65
	.long	0x267
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetPriority\0"
	.byte	0x1
	.byte	0x73
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0xa7b
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x73
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Value\0"
	.byte	0x1
	.byte	0x73
	.long	0x254
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetCallback\0"
	.byte	0x1
	.byte	0x83
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0xac2
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x83
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF6
	.byte	0x1
	.byte	0x83
	.long	0x2f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetState\0"
	.byte	0x1
	.byte	0x90
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0xb08
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x90
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "State\0"
	.byte	0x1
	.byte	0x90
	.long	0x27b
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskSetUserData\0"
	.byte	0x1
	.byte	0xa2
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0xb4f
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xa2
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "arg\0"
	.byte	0x1
	.byte	0xa2
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x18
	.ascii "qTaskClearTimeElapsed\0"
	.byte	0x1
	.byte	0xae
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xb8d
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xae
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.ascii "qTaskQueueEvent\0"
	.byte	0x1
	.byte	0xc5
	.long	0x102
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xbe6
	.uleb128 0x17
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xc5
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x17
	.secrel32	.LASF5
	.byte	0x1
	.byte	0xc5
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1a
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0xc7
	.long	0x506
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x18
	.ascii "qSchedulerSetInterruptsED\0"
	.byte	0x1
	.byte	0xda
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xc40
	.uleb128 0x19
	.ascii "Restorer\0"
	.byte	0x1
	.byte	0xda
	.long	0x67f
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "Disabler\0"
	.byte	0x1
	.byte	0xda
	.long	0x66e
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1b
	.ascii "_qPrioQueueExtract\0"
	.byte	0x1
	.byte	0xdf
	.long	0x4ce
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xcbc
	.uleb128 0x1c
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xe0
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.ascii "i\0"
	.byte	0x1
	.byte	0xe1
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1a
	.ascii "IndexTaskToExtract\0"
	.byte	0x1
	.byte	0xe2
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1a
	.ascii "MaxpValue\0"
	.byte	0x1
	.byte	0xe5
	.long	0x254
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.byte	0
	.uleb128 0x18
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0xf6
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xd44
	.uleb128 0x19
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0xf6
	.long	0x22c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0xf6
	.long	0x2f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0xf6
	.long	0x68a
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x19
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0xf6
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1a
	.ascii "i\0"
	.byte	0x1
	.byte	0xf7
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x1d
	.ascii "qSchedulerAddxTask\0"
	.byte	0x1
	.word	0x12e
	.long	0x102
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xdf1
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x12e
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.secrel32	.LASF6
	.byte	0x1
	.word	0x12e
	.long	0x2f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.secrel32	.LASF2
	.byte	0x1
	.word	0x12e
	.long	0x254
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "Time\0"
	.byte	0x1
	.word	0x12e
	.long	0x22c
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1f
	.ascii "nExecutions\0"
	.byte	0x1
	.word	0x12e
	.long	0x267
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1f
	.ascii "InitialState\0"
	.byte	0x1
	.word	0x12e
	.long	0x27b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1f
	.ascii "arg\0"
	.byte	0x1
	.word	0x12e
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x20
	.ascii "qSchedulerAddeTask\0"
	.byte	0x1
	.word	0x15a
	.long	0x102
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xe5f
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x15a
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.secrel32	.LASF3
	.byte	0x1
	.word	0x15a
	.long	0x2f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.secrel32	.LASF2
	.byte	0x1
	.word	0x15a
	.long	0x254
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "arg\0"
	.byte	0x1
	.word	0x15a
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x21
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.word	0x15e
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xea9
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x15e
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "Event\0"
	.byte	0x1
	.word	0x15e
	.long	0x21a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x21
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.word	0x168
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xf2d
	.uleb128 0x22
	.ascii "a\0"
	.byte	0x1
	.word	0x169
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x22
	.ascii "b\0"
	.byte	0x1
	.word	0x169
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x22
	.ascii "c\0"
	.byte	0x1
	.word	0x169
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.ascii "e\0"
	.byte	0x1
	.word	0x169
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x22
	.ascii "tmp\0"
	.byte	0x1
	.word	0x169
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x22
	.ascii "head\0"
	.byte	0x1
	.word	0x16a
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x1d
	.ascii "qTaskLinkRBuffer\0"
	.byte	0x1
	.word	0x1a7
	.long	0x102
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0xfa1
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x1a7
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "RingBuffer\0"
	.byte	0x1
	.word	0x1a7
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1f
	.ascii "Mode\0"
	.byte	0x1
	.word	0x1a7
	.long	0x6d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "arg\0"
	.byte	0x1
	.word	0x1a7
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x23
	.ascii "_qCheckRBufferEvents\0"
	.byte	0x1
	.word	0x1ba
	.long	0x21a
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x1005
	.uleb128 0x1e
	.secrel32	.LASF4
	.byte	0x1
	.word	0x1ba
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x22
	.ascii "rb\0"
	.byte	0x1
	.word	0x1bb
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.ascii "popdata\0"
	.byte	0x1
	.word	0x1bc
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0x24
	.ascii "_qTriggerReleaseSchedEvent\0"
	.byte	0x1
	.word	0x1cf
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x24
	.ascii "_qTriggerIdleTask\0"
	.byte	0x1
	.word	0x1d8
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x25
	.ascii "qSchedulerRun\0"
	.byte	0x1
	.word	0x1e6
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0x10ee
	.uleb128 0x26
	.secrel32	.LASF4
	.byte	0x1
	.word	0x1e7
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x22
	.ascii "qTask\0"
	.byte	0x1
	.word	0x1e7
	.long	0x4ce
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.ascii "trg\0"
	.byte	0x1
	.word	0x1e8
	.long	0x21a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x27
	.ascii "qMainSchedule\0"
	.byte	0x1
	.word	0x1e9
	.quad	.L77
	.uleb128 0x27
	.ascii "qReleasedSchedule\0"
	.byte	0x1
	.word	0x202
	.quad	.L79
	.byte	0
	.uleb128 0x1d
	.ascii "qStateMachine_Init\0"
	.byte	0x1
	.word	0x222
	.long	0x102
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x118f
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x222
	.long	0x788
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "InitState\0"
	.byte	0x1
	.word	0x222
	.long	0x83a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1f
	.ascii "SuccessState\0"
	.byte	0x1
	.word	0x222
	.long	0x84e
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "FailureState\0"
	.byte	0x1
	.word	0x222
	.long	0x84e
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1f
	.ascii "UnexpectedState\0"
	.byte	0x1
	.word	0x222
	.long	0x84e
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0x25
	.ascii "qStateMachine_Run\0"
	.byte	0x1
	.word	0x239
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x11eb
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x239
	.long	0x788
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "Data\0"
	.byte	0x1
	.word	0x239
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x22
	.ascii "prev\0"
	.byte	0x1
	.word	0x23a
	.long	0x83a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1d
	.ascii "qSTimerSet\0"
	.byte	0x1
	.word	0x264
	.long	0x28b
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x1234
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x264
	.long	0x1234
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "Time\0"
	.byte	0x1
	.word	0x264
	.long	0x22c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x895
	.uleb128 0x20
	.ascii "qSTimerFreeRun\0"
	.byte	0x1
	.word	0x281
	.long	0x28b
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0x1287
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x281
	.long	0x1234
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "Time\0"
	.byte	0x1
	.word	0x281
	.long	0x22c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1d
	.ascii "qSTimerExpired\0"
	.byte	0x1
	.word	0x29a
	.long	0x28b
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.long	0x12c4
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x29a
	.long	0x1234
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1d
	.ascii "qSTimerElapsed\0"
	.byte	0x1
	.word	0x2ab
	.long	0x244
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.long	0x1301
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x2ab
	.long	0x1234
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "qSTimerRemaining\0"
	.byte	0x1
	.word	0x2bb
	.long	0x244
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.long	0x1353
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x2bb
	.long	0x1234
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x22
	.ascii "elapsed\0"
	.byte	0x1
	.word	0x2bc
	.long	0x244
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x28
	.ascii "qSTimerDisarm\0"
	.byte	0x1
	.word	0x2c8
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.long	0x138b
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x2c8
	.long	0x1234
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "qMemoryAlloc\0"
	.byte	0x1
	.word	0x2dd
	.long	0x2e3
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.uleb128 0x1
	.byte	0x9c
	.long	0x141e
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x2dd
	.long	0x141e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "size\0"
	.byte	0x1
	.word	0x2dd
	.long	0x16a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x22
	.ascii "i\0"
	.byte	0x1
	.word	0x2de
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x22
	.ascii "j\0"
	.byte	0x1
	.word	0x2de
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x22
	.ascii "k\0"
	.byte	0x1
	.word	0x2de
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.uleb128 0x22
	.ascii "sum\0"
	.byte	0x1
	.word	0x2df
	.long	0x16a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x22
	.ascii "offset\0"
	.byte	0x1
	.word	0x2e0
	.long	0x906
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x90c
	.uleb128 0x25
	.ascii "qMemoryFree\0"
	.byte	0x1
	.word	0x30f
	.quad	.LFB31
	.quad	.LFE31-.LFB31
	.uleb128 0x1
	.byte	0x9c
	.long	0x1484
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x30f
	.long	0x141e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "pmem\0"
	.byte	0x1
	.word	0x30f
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x22
	.ascii "i\0"
	.byte	0x1
	.word	0x310
	.long	0x14c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x22
	.ascii "p\0"
	.byte	0x1
	.word	0x310
	.long	0x906
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x29
	.ascii "_qRBufferValidPowerOfTwo\0"
	.byte	0x1
	.word	0x320
	.long	0x16a
	.quad	.LFB32
	.quad	.LFE32-.LFB32
	.uleb128 0x1
	.byte	0x9c
	.long	0x14d6
	.uleb128 0x1f
	.ascii "k\0"
	.byte	0x1
	.word	0x320
	.long	0x16a
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x22
	.ascii "i\0"
	.byte	0x1
	.word	0x321
	.long	0x16a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.byte	0
	.uleb128 0x29
	.ascii "_qRBufferCount\0"
	.byte	0x1
	.word	0x32a
	.long	0x16a
	.quad	.LFB33
	.quad	.LFE33-.LFB33
	.uleb128 0x1
	.byte	0x9c
	.long	0x1513
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x32a
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x23
	.ascii "_qRBufferFull\0"
	.byte	0x1
	.word	0x32e
	.long	0x28b
	.quad	.LFB34
	.quad	.LFE34-.LFB34
	.uleb128 0x1
	.byte	0x9c
	.long	0x154f
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x32e
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x25
	.ascii "qRBufferInit\0"
	.byte	0x1
	.word	0x343
	.quad	.LFB35
	.quad	.LFE35-.LFB35
	.uleb128 0x1
	.byte	0x9c
	.long	0x15c2
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x343
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "DataBlock\0"
	.byte	0x1
	.word	0x343
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.secrel32	.LASF1
	.byte	0x1
	.word	0x343
	.long	0x16a
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1f
	.ascii "ElementCount\0"
	.byte	0x1
	.word	0x343
	.long	0x16a
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x20
	.ascii "qRBufferEmpty\0"
	.byte	0x1
	.word	0x359
	.long	0x28b
	.quad	.LFB36
	.quad	.LFE36-.LFB36
	.uleb128 0x1
	.byte	0x9c
	.long	0x15fe
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x359
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "qRBufferGetFront\0"
	.byte	0x1
	.word	0x369
	.long	0x2e3
	.quad	.LFB37
	.quad	.LFE37-.LFB37
	.uleb128 0x1
	.byte	0x9c
	.long	0x163d
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x369
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x20
	.ascii "qRBufferPopFront\0"
	.byte	0x1
	.word	0x37c
	.long	0x2e3
	.quad	.LFB38
	.quad	.LFE38-.LFB38
	.uleb128 0x1
	.byte	0x9c
	.long	0x168c
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x37c
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x22
	.ascii "data\0"
	.byte	0x1
	.word	0x37e
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.ascii "qRBufferPush\0"
	.byte	0x1
	.word	0x393
	.long	0x28b
	.quad	.LFB39
	.quad	.LFE39-.LFB39
	.uleb128 0x1
	.byte	0x9c
	.long	0x1723
	.uleb128 0x1f
	.ascii "obj\0"
	.byte	0x1
	.word	0x393
	.long	0x4d9
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1f
	.ascii "data\0"
	.byte	0x1
	.word	0x393
	.long	0x2e3
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x22
	.ascii "status\0"
	.byte	0x1
	.word	0x394
	.long	0x28b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x22
	.ascii "data_element\0"
	.byte	0x1
	.word	0x395
	.long	0x906
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x22
	.ascii "ring_data\0"
	.byte	0x1
	.word	0x396
	.long	0x3ee
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.ascii "i\0"
	.byte	0x1
	.word	0x397
	.long	0x16a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x2a
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x15
	.long	0x173c
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0xd
	.long	0x695
	.uleb128 0x2a
	.ascii "_qSysTick_Epochs_\0"
	.byte	0x1
	.byte	0x16
	.long	0x4c4
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
