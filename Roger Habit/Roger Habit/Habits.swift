//
//  Habits.swift
//  Roger Habit
//
//  Created by Stefan Blos on 18.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import Foundation

class Habits: ObservableObject {
    @Published var items: [Habit] {
        didSet {
            save(items)
        }
    }
    
    init() {
        self.items = []
        self.items = load()
    }
    
    func save(_ items: [Habit]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
    
    func load() -> [Habit] {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: items) {
                return decoded
            }
        }
        return []
    }
    
    func getHabit(by id: UUID) -> Habit? {
        items.first { (habit) -> Bool in
            habit.id == id
        }
    }
    
    func increaseAmount(of index: Int, by amount: Int = 1) {
        var k = items[index]
        k.amount += 1
        items[index] = k
    }
}
