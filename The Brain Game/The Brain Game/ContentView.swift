//
//  ContentView.swift
//  The Brain Game
//
//  Created by Stefan Blos on 26.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
