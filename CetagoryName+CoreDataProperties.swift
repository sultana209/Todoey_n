//
//  CetagoryName+CoreDataProperties.swift
//  Todoey
//
//  Created by A K M Saleh Sultan on 1/11/19.
//  Copyright © 2019 A K M Saleh Sultan. All rights reserved.
//
//

import Foundation
import CoreData


extension CetagoryName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CetagoryName> {
        return NSFetchRequest<CetagoryName>(entityName: "CetagoryName")
    }

    @NSManaged public var cetName: String?
    @NSManaged public var toItems: NSSet

}

// MARK: Generated accessors for toItems
extension CetagoryName {

    @objc(addToItemsObject:)
    @NSManaged public func addToToItems(_ value: Item)

    @objc(removeToItemsObject:)
    @NSManaged public func removeFromToItems(_ value: Item)

    @objc(addToItems:)
    @NSManaged public func addToToItems(_ values: NSSet)

    @objc(removeToItems:)
    @NSManaged public func removeFromToItems(_ values: NSSet)

}
