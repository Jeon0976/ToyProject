//
//  SrollViewExam.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 5/28/24.
//

import SwiftUI

struct ScrollViewExam: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text("Vertical ScrollView").font(.largeTitle)
                ScrollView {
                    ForEach(0..<10) { i in
                        Circle()
                            .fill(Color(white: 0.2 + (0.8 * Double(i) / 10)))
                            .frame(width: 80, height: 80)
                    }.frame(width: geometry.size.width)
                }
                .scrollIndicators(.hidden)
                .frame(
                    height: geometry.size.height / 2,
                    alignment: .top
                )
                .padding(.bottom)
                
                Text("Horizontal ScrollView").font(.largeTitle)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<10) { i in
                            Circle()
                                .fill(Color(white: 0.2 + (0.8 * Double(i) / 10)))
                                .frame(width: 80, height: 80)
                        }
                    }
                    .frame(height: geometry.size.height / 5)
                    .padding([.bottom, .horizontal])
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
}

#Preview {
    ScrollViewExam()
}
