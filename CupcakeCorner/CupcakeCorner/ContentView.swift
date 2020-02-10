//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Stefan Blos on 27.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Orders()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Select your cake type", selection: $order.order.type) {
                            ForEach(0..<Order.types.count, id: \.self) {
                                Text(Order.types[$0])
                            }
                        }
                        
                        Stepper(value: $order.order.quantity, in: 3...20) {
                            Text("Number of cakes: \(order.order.quantity)")
                        }
                    }
                    
                    Section {
                        Toggle(isOn: $order.order.specialRequestEnabled.animation()) {
                            Text("Any special requests?")
                        }
                        
                        if order.order.specialRequestEnabled {
                            Toggle(isOn: $order.order.extraFrosting) {
                                Text("Add extra frosting")
                            }
                            
                            Toggle(isOn: $order.order.addSprinkles) {
                                Text("Add extra sprinkles")
                            }
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: AddressView(order: order)) {
                            Text("Delivery details")
                        }
                    }
                }
                
                Image("cupcake_top")
                    .colorMultiply(.yellow)
                    .offset(x: 0, y: 50)
                
                Image("cupcake_bottom")
                
                Spacer()
            }
        .navigationBarTitle("Cupcake Corner")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
