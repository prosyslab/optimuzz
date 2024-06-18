MAKE=@make
DUNE=@dune
LN=@ln -sf
RM=@rm
EXE=llfuzz

.PHONY: clean

all: fmt
	$(DUNE) build
	$(LN) _build/default/src/main.exe $(EXE)
	$(LN) _build/default/src/program/check_corpus.exe check_corpus
	$(LN) _build/default/src/program/cov.exe cov
	$(LN) _build/default/src/program/pattern_check.exe pattern-check
	$(LN) _build/default/src/program/clean.exe clean

test: all
	$(DUNE) test

fmt:
	- $(DUNE) fmt

clean:
	$(DUNE) clean
	$(RM) -rf $(EXE) *.txt
