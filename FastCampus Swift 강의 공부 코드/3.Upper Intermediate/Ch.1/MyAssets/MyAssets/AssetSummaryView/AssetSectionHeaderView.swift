//
//  AssetSectionHeaderView.swift
//  MyAssets
//
//  Created by 전성훈 on 2022/09/07.
//

import SwiftUI

struct AssetSectionHeaderView: View {
    let title : String
    var body: some View {
        VStack(alignment : .leading) {
            Text(title).font(.system(size: 20,weight: .bold))
                .foregroundColor(.accentColor)
            Divider()
                .frame(height: 2)
                .background(Color.black)
                .foregroundColor(.red)
        }
    }
}

struct AssetSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AssetSectionHeaderView(title: "은행")
    }
}
