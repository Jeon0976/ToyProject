//
//  FavoriteButton.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/28/24.
//

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject private var store: Store
    let product: Product
    
    private var imageName: String {
        product.isFavorite ? "heart.fill" : "heart"
    }
    
    var body: some View {
        Symbol(imageName, color: .peach)
            .frame(width: 32, height: 32)
            .onTapGesture {
                withAnimation {
                    self.store.toggleFavorite(of: self.product)
                }
            }
    }
}

#Preview {
    FavoriteButton(product: productSamples[0]).environmentObject(Store())
}
