//
//  OrderStruct.swift
//  CupcakeCorner
//
//  Created by Stefan Blos on 10.02.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import Foundation

class Orders: ObservableObject {
    @Published var order: OrderStruct
    
    init() {
        self.order = OrderStruct()
    }
}

struct OrderStruct: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    // Order details
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled: Bool = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    // Address details
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isOnlyWhitespace || streetAddress.isOnlyWhitespace || city.isOnlyWhitespace || zip.isOnlyWhitespace {
            return false
        }
        return true
    }
    
    var cost: Double {
        // 2 $ per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // 1$ / cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // 0.50 $ / cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
