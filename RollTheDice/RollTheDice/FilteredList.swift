//
//  FilteredList.swift
//  RollTheDice
//
//  Created by Stefan Blos on 07.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    var fetchRequest: FetchRequest<T>
    var rolls: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { roll in
            self.content(roll)
        }
    }
    
    init(@ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Roll.timeRolled, ascending: false)])
        self.content = content
    }
}
