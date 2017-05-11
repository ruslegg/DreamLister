//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Ruslan Negrei on 5/11/17.
//  Copyright © 2017 Ruslan Negrei. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
