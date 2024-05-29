//
//  OrderCompletedMessage.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/28/24.
//

import SwiftUI

struct OrderCompletedMessage: View {
    var body: some View {
        Text("주문 완료!")
            .font(.system(size: 24))
            .bold()
            .kerning(2)
    }
}

#Preview {
    OrderCompletedMessage()
}
