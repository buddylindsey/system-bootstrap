#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "signal-desktop" "Signal"

ensure_apt_packages ca-certificates gnupg wget

pushd /tmp >/dev/null

wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
sudo install -m 0644 signal-desktop-keyring.gpg /usr/share/keyrings/signal-desktop-keyring.gpg

wget -O signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources
sudo install -m 0644 signal-desktop.sources /etc/apt/sources.list.d/signal-desktop.sources

popd >/dev/null

sudo apt update

sudo apt install -y signal-desktop
