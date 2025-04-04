CXX = clang++
LLVM_CONFIG ?= llvm-config
CXXFLAGS = $(shell $(LLVM_CONFIG) --cxxflags) -std=c++17 -fno-rtti -fPIC
LDFLAGS  = $(shell $(LLVM_CONFIG) --ldflags)
PLUGIN_FLAGS = -Xclang -fpass-plugin=./inst-pass.so
DISTANCE = $(HOME)/llfuzz-experiment/optimuzz/_build/default/src/program/distance.exe

.PHONY: all
all: inst-pass.so coverage.o

inst-pass.so: InstPass.cpp
	$(CXX) -g -shared -o $@ $^ $(CXXFLAGS) $(LLVM_LDFLAGS)

coverage.o: coverage.cpp
	$(CXX) -fPIC -c $< -o $@

test: inst-pass.so targets.txt test.cpp coverage.o
	- rm -r out-ours
	OUT_DIR=./out-ours TARGET_FILE=test.cpp VERBOSE=1 $(CXX) -o $@ test.cpp coverage.o $(PLUGIN_FLAGS) -g -O0 -S -emit-llvm
	cp targets.txt out-ours/target-blocks.txt
	$(DISTANCE) targets.txt out-ours

clean:
	rm -f inst-pass.so test coverage.o

.PHONY: test clean