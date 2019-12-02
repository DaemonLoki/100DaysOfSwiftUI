//
//  CardDragAnimation.swift
//  Animations
//
//  Created by Stefan Blos on 02.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct CardDragAnimation: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged {
                        self.dragAmount = $0.translation
                    }
                .onEnded { _ in withAnimation(.spring()) {
                    self.dragAmount = .zero }
                }
            )
    }
}

struct CardDragAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CardDragAnimation()
    }
}
