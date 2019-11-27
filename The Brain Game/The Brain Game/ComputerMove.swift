//
//  ComputerMove.swift
//  The Brain Game
//
//  Created by Stefan Blos on 27.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ComputerMove: View {
    let selectedMove: String
    let playerShouldWin: Bool
    
    var body: some View {
        Group {
            Text("Computer chooses".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(selectedMove.uppercased())
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
            
            Text("You want to".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(playerShouldWin ? "WIN" : "LOSE")
                .font(.title)
                .foregroundColor(playerShouldWin ? .green : .red)
        }
    }
}

struct ComputerMove_Previews: PreviewProvider {
    static var previews: some View {
        ComputerMove(selectedMove: "Rock", playerShouldWin: true)
    }
}
