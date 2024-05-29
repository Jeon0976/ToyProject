//
//  ShrinkButtonStyle.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/28/24.
//

import SwiftUI

struct ShrinkButtonStyle: ButtonStyle {
    var minScale: CGFloat = 0.95
    var minOpacity: Double = 0.8
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? minScale : 1)
            .opacity(configuration.isPressed ? minOpacity : 1)
    }
}
