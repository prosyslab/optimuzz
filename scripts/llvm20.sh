#!/usr/bin/env bash

# Build LLVM 20 and install the OCaml bindings into the current opam switch

export OPAMYES=1

set -e

echo $LLVM_PATH
opam switch
eval $(opam env)

opam install ctypes

if [ -z "$LLVM_PATH" ]; then
  echo "LLVM_PATH is not set. Please set it to the path of your LLVM installation."
  exit 1
fi

pushd $LLVM_PATH
git checkout llvmorg-20.1.1
mkdir -p build
pushd build
# Alive2 requires ASSERTIONS to be enabled
cmake -G Ninja ../llvm \
    -DLLVM_ENABLE_PROJECTS="llvm;clang" \
    -DLLVM_ENABLE_BINDINGS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_ENABLE_SPHINX=OFF \
    -DLLVM_ENABLE_DOXYGEN=OFF \
    -DLLVM_ENABLE_OCAMLDOC=OFF \
    -DLLVM_OCAML_INSTALL_PATH="$(opam var lib)"
ninja
sudo ninja install
popd
popd

