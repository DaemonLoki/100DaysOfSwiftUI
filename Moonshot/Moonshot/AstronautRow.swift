//
//  AstronautView.swift
//  Moonshot
//
//  Created by Stefan Blos on 11.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AstronautRow: View {
    let crewMember: MissionView.CrewMember
    let missions: [Mission]
    let chiefTitle = "Commander"
    
    @State private var isStarScaled = false
    
    var body: some View {
        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
            HStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: crewMember.astronaut.id)
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
        .buttonStyle(PlainButtonStyle())
    }
}

struct AstronautRow_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let role = "Commander"
    
    static var previews: some View {
        AstronautRow(crewMember: MissionView.CrewMember(role: role, astronaut: astronauts[0]), missions: missions)
    }
}
