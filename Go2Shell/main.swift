import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        openShellInFinderDirectory()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NSApp.terminate(nil)
        }
    }

    private func openShellInFinderDirectory() {
        let source = """
        tell application "Finder"
            if (count of Finder windows) > 0 then
                set currentPath to POSIX path of (target of front Finder window as alias)
            else
                set currentPath to POSIX path of (desktop as alias)
            end if
        end tell

        tell application "Terminal"
            activate
            do script "cd " & quoted form of currentPath & " && clear"
        end tell
        """

        var error: NSDictionary?
        let script = NSAppleScript(source: source)
        script?.executeAndReturnError(&error)

        if let error = error {
            NSLog("Go2Shell error: \(error)")
        }
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
