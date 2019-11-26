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
    @State private var selectedMove = Int.random(in: 0...2)
    @State private var playerShouldWin = Bool.random()
    
    @State private var currentScore = 0
    
    var body: some View {
        VStack {
            Group {
                Text("Current score: \(currentScore)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.top)
                Divider()
                Text(moves[selectedMove])
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(playerShouldWin ? "WIN" : "LOSE")
                    .font(.title)
                    .foregroundColor(playerShouldWin ? .green : .red)
            }
            
            Group {
                HStack {
                    Button(action: {
                        print("Rock")
                    }) {
                        Text("Rock")
                    }
                    Spacer()
                    Button(action: {
                        print("Paper")
                    }) {
                        Text("Paper")
                    }
                    Spacer()
                    Button(action: {
                        print("Scissors")
                    }) {
                        Text("Scissors")
                    }
                }
            }.padding(.top, 100)
                .padding(50)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
