//
//  ContentView.swift
//  HotProspects
//
//  Created by Stefan Blos on 09.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct ContentView: View {
    let user = User()
    
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct EditView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}
