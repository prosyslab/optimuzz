#!/bin/bash
set -e

export OPAMYES=1

NCPU="$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)"
OCAML_VERSION="5.3.0"
export OPTIMUZZ_OPAM_SWITCH="optimuzz-$OCAML_VERSION"
opam init --reinit --bare --no-setup

switch_exists=no
for installed_switch in $(opam switch list --short); do
  if [[ "$installed_switch" == "$OPTIMUZZ_OPAM_SWITCH" ]]; then
    switch_exists=yes
    break
  fi
done

if [ "$switch_exists" = "no" ]; then
  opam switch create $OPTIMUZZ_OPAM_SWITCH $OCAML_VERSION
else
  opam switch $OPTIMUZZ_OPAM_SWITCH
fi

eval $(SHELL=bash opam env --switch=$OPTIMUZZ_OPAM_SWITCH)
opam pin https://github.com/prosyslab/logger.git
opam install -j $NCPU dune ctypes domainslib progress ocamlgraph ocamlformat merlin ocp-index ocp-indent ocaml-lsp-server
scripts/llvm20.sh
scripts/alive.sh

make
# opam install -j $NCPU llvm.16.0.6+nnp
# make
