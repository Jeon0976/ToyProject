//
//  VIewModifierExample.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/08.
//

import SwiftUI


struct VIewModifierExample: View {
    var body: some View {
        VStack {
            Text("Test")
                .modifier(CustomViewModifire(borderColor: .blue))
            Text("TEST")
                .modifier(CustomViewModifire())
            ModifiedContent(content: Text("테스트입니다."), modifier: CustomViewModifire(borderColor: .green))
            Text("Test2")
                .customModifier()
        }
    }
}

extension View {
    func customModifier(borderColor: Color = .black) -> some View {
        self.modifier(CustomViewModifire(borderColor: borderColor))
    }
}

struct VIewModifierExample_Previews: PreviewProvider {
    static var previews: some View {
        VIewModifierExample()
    }
}


struct CustomViewModifire: ViewModifier {
    var borderColor: Color = .red
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(Color.white)
            .padding()
            .background(Rectangle().fill(Color.gray))
            .border(borderColor, width: 2)
    }
}
