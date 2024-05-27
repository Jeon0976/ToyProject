//
//  ProductRow.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

struct ProductRow: View {
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
        .frame(height: 150)
        .background(Color.primary.colorInvert())
        .clipShape(.rect(cornerRadius: 6))
        .shadow(color: Color.primaryShadow,radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
}

private extension ProductRow {
    private var productImage: some View {
        Image(product.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }
    
    private var productDescrpition: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            
            Text(product.description)
                .font(.footnote)
                .foregroundStyle(Color.secondaryText)
            
            Spacer()
            
            footerView
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }
    
    private var footerView: some View {
        HStack(spacing: 0) {
            Text("₩").font(.footnote) +
            Text("\(product.price)").font(.headline)
            
            Spacer()
            
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundStyle(.peach)
                .frame(width: 32, height: 32)
            
            Image(systemName: "cart")
                .imageScale(.large)
                .foregroundStyle(.peach)
                .frame(width: 32, height: 32)
        }
    }

}

#Preview {
    ProductRow(product: productSamples[0])
}
