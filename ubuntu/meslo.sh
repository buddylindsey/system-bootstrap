#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

log_step "Installing latest Meslo Nerd Font"

pushd /tmp >/dev/null
MESLO_VERSION=$(github_latest_release_tag "ryanoasis/nerd-fonts")
MESLO_VERSION=${MESLO_VERSION#v}
rm -rf meslo
mkdir meslo
pushd meslo >/dev/null
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v$MESLO_VERSION/Meslo.zip"
unzip -o Meslo.zip
sudo mkdir -p /usr/local/share/fonts/meslo
sudo cp Meslo* /usr/local/share/fonts/meslo
popd >/dev/null
popd >/dev/null
