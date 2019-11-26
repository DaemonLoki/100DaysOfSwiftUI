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

struct FinalScore: View {
    let score: Int
    let completionHandler: () -> Void
    
    var body: some View {
        Group {
            VStack {
                Text("Final score".uppercased())
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                
                
                Text("\(score)")
                    .font(.system(size: 80))
                    .fontWeight(.black)
                    .padding()
                
                Text(score > 5 ? "🎉🎉🎉" : "😥😥😥")
                    .font(.largeTitle)
                
                Text(score > 5 ? "Awesome, keep it going!" : "Better luck next time!")
                    .font(.headline)
                    .padding()
                
                Button(action: {
                    self.completionHandler()
                }) {
                    VStack {
                        Image(systemName: "arrow.counterclockwise")
                            .renderingMode(.original)
                            .imageScale(.large)
                            .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 100)
                        
                        Text("Restart".uppercased())
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: 150, minHeight: 0, maxHeight: 150)
                    .background(Color.init(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding()
                    .shadow(radius: 5)
                }
            }
        }
    }
}

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

struct MoveCard : View {
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

struct MovesList: View {
    let evaluator: (Int) -> Void
    
    var body: some View {
        Group {
            HStack(spacing: 5) {
                Button(action: {
                    self.evaluator(0)
                }) {
                    MoveCard(move: "✊🏽", name: "Rock")
                }
                Button(action: {
                    self.evaluator(1)
                }) {
                    MoveCard(move: "✋🏽", name: "Paper")
                }
                Button(action: {
                    self.evaluator(2)
                }) {
                    MoveCard(move: "✌🏽", name: "Scissors")
                }
            }
        }.padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
