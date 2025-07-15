#!/bin/bash

VERBOSE="${VERBOSE:-no}"

pushd /tmp

REPO='balena-io/etcher'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE='balenaEtcher.AppImage'
version=${APP_VERSION#v}
DOWNLOAD_ARCHIVE="balenaEtcher-$version-x64.AppImage"
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION=''

if [[ $VERBOSE == "yes" ]]; then
    echo "REPO: $REPO"
    echo "VERSION: $APP_VERSION"
    echo "DOWNLOAD_ARCHIVE: $DOWNLOAD_ARCHIVE"
fi

curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
chmod +x $ARCHIVE_FILE
sudo install $ARCHIVE_FILE $APP_DIR 
popd

