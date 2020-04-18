//
//  ContentView.swift
//  BucketList
//
//  Created by Stefan Blos on 12.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentView: View {
    
    @State private var isUnlocked = true
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var showingAuthenticationError = false
    @State private var authenticationErrorString = "An error occurred."
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            if isUnlocked {
                MyMapView(centerCoordinate: self.$centerCoordinate, selectedPlace: self.$selectedPlace, showingPlaceDetails: self.$showingPlaceDetails, locations: self.$locations, showingEditScreen: self.$showingEditScreen)
                    .cornerRadius(showingPlaceDetails ? 20 : 0)
                    .rotation3DEffect(.degrees(showingPlaceDetails ? 10 : 0), axis: (x: -1, y: 0, z: 0))
                    .scaleEffect(showingPlaceDetails ? 0.8 : 1)
                    .offset(x: 0, y: showingPlaceDetails ? -250 : 0)
                    .shadow(radius: showingPlaceDetails ? 20 : 0)
                    .animation(.easeInOut)
                    .edgesIgnoringSafeArea(showingPlaceDetails ? [] : .all)
                
                PlaceDetailView(title: selectedPlace?.title ?? "Unknown", subtitle: selectedPlace?.subtitle ?? "Missing place information.", showingEditScreen: self.$showingEditScreen)
                    .offset(x: 0, y: showingPlaceDetails ? 150 : 700)
                    .animation(.easeInOut )
                    .gesture(TapGesture()
                        .onEnded({ _ in
                            if self.showingPlaceDetails {
                                self.showingPlaceDetails = false
                            }
                        }))
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
        }
            
            
        .alert(isPresented: self.$showingAuthenticationError) {
            Alert(title: Text("Authentication error"), message: Text(self.authenticationErrorString), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: self.$showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear {
            self.loadData()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.authenticationErrorString = authenticationError?.localizedDescription ?? "Error occurred."
                        self.showingAuthenticationError = true
                    }
                }
                
            }
        } else {
            self.authenticationErrorString = "No biometric validation found."
            self.showingAuthenticationError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
