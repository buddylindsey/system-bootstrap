#!/bin/bash

VERBOSE="${VERBOSE:-no}"

pushd /tmp

REPO='fastfetch-cli/fastfetch'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE='fastfetch.tar.gz'
DOWNLOAD_ARCHIVE='fastfetch-linux-amd64.tar.gz'
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION='fastfetch-linux-amd64/usr/bin/fastfetch'

if [[ $VERBOSE == "yes" ]]; then
    echo "REPO: $REPO"
    echo "VERSION: $APP_VERSION"
fi

curl -sLo $ARCHIVE_FILE -s https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
tar -xzf $ARCHIVE_FILE
sudo install $EXTRACT_LOCATION $APP_DIR

popd
