//
//  ItemPropertyTextField.swift
//  totp_generator
//
//  Created by Dong Liang on 2/28/21.
//

import Cocoa

class ItemPropertyTextField: NSTextField {

    var parentView: ItemTableCellView!

    override init(frame: NSRect) {
        super.init(frame: frame)

        let fontName = "Arial"
        
        self.isBordered = false
        self.font = NSFont(name: fontName, size: 20)
        self.textColor = NSColor.white
        self.isSelectable = false
        self.isEditable = false
        self.wantsLayer = true
        self.isBezeled = false
        self.drawsBackground = false
    }

    convenience init(frame: NSRect, parentView: ItemTableCellView) {
        self.init(frame: frame)

        self.parentView = parentView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: NSPoint) -> NSView? {
        return parentView
    }
}
