//
//  Cetagory.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/23/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//

import Foundation
import RealmSwift

class Cetagory: Object {
    
    @objc dynamic var cetaroryName: String = ""
    
    let items = List<Item>()
}
