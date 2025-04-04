#! /usr/bin/env python3

"""
Collect seeds from the LLVM Transforms unit test suite.

Reference: https://github.com/ericliuu/flux/blob/main/scripts/collect_unittest_functions.py
"""

# Collect seeds from the LLVM Transforms unit test suite.

import os
from pathlib import Path
import shutil
import subprocess
import argparse
import datetime
import sys
import logging
from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor, as_completed

NOW = datetime.datetime.now().strftime('%Y-%m-%d')

SKIP_TARGETS = [
    '"target-cpu"="sm',
    '"target-cpu"="cortex',
    '"target-cpu"="v13',
    '"target-cpu"="z13',
    '"target-cpu"="arm7tdmi',
    '"target-cpu"="ppc64',
    '"target-cpu"="gfx908',
    '"target-cpu"="nocona',
    '"target-cpu"="pentium-m',
]

parser = argparse.ArgumentParser(description='Collect seeds from the LLVM Transforms unit test suite.')
parser.add_argument('-i', '--input', type=Path, help='Input file to extract seed functions from.')
parser.add_argument('-o', '--output', type=Path, default=Path(f'seeds-{NOW}'), help='Output directory for the seeds.')
parser.add_argument('-f', '--force', action='store_true', help='Force overwrite of output directory if it exists.')


def get_function_name(line):
    if '(' not in line or '@' not in line:
        return None
    
    # start of identifier
    func_name = line[line.find('@')+1:].strip()
    
    # location to start searching for the start of
    # function arguments
    arg_loc_search = 0
    
    # if the identifier is wrapped in quotes, then
    # make the arg search start location equal to the
    # end of the matching quotations
    if func_name[0] == '"':
        arg_loc_search = func_name.find('"', 1)
        assert(arg_loc_search != -1)

    func_name = func_name.split('(')[0]
    return func_name.strip()

def extract_function_names(content: list[str]):
    function_names = []
    for line in content:
        if 'define' in line and ';' not in line:
            function_name = get_function_name(line)
            if function_name:
                function_names.append(function_name)

    return function_names

if __name__ == '__main__':
    logging.basicConfig(
        format='%(asctime)s %(message)s',
        level=logging.INFO,
        datefmt='%Y-%m-%d %H:%M:%S',
        filename='harvest.log',
        filemode='w',
    )
    args = parser.parse_args()
    LLVM_PATH: Path = Path(os.environ['LLVM_PATH'])
    if not LLVM_PATH.is_dir() or not LLVM_PATH.exists():
        raise ValueError(f'Invalid LLVM path: {LLVM_PATH}')
    print(f'Using LLVM path: {LLVM_PATH}', file=sys.stderr)
    out_dir: Path = args.output
    if out_dir.exists() and len(list(out_dir.iterdir())) > 0:
        if not args.force:
            raise ValueError(f'Output directory {out_dir} already exists and is not empty.')
        else:
            shutil.rmtree(out_dir)
            print(f'Output directory {out_dir} already exists and is not empty. Removing it.', file=sys.stderr)

    out_dir.mkdir(parents=True, exist_ok=True)

    test_files = list((LLVM_PATH / 'llvm' / 'test' / 'Transforms' / 'InstCombine').glob('*.ll')) if not args.input else [args.input]

    def process_test_case(test_file: Path):
        try:
            with open(test_file, 'r') as fname:
                content = fname.readlines()

            # Skip test cases that target specific CPUs
            if any([t in ''.join(content) for t in SKIP_TARGETS]):
                return 0

            functions = extract_function_names(content)
            count = 0

            for fname in functions:
                output_parts = list(test_file.relative_to(LLVM_PATH / "llvm" / "test" / "Transforms").parts[:-1]) + [test_file.stem]
                output_parts.append(f'-{fname}.ll')
                output_name = out_dir / '-'.join(output_parts)
                args = ['llvm-extract', '-S', '-func', fname, test_file, '-o', output_name]
                p = subprocess.run(args, capture_output=True, text=True)
                if p.returncode != 0:
                    logging.error(f"Error: {fname} < {test_file}")
                    logging.error(p.stderr)
                    continue
                count += 1
            return count
        except Exception as e:
            logging.error(f"Exception processing {test_file}: {e}")
            return 0

    with ThreadPoolExecutor() as executor:
        futures = {executor.submit(process_test_case, test_file): test_file for test_file in test_files}
        total_functions = 0
        for future in tqdm(as_completed(futures), desc='extracting seeds', unit='file', total=len(test_files)):
            total_functions += future.result()

    print("Collected", total_functions, "seeds in", out_dir, file=sys.stderr)
    print(total_functions)

