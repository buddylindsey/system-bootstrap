#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

log_step "Installing latest Telegram Desktop"

pushd /tmp >/dev/null

REPO="telegramdesktop/tdesktop"
APP_VERSION=$(github_latest_release_tag "$REPO")

if [[ ${VERBOSE:-no} == "yes" ]]; then
    log_step "REPO: $REPO"
    log_step "VERSION: $APP_VERSION"
fi

curl -fsSLo tsetup.tar.xz "https://github.com/$REPO/releases/download/$APP_VERSION/tsetup.${APP_VERSION#v}.tar.xz"
tar -xJf tsetup.tar.xz
sudo install Telegram/Telegram /usr/local/bin
popd >/dev/null
