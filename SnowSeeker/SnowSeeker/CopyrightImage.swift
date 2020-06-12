//
//  CopyrightImage.swift
//  SnowSeeker
//
//  Created by Stefan Blos on 12.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct CopyrightImage: View {
    
    let imageId: String
    let imageCredit: String
    
    var body: some View {
        ZStack {
            Image(decorative: imageId)
            .resizable()
            .scaledToFit()
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Text(imageCredit)
                        .foregroundColor(.white)
                    .padding()
                        .background(Color.black.opacity(0.4))
                }
            }
        }
        
    }
}

struct CopyrightImage_Previews: PreviewProvider {
    static var previews: some View {
        CopyrightImage(imageId: "les-trois-vallees", imageCredit: "Ben Kapomoto")
            .frame(width: 400, height: 200)
    }
}
