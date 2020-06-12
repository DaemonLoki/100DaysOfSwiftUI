//
//  Resort.swift
//  SnowSeeker
//
//  Created by Stefan Blos on 10.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static func string(for size: Int) -> String {
        switch size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
