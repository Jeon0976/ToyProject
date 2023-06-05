//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/05.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var 수량test = 0
    
    var body: some View {
        VStack(spacing: 0) {
            productImage
            orderView
        }
        .edgesIgnoringSafeArea(.top)
    }
}

private extension ProductDetailView {
    var productImage: some View {
        GeometryReader { _ in
            Image(self.product.imageName)
                .resizable()
                .scaledToFill()
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
                
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundColor(Color.peach)
                    .frame(width: 32, height: 32)
            }
            
            Text(product.description.splitText())
                .foregroundColor(.secondaryText)
                .fixedSize()
        }
    }
    
    var priceInfo: some View {
        // 통화 기호는 작게 나타내고 가격만 더 크게 표시
        HStack {
            (Text("₩") + Text("\(product.price)").font(.title)).fontWeight(.medium)
            
            Spacer()
            
            // 추후 다시 구현 예정
            HStack {
                Button(action: {
                    if 수량test == 0 {
                        return
                    } else {
                        수량test -= 1
                    }}) {
                    Text("-")
                }
                Text("\(수량test)")
                
                Button(action: { 수량test += 1}) {
                    Text("+")
                }
            }
        }
    }
    
    var placeOrderButton: some View {
        Button(action: { print("Test") }) {
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
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(name: "Test", imageName: "fig", price: 1000, description: "테스트~ 테스트~ 망고를~~ 유혹하네"))
    }
}
