//
//  OrderRow.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 6/3/24.
//

import SwiftUI

struct OrderRow: View {
    let order: Order
    
    var body: some View {
        HStack {
            ResizedImage(order.product.imageName)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(order.product.name)
                    .font(.headline).fontWeight(.medium)
                Text("₩\(order.price)  |  \(order.quantity)개")
                    .font(.footnote).foregroundStyle(.secondary)
            }
        }.frame(height: 100)
    }
}

#Preview {
    OrderRow(
        order: Order(
            id: 1,
            product: Product(
                name: "test",
                imageName: "avocado",
                price: 1000,
                description: "test\ntest"
            ),
            quantity: 3
        )
    )
}
