#!/bin/bash

pushd /tmp

REPO='eza-community/eza'
ARCHIVE_FILE='eza.zip'

APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/v$APP_VERSION/eza_x86_64-unknown-linux-musl.zip
unzip $ARCHIVE_FILE
sudo install eza /usr/local/bin
popd

