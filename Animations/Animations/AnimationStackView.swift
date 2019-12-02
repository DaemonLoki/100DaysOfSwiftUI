//
//  AnimationStackView.swift
//  Animations
//
//  Created by Stefan Blos on 02.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct AnimationStackView: View {
    @State private var enabled = false
    
    var body: some View {
        Button("Tap me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .animation(.default)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60: 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct AnimationStackView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationStackView()
    }
}
