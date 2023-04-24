//
//  NavigationBarWithButton.swift
//  MyAssets
//
//  Created by 전성훈 on 2022/09/06.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {
    var title : String = ""
    func body(content: Content) -> some View {
        return content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(title)
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("자산추가버튼 tapped")
                    } label: {
                        Image(systemName: "plus")
                        Text("자산추가")
                            .font(.system(size: 12))
                    }.tint(.black)
                        .padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 12))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(white: 1, alpha: 0.7)
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
            
    }
}

extension View {
    func navigationBarWithButtonStyle(_ title: String) -> some View {
        return self.modifier(NavigationBarWithButton(title: title))
    }
}

struct NavigationBarWithButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Color.gray.edgesIgnoringSafeArea(.all)
                .navigationBarWithButtonStyle("내 자산")
        }
    }
}
