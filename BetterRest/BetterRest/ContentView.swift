//
//  ContentView.swift
//  BetterRest
//
//  Created by Stefan Blos on 27.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        let now = Date()
        let tomorrow = Date().addingTimeInterval(86400)
        let range = now ... tomorrow
        
        return Form {
            Section(header: Text("Amount of sleep")) {
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g")")
                }
            }
            
            Section(header: Text("Enter a date")) {
                DatePicker("Enter a date", selection: $wakeUp, in: Date()..., displayedComponents: .hourAndMinute)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
