//
//  ResortsViewModel.swift
//  SnowSeeker
//
//  Created by Stefan Blos on 12.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

class ResortsViewModel: ObservableObject {
    
    private var resorts: [Resort]
    
    var resortList: [Resort] {
        self.resorts
    }
    
    var countries: [String] {
        Array(Set(self.resorts
            .map { $0.country }))
    }
    
    var prices: [Int] {
        Array(Set(self.resorts
            .map { $0.price }))
    }
    
    var sizes: [Int] {
        Array(Set(self.resorts
            .map { $0.size }))
    }
    
    private var isFiltering = false
    private var isSorted = false
    
    init() {
        self.resorts = []
        self.resorts = loadResorts()
    }
    
    private func loadResorts() -> [Resort] {
        return Bundle.main.decode("resorts.json")
    }
    
    func sort(by method: SortingMethod) {
        objectWillChange.send()
        switch method {
        case .alphabetical:
            self.resorts.sort { $0.name < $1.name }
        case .country:
            self.resorts.sort { $0.country < $1.country}
        default:
            self.resorts = loadResorts()
        }
    }
    
    func filter(_ type: FilterType, by value: String) {
        objectWillChange.send()
        switch type {
        case .country:
            self.resorts = self.resorts.filter { $0.country == value }
        case .size:
            self.resorts = self.resorts.filter { $0.size == Int(value) }
        case .price:
            self.resorts = self.resorts.filter { $0.price == Int(value) }
        case .none:
            self.resorts = loadResorts()
        }
    }
    
    enum FilterType {
        case country, size, price, none
    }
    
    enum SortingMethod {
        case standard, alphabetical, country
    }
}
