//
//  ButtonExample.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/05.
//

import SwiftUI

struct ButtonExample: View {
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                // 텍스트를 버튼의 레이블로 사용한 경우
                Button("Button") {
                    print("Button1")
                }
                Button(action: { print("Button2")}) {
                    Text("Button")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18).strokeBorder()
                        )
                }
                Button(action: { print("Button3")}) {
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: 80, height: 80)
                        .overlay(Text("Button"))
                    Image("167")
                        .resizable()
                        .frame(width: 80,height: 80)
                        .cornerRadius(18)
                        .onTapGesture {
                            print("Tap")
                        }
                }
                .tint(.blue)
            }
            HStack(spacing: 20) {
                Button(action: {print("Button1") }) {
                    Image("167")
                        .resizable()
                        .frame(width: 120,height: 120)
                }
                Button(action: {print("Button2") }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                        .font(.largeTitle)
                }
                .buttonStyle(PlainButtonStyle())
                
            }
        }.accentColor(.black)
    }
}

struct ButtonExample_Previews: PreviewProvider {
    static var previews: some View {
        ButtonExample()
    }
}
