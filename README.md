<p align="center">
  <img src="assets/app-icon.png" width="128" height="128" alt="MyGo2Shell Icon">
</p>

<h1 align="center">MyGo2Shell</h1>

<p align="center">
  <strong>One click to open Terminal from Finder.</strong>
</p>

<p align="center">
  <a href="https://github.com/yuman07/MyGo2Shell/releases"><img src="https://img.shields.io/github/v/release/yuman07/MyGo2Shell?color=brightgreen&logo=github" alt="Release"></a>
  <a href="https://github.com/yuman07/MyGo2Shell/releases"><img src="https://img.shields.io/github/downloads/yuman07/MyGo2Shell/total?color=blue&logo=github" alt="Downloads"></a>
  <a href="https://github.com/yuman07/MyGo2Shell/stargazers"><img src="https://img.shields.io/github/stars/yuman07/MyGo2Shell?style=social" alt="Stars"></a>
  <br>
  <img src="https://img.shields.io/badge/macOS-12.0%2B_(Monterey)-blue?logo=apple" alt="macOS 12.0+">
  <img src="https://img.shields.io/badge/Swift-6.0-orange?logo=swift" alt="Swift 6.0">
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
- **Multiple terminal support** — Works with Terminal.app, iTerm2, Warp, and more via a single `defaults write` command
- **Zero configuration** — Works out of the box with Terminal.app, no setup required
- **Minimal footprint** — Single-file Swift app (~100 lines of code), launches and exits immediately
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

### Option 1: One-Line Install (Recommended)

Open Terminal and paste the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/yuman07/MyGo2Shell/main/install.sh | bash
```

This will automatically download the latest release, install, and configure the app — ready to use.

### Option 2: Build from Source

```bash
# Clone the repository
git clone https://github.com/yuman07/MyGo2Shell.git
cd MyGo2Shell

# Build the app
./build.sh

# Copy to Applications
cp -r build/MyGo2Shell.app /Applications/
```

### Option 3: Build with Xcode

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

### Runtime Requirements

| Item | Requirement | Notes |
|------|-------------|-------|
| **macOS** | 12.0 (Monterey) or later | Deployment target is set to macOS 12.0 |
| **Architecture** | Apple Silicon (arm64) | Intel Macs are not supported |
| **Permissions** | Automation (AppleScript) | System will prompt on first launch |

### Build Requirements

| Item | Requirement | Notes |
|------|-------------|-------|
| **Xcode** | 26.3 or later | Required for macOS 12.0 SDK and Swift 6.0 |
| **Swift** | 6.0 or later | Included with Xcode |
| **Xcode Command Line Tools** | Required for `build.sh` | Install via `xcode-select --install` |

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
│   ├── MyGo2Shell.entitlements # AppleScript permissions
│   └── Assets.xcassets/        # App icon assets
├── assets/                     # Project assets (app icon source)
├── MyGo2Shell.xcodeproj/       # Xcode project file
├── build.sh                    # Command-line build script
├── install.sh                  # One-line installation script
├── README.md                   # English documentation
└── README_CN.md                # Chinese documentation
```

## FAQ

**Q: macOS says the app is "damaged and can't be opened"?**
> This is caused by macOS Gatekeeper quarantining unsigned apps downloaded from the internet. Run the following command in Terminal to remove the quarantine flag:
> ```bash
> xattr -cr /Applications/MyGo2Shell.app
> ```
> Then double-click to open it normally.

**Q: Why does macOS say the app is from an unidentified developer?**
> Right-click the app and select **Open**, then click **Open** in the dialog to bypass this warning.

**Q: Can I use iTerm2 / Warp / other terminals instead of Terminal.app?**
> Yes! Use `defaults write` to set your preferred terminal:
> ```bash
> # Use iTerm2
> defaults write com.go2shell.MyGo2Shell terminal -string "iTerm"
>
> # Use Warp
> defaults write com.go2shell.MyGo2Shell terminal -string "Warp"
>
> # Reset to default Terminal.app
> defaults delete com.go2shell.MyGo2Shell terminal
> ```
> The terminal name should match the application name in `/Applications/`. iTerm2 and Warp have built-in native handling; other terminals use the standard AppleScript `do script` interface.

**Q: The app opens Terminal but doesn't navigate to the right folder?**
> Make sure you've granted automation permissions in **System Settings > Privacy & Security > Automation**. You may need to remove and re-add the permissions.

## Acknowledgments

Inspired by the original [Go2Shell](https://zipzapmac.com/Go2Shell) app which is no longer actively maintained. This is a clean, open-source reimplementation built with pure Swift and AppleScript.

## License

This project is open source and available under the [MIT License](LICENSE).
