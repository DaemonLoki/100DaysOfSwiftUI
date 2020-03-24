//
//  ContentView.swift
//  FriendFace
//
//  Created by Stefan Blos on 10.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @FetchRequest(entity: ModelUser.entity(), sortDescriptors: []) var users: FetchedResults<ModelUser>
    @Environment(\.managedObjectContext) var moc
    
    let website = "https://www.hackingwithswift.com/samples/friendface.json"
    
    @State private var userList: [ModelUser] = []
    
    init() {
        print("init")
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userList, id: \.self) { user in
                    NavigationLink(destination: UserView(user: user, users: self.$userList)) {
                        UserRow(name: user.wrappedName, mail: user.wrappedMail)
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
        if self.users.count > 0 {
            for user in self.users {
                self.userList.append(user)
            }
        } else {
            print("none existant")
            self.loadUsersFromWeb()
        }
    }
    
    func loadUsersFromWeb() {
        let url = URL(string: website)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else {
                return
            }
            
            guard let decodedUsers = try? JSONDecoder().decode([User].self, from: unwrappedData) else {
                return
            }
            
            for user in decodedUsers {
                let newUser = ModelUser(context: self.moc)
                newUser.name = user.name
                newUser.id = user.id
                newUser.email = user.email
                newUser.about = user.about
                newUser.age = Int16(user.age)
                newUser.address = user.address
                newUser.company = user.company
                var friendList: [ModelFriend] = []
                for friend in user.friends {
                    let newFriend = ModelFriend(context: self.moc)
                    newFriend.id = friend.id
                    newFriend.name = friend.name
                    friendList.append(newFriend)
                }
                newUser.friends = NSSet(array: friendList)
                self.userList.append(newUser)
            }
            
            try? self.moc.save()
        }.resume()
    }
}

struct UserRow: View {
    var name: String
    var mail: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
            
            Text(mail)
                .foregroundColor(.secondary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
