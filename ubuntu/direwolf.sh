#!/bin/bash

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

REPO='wb2osz/direwolf'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')

UPGRADE="no"

check_command_installed "direwolf"
if [ $? -eq 0 ]; then
    $UPGRADE="yes"
    exit 0
fi

sudo apt-get install -y libasound2-dev build-essential cmake git gpsd libgps-dev gcc g++ make cmake libasound2-dev libudev-dev libavahi-client-dev socat

pushd /tmp

if [ -d "direwolf" ]; then
    rm -rf direwolf
fi

git clone https://www.github.com/wb2osz/direwolf

cd direwolf

mkdir build && cd build
cmake ..
make -j4
sudo make install

if [[ $UPGRADE == "no" ]]; then
    make install-conf
fi

popd
