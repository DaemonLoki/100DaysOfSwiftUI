//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Stefan Blos on 08.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//
import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
