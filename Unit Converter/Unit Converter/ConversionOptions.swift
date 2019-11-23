//
//  ConversionOptions.swift
//  Unit Converter
//
//  Created by Stefan Blos on 23.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import Foundation

struct ConversionOptions {
    
    static let options: [ConversionOption] = [
        
        ConversionOption(name: "Temperatures", units: [
            ConversionUnit(title: "Celsius", unit: UnitTemperature.celsius),
            ConversionUnit(title: "Fahrenheit", unit: UnitTemperature.fahrenheit),
            ConversionUnit(title: "Kelvin", unit: UnitTemperature.kelvin)
        ]),
        
        ConversionOption(name: "Distances", units: [
            ConversionUnit(title: "Meters", unit: UnitLength.meters),
            ConversionUnit(title: "Kilometers", unit: UnitLength.kilometers),
            ConversionUnit(title: "Feet", unit: UnitLength.feet),
            ConversionUnit(title: "Yards", unit: UnitLength.yards),
            ConversionUnit(title: "Miles", unit: UnitLength.miles)
        ]),
        
        ConversionOption(name: "Times", units: [
            ConversionUnit(title: "Milliseconds", unit: UnitDuration.milliseconds),
            ConversionUnit(title: "Seconds", unit: UnitDuration.seconds),
            ConversionUnit(title: "Minutes", unit: UnitDuration.minutes),
            ConversionUnit(title: "Hours", unit: UnitDuration.hours),
        ]),
        
        ConversionOption(name: "Volumes", units: [
            ConversionUnit(title: "Milliliters", unit: UnitVolume.milliliters),
            ConversionUnit(title: "Liters", unit: UnitVolume.liters),
            ConversionUnit(title: "Cups", unit: UnitVolume.cups),
            ConversionUnit(title: "Pints", unit: UnitVolume.pints),
            ConversionUnit(title: "Gallons", unit: UnitVolume.gallons),
        ])
    ]
    
}
