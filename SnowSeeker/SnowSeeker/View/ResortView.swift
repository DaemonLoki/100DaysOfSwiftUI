//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Stefan Blos on 11.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                CopyrightImage(imageId: resort.id, imageCredit: resort.imageCredit)
                
                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            
                            VStack { ResortDetailsView(resort: resort) }
                            
                            VStack { SkiDetailsView(resort: resort) }
                            
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            
                            Spacer()
                                .frame(height: 0)
                            
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                                        
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
        }
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: .example)
    }
}
