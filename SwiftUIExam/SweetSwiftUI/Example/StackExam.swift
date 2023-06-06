//
//  StackExam.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/03.
//

import SwiftUI

struct StackExam: View {
    var body: some View {
        HStack(alignment: .center,spacing: 20) {
            Text("Test")
            Spacer()
            VStack(alignment: .leading, spacing: 100) {
                Text("테스트")
                Text("Test")
                    .font(.body)
            }
            Circle()
                .fill(Color.yellow.opacity(0.6))
                .overlay(Text("stick").font(.caption2))
                .overlay(Image(systemName: "arrow.up").font(.caption2).padding(2), alignment: .top)
                .overlay(Image(systemName: "arrow.left").font(.caption2).padding(2), alignment: .leading)
                .overlay(Image(systemName: "arrow.right").font(.caption2).padding(2), alignment: .trailing)
                .background(Image(systemName: "arrow.down").font(.caption2).padding(2), alignment: .bottom)
            Text("Test2")
                .padding(16)
                .background(Color.gray)
                .cornerRadius(8.0)
            ZStack(alignment: .center) {
                Rectangle().frame(height: 10)
                HStack {
                    Circle().fill(Color.blue)
                    Ellipse().fill(Color.red)
                    Capsule().fill(Color.green)
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue,lineWidth: 3)
            )
        }
        .padding(16)
        // 바로 border보단 overlay, background 내부에 설정
//        .overlay(RoundedRectangle(cornerRadius: 10)
//            .stroke(Color.blue,lineWidth: 3)
//        )
        .background(RoundedRectangle(cornerRadius: 15)
            .stroke(Color.gray,lineWidth: 5)
        )
//        .border(.brown,width: 2)
//        .cornerRadius(18)
    }
}

struct StackExam_Previews: PreviewProvider {
    static var previews: some View {
        StackExam()
    }
}
