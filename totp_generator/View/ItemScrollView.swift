//
//  ItemScrollView.swift
//  totp_generator
//
//  Created by Dong Liang on 2/27/21.
//

import Cocoa

class ItemScrollView: NSScrollView, NSTableViewDelegate, NSTableViewDataSource {

    var tableView: NSTableView
    var tableColumn: NSTableColumn
    var items: [Item]
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame: NSRect) {
        self.tableView = NSTableView()
        self.items = [Item]()
        self.tableColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "col"))
        
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = NSColor.clear
        self.drawsBackground = false
        
        self.tableView.headerView = nil
        
        self.tableView.backgroundColor = NSColor.clear
        self.tableView.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)

        
        self.tableColumn.minWidth = 200
        self.tableView.addTableColumn(self.tableColumn)
        
        
        
        self.tableView.frame = self.bounds
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.documentView = tableView
        self.hasHorizontalScroller = false
        self.hasVerticalScroller = true

        // listen to new items created events
        NotificationCenter.default.addObserver(self, selector: #selector(reloadItemsFromUserDefault), name: .itemsUpdated, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: NSTableView, didAdd rowView: NSTableRowView, forRow row: Int) {
        rowView.selectionHighlightStyle = .none
    }
  
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = ItemTableCellView(frame: NSRect.zero, item: items[row])

        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 80
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.items.count
    }

    @objc func reloadItemsFromUserDefault() {
        let userDefaults = UserDefaults.standard
        let itemsDictionaries = userDefaults.object(forKey: "items") as? [Dictionary<String, String>]

        var newItems = [Item]()

        if let allItems = itemsDictionaries {
            for item in allItems {
                newItems.append(Item.fromDictionary(dict: item))
            }
        }

        self.items = newItems
        self.tableView.reloadData()
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
}
