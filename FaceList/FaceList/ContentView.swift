//
//  ContentView.swift
//  FaceList
//
//  Created by Stefan Blos on 25.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingImagePicker = false
    @State private var image: UIImage?
    @State private var creatingPerson = false
    
    @State private var personList = [Person]()
    
    var body: some View {
        GeometryReader { geo in
            if !self.creatingPerson {
                PersonsListView(showingImagePicker: self.$showingImagePicker, image: self.$image, creatingPerson: self.$creatingPerson, personList: self.personList)
            } else {
                AddPersonView(creatingPerson: self.$creatingPerson, image: self.$image, personList: self.$personList)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
