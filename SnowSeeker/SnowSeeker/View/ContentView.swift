//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Stefan Blos on 09.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ShowingSheet: Identifiable {
    var id = UUID()
    var sheetType: SheetType
}

enum SheetType: CaseIterable {
    case filtering, sorting
}

struct ContentView: View {
    
    @ObservedObject var favorites = Favorites()
    @ObservedObject var viewModel = ResortsViewModel()
    
    @State private var showSortingSheet = false
    @State private var showFilterSheet = false
    
    @State private var actionSheet: ActionSheet? = ActionSheet(title: Text("Hey"))
    @State private var showingSheet: ShowingSheet? = nil
    
    @State private var bottomSheetOffset: CGFloat = ContentView.defaultOffset
    @State private var filterTypeSelected: ResortsViewModel.FilterType = .country
    
    static var defaultOffset: CGFloat = 800
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.resortList) { resort in
                    NavigationLink(destination: ResortView(resort: resort)) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1))
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        .layoutPriority(1)
                        
                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                    }
                }
                
                BottomSheetView(bottomSheetOffset: self.$bottomSheetOffset, filterTypeSelected: self.$filterTypeSelected)
                    .environmentObject(viewModel)
                    .offset(y: bottomSheetOffset)
                    .animation(.spring())
            }
            .phoneOnlyStackNavigationView()
            .navigationBarItems(leading: Button(action: {
                self.showingSheet = ShowingSheet(sheetType: .filtering)
            }, label: {
                Text("Filter")
            }), trailing:
                Button(action: {
                    self.showingSheet = ShowingSheet(sheetType: .sorting)
                }) {
                    Text("Sort")
                }
            )
                .actionSheet(item: self.$showingSheet, content: { (showingSheet: ShowingSheet) in
                    switch showingSheet.sheetType {
                    case .filtering:
                        return ActionSheet(title: Text("Filter"), message: nil, buttons: [
                            .default(Text("Country"), action: {
                                self.filterTypeSelected = .country
                                self.bottomSheetOffset = 0
                            }),
                            .default(Text("Size"), action: {
                                self.filterTypeSelected = .size
                                self.bottomSheetOffset = 0
                            }),
                            .default(Text("Price"), action: {
                                self.filterTypeSelected = .price
                                self.bottomSheetOffset = 0
                            }),
                            .default(Text("None"), action: {
                                self.viewModel.filter(.none, by: "")
                            }),
                            .destructive(Text("Cancel"))
                            ])
                    case .sorting:
                        return ActionSheet(title: Text("Sort by"), message: nil, buttons: [
                            .default(Text("Default"), action: {
                                self.applySorting(by: .standard)
                            }),
                            .default(Text("Alphabetical"), action: {
                                self.applySorting(by: .alphabetical )
                            }),
                            .default(Text("Country"), action: {
                                self.applySorting(by: .country)
                            }),
                            .destructive(Text("Cancel"))
                        ])
                        
                    }
                })
                .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    
    func applySorting(by method: ResortsViewModel.SortingMethod) {
        viewModel.sort(by: method)
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
