//
//  CustomFunctionBuilders.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/06.
//

import SwiftUI

struct CustomFunctionBuilders: View {
    @EvenNumbers var computedProperty: [Int] {
        [1,2,3,4,5,6]
    }
    
    @EvenNumbers
    func annotatedFunction(_ numbers: [Int]) -> [Int] {
        numbers.filter { $0 > 2}
    }
    
    func parameterAnnotated(@EvenNumbers _ content: () -> [Int]) -> [Int] {
        content()
    }
    
    var test = [1,2,3,4,5,6,7]
    
    var body: some View {
        VStack {
            Text(computedProperty.map(String.init).joined(separator: ", "))
            Text(annotatedFunction(test).map(String.init).joined(separator: ", "))
            Text(parameterAnnotated({
                test
            }).map(String.init).joined(separator: ", "))
            
            HStack {
                MyVStack {
                    Color.blue
                        .frame(width: 100,height: 20)
                    Text("Hello, SwiftUI")
                    Rectangle()
                        .frame(width: 250, height: 40)
                }
                VStack {
                    ViewBuilder.buildBlock(
                        Text("Test"),
                        Bool.random() ? ViewBuilder.buildEither(first: Spacer()) : ViewBuilder.buildEither(second: Divider()),
                        ViewBuilder.buildIf(Bool.random() ? Text("Optional") : nil)
                    )
                }
            }
        }
        
    }
}

struct CustomFunctionBuilders_Previews: PreviewProvider {
    static var previews: some View {
        CustomFunctionBuilders()
    }
}


struct MyVStack<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            content
        }
    }
}

@resultBuilder
struct EvenNumbers {
    static func buildBlock(_ numbers: Int...) -> [Int] {
        numbers.filter { $0.isMultiple(of: 2) }
    }
    
    static func buildBlock(_ numbers: [Int]) -> [Int] {
        numbers.filter { $0.isMultiple(of: 2) }
    }
}



