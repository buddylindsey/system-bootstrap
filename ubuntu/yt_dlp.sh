#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "yt-dlp" "yt-dlp"

sudo apt remove -y yt-dlp
sudo apt remove -y --autoremove

pushd /tmp >/dev/null

REPO="yt-dlp/yt-dlp"
APP_VERSION=$(github_latest_release_tag "$REPO")

if [[ ${VERBOSE:-no} == "yes" ]]; then
    log_step "REPO: $REPO"
    log_step "VERSION: $APP_VERSION"
fi

curl -fsSLo yt-dlp "https://github.com/$REPO/releases/download/$APP_VERSION/yt-dlp_linux"
chmod +x yt-dlp
sudo install yt-dlp /usr/local/bin
popd >/dev/null
