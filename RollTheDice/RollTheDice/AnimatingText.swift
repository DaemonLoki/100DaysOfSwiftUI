//
//  AnimatingText.swift
//  RollTheDice
//
//  Created by Stefan Blos on 09.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

extension View {
    func animatableNumber(_ number: CGFloat) -> some View {
        self.modifier(AnimatableNumber(count: number))
    }
}

struct AnimatingText: View {
    
    var result: CGFloat
    
    var body: some View {
        Text("\(Int(result))")
            .font(.largeTitle)
    }
    
}

struct AnimatableNumber: AnimatableModifier {
    var count: CGFloat = 0
    
    var animatableData: CGFloat {
        get { count }
        set { count = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(AnimatingText(result: count))
    }
}

struct AnimatingText_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingText(result: 5)
    }
}
