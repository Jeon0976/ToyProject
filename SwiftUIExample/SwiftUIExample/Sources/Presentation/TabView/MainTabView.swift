//
//  MainTabView.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct MainTabView: View {
    private enum Tabs {
        case home, recipe, gallery, myPage
    }
    
    @State private var selectedTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                home
                recipe
                imageGallery
                myPage
            }
            .tint(.primary)
        }
        .tint(.peach)
        .ignoresSafeArea(edges: .top)
    }
}

private extension MainTabView {
    var home: some View {
        Home()
            .tag(Tabs.home)
            .tabItem(image: "house", text: "홈")
            .environmentObject(Store())

    }
    
    var recipe: some View {
        RecipeView()
            .tag(Tabs.recipe)
            .tabItem(image: "book", text: "레시피")
    }
    
    var imageGallery: some View {
        ImageGallery()
            .tag(Tabs.gallery)
            .tabItem(image: "photo.on.rectangle", text: "갤러리")
    }
    
    var myPage: some View {
        Text("마이페이지")
            .tag(Tabs.myPage)
            .tabItem(image: "person", text: "마이페이지")
    }
}

fileprivate extension View {
    func tabItem(image: String, text: String) -> some View {
        self.tabItem {
            Symbol(image, imageScale: .large)
                .font(.system(size: 17, weight: .light))
            Text(text)
        }
    }
}

#Preview {
    MainTabView()
}
