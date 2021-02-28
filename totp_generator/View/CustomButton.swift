//
//  CustomButton.swift
//  totp_generator
//
//  Created by Dong Liang on 2/27/21.
//

import Cocoa

class CustomButton: NSButton {

    var customAction: ((AnyObject?) -> Void)?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)

        self.wantsLayer = true
        self.isBordered = false
        self.layer?.cornerRadius = 10
        self.layer?.backgroundColor = NSColor.darkGray.cgColor
        self.font = NSFont(name: "Arial Bold", size: 15)
    }
    
    convenience init(frame: NSRect, title: String, titleColor: NSColor, customAction: ((_ sender: AnyObject?) -> Void)?) {
        self.init(frame: frame)
            
        self.title = title
        self.titleTextColor = titleColor
        self.action = #selector(buttonAction)
        self.target = self
        self.customAction = customAction
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonAction(sender: AnyObject?) {
        if let ca = customAction {
            ca(sender)
        }
    }
}
