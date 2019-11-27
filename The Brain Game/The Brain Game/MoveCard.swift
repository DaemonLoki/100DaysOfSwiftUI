//
//  MoveCard.swift
//  The Brain Game
//
//  Created by Stefan Blos on 27.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct MoveCard: View {
    let move: String
    let name: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(move)
                .font(.largeTitle)
            Text(name.uppercased())
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.init(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding()
        .shadow(radius: 5)
    }
}

struct MoveCard_Previews: PreviewProvider {
    static var previews: some View {
        MoveCard(move: "✊🏽", name: "Rock")
    }
}
