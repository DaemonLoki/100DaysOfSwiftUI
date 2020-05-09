//
//  PersonsListView.swift
//  FaceList
//
//  Created by Stefan Blos on 27.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct PersonsListView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @Binding var showingImagePicker: Bool
    @Binding var image: UIImage?
    @Binding var creatingPerson: Bool
    var personList: [Person]
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    FilteredPersonList(filterKey: "", filterValue: "") { (person: Person) in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            ListElement(image: UIImage.loadFromDisk(with: person.wrappedImageId), name: person.wrappedName)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.showingImagePicker = true
                    }) {
                        Text("Add person")
                            .padding()
                            .frame(width: geo.size.width * 0.8)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(.cornerRadius)
                            .shadow(radius: .shadowRadius)
                        
                    }
                    .padding(.bottom)
                }
                .sheet(isPresented: self.$showingImagePicker, onDismiss: self.loadImage) {
                    ImagePicker(image: self.$image)
                }
                .navigationBarTitle("Face List")
            }
        }
    }
    
    func loadImage() {
        self.creatingPerson = true
    }
}

struct PersonsListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsListView(showingImagePicker: .constant(false), image: .constant(nil), creatingPerson: .constant(false), personList: [Person]())
    }
}
