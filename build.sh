#!/bin/bash
set -e

command -v swiftc >/dev/null 2>&1 || { echo "Error: swiftc not found. Run: xcode-select --install"; exit 1; }
command -v actool >/dev/null 2>&1 || { echo "Error: actool not found. Run: xcode-select --install"; exit 1; }

APP_NAME="MyGo2Shell"
BUILD_DIR="build"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
DEPLOYMENT_TARGET="12.0"

rm -rf "$BUILD_DIR"

mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

# Compile binary (arm64)
swiftc MyGo2Shell/main.swift \
    -o "$APP_BUNDLE/Contents/MacOS/$APP_NAME" \
    -framework Cocoa \
    -target arm64-apple-macos${DEPLOYMENT_TARGET}

# Compile asset catalog (generates AppIcon.icns)
actool MyGo2Shell/Assets.xcassets \
    --compile "$APP_BUNDLE/Contents/Resources" \
    --platform macosx \
    --minimum-deployment-target ${DEPLOYMENT_TARGET} \
    --app-icon AppIcon \
    --output-partial-info-plist "$BUILD_DIR/partial-info.plist"

# Copy Info.plist (replace build variables with actual values)
sed \
    -e 's/$(DEVELOPMENT_LANGUAGE)/en/' \
    -e 's/$(EXECUTABLE_NAME)/MyGo2Shell/' \
    -e "s/\$(PRODUCT_BUNDLE_IDENTIFIER)/com.go2shell.MyGo2Shell/" \
    -e 's/$(PRODUCT_NAME)/MyGo2Shell/' \
    -e "s/\$(MACOSX_DEPLOYMENT_TARGET)/${DEPLOYMENT_TARGET}/" \
    MyGo2Shell/Info.plist > "$APP_BUNDLE/Contents/Info.plist"

# Create PkgInfo
echo -n "APPL????" > "$APP_BUNDLE/Contents/PkgInfo"

echo "Build complete: $APP_BUNDLE"
echo ""
echo "Usage:"
echo "  1. Copy $APP_BUNDLE to /Applications"
echo "  2. Open a Finder window"
echo "  3. Hold Command and drag MyGo2Shell.app from /Applications into the Finder toolbar"
echo "  4. Click the icon to open Terminal at the current folder"
