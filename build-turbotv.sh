#!/usr/bin/env bash

git submodule update --init --remote turbo-tv
pushd turbo-tv
git checkout a011a31faf0b9effb06d5b67b977e2dc91d4e240

export OPAMYES=1

opam install core_unix cmdliner dune ocamlgraph z3 ocamlformat oUnit -y
dune build --root . || true
dune install --root .

command -v turbo-tv
