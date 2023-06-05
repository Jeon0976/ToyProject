//
//  GeometryReaderExample.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/05.
//


// frame 설정으로 top, bottom의 inset값이 0 이 됨
// frame을 설정 안하면 값 생김
import SwiftUI

struct GeometryReaderExample: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle().fill(Color.red)
                    .frame(width: 150,height: 150)
                Circle().fill(Color.blue)
                    .frame(width: 50,height: 50)
            }.padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
            
            Text("Geometry Reader")
                .font(.largeTitle)
                .bold()
                .position(x: geometry.size.width / 2,
                          y: geometry.safeAreaInsets.top + 32
                )
            
            VStack {
                Text("Size").bold()
                Text("width: \(Int(geometry.size.width))")
                Text("Height: \(Int(geometry.size.height))")
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2.5)
            
            VStack {
                Text("SafeAreaInsets").bold()
                Text("top: \(Int(geometry.safeAreaInsets.top))")
                Text("bottom: \(Int(geometry.safeAreaInsets.bottom))")
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.4)
        }
        .font(.title)
//        .frame(height: 500)
        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray,lineWidth: 2))
    }
}

struct GeometryReaderExample_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderExample()
    }
}
