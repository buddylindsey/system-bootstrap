#!/bin/bash

pushd /tmp

REPO='sharkdp/bat'
ARCHIVE_FILE='bat.tar.gz'

APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -sLo $ARCHIVE_FILE -s https://github.com/sharkdp/bat/releases/download/$APP_VERSION/bat-$APP_VERSION-x86_64-unknown-linux-musl.tar.gz
tar -xzf $ARCHIVE_FILE bat-$APP_VERSION-x86_64-unknown-linux-musl/bat
sudo install bat-$APP_VERSION-x86_64-unknown-linux-musl/bat /usr/local/bin

popd

