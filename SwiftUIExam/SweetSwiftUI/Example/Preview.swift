//
//  Preview.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/06.
//

import SwiftUI

struct Preview: View {
    var body: some View {
        List {
            Text("Hello SwiftUI")
            Image("167")
        }
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14", "iPhone 14 Pro"], id: \.self) {
            Preview().previewDevice(PreviewDevice(rawValue: $0))
                .previewDisplayName($0)
        }
    }
}
