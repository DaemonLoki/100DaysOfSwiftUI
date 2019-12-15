//
//  ContentView.swift
//  Drawing
//
//  Created by Stefan Blos on 12.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Group {
                        NavigationLink(destination: ArrowView()) {
                            Text("Arrow")
                                .font(.title)
                        }
                        .padding()
                        
                        NavigationLink(destination: TriangleView()) {
                            Text("Triangle")
                                .font(.title)
                        }
                        .padding()
                        
                        NavigationLink(destination: ArcView()) {
                            Text("Arc")
                                .font(.title)
                        }
                        .padding()
                        
                        NavigationLink(destination: FlowerView()) {
                            Text("Flower")
                                .font(.title)
                        }
                        .padding()
                    }
                    
                    NavigationLink(destination: ImageFrameView()) {
                        Text("Image Frame")
                            .font(.title)
                    }
                    .padding()
                    
                    NavigationLink(destination: ColorCircleView()) {
                        Text("Color Circle")
                            .font(.title)
                    }
                    .padding()
                    
                    NavigationLink(destination: SpecialEffectsView()) {
                        Text("Special Effects")
                            .font(.title)
                    }
                    .padding()
                    
                    NavigationLink(destination: BlurSaturationView()) {
                        Text("Blur / Saturation")
                            .font(.title)
                    }
                    .padding()
                    
                    NavigationLink(destination: TrapezoidView()) {
                        Text("Trapezoid")
                            .font(.title)
                    }
                    .padding()
                    
                    NavigationLink(destination: CheckerboardView()) {
                        Text("Checkerboard")
                            .font(.title)
                    }
                    .padding()
                    
                    NavigationLink(destination: SpirographView()) {
                        Text("Spirograph")
                            .font(.title)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Drawing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
