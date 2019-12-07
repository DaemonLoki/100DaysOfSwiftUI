//
//  ContentView.swift
//  iExpense
//
//  Created by Stefan Blos on 07.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var firstName: String = "Bilbo"
    var lastName: String = "Baggins"
}

struct ContentView: View {
    
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("I'm \(user.firstName) \(user.lastName)")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            
            Button("Save") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
        }
        .onAppear {
            guard let data = UserDefaults.standard.data(forKey: "UserData") else { return }
            
            let decoder = JSONDecoder()
            guard let decodedUser = try? decoder.decode(User.self, from: data) else { return }
            self.user = decodedUser
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
