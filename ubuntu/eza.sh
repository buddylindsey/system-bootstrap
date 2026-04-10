#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "eza" "eza"

pushd /tmp >/dev/null

REPO="eza-community/eza"
APP_VERSION=$(github_latest_release_tag "$REPO")
curl -fsSLo eza.zip "https://github.com/$REPO/releases/download/$APP_VERSION/eza_x86_64-unknown-linux-musl.zip"
unzip -o eza.zip
sudo install eza /usr/local/bin
popd >/dev/null
