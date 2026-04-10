#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "rg" "ripgrep"

pushd /tmp >/dev/null
RG_VERSION=$(github_latest_release_tag "BurntSushi/ripgrep")
curl -fsSLo ripgrep.tar.gz "https://github.com/BurntSushi/ripgrep/releases/download/$RG_VERSION/ripgrep-$RG_VERSION-x86_64-unknown-linux-musl.tar.gz"
tar -xzf ripgrep.tar.gz "ripgrep-$RG_VERSION-x86_64-unknown-linux-musl/rg"
sudo install "ripgrep-$RG_VERSION-x86_64-unknown-linux-musl/rg" /usr/local/bin
popd >/dev/null
