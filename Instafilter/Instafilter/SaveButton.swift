//
//  SaveButton.swift
//  Instafilter
//
//  Created by Stefan Blos on 09.04.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct SaveButton: View {
    
    @Binding var showingError: Bool
    @Binding var errorMessage: String
    var processedImage: UIImage?
    
    @State private var isSaving = false
    @State private var offsetX: CGFloat = 100.0
    
    var body: some View {
        Group {
            ZStack {
                Image(systemName: "checkmark")
                    .foregroundColor(Color(red: 231 / 255.0, green: 211 / 255.0, blue: 159 / 255.0))
                    .frame(width: 30, height: 30)
                    .opacity(isSaving ? 1.0 : 0.0)
                    .scaleEffect(isSaving ? 2.0 : 0.0)
                    .animation(.easeInOut)
                
                Button(action: saveImage, label: {
                    Image(systemName: "folder")
                        .frame(width: 30, height: 30)
                        .opacity(isSaving ? 0.0 : 1.0)
                        .animation(.easeInOut)
                    
                })
            }
            .background(
                Rectangle()
                    .fill(Color(red: 251 / 255.0, green: 123 / 255.0, blue: 107 / 255.0).opacity(0.8))
                    .frame(width: 150, height: 150)
                    .cornerRadius(20)
                    .offset(x: 40, y: 40)
            )
        }
    .offset(x: offsetX, y: 0)
        .animation(Animation.easeInOut.speed(0.5))
        .onAppear {
            self.offsetX = 0
        }
    }
    
    func saveImage() {
        self.isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSaving = false
        }
        
        guard let processedImage = self.processedImage else {
            self.showingError = true
            self.errorMessage = "Please select an image first by touching the grey area."
            return
        }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            self.errorMessage = $0.localizedDescription
            self.showingError = true
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

struct SaveButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveButton(showingError: Binding.constant(true), errorMessage: Binding.constant("Test"), processedImage: nil)
    }
}
