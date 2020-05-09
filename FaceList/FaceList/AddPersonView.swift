//
//  AddPersonView.swift
//  FaceList
//
//  Created by Stefan Blos on 27.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AddPersonView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @Binding var creatingPerson: Bool
    @Binding var image: UIImage?
    @Binding var personList: [Person]
    
    @State private var personName = ""
    
    let locationFetcher = LocationFetcher()
    
    var isButtonDisabled: Bool {
        image == nil || personName.isEmpty
    }
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    if self.image != nil {
                        Image(uiImage: self.image!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: .shadowRadius)
                            .padding(.vertical)
                    }
                    
                    HStack {
                        Text("Name".uppercased())
                            .font(.title)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                    .padding(.leading, 40)
                    
                    TextField("Enter name", text: self.$personName)
                        .font(.largeTitle)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    Button(action: {
                        guard let userImage = self.image else { return }
                        
                        let location = self.locationFetcher.lastKnownLocation
                        
                        let person = Person(context: self.moc)
                        person.imageId = userImage.writeToDisk()
                        person.name = self.personName
                        person.latitude = location?.latitude ?? 0.0
                        person.longitude = location?.longitude ?? 0.0
                        
                        try? self.moc.save()
                        
                        self.creatingPerson = false
                    }) {
                        Text("Done")
                            .padding()
                            .frame(width: geo.size.width * 0.8)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(.cornerRadius)
                            .shadow(radius: .shadowRadius)
                            
                            .disabled(self.isButtonDisabled)
                    }
                    .padding(.bottom)
                }
                .navigationBarTitle("Add person")
            }
            .onAppear {
                self.locationFetcher.start()
            }
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(creatingPerson: .constant(true), image: .constant(UIImage(named: "Planes18")), personList: .constant([Person]()))
    }
}
