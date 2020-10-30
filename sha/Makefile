# By default, the code is compiled for a "big endian" machine.
# To compile on a "little endian" machine set the LITTLE_ENDIAN flag.
# To make smaller object code, but run a little slower, don't use UNROLL_LOOPS.
# To use NIST's modified SHA of 7/11/94, define USE_MODIFIED_SHA

CC = gcc
CFLAGS = -static -O3 -g

OBJ = sha_driver.o sha.o
sha: ${OBJ} Makefile
	aarch64-linux-gnu-gcc ${CFLAGS} ${OBJ} -o sha -lm
sha_driver.o: sha_driver.c
	aarch64-linux-gnu-gcc ${CFLAGS} -c sha_driver.c
sha.o: sha.c
	aarch64-linux-gnu-gcc ${CFLAGS} -c sha.c

clean:
	rm -rf *.o sha output*
