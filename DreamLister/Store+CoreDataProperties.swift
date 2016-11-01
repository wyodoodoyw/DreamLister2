//
//  Store+CoreDataProperties.swift
//  DreamLister
//
//  Created by Matthew Wood on 2016-10-24.
//  Copyright © 2016 Matthew. All rights reserved.
//

import Foundation
import CoreData

extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store");
    }

    @NSManaged public var name: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItem: Item?

}
