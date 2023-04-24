//
//  BannerCard.swift
//  MyAssets
//
//  Created by 전성훈 on 2022/09/07.
//

import SwiftUI

struct BannerCard: View {
    var banner : AssetBanner
    var body: some View {
        ZStack{
            Color(banner.backgroundColoer)
            VStack{
                Text(banner.title).font(.title)
                Text(banner.description).font(.subheadline)
            }
        }
        
//        Color(banner.backgroundColoer)
//            .overlay {
//                VStack {
//                    Text(banner.title).font(.title)
//                    Text(banner.description).font(.subheadline)
//                }
//            }
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", description: "확인하세요", backgroundColoer: .gray)
        BannerCard(banner: banner0)
    }
}
