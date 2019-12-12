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
        HStack(spacing: 20) {
            Image(self.mission.image)
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
        
            VStack(alignment: .leading) {
                Text(self.mission.displayName)
                    .font(.headline)
                
                Text(self.showingDates ? self.mission.formattedLaunchDate : self.mission.crew.compactMap { role in
                    return self.astronauts.first { (a: Astronaut) -> Bool in
                        a.id == role.name
                    }?.name
                }.joined(separator: "\n"))
                    .font(.footnote)
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 336, height: 270)
        .background(Color.init(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
        .padding(.horizontal, 20)
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
