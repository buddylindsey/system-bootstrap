#!/bin/bash

VERBOSE="${VERBOSE:-no}"

# Source utils in parent directory
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/../utils.sh"

check_command_installed "Telegram"
if [ $? -eq 0 ]; then
    exit 0
fi


pushd /tmp

REPO='telegramdesktop/tdesktop'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE='tsetup.tar.xz'
DOWNLOAD_ARCHIVE='tsetup.5.5.5.tar.xz'
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION='Telegram/Telegram'

if [[ $VERBOSE == "yes" ]]; then
    echo "REPO: $REPO"
    echo "VERSION: $APP_VERSION"
fi

curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
tar -xJf $ARCHIVE_FILE
sudo install $EXTRACT_LOCATION $APP_DIR 
popd

