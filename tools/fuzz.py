#!/usr/bin/env python3

"""
Run optimuzz against an LLVM project.
The LLVM project directory must be checked out at the commit under test.
The LLVM project must have `build` directory with `opt` in it.
"""

import argparse
from pathlib import Path
import sys
import os
import shutil
import subprocess as sp


parser = argparse.ArgumentParser(description="Continuously fuzz-test a commit")
parser.add_argument('llvm_dir', type=Path, help="the LLVM source directory")
parser.add_argument('seed_dir', type=Path, help="the seed directory")
parser.add_argument('target_file', type=Path, help="the target file")
parser.add_argument('target_line', type=int, help="the target line")
parser.add_argument('-r', '--run-dir', type=Path, help="the fuzzing context directory", required=True)
parser.add_argument('--timeout', type=str, default='90m', help="timeout for the continuous test")
parser.add_argument('--passes', type=str, default='instcombine', help="the optimization passes to apply")
parser.add_argument('--mtriple', type=str, help="the target triple for the continuous test")

def test(llvm_dir: Path, seed_dir: Path, target_file: str, target_line: int, run_dir: Path,
         timeout: str, passes: str, mtriple: str):
    if isinstance(target_file, Path):
        target_file = str(target_file)
    
    if not (llvm_dir / 'build' / 'bin' / 'opt').exists():
        print(f"[*] opt not found at {llvm_dir / 'build' / 'bin' / 'opt'}", file=sys.stderr)
        raise FileNotFoundError(f"opt not found at {llvm_dir / 'build' / 'bin' / 'opt'}")

    run_dir.mkdir(parents=True, exist_ok=False)

    build_dir = llvm_dir / 'build'
    opt_bin = build_dir / 'bin' / 'opt'

    sp.run(["ln", "-sf", opt_bin, run_dir / 'opt'], check=True)

    target_blocks_map = (build_dir / 'cfg' / 'target-blocks-map.txt').read_text().strip().split('\n')
    targets = set()
    for line in target_blocks_map:
        target, blocks = line.split(' ')
        blockfile, blockline = blocks.split(':')
        if target_file in blockfile and target_line == int(blockline):
            targets.add(target)
    
    if not targets:
        raise ValueError(f"no target found for {target_file}:{target_line}")

    for t in targets:
        print(f"[*] Found target: {t}", file=sys.stderr)

    (run_dir / 'llfuzz-out').mkdir(exist_ok=True, parents=True)
    target_blocks_file = run_dir / 'llfuzz-out' / 'target-blocks.txt'

    with open(target_blocks_file, 'w') as f:
        for t in targets:
            f.write(t + '\n')
    
    print(target_blocks_file, file=sys.stderr)
    assert (target_blocks_file).exists()

    out_dir = 'llfuzz-out'
    fuzzer_args = [
        'timeout', timeout,
        'fuzzer',
        '-seed-dir', seed_dir.absolute(),
        '-opt-bin', './opt',
        '-out-dir', out_dir,
        '-targets', target_blocks_file,
        '-cfg-dir', str(build_dir / 'cfg'),
        '-log-level', 'debug',
        '-no-tv',
    ]

    if passes:
        fuzzer_args += ['-passes', passes]
    if mtriple:
        fuzzer_args += ['-mtriple', mtriple]

    with open(run_dir / out_dir / 'fuzzer.out', 'w') as out_f, open(run_dir / out_dir / 'fuzzer.err', 'w') as err_f:
        print("[*] Running fuzzer", file=sys.stderr)
        print(f"[*] Fuzzer args: {' '.join(map(str, fuzzer_args))}", file=sys.stderr)
        print(f"[*] Fuzzer cwd: {run_dir}", file=sys.stderr)
        print(f"[*] Fuzzer timeout: {timeout}", file=sys.stderr)
        print(f"[*] Fuzzer stdout: {run_dir / 'fuzzer.out'}", file=sys.stderr)
        print(f"[*] Fuzzer stderr: {run_dir / 'fuzzer.err'}", file=sys.stderr)
        sp.run(fuzzer_args, cwd=run_dir, stdout=out_f, stderr=err_f)

    print("[*] Fuzzer finished", file=sys.stderr)

if __name__ == '__main__':
    # Check if the required tools can be found
    tools = ['fuzzer', 'llmutate']
    not_found = list(filter(lambda x: shutil.which(x) is None, tools))

    # Check if required environment variables are set
    variables = []
    missing_vars = list(filter(lambda x: os.environ.get(x) is None, variables))

    if not_found:
        print(f"Tools not found in PATH: {', '.join(not_found)}", file=sys.stderr)
        print("Please install the required tools and add them to your PATH.", file=sys.stderr)

    if missing_vars:
        print(f"Environment variables not set: {', '.join(missing_vars)}", file=sys.stderr)
        print("Please set the required environment variables.", file=sys.stderr)
    
    if not_found or missing_vars:
        exit(1)

    args = parser.parse_args()

    test(args.llvm_dir, args.seed_dir, args.target_file, args.target_line, args.run_dir,
         args.timeout, args.passes, args.mtriple)