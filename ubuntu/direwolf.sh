#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/../utils.sh"

prepare_install "$MODE_LATEST" "direwolf" "Dire Wolf"

upgrade_mode="no"
if command_exists direwolf; then
    upgrade_mode="yes"
fi

sudo apt-get install -y libasound2-dev build-essential cmake git gpsd libgps-dev gcc g++ make libudev-dev libavahi-client-dev socat

pushd /tmp >/dev/null

rm -rf direwolf
git clone https://www.github.com/wb2osz/direwolf

cd direwolf
mkdir build
cd build
cmake ..
make -j4
sudo make install

if [[ $upgrade_mode == "no" ]]; then
    make install-conf
fi

popd >/dev/null
