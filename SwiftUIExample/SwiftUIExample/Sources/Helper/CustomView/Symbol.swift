//
//  Symbol.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/28/24.
//

import SwiftUI

struct Symbol: View {
    let systemName: String
    let imageScale: Image.Scale
    let color: Color?
    
    init(
        _ systemName: String,
        imageScale: Image.Scale = .large,
        color: Color? = nil
    ) {
        self.systemName = systemName
        self.imageScale = imageScale
        self.color = color
    }
    
    var body: some View {
        if let color = color {
            Image(systemName: systemName)
                .imageScale(imageScale)
                .foregroundStyle(color)
        } else {
            Image(systemName: systemName)
                .imageScale(imageScale)
        }
    }
}
