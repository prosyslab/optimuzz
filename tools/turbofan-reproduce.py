import argparse
from pathlib import Path
import subprocess
import os
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

ROOT = Path(__file__).parent.parent
# TURBO_TV_EXP_ROOT = Path(__file__).parent.parent.parent

def run_cmd(cmd: str, **args):
    print(f"==> Run: \"{cmd}\"", end=" ")
    try:
        subprocess.run(cmd, **args)
        print("\033[92mO\033[0m")
    except subprocess.CalledProcessError as e:
        print("\033[91mX\033[0m")
        print(f"Error: {e}")
        print(f"Output: {e.output}")

class Monitor(FileSystemEventHandler):
    def on_created(self, event):
        if event.src_path.endswith(".js"):
            js_path = Path(event.src_path)
            fuzzer.check_js(js_path)


class Fuzzer:
    def __init__(self):
        self._fuzz_out_dir = None
        self._js_dir = None
        self._fuzz_d8_p = None
        self._tv_d8_p = None
        self._bug_dir = None
        self._time_budget = 10
        self._cnt = 0
        self._bug_idx = 0

    def init(self):
        run_cmd("swift build -c release", shell=True, cwd=ROOT / 'turbotv-fuzzilli')

    def _register_js_event_handler(self):
        observer = Observer()
        observer.schedule(Monitor(), self._js_dir, recursive=True)
        observer.start()
        return observer

    def _run_fuzzilli_reproduce(self):
        env = os.environ.copy()
        env["COV_PATH"] = "."
        env["DISTMAP_FILE"] = "../distmap.txt"
        cmd = f"timeout 6h .build/release/FuzzilliCli --profile=v8 --timeout=500 --storagePath={self._fuzz_out_dir} {self._fuzz_d8_p} --overwrite"
        subprocess.run(cmd, shell=True, cwd="fuzzilli", env=env)



    def reproduce(self, fuzz_out_dir: Path, issue_id: str):
        self._js_dir = fuzz_out_dir / "covers"
        self._fuzz_d8_p = d8.get_d8_path(issue_id)
        self._fuzz_out_dir = fuzz_out_dir

        self._fuzz_out_dir.mkdir(exist_ok=True, parents=True)
        self.init()
        self._run_fuzzilli_reproduce()


    def _run_fuzzilli(self):
        env = os.environ.copy()
        env["COV_PATH"] = "."
        env["DISTMAP_FILE"] = "target.dist"
        cmd = f"timeout 6h .build/release/FuzzilliCli --profile=v8 --timeout=500 --storagePath={self._fuzz_out_dir} {self._fuzz_d8_p} --overwrite"
        subprocess.run(cmd, shell=True, cwd="fuzzilli", env=env)

    def _run_js(self, js_path: Path, param1: str, param2: str):
        target_code = """let jit_a0 = opt(1, 0);
opt(1, 0);
let jit_a0_0 = opt(1, 0);
%PrepareFunctionForOptimization(opt);
let temp = opt(1, 0);
let jit_a0_1 = opt(1, 0);
%OptimizeFunctionOnNextCall(opt)
let temp2 = opt(1, 0);
let jit_a2 = opt(1, 0);
console.log(jit_a0);
console.log(jit_a2);"""
        modified_code = f"""let jit_a0 = opt({param1}, {param2});
opt(1, 0);
let jit_a0_0 = opt({param1}, {param2});
%PrepareFunctionForOptimization(opt);
let temp = opt(1, 0);
let jit_a0_1 = opt({param1}, {param2});
%OptimizeFunctionOnNextCall(opt)
let temp2 = opt(1, 0);
let jit_a2 = opt({param1}, {param2});
console.log(jit_a0);
console.log(jit_a2);"""

        js_path.write_text(js_path.read_text().replace(target_code, modified_code))

        try:
            output = subprocess.check_output(
                f"{self._fuzz_d8_p} --allow-natives-syntax {js_path} --trace-deopt", timeout=10, shell=True
            )
            print(f"No Error {js_path}")
            return False
        except subprocess.CalledProcessError as e:
            print(f"Error in _run_js: {e}")
            return False
        except subprocess.TimeoutExpired:
            return False
        except Exception as e:
            print(e)
            return True

    def check_js(self, js_path: Path):
        d8.emit_reductions(js_path)
        reductions = list(filter(lambda p: p.is_dir(), workbench.js_dir_of(js_path.stem).glob("*")))

        for reduction in reductions:
            ir_1 = reduction / "src.ir"
            ir_2 = reduction / "tgt.ir"

            if b"Loop" in ir_1.read_bytes() or b"Loop" in ir_2.read_bytes():
                print(f"finish {workbench.js_dir_of(js_path.stem)}")
                subprocess.run(["rm", "-rf", str(workbench.js_dir_of(js_path.stem))])
                return CheckResult.NOT_TARGET, None

            try:
                output = subprocess.check_output(
                    f"turbo-tv/turbo-tv --verify {ir_1},{ir_2}", shell=True, timeout=self._time_budget
                )

                if b"Result: Not Verified" in output:
                    param1, param2 = self._extract_parameters(output)
                    if self._run_js(js_path, param1, param2):
                        self._bug_idx += 1
                        outdir = self._bug_dir / str(self._bug_idx)
                        outdir.mkdir()
                        (outdir / "poc.js").write_bytes(js_path.read_bytes())
                        (outdir / "src.ir").write_bytes(ir_1.read_bytes())
                        (outdir / "tgt.ir").write_bytes(ir_2.read_bytes())
                        (outdir / "model").write_bytes(output)
                elif b"Result: Verified" in output:
                    print("Verified", js_path)
            except subprocess.TimeoutExpired:
                subprocess.run(["rm", "-rf", str(workbench.js_dir_of(js_path.stem))])
                return CheckResult.TIMEOUT, None, self._time_budget
            except subprocess.CalledProcessError:
                subprocess.run(["rm", "-rf", str(workbench.js_dir_of(js_path.stem))])
                return CheckResult.RUNTIME_ERROR, None, 0.0

        subprocess.run(["rm", "-rf", str(workbench.js_dir_of(js_path.stem))])

    def _extract_parameters(self, output: bytes):
        param1_start = output.find(b"Parameter[0]:")
        param1 = output[param1_start + len(b"Parameter[0]:"):output.find(b'\n', param1_start)]

        if b"TaggedSigned" in param1:
            param1 = param1[param1.find(b"(")+1:param1.find(b")")]
        elif b"HeapConstant" in param1:
            start = param1.find(b"HeapConstant")
            param1 = param1[param1.find(b"(", start)+1:param1.find(b")", start)].lower()
        elif b"HeapNumber" in param1:
            start = param1.find(b"HeapNumber")
            param1 = param1[param1.find(b"(", start)+1:param1.find(b" ", start)]
            if param1.endswith(b'?'):
                param1 = param1[:-1]
        elif b"BigInt" in param1:
            start = param1.find(b"BigInt")
            sign = param1[param1.find(b"(", start)+1:param1.find(b"(", start)+2]
            param1 = param1[param1.find(b"(", start)+2:param1.find(b")", start)] + b"n" if sign == b"+" else param1[param1.find(b"(", start)+1:param1.find(b")", start)] + b"n"
        else:
            param1 = b"1"

        param2_start = output.find(b"Parameter[1]:")
        param2 = output[param2_start + len(b"Parameter[1]:"):output.find(b'\n', param2_start)]

        if b"TaggedSigned" in param2:
            param2 = param2[param2.find(b"(")+1:param2.find(b")")]
        elif b"HeapConstant" in param2:
            start = param2.find(b"HeapConstant")
            param2 = param2[param2.find(b"(", start)+1:param2.find(b")", start)].lower()
        elif b"HeapNumber" in param2:
            start = param2.find(b"HeapNumber")
            param2 = param2[param2.find(b"(", start)+1:param2.find(b" ", start)]
            if param2.endswith(b'?'):
                param2 = param2[:-1]
        elif b"BigInt" in param2:
            start = param2.find(b"BigInt")
            sign = param2[param2.find(b"(", start)+1:param2.find(b"(", start)+2]
            param2 = param2[param2.find(b"(", start)+2:param2.find(b")", start)] + b"n" if sign == b"+" else param2[param2.find(b"(", start)+1:param2.find(b")", start)] + b"n"
        else:
            param2 = b"0"

        return param1.decode(), param2.decode()


    def fuzz_turbo_tv(self, fuzz_out_dir: Path):
        self._js_dir = fuzz_out_dir / "covers"
        self._fuzz_d8_p = d8.get_d8_path("latest-machine/")
        self._tv_d8_p = d8.get_d8_path("latest")
        self._fuzz_out_dir = fuzz_out_dir
        self._bug_dir = self._fuzz_out_dir / "filtered"

        self._fuzz_out_dir.mkdir(exist_ok=True, parents=True)
        self._bug_dir.mkdir(exist_ok=True)
        self.init()
        self._run_fuzzilli()

def reproduce(issue_id: str):
    fuzzer = Fuzzer()
    if issue_id == "1234764" or issue_id == "1234770":
        profile = ROOT / "turbotv-fuzzilli" / "Sources" / "FuzzilliCli" / "Profiles" / f"V8Profile-1234764-1234770.swift.bak"
    else:
        profile = ROOT / "turbotv-fuzzilli" / "Sources" / "FuzzilliCli" / "Profiles" / f"V8Profile-{issue_id}.swift.bak"

    # subprocess.run(f"cp profile /home/user/optimuzz-experiment/fuzzilli/Sources/FuzzilliCli/Profiles/V8Profile.swift", shell=True, cwd="fuzzilli")
    subprocess.run(["cp", profile, ROOT / "turbotv-fuzzilli" / "Sources" / "FuzzilliCli" / "Profiles" / "V8Profile.swift"])
    fuzzer.init()
    fuzz_out_dir = ROOT / "archive"/ "repros" / issue_id
    fuzzer.reproduce(fuzz_out_dir, issue_id)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fuzzilli Reproduce")
    parser.add_argument("issue_id", type=str, required=True, help="Issue ID to reproduce")
    args = parser.parse_args()

    issue_id = args.issue_id
    reproduce(issue_id)