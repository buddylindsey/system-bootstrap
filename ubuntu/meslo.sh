#!/bin/bash

pushd /tmp
MESLO_VERSION=$(curl -s "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
mkdir meslo
pushd meslo
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v$MESLO_VERSION/Meslo.zip"
unzip Meslo.zip
sudo mkdir -p /usr/local/share/fonts/meslo
sudo cp Meslo* /usr/local/share/fonts/meslo
popd
popd

