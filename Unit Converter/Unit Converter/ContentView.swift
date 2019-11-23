//
//  ContentView.swift
//  Unit Converter
//
//  Created by Stefan Blos on 23.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let conversionOptions: [ConversionOption] = ConversionOptions.options
    
    var body: some View {
        NavigationView {
            List(conversionOptions) { option in
                NavigationLink(destination: ConversionView(title: option.name, units: option.units)) {
                    Text(option.name)
                        .fontWeight(.light)
                    .padding()
                }
            }
            .navigationBarTitle("Conversions")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
