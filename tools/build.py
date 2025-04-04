#! /usr/bin/env python3

"""
Build the LLVM project which is pinned to a specific commit.
You can opt in to instrument them with our custom instrumentation pass.
"""

import argparse
import json
from pathlib import Path
import shutil
import sys
import os
import subprocess as sp

OPTIMUZZ_ROOT = Path(__file__).parent.parent

parser = argparse.ArgumentParser(description='build LLVM project of a specific commit')
parser.add_argument('--skip-cmake', action='store_true', help='skip the cmake step', default=False)
parser.add_argument('--inst', type=Path, help='instrument the project with our custom pass', default=OPTIMUZZ_ROOT / 'instrumentation')

subparsers = parser.add_subparsers(dest='build_llvm_opt', help='build for target bug')

target_parser = subparsers.add_parser("target", help='build for a specific target bug')
target_parser.add_argument('issue_id', type=str, help='LLVM issue id to build')

commit_parser = subparsers.add_parser("commit", help='build for a specific commit')
commit_parser.add_argument('commit', type=str, help='LLVM commit hash to build')
commit_parser.add_argument('target_file', type=str, help='target file to run against')
commit_parser.add_argument('--fresh', action='store_true', help='enforce a clean build', default=False)

def build_opt(commit: str, target_file: str, target_path: Path,
              inst: Path,
              fresh: bool = True, skip_cmake: bool = False, shallow: bool = False):
    """
    Download the LLVM project from the official repository, if we do not have it locally.
    """

    if not os.environ.get('LLVM_PATH'):
        raise ValueError('LLVM_PATH environment variable is not set. Please set it to the path of the LLVM project.')
    
    LLVM_PATH = Path(os.environ['LLVM_PATH'])

    if not LLVM_PATH.exists():
        raise FileNotFoundError(f"LLVM_PATH {LLVM_PATH} does not exist. Please download the LLVM project first.")

    if not target_path.exists():
        print(f"[*] Copy from local LLVM repo to {target_path} and reset to {commit}", file=sys.stderr)
        target_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(LLVM_PATH, target_path, ignore=shutil.ignore_patterns('build'))
        if (target_path / 'build').exists():
            shutil.rmtree(target_path / 'build')

        sp.run(['git', 'restore', '.'], cwd=target_path, check=True)
        if shallow:
            sp.run(['git', 'fetch', '--depth=1', 'origin', commit], cwd=target_path, check=True)
        else:
            sp.run(['git', 'fetch', 'origin', commit], cwd=target_path, check=True)
        sp.run(['git', 'checkout', commit], cwd=target_path, check=True)

    # Now, we have a copy of LLVM project at the specified commit

    build_path = target_path / 'build'
    if fresh:
        if build_path.exists():
            sp.run(f"rm -rf {build_path}", shell=True)
        if (target_path / '.git').exists() and (target_path / '.git').is_dir():
            sp.run('git restore .', cwd=target_path, shell=True)
    
    if (build_path / 'bin' / 'opt').exists():
        print(f"[*] {build_path / 'bin' / 'opt'} already exists. skip building...", file=sys.stderr)
        return target_path

    build_path.mkdir(parents=True, exist_ok=True)

    pass_so = inst / 'inst-pass.so'
    callback_o = inst / 'coverage.o'
    inst_flags = [
        f'{callback_o.absolute()}',
        f'-Xclang -fpass-plugin={pass_so}'
    ]

    if not pass_so.exists() or not callback_o.exists():
        raise FileNotFoundError(f"LLVM instrumentation pass not found at {pass_so} or {callback_o}. Please build the instrumentation pass first.")

    cmake_cmd = [
        'cmake', '-GNinja',
        '-DCMAKE_C_COMPILER=clang', '-DCMAKE_CXX_COMPILER=clang++',
        f'-DCMAKE_CXX_FLAGS={" ".join(inst_flags)}',
        '-DLLVM_USE_LINKER=lld',
        '-DLLVM_ENABLE_RTTI=ON',
        '-DLLVM_ENABLE_EH=ON',
        '-DLLVM_ENABLE_PIC=OFF',
        '-DLLVM_ENABLE_BINDINGS=OFF',
        '-DLLVM_BUILD_RUNTIME=Off',
        '-DCMAKE_BUILD_TYPE=Debug',
        '-DLLVM_ENABLE_ASSERTIONS=ON',
        '-DLLVM_ENABLE_PROJECTS=llvm', '../llvm'
    ]

    build_env = dict(os.environ.copy(),
        TARGET_FILE=target_file,
        OUT_DIR='cfg',
        VERBOSE='1')

    if not skip_cmake:
        print('[*] Issuing CMake command', file=sys.stderr)
        print(f'Log: {build_path / "cmake.log"}', file=sys.stderr)
        print(f'Error: {build_path / "cmake.err"}', file=sys.stderr)
        with open(build_path / 'cmake.log', 'w') as log, open(build_path / 'cmake.err', 'w') as err:
            sp.run(cmake_cmd, cwd=build_path, stdout=log, stderr=err, env=build_env, check=True)

    print('[*] Building LLVM project at ', build_path, file=sys.stderr)
    print(f'Log: {build_path / "ninja.log"}', file=sys.stderr)
    print(f'Error: {build_path / "ninja.err"}', file=sys.stderr)
    with open(build_path / 'ninja.log', 'w') as log, open(build_path / 'ninja.err', 'w') as err:
        sp.run(['ninja', 'opt'], cwd=build_path, stdout=log, stderr=err, env=build_env, check=True)
    
    return target_path


if __name__ == '__main__':
    args = parser.parse_args()
    if args.build_llvm_opt == "target":
        print(f"target issue: {args.issue_id}", file=sys.stderr)
        issues_db = json.load((OPTIMUZZ_ROOT / 'cases' / 'llvm' / 'issues.json').open())
        issue = issues_db[args.issue_id]
        commit = issue['commit'] + "~1"
        target_file = issue['target_file']
        print(f"target commit: {commit}\ntarget file: {target_file}", file=sys.stderr)
        build_path = Path(os.environ['LLVM_BUILDS']) / "issues" / args.issue_id
        opt_path = build_opt(commit, target_file, build_path, args.inst, fresh=True, skip_cmake=args.skip_cmake, shallow=False)
        print(opt_path)
        exit(0)
    if args.build_llvm_opt == "commit":
        print(f"target commit: {args.commit}", file=sys.stderr)
        print(f"target file: {args.target_file}", file=sys.stderr)
        build_path = Path(os.environ['LLVM_BUILDS']) / "commit" / args.commit
        opt_path = build_opt(args.commit, args.target_file, build_path, args.inst, fresh=args.fresh, skip_cmake=args.skip_cmake, shallow=True)
        print(opt_path)
        exit(0)

    parser.print_help()
    exit(1)
