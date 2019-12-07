//
//  QuestionsView.swift
//  Multiply
//
//  Created by Stefan Blos on 05.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

let animalArray = ["🐸", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷"]
let correctComments = ["Great job!", "Awesome!", "Nice!", "Keep going!", "Yeah!"]
let wrongComments = ["Better luck next time!", "Next one will be better!", "You can do it!", "Keep going!"]

struct QuestionsView: View {
    
    let questions: [[Int]]
    let showSettings: () -> Void
    
    @State private var correctAnswer = 0
    @State private var answers = [Int]()
    @State private var currentQuestionNumber = 0
    @State private var showingSolution = false
    @State private var score = 0
    @State private var selectedAnswer = 0
    @State private var showingScore = false
    
    init(questions: [[Int]], showSettings: @escaping () -> Void) {
        self.questions = questions
        self.showSettings = showSettings
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(.secondarySystemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                if showingScore {
                    ScoreView(finalScore: score, numberOfQuestions: questions.count, showSettings: showSettings)
                } else {
                    VStack(spacing: 20) {
                        EquationView(firstNumber: questions[currentQuestionNumber][0], secondNumber: questions[currentQuestionNumber][1])
                            .padding(.vertical, 40)
                        
                        HStack {
                            ForEach(0..<self.answers.count) { number in
                                AnswerButton(answer: self.answers[number]) { number in
                                    self.tryAnswer(number)
                                }
                                .overlay(Color.red.opacity(
                                    self.showingSolution && self.answers[number] != self.correctAnswer ? 0.6 : 0
                                ))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 5)
                                    .scaleEffect(self.showingSolution && self.answers[number] == self.correctAnswer ? 1.4 : 1)
                                    .padding(.horizontal, 10)
                                    .animation(.default)
                            }
                        }
                        
                        Spacer()
                        
                        AnimalView(showing: showingSolution, correctAnswer: selectedAnswer == correctAnswer)
                        
                        Spacer()
                        
                        Text("Score: \(score)")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 60)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                            .padding(.horizontal, 40)
                        Button(action: {
                            self.showSettings()
                        }) {
                            Text("Back to Settings")
                                .font(.caption)
                                .foregroundColor(.primary)
                            
                        }
                    }
                    .navigationBarTitle("Question \(currentQuestionNumber + 1) of \(questions.count)")
                }
            }
        }
        .onAppear {
            self.poseQuestion()
        }
    }
    
    func poseQuestion() {
        self.correctAnswer = self.questions[self.currentQuestionNumber][2]
        let answersExtracted = self.questions[self.currentQuestionNumber].dropFirst(2).shuffled()
        self.answers = answersExtracted
    }
    
    func tryAnswer(_ answer: Int) {
        if answer == correctAnswer {
            self.score += 1
        }
        self.selectedAnswer = answer
        self.showingSolution = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.currentQuestionNumber >= self.questions.count - 1 {
                // end game
                self.showingScore = true
            } else {
                self.currentQuestionNumber += 1
                self.showingSolution = false
                self.poseQuestion()
            }
        }
    }
}

struct AnswerButton: View {
    let answer: Int
    let select: (Int) -> Void
    
    var body: some View {
        Button(action: {
            self.select(self.answer)
        }) {
            Text("\(answer)")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(20)
                .frame(width: 100, height: 50)
                .background(Color.init(.systemBackground))
        }
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(questions: [[Int]]()) { /* do nothing */ }
    }
}
