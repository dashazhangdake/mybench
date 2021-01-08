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
	.file	"matmult.c"
	.text
	.comm	first_matrix,16384,4
	.comm	second_matrix,16384,4
	.comm	golden_matrix,16384,4
	.global	ind
	.bss
	.align	2
	.type	ind, %object
	.size	ind, 4
ind:
	.space	4
	.global	seed_value
	.data
	.align	2
	.type	seed_value, %object
	.size	seed_value, 4
seed_value:
	.word	-1
	.text
	.align	1
	.global	init_matrices
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	init_matrices, %function
init_matrices:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}
	sub	sp, sp, #12
	add	r7, sp, #0
	ldr	r4, .L8
.LPIC5:
	add	r4, pc
	movs	r3, #0
	str	r3, [r7]
	movs	r3, #0
	str	r3, [r7, #4]
	ldr	r3, .L8+4
.LPIC0:
	add	r3, pc
	ldr	r3, [r3]
	cmp	r3, #-1
	bne	.L2
	ldr	r3, .L8+8
.LPIC1:
	add	r3, pc
	ldr	r3, [r3]
	mov	r0, r3
	bl	srand(PLT)
	ldr	r3, .L8+12
.LPIC2:
	add	r3, pc
	ldr	r3, [r3]
	mov	r2, r3
	ldr	r3, .L8+16
.LPIC3:
	add	r3, pc
	str	r2, [r3]
	b	.L3
.L2:
	ldr	r3, .L8+20
.LPIC4:
	add	r3, pc
	ldr	r3, [r3]
	mov	r0, r3
	bl	srand(PLT)
.L3:
	movs	r3, #0
	str	r3, [r7]
	b	.L4
.L7:
	movs	r3, #0
	str	r3, [r7, #4]
	b	.L5
.L6:
	bl	rand(PLT)
	ldr	r3, .L8+24
	ldr	r3, [r4, r3]
	mov	r1, r3
	ldr	r3, [r7]
	lsls	r2, r3, #6
	ldr	r3, [r7, #4]
	add	r3, r3, r2
	str	r0, [r1, r3, lsl #2]
	bl	rand(PLT)
	ldr	r3, .L8+28
	ldr	r3, [r4, r3]
	mov	r1, r3
	ldr	r3, [r7]
	lsls	r2, r3, #6
	ldr	r3, [r7, #4]
	add	r3, r3, r2
	str	r0, [r1, r3, lsl #2]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.L5:
	ldr	r3, [r7, #4]
	cmp	r3, #63
	ble	.L6
	ldr	r3, [r7]
	adds	r3, r3, #1
	str	r3, [r7]
.L4:
	ldr	r3, [r7]
	cmp	r3, #63
	ble	.L7
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r4, r7, pc}
.L9:
	.align	2
.L8:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC5+4)
	.word	seed_value-(.LPIC0+4)
	.word	ind-(.LPIC1+4)
	.word	ind-(.LPIC2+4)
	.word	seed_value-(.LPIC3+4)
	.word	seed_value-(.LPIC4+4)
	.word	first_matrix(GOT)
	.word	second_matrix(GOT)
	.size	init_matrices, .-init_matrices
	.align	1
	.global	matrix_multiply
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	matrix_multiply, %function
matrix_multiply:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #36
	add	r7, sp, #0
	str	r0, [r7, #12]
	str	r1, [r7, #8]
	str	r2, [r7, #4]
	movs	r3, #0
	str	r3, [r7, #16]
	movs	r3, #0
	str	r3, [r7, #20]
	movs	r3, #0
	str	r3, [r7, #24]
	movs	r3, #0
	str	r3, [r7, #28]
	movs	r3, #0
	str	r3, [r7, #16]
	b	.L11
.L16:
	movs	r3, #0
	str	r3, [r7, #20]
	b	.L12
.L15:
	movs	r3, #0
	str	r3, [r7, #24]
	b	.L13
.L14:
	ldr	r3, [r7, #16]
	lsls	r3, r3, #8
	ldr	r2, [r7, #12]
	add	r3, r3, r2
	ldr	r2, [r7, #24]
	ldr	r3, [r3, r2, lsl #2]
	ldr	r2, [r7, #24]
	lsls	r2, r2, #8
	ldr	r1, [r7, #8]
	add	r2, r2, r1
	ldr	r1, [r7, #20]
	ldr	r2, [r2, r1, lsl #2]
	mul	r3, r2, r3
	mov	r2, r3
	ldr	r3, [r7, #28]
	add	r3, r3, r2
	str	r3, [r7, #28]
	ldr	r3, [r7, #24]
	adds	r3, r3, #1
	str	r3, [r7, #24]
.L13:
	ldr	r3, [r7, #24]
	cmp	r3, #63
	ble	.L14
	ldr	r3, [r7, #16]
	lsls	r3, r3, #8
	ldr	r2, [r7, #4]
	add	r3, r3, r2
	ldr	r2, [r7, #20]
	ldr	r1, [r7, #28]
	str	r1, [r3, r2, lsl #2]
	movs	r3, #0
	str	r3, [r7, #28]
	ldr	r3, [r7, #20]
	adds	r3, r3, #1
	str	r3, [r7, #20]
.L12:
	ldr	r3, [r7, #20]
	cmp	r3, #63
	ble	.L15
	ldr	r3, [r7, #16]
	adds	r3, r3, #1
	str	r3, [r7, #16]
.L11:
	ldr	r3, [r7, #16]
	cmp	r3, #63
	ble	.L16
	nop
	adds	r7, r7, #36
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	matrix_multiply, .-matrix_multiply
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d     \000"
	.text
	.align	1
	.global	print_matrix
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	print_matrix, %function
print_matrix:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	movs	r3, #0
	str	r3, [r7, #8]
	movs	r3, #0
	str	r3, [r7, #12]
	movs	r3, #0
	str	r3, [r7, #8]
	b	.L18
.L21:
	movs	r3, #0
	str	r3, [r7, #12]
	b	.L19
.L20:
	ldr	r3, [r7, #8]
	lsls	r3, r3, #8
	ldr	r2, [r7]
	add	r3, r3, r2
	ldr	r2, [r7, #12]
	ldr	r3, [r3, r2, lsl #2]
	mov	r1, r3
	ldr	r3, .L22
.LPIC6:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	str	r3, [r7, #12]
.L19:
	ldr	r2, [r7, #12]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	blt	.L20
	ldr	r3, [r7, #8]
	adds	r3, r3, #1
	str	r3, [r7, #8]
.L18:
	ldr	r2, [r7, #8]
	ldr	r3, [r7, #4]
	cmp	r2, r3
	blt	.L21
	nop
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L23:
	.align	2
.L22:
	.word	.LC0-(.LPIC6+4)
	.size	print_matrix, .-print_matrix
	.align	1
	.global	matrix_multiply_test
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	matrix_multiply_test, %function
matrix_multiply_test:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r3, r4, r7, lr}
	add	r7, sp, #0
	ldr	r4, .L25
.LPIC7:
	add	r4, pc
	bl	init_matrices(PLT)
	ldr	r3, .L25+4
	ldr	r3, [r4, r3]
	mov	r2, r3
	ldr	r3, .L25+8
	ldr	r3, [r4, r3]
	mov	r1, r3
	ldr	r3, .L25+12
	ldr	r3, [r4, r3]
	mov	r0, r3
	bl	matrix_multiply(PLT)
	ldr	r3, .L25+4
	ldr	r3, [r4, r3]
	mov	r1, r3
	movs	r0, #64
	bl	print_matrix(PLT)
	nop
	pop	{r3, r4, r7, pc}
.L26:
	.align	2
.L25:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC7+4)
	.word	golden_matrix(GOT)
	.word	second_matrix(GOT)
	.word	first_matrix(GOT)
	.size	matrix_multiply_test, .-matrix_multiply_test
	.section	.rodata
	.align	2
.LC1:
	.ascii	"Side matrix size: %i\015\012\000"
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	movs	r1, #64
	ldr	r3, .L29
.LPIC8:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	bl	matrix_multiply_test(PLT)
	movs	r3, #0
	mov	r0, r3
	pop	{r7, pc}
.L30:
	.align	2
.L29:
	.word	.LC1-(.LPIC8+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0"
	.section	.note.GNU-stack,"",%progbits
