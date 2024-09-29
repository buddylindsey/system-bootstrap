#!/bin/bash

pushd /tmp
wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
tar -xf zellij.tar.gz
sudo install zellij /usr/local/bin
rm zellij.tar.gz
popd

mkdir -p ~/.config/zellij/

