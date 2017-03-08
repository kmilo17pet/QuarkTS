	.file	"QuarkSM.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
.lcomm __qSM_Error,8,8
.lcomm __qSM_OK,8,8
.lcomm __qSM_Unexpected,8,8
	.globl	_qStateMachine_Init
	.def	_qStateMachine_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStateMachine_Init
_qStateMachine_Init:
.LFB0:
	.file 1 "QuarkSM.c"
	.loc 1 8 0
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
	.loc 1 9 0
	movq	16(%rbp), %rax
	movq	24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 10 0
	movq	16(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 11 0
	movq	40(%rbp), %rax
	movq	%rax, __qSM_Error(%rip)
	.loc 1 12 0
	movq	32(%rbp), %rax
	movq	%rax, __qSM_OK(%rip)
	.loc 1 13 0
	movq	48(%rbp), %rax
	movq	%rax, __qSM_Unexpected(%rip)
	.loc 1 14 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.seh_endproc
	.globl	_qStateMachine_Run
	.def	_qStateMachine_Run;	.scl	2;	.type	32;	.endef
	.seh_proc	_qStateMachine_Run
_qStateMachine_Run:
.LFB1:
	.loc 1 16 0
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
	.loc 1 17 0
	movq	$0, -8(%rbp)
	.loc 1 18 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L3
	.loc 1 19 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 20 0
	movq	16(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movl	%edx, 16(%rax)
	.loc 1 21 0
	movq	16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L4
.L3:
	.loc 1 23 0
	movq	16(%rbp), %rax
	movl	$65263, 16(%rax)
.L4:
	.loc 1 25 0
	movq	16(%rbp), %rax
	movl	16(%rax), %eax
	cmpl	$65199, %eax
	je	.L6
	cmpl	$65263, %eax
	jne	.L13
	.loc 1 27 0
	movq	__qSM_Error(%rip), %rax
	testq	%rax, %rax
	je	.L8
	.loc 1 27 0 is_stmt 0 discriminator 1
	movq	__qSM_Error(%rip), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 28 0 is_stmt 1 discriminator 1
	jmp	.L9
.L8:
	.loc 1 28 0 is_stmt 0
	jmp	.L9
.L6:
	.loc 1 30 0 is_stmt 1
	movq	__qSM_OK(%rip), %rax
	testq	%rax, %rax
	je	.L10
	.loc 1 30 0 is_stmt 0 discriminator 1
	movq	__qSM_OK(%rip), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 31 0 is_stmt 1 discriminator 1
	jmp	.L9
.L10:
	.loc 1 31 0 is_stmt 0
	jmp	.L9
.L13:
	.loc 1 33 0 is_stmt 1
	movq	__qSM_Unexpected(%rip), %rax
	testq	%rax, %rax
	je	.L11
	.loc 1 33 0 is_stmt 0 discriminator 1
	movq	__qSM_Unexpected(%rip), %rax
	movq	16(%rbp), %rcx
	call	*%rax
	.loc 1 34 0 is_stmt 1 discriminator 1
	jmp	.L14
.L11:
.L14:
	.loc 1 34 0 is_stmt 0
	nop
.L9:
	.loc 1 37 0 is_stmt 1
	movl	$0, %eax
	.loc 1 38 0
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.seh_endproc
.Letext0:
	.file 2 "QuarkSM.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x337
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C 4.9.3 -mtune=generic -march=x86-64 -g\0"
	.byte	0x1
	.ascii "QuarkSM.c\0"
	.ascii "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS\0"
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.secrel32	.Ldebug_line0
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.ascii "long int\0"
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
	.uleb128 0x3
	.ascii "state\0"
	.byte	0x4
	.byte	0x2
	.byte	0x1d
	.long	0x162
	.uleb128 0x4
	.ascii "SM_ERROR\0"
	.sleb128 65263
	.uleb128 0x4
	.ascii "SM_OK\0"
	.sleb128 65199
	.byte	0
	.uleb128 0x5
	.ascii "qSM_Status_t\0"
	.byte	0x2
	.byte	0x1d
	.long	0x13c
	.uleb128 0x6
	.ascii "_qSM_t\0"
	.byte	0x18
	.byte	0x2
	.byte	0x1f
	.long	0x1cb
	.uleb128 0x7
	.ascii "NextState\0"
	.byte	0x2
	.byte	0x20
	.long	0x1e5
	.byte	0
	.uleb128 0x7
	.ascii "PreviousState\0"
	.byte	0x2
	.byte	0x21
	.long	0x1e5
	.byte	0x8
	.uleb128 0x7
	.ascii "PreviousReturnStatus\0"
	.byte	0x2
	.byte	0x22
	.long	0x162
	.byte	0x10
	.byte	0
	.uleb128 0x8
	.long	0x162
	.long	0x1da
	.uleb128 0x9
	.long	0x1da
	.byte	0
	.uleb128 0xa
	.byte	0x8
	.long	0x1e0
	.uleb128 0xb
	.long	0x176
	.uleb128 0xa
	.byte	0x8
	.long	0x1cb
	.uleb128 0x5
	.ascii "qSM_State_t\0"
	.byte	0x2
	.byte	0x26
	.long	0x1e5
	.uleb128 0xc
	.ascii "_qStateMachine_Init\0"
	.byte	0x1
	.byte	0x8
	.long	0xe6
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x293
	.uleb128 0xd
	.ascii "obj\0"
	.byte	0x1
	.byte	0x8
	.long	0x1da
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xd
	.ascii "InitState\0"
	.byte	0x1
	.byte	0x8
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0xd
	.ascii "OKState\0"
	.byte	0x1
	.byte	0x8
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0xd
	.ascii "ErrorState\0"
	.byte	0x1
	.byte	0x8
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0xd
	.ascii "UnexpectedState\0"
	.byte	0x1
	.byte	0x8
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.byte	0
	.uleb128 0xe
	.ascii "_qStateMachine_Run\0"
	.byte	0x1
	.byte	0x10
	.long	0xe6
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x2e1
	.uleb128 0xd
	.ascii "obj\0"
	.byte	0x1
	.byte	0x10
	.long	0x1da
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xf
	.ascii "prev\0"
	.byte	0x1
	.byte	0x11
	.long	0x1eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xf
	.ascii "__qSM_Error\0"
	.byte	0x1
	.byte	0x3
	.long	0x1e5
	.uleb128 0x9
	.byte	0x3
	.quad	__qSM_Error
	.uleb128 0xf
	.ascii "__qSM_OK\0"
	.byte	0x1
	.byte	0x4
	.long	0x1e5
	.uleb128 0x9
	.byte	0x3
	.quad	__qSM_OK
	.uleb128 0xf
	.ascii "__qSM_Unexpected\0"
	.byte	0x1
	.byte	0x5
	.long	0x1e5
	.uleb128 0x9
	.byte	0x3
	.quad	__qSM_Unexpected
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
	.uleb128 0x9
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xe
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
	.uleb128 0xf
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
	.ident	"GCC: (GNU) 4.9.3"
