MAKE=@make
DUNE=@dune
LN=@ln -sf
RM=@rm
EXE=fuzzer

.PHONY: clean

all: fmt
	$(DUNE) build
	$(LN) _build/default/src/main.exe $(EXE)
	$(LN) _build/default/src/check_corpus.exe check_corpus
	$(LN) _build/default/src/llmutate.exe llmutate

test: all
	$(DUNE) test

fmt:
	- $(DUNE) fmt

clean:
	$(DUNE) clean
	$(RM) -rf $(EXE) *.txt
