#!/bin/bash
set -e

APP_NAME="MyGo2Shell"
TMP_FILE="/tmp/$APP_NAME.dmg"
MOUNT_POINT="/tmp/$APP_NAME.mount"
INSTALL_DIR="/Applications"

cleanup() {
    if [ -d "$MOUNT_POINT" ]; then
        hdiutil detach "$MOUNT_POINT" -quiet 2>/dev/null || true
    fi
    rm -f "$TMP_FILE"
}
trap cleanup EXIT

echo "Fetching latest release..."
DOWNLOAD_URL=$(curl -fsSL "https://api.github.com/repos/yuman07/MyGo2Shell/releases/latest" \
    | grep "browser_download_url.*\.dmg" | head -1 | cut -d'"' -f4)
if [ -z "$DOWNLOAD_URL" ]; then
    echo "❌ Failed to fetch latest release URL."
    echo "   Please check your network connection and try again."
    exit 1
fi

rm -f "$TMP_FILE"

echo "Downloading $APP_NAME..."
curl -fL "$DOWNLOAD_URL" -o "$TMP_FILE"

if [ ! -s "$TMP_FILE" ]; then
    echo "❌ Download failed: file is empty."
    echo "   Please check your network connection and try again."
    exit 1
fi

if ! hdiutil verify "$TMP_FILE" > /dev/null 2>&1; then
    echo "❌ Download failed: file is not a valid dmg image."
    echo "   This is usually caused by a network issue. Please try again."
    exit 1
fi

echo "Mounting $APP_NAME.dmg..."
hdiutil attach "$TMP_FILE" -mountpoint "$MOUNT_POINT" -nobrowse -quiet

if [ ! -d "$MOUNT_POINT/$APP_NAME.app" ]; then
    echo "❌ Mounted image does not contain $APP_NAME.app."
    exit 1
fi

if [ -d "$INSTALL_DIR/$APP_NAME.app" ]; then
    echo "Existing installation found. Overwriting..."
    rm -rf "$INSTALL_DIR/$APP_NAME.app"
fi

echo "Installing to $INSTALL_DIR..."
cp -R "$MOUNT_POINT/$APP_NAME.app" "$INSTALL_DIR/"

echo "Removing quarantine flag..."
xattr -cr "$INSTALL_DIR/$APP_NAME.app"

echo ""
echo "✅ $APP_NAME installed successfully!"
echo ""
echo "Opening $INSTALL_DIR in Finder..."
open "$INSTALL_DIR"
echo ""
echo "Next steps:"
echo "  1. Hold Cmd and drag $APP_NAME.app into the Finder toolbar"
echo "  2. Click the icon to open Terminal at the current folder"
