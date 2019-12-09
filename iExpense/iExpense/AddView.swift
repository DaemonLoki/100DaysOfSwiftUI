//
//  AddView.swift
//  iExpense
//
//  Created by Stefan Blos on 09.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var amount = ""
    @State private var type = "Personal"
    
    @State private var showingAlert = false
    
    static let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Expense name", text: $name)
                }
                
                Section(header: Text("Type of expense")) {
                    Picker("Type", selection: $type) {
                        ForEach(Self.types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount")) {
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                }
                
                
            }
            .navigationBarTitle("Add Expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingAlert.toggle()
                }
            })
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Wrong amount"), message: Text("Please enter a valid amount of money as an expense."))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
