//
//  ContentView.swift
//  BetterRest
//
//  Created by Stefan Blos on 27.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Form {
                    Section(header: Text("When do you want to wake up?")) {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    Section(header: Text("Desired amount of sleep?")) {
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                        .accessibility(label: Text("Selected \(sleepAmount) hours of desired sleep"))
                    }
                    
                    Section(header: Text("Daily coffee intake")) {
                        Picker("Number of cups", selection: $coffeeAmount) {
                            ForEach(0 ..< 21, id: \.self) {
                                Text("\($0) cup\($0 == 1 ? "" : "s")")
                            }
                        }
                    }
                }
                
                Text("Your ideal bedtime")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(calculateBedTime())
                    .font(.largeTitle)
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> String {
        let model = SleepCalculator()
        
        // get date elements
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        var bedTime: String
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            bedTime = formatter.string(from: sleepTime)
        } catch {
            // Uh-oh something went wrong
            bedTime = "Sorry, there was a problem calculating your bedtime."
        }
        
        return bedTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
