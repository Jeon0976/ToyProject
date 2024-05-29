//
//  TabViewExam.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 5/28/24.
//

import SwiftUI

struct TabViewExam: View {
    var body: some View {
        TabView {
            VStack {
                Text("첫번째").font(.largeTitle)
            }.tabItem {
                Image(systemName: "house")
                Text("아이템1")
            }
            
            Text("두번째")
                .tabItem {
                    Image(systemName: "person")
                    Text("아이템2")
                }
        }
    }
}

#Preview {
    TabViewExam()
}
