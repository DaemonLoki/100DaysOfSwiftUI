//
//  RollsViewModel.swift
//  RollTheDice
//
//  Created by Stefan Blos on 06.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class RollsViewModel {
    
    //@Environment(\.managedObjectContext) var moc
    
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func addRoll(result: Int, numberOfSides: Int) {
        let newRoll = Roll(context: moc)
        newRoll.result = Int16(result)
        newRoll.numberOfSides = Int16(numberOfSides)
        newRoll.timeRolled = Date()
        
        do {
            try moc.save()
        } catch {
            print("Error occurred: \(error)")
        }
        
    }
    
}
