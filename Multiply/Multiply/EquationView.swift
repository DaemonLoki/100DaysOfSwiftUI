//
//  EquationView.swift
//  Multiply
//
//  Created by Stefan Blos on 06.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct EquationView: View {
    let firstNumber: Int
    let secondNumber: Int
    
    var body: some View {
        HStack {
            Text("\(firstNumber)")
                .font(Font.system(size: 80.0, weight: .black))
                .frame(width: 100)
            Text("x")
                .font(Font.system(size: 70.0, weight: .bold))
                .frame(width: 60)
            Text("\(secondNumber)")
                .font(Font.system(size: 80.0, weight: .black))
                .frame(width: 100)
        }
    }
}

struct EquationView_Previews: PreviewProvider {
    static var previews: some View {
        EquationView(firstNumber: 11, secondNumber: 8)
    }
}
