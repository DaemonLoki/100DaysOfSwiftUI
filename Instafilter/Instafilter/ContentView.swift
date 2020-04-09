//
//  ContentView.swift
//  Instafilter
//
//  Created by Stefan Blos on 29.03.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterInputScale = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var showingFilterSheet = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    @State private var filterCardOffset: CGFloat = 300.0
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
        },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
        }
        )
        
        let radius = Binding<Double>(
            get: {
                self.filterRadius
        },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
        }
        )
        
        let inputScale = Binding<Double>(
            get: {
                self.filterInputScale
        },
            set: {
                self.filterInputScale = $0
                self.applyProcessing()
        }
        )
        
        return GeometryReader { geo in
            NavigationView {
                VStack {
                    ImageCard(image: self.image)
                        .frame(width: 300, height: 300)
                        .padding()
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                    
                    Spacer()
                    
                    FilterCard(intensity: intensity, radius: radius, inputScale: inputScale, currentFilter: self.currentFilter, cardWidth: geo.size.width * 0.9)
                    
                    HStack {
                        FilterButton(showingFilterSheet: self.$showingFilterSheet, filterName: self.currentFilter.name)
                            .shadow(radius: 5)
                        
                        Spacer()
                        
                        SaveButton(showingError: self.$showingError, errorMessage: self.$errorMessage, processedImage: self.processedImage)
                            .shadow(radius: 5)
                    }
                }
                .padding([.horizontal, .bottom])
                .navigationBarTitle("Instafilter")
                .sheet(isPresented: self.$showingImagePicker, onDismiss: self.loadImage) {
                    ImagePicker(image: self.$inputImage)
                }
                .actionSheet(isPresented: self.$showingFilterSheet) {
                    ActionSheet(title: Text("Select a filter"), buttons: [
                        .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                        .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                        .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                        .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                        .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                        .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                        .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    ])
                }
                .alert(isPresented: self.$showingError) { () -> Alert in
                    Alert(title: Text("Error"), message: Text(self.errorMessage))
                }
                .accentColor(.white)
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut.speed(0.25)) {
                self.filterCardOffset = 100
            }
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterInputScale * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
}

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingwitError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
