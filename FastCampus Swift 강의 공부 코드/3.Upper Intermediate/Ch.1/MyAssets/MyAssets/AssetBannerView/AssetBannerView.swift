//
//  AssetBannerView.swift
//  MyAssets
//
//  Created by 전성훈 on 2022/09/07.
//

import SwiftUI

struct AssetBannerView: View {
    let bannerList : [AssetBanner] = [
        AssetBanner(title:"공지사항", description: "추가된 공지사항을 확인하세요", backgroundColoer: .gray),
        AssetBanner(title:"주말 이벤트", description: "추가된 공지사항을 확인하세요", backgroundColoer: .darkGray),
        AssetBanner(title:"깜짝 이벤트", description: "추가된 공지사항을 확인하세요", backgroundColoer: .brown),
        AssetBanner(title:"가을 프로모션", description: "추가된 공지사항을 확인하세요", backgroundColoer: .lightGray)
    ]
    
    @State private var currentPage = 0
    
    var body: some View {
        let bannerCards = bannerList.map {
            BannerCard(banner: $0) }
        
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: bannerCards, currentPage: $currentPage)
            PageControl(numberOfPages: bannerList.count, currentPage: $currentPage)
                .frame(width: CGFloat(bannerCards.count * 18))
                .padding(.trailing)
        }
    }
}

struct AssetBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AssetBannerView().aspectRatio(5/2,contentMode: .fit)
    }
}
