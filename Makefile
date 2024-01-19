MAKE=@make
DUNE=@dune
LN=@ln -sf
RM=@rm
EXE=llfuzz

all:
	$(DUNE) build src/main.exe
	$(DUNE) build test/mutator/test.exe
	$(LN) _build/default/src/main.exe $(EXE)

test: all
	$(DUNE) test

clean:
	$(DUNE) clean
	$(RM) -rf $(EXE) *.txt
