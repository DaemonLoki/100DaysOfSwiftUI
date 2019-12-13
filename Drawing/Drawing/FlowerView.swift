//
//  FlowerView.swift
//  Drawing
//
//  Created by Stefan Blos on 13.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct FlowerView: View {
    
    struct Flower: Shape {
        // how much to move this petal away from the center
        var petalOffset: Double = -20
        
        // how wide to make each petal
        var petalWidth: Double = 100
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            // count from 1 to .pi * 2, moving by .pi / 8 each time
            for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
                
                // rotate the petal by current value of our loop
                let rotation = CGAffineTransform(rotationAngle: number)
                
                // move the petal to be at the center of our view
                let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
                
                // create path for this petal using our properties plus a fixed Y and height
                let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
                
                // apply our rotation / position transformation to the petal
                let rotatedPetal = originalPetal.applying(position)
                
                // add it to our main path
                path.addPath(rotatedPetal)
            }
            
            return path
        }
    }
    
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                //.stroke(Color.red, lineWidth: 1)
                .fill(Color.red, style: FillStyle(eoFill: true))
                .padding()
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}
