//
//  AstronautView.swift
//  Moonshot
//
//  Created by Stefan Blos on 11.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let crewMember: MissionView.CrewMember
    let chiefTitle = "Commander"
    
    @State private var isStarScaled = false
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 83, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(crewMember.role == chiefTitle ? Color.red : Color.secondary, lineWidth: 2))
                    .shadow(radius: 5)
                
                if crewMember.role == chiefTitle {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                        .padding(.trailing, 8)
                        .scaleEffect(isStarScaled ? 1.3 : 1.0)
                        .animation(Animation.default.repeatForever())
                        .onAppear {
                            self.isStarScaled = true
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .font(.headline)
                Text(crewMember.role)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let role = "Commander"
    
    static var previews: some View {
        AstronautView(crewMember: MissionView.CrewMember(role: role, astronaut: astronauts[0]))
    }
}
