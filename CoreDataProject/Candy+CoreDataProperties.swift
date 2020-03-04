//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Stefan Blos on 04.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
    
}
