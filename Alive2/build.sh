git submodule update --init llvm-project alive2

mkdir -p llvm-project/build
cd llvm-project/build
cmake -GNinja -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_EH=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_ENABLE_PROJECTS="llvm;clang" ../llvm
ninja

cd ../..
mkdir -p alive2/build
cd alive2/build
cmake -GNinja -DCMAKE_PREFIX_PATH="$(realpath ../../llvm-project/build)" -DBUILD_TV=1 -DCMAKE_BUILD_TYPE=Release "$(realpath ..)"
ninja


