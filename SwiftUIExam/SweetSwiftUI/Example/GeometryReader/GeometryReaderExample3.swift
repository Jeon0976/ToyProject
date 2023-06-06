//
//  GeometryReaderExample3.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/05.
//

import SwiftUI

struct GeometryReaderExample3: View {
    var body: some View {
        HStack {
            Rectangle().fill(Color.yellow).frame(width: 30)
            
            VStack {
                Rectangle().fill(Color.blue).frame(height: 200)
                
                GeometryReader {
                    self.contents(geometry: $0)
                        .position(x: $0.size.width / 2, y: $0.size.height / 2)
                }
                .border(Color.red, width: 4)
                .background(Color.green)
                .padding(.bottom, 1)
                .padding(.trailing, 1)
                
            }.coordinateSpace(name: "VStack2CS")
        }.coordinateSpace(name: "HStack2CS")
    }
    
    func contents(geometry g: GeometryProxy) -> some View {
        VStack {
            Text("Local").bold()
            Text(stringFormat(for: g.frame(in: .local).origin))
                .padding(.bottom)
            
            Text("Global").bold()
            Text(stringFormat(for: g.frame(in: .global).origin))
                .padding(.bottom)
            
            Text("Name VStackCS").bold()
            Text(stringFormat(for: g.frame(in: .named("VStack2CS")).origin))
                .padding(.bottom)
            
            Text("Name HStackCS").bold()
            Text(stringFormat(for: g.frame(in: .named("HStack2CS")).origin))
                .padding(.bottom)
        }
    }
    
    func stringFormat(for point: CGPoint) -> String {
        String(format: "(x: %.f, y: %.f)", arguments: [point.x, point.y])
    }
}

struct GeometryReaderExample3_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderExample3()
    }
}
