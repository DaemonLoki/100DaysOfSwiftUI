//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Stefan Blos on 21.02.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

let equalsPredicate = NSPredicate(format: "universe == 'Star Wars'")
let genericPredicate = NSPredicate(format: "universe == %@", "Star Wars")
let smallerPredicate = NSPredicate(format: "name < %@", "F")
let inPredicate = NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
let beginsWithPredicate = NSPredicate(format: "name BEGINSWITH %@", "E")
let ignoringCaseBeginsWithPredicate = NSPredicate(format: "name BEGINSWITH[c] %@", "e")
let negatedPredicate = NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: equalsPredicate) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown ship")
            }
            
            Button("Add examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
