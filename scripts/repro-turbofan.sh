#!/usr/bin/env bash

ROOT=$PWD
NUMBER=$1 # 1195650 1198705 1199345 1200490 1234764 1234770

if [[ -z $NUMBER ]]; then
    echo "Usage: $0 <number>"
    exit 1
fi

if [[ $(basename "$ROOT") != "optimuzz" ]]; then
    echo -e "\033[31mPlease run this script from the root of the optimuzz repository.\033[0m"
    exit 1
fi

echo $ROOT
export SCRIPTS=$ROOT/scripts

set -e

scripts/install-swift.sh

export SWIFTLY_HOME_DIR="/home/user/.local/share/swiftly"
export SWIFTLY_BIN_DIR="/home/user/.local/share/swiftly/bin"
if [[ ":$PATH:" != *":$SWIFTLY_BIN_DIR:"* ]]; then
    export PATH="$SWIFTLY_BIN_DIR:$PATH"
fi

swiftly install --use 6.0.1
swift --version

# Our TurboFan benchmark requires Python 2
if [[ ! -d $HOME/.pyenv ]]; then
    curl https://pyenv.run | bash
fi
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
pyenv install 2 --skip-existing


TURBOFAN_BUILDS=$HOME/turbofan-builds

mkdir -p $TURBOFAN_BUILDS
pushd $TURBOFAN_BUILDS
if [[ ! -d tools/depot_tools ]]; then
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git tools/depot_tools
fi
export PATH=$PWD/tools/depot_tools:$PATH

if [[ ! -d v8 ]]; then
    echo -e "\033[34mFetching v8...\033[0m"
    fetch v8
fi

echo -e "\033[34mChecking out v8...\033[0m"
gclient sync


COMMIT_ID=$(grep "^$NUMBER" $ROOT/turbotv-fuzzilli/d8-targets/commits.txt | awk '{print $2}')
echo -e "\033[34mFound the commit sha: $COMMIT_ID\033[0m"
pyenv global 2 # Our targets need python 2.7
pyenv exec gclient sync -D -R --revision=$COMMIT_ID

if [[ ! -f $HOME/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz ]]; then
    pushd $HOME
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz
    tar -xvf clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz
    popd
fi

pushd v8
tools/dev/v8gen.py x64.debug

cat > out.gn/x64.debug/args.gn <<EOF
clang_base_path = "$HOME/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04"
clang_use_chrome_plugins = false
treat_warnings_as_errors = false
is_debug = true
target_cpu = "x64"
v8_enable_backtrace = true
v8_enable_slow_dchecks = true
v8_optimized_debug = false
EOF

gn gen out.gn/x64.debug

cat out.gn/x64.debug/args.gn

echo -e "\033[34mBuilding instrumentation...\033[0m"

make -C $ROOT/instrumentation/ clean
make -C $ROOT/instrumentation/ BASE=$HOME/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04

echo -e "\033[34mEditing build rules...\033[0m"

TARGET_FILE=$(cat $ROOT/turbotv-fuzzilli/d8-targets/$NUMBER.txt | cut -d':' -f1)
$SCRIPTS/edit_rule.py out.gn/x64.debug/toolchain.ninja cxx "VERBOSE=1 TARGET_FILE=$TARGET_FILE OUT_DIR=\"$PWD/out.gn/x64.debug/cfg\"" "-fexperimental-new-pass-manager -Xclang -fpass-plugin=$ROOT/instrumentation/inst-pass.so"
$SCRIPTS/edit_rule.py out.gn/x64.debug/toolchain.ninja link "" "$ROOT/instrumentation/coverage.o"
$SCRIPTS/edit_rule.py out.gn/x64.debug/toolchain.ninja solink "" "$ROOT/instrumentation/coverage.o"

echo -e "\033[34mBuilding d8...\033[0m"
# ninja -C out.gn/x64.debug d8
$SCRIPTS/cfg_preprocess.py out.gn/x64.debug/cfg $ROOT/turbotv-fuzzilli/d8-targets/$NUMBER.txt > distmap.txt
cat distmap.txt | tail -n 5

cd $ROOT

rm -rf $HOME/d8s/$NUMBER/
mkdir -p $HOME/d8s/$NUMBER
mv $TURBOFAN_BUILDS/v8/out.gn/x64.debug/* $HOME/d8s/$NUMBER/
cp $TURBOFAN_BUILDS/v8/distmap.txt        $HOME/d8s/$NUMBER/distmap.txt

python3 -m venv .env
source .env/bin/activate
pip install -r $ROOT/turbotv-fuzzilli-requirements.txt
tools/turbofan-reproduce.py $NUMBER $HOME/d8s/$NUMBER/