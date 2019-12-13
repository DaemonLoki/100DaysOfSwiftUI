//
//  ImageFrameView.swift
//  Drawing
//
//  Created by Stefan Blos on 13.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ImageFrameView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: 300, height: 300)
                .border(ImagePaint(image: Image("meetup_talk"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("meetup_talk"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 200)
        }
    }
}

struct ImageFrameView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFrameView()
    }
}
