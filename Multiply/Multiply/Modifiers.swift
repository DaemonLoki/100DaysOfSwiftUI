//
//  Modifiers.swift
//  Multiply
//
//  Created by Stefan Blos on 05.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct HeadlineLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(minWidth: 0, maxWidth: .infinity)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 40)
    }
}

struct CardView: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
    }
}

extension View {
    func headline() -> some View {
        self.modifier(HeadlineLabel())
    }
    
    func card(colored: Color = Color.init(.systemBackground)) -> some View {
        self.modifier(CardView(color: colored))
    }
}
