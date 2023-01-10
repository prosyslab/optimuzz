CC=@clang
OPT=@opt
RM=@rm

EXAMPLE_C_FILES = $(shell find . -type f -name '*.c')
EXAMPLE_LL_FILES = $(patsubst %.c, %.ll, $(EXAMPLE_C_FILES))
EXAMPLE_BIN_FILES = $(patsubst %.c, %, $(EXAMPLE_C_FILES))

all: $(EXAMPLE_LL_FILES)

%.ll: %.c
	$(CC) -c -emit-llvm -S -fno-discard-value-names -O0 -Xclang -disable-O0-optnone -o $*.ll $<

clean:
	$(RM) -f $(EXAMPLE_LL_FILES) $(EXAMPLE_BIN_FILES) *.ll
