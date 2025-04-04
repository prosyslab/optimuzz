MAKE=@make
DUNE=@dune
LN=@ln -sf
RM=@rm
EXE=fuzzer

.PHONY: clean

all:
	$(DUNE) build -p optimuzz
	dune install

test: all
	$(DUNE) test

clean:
	$(DUNE) clean
	$(RM) -rf $(EXE) *.txt
