//
//  Item+CoreDataProperties.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/11/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var done: Bool
    @NSManaged public var toCetagory: CetagoryName?

}
