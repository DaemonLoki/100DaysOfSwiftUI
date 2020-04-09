//
//  FilterButton.swift
//  Instafilter
//
//  Created by Stefan Blos on 09.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct FilterButton: View {
    
    @Binding var showingFilterSheet: Bool
    var filterName: String
    
    @State private var offsetX: CGFloat = -200
    
    var body: some View {
        Group {
            Button(filterName) {
                self.showingFilterSheet = true
            }
            .background(
                Rectangle()
                    .fill(Color(red: 251 / 255.0, green: 123 / 255.0, blue: 107 / 255.0).opacity(0.8))
                    .frame(width: 250, height: 150)
                    .cornerRadius(20)
                    .offset(x: -40, y: 40)
            )
        }
        .offset(x: offsetX, y: 0)
        .animation(Animation.easeInOut.speed(0.5))
        .onAppear {
            self.offsetX = 0
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(showingFilterSheet: Binding.constant(true), filterName: "CISepiaFilter")
    }
}
