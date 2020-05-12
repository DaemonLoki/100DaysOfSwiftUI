//
//  Prospect.swift
//  HotProspects
//
//  Created by Stefan Blos on 12.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
}
