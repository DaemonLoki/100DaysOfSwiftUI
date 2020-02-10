//
//  String+Extensions.swift
//  CupcakeCorner
//
//  Created by Stefan Blos on 10.02.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation

extension String {
    
    var isOnlyWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
