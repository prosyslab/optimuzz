#!/usr/bin/env python3

import argparse
from pathlib import Path
import subprocess
import os
from tqdm import tqdm

ROOT = Path(__file__).parent.parent

def reproduce(issue_id: str, d8_build_path: Path):
    if issue_id == "1234764" or issue_id == "1234770":
        profile = ROOT / "turbotv-fuzzilli" / "Sources" / "FuzzilliCli" / "Profiles" / f"V8Profile-1234764-1234770.swift.bak"
    else:
        profile = ROOT / "turbotv-fuzzilli" / "Sources" / "FuzzilliCli" / "Profiles" / f"V8Profile-{issue_id}.swift.bak"

    # subprocess.run(f"cp profile /home/user/optimuzz-experiment/fuzzilli/Sources/FuzzilliCli/Profiles/V8Profile.swift", shell=True, cwd="fuzzilli")
    subprocess.run(["cp", profile, ROOT / "turbotv-fuzzilli" / "Sources" / "FuzzilliCli" / "Profiles" / "V8Profile.swift"])
    subprocess.run(["swift", "build", "-c", "release"], cwd=ROOT / 'turbotv-fuzzilli')
    fuzz_out_dir = ROOT / "archive"/ "repros" / issue_id


    (ROOT / "turbotv-fuzzilli" / "temp").mkdir(parents=True, exist_ok=True)

    env = os.environ.copy()
    env["COV_PATH"] = "."
    env["DISTMAP_FILE"] = (Path(d8_build_path) / "distmap.txt").as_posix()
    subprocess.run(["timeout", "6h",
                    ".build/release/FuzzilliCli",
                    "--profile=v8", "--timeout=500",
                    "--storagePath=" + str(fuzz_out_dir),
                    d8_build_path / "d8", "--overwrite"],
        cwd="turbotv-fuzzilli", env=env)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fuzzilli Reproduce")
    parser.add_argument("issue_id", type=str, help="Issue ID to reproduce")
    parser.add_argument("d8_build_path", type=Path, help="d8 path")
    args = parser.parse_args()

    issue_id = args.issue_id
    reproduce(issue_id, args.d8_build_path)