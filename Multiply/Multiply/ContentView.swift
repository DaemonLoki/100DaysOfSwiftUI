//
//  ContentView.swift
//  Multiply
//
//  Created by Stefan Blos on 04.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showIntro = true
    @State private var showSettings = true
    @State private var showAnimation = false
    @State private var lowerBoundary = 1
    @State private var upperBoundary = 12
    @State private var singleType = 0
    @State private var numOfQuestionsIndex = 1
    @State private var questions: [[Int]] = [[Int]]()
    
    let multiplicationType = ["Single Number", "Multi-Numbers"]
    let numberOfQuestionsCounts = ["5", "10", "20", "All"]
    
    
    var body: some View {
        Group {
            if showIntro {
                IntroView(showing: $showIntro)
            } else {
                if showSettings {
                    SettingsView { questions in
                        self.questions = questions
                        self.showSettings = false
                    }
                } else {
                    QuestionsView(questions: questions) {
                        self.showSettings = true
                    }
                }
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
        let upper = upperBoundary
        var questions = [[Int]]()
        if let num = Int.init(numberOfQuestionsCounts[numOfQuestionsIndex]) {
            // only generate a few questions
            for _ in 0 ..< num {
                let first = Int.random(in: lower...upper)
                let second = Int.random(in: 1...12)
                let result = first * second
                let wrong_1 = generateRandom(in: 1...(12*12), otherThan: result)
                let wrong_2 = generateRandom(in: 1...(12*12), otherThan: result, wrong_1)
                questions.append([first, second, result, wrong_1, wrong_2])
            }
        } else {
            // generate all possible questions
            for i in lowerBoundary...upperBoundary {
                for j in lowerBoundary...upperBoundary {
                    let first = i
                    let second = j
                    let result = i * j
                    let wrong_1 = generateRandom(in: 1...(12*12), otherThan: result)
                    let wrong_2 = generateRandom(in: 1...(12*12), otherThan: result, wrong_1)
                    questions.append([first, second, result, wrong_1, wrong_2])
                }
            }
        }
        return questions
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
