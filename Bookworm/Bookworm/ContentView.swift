//
//  ContentView.swift
//  Bookworm
//
//  Created by Stefan Blos on 11.02.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
