//
//  BottomSheetView.swift
//  SnowSeeker
//
//  Created by Stefan Blos on 12.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct BottomSheetView: View {
    
    @EnvironmentObject var viewModel: ResortsViewModel
    
    @Binding var bottomSheetOffset: CGFloat
    @Binding var filterTypeSelected: ResortsViewModel.FilterType
    
    var selectText: String {
        switch filterTypeSelected {
        case .country:
            return "country"
        case .price:
            return "price"
        case .size:
            return "size"
        default:
            return "value"
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Select a \(selectText):")
                .font(.headline)
            if self.filterTypeSelected == .country {
                ForEach(viewModel.countries, id: \.self) { country in
                    Image(country)
                    .resizable()
                    .scaledToFill()
                        .frame(width: 90, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .onTapGesture {
                            self.bottomSheetOffset = ContentView.defaultOffset
                            self.viewModel.filter(.country, by: country)
                            
                    }
                }
            }
            
            if self.filterTypeSelected == .size {
                ForEach(viewModel.sizes, id: \.self) { size in
                    Text("\(Resort.string(for: size))")
                        .font(.subheadline)
                        .onTapGesture {
                            self.bottomSheetOffset = ContentView.defaultOffset
                            self.viewModel.filter(.size, by: "\(size)")
                    }
                }
            }
            
            if self.filterTypeSelected == .price {
                ForEach(viewModel.prices, id: \.self) { price in
                    Text(String(repeating: "$", count: price))
                        .font(.subheadline)
                        .onTapGesture {
                            self.bottomSheetOffset = ContentView.defaultOffset
                            self.viewModel.filter(.price, by: "\(price)")
                    }
                }
            }
            
        }
            .padding(40)
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white))
            .shadow(radius: 20)
    }
}
