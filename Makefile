EXTRA_CFLAGS =

#CC = gcc

CFLAGS = -std=c11 -g -O2 -Wall $(EXTRA_CFLAGS)
LDFLAGS =
SOURCES = ptr-vs-array.c
OBJS = ptr-vs-array.o
ASMS = ptr-vs-array.s

LIBS =

all: ptr-vs-array ptr-vs-array.s

clean:
	rm -f $(OBJS) $(ASMS) ptr-vs-array ptr-vs-array-asm-test compile_commands.json

ptr-vs-array: $(OBJS)
	$(CC) -o ptr-vs-array $(OBJS) $(CFLAGS) $(LDFLAGS) $(LIBS)

$(ASMS) ptr-vs-array-asm-test: $(SOURCES)
	$(CC) -std=c11 $(SOURCES) -O0 -o ptr-vs-array-asm-test -Wa,-adhln=$(ASMS) -fverbose-asm -fno-stack-protector

inspect: ptr-vs-array-asm-test
	objdump -d "ptr-vs-array-asm-test"
	hexdump -C "ptr-vs-array-asm-test"

# Unecessary to do this, but in case you want to inspect the .o file
$(OBJS): $(SOURCES)

