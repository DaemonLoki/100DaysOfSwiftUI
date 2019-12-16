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
    var body: some View {
        VStack(spacing: 20) {
            Arrow()
                .stroke(Color.red, style: StrokeStyle(lineWidth: widthOfLine, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
            
            Slider(value: $widthOfLine, in: 0...20, step: 0.5)
                .padding()
        }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
