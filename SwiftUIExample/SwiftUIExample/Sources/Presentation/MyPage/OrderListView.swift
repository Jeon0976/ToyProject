//
//  OrderListView.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/30/24.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ZStack {
            if store.orders.isEmpty {
                emptyOrders
            } else {
                orderList
            }
        }
        .animation(.default, value: UUID())
        .navigationTitle("주문 목록")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            ToolbarItem(placement: .topBarTrailing) {
                editButton
            }
        }
    }
}

private extension OrderListView {
    var emptyOrders: some View {
        VStack(spacing: 25) {
            Image("box")
                .renderingMode(.template)
                .foregroundStyle(.gray.opacity(0.4))
            Text("주문 내역이 없습니다.")
                .font(.headline).fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    var orderList: some View {
        List {
            ForEach(store.orders) {
                OrderRow(order: $0)
            }
            .onDelete(perform: store.deleteOrder(at:))
            .onMove(perform: store.moveOrder(from:to:))
        }
    }
    
    var editButton: some View {
        !store.orders.isEmpty ? AnyView(EditButton()) : AnyView(EmptyView())
    }
}
#Preview {
    OrderListView().environmentObject(Store())
}
