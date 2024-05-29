//
//  SwiftUIExampleApp.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

@main
struct SwiftUIExampleApp: App {
    var body: some Scene {
        WindowGroup {
//            ProductDetailView(product: productSamples[0])
            configureAppearance()
            
            return MainTabView()
        }
    }
    
    private func configureAppearance() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "peach")!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(named: "peach")!
        ]
    }
}

