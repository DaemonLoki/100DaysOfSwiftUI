//
//  ContentView.swift
//  Drawing
//
//  Created by Stefan Blos on 12.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            
            return path
        }
    }
    
    struct Arc: Shape {
        var startAngle: Angle
        var endAngle: Angle
        var clockwise: Bool
        
        func path(in rect: CGRect) -> Path {
            let rotationAdjustment = Angle.degrees(90)
            let modifiedStart = startAngle - rotationAdjustment
            let modifiedEnd = endAngle - rotationAdjustment
            
            var path = Path()
            
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
            
            return path
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Triangle()
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 200, height: 200)
            
            Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 200, height: 200)
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
