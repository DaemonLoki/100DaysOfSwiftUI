//
//  BlurSaturationView.swift
//  Drawing
//
//  Created by Stefan Blos on 14.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct BlurSaturationView: View {
    
    @State private var amount: CGFloat = 0.0
    
    var body: some View {
        VStack {
            Image("meetup_talk")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(Double(amount))
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
    }
}

struct BlurSaturationView_Previews: PreviewProvider {
    static var previews: some View {
        BlurSaturationView()
    }
}
