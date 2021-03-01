//
//  ItemTableCellView.swift
//  totp_generator
//
//  Created by Dong Liang on 2/27/21.
//

import Cocoa

class ItemTableCellView: NSTableCellView {

    var centerView: NSView

    var itemSiteTextField: ItemPropertyTextField
    var itemUserTextField: ItemPropertyTextField
    var itemCodeTextField: ItemPropertyTextField

    var item: Item?
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }

    override init(frame: NSRect) {
        self.centerView = NSView(frame: NSRect(x: 13, y: 10, width: 324, height: 60))
        self.itemSiteTextField = ItemPropertyTextField(frame: NSRect(x: 30, y: 20, width: 120, height: 30))
        self.itemUserTextField = ItemPropertyTextField(frame: NSRect(x: 30, y: 0, width: 120, height: 30))
        self.itemCodeTextField = ItemPropertyTextField(frame: NSRect(x: 225, y: 10, width: 120, height: 30))
        super.init(frame: frame)

        self.itemSiteTextField.textColor = NSColor.white
        self.itemUserTextField.textColor = NSColor.white
        self.itemCodeTextField.textColor = NSColor.blue

        self.centerView.wantsLayer = true
        self.centerView.layer?.backgroundColor = NSColor.darkGray.cgColor
        self.centerView.layer?.cornerRadius = 15

        self.centerView.addSubview(self.itemSiteTextField)
        self.centerView.addSubview(self.itemUserTextField)
        self.centerView.addSubview(self.itemCodeTextField)

        self.addSubview(self.centerView)
        self.wantsLayer = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(frame: NSRect, item: Item) {
        self.init(frame: frame)
        self.item = item
        self.itemSiteTextField.stringValue = item.site
        self.itemUserTextField.stringValue = item.user
        self.itemCodeTextField.stringValue = item.now()
    }

    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)

        if let i = item {

            self.copyTextFieldContentToPasteBoard(contentToCopy: i.now())
            NSAnimationContext.runAnimationGroup({ (context) in
                context.allowsImplicitAnimation = true
                context.duration = 0.2
                self.centerView.animator().layer!.backgroundColor = NSColor.white.cgColor

                self.centerView.frame.origin = CGPoint(x: 13, y: 14)
            }) {
                NSAnimationContext.runAnimationGroup ({ (context) in
                    context.allowsImplicitAnimation = true
                    context.duration = 0.2
                    self.centerView.animator().layer!.backgroundColor = NSColor.darkGray.cgColor

                    self.centerView.frame.origin = CGPoint(x: 13, y: 6)
                }) {
                    NSAnimationContext.runAnimationGroup ({ (context) in
                        context.allowsImplicitAnimation = true
                        context.duration = 0.2
                        self.centerView.animator().layer!.backgroundColor = NSColor.darkGray.cgColor

                        self.centerView.frame.origin = CGPoint(x: 13, y: 10)
                    }) {
                        self.itemCodeTextField.stringValue = i.now()
                    }
                }
            }
        }
    }

    func copyTextFieldContentToPasteBoard(contentToCopy: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.setString(contentToCopy, forType: .string)
        self.itemCodeTextField.stringValue = "Copied!"
    }

    override func rightMouseUp(with event: NSEvent) {
        super.rightMouseUp(with: event)

        let deleteMenuItem = NSMenuItem(title: "Delete", action: #selector(deleteMenuItemAction), keyEquivalent: "")
        let copyMenuItem = NSMenuItem(title: "Copy", action: #selector(copyMenuItemAction), keyEquivalent: "")

        deleteMenuItem.title = "Delete"
        deleteMenuItem.isEnabled = true

        copyMenuItem.title = "Copy"
        copyMenuItem.isEnabled = true

        let mainMenu = NSMenu()
        mainMenu.addItem(deleteMenuItem)
        mainMenu.addItem(copyMenuItem)

        NSMenu.popUpContextMenu(mainMenu, with: event, for: self)
    }

    @objc func deleteMenuItemAction() {
        if let i = item {
            let userDefaults = UserDefaults.standard


            let existingItems = userDefaults.object(forKey: "items") as? [Dictionary<String, String>] ?? [Dictionary<String, String>]()

            var newItems = [Dictionary<String, String>]()

            for existingItem in existingItems {
                if existingItem["uuid"] == i.uuid {
                    continue
                } else {
                    newItems.append(existingItem)
                }
            }

            userDefaults.set(newItems, forKey: "items")

            let nc = NotificationCenter.default
            nc.post(name: .itemsUpdated, object: nil)
        }
    }

    @objc func copyMenuItemAction() {
        if let i = item {
            self.copyTextFieldContentToPasteBoard(contentToCopy: i.now())
        }
    }
}
