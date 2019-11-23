//
//  ConversionView.swift
//  Unit Converter
//
//  Created by Stefan Blos on 23.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ConversionView: View {
    
    let title: String
    let units: [ConversionUnit]
    
    @State private var firstUnit = 0
    @State private var secondUnit = 1
    @State private var initialUnit = "0"
    
    private var conversionResult: Double {
        let initialValue = Measurement(value: Double(initialUnit) ?? 0, unit: units[firstUnit].unit)
        return initialValue.converted(to: units[secondUnit].unit).value
    }
    
    var body: some View {
        
        Form {
            Section(header: Text("Convert from")) {
                Picker("First unit", selection: $firstUnit) {
                    ForEach(0 ..< units.count) {
                        Text("\(self.units[$0].title)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Value", text: $initialUnit)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Convert to")) {
                Picker("Second unit", selection: $secondUnit) {
                    ForEach(0 ..< units.count) {
                        Text("\(self.units[$0].title)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text("\(conversionResult, specifier: "%.3f")")
            }
        }
        .navigationBarTitle(title)
    }
}

struct ConversionView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView(title: "Temperatures", units: [
            ConversionUnit(title: "Celsius", unit: UnitTemperature.celsius), ConversionUnit(title: "Fahrenheit", unit: UnitTemperature.fahrenheit), ConversionUnit(title: "Kelvin", unit: UnitTemperature.kelvin)
        ])
    }
}
