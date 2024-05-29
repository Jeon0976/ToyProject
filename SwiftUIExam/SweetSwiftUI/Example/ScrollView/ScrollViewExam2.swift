//
//  ScrollViewExam2.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 5/28/24.
//

import SwiftUI

struct ScrollViewExam2: View {
    var body: some View {
        let colors: [Color] = [.red, .green, .blue]
        
        return GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(colors.indices, id: \.self) { index in
                        Circle()
                            .fill(colors[index])
                            .overlay(Text("\(index) 페이지")
                                .font(.largeTitle).foregroundStyle(.white)
                            )
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            .onAppear { UIScrollView.appearance().isPagingEnabled = true }
        }
    }
}

#Preview {
    ScrollViewExam2()
}
