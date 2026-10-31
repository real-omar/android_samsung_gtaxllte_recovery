#!/bin/bash

# Magisk
function download_magisk(){
    # Usage: download_magisk <destination_path>
    local DEST=$1
    if [ -n "${DEST}" ]; then
      if [ ! -e ${DEST} ]; then
        echo "Downloading Magisk Version 30.1..."
        local MAGISK_V27_URL="https://github.com/topjohnwu/Magisk/releases/download/v30.1/Magisk-v30.1.apk"
        mkdir -p $(dirname ${DEST})
        wget -q ${MAGISK_V27_URL} -O ${DEST} || wget ${MAGISK_V27_URL} -O ${DEST}
        local RCODE=$?
        if [ "$RCODE" = "0" ]; then
          echo "Successfully Downloaded Magisk v30.1 to ${DEST}!"
          echo "Done!"
        else
          echo "Failed to Download Magisk v30.1 to ${DEST}!"
        fi
      fi
    fi
}
export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk.zip
download_magisk $FOX_USE_SPECIFIC_MAGISK_ZIP

SOURCE_IMAGE="device/samsung/gtaxllte/addon/maintainer.png"

# Target location in the recovery ramdisk
TARGET_DIR="$FOX_RAMDISK/twres/images/Default/About"

if [ -f "$SOURCE_IMAGE" ]; then
    echo "Applying custom maintainer image from device tree..."
    mkdir -p "$TARGET_DIR"
    cp -f "$SOURCE_IMAGE" "$TARGET_DIR/maintainer.png"
    echo "Success: maintainer.png updated."
else
    echo "Error: Image not found at $SOURCE_IMAGE"
    # Tip: check if you are running 'lunch' from the base of the source tree
    exit 1
fi
