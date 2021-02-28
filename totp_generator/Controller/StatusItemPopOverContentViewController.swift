//
//  PopOverContentViewController.swift
//  totp_generator
//
//  Created by Dong Liang on 2/26/21.
//

import Foundation
import Cocoa

class StatusItemPopOverContentViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var width: Double
    var height: Double
    var menuView: NSView!
    var countDownView: NSView!
    var countDownText: NSTextView!
    var scrollView: ItemScrollView!
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: self.width, height: self.height))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuView = MenuView(frame: NSRect(x: 0, y: 0, width: self.width, height: 50))
        
        let cdv_height: Double = 65
        let left_padding: Double = 130
        self.countDownView = NSView(frame: NSRect(x: left_padding, y: self.height - 20 - cdv_height , width: self.width - left_padding*2, height: cdv_height))
        self.countDownView.wantsLayer = true
        self.countDownView.layer?.cornerRadius = CGFloat(30)
        self.countDownView.layer?.backgroundColor = NSColor.darkGray.cgColor

        self.countDownText = NSTextView(frame: NSRect(x: CGFloat.zero, y: CGFloat.zero , width: self.countDownView.layer!.frame.width, height: self.countDownView.layer!.frame.height))
        self.countDownText.isEditable = false
        self.countDownText.font = NSFont(name: "Arial Bold", size: 55)
        self.countDownText.alignment = .center
        self.countDownText.backgroundColor = NSColor.darkGray
        self.countDownText.string = String(calculateCountDown())
        
        self.scrollView = ItemScrollView()
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView!, attribute: .top, relatedBy: .equal, toItem: self.countDownView, attribute: .bottom, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 15)) // 15 to hide scroll bar
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView!, attribute: .bottom, relatedBy: .equal, toItem: self.menuView, attribute: .top, multiplier: 1.0, constant: 0))
        
        self.view.addSubview(self.menuView)
        self.view.addSubview(self.countDownView)
        self.countDownView.addSubview(countDownText)
        self.view.addSubview(self.scrollView)

        self.scrollView.reloadItemsFromUserDefault()

        // start a period job to update the countdown
        self.startTimerJob()
    }

    func calculateCountDown() -> Int {
        let seconds = Calendar.current.getSecondsNow
        
        var countDownToWrite = 1
        var secondsToSubstruct = 0
        
        if seconds < 30 {
            secondsToSubstruct = seconds
            countDownToWrite = 30 - secondsToSubstruct
        } else {
            secondsToSubstruct = seconds - 30
            countDownToWrite = 30 - secondsToSubstruct
        }
        
        return countDownToWrite
    }
    
    func startTimerJob() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let countDown = self.calculateCountDown()
            self.countDownText.string = String(countDown)

            if countDown == 30 {
                self.scrollView.tableView.reloadData()
            }
        }

        // add to runloop so it won't stop working when NSMenu is popped up
        RunLoop.main.add(timer, forMode: .common)
    }
}
