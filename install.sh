#!/bin/bash
set -e

APP_NAME="MyGo2Shell"
DOWNLOAD_URL="https://github.com/yuman07/MyGo2Shell/releases/download/v1.0.0/MyGo2Shell.zip"
TMP_FILE="/tmp/$APP_NAME.zip"
INSTALL_DIR="/Applications"

rm -f "$TMP_FILE"

echo "Downloading $APP_NAME..."
curl -fL "$DOWNLOAD_URL" -o "$TMP_FILE"

if [ ! -s "$TMP_FILE" ]; then
    echo "❌ Download failed: file is empty."
    echo "   Please check your network connection and try again."
    rm -f "$TMP_FILE"
    exit 1
fi

if ! unzip -tq "$TMP_FILE" > /dev/null 2>&1; then
    echo "❌ Download failed: file is not a valid zip archive."
    echo "   This is usually caused by a network issue. Please try again."
    rm -f "$TMP_FILE"
    exit 1
fi

echo "Installing to $INSTALL_DIR..."
unzip -o "$TMP_FILE" -d "$INSTALL_DIR"

echo "Removing quarantine flag..."
xattr -cr "$INSTALL_DIR/$APP_NAME.app"

rm -f "$TMP_FILE"

echo ""
echo "✅ $APP_NAME installed successfully!"
echo ""
echo "Next steps:"
echo "  1. Open a Finder window"
echo "  2. Hold Cmd and drag $APP_NAME.app from /Applications into the Finder toolbar"
echo "  3. Click the icon to open Terminal at the current folder"
