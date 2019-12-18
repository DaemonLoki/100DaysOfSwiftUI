//
//  ContentView.swift
//  Roger Habit
//
//  Created by Stefan Blos on 16.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // TODO load data from UserDefaults
    @State private var habits = [Habit]()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List(habits) { habit in
                Text(habit.name)
            }
        .navigationBarTitle("Roger Habit")
        .navigationBarItems(trailing:
            Button("Add") {
                self.showingSheet = true
            })
            .sheet(isPresented: $showingSheet) {
                AddHabitView(habits: self.$habits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
