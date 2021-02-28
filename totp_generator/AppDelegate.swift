//
//  AppDelegate.swift
//  totp_generator
//
//  Created by Dong Liang on 2/26/21.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItemController: StatusItemController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let width: Double = 350
        let height: Double = 500
        self.statusItemController = StatusItemController(statuItemPopover: StatusItemPopover(width: width, height: height))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

