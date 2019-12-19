//
//  DetailView.swift
//  Roger Habit
//
//  Created by Stefan Blos on 19.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var habits: Habits
    let habit: Habit
    let habitIndex: Int
    
    init(habits: Habits, habit: Habit) {
        self.habits = habits
        self.habit = habit
        self.habitIndex = habits.items.firstIndex(of: habit) ?? 0
    }
        
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    CardBackgroundView(width: geo.size.width, height: CGFloat(300))
                    
                    Text(self.habits.items[self.habitIndex].name)
                        .font(.largeTitle)
                }
                
                Text("Total")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding()
                
                Text("\(self.habits.items[self.habitIndex].amount)")
                    .font(.system(size: 100.0, weight: .black))
                    .padding()
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button("+1") {
                        self.habits.increaseAmount(of: self.habitIndex)
                    }
                    .padding()
                }
            }
        }
    }
}

/*
struct DetailView_Previews: PreviewProvider {
    
    @State private var habits = Habits()
    
    static var previews: some View {
        DetailView(habit: habits.items[0] ?? Habit(name: "Test Habit", type: "Daily", amount: 3))
    }
}
*/
