//
//  ContentView.swift
//  BucketList
//
//  Created by Stefan Blos on 12.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        
        ZStack {
            MapView()
                .edgesIgnoringSafeArea(.all)
            
            if !isUnlocked {
                Color.white.blur(radius: 10).animation(.easeInOut).edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            self.authenticate()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        print(authenticationError?.localizedDescription ?? "Error occurred.")
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
