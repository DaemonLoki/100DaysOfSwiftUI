//
//  ArrowView.swift
//  Drawing
//
//  Created by Stefan Blos on 15.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(CGRect(x: rect.midX / 2, y: rect.midY, width: rect.width / 2, height: rect.width / 2))
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.midY))
        
        return path
    }
}

struct ArrowView: View {
    var body: some View {
        Arrow()
            .frame(width: 300, height: 300)
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
