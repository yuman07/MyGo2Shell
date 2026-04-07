<p align="center">
  <img src="assets/app-icon.png" width="128" height="128" alt="MyGo2Shell Icon">
</p>

<h1 align="center">MyGo2Shell</h1>

<p align="center">
  <strong>One click to open Terminal from Finder.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-macOS-blue?logo=apple" alt="Platform">
  <img src="https://img.shields.io/badge/language-Swift-orange?logo=swift" alt="Language">
  <img src="https://img.shields.io/badge/architecture-arm64-green" alt="Architecture">
  <img src="https://img.shields.io/github/license/yuman07/MyGo2Shell" alt="License">
</p>

<p align="center">
  <a href="README.md">English</a> | <a href="README_CN.md">中文</a>
</p>

---

## What is MyGo2Shell?

MyGo2Shell is a lightweight macOS utility that opens **Terminal.app** directly at the directory you're currently viewing in Finder. Simply drag it to the Finder toolbar and click — no configuration needed.

```
 Finder Window (/Users/you/Projects/MyApp)
 ┌──────────────────────────────────────────────┐
 │  ← → ▲  📁 MyApp    [MyGo2Shell]  <- Click!   │
 ├──────────────────────────────────────────────┤
 │  📂 src                                      │
 │  📂 docs                                     │
 │  📄 README.md                                │
 └──────────────────────────────────────────────┘
                     ↓
 Terminal
 ┌──────────────────────────────────────────────┐
 │  $ cd /Users/you/Projects/MyApp              │
 │  $  _                                        │
 │                                              │
 └──────────────────────────────────────────────┘
```

## Features

- **One-click launch** — Click the toolbar icon to instantly open Terminal at the current Finder directory
- **Zero configuration** — No preferences, no menu bar icon, no background process
- **Minimal footprint** — Single-file Swift app (~40 lines of code), launches and exits immediately
- **Native macOS experience** — Uses AppleScript to communicate with Finder and Terminal seamlessly
- **Finder toolbar integration** — Lives right in your Finder toolbar for quick access

## How It Works

```
┌─────────┐     AppleScript      ┌────────┐     Get current     ┌──────────┐
│         │ ──────────────────→  │        │ ──────────────────→ │          │
│ MyGo2Shell│                      │ Finder │   directory path    │ Terminal │
│         │                      │        │                     │   .app   │
└─────────┘                      └────────┘                     └──────────┘
     │                                                               │
     │              cd /path/to/current/folder && clear              │
     └───────────────────────────────────────────────────────────────┘
```

1. **Click** the MyGo2Shell icon in the Finder toolbar
2. The app reads the **current Finder window's directory** via AppleScript
3. If no Finder window is open, it defaults to the **Desktop**
4. A new Terminal window opens with `cd` to that directory
5. The app **exits automatically** — no lingering process

## Installation

### Option 1: Build from Source (Recommended)

```bash
# Clone the repository
git clone https://github.com/yuman07/MyGo2Shell.git
cd MyGo2Shell

# Build the app
./build.sh

# Copy to Applications
cp -r build/MyGo2Shell.app /Applications/
```

### Option 2: Build with Xcode

1. Open `MyGo2Shell.xcodeproj` in Xcode
2. Select **Product > Build** (or press `Cmd + B`)
3. Copy the built `MyGo2Shell.app` to `/Applications/`

### Add to Finder Toolbar

> This is the key step to make MyGo2Shell truly useful!

| Step | Action |
|:----:|--------|
| **1** | Open any **Finder** window |
| **2** | Open `/Applications/` in another Finder window |
| **3** | Hold **`Cmd`** and **drag** `MyGo2Shell.app` into the Finder toolbar |
| **4** | Release — the icon now appears in the toolbar |

```
 Before:  ← → ▲  📁 Documents
 After:   ← → ▲  📁 Documents   [>_]  <- MyGo2Shell!
```

> **Tip:** To remove it later, hold `Cmd` and drag the icon out of the toolbar.

## Requirements

| Item | Requirement |
|------|-------------|
| **OS** | macOS (Apple Silicon) |
| **Build tool** | Xcode Command Line Tools or Xcode |
| **Permissions** | Accessibility permission for AppleScript (system will prompt on first use) |

## Privacy & Permissions

On first launch, macOS will ask you to grant MyGo2Shell permission to control **Finder** and **Terminal** via AppleScript. This is required for the app to:

- Read the current Finder window's directory path
- Open a new Terminal window and run the `cd` command

You can manage these permissions in **System Settings > Privacy & Security > Automation**.

## Project Structure

```
MyGo2Shell/
├── MyGo2Shell/
│   ├── main.swift              # App entry point & core logic
│   ├── Info.plist              # App metadata
│   ├── MyGo2Shell.entitlements   # AppleScript permissions
│   └── Assets.xcassets/        # App icon assets
├── MyGo2Shell.xcodeproj/         # Xcode project file
├── build.sh                    # Command-line build script
└── README.md
```

## FAQ

**Q: Why does macOS say the app is from an unidentified developer?**
> Since the app is not signed with an Apple Developer certificate, macOS Gatekeeper may block it. Right-click the app and select **Open**, then click **Open** in the dialog to bypass this warning.

**Q: Can I use iTerm2 / Warp / other terminals instead of Terminal.app?**
> The current version only supports the built-in Terminal.app. You can modify the AppleScript in `main.swift` to target your preferred terminal.

**Q: The app opens Terminal but doesn't navigate to the right folder?**
> Make sure you've granted automation permissions in **System Settings > Privacy & Security > Automation**. You may need to remove and re-add the permissions.

## Acknowledgments

Inspired by the original [Go2Shell](https://zipzapmac.com/Go2Shell) app which is no longer actively maintained. This is a clean, open-source reimplementation built with pure Swift and AppleScript.

## License

This project is open source and available under the [MIT License](LICENSE).
