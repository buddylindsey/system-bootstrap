#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "ghostty" "Ghostty"

OS_FILE_PATH="/etc/os-release"
if [ -e "$OS_FILE_PATH" ]; then
    source "$OS_FILE_PATH"
else
    echo "Error: File '$OS_FILE_PATH' does not exist." >&2
    exit 1
fi

pushd /tmp >/dev/null

REPO="mkasberg/ghostty-ubuntu"
APP_VERSION=$(github_latest_release_tag "$REPO")
DOWNLOAD_ARCHIVE="ghostty_${APP_VERSION}_amd64_${VERSION_ID}.deb"

curl -fsSLo ghostty.deb "https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE"
sudo dpkg -i ghostty.deb

popd >/dev/null
