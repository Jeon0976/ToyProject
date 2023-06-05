//
//  GeometryReaderExample2.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/05.
//

import SwiftUI

// 동적 그래프 그리기
struct BarGraph: View {
    var values: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 16) {
                ForEach(self.values.indices, id: \.self) { index in
                    Rectangle()
                        .fill(Color.red)
                        .frame(height: CGFloat(self.values[index]) / CGFloat(self.values.max() ?? 1) * geometry.size.height)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        BarGraph(values: [24,100,10, 23, 45, 60, 33, 76, 88])
            .frame(height: 200)
            .border(Color.gray, width: 1)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

