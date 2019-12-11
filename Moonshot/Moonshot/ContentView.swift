//
//  ContentView.swift
//  Moonshot
//
//  Created by Stefan Blos on 10.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text("\(astronauts.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
