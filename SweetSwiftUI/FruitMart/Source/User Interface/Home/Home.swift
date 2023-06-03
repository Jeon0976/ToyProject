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

    var body: some View {
        ScrollView {
            VStack {
                ForEach(products ?? [], id: \.name) { product in
                    ProductRow(product: product)
                }
            }
            .onAppear {
                products = loadProducts()
            }
        }
    }
}

// JSON file Decoder
private extension Home {
    func loadProducts() -> [Product]? {
        guard let url = Bundle.main.url(forResource: "ProductData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return nil }
        
        let decoder = JSONDecoder()
        return try? decoder.decode([Product].self, from: data)
    }
}


struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
