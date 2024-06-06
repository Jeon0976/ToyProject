//
//  DetailView.swift
//  SwiftUICoordinator
//
//  Created by 전성훈 on 5/31/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var path: [Int]
    
    let count: Int
    
    var body: some View {
        Button("Go depper") {
            path.append(1)
        }
        .navigationTitle(count.description)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Pop to Root") {
                    path = []
                }
            }
        }
    }
}
