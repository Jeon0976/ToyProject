//
//  ResizedImage.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/09.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import SwiftUI

struct ResizedImage: View {
    let imageName: String
    let contentMode: ContentMode
    let renderingMode: Image.TemplateRenderingMode?
    
    init(_ imageName: String, contentMode: ContentMode = .fill, renderingMode: Image.TemplateRenderingMode? = nil) {
        self.imageName = imageName
        self.contentMode = contentMode
        self.renderingMode = renderingMode
    }
    
    var body: some View {
        Image(imageName)
            .renderingMode(renderingMode)
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}
