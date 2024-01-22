# LLFuzz

## Installation
### Build LLFuzz
```sh
git clone --recurse-submodules git@github.com:prosyslab/llfuzz.git
cd llfuzz
./build.sh
make
```
### Build Alive2
#### Build LLVM for Alive2
```sh
cd Alive2/llvm-project
mkdir build
cd build
cmake -GNinja -DCMAKE_CXX_FLAGS="--coverage" -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_EH=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_ENABLE_PROJECTS="llvm;clang" ../llvm
ninja
```
#### Build Alive2
```sh
cd Alive2/alive2
mkdir build
cd build
cmake -GNinja -DCMAKE_PREFIX_PATH=$(realpath ../../llvm-project/build) -DBUILD_TV=1 -DCMAKE_BUILD_TYPE=Release $(realpath ..)
ninja
```
### Build target LLVM and link `opt`
You have to rename each target LLVMs. (`<label>`)
```sh
mkdir builds
cd builds
git clone git@github.com:llvm/llvm-project.git
cd llvm-project
mkdir build
cd build
cmake -GNinja -DCMAKE_CXX_FLAGS="--coverage" -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_EH=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_ENABLE_PROJECTS="llvm;clang" ../llvm
ninja
cd ../../../
mv builds/llvm-project/ builds/<label>
ln -s builds/<label>/build/bin/opt ./opt
```
