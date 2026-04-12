<p align="center">
  <img src="assets/app-icon.png" width="128" height="128" alt="MyGo2Shell Icon">
</p>

<h1 align="center">MyGo2Shell</h1>

<p align="center">
  <strong>一键从 Finder 打开终端。</strong>
</p>

<p align="center">
  <a href="https://github.com/yuman07/MyGo2Shell/releases"><img src="https://img.shields.io/github/v/release/yuman07/MyGo2Shell?color=brightgreen&logo=github" alt="Release"></a>
  <a href="https://github.com/yuman07/MyGo2Shell/releases"><img src="https://img.shields.io/github/downloads/yuman07/MyGo2Shell/total?color=blue&logo=github" alt="Downloads"></a>
  <a href="https://github.com/yuman07/MyGo2Shell/stargazers"><img src="https://img.shields.io/github/stars/yuman07/MyGo2Shell?style=social" alt="Stars"></a>
  <br>
  <img src="https://img.shields.io/badge/macOS-14.0%2B_(Sonoma)-blue?logo=apple" alt="macOS 14.0+">
  <img src="https://img.shields.io/badge/Swift-6.0-orange?logo=swift" alt="Swift 6.0">
  <img src="https://img.shields.io/badge/architecture-arm64-green" alt="Architecture">
  <img src="https://img.shields.io/github/license/yuman07/MyGo2Shell" alt="License">
</p>

<p align="center">
  <a href="README.md">English</a> | <a href="README_ZH.md">中文</a>
</p>

---

## MyGo2Shell 是什么？

MyGo2Shell 是一款轻量级 macOS 工具，能够在你当前浏览的 Finder 目录下直接打开 **Terminal.app**。只需将它拖到 Finder 工具栏，点击即用，无需任何配置。

```
 Finder 窗口 (/Users/you/Projects/MyApp)
 ┌──────────────────────────────────────────────┐
 │  ← → ▲  📁 MyApp    [MyGo2Shell]  <- 点击!  │
 ├──────────────────────────────────────────────┤
 │  📂 src                                      │
 │  📂 docs                                     │
 │  📄 README.md                                │
 └──────────────────────────────────────────────┘
                     ↓
 终端
 ┌──────────────────────────────────────────────┐
 │  $ cd /Users/you/Projects/MyApp              │
 │  $  _                                        │
 │                                              │
 └──────────────────────────────────────────────┘
```

## 功能特性

- **一键启动** — 点击工具栏图标，即刻在当前 Finder 目录下打开终端
- **多终端支持** — 通过一条 `defaults write` 命令即可切换到 iTerm2、Warp 等终端
- **零配置** — 开箱即用，默认打开 Terminal.app，无需任何设置
- **极致轻量** — 单文件 Swift 应用（约 100 行代码），启动即退出
- **原生体验** — 使用 AppleScript 与 Finder 和 Terminal 无缝通信
- **工具栏集成** — 常驻 Finder 工具栏，随时可用

## 安装

### macOS（14.0+，Apple Silicon）

#### 方式一：一键安装（推荐）

打开终端，粘贴以下命令：

```bash
curl -fsSL https://raw.githubusercontent.com/yuman07/MyGo2Shell/main/install.sh | bash
```

自动下载最新版本，安装到 `/Applications/` 并移除 macOS 隔离标记，即装即用。

#### 方式二：从 GitHub 下载

1. 前往 [Releases](https://github.com/yuman07/MyGo2Shell/releases) 页面
2. 下载最新的 `.zip` 文件
3. 解压后将 `MyGo2Shell.app` 移动到 `/Applications/`

> **注意：** MyGo2Shell 未使用 Apple 开发者证书签名，macOS Gatekeeper 可能会在首次启动时拦截。可通过以下任一方式允许运行：
>
> **方法一 — 系统设置：**
> 打开 **系统设置 > 隐私与安全性**，滚动到底部，找到 MyGo2Shell 被阻止的提示，点击 **仍要打开**。
>
> **方法二 — 右键打开：**
> 在 `/Applications/` 中右键点击（或按住 Control 点击）`MyGo2Shell.app`，选择 **打开**，然后在确认对话框中再次点击 **打开**。
>
> **方法三 — 移除隔离标记：**
> ```bash
> xattr -cr /Applications/MyGo2Shell.app
> ```

#### 添加到 Finder 工具栏

> 这是让 MyGo2Shell 真正好用的关键步骤！

| 步骤 | 操作 |
|:----:|------|
| **1** | 打开任意 **Finder** 窗口 |
| **2** | 在另一个 Finder 窗口中打开 `/Applications/` |
| **3** | 按住 **`Cmd`** 键，将 `MyGo2Shell.app` **拖入** Finder 工具栏 |
| **4** | 松开鼠标 — 图标即出现在工具栏中 |

```
 添加前:  ← → ▲  📁 文稿
 添加后:  ← → ▲  📁 文稿   [>_]  <- MyGo2Shell!
```

> **提示：** 如需移除，按住 `Cmd` 键将图标拖出工具栏即可。

## 开发

> **仅限 macOS。** 构建步骤仅适用于 macOS 环境。

### 前置要求

| 项目 | 最低版本 | 说明 |
|------|---------|------|
| **macOS** | 14.5 (Sonoma) | Xcode 16.0 的系统要求 |
| **Xcode** | 16.0 | 包含 Swift 6.0、swiftc、actool 和 Git。从 [Mac App Store](https://apps.apple.com/app/xcode/id497799835) 下载 |

### 命令行构建

```bash
# 克隆仓库到本地
git clone https://github.com/yuman07/MyGo2Shell.git

# 进入项目目录
cd MyGo2Shell

# 运行构建脚本（编译 arm64 二进制文件，打包应用图标，生成 .app）
./build.sh

# 将构建好的应用复制到"应用程序"文件夹
cp -r build/MyGo2Shell.app /Applications/

# 移除 macOS 隔离标记，避免 Gatekeeper 拦截
xattr -cr /Applications/MyGo2Shell.app
```

### 使用 Xcode 构建

```bash
# 克隆仓库到本地
git clone https://github.com/yuman07/MyGo2Shell.git

# 进入项目目录
cd MyGo2Shell

# 打开 Xcode 项目
open MyGo2Shell.xcodeproj
```

然后在 Xcode 中：

1. 选择菜单栏 **Product > Build**（或按 `Cmd + B`）编译
2. 选择 **Product > Show Build Folder in Finder** 找到 `MyGo2Shell.app`
3. 将 `MyGo2Shell.app` 移动到 `/Applications/`

## 技术概述

MyGo2Shell 是一个无界面的 Cocoa 应用（`LSUIElement = true`），充当 Finder 与终端模拟器之间的桥梁。启动后执行三阶段工作流：

1. **路径获取** — 通过 AppleScript 查询 Finder 最前面窗口的目录路径。如果没有打开任何窗口，则回退到桌面。
2. **终端路由** — 应用从 `UserDefaults` 读取 `terminal` 键值以确定使用哪个终端，然后分派到针对该终端优化的处理器。iTerm2 使用感知标签页的 AppleScript（在现有窗口中创建标签页或新建窗口），Warp 使用 `open -a`（原生目录参数），其余终端使用通用的 `do script` AppleScript 接口。
3. **自动退出** — 分派终端命令后，应用在下一个 run loop 迭代中调用 `NSApp.terminate`。不会有进程驻留内存。

输入清洗会剥离终端名称中的非字母数字字符（防止 AppleScript 注入），如果配置的终端未安装则自动回退到 Terminal.app。

### 技术栈

| 类别 | 技术 |
|------|-----|
| 语言 | Swift 6.0 |
| 框架 | Cocoa (AppKit) |
| 进程间通信 | AppleScript（通过 `NSAppleScript`） |
| 配置 | `UserDefaults`（`defaults write`） |
| 构建系统 | Xcode / shell 脚本（`swiftc` + `actool`） |
| 架构 | arm64 (Apple Silicon) |
| 部署目标 | macOS 14.0 (Sonoma) |

### 架构

```
┌──────────────────────────────────────────────────────────┐
│                       MyGo2Shell                         │
│                                                          │
│  ┌─────────────┐    ┌──────────────┐    ┌────────────┐  │
│  │ UserDefaults │───→│ 终端         │───→│ AppleScript│  │
│  │ (terminal)   │    │ 路由器       │    │ 分派器     │  │
│  └─────────────┘    └──────────────┘    └─────┬──────┘  │
│                                                │         │
└────────────────────────────────────────────────┼─────────┘
                                                 │
                    ┌────────────────────────────┬┼─────────────┐
                    │                            ││             │
               ┌────▼─────┐              ┌───────▼▼──┐   ┌─────▼────┐
               │  Finder   │              │ Terminal  │   │  iTerm2  │
               │(获取路径) │              │ / Warp /  │   │(标签管理)│
               └───────────┘              │  通用终端 │   └──────────┘
                                          └───────────┘
```

### 项目结构

```
MyGo2Shell/
├── MyGo2Shell/
│   ├── main.swift              # 应用代理、终端路由、AppleScript 执行
│   ├── Info.plist              # Bundle 元数据（LSUIElement、版本、权限）
│   ├── MyGo2Shell.entitlements # Apple Events 自动化权限
│   └── Assets.xcassets/        # 应用图标（16×16 到 512×512，1x 和 2x）
├── assets/
│   └── app-icon.png            # 图标源文件（128×128）
├── MyGo2Shell.xcodeproj/       # Xcode 项目配置
├── build.sh                    # 命令行构建：swiftc + actool → .app 包
├── install.sh                  # 一键安装脚本（下载最新 Release）
├── README.md                   # 英文文档
├── README_ZH.md                # 中文文档
└── LICENSE                     # MIT 许可证
```

## 常见问题

**Q：双击提示"已损坏，无法打开"？**
> 这是 macOS Gatekeeper 对未签名应用的安全拦截，并非真的损坏。在终端中执行以下命令移除隔离标记：
> ```bash
> xattr -cr /Applications/MyGo2Shell.app
> ```
> 然后重新打开即可。

**Q：能否使用 iTerm2 / Warp 等第三方终端代替 Terminal.app？**
> 支持！通过 `defaults write` 命令即可切换终端：
> ```bash
> # 使用 iTerm2
> defaults write com.go2shell.MyGo2Shell terminal -string "iTerm"
>
> # 使用 Warp
> defaults write com.go2shell.MyGo2Shell terminal -string "Warp"
>
> # 恢复默认的 Terminal.app
> defaults delete com.go2shell.MyGo2Shell terminal
> ```
> 终端名称应与 `/Applications/` 中的应用名一致。iTerm2 和 Warp 有内置的原生适配，其他终端使用标准的 AppleScript `do script` 接口。

**Q：应用打开了终端，但没有跳转到正确的目录？**
> 请确认你已在 **系统设置 > 隐私与安全性 > 自动化** 中授予了相关权限。可能需要先移除再重新添加权限。

**Q：首次启动时，macOS 请求控制 Finder / Terminal 的权限？**
> 这是正常行为。MyGo2Shell 需要 Apple Events 权限来读取 Finder 的当前目录并打开终端窗口。点击 **好** 授予权限即可。你可以在 **系统设置 > 隐私与安全性 > 自动化** 中管理这些权限。

## 致谢

灵感来源于已停止维护的 [Go2Shell](https://zipzapmac.com/Go2Shell)。MyGo2Shell 是基于纯 Swift + AppleScript 的全新开源重写版本。

## 许可证

本项目基于 [MIT License](LICENSE) 开源。
