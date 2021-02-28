//
//  ImageExtension.swift
//  totp_generator
//
//  Created by Dong Liang on 2/27/21.
//

import Foundation
import Cocoa

extension NSImage {
    func tint(color: NSColor) -> NSImage {
        let image = self.copy() as! NSImage
        image.lockFocus()

        color.set()

        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        imageRect.fill(using: .sourceAtop)

        image.unlockFocus()

        return image
    }
}

extension NSButton {
 
    var titleTextColor : NSColor {
        get {
            let attrTitle = self.attributedTitle
            return attrTitle.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as! NSColor
        }
        
        set(newColor) {
            let attrTitle = NSMutableAttributedString(attributedString: self.attributedTitle)
            let titleRange = NSMakeRange(0, self.title.count)
 
            attrTitle.addAttributes([NSAttributedString.Key.foregroundColor: newColor], range: titleRange)
            self.attributedTitle = attrTitle
        }
    }
    
}

extension Notification.Name {
    static var itemsUpdated: Notification.Name {
        return .init(rawValue: "Items.updated")
    }
}

extension Calendar {
    var getSecondsNow: Int {
        return  self.component(.second, from: Date())
    }
}
