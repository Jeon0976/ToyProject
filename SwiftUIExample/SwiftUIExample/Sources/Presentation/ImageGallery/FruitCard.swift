//
//  FruitCard.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct FruitCard: View {
    let imageName: String
    let size: CGSize
    let cornerRadius: CGFloat
    
    init(
        _ imageName: String,
        size: CGSize = CGSize(width: 240, height: 200),
        cornerRadius: CGFloat = 14
    ) {
        self.imageName = imageName
        self.size = size
        self.cornerRadius = cornerRadius
    }
    var body: some View {
        ResizedImage(imageName)
            .frame(width: size.width, height: size.height)
            .clipShape(.rect(cornerRadius: cornerRadius))
    }
}

#Preview {
    FruitCard(productSamples[0].imageName)
}
