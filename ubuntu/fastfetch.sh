#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "fastfetch" "fastfetch"

pushd /tmp >/dev/null

REPO="fastfetch-cli/fastfetch"
APP_VERSION=$(github_latest_release_tag "$REPO")

if [[ ${VERBOSE:-no} == "yes" ]]; then
    log_step "REPO: $REPO"
    log_step "VERSION: $APP_VERSION"
fi

curl -fsSLo fastfetch.tar.gz "https://github.com/$REPO/releases/download/$APP_VERSION/fastfetch-linux-amd64.tar.gz"
tar -xzf fastfetch.tar.gz
sudo install fastfetch-linux-amd64/usr/bin/fastfetch /usr/local/bin

popd >/dev/null
