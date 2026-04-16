import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        openShellInFinderDirectory()
        DispatchQueue.main.async {
            NSApp.terminate(nil)
        }
    }

    private func applicationExists(_ name: String) -> Bool {
        let fm = FileManager.default
        return fm.fileExists(atPath: "/Applications/\(name).app")
            || fm.fileExists(atPath: "/System/Applications/\(name).app")
            || fm.fileExists(atPath: "/System/Applications/Utilities/\(name).app")
            || fm.fileExists(atPath: "\(NSHomeDirectory())/Applications/\(name).app")
    }

    private func sanitizedTerminalName(_ raw: String) -> String {
        let allowed = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: " -"))
        let sanitized = String(raw.unicodeScalars.filter { allowed.contains($0) })
        return sanitized.isEmpty ? "Terminal" : sanitized
    }

    private func openShellInFinderDirectory() {
        let rawTerminal = UserDefaults.standard.string(forKey: "terminal") ?? "Terminal"
        let terminal = sanitizedTerminalName(rawTerminal)

        let getPathScript = """
        tell application "Finder"
            if (count of Finder windows) > 0 then
                try
                    set currentPath to POSIX path of (target of front Finder window as alias)
                on error
                    set currentPath to POSIX path of (desktop as alias)
                end try
            else
                set currentPath to POSIX path of (desktop as alias)
            end if
        end tell
        return currentPath
        """

        var error: NSDictionary?
        let result = NSAppleScript(source: getPathScript)?.executeAndReturnError(&error)
        guard let path = result?.stringValue, !path.isEmpty else {
            if let error { NSLog("MyGo2Shell error getting path: \(error)") }
            return
        }

        if !applicationExists(terminal) {
            NSLog("MyGo2Shell: terminal '\(terminal)' not found, falling back to Terminal")
            openInGenericTerminal(name: "Terminal", path: path)
            return
        }

        let lowercased = terminal.lowercased()
        if lowercased == "iterm" || lowercased == "iterm2" {
            openInITerm(path: path)
        } else if lowercased == "warp" {
            openInWarp(path: path)
        } else if lowercased == "ghostty" {
            openInGhostty(path: path)
        } else {
            openInGenericTerminal(name: terminal, path: path)
        }
    }

    private func openInITerm(path: String) {
        let source = """
        tell application "iTerm"
            activate
            if (count of windows) > 0 then
                tell current window
                    create tab with default profile
                end tell
            else
                create window with default profile
            end if
            tell current session of current window
                write text "cd " & quoted form of "\(path)" & " && clear"
            end tell
        end tell
        """
        runAppleScript(source)
    }

    private func openInGhostty(path: String) {
        let source = """
        tell application "Ghostty"
            activate
            set cfg to new surface configuration
            set initial working directory of cfg to "\(path)"
            if (count of windows) > 0 then
                new tab in front window with configuration cfg
            else
                new window with configuration cfg
            end if
        end tell
        """
        runAppleScript(source)
    }

    private func openInWarp(path: String) {
        let source = """
        do shell script "open -a Warp " & quoted form of "\(path)"
        """
        runAppleScript(source)
    }

    private func openInGenericTerminal(name: String, path: String) {
        let source = """
        tell application "\(name)"
            activate
            do script "cd " & quoted form of "\(path)" & " && clear"
        end tell
        """
        runAppleScript(source)
    }

    private func runAppleScript(_ source: String) {
        var error: NSDictionary?
        let script = NSAppleScript(source: source)
        script?.executeAndReturnError(&error)
        if let error {
            NSLog("MyGo2Shell error: \(error)")
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
