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
    
    @State private var showingDates = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                return NavigationLink(destination: MissionView(mission: mission, missions: self.missions, astronauts: self.astronauts)) {
                    MissionRow(mission: mission, astronauts: self.astronauts, showingDates: self.$showingDates)
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(self.showingDates ? "Show Crew" : "ShowDates") {
                    self.showingDates.toggle()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
