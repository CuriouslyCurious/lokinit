#if os(macOS)

import AppKit
import CoreFoundation

@_cdecl("setup")
func ffiSetup() {
    // Init the NSApplication
    let nsApp = NSApplication.shared

    // Start the NSApplication
    nsApp.setActivationPolicy(NSApplication.ActivationPolicy.regular)
    nsApp.activate(ignoringOtherApps: true)
    nsApp.finishLaunching()
}

@_cdecl("create_window")
func ffiCreateWindow(width: Int64, height: Int64, title: UnsafePointer<CChar>) -> UInt64 {
    // Convert FFI to Swift types
    let title = String.init(cString: title)
    let size = NSRect.init(x: 0, y: 0, width: Int(width), height: Int(height))
    // Make a new window
    let window = MacOSWindow.init(size, title)
    
    return UInt64(window.windowNumber)
}

@_cdecl("update")
func ffiUpdate() -> Bool {
    if NSApp.windows.count == 0 {
        return true
    }
    while true {
        let event = NSApp.nextEvent(
            matching: NSEvent.EventTypeMask.any,
            until: nil,
            inMode: RunLoop.Mode.default,
            dequeue: true
        )
        if event == nil {
            break
        }

        NSApp.sendEvent(event!)
    }
    return false
}

#endif
