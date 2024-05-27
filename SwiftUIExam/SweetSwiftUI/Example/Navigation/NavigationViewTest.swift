//
//  NavigationViewTest.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

struct NavigationViewTest: View {
    let titles = ["ㅅㅅ", "ㅇㅇ"]
    let data = [[1,2,3,4],[5,6,7,8]]
    
    var body: some View {
        let leadingItem = Button(action: { print("Leading item tapped")}) {
            Image(systemName: "bell").imageScale(.large)
        }
        
        let trailingItem = Button(action: { print("TrilingItem item tapped")}) {
            Image(systemName: "gear").imageScale(.large)
        }
        
        return NavigationView {
            List {
                ForEach(data.indices, id: \.self) { index in
                    Section {
                        ForEach(data[index], id: \.self) {
                            Text("\($0)")
                                .listSectionSeparator(.hidden)
                        }
                    } header: {
                        Text(titles[index]).font(.largeTitle).foregroundStyle(.black)

                    } footer: {
                        HStack {
                            Spacer()
                            Text("\(data[index].count) 건")
                        }
                        .listSectionSeparator(.hidden)
                    }
                    
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("네비게이션 타이틀")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { leadingItem }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: -5) {
                        trailingItem
                        trailingItem
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationViewTest()
}
