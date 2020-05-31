//
//  MissionView.swift
//  Moonshot
//
//  Created by Stefan Blos on 11.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    let mission: Mission
    let missions: [Mission]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let astronauts: [CrewMember]
    
    let baseline: CGFloat = 44
        
    init(mission: Mission, missions: [Mission], astronauts: [Astronaut]) {
        self.mission = mission
        self.missions = missions
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id ==  member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        ScrollView(.vertical) {
            GeometryReader { (geometry: GeometryProxy) in
                VStack {
                    Image(decorative: self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300 + self.calcScale(with: geometry.frame(in: .global).minY))
                        .padding(.top, 30)
                    
                    if self.mission.launchDate != nil {
                        Text(self.mission.formattedLaunchDate)
                            .font(.title)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        AstronautRow(crewMember: crewMember, missions: self.missions)
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    func calcScale(with offset: CGFloat) -> CGFloat {
        if offset == baseline {
            return 0
        }
        
        return offset - baseline
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], missions: missions, astronauts: astronauts)
    }
}
