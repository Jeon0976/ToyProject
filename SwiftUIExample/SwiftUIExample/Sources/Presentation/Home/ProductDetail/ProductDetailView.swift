//
//  ProductDetailView.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

struct ProductDetailView: View {
    @State private var quantity: Int = 1
    @State private var showingAlert: Bool = false
    @State private var showingPopup: Bool = false
    @State private var willAppear: Bool = false
    
    @EnvironmentObject private var store: Store
    
    let product: Product
    
    var body: some View {
        VStack(spacing: 0) {
            if willAppear {
                productImage
            }
            orderView
        }
        .popup(isPresented: $showingPopup, style: .dimmed) { OrderCompletedMessage() }
        .ignoresSafeArea(edges: [.top])
        .alert("주문 확인", isPresented: $showingAlert, actions: {
            Button("취소", role: .cancel, action: {})
            Button("확인", action: {
                self.placeOrder()
            })
        }, message: {
            Text("\(product.name)을(를) \(quantity)개 구매하겠습니까?")
        })
        .onAppear { self.willAppear = true }
    }
}

private extension ProductDetailView {
    var productImage: some View {
        let effect = AnyTransition.scale.combined(with: .opacity)
            .animation(Animation.easeInOut(duration: 0.4).delay(0.05))
        
        return GeometryReader { _ in
            ResizedImage(self.product.imageName)
        }
        .transition(effect)
    }
    
    var orderView: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                self.productDescrpition
                    .padding(.top, 32)
                
                Spacer()
                
                self.priceInfo
                self.placeOrderButton
                    .padding(.bottom, 16)
            }
            .padding([.leading, .trailing], 32)
            .frame(height: $0.size.height)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 16))
            .offset(y: -6)
        }
    }
    
    var productDescrpition: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(product.name)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                
                Spacer()
                
                FavoriteButton(product: product)
            }
            
            ScrollView {
                Text(product.description)
                    .foregroundStyle(Color.secondaryText)
            }
            .scrollDisabled(true)
        }
    }
    
    var priceInfo: some View {
        let price = quantity * product.price
        
        return HStack {
            (Text("₩ ") + Text("\(price)").font(.title).fontWeight(.medium))
                .fontWeight(.medium)
            Spacer()
            QuantitySelector(quantity: $quantity)
        }
        .foregroundStyle(.black)
    }
    
    var placeOrderButton: some View {
        Button(action: { self.showingAlert = true }) {
            Capsule()
                .fill(.peach)
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(
                    Text("주문하기")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                )
        }
        .buttonStyle(ShrinkButtonStyle())
    }
    
    private func placeOrder() {
        store.placeOrder(product: product, quantity: quantity)
        showingPopup = true
    }
}

struct ProductDet_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: ProductDetailView(product: productSamples[0])).environmentObject(Store())
    }
}

