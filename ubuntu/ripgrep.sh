#!/bin/bash

pushd /tmp
RG_VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
echo $RG_VERSION
curl -sLo ripgrep.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/$RG_VERSION/ripgrep-$RG_VERSION-x86_64-unknown-linux-musl.tar.gz
tar -xzf ripgrep.tar.gz ripgrep-$RG_VERSION-x86_64-unknown-linux-musl/rg
sudo install ripgrep-$RG_VERSION-x86_64-unknown-linux-musl/rg /usr/local/bin
popd

