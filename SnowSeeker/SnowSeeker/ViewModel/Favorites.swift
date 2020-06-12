//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Stefan Blos on 12.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        resorts = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: saveKey) as? Data ?? Data()) as? Set<String> ?? []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        try? UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: resorts, requiringSecureCoding: false), forKey: saveKey)
    }
}
