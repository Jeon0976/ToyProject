//
//  MainView.swift
//  CoordinatorWithSwiftUI
//
//  Created by 전성훈 on 6/5/24.
//

import SwiftUI


struct MainView: View {    
    
    var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
            
            Button(
                action: { self.pushDetail() },
                label: {
                    Text("Button")
                }
            )
        }
    }
    
    private func pushDetail() {
        viewModel.pushDetail()
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
