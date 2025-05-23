# Optimuzz

<p align="center">
    <img src="optimuzz-white-bg.png" alt="Optimuzz" width="35%" >
</p>

This is an Optimuzz instantiation for LLVM.
Optimuzz performs directed fuzzing on LLVM optimizer passes with Alive2 translation validator.
Our recent development is available at [our website](https://prosys.kaist.ac.kr/optimuzz/).

We also provide an Optimuzz instantiation with TurboTV for the past bugs of TurboFan.

## Installation

### Quick Start

We provide [Dockerfile](Dockerfile) which installs the system dependencies and configures the environment variables.

```bash
docker build -t . optimuzz
docker run -it optimuzz

# Inside the docker
echo $PWD # /home/user/optimuzz
./build.sh
eval $(opam env) # Optimuzz toolchains are installed under the current opam switch
```

### Environment Variables

- `LLVM_PATH`: The LLVM project directory. We use clang/llvm toolchains and libraries to build Optimuzz, Alive2, and other LLVM versions under test.
- `LLVM_BUILDS`: LLVM versions under test will be installed under this directory.

Note that we use LLVM 20.1.1.

### Build Script

The script `build.sh` installs the followings:

- the required OPAM packages
- LLVM 20 with the OCaml bindings
- Alive2
- Optimuzz toolchain (`fuzzer` and `llmutate`)

## Optimuzz Toolchain

We provide following tools to employ Optimuzz.

* `tools/build.py`: instruments and builds LLVM with a target file
* `tools/harvest.py` collects unit test cases as seeds from LLVM of the targeted commit
* `tools/targetline.py` asks an LLM to infer the target location from an LLVM commit
* `tools/fuzz.py` runs our fuzzer.

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

In addition, `scripts/repro-turbofan.sh 1195650` performs the reproduction experiment for the TurboFan Bug 1195650.
You can change the number to one of `1195650 1198705 1199345 1200490 1234764 1234770`.
The reproduction detail appears in our paper.
