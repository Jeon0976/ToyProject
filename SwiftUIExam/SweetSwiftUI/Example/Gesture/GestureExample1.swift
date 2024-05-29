//
//  GestureExample1.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct GestureExample1: View {
    @GestureState private var translation: CGSize = .zero
    @State private var position: CGSize = .zero
    
    var body: some View {
        let gesture = DragGesture()
            .updating($translation) { (value, state, _) in
                state = value.translation
            }
            .onEnded { value in
                position.width += value.translation.width
                position.height += value.translation.height
                print("--")

                print(position.width)
                print(value.translation.width)
                print("--")

            }
        
        Circle()
            .frame(width: 100, height: 100)
            .offset(translation)
            .offset(position)
            .gesture(gesture)
    }
}

#Preview {
    GestureExample1()
}
