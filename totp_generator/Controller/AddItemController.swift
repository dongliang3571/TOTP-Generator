//
//  AddItemController.swift
//  totp_generator
//
//  Created by Dong Liang on 2/27/21.
//

import Cocoa

class AddItemController: NSViewController {

    var width: Double
    var height: Double
    
    var parentPopover: NSPopover
    var siteInputTextField: NSTextField
    var userInputTextField: NSTextField
    var secretInputTextField: NSTextField
    var saveButton: CustomButton
    var cancelButton: CustomButton
    
    init(width: Double, height: Double, popover: NSPopover) {
        self.width = width
        self.height = height
        self.parentPopover = popover
        
        let textFieldHeight = 30
        let leftPadding = 20
        siteInputTextField = NSTextField(frame: NSRect(x: leftPadding, y: 150, width: 200, height: textFieldHeight))
        siteInputTextField.wantsLayer = true
        userInputTextField = NSTextField(frame: NSRect(x: leftPadding, y: 100, width: 200, height: textFieldHeight))
        userInputTextField.wantsLayer = true
        secretInputTextField = NSTextField(frame: NSRect(x: leftPadding, y: 50, width: 200, height: textFieldHeight))
        secretInputTextField.wantsLayer = true

        self.saveButton = CustomButton(frame: NSRect(x: leftPadding, y: 10, width: 55, height: 30), title: "Save", titleColor: NSColor.white, customAction: nil)
        self.cancelButton = CustomButton(frame: NSRect(x: 165, y: 10, width: 55, height: 30), title: "Cancel", titleColor: NSColor.red, customAction: nil)

        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: self.width, height: self.height))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cornerRadius: CGFloat = 10
        self.view.addSubview(self.siteInputTextField)
        self.siteInputTextField.placeholderString = "Site"
        self.siteInputTextField.font = NSFont(name: "Arial", size: 20)
        self.siteInputTextField.layer?.cornerRadius = cornerRadius
        self.siteInputTextField.focusRingType = .none
        
        self.view.addSubview(self.userInputTextField)
        self.userInputTextField.placeholderString = "User"
        self.userInputTextField.font = NSFont(name: "Arial", size: 20)
        self.userInputTextField.layer?.cornerRadius = cornerRadius
        self.userInputTextField.focusRingType = .none
        
        self.view.addSubview(self.secretInputTextField)
        self.secretInputTextField.placeholderString = "Secret"
        self.secretInputTextField.font = NSFont(name: "Arial", size: 20)
        self.secretInputTextField.layer?.cornerRadius = cornerRadius
        self.secretInputTextField.focusRingType = .none
        
        self.view.addSubview(self.saveButton)
        self.saveButton.customAction = { (sender) in
            let siteInput = self.siteInputTextField.stringValue
            let userInput = self.userInputTextField.stringValue
            let secretInput = self.secretInputTextField.stringValue
            
            let userDefaults = UserDefaults.standard

            var existingItems = userDefaults.object(forKey: "items") as? [Dictionary<String, String>] ?? [Dictionary<String, String>]()
            
            existingItems.append(Item(site: siteInput, user: userInput, secret: secretInput).toDictionary())
            userDefaults.set(existingItems, forKey: "items")
            
            let nc = NotificationCenter.default
            nc.post(name: .itemsUpdated, object: nil)
            
            self.parentPopover.performClose(sender)
            
            // clear text
            self.siteInputTextField.stringValue = ""
            self.userInputTextField.stringValue = ""
            self.secretInputTextField.stringValue = ""
        }
        
        self.view.addSubview(self.cancelButton)
        self.cancelButton.customAction = { (sender) in
            self.parentPopover.performClose(sender)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
