//
//  Expenses.swift
//  iExpense
//
//  Created by Stefan Blos on 08.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
