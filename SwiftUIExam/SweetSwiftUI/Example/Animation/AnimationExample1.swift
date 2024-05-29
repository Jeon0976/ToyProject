//
//  AnimationExample1.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct AnimationExample1: View {
    @State private var blur: Bool = false
    @State private var reduction: Bool = false
    
    var body: some View {
        Image("167")
            .blur(radius: blur ? 5 : 0)
            .animation(.default.speed(2).repeatCount(5, autoreverses: true), value: blur)
            .scaleEffect(reduction ? 0.7 : 1)
            .animation(.default.delay(1), value: reduction)
            .onTapGesture {
                self.reduction.toggle()
                self.blur.toggle()
            }
    }
}

#Preview {
    AnimationExample1()
}
