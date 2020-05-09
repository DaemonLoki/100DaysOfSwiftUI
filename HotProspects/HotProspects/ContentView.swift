//
//  ContentView.swift
//  HotProspects
//
//  Created by Stefan Blos on 09.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is: \(updater.value)")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
