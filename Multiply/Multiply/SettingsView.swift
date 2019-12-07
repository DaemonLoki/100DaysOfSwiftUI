//
//  SettingsView.swift
//  Multiply
//
//  Created by Stefan Blos on 05.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var showAnimation = false
    @State private var lowerBoundary = 1
    @State private var upperBoundary = 12
    @State private var singleType = 0
    @State private var numOfQuestionsIndex = 1
    
    let setQuestions: ([[Int]]) -> Void
    
    let multiplicationType = ["Single Number", "Multi-Numbers"]
    let numberOfQuestionsCounts = ["5", "10", "20", "All"]
    @State private var questions: [[Int]] = [[Int]]()
    
    var body: some View {
        Group {
            NavigationView {
                ZStack {
                    Color.init(.secondarySystemBackground)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 30) {
                            Text("Number(s) to practice?")
                                .fontWeight(.bold)
                                .headline()
                                .padding(.top, 20)
                            
                            Picker("Type of multiplication", selection: $singleType) {
                                ForEach(0..<multiplicationType.count) { number in
                                    Text(self.multiplicationType[number])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                            
                            VStack {
                                HStack {
                                    Text(singleType == 0 ? "\t\t" : "From:\t")
                                        .font(.caption)
                                        
                                    Stepper(value: $lowerBoundary, in: 1...upperBoundary) {
                                        Text("\(lowerBoundary)")
                                    }
                                    
                                }.padding(.horizontal, 20)
                                
                                HStack {
                                    Text("To:\t\t")
                                        .font(.caption)
                                    
                                    Stepper(value: $upperBoundary, in: lowerBoundary...12) {
                                        Text("\(upperBoundary)")
                                    }
                                    
                                }
                                .disabled(singleType == 0)
                                .padding(.horizontal, 20)
                                
                            }.padding(.horizontal, 40)
                        }
                        .card()
                        
                        
                        VStack {
                            Text("How many questions?")
                                .fontWeight(.bold)
                                .headline()
                                .padding(.top, 20)
                            
                            Picker("Number of questions", selection: $numOfQuestionsIndex) {
                                ForEach(0..<numberOfQuestionsCounts.count) { number in
                                    Text(self.numberOfQuestionsCounts[number])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()
                        }
                        .card()
                        
                        Button(action: {
                            withAnimation(.interpolatingSpring(stiffness: 5, damping: 3)) {
                                self.showAnimation.toggle()
                            }
                            
                            let questions = self.generateQuestions()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.setQuestions(questions)
                            }
                        }) {
                            HStack(alignment: .center, spacing: 40) {
                                Text("🦁")
                                    .font(.system(size: 60))
                                    .scaleEffect(showAnimation ? 1.5 : 1)
                                
                                if !showAnimation {
                                    Text("Start")
                                        .frame(width: 150, height: 40)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            
                        }
                        
                        Text("Don't worry, my friends & I will keep you motivated along the way!")
                            .font(.headline)
                            .card()
                            .padding(.top)
                        
                        Spacer()
                    }
                }
                .navigationBarTitle("Multiplications")
            }
        }
    }
    
    func generateRandom(in range: ClosedRange<Int>, otherThan: Int...) -> Int {
        var generated = otherThan[0]
        while otherThan.contains(generated) {
            generated = Int.random(in: range)
        }
        return generated
    }
    
    func generateQuestions() -> [[Int]] {
        let lower = lowerBoundary
        let upper = singleType == 0 ? lower : upperBoundary
        var questions = [[Int]]()
        if let num = Int.init(numberOfQuestionsCounts[numOfQuestionsIndex]) {
            // only generate a few questions
            for _ in 0 ..< num {
                let first = Int.random(in: lower...upper)
                let second = Int.random(in: 1...12)
                let result = first * second
                let wrong_1 = generateRandom(in: lower...(upper*12), otherThan: result)
                let wrong_2 = generateRandom(in: lower...(upper*12), otherThan: result, wrong_1)
                questions.append([first, second, result, wrong_1, wrong_2])
            }
        } else {
            // generate all possible questions
            for i in lower...upper {
                for j in 1...12 {
                    let first = i
                    let second = j
                    let result = i * j
                    let wrong_1 = generateRandom(in: 1...(12*12), otherThan: result)
                    let wrong_2 = generateRandom(in: 1...(12*12), otherThan: result, wrong_1)
                    questions.append([first, second, result, wrong_1, wrong_2])
                }
            }
            questions.shuffle()
        }
        return questions
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView { q in
            // do nothing
        }
    }
}
