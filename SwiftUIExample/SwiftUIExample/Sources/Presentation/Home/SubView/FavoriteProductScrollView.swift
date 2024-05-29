//
//  FavoriteProductScrollView.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct FavoriteProductScrollView: View {
    @EnvironmentObject private var store: Store
    @Binding var showingImage: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            if showingImage {
                products
            }
        }
        .transition(.slide)
    }
}

extension FavoriteProductScrollView {
    var title: some View {
        HStack(alignment: .center, spacing: 5) {
            Text("즐겨찾는 상품")
                .font(.headline)
                .fontWeight(.medium)
            
            Symbol("arrowtriangle.up.square")
                .padding(4)
                .rotationEffect(Angle(radians: showingImage ? .pi : 0))
            
            Spacer()
        }
        .padding(.bottom, 8)
        .padding(.leading, 16)
        .onTapGesture {
            withAnimation {
                self.showingImage.toggle()
            }
        }
    }
    
    var products: some View {
        let favoriteProducts = store.products.filter({ $0.isFavorite })
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                Spacer()

                ForEach(favoriteProducts) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        self.eachProduct(product)
                    }
                }
            }
        }
        .animation(.spring(dampingFraction: 0.78), value: UUID())
    }
    
    func eachProduct(_ product: Product) -> some View {
        GeometryReader {
            ResizedImage(product.imageName, renderingMode: .original)
                .clipShape(Circle())
                .frame(width: 90, height: 90)
                .scaleEffect(self.scaledValue(from: $0))
        }
        .frame(width: 105, height: 105)
    }
    
    func scaledValue(from geometry: GeometryProxy) -> CGFloat {
        let xOffset = geometry.frame(in: .global).minX - 16
        let minSize: CGFloat = 0.9
        let maxSize: CGFloat = 1.0
        let delta: CGFloat = maxSize - minSize
        
        let size = minSize + delta * (1 - xOffset / UIScreen.main.bounds.width)
        
        return max(min(size, maxSize), minSize)
    }
}

struct FavoriteProductScrollView_Previews: PreviewProvider {
    @State static var showingImage = true
    
    static var previews: some View {
        FavoriteProductScrollView(showingImage: $showingImage)
            .environmentObject(Store())
    }
}
