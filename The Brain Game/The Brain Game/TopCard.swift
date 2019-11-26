//
//  TopCard.swift
//  The Brain Game
//
//  Created by Stefan Blos on 27.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct TopCard: View {
    let score: Int
    let round: Int
    let gameRunning: Bool
    
    var body: some View {
        VStack {
            Text("ROUND \(round) / 10")
                .font(.caption)
                .padding()
            
            Text("Current score: \(score)")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(gameRunning ? Color.green : Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .shadow(radius: 10)
        .blur(radius: gameRunning ? 0 : 5)
    }
}

struct TopCard_Previews: PreviewProvider {
    static var previews: some View {
        TopCard(score: 3, round: 4, gameRunning: true)
    }
}

