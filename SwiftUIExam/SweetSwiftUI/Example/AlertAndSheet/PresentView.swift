//
//  PresentView.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/07.
//

import SwiftUI

struct PresentView: View {
    @Environment(\.dismiss) private var dismsissTest
    
    var body: some View {
        Button(action: {
            dismsissTest()
        }) {
            Text("Tap to Dismiss")
                .font(.title)
                .foregroundColor(.red)
        }
    }
}

struct PresentView_Previews: PreviewProvider {
    static var previews: some View {
        PresentView()
    }
}
