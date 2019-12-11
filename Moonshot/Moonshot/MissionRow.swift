//
//  MissionRow.swift
//  Moonshot
//
//  Created by Stefan Blos on 11.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct MissionRow: View {
    
    let mission: Mission
    let astronauts: [Astronaut]
    
    @Binding var showingDates: Bool
    
    var body: some View {
        HStack {
            Image(mission.image)
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)
        
            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                
                Text(self.showingDates ? mission.formattedLaunchDate : mission.crew.compactMap { role in
                    return self.astronauts.first { (a: Astronaut) -> Bool in
                        a.id == role.name
                    }?.name
                }.joined(separator: "\n"))
                    .font(.footnote)
            }
        }
    }
}

struct MissionRow_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    @State static var showingDates = false
    
    static var previews: some View {
        MissionRow(mission: missions[2], astronauts: astronauts, showingDates: $showingDates)
    }
}
