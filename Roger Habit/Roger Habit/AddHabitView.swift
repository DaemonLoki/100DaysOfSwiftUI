//
//  AddHabitView.swift
//  Roger Habit
//
//  Created by Stefan Blos on 18.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    
    @State private var habitName = ""
    @Environment(\.presentationMode) var presentationMode
    @Binding var habits: [Habit]
    
    var body: some View {
        Form {
            TextField("Enter name", text: self.$habitName)
            
            Button("Add") {
                self.habits.append(Habit(name: self.habitName, amount: 0))
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

/*
struct AddHabitView_Previews: PreviewProvider {
    
    @State private var habits = [Habit]()
    
    static var previews: some View {
        AddHabitView(habits: $habits)
    }
}
 */
