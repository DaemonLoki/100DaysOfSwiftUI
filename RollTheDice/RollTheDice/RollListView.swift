//
//  RollListView.swift
//  RollTheDice
//
//  Created by Stefan Blos on 08.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct RollListView: View {
    
    var date: Date
    var result: Int
    var numberOfSides: Int
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                HStack {
                    Text("\(formattedDate)")
                        .foregroundColor(.secondary)
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "cube.box.fill")
                    
                    Text("\(numberOfSides)")
                        .font(.footnote)
                        .foregroundColor(Color(.systemBackground))
                        .padding(4)
                        .background(Color.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                        .padding(4)
                }
                
                Text("\(result)")
                    .font(.largeTitle)
                    .padding(.top)
                
                
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(radius: 20)
        .padding(.vertical, 25)
        .padding(.horizontal)
        
    }
}

struct RollListView_Previews: PreviewProvider {
    static var previews: some View {
        RollListView(date: Date(), result: 4, numberOfSides: 10)
    }
}
