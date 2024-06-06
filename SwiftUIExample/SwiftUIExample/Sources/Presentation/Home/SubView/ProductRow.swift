//
//  ProductRow.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var store: Store
    
    @Binding var quickOrder: Product?
    
    @State private var willAppear: Bool = false
    
    let product: Product
    
    /// UIKit에서는 뷰의 설정을 바꾸거나 자식 뷰를 추가한다고 그 자신의 타입이 바뀌는 것은 아니었지만, 구조체를 사용하고 제네릭을 적극적으로 활용하는 SwiftUI의 구현 방식에서는
    /// 뷰를 추가하거나 변경할 때마다 새로운 타입이 만들어지고 있기 때문에, 불투명 타입인 some 사용
    /// 제네릭은 코드를 호출하는 측에서 호출되는 측의 타입을 결정한다.
    /// 하지만 불투명 타입은 반대로 호출된 코드가 호출한 코드의 타입을 결정한다.
    var body: some View {
        HStack {
            productImage
            productDescrpition
        }
        .frame(height: store.appSetting.productRowHeight)
        .background(Color.primary.colorInvert())
        .clipShape(.rect(cornerRadius: 6))
        .shadow(color: Color.primaryShadow,radius: 1, x: 2, y: 2)
        .opacity(willAppear ? 1 : 0)
        .animation(.easeInOut(duration: 0.4), value: willAppear)
        .onAppear { self.willAppear = true }
        .contextMenu { contextMenu }
    }
}

private extension ProductRow {
    var productImage: some View {
        Image(product.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }
    
    var productDescrpition: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 6)

            Text(product.description)
                .font(.footnote)
                .foregroundStyle(Color.secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
            
            footerView
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }
    
    var footerView: some View {
        HStack(spacing: 0) {
            Text("₩").font(.footnote) +
            Text("\(product.price)").font(.headline)
            
            Spacer()
            
            FavoriteButton(product: product)
            
            Symbol("cart", color: .peach)
                .frame(width: 32, height: 32)
                .onTapGesture { self.orderProduct() }
        }
    }
    
    var contextMenu: some View {
        VStack {
            Button(action: { self.toggleFavorite() }) {
                Text("Toggle Favorite")
                Symbol(self.product.isFavorite ? "heart.fill" : "heart")
            }
            Button(action: { self.orderProduct()}) {
                Text("Order Product")
                Symbol("cart")
            }
        }
    }

    func orderProduct() {
        quickOrder = product
        
        store.placeOrder(product: product, quantity: 1)
    }
    
    func toggleFavorite() {
        store.toggleFavorite(of: product)
    }
}

#Preview {
    ProductRow(
        quickOrder: .constant(nil),
        product: productSamples[0]
    ).environmentObject(Store())
}
