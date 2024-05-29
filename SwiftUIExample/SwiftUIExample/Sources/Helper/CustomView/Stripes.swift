//
//  Stripes.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct Stripes: Shape {
    var stripes: Int = 30
    var insertion: Bool = true
    var ratio: CGFloat
    
    var animatableData: CGFloat {
        get { ratio }
        set { ratio = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let stripeWidth = rect.width / CGFloat(stripes)
        let rects = (0..<stripes).map { (index: Int) -> CGRect in
            let xOffset = CGFloat(index) * stripeWidth
            let adjustment = insertion ? 0 : (stripeWidth * (1 - ratio))
            
            return CGRect(
                x: xOffset + adjustment,
                y: 0,
                width: stripeWidth * ratio,
                height: rect.height
            )
        }
        
        path.addRects(rects)
        
        return path
    }
}

extension Stripes: Hashable { }

struct ShapeClipModifier_Previews: PreviewProvider {
    static var previews: some View {
        let ratio: [CGFloat] = [0.1, 0.3, 0.5, 0.7, 0.9]
        let insertion = ratio.map { Stripes(ratio: $0) }
        let removal = ratio.map {
            Stripes(insertion: false, ratio: 1 - $0)
        }
        
        let image = ResizedImage(
            recipeSamples[0].imageName,
            contentMode: .fit
        )
        
        return HStack {
            ForEach([insertion, removal], id: \.self) { type in
                VStack {
                    ForEach(type, id: \.self) {
                        image.modifier(ShapeClipModifier(shape: $0))
                    }
                }
            }
        }
    }
}
