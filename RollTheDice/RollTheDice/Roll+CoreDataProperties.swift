//
//  Roll+CoreDataProperties.swift
//  RollTheDice
//
//  Created by Stefan Blos on 06.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var id: UUID
    @NSManaged public var result: Int16
    @NSManaged public var numberOfSides: Int16
    @NSManaged public var timeRolled: Date
    
    var wrappedResult: Int {
        return Int(result)
    }
    
    var wrappedNumberOfSides: Int {
        return Int(numberOfSides)
    }

}
