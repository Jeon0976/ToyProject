//
//  MyVStack.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

struct MyVStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            content
        }
    }
}


#Preview {
    MyVStack {
        Text("tesadwdkawdawddawdawddwdddt")
        Text("test")
        Text("test")
        Text("test")
        Text("test")
        Text("test")
        Text("test")
        Text("test")
        Text("test")
        Text("test")
        Text("test")

    }
}
