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
    @State private var currentRound = 1
    @State private var gameRunning = true
    
    var body: some View {
        VStack {
            Group {
                TopCard(score: currentScore, round: currentRound, gameRunning: gameRunning)
                
                Divider()
                    .padding(.bottom)
                
                if gameRunning {
                    ComputerMove(selectedMove: moves[selectedMove], playerShouldWin: playerShouldWin)
                    
                    MovesList { (moveIndex) in
                        self.evaluate(move: moveIndex)
                    }
                } else {
                    FinalScore(score: currentScore) {
                        self.restartGame()
                    }
                }
                
                Spacer()
            }
        }
    }
    
    func evaluate(move: Int) {
        let correctMove: Int
        if selectedMove == 0 {
            // Rock
            correctMove = playerShouldWin ? 1 : 2
        } else if selectedMove == 1 {
            // Paper
            correctMove = playerShouldWin ? 2 : 0
        } else {
            // Scissors
            correctMove = playerShouldWin ? 0 : 1
        }
        currentScore += move == correctMove ? 1 : -1
        if currentRound < 10 {
            createNewRound()
        } else {
            gameRunning = false
        }
    }
    
    func createNewRound() {
        selectedMove = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
        currentRound += 1
    }
    
    func restartGame() {
        currentRound = 0
        currentScore = 0
        createNewRound()
        gameRunning = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
