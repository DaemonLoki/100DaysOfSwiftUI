//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Stefan Blos on 27.02.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case beginsWithIgnoringCapitalization = "BEGINSWITH[c]"
    case equals = "=="
    case smallerThan = "<"
    case biggerThan = ">"
    case contains = "IN"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor] = [], predicate: Predicate = .beginsWith, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(items, id: \.self) { listItem in
            self.content(listItem)
        }
    }
}
