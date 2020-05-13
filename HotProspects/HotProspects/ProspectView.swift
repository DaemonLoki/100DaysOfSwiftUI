//
//  ProspectView.swift
//  HotProspects
//
//  Created by Stefan Blos on 12.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectView: View {
    
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    @State private var sortingType: SortType = .none
    @State private var isShowingFilterSheet = false
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortType {
        case none, name, recent
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
        let sortedPeople = prospects.people.sorted {
            switch self.sortingType {
            case .none:
                return true
            case .name:
                return $0.name > $1.name
            case .recent:
                return $0.dateAdded > $1.dateAdded
            }
        }
        
        switch filter {
        case .none:
            return sortedPeople
        case .contacted:
            return sortedPeople.filter { $0.isContacted }
        case .uncontacted:
            return sortedPeople.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        if self.filter == .none {
                            Image(systemName: prospect.isContacted ? "checkmark.circle" : "xmark.circle")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundColor(prospect.isContacted ? .green : .red)
                                .animation(.default)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: {
                self.isShowingFilterSheet = true
            }) {
                Text("Sort")
                }, trailing:
                Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
            })
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: self.$isShowingFilterSheet) {
                ActionSheet(title: Text("Filter by"), message: nil, buttons: [
                    .default(Text("None"), action: {
                        self.sortingType = .none
                    }),
                    .default(Text("Name"), action: {
                        self.sortingType = .name
                    }),
                    .default(Text("Recent"), action: {
                        self.sortingType = .recent
                    }),
                    .cancel(Text("Cancel"))
                ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed! Reason: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectView(filter: .none)
    }
}
