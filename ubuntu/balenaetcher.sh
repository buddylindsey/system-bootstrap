#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "balenaEtcher.AppImage" "balenaEtcher"

pushd /tmp >/dev/null

REPO="balena-io/etcher"
APP_VERSION=$(github_latest_release_tag "$REPO")
version=${APP_VERSION#v}
DOWNLOAD_ARCHIVE="balenaEtcher-$version-x64.AppImage"

if [[ ${VERBOSE:-no} == "yes" ]]; then
    log_step "REPO: $REPO"
    log_step "VERSION: $APP_VERSION"
    log_step "DOWNLOAD_ARCHIVE: $DOWNLOAD_ARCHIVE"
fi

curl -fsSLo balenaEtcher.AppImage "https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE"
chmod +x balenaEtcher.AppImage
sudo install balenaEtcher.AppImage /usr/local/bin
popd >/dev/null
