//
//  Modifiers.swift
//  iExpense
//
//  Created by Stefan Blos on 09.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import Foundation
import SwiftUI

struct AmountModifier: ViewModifier {
    let price: Int
    
    func body(content: Content) -> some View {
        if price < 10 {
            return content
                .font(.caption)
        } else if price < 100 {
            return content
                .font(.subheadline)
        } else {
            return content
                .font(.headline)
        }
    }
}

extension View {
    func amountStyle(for amount: Int) -> some View {
        self.modifier(AmountModifier(price: amount))
    }
}
