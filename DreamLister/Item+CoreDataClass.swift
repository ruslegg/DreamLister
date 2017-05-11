//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Ruslan Negrei on 5/11/17.
//  Copyright © 2017 Ruslan Negrei. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
