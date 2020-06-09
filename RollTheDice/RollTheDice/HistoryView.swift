//
//  HistoryView.swift
//  RollTheDice
//
//  Created by Stefan Blos on 07.06.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    
    var body: some View {
        FilteredList { (roll: Roll) in
            RollListView(date: roll.timeRolled, result: Int(roll.result), numberOfSides: Int(roll.numberOfSides))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
