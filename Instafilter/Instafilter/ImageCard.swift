//
//  ImageCard.swift
//  Instafilter
//
//  Created by Stefan Blos on 09.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ImageCard: View {
    
    var image: Image?
    @State private var shadowRadius: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(self.image == nil ? Color(red: 231 / 255.0, green: 211 / 255.0, blue: 159 / 255.0) : Color.clear)
                .cornerRadius(20)
                .shadow(color: Color(red: 82 / 255.0, green: 45 / 255.0, blue: 91 / 255.0), radius: shadowRadius)
                .animation(.easeInOut)
            
            // display the image
            if self.image != nil {
                self.image?
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .shadow(color: Color(red: 82 / 255.0, green: 45 / 255.0, blue: 91 / 255.0), radius: shadowRadius)
                    .animation(.easeInOut)
            } else {
                Text("Tap to select a picture")
                    .font(.headline)
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut.delay(0.5)) {
                self.shadowRadius = 20
            }
        }
    }
}

struct ImageCard_Previews: PreviewProvider {
    static var previews: some View {
        ImageCard()
        .frame(width: 300, height: 300)
    }
}
