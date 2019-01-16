//
//  TodoItem.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 12/26/18.
//  Copyright © 2018 A K M Saleh Sultan. All rights reserved.
//

import UIKit

class TodoItem: NSObject, Codable {
   
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
//    }
//
//    required  convenience init?(coder aDecoder: NSCoder) {
//        let name = aDecoder.decodeObject(forKey: "name") as! String
//        self.init(name: name)
//    }
//
 
    var name: String = ""
    var chacked: Bool = false
    override init() {
        
    }
    
    init(item_Data: NSSet) {
       // self.name = item_Data.
    }
    init(name: String) {
        self.name =  name
       // self.chacked = false
    }
    init(name: String, done: Bool){
        self.name = name
        self.chacked = done
    }
    
    init(itemData: Item){
        self.name = itemData.title!
        self.chacked = itemData.done
    }
    
    init(json: [String: String]){
        self.name = json[Contacts.TodoList.todoItem] as! String 
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
