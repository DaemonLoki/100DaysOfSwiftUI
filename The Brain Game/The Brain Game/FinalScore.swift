//
//  FinalScore.swift
//  The Brain Game
//
//  Created by Stefan Blos on 27.11.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

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

struct FinalScore_Previews: PreviewProvider {
    static var previews: some View {
        FinalScore(score: 8) {
            // nothing to do here
        }
    }
}
