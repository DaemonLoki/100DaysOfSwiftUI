//
//  ModelUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Stefan Blos on 24.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//
//

import Foundation
import CoreData


extension ModelUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModelUser> {
        return NSFetchRequest<ModelUser>(entityName: "ModelUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var id: String?
    @NSManaged public var friends: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedMail: String {
        email ?? "Unknown"
    }
    
    public var wrappedAge: Int {
        Int(age) ?? 0
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown"
    }
    
    public var wrappedAbout: String {
        about ?? "Unknown"
    }
    
    public var wrappedId: String {
        id ?? "Unknown"
    }
    
    public var wrappedFriends: [ModelFriend] {
        var friendsArray: [ModelFriend] = []
        for friend in friends ?? [] {
            friendsArray.append(friend as! ModelFriend)
        }
        return friendsArray
    }

}

// MARK: Generated accessors for friends
extension ModelUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: ModelFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: ModelFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
