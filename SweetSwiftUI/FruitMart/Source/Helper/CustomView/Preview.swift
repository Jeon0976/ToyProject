//
//  Preview.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/06.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import SwiftUI

struct Preview<V: View>: View {
    // 프리뷰에서 활용할 기기 목록 정의
    enum Device: String, CaseIterable {
        case iPhone14 = "iPhone 14"
        case iPhoneSe = "iPhone SE (3rd generation)"
        case iPhone14ProMax = "iPhone 14 Pro Max"
        case iPhone13mini = "iPhone 13 mini"
    }
    
    // 프리뷰에서 표현될 뷰
    let source: V
    var devices: [Device] = [.iPhone14, .iPhone14ProMax, .iPhoneSe, .iPhone13mini]
    
    // 다크 모드 출력 여부
    var displayDarkMode: Bool = true
    
    var body: some View {
        Group {
            ForEach(devices, id: \.self) {
                self.previewSource(device: $0)
            }
            if !devices.isEmpty && displayDarkMode {
                self.previewSource(device: devices[0])
                    .preferredColorScheme(.dark)
            }
        }
    }
    
    private func previewSource(device: Device) -> some View {
        source
            .previewDevice(PreviewDevice(rawValue: device.rawValue)) // 기기 형태
            .previewDisplayName(device.rawValue) // 프리뷰 컨테이너에 표시할 이름
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Text("Hello"))
    }
}
