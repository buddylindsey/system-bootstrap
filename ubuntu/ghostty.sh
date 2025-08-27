#!/bin/bash

VERBOSE="${VERBOSE:-no}"


OS_FILE_PATH="/etc/os-release"

if [ -e "$OS_FILE_PATH" ]; then
  source $OS_FILE_PATH
else
  echo "Error: File '$OS_FILE_PATH' does not exist."
  exit 1
fi

# Source utils in parent
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

pushd /tmp

REPO='mkasberg/ghostty-ubuntu'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE='ghostty.deb'
DOWNLOAD_ARCHIVE="ghostty_${APP_VERSION}_amd64_${VERSION_ID}.deb"
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION='yazi-x86_64-unknown-linux-gnu/yazi'

curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/$APP_VERSION/ghostty_1.0.1-0.ppa1_amd64_22.04.deb

# Something is wrong with their download archive file naming
# Until they fix that we have to hard code it
# curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
sudo dpkg -i $ARCHIVE_FILE

popd
