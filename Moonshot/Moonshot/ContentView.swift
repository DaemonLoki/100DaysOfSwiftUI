//
//  ContentView.swift
//  Moonshot
//
//  Created by Stefan Blos on 10.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let centerOfTransformation: Double = 100
    let amountOfOverlap: CGFloat = 100
    let dampingFactor: Double = 8
    
    @State private var showingDates = true
    
    var body: some View {
        NavigationView {
            HStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: -amountOfOverlap) {
                        ForEach(missions) { mission in
                            GeometryReader { geo in
                                NavigationLink(destination: MissionView(mission: mission, missions: self.missions, astronauts: self.astronauts)) {
                                
                                    MissionRow(mission: mission, astronauts: self.astronauts, showingDates: self.$showingDates)
                                        .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY) - self.centerOfTransformation) / -self.dampingFactor, axis: (x: 10, y: 0, z: 0))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .frame(width: 376, height: 300)
                        }
                    }
                }
                .navigationBarTitle("Moonshot")
                .navigationBarItems(trailing:
                    Button(self.showingDates ? "Show Crew" : "Show Dates") {
                        self.showingDates.toggle()
                    }
                )
            }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
