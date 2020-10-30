FILE1 = matmult_b.c

all: mat_multb

mat_multb: ${FILE1} Makefile
	arm-linux-gnueabihf-gcc -static ${FILE1} -O3 -o matrixmultb -lm

clean:
	rm -rf matrixmult_block*