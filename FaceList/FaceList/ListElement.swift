//
//  ListElement.swift
//  FaceList
//
//  Created by Stefan Blos on 25.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ListElement: View {
    
    var image: UIImage
    
    var firstName: String
    var surname: String
    
    init(image: UIImage, name: String) {
        self.image = image
        let names = name.split(separator: " ")
        self.firstName = "\(names[0])"
        self.surname = "\(names[1])"
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: .shadowRadius)
                    .padding()
                
                Spacer()
            }
            
            
            HStack {
                Text(firstName)
                    .foregroundColor(.secondary)
                    .font(.largeTitle)
                    .bold()
                    +
                    Text(" ")
                        .font(.largeTitle)
                    +
                    Text(surname)
                        .font(.largeTitle)
                        .bold()
            }
            .padding(.trailing, 20)
            
            
        }
        //.padding(40)
        //.background(Color.white)
        //.cornerRadius(.cornerRadius)
        //.shadow(radius: .shadowRadius)
        .padding(20)
    }
}

struct ListElement_Previews: PreviewProvider {
    static var previews: some View {
        ListElement(image: UIImage(named: "Planes18")!, name: "Stefan Blos")
    }
}
