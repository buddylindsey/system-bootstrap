#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "bat" "bat"

pushd /tmp >/dev/null

REPO="sharkdp/bat"
APP_VERSION=$(github_latest_release_tag "$REPO")
curl -fsSLo bat.tar.gz "https://github.com/$REPO/releases/download/$APP_VERSION/bat-$APP_VERSION-x86_64-unknown-linux-musl.tar.gz"
tar -xzf bat.tar.gz "bat-$APP_VERSION-x86_64-unknown-linux-musl/bat"
sudo install "bat-$APP_VERSION-x86_64-unknown-linux-musl/bat" /usr/local/bin

popd >/dev/null
