//
//  animation+Extension.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

extension View {
    func withoutAnimation() -> some View {
        self.animation(nil, value: UUID())
    }
}
