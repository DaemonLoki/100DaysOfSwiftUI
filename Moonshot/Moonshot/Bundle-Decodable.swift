//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Stefan Blos on 11.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import Foundation

extension Bundle {
    
    func decode(_ file: String) -> [Astronaut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode([Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
    
}
