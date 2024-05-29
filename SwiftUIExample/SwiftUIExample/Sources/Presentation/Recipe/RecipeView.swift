//
//  RecipeView.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct RecipeView: View {
    @State private var currentIndex = 0
    private let recipes = recipeSamples
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            
            Spacer()
            
            recipePicker
            
            Spacer()
            
            recipeName
            recipeIndicator
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 30)
        .padding(.top, 50)
        .background(backgroundGradient)
        .ignoresSafeArea(edges: .top)
    }
}

private extension RecipeView {
    var title: some View {
        VStack {
            Text("과일을 활용한 \n신나는 요리")
                .font(.system(size: 42)).fontWeight(.thin)
                .foregroundStyle(.white)
                .padding(.vertical)
            
            Text("토마토와 함께하는 금주의 레시피")
                .font(.headline).fontWeight(.thin)
                .foregroundStyle(.white)
        }
        .padding()
    }
    
    var recipePicker: some View {
        HStack {
            Button(action: { self.changeIndex(-1) }) {
                Text("<")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            ResizedImage(recipes[currentIndex].imageName, contentMode: .fit)
                .padding(.horizontal)
                .transition(.stripes())
                .id(currentIndex)
            
            Spacer()
            
            Button(action: { self.changeIndex(1) }) {
                Text(">")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
        }
        .padding()
    }
    
    var recipeName: some View {
        Text(recipes[currentIndex].name)
            .font(.headline).fontWeight(.medium)
            .foregroundStyle(.white)
            .animation(nil, value: currentIndex)
    }
    
    var recipeIndicator: some View {
        GeometryReader {
            Rectangle()
                .fill(.white.opacity(0.4))
                .frame(width: $0.size.width)
                .overlay(self.currentIndicator(proxy: $0), alignment: .leading)
        }
        .frame(height: 2)
        .padding(.top)
    }
    
    var backgroundGradient: some View {
        let colors = [Color(hex: "#f56161"), Color(hex: "#fc9c79")]
        let gradient = Gradient(colors: colors)
        
        return LinearGradient(
            gradient: gradient,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private func changeIndex(_ num: Int) {
        withAnimation(.easeInOut(duration: 0.6)) {
            currentIndex = (currentIndex + recipes.count + num) % recipes.count
        }
    }
    
    private func currentIndicator(proxy: GeometryProxy) -> some View {
        let pastelYellow = Color(hex: "#fffa77")
        let width = proxy.size.width / CGFloat(recipes.count)
        
        return pastelYellow
            .frame(width: width)
            .offset(x: width * CGFloat(currentIndex), y: 0)
    }
}

#Preview {
    RecipeView()
}
