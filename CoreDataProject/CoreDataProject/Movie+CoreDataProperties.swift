//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Stefan Blos on 21.02.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

}
