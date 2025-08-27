#!/bin/bash

# Source utils in parent

VERBOSE="${VERBOSE:-no}"

pushd /tmp

REPO='asdf-vm/asdf'
APP_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
ARCHIVE_FILE='asdf.tar.gz'
DOWNLOAD_ARCHIVE="asdf-$APP_VERSION-linux-amd64.tar.gz"
APP_DIR='/usr/local/bin'
EXTRACT_LOCATION='asdf'

if [[ $VERBOSE == "yes" ]]; then
    echo "REPO: $REPO"
    echo "VERSION: $APP_VERSION"
    echo "DOWNLOAD_ARCHIVE: $DOWNLOAD_ARCHIVE"
fi

curl -sLo $ARCHIVE_FILE https://github.com/$REPO/releases/download/$APP_VERSION/$DOWNLOAD_ARCHIVE
tar -xzvf $ARCHIVE_FILE
sudo install $EXTRACT_LOCATION $APP_DIR
popd

asdf plugin add python
asdf install python latest
asdf global python latest
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest
asdf plugin add golang
asdf install golang latest
