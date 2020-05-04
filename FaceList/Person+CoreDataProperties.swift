//
//  Person+CoreDataProperties.swift
//  FaceList
//
//  Created by Stefan Blos on 28.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageId: String?
    
    public var wrappedName: String {
        name ?? "Unkown Name"
    }
    
    public var wrappedImageId: String {
        imageId ?? "Wave006"
    }

}
