//
//  SwiftUIMVVMApp.swift
//  SwiftUIMVVM
//
//  Created by 전성훈 on 6/5/24.
//

import SwiftUI

@main
struct SwiftUIMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: HomeViewModel())
        }
    }
}
