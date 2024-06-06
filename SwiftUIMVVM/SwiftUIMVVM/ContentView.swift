//
//  ContentView.swift
//  SwiftUIMVVM
//
//  Created by 전성훈 on 6/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        if case .LOADING = viewModel.currentState {
            loaderView()
        } else if case .SUCCESS(let users) = viewModel.currentState {
            List(users) { user in
                userCell(user: user)
            }
        } else if case .FAILURE(let error) = viewModel.currentState {
            failureView(error: error)
        }
    }
    
    private func userCell(user: User) -> some View {
        HStack(spacing: 40) {
            AsyncImage(url: URL(string: user.avatar_url ?? "Unknown user")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60, alignment: .center)
            .clipShape(Circle())
            
            Text(user.login ?? "")
                .font(.headline)
            Spacer()
        }
    }
    
    private func loaderView() -> some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.gray)
        }
    }
    
    private func failureView(error: String) -> some View {
        VStack(alignment: .center) {
            Spacer()
            Text(error)
                .font(.headline.bold())
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: HomeViewModel())
}
