//
//  RollDiceView.swift
//  RollTheDice
//
//  Created by Stefan Blos on 07.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct RollDiceView: View {
    
    var viewModel: RollsViewModel
    
    @State private var result: Int? = nil
    @State private var numberOfSides = 6
    @State private var degrees: Double = 0
    
    var resultFloat: CGFloat {
        CGFloat(result ?? 0)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $numberOfSides, label: Text("Number of sides")) {
                    Text("2").tag(2)
                    Text("4").tag(4)
                    Text("6").tag(6)
                    Text("8").tag(8)
                    Text("10").tag(10)
                    Text("12").tag(12)
                    Text("20").tag(20)
                    Text("100").tag(100)
                }.pickerStyle(SegmentedPickerStyle())
                
                PolygonShape(sides: Double(self.numberOfSides), scale: 1.0)
                    .stroke(Color.black, lineWidth: numberOfSides >= 20 ? 1 : 5)
                    .padding()
                    .rotationEffect(.degrees(self.degrees))
                    .animation(.spring(response: 0.5, dampingFraction: 0.7))
                    .layoutPriority(1)
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemBackground))
                    .animatableNumber(resultFloat)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text(result != nil ? "#BlackLivesMatter" : "Hit the button to roll")
                    .font(.headline)
                    .foregroundColor(.secondary)
                        .padding(.trailing)
                    
                    Button(action: {
                        withAnimation {
                            self.degrees += 360
                            self.result = Int.random(in: 1...self.numberOfSides)
                            self.viewModel.addRoll(result: self.result!, numberOfSides: self.numberOfSides)
                        }
                    }, label: {
                        Image(systemName: "play")
                            .foregroundColor(.white)
                            .padding(30)
                            .background(Circle().fill(Color.black))
                    })
                }
                .padding()
            }
            .padding()
            .navigationBarTitle("Roll the dice")
        }
    }
}
