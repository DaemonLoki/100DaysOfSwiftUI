//
//  AnimationBindingView.swift
//  Animations
//
//  Created by Stefan Blos on 02.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AnimationBindingView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            .padding()
            
            Spacer()
            
            Button("Tap me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct AnimationBindingView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBindingView()
    }
}
