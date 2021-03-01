//
//  AddItemPopover.swift
//  totp_generator
//
//  Created by Dong Liang on 2/27/21.
//

import Cocoa

class AddItemPopover: NSPopover {
    
    override init() {
        super.init()
    }
    
    convenience init(width: Double, height: Double) {
        self.init()
        self.behavior = .transient
        self.contentSize = NSSize(width: width, height: height)
        self.contentViewController = AddItemController(width: width, height: height, popover: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
