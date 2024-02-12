MAKE=@make
DUNE=@dune
LN=@ln -sf
RM=@rm
EXE=llfuzz

all: fmt
	$(DUNE) build src/main.exe
	$(DUNE) build src/program/check_corpus.exe
	$(DUNE) build test/coverage/test.exe
	$(DUNE) build test/mutator/test.exe
	$(LN) _build/default/src/main.exe $(EXE)
	$(LN) _build/default/src/program/check_corpus.exe check_corpus

test: all
	$(DUNE) test

fmt:
	- $(DUNE) fmt

clean:
	$(DUNE) clean
	$(RM) -rf $(EXE) *.txt
