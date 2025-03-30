#! /usr/bin/env bash

set -e

echo "LLVM_PATH: $LLVM_PATH"

git submodule update --init --remote alive2

pushd alive2
git checkout v20.0

rm -rf build
mkdir -p build

pushd build
cmake -GNinja -DCMAKE_PREFIX_PATH="$LLVM_PATH" -DBUILD_TV=1 -DCMAKE_BUILD_TYPE=Release ..
ninja
popd
popd
