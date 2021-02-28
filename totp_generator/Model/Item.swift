//
//  Item.swift
//  totp_generator
//
//  Created by Dong Liang on 2/26/21.
//

import Foundation


class Item: TOTP {
    
    var site: String
    var user: String
    var code: String?
    var uuid: String
    
    init(site: String, user: String, secret: String) {
        self.site = site
        self.user = user
        self.uuid = UUID().uuidString
        super.init(secret: secret)
    }
    
    func toDictionary() -> Dictionary<String, String> {
        var ret = Dictionary<String, String>()
        ret.updateValue(self.site, forKey: "site")
        ret.updateValue(self.user, forKey: "user")
        ret.updateValue(self.secret, forKey: "secret")
        ret.updateValue(self.uuid, forKey: "uuid")

        return ret
    }
    
    static func fromDictionary(dict: Dictionary<String, String>) -> Item {
        let item = Item(site: "", user: "", secret: "")
        item.site = dict["site"] ?? ""
        item.user = dict["user"] ?? ""
        item.secret = dict["secret"] ?? ""
        item.uuid = dict["uuid"] ?? ""
        
        return item
    }

    override func now() -> String {
        self.code = super.now()

        return self.code!
    }

    func isSame(item: Item) -> Bool {
        return self.uuid == item.uuid
    }
}
