//
//  ConversionOption.swift
//  Unit Converter
//
//  Created by Stefan Blos on 23.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import Foundation

struct ConversionOption: Hashable, Identifiable {
    var id = UUID()
    let name: String
    let units: [ConversionUnit]
}
