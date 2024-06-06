//
//  NavigationStackRoot.swift
//  SwiftUICoordinator
//
//  Created by 전성훈 on 5/31/24.
//

import SwiftUI

struct NavigationStackRoot: View {
    @State private var path: [Int] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            Button("Start") {
                path.append(1)
            }
            .navigationDestination(for: Int.self) { int in
                DetailView(path: $path, count: int)
            }
            .navigationTitle("Home")
        }
    }
}
