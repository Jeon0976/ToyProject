//
//  UsePriority.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/05.
//

import SwiftUI

struct UsePriority: View {
    var body: some View {
        HStack {
            Text("Hello, SwiftUI!")
                .layoutPriority(1) // 이 뷰는 다른 뷰보다 더 많은 공간을 차지합니다.
                .background(Color.yellow)
            
            Text("This is a longer textsssssssssss")
//                .frame(minWidth: 50, maxWidth: 150) // 뷰의 너비가 50과 150 사이로 제한됩니다.
                .background(Color.green)
            
            Text("TestTestssssssssssssssssssssssssssssssss")
                .layoutPriority(1)
        }
    }
}

struct UsePriority_Previews: PreviewProvider {
    static var previews: some View {
        UsePriority()
    }
}

