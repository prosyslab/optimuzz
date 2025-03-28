#! /usr/bin/env bash

set -e

git submodule update --init --remote llvm-project alive2

pushd llvm-project
git checkout llvmorg-20.1.1
popd

pushd alive2
git checkout v20.0
popd

rm -rf llvm-project/build
mkdir -p llvm-project/build
pushd llvm-project/build
cmake -GNinja -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_EH=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_ENABLE_PROJECTS="llvm;clang" ../llvm
ninja
popd

rm -rf alive2/build
mkdir -p alive2/build
pushd alive2/build
cmake -GNinja -DCMAKE_PREFIX_PATH="$(realpath ../../llvm-project/build)" -DBUILD_TV=1 -DCMAKE_BUILD_TYPE=Release "$(realpath ..)"
ninja
popd
