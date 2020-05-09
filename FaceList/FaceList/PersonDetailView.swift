//
//  PersonDetailView.swift
//  FaceList
//
//  Created by Stefan Blos on 09.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct PersonDetailView: View {
    
    var person: Person
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                MapView(name: self.person.wrappedName, latitude: self.person.latitude, longitude: self.person.longitude)
                
                VStack {
                    Image(uiImage: UIImage.loadFromDisk(with: self.person.wrappedImageId))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: .shadowRadius)
                        .padding()
                    
                    Spacer()
                    
                    Text(self.person.wrappedName)
                        .padding()
                        .frame(width: geo.size.width * 0.9, height: 80)
                        .background(Color(UIColor.systemBackground))
                    .cornerRadius(20)
                        .padding()
                }
            }
        .navigationBarTitle("Details")
        }
    }
}

/*
 struct PersonDetailView_Previews: PreviewProvider {
 static var previews: some View {
 PersonDetailView()
 }
 }
 */
