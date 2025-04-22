#!/usr/bin/env python3

import sys

toolchain = sys.argv[1]
target_rule = sys.argv[2]
prepends = sys.argv[3]
appends = sys.argv[4]

# print(toolchain, target_rule, prepends, appends)

command_line = None

with open(toolchain, 'r') as f:
    lines = f.readlines()
    for i, l in enumerate(lines):
        if l.strip() == f"rule {target_rule}":
            command_line = lines[i + 1].strip()
            break


if command_line is None:
    sys.stderr.write("target rule not found")
    exit(1)

command_line = '  command =  ' + prepends + ' ' + command_line.lstrip('command =').strip() + ' ' + appends + '\n'
lines[i + 1] = command_line

with open(toolchain, 'w') as f:
    f.write(''.join(lines))
