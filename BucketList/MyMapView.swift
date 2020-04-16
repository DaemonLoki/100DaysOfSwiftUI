//
//  MyMapView.swift
//  BucketList
//
//  Created by Stefan Blos on 17.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import MapKit

struct MyMapView: View {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var showingEditScreen: Bool
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example location"
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.headline)
                            .clipShape(Circle())
                    }
                    .padding(.trailing)
                    
                }
            }
        }
    }
}

struct MyMapView_Previews: PreviewProvider {
    static var previews: some View {
        MyMapView(centerCoordinate: .constant(CLLocationCoordinate2D(latitude: 51.3, longitude: 0.13)), selectedPlace: .constant(nil), showingPlaceDetails: .constant(false), locations: .constant([CodableMKPointAnnotation]()), showingEditScreen: .constant(false))
    }
}
