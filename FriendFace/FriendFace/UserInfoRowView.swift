//
//  UserInfoRowView.swift
//  FriendFace
//
//  Created by Stefan Blos on 16.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct UserInfoRowView: View {
    let imageName: String
    let text: String
    let color: Color
    let maxWidth: CGFloat
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 50, height: 50)
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(self.color)
                    .frame(width: 25, height: 25)
            }
            
            Text(text)
                .padding(.leading)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(self.color))
        .shadow(radius: text == "" ? 0 : 5)
    }
}

struct UserInfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoRowView(imageName: "envelope", text: "stefan.blos@gmail.com", color: .red, maxWidth: .infinity)
    }
}
