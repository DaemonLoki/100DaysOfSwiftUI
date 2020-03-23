//
//  UserView.swift
//  FriendFace
//
//  Created by Stefan Blos on 10.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct UserView: View {
    let user: User
    @Binding var users: [User]
    
    @State private var ageXOffset: CGFloat = 0
    @State private var ageYOffset: CGFloat = 0
    
    @State private var mailXOffset: CGFloat = 0
    @State private var mailYOffset: CGFloat = 0
    
    @State private var addressXOffset: CGFloat = 0
    @State private var addressYOffset: CGFloat = 0
    
    @State private var cardsMaxWidth: CGFloat = 200
    
    @State var offsetToggle = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    ZStack {
                        
                        UserInfoRowView(imageName: "envelope", text: self.offsetToggle ? "" :  self.user.email, color: .red, maxWidth: self.cardsMaxWidth)
                            .offset(x: self.mailXOffset, y: self.mailYOffset)
                        
                        UserInfoRowView(imageName: "house", text: self.offsetToggle ? "" : self.user.address, color: .green, maxWidth: self.cardsMaxWidth)
                            .offset(x: self.addressXOffset, y: self.addressYOffset)
                        
                        UserInfoRowView(imageName: "timer", text: "\(self.user.age) years old.", color: .yellow, maxWidth: self.cardsMaxWidth)
                            .offset(x: self.ageXOffset, y: self.ageYOffset)
                        
                    }
                    .frame(width: geo.size.width, height: 200)
                    .gesture(
                        TapGesture()
                            .onEnded({
                                self.toggleOffsets()
                            })
                    )
                        .padding(.top)
                    
                    Text("ABOUT")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding(.top, 40)
                        .padding(.horizontal, 20)
                    
                    Text(self.user.about)
                        .font(.body)
                        .padding()
                    
                    Text("FRIENDS")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(0..<self.user.friends.count) { index in
                                NavigationLink(destination: UserView(user: self.users.first(where: { $0.id == self.user.friends[index].id })!, users: self.$users)) {
                                    VStack {
                                        Image(systemName: "person")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.primary)
                                            .padding()
                                            .frame(width: 50, height: 50)
                                        
                                        
                                        Text(self.user.friends[index].name)
                                            .foregroundColor(.primary)
                                        
                                    }
                                    .frame(width: geo.size.width * 0.4, height: 100)
                                    .background(self.backgroundColor(by: index))
                                    .cornerRadius(10)
                                    .padding(.vertical, 20)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                        self.toggleOffsets()
                    }
                    
                }
            }
        }.navigationBarTitle(user.name)
        
    }
    
    func backgroundColor(by index: Int) -> Color {
        switch index % 3 {
        case 0:
            return .red
        case 1:
            return .yellow
        case 2:
            return .green
        default:
            return .clear
        }
    }
    
    func toggleOffsets() {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.5)) {
            if offsetToggle {
                self.ageXOffset = 70
                self.ageYOffset = 10
                
                self.mailXOffset = 10
                self.mailYOffset = -50
                
                self.addressXOffset = 5
                self.addressYOffset = 80
                
                self.cardsMaxWidth = .infinity
            } else {
                self.ageXOffset = 0
                self.ageYOffset = 0
                
                self.mailXOffset = 0
                self.mailYOffset = 0
                
                self.addressXOffset = 0
                self.addressYOffset = 0
                
                self.cardsMaxWidth = 200
            }
            self.offsetToggle.toggle()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: "testId", name: "Stefan Blos", age: 29, company: "Codecamp:N", email: "stefan.blos@gmail.com", address: "Stettiner Straße 18, 91320 Ebermannstadt", about: "He is an aspiring iOS developer who takes 8 hours on average to record a 3 minute YouTube clip.", friends: [Friend(id: "friendId1", name: "Batman"),
                                                                                                                                                                                                                                                                                                         Friend(id: "friendId2", name: "Mr. Wayne"),
                                                                                                                                                                                                                                                                                                         Friend(id: "friendId3", name: "Superman"),
                                                                                                                                                                                                                                                                                                         Friend(id: "friendId4", name: "Mr. Smith"),
                                                                                                                                                                                                                                                                                                         Friend(id: "friendId5", name: "Neo"),
                                                                                                                                                                                                                                                                                                         Friend(id: "friendId6", name: "Morpheus")]), users: Binding.constant([]))
    }
}
