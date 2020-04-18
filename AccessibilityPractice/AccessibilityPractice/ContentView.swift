//
//  ContentView.swift
//  AccessibilityPractice
//
//  Created by Stefan Blos on 18.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var estimate = 25.0
    
    var body: some View {
        Slider(value: $estimate, in: 0...50)
            .padding()
        .accessibility(value: Text("\(Int(estimate))"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
