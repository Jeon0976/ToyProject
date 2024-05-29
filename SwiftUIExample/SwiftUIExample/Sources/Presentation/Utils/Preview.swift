//
//  Preview.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

struct Preview<V: View>: View {
    enum Device: String, CaseIterable {
        case iphoneSE = "iPhone SE"
        case iphone15pro = "iPhone 15 pro"
    }
    
    let source: V
    var devices: [Device] = [.iphoneSE, .iphone15pro]

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
            .previewDevice(PreviewDevice(rawValue: device.rawValue))
            .previewDisplayName(device.rawValue)
    }
}
