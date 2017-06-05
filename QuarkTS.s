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
	jne	.L11
.L9:
	.loc 1 146 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	24(%rbp), %edx
	movb	%dl, 50(%rax)
	.loc 1 147 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	jmp	.L8
.L11:
	.loc 1 145 0
	nop
.L8:
	.loc 1 148 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.seh_endproc
	.globl	qTaskSetData
	.def	qTaskSetData;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskSetData
qTaskSetData:
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
	jl	.L15
	.loc 1 198 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L17
.L15:
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
.L17:
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
	jns	.L20
	.loc 1 227 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L21
.L20:
	.loc 1 228 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L22
	.loc 1 228 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L22:
	.loc 1 229 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	movb	%al, -3(%rbp)
	.loc 1 230 0
	movb	$1, -1(%rbp)
	jmp	.L23
.L27:
	.loc 1 231 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L31
	.loc 1 232 0
	leaq	QUARKTS(%rip), %rax
	movq	88(%rax), %rax
	movzbl	-1(%rbp), %edx
	salq	$4, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movzbl	32(%rax), %eax
	cmpb	-3(%rbp), %al
	jbe	.L26
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
.L26:
	.loc 1 230 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L23:
	.loc 1 230 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L27
	jmp	.L25
.L31:
	.loc 1 231 0 is_stmt 1
	nop
.L25:
	.loc 1 237 0
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
	jmp	.L28
.L29:
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
.L28:
	.loc 1 240 0 discriminator 1
	movzbl	-1(%rbp), %edx
	leaq	QUARKTS(%rip), %rax
	movzwl	98(%rax), %eax
	cwtl
	cmpl	%eax, %edx
	jl	.L29
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
	je	.L30
	.loc 1 242 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L30:
	.loc 1 243 0 is_stmt 1
	movq	-16(%rbp), %rax
.L21:
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
	leaq	QUARKTS(%rip), %rax
	movss	16(%rbp), %xmm0
	movss	%xmm0, 16(%rax)
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
	jmp	.L33
.L34:
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
.L33:
	.loc 1 254 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movzbl	96(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L34
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
	.loc 1 301 0
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
	.loc 1 302 0
	movss	40(%rbp), %xmm0
	movss	.LC0(%rip), %xmm1
	divss	%xmm1, %xmm0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L36
	.loc 1 302 0 is_stmt 0 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jp	.L38
	pxor	%xmm0, %xmm0
	ucomiss	40(%rbp), %xmm0
	jne	.L38
.L36:
	.loc 1 302 0 discriminator 4
	cmpq	$0, 24(%rbp)
	jne	.L39
.L38:
	.loc 1 302 0 discriminator 5
	movl	$-1, %eax
	jmp	.L40
.L39:
	.loc 1 303 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 304 0
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	40(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 305 0
	movq	16(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 306 0
	movq	16(%rbp), %rax
	movzbl	32(%rbp), %edx
	movb	%dl, 32(%rax)
	.loc 1 307 0
	movq	16(%rbp), %rax
	movzbl	-4(%rbp), %edx
	movb	%dl, 24(%rax)
	.loc 1 308 0
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
	.loc 1 309 0
	cmpb	$0, -8(%rbp)
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 50(%rax)
	.loc 1 310 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rdx
	movq	16(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 311 0
	leaq	QUARKTS(%rip), %rax
	movq	16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 312 0
	movq	16(%rbp), %rax
	movl	$0, 28(%rax)
	.loc 1 313 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 314 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 315 0
	movq	16(%rbp), %rax
	movq	$0, 64(%rax)
	.loc 1 316 0
	movq	16(%rbp), %rax
	movq	$0, 72(%rax)
	.loc 1 317 0
	movl	$0, %eax
.L40:
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
	.loc 1 345 0
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
	.loc 1 346 0
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
	.loc 1 347 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.globl	qSchedulerAddSMTask
	.def	qSchedulerAddSMTask;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerAddSMTask
qSchedulerAddSMTask:
.LFB15:
	.loc 1 405 0
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
	movq	%rcx, 16(%rbp)
	movss	%xmm2, 32(%rbp)
	movq	%r9, 40(%rbp)
	movl	88(%rbp), %eax
	movb	%dl, 24(%rbp)
	movb	%al, -4(%rbp)
	.loc 1 406 0
	cmpq	$0, 48(%rbp)
	jne	.L45
	.loc 1 406 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L46
.L45:
	.loc 1 407 0 is_stmt 1
	movzbl	-4(%rbp), %eax
	movzbl	24(%rbp), %ecx
	movss	32(%rbp), %xmm0
	movq	96(%rbp), %rdx
	movq	%rdx, 48(%rsp)
	movl	%eax, 40(%rsp)
	movl	$255, 32(%rsp)
	movaps	%xmm0, %xmm3
	movl	%ecx, %r8d
	movl	$1, %edx
	movq	16(%rbp), %rcx
	call	qSchedulerAddxTask
	cmpl	$-1, %eax
	jne	.L47
	.loc 1 407 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L46
.L47:
	.loc 1 408 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 72(%rax)
	.loc 1 409 0
	movq	40(%rbp), %rax
	movq	48(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 410 0
	movq	40(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 411 0
	movq	40(%rbp), %rax
	movq	72(%rbp), %rdx
	movq	%rdx, 32(%rax)
	.loc 1 412 0
	movq	40(%rbp), %rax
	movq	64(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 413 0
	movq	40(%rbp), %rax
	movq	80(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 414 0
	movq	40(%rbp), %rax
	movq	56(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 415 0
	movl	$0, %eax
.L46:
	.loc 1 416 0
	addq	$80, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.seh_endproc
	.def	_qTriggerEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerEvent
_qTriggerEvent:
.LFB16:
	.loc 1 418 0
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
	.loc 1 419 0
	leaq	QUARKTS(%rip), %rax
	movl	24(%rbp), %edx
	movl	%edx, 24(%rax)
	.loc 1 420 0
	movq	16(%rbp), %rax
	movzbl	48(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 421 0
	movq	16(%rbp), %rax
	movq	(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 32(%rax)
	.loc 1 422 0
	movq	16(%rbp), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L49
	.loc 1 422 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	cmpq	$1, %rax
	jne	.L49
	.loc 1 422 0 discriminator 2
	movq	16(%rbp), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	leaq	24(%rdx), %rdx
	movq	%rax, %rcx
	call	qStateMachine_Run
	jmp	.L50
.L49:
	.loc 1 423 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L50
	.loc 1 423 0 is_stmt 0 discriminator 1
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
.L50:
	.loc 1 424 0 is_stmt 1
	movq	16(%rbp), %rax
	movb	$1, 48(%rax)
	.loc 1 425 0
	leaq	QUARKTS(%rip), %rax
	movq	$0, 40(%rax)
	.loc 1 426 0
	movq	16(%rbp), %rax
	movl	28(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movl	%edx, 28(%rax)
	.loc 1 427 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.def	_qTaskChainbyPriority;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTaskChainbyPriority
_qTaskChainbyPriority:
.LFB17:
	.loc 1 429 0
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
	.loc 1 430 0
	movq	$0, -8(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -48(%rbp)
	.loc 1 431 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -40(%rbp)
	.loc 1 432 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L53
	.loc 1 432 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
	.loc 1 433 0 is_stmt 1 discriminator 1
	jmp	.L53
.L60:
	.loc 1 434 0
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 435 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 436 0
	jmp	.L54
.L59:
	.loc 1 437 0
	movq	-8(%rbp), %rax
	movzbl	32(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	32(%rax), %eax
	cmpb	%al, %dl
	jnb	.L55
	.loc 1 438 0
	movq	-16(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -48(%rbp)
	.loc 1 439 0
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 56(%rax)
	.loc 1 440 0
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jne	.L56
	.loc 1 440 0 is_stmt 0 discriminator 1
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	leaq	QUARKTS(%rip), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L57
.L56:
	.loc 1 441 0 is_stmt 1
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
.L57:
	.loc 1 442 0
	movq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 443 0
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L58
.L55:
	.loc 1 446 0
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 447 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L58:
	.loc 1 449 0
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 450 0
	movq	-16(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L54
	.loc 1 450 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L54:
	.loc 1 436 0 is_stmt 1
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jne	.L59
.L53:
	.loc 1 433 0
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	cmpq	-32(%rbp), %rax
	jne	.L60
	.loc 1 453 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L62
	.loc 1 453 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L62:
	.loc 1 454 0 is_stmt 1
	nop
	addq	$80, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.globl	qTaskLinkRBuffer
	.def	qTaskLinkRBuffer;	.scl	2;	.type	32;	.endef
	.seh_proc	qTaskLinkRBuffer
qTaskLinkRBuffer:
.LFB18:
	.loc 1 492 0
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
	.loc 1 493 0
	cmpq	$0, 24(%rbp)
	jne	.L64
	.loc 1 493 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L65
.L64:
	.loc 1 494 0 is_stmt 1
	movq	24(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L66
	.loc 1 494 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L65
.L66:
	.loc 1 495 0 is_stmt 1
	movl	32(%rbp), %eax
	cmpl	$1, %eax
	je	.L68
	cmpl	$1, %eax
	jb	.L69
	cmpl	$2, %eax
	je	.L70
	jmp	.L74
.L69:
	.loc 1 497 0
	movq	16(%rbp), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 51(%rax)
	.loc 1 498 0
	jmp	.L71
.L68:
	.loc 1 500 0
	movq	16(%rbp), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 52(%rax)
	.loc 1 501 0
	jmp	.L71
.L70:
	.loc 1 503 0
	movq	16(%rbp), %rax
	movzbl	40(%rbp), %edx
	movb	%dl, 53(%rax)
	.loc 1 504 0
	jmp	.L71
.L74:
	.loc 1 505 0
	movl	$-1, %eax
	jmp	.L65
.L71:
	.loc 1 507 0
	cmpb	$0, 40(%rbp)
	je	.L72
	.loc 1 507 0 is_stmt 0 discriminator 1
	movq	24(%rbp), %rax
	jmp	.L73
.L72:
	.loc 1 507 0 discriminator 2
	movl	$0, %eax
.L73:
	.loc 1 507 0 discriminator 4
	movq	16(%rbp), %rdx
	movq	%rax, 64(%rdx)
	.loc 1 508 0 is_stmt 1 discriminator 4
	movl	$0, %eax
.L65:
	.loc 1 509 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.def	_qCheckRBufferEvents;	.scl	3;	.type	32;	.endef
	.seh_proc	_qCheckRBufferEvents
_qCheckRBufferEvents:
.LFB19:
	.loc 1 511 0
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
	.loc 1 512 0
	movq	-48(%rbp), %rax
	movq	64(%rax), %rax
	movq	%rax, -88(%rbp)
	.loc 1 513 0
	movq	$0, -96(%rbp)
	.loc 1 514 0
	cmpq	$0, -88(%rbp)
	jne	.L76
	.loc 1 514 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L77
.L76:
	.loc 1 515 0 is_stmt 1
	movq	-48(%rbp), %rax
	movzbl	52(%rax), %eax
	testb	%al, %al
	je	.L78
	.loc 1 515 0 is_stmt 0 discriminator 1
	movq	-88(%rbp), %rax
	movq	%rax, %rcx
	call	_qRBufferFull
	testb	%al, %al
	je	.L78
	.loc 1 516 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 517 0
	movl	$6, %eax
	jmp	.L77
.L78:
	.loc 1 519 0
	movq	-48(%rbp), %rax
	movzbl	53(%rax), %eax
	testb	%al, %al
	je	.L79
	.loc 1 519 0 is_stmt 0 discriminator 1
	movq	-48(%rbp), %rax
	movzbl	53(%rax), %eax
	movzbl	%al, %ebx
	movq	-88(%rbp), %rax
	movq	%rax, %rcx
	call	_qRBufferCount
	cmpw	%ax, %bx
	jb	.L79
	.loc 1 520 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 521 0
	movl	$7, %eax
	jmp	.L77
.L79:
	.loc 1 523 0
	movq	-48(%rbp), %rax
	movzbl	51(%rax), %eax
	testb	%al, %al
	je	.L80
	.loc 1 524 0
	movq	-88(%rbp), %rax
	movq	%rax, %rcx
	call	qRBufferGetFront
	movq	%rax, -96(%rbp)
	cmpq	$0, -96(%rbp)
	je	.L80
	.loc 1 525 0
	leaq	QUARKTS(%rip), %rax
	movq	-96(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 526 0
	movl	$5, %eax
	jmp	.L77
.L80:
	.loc 1 529 0
	movl	$0, %eax
.L77:
	.loc 1 530 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
	.def	_qTriggerReleaseSchedEvent;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerReleaseSchedEvent
_qTriggerReleaseSchedEvent:
.LFB20:
	.loc 1 532 0
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
	.loc 1 533 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 80(%rax)
	.loc 1 534 0
	leaq	QUARKTS(%rip), %rax
	movb	$0, 82(%rax)
	.loc 1 535 0
	leaq	QUARKTS(%rip), %rax
	movzbl	83(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 536 0
	leaq	QUARKTS(%rip), %rax
	movl	$4, 24(%rax)
	.loc 1 537 0
	leaq	QUARKTS(%rip), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L82
	.loc 1 537 0 is_stmt 0 discriminator 1
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
.L82:
	.loc 1 538 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 539 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.seh_endproc
	.def	_qTriggerIdleTask;	.scl	3;	.type	32;	.endef
	.seh_proc	_qTriggerIdleTask
_qTriggerIdleTask:
.LFB21:
	.loc 1 541 0
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
	.loc 1 542 0
	leaq	QUARKTS(%rip), %rax
	movzbl	81(%rax), %eax
	testb	%al, %al
	sete	%al
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movb	%dl, 48(%rax)
	.loc 1 543 0
	leaq	QUARKTS(%rip), %rax
	movl	$2, 24(%rax)
	.loc 1 544 0
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
	.loc 1 545 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 81(%rax)
	.loc 1 546 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
	.globl	qSchedulerRun
	.def	qSchedulerRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSchedulerRun
qSchedulerRun:
.LFB22:
	.loc 1 555 0
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
	.loc 1 557 0
	movl	$0, -12(%rbp)
.L85:
	.loc 1 559 0
	leaq	QUARKTS(%rip), %rax
	movzbl	82(%rax), %eax
	testb	%al, %al
	jne	.L104
	.loc 1 560 0
	leaq	QUARKTS(%rip), %rax
	movzbl	80(%rax), %eax
	testb	%al, %al
	jne	.L88
	.loc 1 561 0
	call	_qTaskChainbyPriority
	.loc 1 562 0
	leaq	QUARKTS(%rip), %rax
	movb	$1, 80(%rax)
.L88:
	.loc 1 564 0
	leaq	QUARKTS(%rip), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 565 0
	jmp	.L89
.L102:
	.loc 1 566 0
	call	_qPrioQueueExtract
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L90
	.loc 1 566 0 is_stmt 0 discriminator 1
	movq	-24(%rbp), %rax
	movl	$3, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
.L90:
	.loc 1 567 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	-8(%rbp), %rax
	movl	20(%rax), %eax
	subl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	%eax, %edx
	jnb	.L91
	.loc 1 567 0 is_stmt 0 discriminator 2
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %eax
	testq	%rax, %rax
	js	.L92
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L93
.L92:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L93:
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jp	.L94
	pxor	%xmm1, %xmm1
	ucomiss	%xmm1, %xmm0
	jne	.L94
.L91:
	.loc 1 567 0 discriminator 3
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L96
	.loc 1 567 0 discriminator 5
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	jne	.L94
.L96:
	.loc 1 567 0 discriminator 6
	movq	-8(%rbp), %rax
	movzbl	50(%rax), %eax
	testb	%al, %al
	je	.L94
	.loc 1 568 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 20(%rax)
	.loc 1 569 0
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	cmpb	$-1, %al
	je	.L97
	.loc 1 569 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movb	%dl, 24(%rax)
.L97:
	.loc 1 570 0 is_stmt 1
	movq	-8(%rbp), %rax
	movzbl	24(%rax), %eax
	testb	%al, %al
	jne	.L98
	.loc 1 570 0 is_stmt 0 discriminator 1
	movq	-8(%rbp), %rax
	movb	$0, 50(%rax)
.L98:
	.loc 1 571 0 is_stmt 1
	movq	-8(%rbp), %rax
	movl	$1, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L99
.L94:
	.loc 1 573 0
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	_qCheckRBufferEvents
	movl	%eax, -12(%rbp)
	cmpl	$0, -12(%rbp)
	je	.L100
	.loc 1 574 0
	movl	-12(%rbp), %edx
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	_qTriggerEvent
	.loc 1 575 0
	movq	-8(%rbp), %rax
	movq	64(%rax), %rax
	movzwl	14(%rax), %edx
	addl	$1, %edx
	movw	%dx, 14(%rax)
	jmp	.L99
.L100:
	.loc 1 577 0
	movq	-8(%rbp), %rax
	movzbl	49(%rax), %eax
	testb	%al, %al
	je	.L101
	.loc 1 578 0
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	leaq	QUARKTS(%rip), %rax
	movq	%rdx, 40(%rax)
	.loc 1 579 0
	movq	-8(%rbp), %rax
	movb	$0, 49(%rax)
	.loc 1 580 0
	movq	-8(%rbp), %rax
	movl	$4, %edx
	movq	%rax, %rcx
	call	_qTriggerEvent
	jmp	.L99
.L101:
	.loc 1 582 0
	leaq	QUARKTS(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L99
	.loc 1 582 0 is_stmt 0 discriminator 1
	call	_qTriggerIdleTask
.L99:
	.loc 1 583 0 is_stmt 1
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -8(%rbp)
.L89:
	.loc 1 565 0
	cmpq	$0, -8(%rbp)
	jne	.L102
	.loc 1 585 0
	jmp	.L85
.L104:
	.loc 1 559 0
	nop
.L87:
	.loc 1 586 0
	call	_qTriggerReleaseSchedEvent
	.loc 1 587 0
	nop
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.seh_endproc
	.globl	qStateMachine_Init
	.def	qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Init
qStateMachine_Init:
.LFB23:
	.loc 1 618 0
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
	.loc 1 619 0
	cmpq	$0, 24(%rbp)
	jne	.L106
	.loc 1 619 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L107
.L106:
	.loc 1 620 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 621 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 622 0
	movq	16(%rbp), %rax
	movq	40(%rbp), %rdx
	movq	%rdx, 32(%rax)
	.loc 1 623 0
	movq	16(%rbp), %rax
	movq	32(%rbp), %rdx
	movq	%rdx, 40(%rax)
	.loc 1 624 0
	movq	16(%rbp), %rax
	movq	48(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 625 0
	movl	$0, %eax
.L107:
	.loc 1 626 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.seh_endproc
	.globl	qStateMachine_Run
	.def	qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.seh_proc	qStateMachine_Run
qStateMachine_Run:
.LFB24:
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
	movq	%rdx, 24(%rbp)
	.loc 1 642 0
	movq	$0, -8(%rbp)
	.loc 1 643 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 644 0
	movq	16(%rbp), %rax
	movq	56(%rax), %rax
	testq	%rax, %rax
	je	.L109
	.loc 1 644 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	56(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
.L109:
	.loc 1 645 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L110
	.loc 1 646 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	setne	%al
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movb	%dl, 20(%rax)
	.loc 1 647 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 648 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 649 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L111
.L110:
	.loc 1 651 0
	movq	16(%rbp), %rax
	movl	$-32767, 16(%rax)
.L111:
	.loc 1 653 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$-32768, %eax
	je	.L113
	cmpl	$-32767, %eax
	jne	.L119
	.loc 1 655 0
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	testq	%rax, %rax
	je	.L120
	.loc 1 655 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	32(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 656 0 is_stmt 1 discriminator 1
	jmp	.L120
.L113:
	.loc 1 658 0
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L121
	.loc 1 658 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	40(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 659 0 is_stmt 1 discriminator 1
	jmp	.L121
.L119:
	.loc 1 661 0
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	je	.L122
	.loc 1 661 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movq	48(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 662 0 is_stmt 1 discriminator 1
	jmp	.L122
.L120:
	.loc 1 656 0
	nop
	jmp	.L116
.L121:
	.loc 1 659 0
	nop
	jmp	.L116
.L122:
	.loc 1 662 0
	nop
.L116:
	.loc 1 664 0
	nop
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.seh_endproc
	.globl	qSTimerSet
	.def	qSTimerSet;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerSet
qSTimerSet:
.LFB25:
	.loc 1 685 0
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
	.loc 1 686 0
	cvtss2sd	24(%rbp), %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	ucomisd	%xmm1, %xmm0
	jbe	.L128
	.loc 1 686 0 is_stmt 0 discriminator 1
	movl	$-1, %eax
	jmp	.L126
.L128:
	.loc 1 687 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movss	16(%rax), %xmm1
	movss	24(%rbp), %xmm0
	divss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 8(%rax)
	.loc 1 688 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	%edx, 4(%rax)
	.loc 1 689 0
	movq	16(%rbp), %rax
	movb	$1, (%rax)
	.loc 1 690 0
	movl	$0, %eax
.L126:
	.loc 1 691 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.seh_endproc
	.globl	qSTimerFreeRun
	.def	qSTimerFreeRun;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerFreeRun
qSTimerFreeRun:
.LFB26:
	.loc 1 714 0
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
	.loc 1 715 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L130
	.loc 1 716 0
	movq	16(%rbp), %rcx
	call	qSTimerExpired
	testb	%al, %al
	je	.L131
	.loc 1 717 0
	movq	16(%rbp), %rcx
	call	qSTimerDisarm
	.loc 1 718 0
	movl	$1, %eax
	jmp	.L132
.L131:
	.loc 1 720 0
	movl	$0, %eax
	jmp	.L132
.L130:
	.loc 1 722 0
	movss	24(%rbp), %xmm0
	movaps	%xmm0, %xmm1
	movq	16(%rbp), %rcx
	call	qSTimerSet
.L132:
	.loc 1 723 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.seh_endproc
	.globl	qSTimerExpired
	.def	qSTimerExpired;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerExpired
qSTimerExpired:
.LFB27:
	.loc 1 739 0
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
	.loc 1 740 0
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L134
	.loc 1 740 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L135
.L134:
	.loc 1 741 0 is_stmt 1
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	%eax, %edx
	setnb	%al
.L135:
	.loc 1 742 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.seh_endproc
	.globl	qSTimerElapsed
	.def	qSTimerElapsed;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerElapsed
qSTimerElapsed:
.LFB28:
	.loc 1 756 0
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
	.loc 1 757 0
	movl	_qSysTick_Epochs_(%rip), %edx
	movq	16(%rbp), %rax
	movl	4(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	.loc 1 758 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.seh_endproc
	.globl	qSTimerRemaining
	.def	qSTimerRemaining;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerRemaining
qSTimerRemaining:
.LFB29:
	.loc 1 772 0
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
	.loc 1 773 0
	movq	16(%rbp), %rcx
	call	qSTimerElapsed
	movl	%eax, -4(%rbp)
	.loc 1 774 0
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L139
	.loc 1 774 0 is_stmt 0 discriminator 2
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	cmpl	-4(%rbp), %eax
	jnb	.L140
.L139:
	.loc 1 774 0 discriminator 3
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	jmp	.L141
.L140:
	.loc 1 774 0 discriminator 4
	movq	16(%rbp), %rax
	movl	8(%rax), %eax
	subl	-4(%rbp), %eax
.L141:
	.loc 1 775 0 is_stmt 1 discriminator 6
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.seh_endproc
	.globl	qSTimerDisarm
	.def	qSTimerDisarm;	.scl	2;	.type	32;	.endef
	.seh_proc	qSTimerDisarm
qSTimerDisarm:
.LFB30:
	.loc 1 785 0
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
	.loc 1 786 0
	movq	16(%rbp), %rax
	movb	$0, (%rax)
	.loc 1 787 0
	movq	16(%rbp), %rax
	movl	$0, 4(%rax)
	.loc 1 788 0
	nop
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.seh_endproc
	.globl	qMemoryAlloc
	.def	qMemoryAlloc;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryAlloc
qMemoryAlloc:
.LFB31:
	.loc 1 806 0
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
	.loc 1 809 0
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 810 0
	movb	$0, -2(%rbp)
	.loc 1 811 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L146
	.loc 1 811 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
	.loc 1 812 0 is_stmt 1 discriminator 1
	jmp	.L146
.L161:
	.loc 1 813 0
	movw	$0, -6(%rbp)
	.loc 1 814 0
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	.loc 1 815 0
	jmp	.L147
.L150:
	.loc 1 816 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L163
	.loc 1 817 0
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
	.loc 1 818 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	addb	%al, -1(%rbp)
	.loc 1 819 0
	nop
.L147:
	.loc 1 815 0
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L150
	jmp	.L149
.L163:
	.loc 1 821 0
	nop
.L149:
	.loc 1 823 0
	movzbl	-1(%rbp), %eax
	movb	%al, -2(%rbp)
	.loc 1 824 0
	movb	$1, -3(%rbp)
	movzbl	-2(%rbp), %eax
	movb	%al, -1(%rbp)
	jmp	.L151
.L159:
	.loc 1 825 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L152
	.loc 1 826 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movzbl	-1(%rbp), %eax
	addl	%edx, %eax
	movb	%al, -2(%rbp)
	.loc 1 827 0
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 828 0
	movzbl	-2(%rbp), %edx
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	cltq
	addq	%rax, -16(%rbp)
	.loc 1 829 0
	jmp	.L153
.L152:
	.loc 1 831 0
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	addw	%ax, -6(%rbp)
	.loc 1 832 0
	movzwl	-6(%rbp), %eax
	cmpw	24(%rbp), %ax
	jb	.L154
	.loc 1 833 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-2(%rbp), %eax
	addq	%rax, %rdx
	movzbl	-3(%rbp), %eax
	movb	%al, (%rdx)
	.loc 1 834 0
	movb	$0, -4(%rbp)
	jmp	.L155
.L156:
	.loc 1 834 0 is_stmt 0 discriminator 3
	movzbl	-1(%rbp), %edx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movzbl	-4(%rbp), %eax
	addl	$1, %eax
	movb	%al, -4(%rbp)
.L155:
	.loc 1 834 0 discriminator 1
	movzbl	-4(%rbp), %eax
	cmpw	24(%rbp), %ax
	jb	.L156
	.loc 1 835 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L157
	.loc 1 835 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L157:
	.loc 1 836 0 is_stmt 1
	movq	-16(%rbp), %rax
	jmp	.L158
.L154:
	.loc 1 824 0 discriminator 2
	movzbl	-3(%rbp), %eax
	addl	$1, %eax
	movb	%al, -3(%rbp)
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L151:
	.loc 1 824 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L159
.L153:
	.loc 1 839 0 is_stmt 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	je	.L164
.L146:
	.loc 1 812 0
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-2(%rbp), %al
	ja	.L161
	jmp	.L160
.L164:
	.loc 1 839 0
	nop
.L160:
	.loc 1 841 0
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L162
	.loc 1 841 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L162:
	.loc 1 842 0 is_stmt 1
	movl	$0, %eax
.L158:
	.loc 1 843 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.seh_endproc
	.globl	qMemoryFree
	.def	qMemoryFree;	.scl	2;	.type	32;	.endef
	.seh_proc	qMemoryFree
qMemoryFree:
.LFB32:
	.loc 1 857 0
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
	.loc 1 859 0
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	testq	%rax, %rax
	je	.L166
	.loc 1 859 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	64(%rax), %rax
	call	*%rax
	movl	%eax, %edx
	leaq	QUARKTS(%rip), %rax
	movl	%edx, 84(%rax)
.L166:
	.loc 1 860 0 is_stmt 1
	movq	16(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 861 0
	movb	$0, -1(%rbp)
	jmp	.L167
.L170:
	.loc 1 862 0
	movq	-16(%rbp), %rax
	cmpq	24(%rbp), %rax
	jne	.L168
	.loc 1 863 0
	movq	16(%rbp), %rax
	movq	8(%rax), %rdx
	movzbl	-1(%rbp), %eax
	addq	%rdx, %rax
	movb	$0, (%rax)
	.loc 1 864 0
	jmp	.L169
.L168:
	.loc 1 866 0 discriminator 2
	movq	16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	addq	%rax, -16(%rbp)
	.loc 1 861 0 discriminator 2
	movzbl	-1(%rbp), %eax
	addl	$1, %eax
	movb	%al, -1(%rbp)
.L167:
	.loc 1 861 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzbl	2(%rax), %eax
	cmpb	-1(%rbp), %al
	ja	.L170
.L169:
	.loc 1 868 0 is_stmt 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	testq	%rax, %rax
	je	.L172
	.loc 1 868 0 is_stmt 0 discriminator 1
	leaq	QUARKTS(%rip), %rax
	movq	72(%rax), %rax
	leaq	QUARKTS(%rip), %rdx
	movl	84(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
.L172:
	.loc 1 869 0 is_stmt 1
	nop
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.seh_endproc
	.def	_qRBufferValidPowerOfTwo;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferValidPowerOfTwo
_qRBufferValidPowerOfTwo:
.LFB33:
	.loc 1 874 0
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
	.loc 1 876 0
	movzwl	16(%rbp), %eax
	leal	-1(%rax), %edx
	movzwl	16(%rbp), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	je	.L174
	.loc 1 877 0
	movzwl	16(%rbp), %eax
	subl	$1, %eax
	movw	%ax, 16(%rbp)
	.loc 1 878 0
	movw	$1, -2(%rbp)
	jmp	.L175
.L176:
	.loc 1 878 0 is_stmt 0 discriminator 3
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
.L175:
	.loc 1 878 0 discriminator 1
	cmpw	$15, -2(%rbp)
	jbe	.L176
	.loc 1 879 0 is_stmt 1
	movzwl	16(%rbp), %eax
	addl	$1, %eax
	sarl	%eax
	movw	%ax, 16(%rbp)
.L174:
	.loc 1 881 0
	movzwl	16(%rbp), %eax
	.loc 1 882 0
	addq	$16, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.seh_endproc
	.def	_qRBufferCount;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferCount
_qRBufferCount:
.LFB34:
	.loc 1 884 0
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
	.loc 1 885 0
	cmpq	$0, 16(%rbp)
	je	.L179
	.loc 1 885 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rax
	movzwl	12(%rax), %edx
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	.L181
.L179:
	.loc 1 885 0 discriminator 2
	movl	$0, %eax
.L181:
	.loc 1 886 0 is_stmt 1 discriminator 5
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.seh_endproc
	.def	_qRBufferFull;	.scl	3;	.type	32;	.endef
	.seh_proc	_qRBufferFull
_qRBufferFull:
.LFB35:
	.loc 1 888 0
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
	.loc 1 889 0
	cmpq	$0, 16(%rbp)
	je	.L183
	.loc 1 889 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rcx
	call	_qRBufferCount
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movzwl	10(%rax), %eax
	cmpw	%ax, %dx
	sete	%al
	movzbl	%al, %eax
	jmp	.L185
.L183:
	.loc 1 889 0 discriminator 2
	movl	$1, %eax
.L185:
	.loc 1 890 0 is_stmt 1 discriminator 5
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.seh_endproc
	.globl	qRBufferInit
	.def	qRBufferInit;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferInit
qRBufferInit:
.LFB36:
	.loc 1 909 0
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
	.loc 1 910 0
	cmpq	$0, 16(%rbp)
	je	.L188
	.loc 1 911 0
	movq	16(%rbp), %rax
	movw	$0, 12(%rax)
	.loc 1 912 0
	movq	16(%rbp), %rax
	movw	$0, 14(%rax)
	.loc 1 913 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 914 0
	movq	16(%rbp), %rax
	movzwl	32(%rbp), %edx
	movw	%dx, 8(%rax)
	.loc 1 915 0
	movzwl	40(%rbp), %eax
	movl	%eax, %ecx
	call	_qRBufferValidPowerOfTwo
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movw	%dx, 10(%rax)
.L188:
	.loc 1 917 0
	nop
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.seh_endproc
	.globl	qRBufferEmpty
	.def	qRBufferEmpty;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferEmpty
qRBufferEmpty:
.LFB37:
	.loc 1 931 0
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
	.loc 1 932 0
	cmpq	$0, 16(%rbp)
	je	.L190
	.loc 1 932 0 is_stmt 0 discriminator 1
	movq	16(%rbp), %rcx
	call	_qRBufferCount
	testw	%ax, %ax
	sete	%al
	movzbl	%al, %eax
	jmp	.L192
.L190:
	.loc 1 932 0 discriminator 2
	movl	$1, %eax
.L192:
	.loc 1 933 0 is_stmt 1 discriminator 5
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.seh_endproc
	.globl	qRBufferGetFront
	.def	qRBufferGetFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferGetFront
qRBufferGetFront:
.LFB38:
	.loc 1 947 0
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
	.loc 1 948 0
	cmpq	$0, 16(%rbp)
	je	.L194
	.loc 1 949 0
	movq	16(%rbp), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L195
	.loc 1 949 0 is_stmt 0 discriminator 1
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
	jmp	.L197
.L195:
	.loc 1 949 0 discriminator 2
	movl	$0, %eax
	jmp	.L197
.L194:
	.loc 1 951 0 is_stmt 1
	movl	$0, %eax
.L197:
	.loc 1 952 0
	addq	$32, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.seh_endproc
	.globl	qRBufferPopFront
	.def	qRBufferPopFront;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPopFront
qRBufferPopFront:
.LFB39:
	.loc 1 966 0
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
	.loc 1 967 0
	cmpq	$0, 16(%rbp)
	jne	.L199
	.loc 1 967 0 is_stmt 0 discriminator 1
	movl	$0, %eax
	jmp	.L200
.L199:
	.loc 1 968 0 is_stmt 1
	movq	$0, -8(%rbp)
	.loc 1 969 0
	movq	16(%rbp), %rcx
	call	qRBufferEmpty
	testb	%al, %al
	jne	.L201
	.loc 1 970 0
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
	.loc 1 971 0
	movq	16(%rbp), %rax
	movzwl	14(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movw	%dx, 14(%rax)
.L201:
	.loc 1 973 0
	movq	-8(%rbp), %rax
.L200:
	.loc 1 974 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.seh_endproc
	.globl	qRBufferPush
	.def	qRBufferPush;	.scl	2;	.type	32;	.endef
	.seh_proc	qRBufferPush
qRBufferPush:
.LFB40:
	.loc 1 989 0
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
	.loc 1 990 0
	movb	$0, -1(%rbp)
	.loc 1 991 0
	movq	24(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 992 0
	movq	$0, -24(%rbp)
	.loc 1 995 0
	cmpq	$0, 16(%rbp)
	je	.L203
	.loc 1 995 0 is_stmt 0 discriminator 1
	cmpq	$0, -16(%rbp)
	je	.L203
	.loc 1 996 0 is_stmt 1
	movq	16(%rbp), %rcx
	call	_qRBufferFull
	testb	%al, %al
	jne	.L203
	.loc 1 997 0
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
	.loc 1 998 0
	movw	$0, -4(%rbp)
	jmp	.L204
.L205:
	.loc 1 998 0 is_stmt 0 discriminator 3
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
.L204:
	.loc 1 998 0 discriminator 1
	movq	16(%rbp), %rax
	movzwl	8(%rax), %eax
	cmpw	-4(%rbp), %ax
	ja	.L205
	.loc 1 999 0 is_stmt 1
	movq	16(%rbp), %rax
	movzwl	12(%rax), %eax
	leal	1(%rax), %edx
	movq	16(%rbp), %rax
	movw	%dx, 12(%rax)
	.loc 1 1000 0
	movb	$1, -1(%rbp)
.L203:
	.loc 1 1003 0
	movzbl	-1(%rbp), %eax
	.loc 1 1004 0
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
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
	.long	0x1871
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C99 5.4.0 -mtune=generic -march=x86-64 -g -std=c99\0"
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
	.long	0xad
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x3
	.ascii "__int16_t\0"
	.byte	0x2
	.byte	0x37
	.long	0xcf
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.ascii "short int\0"
	.uleb128 0x3
	.ascii "__uint16_t\0"
	.byte	0x2
	.byte	0x39
	.long	0xee
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
	.long	0x11d
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
	.long	0x9c
	.uleb128 0x3
	.ascii "int16_t\0"
	.byte	0x3
	.byte	0x20
	.long	0xbe
	.uleb128 0x3
	.ascii "uint16_t\0"
	.byte	0x3
	.byte	0x24
	.long	0xdc
	.uleb128 0x3
	.ascii "uint32_t\0"
	.byte	0x3
	.byte	0x30
	.long	0x10b
	.uleb128 0x4
	.byte	0x4
	.long	0x11d
	.byte	0x4
	.byte	0x3e
	.long	0x220
	.uleb128 0x5
	.ascii "_Q_NO_VALID_TRIGGER_\0"
	.byte	0
	.uleb128 0x5
	.ascii "byTimeElapsed\0"
	.byte	0x1
	.uleb128 0x5
	.ascii "byPriority\0"
	.byte	0x2
	.uleb128 0x5
	.ascii "byQueueExtraction\0"
	.byte	0x3
	.uleb128 0x5
	.ascii "byAsyncEvent\0"
	.byte	0x4
	.uleb128 0x5
	.ascii "byRBufferPop\0"
	.byte	0x5
	.uleb128 0x5
	.ascii "byRBufferFull\0"
	.byte	0x6
	.uleb128 0x5
	.ascii "byRBufferCount\0"
	.byte	0x7
	.byte	0
	.uleb128 0x3
	.ascii "qTrigger_t\0"
	.byte	0x4
	.byte	0x3e
	.long	0x18c
	.uleb128 0x3
	.ascii "qTime_t\0"
	.byte	0x4
	.byte	0x3f
	.long	0x241
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x3
	.ascii "qClock_t\0"
	.byte	0x4
	.byte	0x40
	.long	0x17c
	.uleb128 0x3
	.ascii "qPriority_t\0"
	.byte	0x4
	.byte	0x41
	.long	0x14e
	.uleb128 0x3
	.ascii "qIteration_t\0"
	.byte	0x4
	.byte	0x42
	.long	0x14e
	.uleb128 0x3
	.ascii "qState_t\0"
	.byte	0x4
	.byte	0x43
	.long	0x14e
	.uleb128 0x3
	.ascii "qBool_t\0"
	.byte	0x4
	.byte	0x44
	.long	0x14e
	.uleb128 0x3
	.ascii "qSize_t\0"
	.byte	0x4
	.byte	0x45
	.long	0x16c
	.uleb128 0x6
	.byte	0x20
	.byte	0x4
	.byte	0x4f
	.long	0x2f8
	.uleb128 0x7
	.ascii "Trigger\0"
	.byte	0x4
	.byte	0x62
	.long	0x220
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x66
	.long	0x2f8
	.byte	0x8
	.uleb128 0x7
	.ascii "EventData\0"
	.byte	0x4
	.byte	0x6a
	.long	0x2f8
	.byte	0x10
	.uleb128 0x7
	.ascii "FirstCall\0"
	.byte	0x4
	.byte	0x6f
	.long	0x291
	.byte	0x18
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.uleb128 0x3
	.ascii "qEvent_t\0"
	.byte	0x4
	.byte	0x70
	.long	0x2af
	.uleb128 0x3
	.ascii "qTaskFcn_t\0"
	.byte	0x4
	.byte	0x72
	.long	0x31c
	.uleb128 0xa
	.byte	0x8
	.long	0x322
	.uleb128 0xb
	.long	0x32d
	.uleb128 0xc
	.long	0x2fa
	.byte	0
	.uleb128 0x6
	.byte	0x6
	.byte	0x4
	.byte	0x73
	.long	0x399
	.uleb128 0x7
	.ascii "InitFlag\0"
	.byte	0x4
	.byte	0x74
	.long	0x399
	.byte	0
	.uleb128 0x7
	.ascii "AsyncRun\0"
	.byte	0x4
	.byte	0x74
	.long	0x399
	.byte	0x1
	.uleb128 0x7
	.ascii "Enabled\0"
	.byte	0x4
	.byte	0x74
	.long	0x399
	.byte	0x2
	.uleb128 0x7
	.ascii "RBAutoPop\0"
	.byte	0x4
	.byte	0x74
	.long	0x399
	.byte	0x3
	.uleb128 0x7
	.ascii "RBFull\0"
	.byte	0x4
	.byte	0x74
	.long	0x399
	.byte	0x4
	.uleb128 0x7
	.ascii "RBCount\0"
	.byte	0x4
	.byte	0x74
	.long	0x399
	.byte	0x5
	.byte	0
	.uleb128 0xd
	.long	0x14e
	.uleb128 0x3
	.ascii "qTaskFlags_t\0"
	.byte	0x4
	.byte	0x75
	.long	0x32d
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0x79
	.long	0x403
	.uleb128 0x7
	.ascii "data\0"
	.byte	0x4
	.byte	0x7a
	.long	0x403
	.byte	0
	.uleb128 0x8
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x7b
	.long	0x409
	.byte	0x8
	.uleb128 0x7
	.ascii "Elementcount\0"
	.byte	0x4
	.byte	0x7c
	.long	0x409
	.byte	0xa
	.uleb128 0x7
	.ascii "head\0"
	.byte	0x4
	.byte	0x7d
	.long	0x409
	.byte	0xc
	.uleb128 0x7
	.ascii "tail\0"
	.byte	0x4
	.byte	0x7e
	.long	0x409
	.byte	0xe
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x399
	.uleb128 0xd
	.long	0x2a0
	.uleb128 0x3
	.ascii "qRBuffer_t\0"
	.byte	0x4
	.byte	0x7f
	.long	0x3b2
	.uleb128 0x4
	.byte	0x4
	.long	0x104
	.byte	0x4
	.byte	0x81
	.long	0x457
	.uleb128 0xe
	.ascii "qSM_EXIT_SUCCESS\0"
	.sleb128 -32768
	.uleb128 0xe
	.ascii "qSM_EXIT_FAILURE\0"
	.sleb128 -32767
	.byte	0
	.uleb128 0x3
	.ascii "qSM_Status_t\0"
	.byte	0x4
	.byte	0x81
	.long	0x420
	.uleb128 0x6
	.byte	0x20
	.byte	0x4
	.byte	0x9a
	.long	0x4c6
	.uleb128 0x7
	.ascii "__Failure\0"
	.byte	0x4
	.byte	0x9b
	.long	0x561
	.byte	0
	.uleb128 0x7
	.ascii "__Success\0"
	.byte	0x4
	.byte	0x9c
	.long	0x561
	.byte	0x8
	.uleb128 0x7
	.ascii "__Unexpected\0"
	.byte	0x4
	.byte	0x9d
	.long	0x561
	.byte	0x10
	.uleb128 0x7
	.ascii "__BeforeAnyState\0"
	.byte	0x4
	.byte	0x9e
	.long	0x561
	.byte	0x18
	.byte	0
	.uleb128 0xb
	.long	0x4d1
	.uleb128 0xc
	.long	0x4d1
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x55c
	.uleb128 0xf
	.ascii "_qSM_t\0"
	.byte	0x40
	.byte	0x4
	.byte	0x85
	.long	0x55c
	.uleb128 0x7
	.ascii "NextState\0"
	.byte	0x4
	.byte	0x89
	.long	0x576
	.byte	0
	.uleb128 0x7
	.ascii "PreviousState\0"
	.byte	0x4
	.byte	0x8d
	.long	0x576
	.byte	0x8
	.uleb128 0x7
	.ascii "PreviousReturnStatus\0"
	.byte	0x4
	.byte	0x91
	.long	0x457
	.byte	0x10
	.uleb128 0x7
	.ascii "StateJustChanged\0"
	.byte	0x4
	.byte	0x95
	.long	0x291
	.byte	0x14
	.uleb128 0x7
	.ascii "Data\0"
	.byte	0x4
	.byte	0x99
	.long	0x2f8
	.byte	0x18
	.uleb128 0x7
	.ascii "_\0"
	.byte	0x4
	.byte	0xa0
	.long	0x46b
	.byte	0x20
	.byte	0
	.uleb128 0xd
	.long	0x4d7
	.uleb128 0xa
	.byte	0x8
	.long	0x4c6
	.uleb128 0x10
	.long	0x457
	.long	0x576
	.uleb128 0xc
	.long	0x4d1
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x567
	.uleb128 0x3
	.ascii "qSM_State_t\0"
	.byte	0x4
	.byte	0xa2
	.long	0x576
	.uleb128 0x3
	.ascii "qSM_ExState_t\0"
	.byte	0x4
	.byte	0xa3
	.long	0x561
	.uleb128 0xf
	.ascii "_qTask_t\0"
	.byte	0x50
	.byte	0x4
	.byte	0xa5
	.long	0x66e
	.uleb128 0x8
	.secrel32	.LASF0
	.byte	0x4
	.byte	0xa6
	.long	0x2f8
	.byte	0
	.uleb128 0x7
	.ascii "AsyncData\0"
	.byte	0x4
	.byte	0xa6
	.long	0x2f8
	.byte	0x8
	.uleb128 0x7
	.ascii "Interval\0"
	.byte	0x4
	.byte	0xa7
	.long	0x66e
	.byte	0x10
	.uleb128 0x7
	.ascii "ClockStart\0"
	.byte	0x4
	.byte	0xa7
	.long	0x66e
	.byte	0x14
	.uleb128 0x7
	.ascii "Iterations\0"
	.byte	0x4
	.byte	0xa8
	.long	0x26d
	.byte	0x18
	.uleb128 0x7
	.ascii "Cycles\0"
	.byte	0x4
	.byte	0xa9
	.long	0x17c
	.byte	0x1c
	.uleb128 0x8
	.secrel32	.LASF2
	.byte	0x4
	.byte	0xaa
	.long	0x25a
	.byte	0x20
	.uleb128 0x7
	.ascii "Callback\0"
	.byte	0x4
	.byte	0xab
	.long	0x30a
	.byte	0x28
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0xac
	.long	0x673
	.byte	0x30
	.uleb128 0x7
	.ascii "Next\0"
	.byte	0x4
	.byte	0xad
	.long	0x678
	.byte	0x38
	.uleb128 0x7
	.ascii "RingBuff\0"
	.byte	0x4
	.byte	0xae
	.long	0x683
	.byte	0x40
	.uleb128 0x8
	.secrel32	.LASF3
	.byte	0x4
	.byte	0xaf
	.long	0x4d1
	.byte	0x48
	.byte	0
	.uleb128 0xd
	.long	0x24a
	.uleb128 0xd
	.long	0x39e
	.uleb128 0xa
	.byte	0x8
	.long	0x67e
	.uleb128 0xd
	.long	0x5a4
	.uleb128 0xa
	.byte	0x8
	.long	0x40e
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.byte	0xb3
	.long	0x6b0
	.uleb128 0x8
	.secrel32	.LASF4
	.byte	0x4
	.byte	0xb4
	.long	0x678
	.byte	0
	.uleb128 0x7
	.ascii "QueueData\0"
	.byte	0x4
	.byte	0xb5
	.long	0x2f8
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.ascii "qQueueStack_t\0"
	.byte	0x4
	.byte	0xb6
	.long	0x689
	.uleb128 0x6
	.byte	0x8
	.byte	0x4
	.byte	0xb8
	.long	0x729
	.uleb128 0x7
	.ascii "Init\0"
	.byte	0x4
	.byte	0xb9
	.long	0x14e
	.byte	0
	.uleb128 0x7
	.ascii "FCallIdle\0"
	.byte	0x4
	.byte	0xb9
	.long	0x14e
	.byte	0x1
	.uleb128 0x7
	.ascii "ReleaseSched\0"
	.byte	0x4
	.byte	0xb9
	.long	0x14e
	.byte	0x2
	.uleb128 0x7
	.ascii "FCallReleased\0"
	.byte	0x4
	.byte	0xb9
	.long	0x14e
	.byte	0x3
	.uleb128 0x7
	.ascii "IntFlags\0"
	.byte	0x4
	.byte	0xba
	.long	0x17c
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.ascii "qTaskCoreFlags_t\0"
	.byte	0x4
	.byte	0xbb
	.long	0x6c5
	.uleb128 0x6
	.byte	0x68
	.byte	0x4
	.byte	0xbd
	.long	0x813
	.uleb128 0x7
	.ascii "IDLECallback\0"
	.byte	0x4
	.byte	0xbe
	.long	0x30a
	.byte	0
	.uleb128 0x7
	.ascii "ReleaseSchedCallback\0"
	.byte	0x4
	.byte	0xbf
	.long	0x30a
	.byte	0x8
	.uleb128 0x7
	.ascii "Tick\0"
	.byte	0x4
	.byte	0xc0
	.long	0x232
	.byte	0x10
	.uleb128 0x7
	.ascii "EventInfo\0"
	.byte	0x4
	.byte	0xc1
	.long	0x2fa
	.byte	0x18
	.uleb128 0x7
	.ascii "First\0"
	.byte	0x4
	.byte	0xc2
	.long	0x678
	.byte	0x38
	.uleb128 0x7
	.ascii "I_Disable\0"
	.byte	0x4
	.byte	0xc3
	.long	0x818
	.byte	0x40
	.uleb128 0x7
	.ascii "I_Restorer\0"
	.byte	0x4
	.byte	0xc4
	.long	0x829
	.byte	0x48
	.uleb128 0x7
	.ascii "Flag\0"
	.byte	0x4
	.byte	0xc5
	.long	0x82f
	.byte	0x50
	.uleb128 0x7
	.ascii "QueueStack\0"
	.byte	0x4
	.byte	0xc6
	.long	0x834
	.byte	0x58
	.uleb128 0x7
	.ascii "QueueSize\0"
	.byte	0x4
	.byte	0xc7
	.long	0x14e
	.byte	0x60
	.uleb128 0x7
	.ascii "QueueIndex\0"
	.byte	0x4
	.byte	0xc8
	.long	0x15d
	.byte	0x62
	.byte	0
	.uleb128 0x11
	.long	0x17c
	.uleb128 0xa
	.byte	0x8
	.long	0x813
	.uleb128 0xb
	.long	0x829
	.uleb128 0xc
	.long	0x17c
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x81e
	.uleb128 0xd
	.long	0x729
	.uleb128 0xa
	.byte	0x8
	.long	0x83a
	.uleb128 0xd
	.long	0x6b0
	.uleb128 0x3
	.ascii "QuarkTSCoreData_t\0"
	.byte	0x4
	.byte	0xc9
	.long	0x741
	.uleb128 0x4
	.byte	0x4
	.long	0x11d
	.byte	0x4
	.byte	0xd7
	.long	0x887
	.uleb128 0x5
	.ascii "RB_AUTOPOP\0"
	.byte	0
	.uleb128 0x5
	.ascii "RB_FULL\0"
	.byte	0x1
	.uleb128 0x5
	.ascii "RB_COUNT\0"
	.byte	0x2
	.byte	0
	.uleb128 0x3
	.ascii "qRBLinkMode_t\0"
	.byte	0x4
	.byte	0xd7
	.long	0x858
	.uleb128 0x12
	.byte	0xc
	.byte	0x4
	.word	0x160
	.long	0x8cd
	.uleb128 0x13
	.ascii "SR\0"
	.byte	0x4
	.word	0x161
	.long	0x291
	.byte	0
	.uleb128 0x13
	.ascii "Start\0"
	.byte	0x4
	.word	0x162
	.long	0x24a
	.byte	0x4
	.uleb128 0x13
	.ascii "TV\0"
	.byte	0x4
	.word	0x162
	.long	0x24a
	.byte	0x8
	.byte	0
	.uleb128 0x14
	.ascii "qSTimer_t\0"
	.byte	0x4
	.word	0x163
	.long	0x89c
	.uleb128 0x12
	.byte	0x18
	.byte	0x4
	.word	0x173
	.long	0x93e
	.uleb128 0x13
	.ascii "BlockSize\0"
	.byte	0x4
	.word	0x174
	.long	0x16c
	.byte	0
	.uleb128 0x13
	.ascii "NumberofBlocks\0"
	.byte	0x4
	.word	0x175
	.long	0x14e
	.byte	0x2
	.uleb128 0x13
	.ascii "BlockDescriptors\0"
	.byte	0x4
	.word	0x176
	.long	0x93e
	.byte	0x8
	.uleb128 0x13
	.ascii "Blocks\0"
	.byte	0x4
	.word	0x177
	.long	0x93e
	.byte	0x10
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x14e
	.uleb128 0x14
	.ascii "qMemoryPool_t\0"
	.byte	0x4
	.word	0x178
	.long	0x8df
	.uleb128 0x15
	.ascii "qTaskGetCycles\0"
	.byte	0x1
	.byte	0x30
	.long	0x17c
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x995
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x30
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x17
	.ascii "qTaskSendEvent\0"
	.byte	0x1
	.byte	0x42
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x9da
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x42
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x16
	.secrel32	.LASF5
	.byte	0x1
	.byte	0x42
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "qTaskSetTime\0"
	.byte	0x1
	.byte	0x52
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0xa1f
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x52
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "Value\0"
	.byte	0x1
	.byte	0x52
	.long	0x232
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "qTaskSetIterations\0"
	.byte	0x1
	.byte	0x65
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0xa6a
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x65
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "Value\0"
	.byte	0x1
	.byte	0x65
	.long	0x26d
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "qTaskSetPriority\0"
	.byte	0x1
	.byte	0x73
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0xab3
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x73
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "Value\0"
	.byte	0x1
	.byte	0x73
	.long	0x25a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "qTaskSetCallback\0"
	.byte	0x1
	.byte	0x83
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0xafa
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x83
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x16
	.secrel32	.LASF6
	.byte	0x1
	.byte	0x83
	.long	0x30a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "qTaskSetState\0"
	.byte	0x1
	.byte	0x90
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0xb40
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0x90
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "State\0"
	.byte	0x1
	.byte	0x90
	.long	0x281
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "qTaskSetData\0"
	.byte	0x1
	.byte	0xa2
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0xb83
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xa2
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "arg\0"
	.byte	0x1
	.byte	0xa2
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x17
	.ascii "qTaskClearTimeElapsed\0"
	.byte	0x1
	.byte	0xae
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xbc1
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xae
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "qTaskQueueEvent\0"
	.byte	0x1
	.byte	0xc5
	.long	0x104
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xc1a
	.uleb128 0x16
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xc5
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x16
	.secrel32	.LASF5
	.byte	0x1
	.byte	0xc5
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.ascii "qtmp\0"
	.byte	0x1
	.byte	0xc7
	.long	0x6b0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x17
	.ascii "qSchedulerSetInterruptsED\0"
	.byte	0x1
	.byte	0xda
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xc74
	.uleb128 0x18
	.ascii "Restorer\0"
	.byte	0x1
	.byte	0xda
	.long	0x829
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "Disabler\0"
	.byte	0x1
	.byte	0xda
	.long	0x818
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1a
	.ascii "_qPrioQueueExtract\0"
	.byte	0x1
	.byte	0xdf
	.long	0x678
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xcf0
	.uleb128 0x1b
	.secrel32	.LASF4
	.byte	0x1
	.byte	0xe0
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.ascii "i\0"
	.byte	0x1
	.byte	0xe1
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x19
	.ascii "IndexTaskToExtract\0"
	.byte	0x1
	.byte	0xe2
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x19
	.ascii "MaxpValue\0"
	.byte	0x1
	.byte	0xe5
	.long	0x25a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.byte	0
	.uleb128 0x17
	.ascii "_qInitScheduler\0"
	.byte	0x1
	.byte	0xf6
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xd78
	.uleb128 0x18
	.ascii "ISRTick\0"
	.byte	0x1
	.byte	0xf6
	.long	0x232
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.ascii "IdleCallback\0"
	.byte	0x1
	.byte	0xf6
	.long	0x30a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x18
	.ascii "Q_Stack\0"
	.byte	0x1
	.byte	0xf6
	.long	0x834
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x18
	.ascii "Size_Q_Stack\0"
	.byte	0x1
	.byte	0xf6
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x19
	.ascii "i\0"
	.byte	0x1
	.byte	0xf7
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x1c
	.ascii "qSchedulerAddxTask\0"
	.byte	0x1
	.word	0x12d
	.long	0x104
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xe25
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.word	0x12d
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1d
	.secrel32	.LASF6
	.byte	0x1
	.word	0x12d
	.long	0x30a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1d
	.secrel32	.LASF2
	.byte	0x1
	.word	0x12d
	.long	0x25a
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1e
	.ascii "Time\0"
	.byte	0x1
	.word	0x12d
	.long	0x232
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1e
	.ascii "nExecutions\0"
	.byte	0x1
	.word	0x12d
	.long	0x26d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii "InitialState\0"
	.byte	0x1
	.word	0x12d
	.long	0x281
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.ascii "arg\0"
	.byte	0x1
	.word	0x12d
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.byte	0
	.uleb128 0x1f
	.ascii "qSchedulerAddeTask\0"
	.byte	0x1
	.word	0x159
	.long	0x104
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xe93
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.word	0x159
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1d
	.secrel32	.LASF6
	.byte	0x1
	.word	0x159
	.long	0x30a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1d
	.secrel32	.LASF2
	.byte	0x1
	.word	0x159
	.long	0x25a
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1e
	.ascii "arg\0"
	.byte	0x1
	.word	0x159
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x1f
	.ascii "qSchedulerAddSMTask\0"
	.byte	0x1
	.word	0x193
	.long	0x104
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xf86
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.word	0x193
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1d
	.secrel32	.LASF2
	.byte	0x1
	.word	0x193
	.long	0x25a
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.ascii "Time\0"
	.byte	0x1
	.word	0x193
	.long	0x232
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1d
	.secrel32	.LASF3
	.byte	0x1
	.word	0x194
	.long	0x4d1
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1d
	.secrel32	.LASF7
	.byte	0x1
	.word	0x194
	.long	0x57c
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x1e
	.ascii "BeforeAnyState\0"
	.byte	0x1
	.word	0x194
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 40
	.uleb128 0x1d
	.secrel32	.LASF8
	.byte	0x1
	.word	0x194
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.uleb128 0x1d
	.secrel32	.LASF9
	.byte	0x1
	.word	0x194
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 56
	.uleb128 0x1d
	.secrel32	.LASF10
	.byte	0x1
	.word	0x194
	.long	0x58f
	.uleb128 0x3
	.byte	0x91
	.sleb128 64
	.uleb128 0x1e
	.ascii "InitialTaskState\0"
	.byte	0x1
	.word	0x195
	.long	0x281
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.ascii "arg\0"
	.byte	0x1
	.word	0x195
	.long	0x2f8
	.uleb128 0x3
	.byte	0x91
	.sleb128 80
	.byte	0
	.uleb128 0x20
	.ascii "_qTriggerEvent\0"
	.byte	0x1
	.word	0x1a2
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xfd0
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.word	0x1a2
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "Event\0"
	.byte	0x1
	.word	0x1a2
	.long	0x220
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x20
	.ascii "_qTaskChainbyPriority\0"
	.byte	0x1
	.word	0x1ad
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0x1054
	.uleb128 0x21
	.ascii "a\0"
	.byte	0x1
	.word	0x1ae
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x21
	.ascii "b\0"
	.byte	0x1
	.word	0x1ae
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x21
	.ascii "c\0"
	.byte	0x1
	.word	0x1ae
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.ascii "e\0"
	.byte	0x1
	.word	0x1ae
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x21
	.ascii "tmp\0"
	.byte	0x1
	.word	0x1ae
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x21
	.ascii "head\0"
	.byte	0x1
	.word	0x1af
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0x1c
	.ascii "qTaskLinkRBuffer\0"
	.byte	0x1
	.word	0x1ec
	.long	0x104
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x10c8
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.word	0x1ec
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "RingBuffer\0"
	.byte	0x1
	.word	0x1ec
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1e
	.ascii "Mode\0"
	.byte	0x1
	.word	0x1ec
	.long	0x887
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1e
	.ascii "arg\0"
	.byte	0x1
	.word	0x1ec
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x22
	.ascii "_qCheckRBufferEvents\0"
	.byte	0x1
	.word	0x1ff
	.long	0x220
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0x112c
	.uleb128 0x1d
	.secrel32	.LASF4
	.byte	0x1
	.word	0x1ff
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x21
	.ascii "rb\0"
	.byte	0x1
	.word	0x200
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.ascii "popdata\0"
	.byte	0x1
	.word	0x201
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0x23
	.ascii "_qTriggerReleaseSchedEvent\0"
	.byte	0x1
	.word	0x214
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x23
	.ascii "_qTriggerIdleTask\0"
	.byte	0x1
	.word	0x21d
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x24
	.ascii "qSchedulerRun\0"
	.byte	0x1
	.word	0x22b
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x1215
	.uleb128 0x25
	.secrel32	.LASF4
	.byte	0x1
	.word	0x22c
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x21
	.ascii "qTask\0"
	.byte	0x1
	.word	0x22c
	.long	0x678
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.ascii "trg\0"
	.byte	0x1
	.word	0x22d
	.long	0x220
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x26
	.ascii "qMainSchedule\0"
	.byte	0x1
	.word	0x22e
	.quad	.L85
	.uleb128 0x26
	.ascii "qReleasedSchedule\0"
	.byte	0x1
	.word	0x24a
	.quad	.L87
	.byte	0
	.uleb128 0x1c
	.ascii "qStateMachine_Init\0"
	.byte	0x1
	.word	0x26a
	.long	0x104
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x1292
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x26a
	.long	0x4d1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1d
	.secrel32	.LASF7
	.byte	0x1
	.word	0x26a
	.long	0x57c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1d
	.secrel32	.LASF8
	.byte	0x1
	.word	0x26a
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1d
	.secrel32	.LASF9
	.byte	0x1
	.word	0x26a
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1d
	.secrel32	.LASF10
	.byte	0x1
	.word	0x26a
	.long	0x58f
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0x24
	.ascii "qStateMachine_Run\0"
	.byte	0x1
	.word	0x281
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x12ee
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x281
	.long	0x4d1
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "Data\0"
	.byte	0x1
	.word	0x281
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x21
	.ascii "prev\0"
	.byte	0x1
	.word	0x282
	.long	0x57c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1c
	.ascii "qSTimerSet\0"
	.byte	0x1
	.word	0x2ad
	.long	0x291
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0x1337
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x2ad
	.long	0x1337
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "Time\0"
	.byte	0x1
	.word	0x2ad
	.long	0x232
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x8cd
	.uleb128 0x1f
	.ascii "qSTimerFreeRun\0"
	.byte	0x1
	.word	0x2ca
	.long	0x291
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.long	0x138a
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x2ca
	.long	0x1337
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "Time\0"
	.byte	0x1
	.word	0x2ca
	.long	0x232
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.uleb128 0x1c
	.ascii "qSTimerExpired\0"
	.byte	0x1
	.word	0x2e3
	.long	0x291
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.long	0x13c7
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x2e3
	.long	0x1337
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1c
	.ascii "qSTimerElapsed\0"
	.byte	0x1
	.word	0x2f4
	.long	0x24a
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.long	0x1404
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x2f4
	.long	0x1337
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1f
	.ascii "qSTimerRemaining\0"
	.byte	0x1
	.word	0x304
	.long	0x24a
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.long	0x1456
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x304
	.long	0x1337
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x21
	.ascii "elapsed\0"
	.byte	0x1
	.word	0x305
	.long	0x24a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x27
	.ascii "qSTimerDisarm\0"
	.byte	0x1
	.word	0x311
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.uleb128 0x1
	.byte	0x9c
	.long	0x148e
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x311
	.long	0x1337
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1f
	.ascii "qMemoryAlloc\0"
	.byte	0x1
	.word	0x326
	.long	0x2f8
	.quad	.LFB31
	.quad	.LFE31-.LFB31
	.uleb128 0x1
	.byte	0x9c
	.long	0x152e
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x326
	.long	0x152e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "size\0"
	.byte	0x1
	.word	0x326
	.long	0x16c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x21
	.ascii "i\0"
	.byte	0x1
	.word	0x327
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x21
	.ascii "j\0"
	.byte	0x1
	.word	0x327
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x21
	.ascii "k\0"
	.byte	0x1
	.word	0x327
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.uleb128 0x21
	.ascii "c\0"
	.byte	0x1
	.word	0x327
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x21
	.ascii "sum\0"
	.byte	0x1
	.word	0x328
	.long	0x16c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x21
	.ascii "offset\0"
	.byte	0x1
	.word	0x329
	.long	0x93e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x944
	.uleb128 0x24
	.ascii "qMemoryFree\0"
	.byte	0x1
	.word	0x359
	.quad	.LFB32
	.quad	.LFE32-.LFB32
	.uleb128 0x1
	.byte	0x9c
	.long	0x1594
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x359
	.long	0x152e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "pmem\0"
	.byte	0x1
	.word	0x359
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x21
	.ascii "i\0"
	.byte	0x1
	.word	0x35a
	.long	0x14e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x21
	.ascii "p\0"
	.byte	0x1
	.word	0x35a
	.long	0x93e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x28
	.ascii "_qRBufferValidPowerOfTwo\0"
	.byte	0x1
	.word	0x36a
	.long	0x2a0
	.quad	.LFB33
	.quad	.LFE33-.LFB33
	.uleb128 0x1
	.byte	0x9c
	.long	0x15e6
	.uleb128 0x1e
	.ascii "k\0"
	.byte	0x1
	.word	0x36a
	.long	0x2a0
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x21
	.ascii "i\0"
	.byte	0x1
	.word	0x36b
	.long	0x16c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.byte	0
	.uleb128 0x28
	.ascii "_qRBufferCount\0"
	.byte	0x1
	.word	0x374
	.long	0x2a0
	.quad	.LFB34
	.quad	.LFE34-.LFB34
	.uleb128 0x1
	.byte	0x9c
	.long	0x1623
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x374
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x22
	.ascii "_qRBufferFull\0"
	.byte	0x1
	.word	0x378
	.long	0x291
	.quad	.LFB35
	.quad	.LFE35-.LFB35
	.uleb128 0x1
	.byte	0x9c
	.long	0x165f
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x378
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x24
	.ascii "qRBufferInit\0"
	.byte	0x1
	.word	0x38d
	.quad	.LFB36
	.quad	.LFE36-.LFB36
	.uleb128 0x1
	.byte	0x9c
	.long	0x16d2
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x38d
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "DataBlock\0"
	.byte	0x1
	.word	0x38d
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x1d
	.secrel32	.LASF1
	.byte	0x1
	.word	0x38d
	.long	0x2a0
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1e
	.ascii "ElementCount\0"
	.byte	0x1
	.word	0x38d
	.long	0x2a0
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.byte	0
	.uleb128 0x1f
	.ascii "qRBufferEmpty\0"
	.byte	0x1
	.word	0x3a3
	.long	0x291
	.quad	.LFB37
	.quad	.LFE37-.LFB37
	.uleb128 0x1
	.byte	0x9c
	.long	0x170e
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x3a3
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1f
	.ascii "qRBufferGetFront\0"
	.byte	0x1
	.word	0x3b3
	.long	0x2f8
	.quad	.LFB38
	.quad	.LFE38-.LFB38
	.uleb128 0x1
	.byte	0x9c
	.long	0x174d
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x3b3
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1f
	.ascii "qRBufferPopFront\0"
	.byte	0x1
	.word	0x3c6
	.long	0x2f8
	.quad	.LFB39
	.quad	.LFE39-.LFB39
	.uleb128 0x1
	.byte	0x9c
	.long	0x179c
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x3c6
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x21
	.ascii "data\0"
	.byte	0x1
	.word	0x3c8
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1f
	.ascii "qRBufferPush\0"
	.byte	0x1
	.word	0x3dd
	.long	0x291
	.quad	.LFB40
	.quad	.LFE40-.LFB40
	.uleb128 0x1
	.byte	0x9c
	.long	0x1833
	.uleb128 0x1e
	.ascii "obj\0"
	.byte	0x1
	.word	0x3dd
	.long	0x683
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.ascii "data\0"
	.byte	0x1
	.word	0x3dd
	.long	0x2f8
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x21
	.ascii "status\0"
	.byte	0x1
	.word	0x3de
	.long	0x291
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x21
	.ascii "data_element\0"
	.byte	0x1
	.word	0x3df
	.long	0x93e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x21
	.ascii "ring_data\0"
	.byte	0x1
	.word	0x3e0
	.long	0x403
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.ascii "i\0"
	.byte	0x1
	.word	0x3e1
	.long	0x16c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x29
	.ascii "QUARKTS\0"
	.byte	0x1
	.byte	0x15
	.long	0x184c
	.uleb128 0x9
	.byte	0x3
	.quad	QUARKTS
	.uleb128 0xd
	.long	0x83f
	.uleb128 0x29
	.ascii "_qSysTick_Epochs_\0"
	.byte	0x1
	.byte	0x16
	.long	0x66e
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
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
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
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
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
	.uleb128 0x1a
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
	.uleb128 0x1b
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
	.uleb128 0x1c
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
	.uleb128 0x1d
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
	.uleb128 0x20
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
.LASF9:
	.ascii "FailureState\0"
.LASF7:
	.ascii "InitState\0"
.LASF0:
	.ascii "TaskData\0"
.LASF10:
	.ascii "UnexpectedState\0"
.LASF6:
	.ascii "CallbackFcn\0"
.LASF3:
	.ascii "StateMachine\0"
.LASF1:
	.ascii "ElementSize\0"
.LASF2:
	.ascii "Priority\0"
.LASF5:
	.ascii "eventdata\0"
.LASF4:
	.ascii "Task\0"
.LASF8:
	.ascii "SuccessState\0"
	.ident	"GCC: (GNU) 5.4.0"
