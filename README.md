# LLFuzz

## Installation
#### Build LLFuzz
```
git clone --recurse-submodules git@github.com:prosyslab/llfuzz.git
cd llfuzz
./build.sh
make
```
#### Build LLVM
```
cd llvm-project
mkdir build
cd build
cmake -GNinja -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_EH=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_ENABLE_PROJECTS="llvm;clang" ../llvm
ninja
```
#### Build Alive2
```
cd alive2
mkdir build
cd build
cmake -GNinja -DCMAKE_PREFIX_PATH=../llvm-project/build -DBUILD_TV=1 -DCMAKE_BUILD_TYPE=Release ..
ninja
```
