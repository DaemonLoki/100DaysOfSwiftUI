//
//  User.swift
//  FriendFace
//
//  Created by Stefan Blos on 10.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let friends: [Friend]
}
