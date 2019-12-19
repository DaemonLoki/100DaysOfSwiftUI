//
//  CardBackgroundView.swift
//  Roger Habit
//
//  Created by Stefan Blos on 18.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct MyBezier: Shape {
    
    var firstX: CGFloat
    var secondX: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(firstX, secondX) }
        set {
            firstX = newValue.first
            secondX = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 1))
        path.addCurve(to: CGPoint(x: 1, y: 0.6), control1: CGPoint(x: firstX, y: 0.2), control2: CGPoint(x: secondX, y: 1))
        path.addLine(to: CGPoint(x: 1, y: 1))
        
        // Figure out how much bigger we need to make our path in order for it to fill the available space without clipping.
        let multiplierX = rect.width
        let multiplierY = rect.height

        // Create an affine transform that uses the multiplier for both dimensions equally.
        let transform = CGAffineTransform(scaleX: multiplierX, y: multiplierY)
        
        return path.applying(transform)
    }
}

struct CardBackgroundView: View {
    
    @State private var x_1: CGFloat = 0.3
    @State private var x_2: CGFloat = 0.6
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: width, height: height)
            
            MyBezier(firstX: x_1, secondX: x_2)
                .fill(Color.orange)
                .frame(width: width, height: height)
                .opacity(1.0)
        }
        .cornerRadius(20)
        .clipped()
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                self.x_1 += 1
                self.x_2 += 1
            }
            
        }
    }
}

struct CardBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackgroundView(width: 300, height: 300)
    }
}
