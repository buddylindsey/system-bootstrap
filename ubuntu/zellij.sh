#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "zellij" "zellij"

pushd /tmp >/dev/null
wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
tar -xf zellij.tar.gz
sudo install zellij /usr/local/bin
rm -f zellij.tar.gz zellij
popd >/dev/null

mkdir -p "$HOME/.config/zellij"
