MAKE=@make
DUNE=@dune
LN=@ln -sf
RM=@rm
EXE=llfuzz

all:
	- $(DUNE) build @fmt --auto-promote src/main.exe
	$(LN) _build/default/src/main.exe $(EXE)

test: all
	$(DUNE) test

fmt:
	- $(DUNE) fmt

clean:
	$(DUNE) clean
	$(RM) -rf $(EXE) *.txt
