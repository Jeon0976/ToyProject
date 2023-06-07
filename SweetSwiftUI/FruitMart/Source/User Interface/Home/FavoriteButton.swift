//
//  FavoriteButton.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/07.
//  Copyright © 2023 Giftbot. All rights reserved.
//
//
import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject private var store: Store
    
    let product: Product
    
    private var imageName: String {
        product.isFavorite ? "heart.fill" : "heart"
    }
    
    var body: some View {
        Button(action: {
            self.store.toggleFavorite(of: self.product)
        }) {
            Image(systemName: imageName)
                .imageScale(.large)
                .foregroundColor(.peach)
                .frame(width: 32, height: 32)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        let testProduct = Product(name: "Test", imageName: "apple", price: 1000, description: "Test", isFavorite: false)
        FavoriteButton(product: testProduct)
    }
}
