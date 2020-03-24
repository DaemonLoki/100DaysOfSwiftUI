//
//  ModelFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Stefan Blos on 24.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//
//

import Foundation
import CoreData


extension ModelFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModelFriend> {
        return NSFetchRequest<ModelFriend>(entityName: "ModelFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    
    public var wrappedId: String {
        id ?? "Unknown"
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }

}
