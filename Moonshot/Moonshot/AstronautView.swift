//
//  AstronautView.swift
//  Moonshot
//
//  Created by Stefan Blos on 11.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let astronautMissions: [Mission]
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var involvedMissions = [Mission]()
        for mission in missions {
            for crewRole in mission.crew {
                if crewRole.name == astronaut.id {
                    involvedMissions.append(mission)
                }
            }
        }
        
        self.astronautMissions = involvedMissions
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Missions")
                        .font(.headline)
                        .padding()
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(self.astronautMissions) { mission in
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                    
                                    Text(mission.displayName)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[1], missions: missions)
    }
}
