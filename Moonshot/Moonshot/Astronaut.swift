//
//  Astronaut.swift
//  Moonshot
//
//  Created by Stefan Blos on 11.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
