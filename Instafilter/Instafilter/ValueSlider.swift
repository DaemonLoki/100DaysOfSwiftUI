//
//  ValueSlider.swift
//  Instafilter
//
//  Created by Stefan Blos on 09.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ValueSlider: View {
    
    var title: String
    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Slider(value: $value)
        }
        .animation(.easeInOut)
        .transition(.slide)
    }
}

struct ValueSlider_Previews: PreviewProvider {
    static var previews: some View {
        ValueSlider(title: "Intensity", value: Binding.constant(0.5))
            .background(Color.black)
    }
}
