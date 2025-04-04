# Optimuzz

This is an Optimuzz instantiation for LLVM.
Optimuzz performs directed fuzzing on LLVM optimizer passes with Alive2 translation validator.
Our recent development is avaiable at [our website](https://prosys.kaist.ac.kr/optimuzz/).

## Installation

### Quick Start

We provide [Dockerfile](Dockerfile) which installs the system dependencies and configures the environment variables.

```bash
docker build -t . optimuzz
docker run -it optimuzz

# Inside the docker
echo $PWD # /home/user/optimuzz
./build.sh
```

### Environment Variables

* `LLVM_PATH`: The LLVM project directory. We use clang/llvm toolchains and libraries to build Optimuzz, Alive2, and other LLVM versions under test.
* `LLVM_BUILDS`: LLVM versions under test will be installed under this directory.

Note that we use LLVM 20.1.1.

### Build Script

The script `build.sh` installs the followings:
* the required OPAM packages
* LLVM 20 with the OCaml bindings
* Alive2
* Optimuzz toolchain (`fuzzer` and `llmutate`)


## Optimuzz Toolchain

We provide following tools to employ Optimuzz.

```sh
# Build LLVM with our instrumentation pass
$ tools/build.py commit <commit-sha> <target-file> [--fresh]
$LLVM_BUILDS/llvm-builds/<commit-sha>/build/bin/opt

# Harvest seed files from the LLVM project
# `LLVM_PATH` must be set to extract seeds from the unit test suite
$ tools/harvest.py -o <output-dir>

# Ask LLM to select the target line for a code change of the commit
# You must set `OPENAI_API_KEY` to use OpenAI LLM
$ tools/targetline.py <commit-sha>
{
    "target_file": <target-file>,
    "target_line": <target-line>,
}


# Fuzz the LLVM project with the provided seed files, target file, and target line
# It should be able to find `fuzzer` and `llmutate` binary in the PATH
# <run-dir> specifies the working directory of the fuzzer
$ tools/fuzz.py <llvm-dir> <seed-dir> <target-file> <target-line> -r <run-dir>

[*] Found target: <target-file>:<line>
[*] Running fuzzer
...
```