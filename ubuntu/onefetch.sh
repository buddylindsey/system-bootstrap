#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "onefetch" "onefetch"

pushd /tmp >/dev/null

REPO="o2sh/onefetch"
APP_VERSION=$(github_latest_release_tag "$REPO")

if [[ ${VERBOSE:-no} == "yes" ]]; then
    log_step "REPO: $REPO"
    log_step "VERSION: $APP_VERSION"
fi

curl -fsSLo onefetch.tar.gz "https://github.com/$REPO/releases/download/$APP_VERSION/onefetch-linux.tar.gz"
tar -xzf onefetch.tar.gz
sudo install ./onefetch /usr/local/bin

popd >/dev/null
