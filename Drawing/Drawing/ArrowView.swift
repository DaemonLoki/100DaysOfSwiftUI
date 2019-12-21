//
//  ArrowView.swift
//  Drawing
//
//  Created by Stefan Blos on 15.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(CGRect(x: rect.midX / 2, y: rect.midY, width: rect.width / 2, height: rect.width / 2))
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.midY))
        
        return path
    }
}

struct ArrowView: View {
    
    @State private var widthOfLine: CGFloat = 2
    @State private var scaleAmount: CGFloat = 1
    @State private var rotationAngle: Double = 0
    @State private var strokeColor: Color = .red
    
    var body: some View {
        VStack(spacing: 20) {
            Arrow()
                .stroke(strokeColor, style: StrokeStyle(lineWidth: widthOfLine, lineCap: .round, lineJoin: .round))
                .transformEffect(CGAffineTransform(scaleX: scaleAmount, y: scaleAmount))
                .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 0, z: 1))
                .frame(width: 300, height: 300)
            
            Slider(value: $widthOfLine, in: 0...20, step: 0.5)
                .padding()
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                self.scaleAmount = 0.6
                self.rotationAngle = 720
                self.widthOfLine = 20
                self.strokeColor = .green
            }
            
        }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
