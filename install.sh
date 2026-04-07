#!/bin/bash
set -e

APP_NAME="MyGo2Shell"
TMP_FILE="/tmp/$APP_NAME.zip"
INSTALL_DIR="/Applications"

trap 'rm -f "$TMP_FILE"' EXIT

echo "Fetching latest release..."
DOWNLOAD_URL=$(curl -fsSL "https://api.github.com/repos/yuman07/MyGo2Shell/releases/latest" \
    | grep "browser_download_url.*\.zip" | head -1 | cut -d'"' -f4)
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

if ! unzip -tq "$TMP_FILE" > /dev/null 2>&1; then
    echo "❌ Download failed: file is not a valid zip archive."
    echo "   This is usually caused by a network issue. Please try again."
    exit 1
fi

if [ -d "$INSTALL_DIR/$APP_NAME.app" ]; then
    echo "Existing installation found. Overwriting..."
fi

echo "Installing to $INSTALL_DIR..."
unzip -oq "$TMP_FILE" -d "$INSTALL_DIR"

echo "Removing quarantine flag..."
xattr -cr "$INSTALL_DIR/$APP_NAME.app"

echo ""
echo "✅ $APP_NAME installed successfully!"
echo ""
echo "Next steps:"
echo "  1. Open a Finder window"
echo "  2. Hold Cmd and drag $APP_NAME.app from /Applications into the Finder toolbar"
echo "  3. Click the icon to open Terminal at the current folder"
