#!/usr/bin/env bash

git submodule update --init --remote turbotv-fuzzilli
pushd turbotv-fuzzilli

git checkout optmuzz