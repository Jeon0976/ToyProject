//
//  ObservableObjectTest.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/07.
//

import SwiftUI

struct ObservableObjectTest: View {
    @ObservedObject var user: User
    
    var body: some View {
        VStack(spacing: 30) {
            Text(user.name)
            
            Button(action: { self.user.score += 1 }) {
                Text(user.score.description)
            }
        }
    }
}

struct ObservableObjectTest_Previews: PreviewProvider {
    static var previews: some View {
        ObservableObjectTest(user: User())
    }
}

class User: ObservableObject {
    @Published var name = "User Name"
    @Published var score = 0
}
