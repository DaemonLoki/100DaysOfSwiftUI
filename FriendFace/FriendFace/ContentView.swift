//
//  ContentView.swift
//  FriendFace
//
//  Created by Stefan Blos on 10.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let website = "https://www.hackingwithswift.com/samples/friendface.json"
    
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    NavigationLink(destination: UserView(user: user, users: self.$users)) {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            
                            Text(user.email)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationBarTitle("Friends")
            .onAppear {
                self.loadUsers()
            }
        }
    }
    
    func loadUsers() {
        let url = URL(string: website)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else {
                return
            }
            
            guard let decodedUsers = try? JSONDecoder().decode([User].self, from: unwrappedData) else {
                return
            }
            
            self.users = decodedUsers
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
