//
//  File.swift
//  totp_generator
//
//  Created by Dong Liang on 2/26/21.
//

import Foundation
import Cocoa

class StatusItemController {
    
    let statusItem: NSStatusItem!
    var popover: NSPopover!
    
    var title: String {
        get {
            return statusItem.button?.title ?? ""
        }
        set {
            statusItem.button?.title = newValue
        }
    }
    
    init(statusItem: NSStatusItem) {
        self.statusItem = statusItem
    }
    
    convenience init(statuItemPopover: NSPopover) {
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.init(statusItem: item)
        self.popover = statuItemPopover
        
        self.statusItem.button!.image = NSImage(named: "totp_icon")
        self.statusItem.button!.target = self
        self.statusItem.button!.action = #selector(togglePopover(_:))
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusItem.button {
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
//                NSApplication.shared.activate(ignoringOtherApps: true)
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
//                self.popover.contentViewController?.view.window?.makeKey()
            }
        }
    }
}
