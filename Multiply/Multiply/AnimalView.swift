//
//  AnimalView.swift
//  Multiply
//
//  Created by Stefan Blos on 06.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AnimalView: View {
    let showing: Bool
    let correctAnswer: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(showing ? animalArray.randomElement()! : "")
                    .font(.system(size: 80))
                Text(showing ? correctAnswer ? "👍🏽" : "👎🏽" : "")
                    .font(.system(size: 40))
                    .rotation3DEffect(.degrees(20), axis: (x: 0, y: 0, z: 1))
                .offset(x: 0, y: 20)
            }
            Text(correctAnswer ?
                correctComments.randomElement()! : wrongComments.randomElement()!)
                .font(.headline)
                .card()
                .padding(.top, 10)
        }
        .opacity(showing ? 1.0 : 0.0)
        .animation(.interactiveSpring())
    }
}

struct AnimalView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalView(showing: true, correctAnswer: false)
    }
}
