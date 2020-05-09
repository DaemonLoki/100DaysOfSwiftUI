//
//  MapView.swift
//  FaceList
//
//  Created by Stefan Blos on 09.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var name: String
    var latitude: Double
    var longitude: Double
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        mapView.setCenter(location, animated: true)

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
    }
}
