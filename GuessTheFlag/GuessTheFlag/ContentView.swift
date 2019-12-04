//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Stefan Blos on 24.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var showAnimation = false
    
    private var flagImages = [
        FlagImage(name: "Germany"),
        FlagImage(name: "Italy"),
        FlagImage(name: "France")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.init(.systemBackground), .init(.blue)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 20)
            
            VStack(spacing: 50) {
                VStack {
                    Text("Tap the flag of:")
                        .font(.subheadline)
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(width: 300)
                }.padding(.top, 20)
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.showAnimation = true
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                            .opacity(self.showAnimation && number != self.correctAnswer ? 0.2 : 1)
                            .animation(.default)
                    }
                }
                
                VStack {
                    Text("Current score:")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    Text("\(currentScore)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("That's the flag of \(self.countries[correctAnswer])."), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                self.showAnimation = false
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            currentScore += 1
            scoreTitle = "Correct"
        } else {
            currentScore -= 1
            scoreTitle = "Wrong"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showingScore = true
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
