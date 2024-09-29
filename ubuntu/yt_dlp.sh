#!/bin/bash

sudo apt remove -y yt-dlp
sudo apt remove -y --autoremove


VERBOSE="${VERBOSE:-no}"

pushd /tmp

REPO='yt-dlp/yt-dlp'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE='yt-dlp'
DOWNLOAD_ARCHIVE='yt-dlp_linux'
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION='yt-dlp'

if [[ $VERBOSE == "yes" ]]; then
    echo "REPO: $REPO"
    echo "VERSION: $APP_VERSION"
fi

curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
chmod +x $ARCHIVE_FILE
sudo install $EXTRACT_LOCATION $APP_DIR 
popd

