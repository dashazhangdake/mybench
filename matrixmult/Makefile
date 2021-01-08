FILE1 = matmult.c

all: mat_mult

mat_mult: ${FILE1} Makefile
	aarch64-linux-gnu-gcc -static ${FILE1} -O3 -o matrixmult -lm

clean:
	rm -rf matrixmult*
