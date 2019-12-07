//
//  IntroView.swift
//  Multiply
//
//  Created by Stefan Blos on 06.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    
    @State private var showAnimation = false
    @Binding var showing: Bool
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("🦁")
                    .font(.system(size: showAnimation ? 140 : 80))
                    .animation(.default)
                
                if showAnimation == false {
                    Text("Hey! I'm the lovely lion Leo and I want to help you with the most fun thing in the world:\n\nMultiplying numbers!")
                        .font(.headline)
                        .card()
                }
            }
            .padding()
            
            Button(action: {
                withAnimation {
                    self.showAnimation.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showing.toggle()
                }
                
            }) {
                Text("Let's have fun!")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 40)
                    .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .opacity(showAnimation ? 0 : 1)
            .animation(.default)
        }
        
        
    }
}
