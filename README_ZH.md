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
  <img src="https://img.shields.io/badge/macOS-15.0%2B_(Sequoia)-blue?logo=apple" alt="macOS 15.0+">
  <img src="https://img.shields.io/badge/Swift-6.0-orange?logo=swift" alt="Swift 6.0">
  <img src="https://img.shields.io/badge/architecture-arm64-green" alt="Architecture">
  <img src="https://img.shields.io/github/license/yuman07/MyGo2Shell" alt="License">
</p>

<p align="center">
  <a href="README.md">English</a> | <a href="README_ZH.md">中文</a>
</p>

---

## MyGo2Shell 是什么？

MyGo2Shell 是一款轻量级 macOS 工具，能够在你当前浏览的 Finder 目录下直接打开终端。支持 **Terminal.app**、**iTerm2**、**Ghostty**、**Warp** 以及任意可脚本化的终端。只需将它拖到 Finder 工具栏，点击即用，无需任何配置。

```
Finder (/Users/you/Projects/MyApp)
+----------------------------------------------+
|  <- ->    MyApp      [MyGo2Shell] <- Click!  |
|----------------------------------------------|
|  src/                                        |
|  docs/                                       |
|  README.md                                   |
+----------------------------------------------+
                       |
                       v
Terminal
+----------------------------------------------+
|  $ cd /Users/you/Projects/MyApp              |
|  $ _                                         |
+----------------------------------------------+
```

## 功能特性

- **一键启动** — 点击工具栏图标，即刻在当前 Finder 目录下打开终端
- **多终端支持** — 通过一条 `defaults write` 命令即可切换到 Terminal.app、iTerm2、Ghostty、Warp 或任意可脚本化的终端
- **零配置** — 开箱即用，默认打开 Terminal.app，无需任何设置
- **极致轻量** — 单文件 Swift 应用（约 180 行代码），启动即退出
- **原生体验** — 使用 AppleScript 与 Finder 和终端无缝通信
- **工具栏集成** — 常驻 Finder 工具栏，随时可用

## 安装

### macOS（15.0+，Apple Silicon）

#### 方式一：一键安装（推荐）

打开终端，粘贴以下命令：

```bash
curl -fsSL https://raw.githubusercontent.com/yuman07/MyGo2Shell/main/install.sh | bash
```

自动下载最新版本、安装到 `/Applications/` 并移除 macOS 隔离标记，即装即用。

#### 方式二：从 GitHub 下载

1. 前往 [Releases](https://github.com/yuman07/MyGo2Shell/releases) 页面
2. 下载最新的 `.dmg` 文件
3. 双击挂载后将 `MyGo2Shell.app` 拖入 `/Applications/`

> **注意：** MyGo2Shell 未使用 Apple 开发者证书签名，macOS Gatekeeper 可能在首次启动时拦截。可通过以下任一方式允许运行：
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
Before:  <- ->    Documents
After:   <- ->    Documents   [>_]  <- MyGo2Shell!
```

> **提示：** 如需移除，按住 `Cmd` 键将图标拖出工具栏即可。

## 使用

### 切换终端

默认情况下，MyGo2Shell 打开 **Terminal.app**。如需使用其他终端，执行对应的 `defaults write` 命令：

```bash
# 使用 iTerm2
defaults write com.go2shell.MyGo2Shell terminal -string "iTerm"

# 使用 Ghostty（需要 Ghostty 1.3+，依赖 perform action "new_window"）
defaults write com.go2shell.MyGo2Shell terminal -string "Ghostty"

# 使用 Warp
defaults write com.go2shell.MyGo2Shell terminal -string "Warp"

# 其它任意可脚本化终端 — 名称需与 /Applications/ 下的 .app 名一致
defaults write com.go2shell.MyGo2Shell terminal -string "Alacritty"

# 恢复默认的 Terminal.app
defaults delete com.go2shell.MyGo2Shell terminal
```

iTerm2、Ghostty、Warp 有内置的原生适配；其他终端会落到通用 AppleScript `do script` 接口处理。若配置的终端在 `/Applications/`、`/System/Applications/`、`/System/Applications/Utilities/`、`~/Applications/` 中均未找到，则自动回退到 Terminal.app。

### 自动化权限

首次启动时，macOS 会请求控制 Finder 和终端的权限，点击 **好** 即可授权——MyGo2Shell 使用 Apple Events 读取 Finder 的当前目录并打开终端窗口。

如果应用打开了终端但没有跳转到正确的目录，请检查 **系统设置 > 隐私与安全性 > 自动化** 中是否已授予相关权限。可能需要先移除再重新添加。

## 开发

> **仅限 macOS。** 构建步骤仅适用于 macOS 环境。

### 推荐前置要求

| 依赖 | 推荐版本 |
|------|---------|
| **macOS** | 26.4.1 (Tahoe) |
| **Xcode** | 26.4.1（内含 Swift 6.3.1、`swiftc`、`actool` 以及 Git） |

<sub>以上是作者本机的开发环境，可以保证成功构建并运行本项目。低于此版本或许也能运行，但未经测试，对效果不做保证。</sub>

### 前置环境检查与配置

用这一节确认本机是否已达到上方推荐基线；若有不足，按下列步骤升级。

**macOS**

- **查看当前版本：** 终端中运行 `sw_vers -productVersion`，或点击 **苹果菜单 > 关于本机** 查看。
- **升级（推荐方式）：** 进入 **系统设置 > 通用 > 软件更新**，安装可用的 macOS 更新。

**Xcode**

- **检查是否已安装及版本：** 终端中运行 `xcodebuild -version`。若提示错误，说明 Xcode 未安装（或 `xcode-select` 指向的是 Command Line Tools）。
- **安装（推荐方式）：** 从 [Mac App Store](https://apps.apple.com/app/xcode/id497799835) 安装 Xcode。安装后首次启动一次，让它完成工具链配置并接受许可协议。
- **升级：** 有新版本发布时，从 Mac App Store 更新。

### 构建步骤

上述前置满足后，克隆并构建：

```bash
# 克隆仓库到本地
git clone https://github.com/yuman07/MyGo2Shell.git

# 进入项目目录
cd MyGo2Shell

# 打开 Xcode 项目
open MyGo2Shell.xcodeproj
```

随后在 Xcode 中：

1. 选择 **Product > Build**（或按 `Cmd + B`）进行编译。
2. 选择 **Product > Show Build Folder in Finder**，定位到 `MyGo2Shell.app`。
3. 将 `MyGo2Shell.app` 移动到 `/Applications/` 进行端到端验证。

本地构建仅用于日常开发调试。**正式 Release 只能通过 [GitHub Actions Release 工作流](.github/workflows/release.yml) 发布**，不要分发本地构建的二进制产物。

### 发布 Release

维护者通过 **Actions > Release > Run workflow** 手动触发工作流并填入 semver 版本号（如 `1.0.0`）。GitHub Actions 在 `macos-26` runner 上使用 Xcode 26.3 通过 `swiftc` + `actool` 构建 app 包，用 `hdiutil` 打成 `.dmg`，并作为 GitHub Release 资源发布。

## 技术概述

MyGo2Shell 是一个无界面的 Cocoa 应用（`LSUIElement = true`），充当 Finder 与终端模拟器之间的一次性桥梁。它没有可见窗口、没有菜单栏图标、也不会驻留进程——启动、完成任务、退出。

核心设计遵循 **fire-and-forget** 模式：应用启动 `NSApplication` run loop 仅用于托管 AppleScript 执行，随后在下一次主循环迭代中终止。这是必要的，因为 `NSAppleScript` 需要活跃的 run loop 来分派 Apple Events，否则对 Finder 和终端的查询会静默失败。

启动后，应用执行三阶段工作流：

1. **路径获取** — 通过 `NSAppleScript` 向 Finder 发送 Apple Events 查询，获取最前面窗口目标目录的 POSIX 路径。如果没有打开任何 Finder 窗口（或目标无法解析为 alias——例如搜索结果视图、AirDrop、缺少 POSIX 路径的网络卷宗），脚本回退到 `~/Desktop`。

2. **终端路由** — 应用从 `UserDefaults` 读取 `terminal` 键值（通过 `defaults write com.go2shell.MyGo2Shell terminal "name"` 设置）。原始值经过清洗，剥离字母数字、空格和连字符以外的所有字符——这是为了防止 AppleScript 注入，因为终端名称会被插值到脚本字符串中。清洗结果若为空则默认 `Terminal`。清洗后的名称以大小写无关的方式与内置处理器匹配：
   - **iTerm / iTerm2** — 始终新开一个窗口（iTerm 已运行时使用 `create window with default profile`；冷启动时复用自动生成的初始窗口），再通过 `write text` 发送 `cd <path> && clear`。
   - **Ghostty** — 已运行时对 focused terminal 调用 `perform action "new_window"`，走与 `Cmd+N` 同一条 keybind notification 路径，从而绕开 AppleScript 路径下因 Ghostty 的 `tabbingMode = .preferred` 引起的自动 tab 合并（直接用 `new window with configuration` 会被合入已有 tab 组）。随后通过 `perform action "text:..."` 把 `cd <path> && clear` + 回车送入新 terminal。冷启动时回退到 `new window with configuration`——此时没有已有 tab 组可合并，安全。
   - **Warp** — 通过 `do shell script "open -a Warp <path>"` 调用 Warp 的原生目录参数。
   - **其他名称** — 落到通用 `do script` AppleScript 处理器，兼容任何可脚本化终端。

   每个处理器都区分「应用已运行」的*快速路径*与「冷启动后轮询 `count of windows > 0`」的*慢速路径*；所有 `cd` 都会追加 `&& clear` 以呈现干净的提示符。如果配置的终端在 `/Applications/`、`/System/Applications/`、`/System/Applications/Utilities/`、`~/Applications/` 中均未找到，则自动回退到 Terminal.app。

3. **自动退出** — `openShellInFinderDirectory` 全程同步（每个 `NSAppleScript.executeAndReturnError` 都会阻塞等待脚本返回）。它返回后，通过 `DispatchQueue.main.async` 把 `NSApp.terminate` 调度到下一次主循环迭代，让 `applicationDidFinishLaunching` 先干净返回，再拆除应用。

### 技术栈

| 类别 | 技术 |
|------|-----|
| 语言 | Swift 6.0 |
| 框架 | Cocoa (AppKit) |
| 进程间通信 | AppleScript（通过 `NSAppleScript`） |
| 配置 | `UserDefaults`（`defaults write`） |
| 构建 — 本地开发 | Xcode |
| 构建 — 发布 | GitHub Actions（`swiftc` + `actool` + `hdiutil`），运行于 `macos-26` 并锁定 Xcode 26.3 |
| 架构 | arm64 (Apple Silicon) |
| 部署目标 | macOS 15.0 (Sequoia) |

### 架构

```mermaid
graph TD
    Finder[Finder.app] -->|"Apple Events: frontmost window path"| Router
    UD[UserDefaults] -->|"terminal preference (sanitized)"| Router

    subgraph App["MyGo2Shell.app (zero-UI, fire-and-forget)"]
        Router[Terminal Router] -->|"name == iTerm / iTerm2"| IH[iTerm Handler]
        Router -->|"name == Ghostty"| GtH[Ghostty Handler]
        Router -->|"name == Warp"| WH[Warp Handler]
        Router -->|"any other / not found"| GH[Generic Handler]
    end

    IH -->|"create window + write text 'cd ...'"| iTerm[iTerm2.app]
    GtH -->|"perform action new_window + text:'cd ...'"| Ghostty[Ghostty.app]
    WH -->|"do shell script 'open -a Warp <path>'"| Warp[Warp.app]
    GH -->|"do script 'cd ...'"| Term["Terminal.app / Other"]
```

- **路径获取流** — Finder.app 响应来自 Terminal Router 的 Apple Events 查询，返回最前面窗口目标的 POSIX 路径；查询失败时路由器回退到 `~/Desktop`。
- **终端路由逻辑** — 路由器从 UserDefaults 读取用户偏好的终端名，清洗输入（剥离不安全字符，若为空则默认 `Terminal`），再以大小写无关的名称匹配分派到四个专用处理器之一；未识别但已安装的终端落到通用处理器，未安装的名称则回退到 Terminal.app。
- **处理器特化** — 每个处理器针对目标终端做了定向优化：iTerm Handler 强制新开窗口以避免复用已有会话；Ghostty Handler 经由 `perform action "new_window"` 绕开 AppleScript 路径下的自动 tab 合并，并通过同一套 action 通道下发 `cd` 命令；Warp Handler 走 Warp 原生目录参数，路径最短；Generic Handler 使用通用的 `do script` AppleScript 接口兼容所有可脚本化终端。所有处理器都区分「应用已运行」的快速路径与「冷启动后等待首个窗口出现再下达命令」的慢速路径。

### 项目结构

```
MyGo2Shell/
|-- MyGo2Shell/
|   |-- main.swift              # 应用代理、终端路由、AppleScript 执行
|   |-- Info.plist              # Bundle 元数据（LSUIElement、版本、Apple Events 用途说明）
|   |-- MyGo2Shell.entitlements # Apple Events 自动化权限
|   `-- Assets.xcassets/        # 应用图标（16x16 到 512x512，1x 和 2x）
|-- assets/
|   `-- app-icon.png            # 图标源文件（128x128）
|-- MyGo2Shell.xcodeproj/       # Xcode 项目配置
|-- .github/workflows/          # GitHub Actions 发布工作流（swiftc + actool + hdiutil）
|-- install.sh                  # 一键安装脚本（下载最新 Release）
|-- README.md                   # 英文文档
|-- README_ZH.md                # 中文文档
`-- LICENSE                     # MIT 许可证
```

## FAQ

**Q: 点击工具栏图标后没有任何反应。**

> 请确认首次启动时已允许权限弹窗。打开 **系统设置 > 隐私与安全性 > 自动化**，找到 MyGo2Shell，确保 **Finder** 与你配置的终端均已勾选。如果从未出现过权限弹窗，通常用 `xattr -cr /Applications/MyGo2Shell.app` 移除隔离标记后重新启动即可触发。

**Q: 终端打开了，但停在了错误的目录（通常是 `~` 或 `~/Desktop`）。**

> 这说明 MyGo2Shell 无法把 Finder 窗口的目标解析为真实文件路径。常见原因：当前最前的 Finder 窗口正显示搜索结果、AirDrop，或缺少 POSIX 路径的网络位置。切换到普通文件夹再试即可。

**Q: 能否使用 iTerm2、Ghostty、Warp 以外的终端？**

> 可以。执行 `defaults write com.go2shell.MyGo2Shell terminal -string "<AppName>"`，把 `<AppName>` 换成 `/Applications/` 下对应 `.app` 的精确名称即可。通用处理器使用的是 AppleScript `do script`，兼容大多数可脚本化终端（如 Alacritty、以 macOS app bundle 形式打包的 kitty 等）。

**Q: 为什么 Ghostty 需要 1.3 或以上版本？**

> Ghostty 处理器依赖 `perform action "new_window"`，该动作自 Ghostty 1.3 起才提供。这是在「应用已运行」快速路径上可靠创建独立窗口、绕开 AppleScript 路径自动合 tab 行为的唯一方式。

## 致谢

灵感来源于已停止维护的 [Go2Shell](https://zipzapmac.com/Go2Shell)。MyGo2Shell 是基于纯 Swift + AppleScript 的全新开源重写版本。

## 许可证

本项目基于 [MIT License](LICENSE) 开源。
