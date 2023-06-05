//
//  Home.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State private var products: [Product]?

    let store: Store
    
    var body: some View {
        NavigationView {
            List(store.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRow(product: product)
                }
            }
            .listStyle(.plain)
            .navigationTitle("과일마트")
        }
        .tint(.black)
    }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home(store: Store())
  }
}

