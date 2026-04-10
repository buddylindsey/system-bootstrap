#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

if ! prepare_install "$MODE_PRESENT" "freecad" "FreeCAD"; then
    exit 0
fi

sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable
sudo apt update
sudo apt install -y freecad
