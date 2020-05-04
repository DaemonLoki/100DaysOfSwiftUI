//
//  UIImage+IO.swift
//  FaceList
//
//  Created by Stefan Blos on 28.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

extension UIImage {
    
    func writeToDisk() -> String? {
        if let data = self.jpegData(compressionQuality: 0.8) {
            let imageId = UUID().uuidString
            let fileName = getDocumentsDirectory().appendingPathComponent("\(imageId).jpeg")
            try? data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
            return imageId
        }
        return "Wave006"
    }
    
    static func loadFromDisk(with name: String) -> UIImage {
        let imageUrl = getDocumentsDirectory().appendingPathComponent("\(name).jpeg")
        return UIImage(contentsOfFile: imageUrl.path) ?? UIImage(named: "Wave006")!
    }
    
    
}
