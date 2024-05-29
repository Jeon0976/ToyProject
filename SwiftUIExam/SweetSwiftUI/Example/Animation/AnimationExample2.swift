//
//  AnimationExample2.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct AnimationExample2: View {
    @State private var showText = false
    
    var body: some View {
        if showText {
            Text("Transition")
                .font(.largeTitle)
                .padding()
                .transition(.scale)
            Circle()
        }
        
        Button("Display Text on/off") {
            withAnimation {
                self.showText.toggle()
            }
        }.font(.title)
    }
}

#Preview {
    AnimationExample2()
}
