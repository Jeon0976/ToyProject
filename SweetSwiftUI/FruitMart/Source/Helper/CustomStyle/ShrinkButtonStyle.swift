//
//  ShrinkButtonStyle.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/09.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import SwiftUI

struct ShrinkButtonStyle: ButtonStyle {
    var minScale: CGFloat = 0.9
    var minOpacity: Double = 0.6
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? minScale : 1)
            .opacity(configuration.isPressed ? minOpacity : 1)
    }
}
