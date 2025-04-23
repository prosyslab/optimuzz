#!/usr/bin/env bash

cd $HOME

if [[ ! -f $HOME/swiftly ]]; then
    curl -O https://download.swift.org/swiftly/linux/swiftly-1.0.0-$(uname -m).tar.gz
    tar -zxf swiftly-1.0.0-$(uname -m).tar.gz
fi

sudo apt-get -y install gnupg2 libcurl4-openssl-dev libxml2-dev
./swiftly init