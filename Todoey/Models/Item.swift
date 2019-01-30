//
//  Item.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/21/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated = Date()
    
    var parentCategory = LinkingObjects(fromType: Cetagory.self, property: "items")
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
