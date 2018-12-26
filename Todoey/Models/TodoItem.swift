//
//  TodoItem.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 12/26/18.
//  Copyright © 2018 A K M Saleh Sultan. All rights reserved.
//

import UIKit

class TodoItem {
    
    var itemName: String = ""
    
    init(name: String) {
        self.itemName =  name
    }
}

extension TodoItem{
    
    public class func getData() -> [TodoItem] {
        return [
        TodoItem(name: "MILK"),
        TodoItem(name: "CHOCKLATE"),
        TodoItem(name: "LIGHT BULB"),
        TodoItem(name: "DOG FOOD"),
        ]
    }
}
