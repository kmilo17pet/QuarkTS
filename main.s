	.file	"main.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	qID_task1, 1, 0
	.comm	qID_task2, 1, 0
	.comm	qID_task3, 1, 0
	.comm	qID_task4, 1, 0
	.comm	qID_task5, 1, 0
	.comm	TimerEmulation, 8, 3
	.globl	TimerInterruptEmulation
	.def	TimerInterruptEmulation;	.scl	2;	.type	32;	.endef
	.seh_proc	TimerInterruptEmulation
TimerInterruptEmulation:
.LFB7:
	.file 1 "main.c"
	.loc 1 15 0
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
	.loc 1 16 0
	movq	$0, -16(%rbp)
	movq	$10000000, -8(%rbp)
.L2:
	.loc 1 18 0 discriminator 1
	leaq	-16(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	nanosleep
	.loc 1 19 0 discriminator 1
	call	__qISRHandler
	.loc 1 20 0 discriminator 1
	jmp	.L2
	.cfi_endproc
.LFE7:
	.seh_endproc
	.globl	IdleTask
	.def	IdleTask;	.scl	2;	.type	32;	.endef
	.seh_proc	IdleTask
IdleTask:
.LFB8:
	.loc 1 23 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	.seh_endprologue
	.loc 1 25 0
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "\15\12t1:%u,%u,%u,%s\15\12\0"
	.text
	.globl	task1
	.def	task1;	.scl	2;	.type	32;	.endef
	.seh_proc	task1
task1:
.LFB9:
	.loc 1 27 0
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
	movq	%rcx, %rbx
	.loc 1 28 0
	movq	8(%rbx), %rdx
	movzbl	2(%rbx), %eax
	movzbl	%al, %r8d
	movzbl	1(%rbx), %eax
	movzbl	%al, %ecx
	movzbl	(%rbx), %eax
	movzbl	%al, %eax
	movq	%rdx, 32(%rsp)
	movl	%r8d, %r9d
	movl	%ecx, %r8d
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	nop
	.loc 1 30 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "\15\12t2-%u,%u,%u,%s\15\12\0"
	.text
	.globl	task2
	.def	task2;	.scl	2;	.type	32;	.endef
	.seh_proc	task2
task2:
.LFB10:
	.loc 1 31 0
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
	movq	%rcx, %rbx
	.loc 1 32 0
	movq	8(%rbx), %rdx
	movzbl	2(%rbx), %eax
	movzbl	%al, %r8d
	movzbl	1(%rbx), %eax
	movzbl	%al, %ecx
	movzbl	(%rbx), %eax
	movzbl	%al, %eax
	movq	%rdx, 32(%rsp)
	movl	%r8d, %r9d
	movl	%ecx, %r8d
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	nop
	.loc 1 33 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.section .rdata,"dr"
.LC2:
	.ascii "\15\12t3-%u,%u,%u,%s\15\12\0"
	.text
	.globl	task3
	.def	task3;	.scl	2;	.type	32;	.endef
	.seh_proc	task3
task3:
.LFB11:
	.loc 1 34 0
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
	movq	%rcx, %rbx
	.loc 1 35 0
	movq	8(%rbx), %rdx
	movzbl	2(%rbx), %eax
	movzbl	%al, %r8d
	movzbl	1(%rbx), %eax
	movzbl	%al, %ecx
	movzbl	(%rbx), %eax
	movzbl	%al, %eax
	movq	%rdx, 32(%rsp)
	movl	%r8d, %r9d
	movl	%ecx, %r8d
	movl	%eax, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	.loc 1 36 0
	leaq	qID_task1(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %ecx
	call	__qSendEvent
	nop
	.loc 1 37 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.section .rdata,"dr"
.LC3:
	.ascii "\15\12TASK5-%u,%u,%u,%s\15\12\0"
	.text
	.globl	task5
	.def	task5;	.scl	2;	.type	32;	.endef
	.seh_proc	task5
task5:
.LFB12:
	.loc 1 38 0
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
	movq	%rcx, %rbx
	.loc 1 39 0
	movq	8(%rbx), %rdx
	movzbl	2(%rbx), %eax
	movzbl	%al, %r8d
	movzbl	1(%rbx), %eax
	movzbl	%al, %ecx
	movzbl	(%rbx), %eax
	movzbl	%al, %eax
	movq	%rdx, 32(%rsp)
	movl	%r8d, %r9d
	movl	%ecx, %r8d
	movl	%eax, %edx
	leaq	.LC3(%rip), %rcx
	call	printf
	nop
	.loc 1 40 0
	addq	$56, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -40
	ret
	.cfi_endproc
.LFE12:
	.seh_endproc
	.section .rdata,"dr"
.LC4:
	.ascii "\15\12t4-%u,%u,%u\15\12\0"
.LC5:
	.ascii "data 1 t2\0"
.LC6:
	.ascii "hello\0"
.LC7:
	.ascii "hi!\0"
.LC8:
	.ascii "pkernel\0"
.LC9:
	.ascii "task 2 t2\0"
	.text
	.globl	task4
	.def	task4;	.scl	2;	.type	32;	.endef
	.seh_proc	task4
task4:
.LFB13:
	.loc 1 41 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, -64
	.seh_endprologue
	movq	%rcx, %rbx
	.loc 1 42 0
	movzbl	2(%rbx), %eax
	movzbl	%al, %ecx
	movzbl	1(%rbx), %eax
	movzbl	%al, %edx
	movzbl	(%rbx), %eax
	movzbl	%al, %eax
	movl	%ecx, %r9d
	movl	%edx, %r8d
	movl	%eax, %edx
	leaq	.LC4(%rip), %rcx
	call	printf
	.loc 1 43 0
	leaq	qID_task1(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %ecx
	call	__qSendEvent
	.loc 1 44 0
	leaq	.LC5(%rip), %rdx
	leaq	qID_task2(%rip), %rax
	movq	%rax, %rcx
	call	__qQueueTaskEvent
	.loc 1 45 0
	leaq	.LC6(%rip), %rdx
	leaq	qID_task3(%rip), %rax
	movq	%rax, %rcx
	call	__qQueueTaskEvent
	.loc 1 46 0
	leaq	.LC7(%rip), %rdx
	leaq	qID_task1(%rip), %rax
	movq	%rax, %rcx
	call	__qQueueTaskEvent
	.loc 1 47 0
	leaq	.LC8(%rip), %rdx
	leaq	qID_task1(%rip), %rax
	movq	%rax, %rcx
	call	__qQueueTaskEvent
	.loc 1 48 0
	leaq	.LC9(%rip), %rdx
	leaq	qID_task2(%rip), %rax
	movq	%rax, %rcx
	call	__qQueueTaskEvent
	nop
	.loc 1 49 0
	addq	$40, %rsp
	popq	%rbx
	.cfi_restore 3
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -24
	ret
	.cfi_endproc
.LFE13:
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB14:
	.loc 1 51 0
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	subq	$512, %rsp
	.seh_stackalloc	512
	.cfi_def_cfa_offset 528
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.cfi_def_cfa 6, 400
	.seh_endprologue
	.loc 1 51 0
	call	__main
	.loc 1 52 0
	movl	$0, %r9d
	leaq	TimerInterruptEmulation(%rip), %r8
	movl	$0, %edx
	leaq	TimerEmulation(%rip), %rax
	movq	%rax, %rcx
	call	pthread_create
	.loc 1 54 0
	leaq	-64(%rbp), %rdx
	leaq	96(%rbp), %rcx
	movq	$0, 40(%rsp)
	movl	.LC10(%rip), %eax
	movl	%eax, 32(%rsp)
	movl	$10, %r9d
	movq	%rdx, %r8
	movl	$5, %edx
	call	__qInit
	.loc 1 55 0
	movq	$0, 48(%rsp)
	movl	$0, 40(%rsp)
	movl	$1, 32(%rsp)
	xorps	%xmm3, %xmm3
	movl	$61, %r8d
	leaq	task1(%rip), %rdx
	leaq	qID_task1(%rip), %rax
	movq	%rax, %rcx
	call	__qTaskAttach
	.loc 1 56 0
	movq	$0, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$-1, 32(%rsp)
	movss	.LC12(%rip), %xmm3
	movl	$20, %r8d
	leaq	task2(%rip), %rdx
	leaq	qID_task2(%rip), %rax
	movq	%rax, %rcx
	call	__qTaskAttach
	.loc 1 57 0
	movq	$0, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$2, 32(%rsp)
	movss	.LC12(%rip), %xmm3
	movl	$30, %r8d
	leaq	task3(%rip), %rdx
	leaq	qID_task3(%rip), %rax
	movq	%rax, %rcx
	call	__qTaskAttach
	.loc 1 58 0
	movq	$0, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$2, 32(%rsp)
	movss	.LC13(%rip), %xmm3
	movl	$8, %r8d
	leaq	task4(%rip), %rdx
	leaq	qID_task4(%rip), %rax
	movq	%rax, %rcx
	call	__qTaskAttach
	.loc 1 59 0
	movq	$0, 48(%rsp)
	movl	$1, 40(%rsp)
	movl	$1, 32(%rsp)
	movss	.LC14(%rip), %xmm3
	movl	$8, %r8d
	leaq	task5(%rip), %rdx
	leaq	qID_task5(%rip), %rax
	movq	%rax, %rcx
	call	__qTaskAttach
	.loc 1 60 0
	call	__qStartScheduler
	.loc 1 62 0
	movl	$0, %eax
	.loc 1 63 0
	addq	$512, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, -504
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.section .rdata,"dr"
	.align 4
.LC10:
	.long	1008981770
	.align 4
.LC12:
	.long	1065353216
	.align 4
.LC13:
	.long	1069547520
	.align 4
.LC14:
	.long	1073741824
	.text
.Letext0:
	.file 2 "/usr/include/sys/types.h"
	.file 3 "/usr/include/cygwin/types.h"
	.file 4 "QuarkTS.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x704
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C 4.8.3 -fpreprocessed -mtune=generic -march=x86-64 -g\0"
	.byte	0x1
	.ascii "main.c\0"
	.ascii "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS\0"
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.secrel32	.Ldebug_line0
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
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
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
	.ascii "long int\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
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
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x4
	.ascii "time_t\0"
	.byte	0x2
	.byte	0x7a
	.long	0xe8
	.uleb128 0x5
	.ascii "timespec\0"
	.byte	0x10
	.byte	0x2
	.byte	0x82
	.long	0x189
	.uleb128 0x6
	.ascii "tv_sec\0"
	.byte	0x2
	.byte	0x83
	.long	0x14a
	.byte	0
	.uleb128 0x6
	.ascii "tv_nsec\0"
	.byte	0x2
	.byte	0x84
	.long	0xe8
	.byte	0x8
	.byte	0
	.uleb128 0x5
	.ascii "__pthread_t\0"
	.byte	0x1
	.byte	0x3
	.byte	0xb2
	.long	0x1ae
	.uleb128 0x6
	.ascii "__dummy\0"
	.byte	0x3
	.byte	0xb2
	.long	0x109
	.byte	0
	.byte	0
	.uleb128 0x4
	.ascii "pthread_t\0"
	.byte	0x3
	.byte	0xb2
	.long	0x1bf
	.uleb128 0x7
	.byte	0x8
	.long	0x189
	.uleb128 0x8
	.byte	0x4
	.byte	0x4
	.byte	0x1f
	.long	0x202
	.uleb128 0x9
	.ascii "LOWEST_Priority\0"
	.sleb128 0
	.uleb128 0x9
	.ascii "MEDIUM_Priority\0"
	.sleb128 30
	.uleb128 0x9
	.ascii "HIGH_Priority\0"
	.sleb128 61
	.byte	0
	.uleb128 0x4
	.ascii "qPriorityValue_t\0"
	.byte	0x4
	.byte	0x1f
	.long	0x1c5
	.uleb128 0x4
	.ascii "qIter_t\0"
	.byte	0x4
	.byte	0x23
	.long	0xd8
	.uleb128 0x4
	.ascii "qTaskID_t\0"
	.byte	0x4
	.byte	0x32
	.long	0x9d
	.uleb128 0x4
	.ascii "qPriority_t\0"
	.byte	0x4
	.byte	0x33
	.long	0x9d
	.uleb128 0x4
	.ascii "qPeriod_t\0"
	.byte	0x4
	.byte	0x34
	.long	0xf4
	.uleb128 0x4
	.ascii "qClock_t\0"
	.byte	0x4
	.byte	0x35
	.long	0xf4
	.uleb128 0x4
	.ascii "qTime_t\0"
	.byte	0x4
	.byte	0x37
	.long	0x27d
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0xa
	.byte	0x18
	.byte	0x4
	.byte	0x39
	.long	0x2dc
	.uleb128 0x6
	.ascii "FirstCall\0"
	.byte	0x4
	.byte	0x3a
	.long	0x9d
	.byte	0
	.uleb128 0x6
	.ascii "LastTaskID\0"
	.byte	0x4
	.byte	0x3a
	.long	0x9d
	.byte	0x1
	.uleb128 0x6
	.ascii "Trigger\0"
	.byte	0x4
	.byte	0x3a
	.long	0x9d
	.byte	0x2
	.uleb128 0xb
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x3b
	.long	0x111
	.byte	0x8
	.uleb128 0xb
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x3b
	.long	0x111
	.byte	0x10
	.byte	0
	.uleb128 0x4
	.ascii "qEventInfo_t\0"
	.byte	0x4
	.byte	0x3c
	.long	0x286
	.uleb128 0x4
	.ascii "qTask\0"
	.byte	0x4
	.byte	0x3e
	.long	0x2fd
	.uleb128 0x7
	.byte	0x8
	.long	0x303
	.uleb128 0xc
	.long	0x30e
	.uleb128 0xd
	.long	0x2dc
	.byte	0
	.uleb128 0xa
	.byte	0x10
	.byte	0x4
	.byte	0x40
	.long	0x332
	.uleb128 0x6
	.ascii "TaskID\0"
	.byte	0x4
	.byte	0x41
	.long	0x332
	.byte	0
	.uleb128 0xb
	.secrel32	.LASF0
	.byte	0x4
	.byte	0x42
	.long	0x111
	.byte	0x8
	.byte	0
	.uleb128 0x7
	.byte	0x8
	.long	0x338
	.uleb128 0xe
	.long	0x229
	.uleb128 0x4
	.ascii "qQueueStack_t\0"
	.byte	0x4
	.byte	0x43
	.long	0x30e
	.uleb128 0xa
	.byte	0x4
	.byte	0x4
	.byte	0x45
	.long	0x3b0
	.uleb128 0xf
	.ascii "Enable\0"
	.byte	0x4
	.byte	0x46
	.long	0xd8
	.byte	0x4
	.byte	0x1
	.byte	0x1f
	.byte	0
	.uleb128 0xf
	.ascii "TimedTaskRun\0"
	.byte	0x4
	.byte	0x47
	.long	0xd8
	.byte	0x4
	.byte	0x8
	.byte	0x17
	.byte	0
	.uleb128 0xf
	.ascii "AsyncRun\0"
	.byte	0x4
	.byte	0x48
	.long	0xd8
	.byte	0x4
	.byte	0x1
	.byte	0x16
	.byte	0
	.uleb128 0xf
	.ascii "FcnInitFlag\0"
	.byte	0x4
	.byte	0x49
	.long	0xd8
	.byte	0x4
	.byte	0x1
	.byte	0x15
	.byte	0
	.byte	0
	.uleb128 0x4
	.ascii "qTaskFlags_t\0"
	.byte	0x4
	.byte	0x4a
	.long	0x352
	.uleb128 0xa
	.byte	0x38
	.byte	0x4
	.byte	0x4c
	.long	0x457
	.uleb128 0x6
	.ascii "Function\0"
	.byte	0x4
	.byte	0x4d
	.long	0x2f0
	.byte	0
	.uleb128 0x6
	.ascii "Period\0"
	.byte	0x4
	.byte	0x4e
	.long	0x24d
	.byte	0x8
	.uleb128 0x6
	.ascii "TimeElapsed\0"
	.byte	0x4
	.byte	0x4f
	.long	0x457
	.byte	0x10
	.uleb128 0x6
	.ascii "Priority\0"
	.byte	0x4
	.byte	0x50
	.long	0x23a
	.byte	0x18
	.uleb128 0x6
	.ascii "Flags\0"
	.byte	0x4
	.byte	0x51
	.long	0x45c
	.byte	0x1c
	.uleb128 0x6
	.ascii "idptr\0"
	.byte	0x4
	.byte	0x52
	.long	0x332
	.byte	0x20
	.uleb128 0x6
	.ascii "Iterations\0"
	.byte	0x4
	.byte	0x53
	.long	0x461
	.byte	0x28
	.uleb128 0x6
	.ascii "N\0"
	.byte	0x4
	.byte	0x53
	.long	0x461
	.byte	0x2c
	.uleb128 0xb
	.secrel32	.LASF1
	.byte	0x4
	.byte	0x54
	.long	0x111
	.byte	0x30
	.byte	0
	.uleb128 0xe
	.long	0x25e
	.uleb128 0xe
	.long	0x3b0
	.uleb128 0xe
	.long	0x21a
	.uleb128 0x4
	.ascii "qTaskStack_t\0"
	.byte	0x4
	.byte	0x55
	.long	0x3c4
	.uleb128 0x10
	.ascii "TimerInterruptEmulation\0"
	.byte	0x1
	.byte	0xf
	.long	0x111
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x4d2
	.uleb128 0x11
	.ascii "varargin\0"
	.byte	0x1
	.byte	0xf
	.long	0x111
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x12
	.ascii "tick\0"
	.byte	0x1
	.byte	0x10
	.long	0x158
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x13
	.ascii "IdleTask\0"
	.byte	0x1
	.byte	0x17
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x503
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x17
	.long	0x2dc
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "task1\0"
	.byte	0x1
	.byte	0x1b
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x531
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1b
	.long	0x2dc
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "task2\0"
	.byte	0x1
	.byte	0x1f
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x55f
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x1f
	.long	0x2dc
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "task3\0"
	.byte	0x1
	.byte	0x22
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x58d
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x22
	.long	0x2dc
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "task5\0"
	.byte	0x1
	.byte	0x26
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x5bb
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x26
	.long	0x2dc
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x15
	.ascii "task4\0"
	.byte	0x1
	.byte	0x29
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x5e9
	.uleb128 0x14
	.secrel32	.LASF2
	.byte	0x1
	.byte	0x29
	.long	0x2dc
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x10
	.ascii "main\0"
	.byte	0x1
	.byte	0x33
	.long	0xd1
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x636
	.uleb128 0x12
	.ascii "__qTSTACK\0"
	.byte	0x1
	.byte	0x36
	.long	0x646
	.uleb128 0x3
	.byte	0x91
	.sleb128 -304
	.uleb128 0x12
	.ascii "__qQSTACK\0"
	.byte	0x1
	.byte	0x36
	.long	0x65b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -464
	.byte	0
	.uleb128 0x16
	.long	0x466
	.long	0x646
	.uleb128 0x17
	.long	0x124
	.byte	0x4
	.byte	0
	.uleb128 0xe
	.long	0x636
	.uleb128 0x16
	.long	0x33d
	.long	0x65b
	.uleb128 0x17
	.long	0x124
	.byte	0x9
	.byte	0
	.uleb128 0xe
	.long	0x64b
	.uleb128 0x18
	.ascii "qID_task1\0"
	.byte	0x1
	.byte	0x8
	.long	0x338
	.uleb128 0x9
	.byte	0x3
	.quad	qID_task1
	.uleb128 0x18
	.ascii "qID_task2\0"
	.byte	0x1
	.byte	0x9
	.long	0x338
	.uleb128 0x9
	.byte	0x3
	.quad	qID_task2
	.uleb128 0x18
	.ascii "qID_task3\0"
	.byte	0x1
	.byte	0xa
	.long	0x338
	.uleb128 0x9
	.byte	0x3
	.quad	qID_task3
	.uleb128 0x18
	.ascii "qID_task4\0"
	.byte	0x1
	.byte	0xb
	.long	0x338
	.uleb128 0x9
	.byte	0x3
	.quad	qID_task4
	.uleb128 0x18
	.ascii "qID_task5\0"
	.byte	0x1
	.byte	0xc
	.long	0x338
	.uleb128 0x9
	.byte	0x3
	.quad	qID_task5
	.uleb128 0x18
	.ascii "TimerEmulation\0"
	.byte	0x1
	.byte	0xe
	.long	0x1ae
	.uleb128 0x9
	.byte	0x3
	.quad	TimerEmulation
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
	.uleb128 0x6
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
	.uleb128 0x7
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
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
	.uleb128 0x9
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0xa
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
	.uleb128 0xb
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
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
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
	.uleb128 0x16
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x18
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
.LASF1:
	.ascii "TaskData\0"
.LASF2:
	.ascii "event\0"
.LASF0:
	.ascii "UserData\0"
	.ident	"GCC: (GNU) 4.8.3"
	.def	nanosleep;	.scl	2;	.type	32;	.endef
	.def	__qISRHandler;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	__qSendEvent;	.scl	2;	.type	32;	.endef
	.def	__qQueueTaskEvent;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	__qInit;	.scl	2;	.type	32;	.endef
	.def	__qTaskAttach;	.scl	2;	.type	32;	.endef
	.def	__qStartScheduler;	.scl	2;	.type	32;	.endef
