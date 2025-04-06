#! /usr/bin/env python3

"""
Run alive-tv for the directory of fuzzer-generated LLVM IR files.
"""

import argparse
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import sys
import os
import subprocess as sp
from tqdm import tqdm
import shutil

from threading import Event, Lock

PROJECT_ROOT = Path(__file__).resolve().parent.parent

parser = argparse.ArgumentParser(description='run alive-tv on a directory')
parser.add_argument('out_dir', type=Path, help='output directory of the fuzzer run')

parser.add_argument('--opt-bin', type=Path, help='path to the opt binary', required=True)
parser.add_argument('--passes', type=str, help='passes to run with opt', default='instcombine')

parser.add_argument('--no-undef', action='store_true', help='disable undef inputs')
parser.add_argument('--no-poison', action='store_true', help='disable poison inputs')

parser.add_argument('-j', '--jobs', type=int, help='number of parallel jobs', default=os.cpu_count() // 8)
parser.add_argument('--cont', action='store_true', help='continue TV even if the first miscompilation is found')

# Placeholder removed as args parsing is moved under __main__
def run_opt(d: Path, timeout: str = '2s', passes: str = 'instcombine', save_result: bool = True, cwd: Path = None):
    opt_args = ['timeout', timeout, 'opt', '-S', f'-passes={passes}']
    opt_result = d.with_suffix('.opt.ll') if save_result else Path('/dev/null')
    opt_args.extend(['-o', opt_result.absolute().as_posix(), str(d)])
    opt_p = sp.run(opt_args)
    if opt_p.returncode == 0:
        return opt_result if save_result else None
    return None

def run_tv(before: Path, after: Path, timeout: str = '2m', no_undef: bool = False, no_poison: bool = False):
    tv_args = ['timeout', timeout, 'alive-tv', before.absolute().as_posix(), after.absolute().as_posix()]
    if no_undef:
        tv_args.append('--disable-undef-input')
    if no_poison:
        tv_args.append('--disable-poison-input')
    tv_p = sp.run(tv_args, capture_output=True, text=True)
    if "1 incorrect" in tv_p.stdout:
        return "incorrect"
    return "pass"

def get_sid(file: Path):
    fields = file.stem.split(',')
    sid = fields[1].split(':')[-1]
    return sid

def get_date(file: Path):
    fields = file.stem.split(',')
    date = fields[0].split(':')[-1]
    return date

def unique_sorted_files(files: list[Path]):
    unique_files = {}
    for file in files:
        sid = get_sid(file)
        if sid not in unique_files:
            unique_files[sid] = file
        else:
            unique_files[sid] = min(unique_files[sid], file, key=lambda x: get_date(x))
    
    files = list(unique_files.values())
    files.sort(key=lambda x: get_date(x))
        
    return files

def process_file(target: Path, crash_dir: Path):
    opt_result = run_opt(target)
    if not opt_result:
        return False
    tv_result = run_tv(target, opt_result)
    if tv_result == "incorrect":
       shutil.copy(opt_result, crash_dir / target.name)

    opt_result.unlink(missing_ok=True) # Remove the temporary .opt.ll file

    return tv_result == "pass"


def postmortem(covers_dir: Path, crash_dir: Path, jobs: int, cont: bool = False):
    files = [d.absolute() for d in covers_dir.iterdir() if d.suffix == '.ll' and 'opt.ll' not in d.name]
    files = unique_sorted_files(files)
    print(f"Found {len(files)} files to process", file=sys.stderr)

    stop_event = Event()  # Event to signal stopping
    progress_lock = Lock()  # Lock to safely update the progress bar

    # Initialize tqdm progress bar
    with tqdm(total=len(files), desc="TV", unit="file") as pbar:
        def worker(file: Path):
            if stop_event.is_set():  # Check if stop signal is set
                return
            passed = process_file(file, crash_dir)
            with progress_lock:  # Safely update the progress bar
                pbar.update(1)
            if not passed:  # Miscompilation found
                if not cont:
                    stop_event.set()  # Signal all threads to stop

        # Use ThreadPoolExecutor for parallel processing
        with ThreadPoolExecutor(max_workers=jobs) as executor:
            futures = [executor.submit(worker, file) for file in files]
            for future in futures:
                if stop_event.is_set():
                    break  # Stop waiting for other futures if miscompilation is found
                future.result()  # Wait for the current future to complete

if __name__ == "__main__":
    args = parser.parse_args()

    out_dir: Path = args.out_dir
    assert out_dir.exists() and out_dir.is_dir()

    covers_dir = out_dir / 'covers'
    crash_dir = out_dir / 'crash'

    assert covers_dir.exists() and covers_dir.is_dir()
    crash_dir.mkdir(parents=True, exist_ok=True)

    tv_bin = shutil.which('alive-tv')
    opt_bin = shutil.which(args.opt_bin.resolve(), mode=os.X_OK)

    if not tv_bin:
        print("Error: 'alive-tv' binary not found in the environment.", file=sys.stderr)
        exit(1)

    if not opt_bin:
        print("Error: 'opt' binary not found", file=sys.stderr)
        exit(1)

    print('opt: ', args.opt_bin, file=sys.stderr)
    print('alive-tv: ', tv_bin, file=sys.stderr)

    postmortem(covers_dir, crash_dir, args.jobs, args.cont)

    miscompilations = len(list(crash_dir.iterdir()))
    if miscompilations > 0:
        print(f"Found {miscompilations} miscompilations in {crash_dir.absolute().as_posix()}", file=sys.stderr)
        exit(1)
    else:
        print("No miscompilations found", file=sys.stderr)
        exit(0)