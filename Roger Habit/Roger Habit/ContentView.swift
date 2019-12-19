//
//  ContentView.swift
//  Roger Habit
//
//  Created by Stefan Blos on 16.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var habits = Habits()
    @State private var showingSheet = false
    
    let rowHeight: CGFloat = 150
    let verticalPaddingSize: CGFloat = 10
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List(habits.items) { habit in
                GeometryReader { geo in
                    VStack {
                        NavigationLink(destination: DetailView(habits: self.habits, habit: habit)) {
                            EmptyView()
                        }
                        .layoutPriority(0)
                        
                        ZStack {
                            CardBackgroundView(width: geo.size.width, height: self.calculateElementHeight(withFactor: 2))
                        
                            Text(habit.name)
                        }
                        .layoutPriority(1)
                    }
                    .frame(width: geo.size.width, height: self.calculateElementHeight(withFactor: 3))
                    //.cornerRadius(10)
                    .clipped()
                    .padding(.vertical, self.verticalPaddingSize)
                    .padding(.horizontal)
                }
            }
            .environment(\.defaultMinListRowHeight, self.rowHeight)
            .navigationBarTitle("Roger Habit")
            .navigationBarItems(trailing:
                Button("Add") {
                    self.showingSheet = true
                }
            )
            .sheet(isPresented: $showingSheet) {
                AddHabitView(habits: self.habits)
            }
        }
    }
    
    func calculateElementHeight(withFactor factor: Int) -> CGFloat {
        return self.rowHeight - (CGFloat(factor) * self.verticalPaddingSize)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
