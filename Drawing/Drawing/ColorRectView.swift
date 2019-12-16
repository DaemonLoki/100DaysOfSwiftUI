//
//  ColorRectView.swift
//  Drawing
//
//  Created by Stefan Blos on 16.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ColorRectView: View {
    @State private var colorRect = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            ColorCyclingRectangle(amount: self.colorRect)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorRect)
                .padding()
        }
    }
}

struct ColorRectView_Previews: PreviewProvider {
    static var previews: some View {
        ColorRectView()
    }
}
