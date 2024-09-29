#!/bin/bash

VERBOSE="${VERBOSE:-no}"

pushd /tmp

REPO='o2sh/onefetch'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE='onefetch.tar.gz'
DOWNLOAD_ARCHIVE='onefetch-linux.tar.gz'
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION='./onefetch'

if [[ $VERBOSE == "yes" ]]; then
    echo "REPO: $REPO"
    echo "VERSION: $APP_VERSION"
fi

curl -sLo $ARCHIVE_FILE -s https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
tar -xzf $ARCHIVE_FILE
sudo install $EXTRACT_LOCATION $APP_DIR

popd
