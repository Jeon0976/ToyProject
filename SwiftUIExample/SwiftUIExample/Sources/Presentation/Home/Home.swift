//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

/// SwiftUI는 뷰를 직졉 변경하는 대신 새로운 동작이나 시각적 변화를 적용한 새로운 타입의 뷰를 반환한다.
/// SwiftUI의 모든 수식어는 그 자신의 타입이나 뷰 프로토콜을 반환하도록 설계되어 있어, 연쇄적인 메서드 호출(메서드 체이닝)이 가능하다.

// if문 Statement 구문 / 삼항연산자 Expression 표현식

// overlay -> addSubview
// background -> 아래 방향으로 쌓기

struct Home: View {
    @EnvironmentObject private var store: Store
    @State private var quickOrder: Product?
    @State private var showingFavoriteImage: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                if showFavorite {
                    favoriteProducts
                }
                darkerDivier
                productList
            }
            .listStyle(.plain)
            .navigationTitle("과일마트")
            .navigationBarTitleDisplayMode(.inline)
        }
        .popupOverContext(
            item: $quickOrder,
            style: .dimmed,
            ignoringEdges: .all,
            content: popupMessage(product:)
        )
    }
}

private extension Home {
    var favoriteProducts: some View {
        FavoriteProductScrollView(showingImage: $showingFavoriteImage)
    }
    
    var darkerDivier: some View {
        Color.primary
            .opacity(0.3)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
    
    private var productList: some View {
        List(store.products) { product in
            HStack {
                ProductRow(quickOrder: self.$quickOrder, product: product)
                NavigationLink(destination: ProductDetailView(product: product)) {
                    EmptyView()
                }
                .opacity(0.0)
                .frame(width: 0)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.background)
        }
        .background(Color.background)
        .padding(.top, -8)
    }
    
    var showFavorite: Bool {
        !store.products.filter { $0.isFavorite }.isEmpty
    }
    
    func popupMessage(product: Product) -> some View {
        let name = product.name.split(separator: " ").last!
        
        return VStack {
            Text(name)
                .font(.title).bold().kerning(3)
                .foregroundStyle(.peach)
                .padding(.bottom, 6)
            
            OrderCompletedMessage()
        }
    }
}

/// 프리뷰는 Home의 자식 뷰에 속하지 않으므로 별개로 인스턴스를 만들어 전달해 주어야 한다.
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Home()).environmentObject(Store())
    }
}

