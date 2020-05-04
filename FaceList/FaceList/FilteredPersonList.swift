//
//  FilteredPersonList.swift
//  FaceList
//
//  Created by Stefan Blos on 28.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredPersonList<T: NSManagedObject, Content: View>: View {
    
    var fetchRequest: FetchRequest<T>
    var persons: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { person in
            self.content(person)
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [])
        self.content = content
    }
}
