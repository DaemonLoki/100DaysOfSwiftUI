//
//  ContentView.swift
//  Drawing
//
//  Created by Stefan Blos on 12.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: TriangleView()) {
                    Text("Triangle")
                        .font(.title)
                }
                .padding()
                
                NavigationLink(destination: ArcView()) {
                    Text("Arc")
                        .font(.title)
                }
                
                Spacer()
            }
            .navigationBarTitle("Drawing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
