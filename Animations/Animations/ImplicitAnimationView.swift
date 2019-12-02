//
//  ImplicitAnimationView.swift
//  Animations
//
//  Created by Stefan Blos on 02.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ImplicitAnimationView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            // self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .overlay(Circle()
            .stroke(Color.red)
            .scaleEffect(animationAmount)
            .opacity(Double(2 - animationAmount))
            .animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: false)
            )
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}

struct ImplicitAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ImplicitAnimationView()
    }
}
