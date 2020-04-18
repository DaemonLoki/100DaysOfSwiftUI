//
//  PlaceDetailView.swift
//  BucketList
//
//  Created by Stefan Blos on 17.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct PlaceDetailView: View {
    
    var title: String
    var subtitle: String
    @Binding var showingEditScreen: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.title)
            
            Text(subtitle)
                .foregroundColor(.secondary)
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.showingEditScreen = true
                }) {
                    Image(systemName: "pencil")
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.headline)
                        .clipShape(Circle())
                }
            }
        }
        .padding(40)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(40)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            PlaceDetailView(title: "Example plase", subtitle: "More details here", showingEditScreen: .constant(false))
        }
        
    }
}
