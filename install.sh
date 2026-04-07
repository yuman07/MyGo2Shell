#!/bin/bash
set -e

APP_NAME="MyGo2Shell"
DOWNLOAD_URL="https://github.com/yuman07/MyGo2Shell/releases/download/v1.0.0/MyGo2Shell.zip"
TMP_FILE="/tmp/$APP_NAME.zip"
INSTALL_DIR="/Applications"

echo "Downloading $APP_NAME..."
curl -L "$DOWNLOAD_URL" -o "$TMP_FILE"

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
