#! /usr/bin/env bash

set -e

COMMIT=$1

if [ -z "$COMMIT" ]; then
    if [ ! -z "$OPENAI_API_KEY" ]; then
        echo "Usage: $0 <commit> [<target_file> <target_line>]"
        echo "Example: $0 abcdef1234 (OPENAI_API_KEY is currently set to use LLM)"
        echo "<target_file> and <target_line> are optional. If not provided, the script will use the LLM to determine them."
        echo "If you want to use a specific target file and line, please provide them as arguments."
    else
        echo "Usage: $0 <commit> <target_file> <target_line>"
        echo "Example: $0 abcdef1234 llvm/lib/Transforms/InstCombine/InstCombineCalls.cpp 1629"
        echo "<target_file> and <target_line> are required as OPENAI_API_KEY is not set."
    fi
    exit 1
fi

if [ -z "$LLVM_BUILDS" ]; then
    echo "Error: LLVM_BUILDS is not set. Please set it before running the script."
    exit 1
fi

if [ -z "$LLVM_PATH" ]; then
    echo "Error: LLVM_PATH is not set. Please set it before running the script."
    exit 1
fi

if [ -z "$SEEDS" ]; then
    echo "Error: SEEDS is not set. Please set it before running the script."
    exit 1
fi

# Check if required toolchain is installed to build LLVM under test
which clang
which clang++
which lld

if [ ! -z "$2" ] && [ ! -z "$3" ]; then
    echo "Using target file and line from command line arguments."
    TARGET_FILE=$2
    TARGET_LINE=$3
else
    echo "Using target file and line from LLM."

    if [ -z "$OPENAI_API_KEY" ]; then
        echo "OPENAI_API_KEY is not set. Please set it before running the script."
        exit 1
    fi

    TARGET=$(tools/targetline.py $COMMIT)
    TARGET_FILE=$(echo "$TARGET" | head -n 1 | cut -d':' -f2)
    TARGET_LINE=$(echo "$TARGET" | tail -n 1 | cut -d':' -f2)
fi

echo "target file: $TARGET_FILE"
echo "target line: $TARGET_LINE"

LLVM_DIR=$(tools/build.py commit $COMMIT $TARGET_FILE)
echo "LLVM_DIR: $LLVM_DIR"

SEEDS=$SEEDS/$COMMIT
mkdir -p $SEEDS
LLVM_PATH=$LLVM_BUILDS/commit/$COMMIT tools/harvest.py -f -o $SEEDS

RUN_DIR=$HOME/optimuzz-runs/$COMMIT/$TARGET_LINE
tools/fuzz.py $LLVM_DIR $SEEDS $TARGET_FILE $TARGET_LINE \
    -r $HOME/optimuzz-runs/$COMMIT/$TARGET_LINE
