//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Matthew Wood on 2016-10-24.
//  Copyright © 2016 Matthew. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        // assigns current date when objects are created
        self.created = NSDate()
    }
}
