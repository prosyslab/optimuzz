#! /usr/bin/env python3

"""
Choose the target line for Optimuzz.
This utilizes an LLM to determine the target line, based on the diff in the commit.
"""

import argparse
import os
from pathlib import Path
import sys
import json
import re
import requests

from langgraph.graph import StateGraph
from langchain_openai import ChatOpenAI

parser = argparse.ArgumentParser(description="Choose the target line for Optimuzz.")
parser.add_argument("commit", type=str, help="The commit hash to analyze.")
parser.add_argument('--verbatim', action='store_true', help="Do not parse the JSON output.")


def fetch_commit(commit: str):
    url = f"https://api.github.com/repos/llvm/llvm-project/commits/{commit}"
    resp = requests.get(url, headers={
        "Accept": "application/vnd.github.v3+json",
    })

    data = resp.json()
    commit = data["commit"]
    json.dump(data, open("commit.json", "w"), indent=2)
    print("commit.json", file=sys.stderr)

    msg = data["commit"]["message"]
    files = data["files"]

    for f in files:
        patch = f["patch"]
        set_lineno(patch)
    
    return {
        "commit": commit,
        "message": msg,
        "files": [{
            "filename": f["filename"],
            "status": f["status"],
            "patch": set_lineno(f["patch"]),
            # "url": f["raw_url"],
        } for f in files if Path(f["filename"]).suffix in [".cpp", ".h"]],
    }

def set_lineno(patch: str):
    tagged_lines = []
    new_line_num = None

    for line in patch.splitlines():
        if line.startswith('@@'):
            # Parse hunk header
            # Example: @@ -10,7 +20,8 @@
            hunk = line.split(' ')[2]  # +20,8
            new_line_num = int(hunk[1:].split(',')[0])  # 20
            tagged_lines.append((None, line))  # Keep hunk line untagged
        elif line.startswith('+') and not line.startswith('+++'):
            tagged_lines.append((new_line_num, line))
            new_line_num += 1
        elif line.startswith('-') and not line.startswith('---'):
            tagged_lines.append((None, line))  # Removed line → no line in new file
        else:
            tagged_lines.append((new_line_num, line))  # Context line
            new_line_num += 1

    result = ""

    for lineno, line in tagged_lines:
        # print(f"{lineno if lineno is not None else '---'} | {line}")
        result += f"{lineno if lineno is not None else '---'} | {line}\n"

    return result


def infer_target_line(data: dict):
    assert "OPENAI_API_KEY" in os.environ, "OPENAI_API_KEY is not set"
    llm = ChatOpenAI(model="gpt-4o")

    def ask(state):
        prompt = state["input"]
        return {"output": llm.invoke(prompt).content }

    graph = StateGraph(dict)
    graph.add_node("ask", ask)
    graph.set_entry_point("ask")
    graph.set_finish_point("ask")

    runnable = graph.compile()

    PROMPT = f"""
Your task is to read a code change from a commit and (1) determine the target lines for a directed compiler fuzzer to aim at, and (2) categorize the code change.

First, you determine the target lines.
The source code is from the LLVM project and implements mid-end optimizations in C++, including InstCombine, VectorCombine, GVN, SLPVectorizer, and others.
The directed compiler fuzzer, Optimuzz, generates input programs that satisfy the optimization conditions in the source code to reach the target line and trigger the optimization.
The target line is the line at which the optimization happens after the optimization condition checks and the code transformation is applied.
For example, LLVM InstCombine pass returns a newly created instruction when the optimization is applied,
and the return statement is usually located at the target line.

The code change is typically one of the following three types:
(A) A new optimization is added to the compiler.
```c++
1 Instruction *foldX() {{
2  if (A)
3    return Inst();
4  if (C)
5    ...
6 }}
```
In the example, a new optimization is added with the optimization condition `A`.
In this case, the target line is 3, where the new instruction `Inst()` is created and returned.
This is because we want to generate input programs that test the optimization `Inst()`.
(B) Optimization condition is weakened.
```c++
1  Instruction *foldX() {{
2   if (A)
3 +   if (B)
4       return nullptr;
5   if (C)
6     return Opt1();
7   return nullptr;
8 }}
```
In the example, the optimization condition `B` is added,
then the optimization condition of `Opt1` is weakened since both `A` and `B` are required to be true to prevent the optimization.
In this case, the target line is 6, where the optimization `Opt1` is applied.
(C) Optimization condition is strengthened.
```c++
1  Instruction *foldX() {{
2   if (A)
3 +   if (B)
4       return Opt1();
5   if (C)
6     return Opt2();
7   return nullptr;
8 }}
```
In the example, the optimization condition `B` is added to the optimization `Opt1`.
In this case, the target lines are 4 and 6, where the optimization `Opt1` is applied and the optimization `Opt2` is applied.
Since the optimization condition of `Opt2` is weakend, we also target the line of `Opt2`.

Second, you categorize the code change.
A code change is typically one of the following three types:

1. A new optimization is added to the compiler. Then you should answer `new`. The code change usually follows the pattern of (A) above.
2. An optimization condition is weakened. Then you should answer `weakened`. The code change usually follows the pattern of (B) above.
3. An optimization condition is strengthened. Then you should answer `strengthened`. The code change usually follows the pattern of (C) above.

The commit message is:
{data["message"]}

The code change is as follows:
"""
    
    for f in data["files"]:
        PROMPT += f"""
File: {f["filename"]}
Status: {f["status"]}
Patch:
```
{f["patch"]}
```
"""
        
    PROMPT += f"""Now you should answer the following question:
    
(1) Which target line should Optimuzz aim at? Provide your best suggestion of the target line.
(2) What is the type of the code change? You can answer one of the following four types: `new`, `bug fix`, `weakened`, `removed`.

You answer should follow the JSON format:
```json
{{
    "target_file": "<target_file>",
    "target_line": <target_line>,
    "type": "<type>"
}}
```
"""
    print(PROMPT, file=sys.stderr)

    out = runnable.invoke({
        "input": PROMPT
    })

    return out["output"]


if __name__ == "__main__":
    args = parser.parse_args()
    data = fetch_commit(args.commit)
    answer = infer_target_line(data)
    print(answer, file=sys.stderr)

    # Extract the json part
    json_part = re.search(r'```json\n(.*?)\n```', answer, re.DOTALL)
    if not json_part:
        print("No JSON part found in the answer.")
        sys.exit(1)
    json_part = json_part.group(1).strip()
    d = json.loads(json_part)

    if args.verbatim:
        print(json.dumps(d, indent=2))
        exit(0)

    target_file = d["target_file"]
    target_line = d["target_line"]

    print(f"file:{target_file}")
    print(f"line:{target_line}")
