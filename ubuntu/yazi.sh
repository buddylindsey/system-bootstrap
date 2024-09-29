#!/bin/bash

VERBOSE="${VERBOSE:-no}"

pushd /tmp

REPO='sxyazi/yazi'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE='yazi.zip'
DOWNLOAD_ARCHIVE='yazi-x86_64-unknown-linux-gnu.zip'
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION='yazi-x86_64-unknown-linux-gnu/yazi'

if [[ $VERBOSE == "yes" ]]; then
    echo "REPO: $REPO"
    echo "VERSION: $APP_VERSION"
fi

curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
unzip $ARCHIVE_FILE
sudo install $EXTRACT_LOCATION $APP_DIR 
popd

