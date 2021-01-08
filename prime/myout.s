	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"prime.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\012\000"
	.global	__aeabi_idivmod
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	movs	r3, #2
	str	r3, [r7]
	b	.L2
.L8:
	movs	r3, #2
	str	r3, [r7, #4]
	b	.L3
.L7:
	ldr	r2, [r7]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	bne	.L4
	ldr	r1, [r7]
	ldr	r3, .L11
.LPIC0:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	b	.L5
.L4:
	ldr	r3, [r7]
	ldr	r1, [r7, #4]
	mov	r0, r3
	bl	__aeabi_idivmod(PLT)
	mov	r3, r1
	cmp	r3, #0
	beq	.L10
.L5:
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.L3:
	ldr	r2, [r7, #4]
	ldr	r3, [r7]
	cmp	r2, r3
	ble	.L7
	b	.L6
.L10:
	nop
.L6:
	ldr	r3, [r7]
	adds	r3, r3, #1
	str	r3, [r7]
.L2:
	ldr	r3, [r7]
	cmp	r3, #19
	ble	.L8
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L12:
	.align	2
.L11:
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0"
	.section	.note.GNU-stack,"",%progbits
