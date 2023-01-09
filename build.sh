#!/bin/bash
set -e

export OPAMYES=1

NCPU="$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)"
OCAML_VERSION="4.13.1"
LLFUZZ_OPAM_SWITCH=llfuzz-"$OCAML_VERSION"
opam init --reinit --bare --no-setup

switch_exists=no
for installed_switch in $(opam switch list --short); do
  if [[ "$installed_switch" == "$LLFUZZ_OPAM_SWITCH" ]]; then
    switch_exists=yes
    break
  fi
done

if [ "$switch_exists" = "no" ]; then
  opam switch create $LLFUZZ_OPAM_SWITCH $OCAML_VERSION
else
  opam switch $LLFUZZ_OPAM_SWITCH
fi

eval $(SHELL=bash opam config env --switch=$LLFUZZ_OPAM_SWITCH)
opam pin git@github.com:prosyslab/logger.git
opam install -j $NCPU dune z3 core yojson logger
opam install -j $NCPU ocamlformat merlin ocp-index ocp-indent ocaml-lsp-server # for development
make
