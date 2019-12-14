//
//  SpecialEffectsView.swift
//  Drawing
//
//  Created by Stefan Blos on 14.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct SpecialEffectsView: View {
    var body: some View {
        Image("meetup_talk")
            .resizable()
            .scaledToFill()
            .colorMultiply(.red)
    }
}

struct SpecialEffectsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectsView()
    }
}
