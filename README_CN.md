<p align="center">
  <img src="assets/app-icon.png" width="128" height="128" alt="MyGo2Shell Icon">
</p>

<h1 align="center">MyGo2Shell</h1>

<p align="center">
  <strong>一键从 Finder 打开终端。</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-26.0%2B_(Tahoe)-blue?logo=apple" alt="macOS 26.0+">
  <img src="https://img.shields.io/badge/Xcode-26.0%2B-1575F9?logo=xcode" alt="Xcode 26.0+">
  <img src="https://img.shields.io/badge/Swift-6.0-orange?logo=swift" alt="Swift 5.0">
  <img src="https://img.shields.io/badge/architecture-arm64-green" alt="Architecture">
  <img src="https://img.shields.io/github/license/yuman07/MyGo2Shell" alt="License">
</p>

<p align="center">
  <a href="README.md">English</a> | <a href="README_CN.md">中文</a>
</p>

---

## MyGo2Shell 是什么?

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
- **零配置** — 无偏好设置、无菜单栏图标、无后台进程
- **极致轻量** — 单文件 Swift 应用（约 40 行代码），启动即退出
- **原生体验** — 使用 AppleScript 与 Finder 和 Terminal 无缝通信
- **工具栏集成** — 常驻 Finder 工具栏，随时可用

## 工作原理

```
┌───────────┐    AppleScript     ┌────────┐    获取当前目录     ┌──────────┐
│           │ ────────────────→  │        │ ────────────────→  │          │
│ MyGo2Shell│                    │ Finder │    目录路径         │ Terminal │
│           │                    │        │                    │   .app   │
└───────────┘                    └────────┘                    └──────────┘
      │                                                             │
      │            cd /path/to/current/folder && clear              │
      └─────────────────────────────────────────────────────────────┘
```

1. **点击** Finder 工具栏中的 MyGo2Shell 图标
2. 应用通过 AppleScript 读取 **当前 Finder 窗口的目录路径**
3. 如果没有打开任何 Finder 窗口，则默认打开 **桌面** 目录
4. 自动在新终端窗口中执行 `cd` 切换到目标目录
5. 应用 **自动退出** — 不会驻留后台

## 安装方法

### 方式一：从源码构建（推荐）

```bash
# 克隆仓库
git clone https://github.com/yuman07/MyGo2Shell.git
cd MyGo2Shell

# 构建应用
./build.sh

# 复制到应用程序目录
cp -r build/MyGo2Shell.app /Applications/
```

### 方式二：使用 Xcode 构建

1. 在 Xcode 中打开 `MyGo2Shell.xcodeproj`
2. 选择 **Product > Build**（或按 `Cmd + B`）
3. 将构建好的 `MyGo2Shell.app` 复制到 `/Applications/`

### 添加到 Finder 工具栏

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

## 系统要求

### 运行环境

| 项目 | 要求 | 说明 |
|------|------|------|
| **macOS** | 26.0 (Tahoe) 或更高版本 | 应用的 Deployment Target 设定为 macOS 26.0 |
| **芯片架构** | Apple Silicon (arm64) | 不支持 Intel Mac |
| **权限** | 自动化（AppleScript）权限 | 首次启动时系统会弹窗提示授权 |

### 编译环境

| 项目 | 要求 | 说明 |
|------|------|------|
| **Xcode** | 26.0 或更高版本 | 需要 macOS 26.0 SDK |
| **Swift** | 6.0 或更高版本 | 已包含在 Xcode 中 |
| **Xcode Command Line Tools** | `build.sh` 构建时必需 | 通过 `xcode-select --install` 安装 |

> **提示：** 如需支持更低版本的 macOS 或 Intel Mac，可修改 `MyGo2Shell.xcodeproj` 中的 Deployment Target，或编辑 `build.sh` 中的 `-target` 参数。

## 隐私与权限

首次启动时，macOS 会请求你授予 MyGo2Shell 通过 AppleScript 控制 **Finder** 和 **Terminal** 的权限。这是应用正常工作所必需的：

- 读取当前 Finder 窗口的目录路径
- 打开新的终端窗口并执行 `cd` 命令

你可以在 **系统设置 > 隐私与安全性 > 自动化** 中管理这些权限。

## 项目结构

```
MyGo2Shell/
├── MyGo2Shell/
│   ├── main.swift                # 应用入口和核心逻辑
│   ├── Info.plist                # 应用元数据
│   ├── MyGo2Shell.entitlements   # AppleScript 权限配置
│   └── Assets.xcassets/          # 应用图标资源
├── MyGo2Shell.xcodeproj/         # Xcode 工程文件
├── build.sh                      # 命令行构建脚本
├── README.md                     # 英文文档
└── README_CN.md                  # 中文文档
```

## 常见问题

**Q：双击提示"已损坏，无法打开。你应该将它移到废纸篓"？**
> 这是 macOS Gatekeeper 对从网络下载的未签名应用的安全拦截，并非真的损坏。在终端中执行以下命令移除隔离标记：
> ```bash
> xattr -cr /Applications/MyGo2Shell.app
> ```
> 然后重新双击即可正常打开。

**Q：macOS 提示"来自身份不明的开发者"怎么办？**
> 右键点击应用，选择 **打开**，然后在弹出的对话框中再次点击 **打开** 即可。

**Q：能否使用 iTerm2 / Warp 等第三方终端代替 Terminal.app？**
> 当前版本仅支持系统自带的 Terminal.app。你可以修改 `main.swift` 中的 AppleScript 脚本来适配你偏好的终端。

**Q：应用打开了终端，但没有跳转到正确的目录？**
> 请确认你已在 **系统设置 > 隐私与安全性 > 自动化** 中授予了相关权限。可能需要先移除再重新添加权限。

## 致谢

灵感来源于已停止维护的 [Go2Shell](https://zipzapmac.com/Go2Shell)。本项目是基于纯 Swift + AppleScript 的全新开源重写版本。

## 许可证

本项目基于 [MIT License](LICENSE) 开源。
