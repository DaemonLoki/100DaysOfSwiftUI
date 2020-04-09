//
//  FilterCard.swift
//  Instafilter
//
//  Created by Stefan Blos on 09.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct FilterCard: View {
    
    @Binding var intensity: Double
    @Binding var radius: Double
    @Binding var inputScale: Double
    
    var currentFilter: CIFilter
    var cardWidth: CGFloat
    
    @State private var filterCardOffset: CGFloat = 300
    
    var body: some View {
        Group {
            VStack(spacing: 20) {
                if self.currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    ValueSlider(title: "Intensity", value: $intensity)
                }
                
                if self.currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    ValueSlider(title: "Radius key", value: $radius)
                }
                
                if self.currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    ValueSlider(title: "Input scale", value: $inputScale)
                }
            }
            .padding(30)
            .background(Rectangle()
            .fill(Color(red: 82 / 255.0, green: 45 / 255.0, blue: 91 / 255.0).opacity(0.8))
            .frame(width: cardWidth, height: 400)
            .cornerRadius(20)
                .offset(x: 0, y: 100)
            .shadow(radius: 10))
            .animation(.easeInOut)
        }
        .offset(x: 0, y: self.filterCardOffset)
        .animation(Animation.easeInOut.speed(0.5))
        .onAppear {
            self.filterCardOffset = 0
        }
    }
}

struct FilterCard_Previews: PreviewProvider {
    static var previews: some View {
        FilterCard(intensity: Binding.constant(0.5), radius: Binding.constant(0.8), inputScale: Binding.constant(0.2), currentFilter: CIFilter.unsharpMask(), cardWidth: 350)
    }
}
