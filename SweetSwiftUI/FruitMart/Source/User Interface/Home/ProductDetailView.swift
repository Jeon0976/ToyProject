//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/05.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject private var store: Store
    
    let product: Product
    
    @State private var quantity: Int = 1
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            productImage
            orderView
        }
        .modifier(Popup(size: CGSize(width: 200, height: 200),
                        style: .dimmed,
                        message: Text("팝업")
                       )
        )
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingAlert) {
            confirmAlert
        }

    }
}

private extension ProductDetailView {
    var productImage: some View {
        GeometryReader { _ in
            ResizedImage(self.product.imageName)
        }
    }
    
    var orderView: some View {
      GeometryReader {
        VStack(alignment: .leading) {
          self.productDescription
          Spacer()
          self.priceInfo
          self.placeOrderButton
        }
        .padding(32)
        .frame(height: $0.size.height + 10)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
      }
    }

    var productDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(product.name)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                Spacer()
                
                FavoriteButton(product: product)
            }
            
            Text(product.description.splitText())
                .foregroundColor(.secondaryText)
                .fixedSize()
        }
    }
    
    var priceInfo: some View {
        let price = quantity * product.price
        
        // 통화 기호는 작게 나타내고 가격만 더 크게 표시
        return HStack {
            (Text("₩") + Text("\(price)").font(.title)).fontWeight(.medium)
            
            Spacer()
            
            QuantitySelector(quantity: $quantity)
        }.foregroundColor(.black)
    }
    
    var placeOrderButton: some View {
        Button(action: { self.showingAlert = true }) {
            Capsule()
                .fill(Color.peach)
            // 너비는 주어진 공간을 최대로 사용하고 높이는 최소, 최대치 지정
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(Text("주문하기"))
                .font(.system(size: 20))
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .padding(.vertical, 8)
        }
        .buttonStyle(ShrinkButtonStyle())
    }
    
    var confirmAlert: Alert {
        Alert(
            title: Text("주문 확인"),
            message: Text("\(product.name)을(를) \(quantity)개 구매하겠습니까?"),
            primaryButton: .default(Text("확인"), action: {
                self.placeOrder()
            }),
            secondaryButton: .cancel(Text("취소"))
        )
    }
    
    func placeOrder() {
        store.placeOrder(product: product, quantity: quantity)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
       let source1 = ProductDetailView(product: Product(
                name: "Test",
                imageName: "fig",
                price: 1000,
                description: "테스트~ 테스트~ 망고를~~ 유혹하네"
            )
        )
        return Group {
            Preview(source: source1)
        }

    }
}
