#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

if ! prepare_install "$MODE_PRESENT" "obs" "OBS Studio"; then
    exit 0
fi

sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y ffmpeg obs-studio
