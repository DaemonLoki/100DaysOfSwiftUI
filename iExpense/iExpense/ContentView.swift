//
//  ContentView.swift
//  iExpense
//
//  Created by Stefan Blos on 07.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
        .navigationBarItems(trailing:
            Button(action: {
                let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                self.expenses.items.append(expense)
            }) {
                Image(systemName: "plus")
            }
        )
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
