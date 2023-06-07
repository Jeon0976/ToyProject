//
//  StateBinding.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/07.
//

import SwiftUI

struct StateBinding: View {
    @State private var isFavorite = true
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Toggle(isOn: $isFavorite) {
                Text("isFavorite: \(isFavorite.description)")
            }
            Stepper("Count: \(count)", value: $count)
        }
    }
}

struct StateBinding_Previews: PreviewProvider {
    static var previews: some View {
        StateBinding()
    }
}
