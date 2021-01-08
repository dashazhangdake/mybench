FILE = prime.c

all: prime

prime: ${FILE} Makefile
	aarch64-linux-gnu-gcc -static -O3 ${FILE} -o prime -lm

clean:
	rm -rf prime output*
