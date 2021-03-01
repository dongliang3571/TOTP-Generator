//
//  MenuView.swift
//  totp_generator
//
//  Created by Dong Liang on 2/27/21.
//

import Foundation
import Cocoa

class MenuView: NSView {
    
    var addItemButton: NSButton
    var addItemPopover: NSPopover
    var quitButton: NSButton
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: NSRect) {
        
        let buttonWidht: Double = 30
        self.addItemButton = NSButton(frame: NSRect(x: 250, y: 10, width: buttonWidht, height: buttonWidht))
        self.addItemButton.image = NSImage(named: "add")?.tint(color: NSColor.white)
        self.addItemButton.isBordered = false
        
        self.quitButton = NSButton(frame: NSRect(x: 300, y: 10, width: buttonWidht, height: buttonWidht))
        self.quitButton.image = NSImage(named: "quit")!.tint(color: NSColor.red)
        self.quitButton.isBordered = false
        
        self.addItemPopover = AddItemPopover(width: 240, height: 200)
        super.init(frame: frame)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.darkGray.cgColor
        
        self.addSubview(self.addItemButton)
        self.addSubview(self.quitButton)
        
        self.addItemButton.target = self
        self.addItemButton.action = #selector(addItemButtonAction(_:))
        
        self.quitButton.target = self
        self.quitButton.action = #selector(quitButtonAction)
    }
    
    @objc func addItemButtonAction(_ sender: AnyObject?) {
        if self.addItemPopover.isShown {
            self.addItemPopover.performClose(sender)
        } else {
            self.addItemPopover.show(relativeTo: self.addItemButton.bounds, of: self.addItemButton, preferredEdge: NSRectEdge.minY)
//            self.addItemPopover.contentViewController?.view.window?.makeKey()
        }
    }
    
    @objc func quitButtonAction(_ sender: AnyObject?) {
        NSApplication.shared.terminate(self)
    }
}
