//
//  ContentView.swift
//  RollTheDice
//
//  Created by Stefan Blos on 06.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel: RollsViewModel
    
    var body: some View {
        TabView {
            
            RollDiceView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "cube.box.fill")
                    Text("Roll")
            }.tag(0)
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Recent")
            }.tag(1)
        }
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: RollsViewModel())
    }
}
*/
