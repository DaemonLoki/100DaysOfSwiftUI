//
//  ContentView.swift
//  Animations
//
//  Created by Stefan Blos on 02.12.19.
//  Copyright © 2019 Stefan Blos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let animationList: [(String, Color)] = [
        ("Implicit Animation", Color.blue),
        ("Animation Bindings", Color.red),
        ("Explicit Animation", Color.green),
        ("Animation Stack", Color.orange),
        ("Card Drag", Color.gray),
        ("Letter animations", Color.purple),
        ("Show Hide transitions", Color.pink),
        ("Custom transitions", Color.yellow)
    ]
    
    let animationViews: [Any] = [
        ImplicitAnimationView.self,
        AnimationBindingView.self,
        ExplicitAnimationView.self,
        AnimationStackView.self,
        CardDragAnimation.self,
        LetterAnimationView.self,
        ShowHideTransition.self,
        CustomTransitionView.self
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0 ..< 8, id: \.self) { number in
                            GeometryReader { geometry in
                                NavigationLink(destination: self.buildView(index: number)) {
                                    Text(self.animationList[number].0.replacingOccurrences(of: " ", with: "\n"))
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                        .frame(width: 200, height: 300)
                                        .background(self.animationList[number].1)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 5)
                                        .rotation3DEffect(.degrees(Double(geometry.frame(in: .global).minX) - 40) / -10, axis: (x: 10, y: 10, z: 10))
                                }
                            }
                            .frame(width: 200, height: 400)
                        }
                    }
                    .padding(40)
                }
                
                Spacer()
            }.navigationBarTitle("Animation examples")
        }
    }
    
    func buildView(index: Int) -> AnyView {
        switch animationViews[index].self {
        case is ImplicitAnimationView.Type:
            return AnyView(ImplicitAnimationView())
        case is AnimationBindingView.Type:
            return AnyView(AnimationBindingView())
        case is ExplicitAnimationView.Type:
            return AnyView(ExplicitAnimationView())
        case is AnimationStackView.Type:
            return AnyView(AnimationStackView())
        case is CardDragAnimation.Type:
            return AnyView(CardDragAnimation())
        case is LetterAnimationView.Type:
            return AnyView(LetterAnimationView())
        case is ShowHideTransition.Type:
            return AnyView(ShowHideTransition())
        case is CustomTransitionView.Type:
            return AnyView(CustomTransitionView())
        default:
            return AnyView(ImplicitAnimationView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
