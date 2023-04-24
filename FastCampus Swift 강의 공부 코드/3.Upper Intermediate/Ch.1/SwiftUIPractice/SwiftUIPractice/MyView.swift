//
//  MyView.swift
//  SwiftUIPractice
//
//  Created by 전성훈 on 2022/09/06.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.title)
            Text("안녕하세요")
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
