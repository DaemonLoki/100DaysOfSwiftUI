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
    let startingX: CGFloat
    let endingX: CGFloat
    
    init(firstX: CGFloat, secondX: CGFloat, starting: CGFloat, ending: CGFloat) {
        self.firstX = firstX + CGFloat.random(in: -1...1)
        self.secondX = secondX + CGFloat.random(in: -1...1)
        self.startingX = starting
        self.endingX = ending
    }
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(firstX, secondX) }
        set {
            firstX = newValue.first
            secondX = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: startingX, y: 1))
        path.addCurve(to: CGPoint(x: endingX, y: 0.6), control1: CGPoint(x: firstX, y: 0.0), control2: CGPoint(x: secondX, y: 1.4))
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
    
    @State private var x_1: CGFloat = 0.2
    @State private var x_2: CGFloat = 0.8
    
    let width: CGFloat
    let height: CGFloat
    let radius: CGFloat
    let bgColor: Color
    let curveColor: Color
    
    init(width: CGFloat, height: CGFloat, radius: CGFloat = 20, bgColor: Color = .blue, curveColor: Color = .orange) {
        self.width = width
        self.height = height
        self.radius = radius
        self.bgColor = bgColor
        self.curveColor = curveColor
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(self.bgColor)
                .frame(width: width, height: height)
            
            ForEach(0 ..< 3) { _ in
                MyBezier(firstX: self.x_1, secondX: self.x_2, starting: self.generateStarting(), ending: self.generateEnding())
                    .fill(self.curveColor)
                    .frame(width: self.width, height: self.height)
                    .opacity(0.4)
            }
        }
        .cornerRadius(self.radius)
        .clipped()
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                self.x_1 += CGFloat.random(in: 0...1)
                self.x_2 += CGFloat.random(in: 0...1)
            }
            
        }
    }
    
    func generateStarting() -> CGFloat {
        return -0.5 + CGFloat.random(in: -1...0.5)
    }
    
    func generateEnding() -> CGFloat {
        return 1.0 + CGFloat.random(in: 0...0.5)
    }
}

struct CardBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackgroundView(width: 300, height: 300)
    }
}
