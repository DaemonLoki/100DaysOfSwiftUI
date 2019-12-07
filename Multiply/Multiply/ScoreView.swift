//
//  ScoreView.swift
//  Multiply
//
//  Created by Stefan Blos on 06.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    
    let finalScore: Int
    let numberOfQuestions: Int
    let showSettings: () -> Void
    
    @State private var showScoreText = false
    @State private var showScore = false
    @State private var showAnimal = false
    @State private var showSettingsButton = false
    
    let baseDelay = 0.2
    
    var body: some View {
        VStack(spacing: 60) {
            Text("Final score:")
                .font(.largeTitle)
                .fontWeight(.black)
                .opacity(showScoreText ? 1.0 : 0)
                .animation(Animation.spring().delay(baseDelay))
                .onAppear {
                    self.showScoreText = true
            }
            
            HStack {
                Text("\(finalScore) / \(numberOfQuestions)")
                    .font(Font.system(size: 80.0, weight: .black))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .opacity(showScore ? 1.0 : 0)
                    .animation(Animation.spring().delay(baseDelay + 0.2))
                    .onAppear {
                        self.showScore = true
                }
            }
            
            AnimalView(showing: true, correctAnswer: Double(finalScore) / Double(numberOfQuestions) >= 0.7 ? true: false)
                .opacity(showAnimal ? 1.0 : 0)
                .animation(Animation.spring().delay(baseDelay + 0.4))
                .onAppear {
                    self.showAnimal = true
            }
            
            Spacer()
            
            Button(action: {
                self.showSettings()
            }) {
                Text("Back to Settings")
                    .font(.body)
                    .foregroundColor(.primary)
                
            }
            .opacity(showSettingsButton ? 1.0 : 0)
            .animation(Animation.easeInOut.delay(baseDelay + 0.6))
            .onAppear {
                self.showSettingsButton = true
            }
        }
        
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(finalScore: 8, numberOfQuestions: 10) {}
    }
}
