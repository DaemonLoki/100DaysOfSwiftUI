//
//  ProspectView.swift
//  HotProspects
//
//  Created by Stefan Blos on 12.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ProspectView: View {
    
    @EnvironmentObject var prospects: Prospects
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(title)
                .navigationBarItems(trailing: Button(action: {
                    let prospect = Prospect()
                    prospect.name = "Paul Hudson"
                    prospect.emailAddress = "paul@hackingwithswift.com"
                    self.prospects.people.append(prospect)
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
        }
    }
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectView(filter: .none)
    }
}
