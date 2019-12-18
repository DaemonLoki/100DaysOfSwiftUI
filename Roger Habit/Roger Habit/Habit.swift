//
//  Habit.swift
//  Roger Habit
//
//  Created by Stefan Blos on 16.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import Foundation

struct Habit: Codable, Identifiable {
    let id = UUID()
    let name: String
    let amount: Int
}
