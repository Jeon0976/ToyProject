//
//  QuantitySelector.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/07.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import SwiftUI

struct QuantitySelector: View {
    @Binding var quantity: Int
    
    // 햅틱 피드백 적용
    private let softFeedback = UIImpactFeedbackGenerator(style: .soft)
    private let rigidFeedback = UIImpactFeedbackGenerator(style: .rigid)
    
    var range: ClosedRange<Int> = 1...20
    
    var body: some View {
        HStack {
            Button(action: { self.changeQuantity(-1)}) {
                Image(systemName: "minus.circle.fill")
                    .imageScale(.large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))
            
            Text("\(quantity)")
                .bold()
                .font(Font.system(.title, design: .monospaced))
                .frame(minWidth: 40, maxWidth: 60)
            
            Button(action: { self.changeQuantity(1)}) {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))
        }
    }
    
    private func changeQuantity(_ num: Int) {
        if range ~= quantity + num {
            quantity += num
            softFeedback.prepare() // 진동 지연 시간을 줄일 수 있도록 미리 준비시키는 메서드
            softFeedback.impactOccurred(intensity: 0.8)
        } else {
            rigidFeedback.prepare()
            rigidFeedback.impactOccurred()
        }
    }
}

struct QuantitySelector_Previews: PreviewProvider {
    static var previews: some View {
        QuantitySelector(quantity: .constant(1))
    }
}
