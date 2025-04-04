#!/bin/bash
set -e

export OPAMYES=1

NCPU="$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)"
OCAML_VERSION="5.3.0"
export OPTIMUZZ_OPAM_SWITCH="optimuzz-$OCAML_VERSION"
opam init --reinit --bare --no-setup

switch_exists=no
for installed_switch in $(opam switch list --short); do
  if [[ "$installed_switch" == "$OPTIMUZZ_OPAM_SWITCH" ]]; then
    switch_exists=yes
    break
  fi
done

if [ "$switch_exists" = "no" ]; then
  opam switch create $OPTIMUZZ_OPAM_SWITCH $OCAML_VERSION
else
  opam switch $OPTIMUZZ_OPAM_SWITCH
fi

eval $(SHELL=bash opam env --switch=$OPTIMUZZ_OPAM_SWITCH)
export OPAMSWITCH=$OPTIMUZZ_OPAM_SWITCH
opam pin https://github.com/prosyslab/logger.git
opam install -j $NCPU dune ctypes ocamlgraph ocamlformat

if [ -z "$LLVM_PATH" ]; then
  echo "LLVM_PATH is not set. Please set it to the path of your LLVM installation."
  exit 1
fi

install_llvm() {
  git clone https://github.com/llvm/llvm-project.git $LLVM_PATH
  pushd $LLVM_PATH
  git checkout llvmorg-20.1.1
  mkdir -p build
  pushd build
  # Alive2 requires ASSERTIONS to be enabled
  cmake -G Ninja ../llvm \
      -DLLVM_ENABLE_PROJECTS="llvm;lld;clang" \
      -DLLVM_ENABLE_BINDINGS=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_ENABLE_RTTI=ON \
      -DLLVM_ENABLE_ASSERTIONS=ON \
      -DLLVM_ENABLE_SPHINX=OFF \
      -DLLVM_ENABLE_DOXYGEN=OFF \
      -DLLVM_ENABLE_OCAMLDOC=OFF \
      -DLLVM_TARGETS_TO_BUILD="X86" \
      -DLLVM_OCAML_INSTALL_PATH="$(opam var lib)"
  ninja

  # This installs LLVM-20 bindings to the current opam switch
  sudo ninja install
  popd
  popd
}


install_alive2() {
  git submodule update --init --remote alive2
  pushd alive2
  git checkout v20.0

  rm -rf build
  mkdir -p build

  pushd build
  cmake -GNinja -DCMAKE_PREFIX_PATH="$LLVM_PATH" -DBUILD_TV=1 -DCMAKE_BUILD_TYPE=Release ..
  ninja
  sudo ninja install
  popd
  popd
}


echo "LLVM_PATH: $LLVM_PATH"

if [ ! -x "$LLVM_PATH/build/bin/opt" ]; then
  echo "No LLVM is found built. Installing LLVM..."
  install_llvm
else
  echo "Built LLVM found. Skipping LLVM build."
  pushd $LLVM_PATH/build
  sudo ninja install
  popd
fi

install_alive2

make
