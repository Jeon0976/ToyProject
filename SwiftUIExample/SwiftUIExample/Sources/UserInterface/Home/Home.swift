//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

/// SwiftUI는 뷰를 직졉 변경하는 대신 새로운 동작이나 시각적 변화를 적용한 새로운 타입의 뷰를 반환한다.
/// SwiftUI의 모든 수식어는 그 자신의 타입이나 뷰 프로토콜을 반환하도록 설계되어 있어, 연쇄적인 메서드 호출(메서드 체이닝)이 가능하다.

// if문 Statement 구문 / 삼항연산자 Expression 표현식

// overlay -> addSubview
// background -> 아래 방향으로 쌓기

struct Home: View {
    var body: some View {
        VStack {
            ProductRow(product: productSamples[0])
            ProductRow(product: productSamples[1])
            ProductRow(product: productSamples[2])
            ProductRow(product: productSamples[3])

        }
    }
}

#Preview {
    Home()
}
