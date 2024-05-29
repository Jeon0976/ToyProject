//
//  AnimationExample3.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct AnimationExample3: View {
    @State private var trimmedTo: CGFloat = 1.0
    @State private var lineWidth: CGFloat = 7.0
    @State private var isHidden = false
    
    var body: some View {
        VStack {
            MyCircle(trimmedTo: trimmedTo, lineWidth: lineWidth)
                .padding()
                .animation(.easeInOut(duration: 1.5), value: isHidden)
            
            Button(action: {
                self.trimmedTo = self.isHidden ? 1.0 : 0
                self.lineWidth = self.isHidden ? 7 : 1
                self.isHidden.toggle()
            }) {
                Text("Animate!").font(.title)
            }.padding()
        }
    }
}

struct MyCircle: Shape {
    var trimmedTo: CGFloat
    var lineWidth: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(trimmedTo, lineWidth)}
        set {
            trimmedTo = newValue.first
            lineWidth = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radious = rect.width / 2

        // 시작 각도에서 종료 각도 원 그릴려면 2파이 플러스
        let start = Angle(radians: .pi) // 원을 그리는 시작 시점
        let end = Angle(radians: .pi * 3) // 원을 그리는 종료 시점
        
        path.addArc(
            center: center, 
            radius: radious / 4,
            startAngle: start,
            endAngle: end,
            clockwise: false
        )
        
        path.addArc(
            center: center,
            radius: radious / 2,
            startAngle: start,
            endAngle: end,
            clockwise: false
        )
        
        path.addArc(
            center: center,
            radius: radious,
            startAngle: start, 
            endAngle: end,
            clockwise: false
        )
        
        return path
            .trimmedPath(from: 0.0, to: trimmedTo)
            .strokedPath(.init(lineWidth: lineWidth))
    }
}

#Preview {
    AnimationExample3()
}
