//
//  SpecialEffectsView.swift
//  Drawing
//
//  Created by Stefan Blos on 14.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct SpecialEffectsView: View {
    
    @State private var amount: CGFloat = 0
    @State private var currentRotation: Double = 0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                .fill(Color.blue)
                .frame(width: 200 * amount)
                .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            .rotationEffect(.degrees(currentRotation))
            .onAppear {
                withAnimation(Animation.interactiveSpring().speed(0.2).repeatForever()) {
                    self.currentRotation = 360
                }
                self.currentRotation = 360
            }
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SpecialEffectsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectsView()
    }
}
