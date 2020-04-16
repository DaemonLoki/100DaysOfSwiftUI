//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Stefan Blos on 15.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    
    public var wrappedTitle: String {
        
        get {
            self.title ?? "Unknown value"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        
        get {
            self.subtitle ?? "Unkown value"
        }
        
        set {
            subtitle = newValue
        }
    }
    
}
