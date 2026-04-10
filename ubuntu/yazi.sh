#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "yazi" "yazi"

pushd /tmp >/dev/null

REPO="sxyazi/yazi"
APP_VERSION=$(github_latest_release_tag "$REPO")

if [[ ${VERBOSE:-no} == "yes" ]]; then
    log_step "REPO: $REPO"
    log_step "VERSION: $APP_VERSION"
fi

curl -fsSLo yazi.zip "https://github.com/$REPO/releases/download/$APP_VERSION/yazi-x86_64-unknown-linux-gnu.zip"
unzip -o yazi.zip
sudo install yazi-x86_64-unknown-linux-gnu/yazi /usr/local/bin
popd >/dev/null
