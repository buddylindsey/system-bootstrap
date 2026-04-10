#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

if ! prepare_install "$MODE_PRESENT" "steam" "Steam"; then
    exit 0
fi

pushd /tmp >/dev/null

ensure_apt_packages wget
wget -O steam.deb https://cdn.akamai.steamstatic.com/client/installer/steam.deb
sudo dpkg -i steam.deb

popd >/dev/null
