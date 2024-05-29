//
//  ImageGallery.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/29/24.
//

import SwiftUI

struct ImageGallery: View {
    // 앱의 다른 부분에는 영향이 없도록 별도의 상품 목록을 저장하여 사용
    static private let galleryImages: [String] = Store().products.map {
        $0.imageName
    }
    @State private var productImages: [String] = galleryImages
    @State private var spacing: CGFloat = 20
    @State private var scale: CGFloat = 0.020
    @State private var angle: CGFloat = 5
    @State private var position: CGSize = .zero
    
    @GestureState private var translation: CGSize = .zero
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                backgroundCards
                frontCard
            }
            Spacer()
            controller
        }
        .background(backgroundGradient)
        .ignoresSafeArea(edges: .top)
    }
}

private extension ImageGallery {
    var frontCard: some View {
        let dragGesture = DragGesture()
            .updating($translation) { (value, state, _) in
                state = value.translation
            }
            .onEnded { value in
                position.width += value.translation.width
                position.height += value.translation.height
            }
        
        return FruitCard(productImages[0])
            .offset(translation)
            .offset(position)
            .shadow(radius: 4, x: 2, y: 2)
            .onLongPressGesture {
                // 첫 이미지를 가장 마지막으로 보내는 역활
                self.productImages.append(self.productImages.removeFirst())
            }
            .simultaneousGesture(dragGesture)
        
    }
    
    var backgroundCards: some View {
        ForEach(productImages.dropFirst().reversed(), id: \.self) {
            self.backgroundCard(image: $0)
        }
    }
    
    var controller: some View {
        let titles = ["간격", "크기", "각도"]
        let values = [$spacing, $scale, $angle]
        let ranges: [ClosedRange<CGFloat>] = [1.0...40.0, 0...0.05, -90.0...90.0]
        
        UISlider.appearance().thumbTintColor = UIColor(.peach)
        
        return VStack {
            ForEach(titles.indices, id: \.self) { i in
                HStack {
                    Text(titles[i])
                        .font(.system(size: 17))
                        .frame(width: 80)
                    Slider(value: values[i], in: ranges[i])
                        .tint(.peach.opacity(0.25))
                }
            }
        }
        .padding()
    }
    
    var backgroundGradient: some View {
        let colors = [Color.peach, Color.white]
        let gradient = Gradient(colors: colors)
        
        return LinearGradient(
            gradient: gradient,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private func backgroundCard(image: String) -> some View {
        let index = productImages.firstIndex(of: image)!
        let response = computeResponse(index: index)
        let animation = Animation.spring(response: response, dampingFraction: 0.68)
        
        return FruitCard(image)
            .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
            .offset(computePosition(index: index))
            .scaleEffect(computeScale(index: index))
            .rotation3DEffect(
                computeAngle(index: index),
                axis: (x: 0.0, y: 0.0, z: 1.0)
            )
            .transition(AnyTransition.scale.animation(animation))
            .animation(animation, value: UUID())
    }
    
    private func computeResponse(index: Int) -> Double {
        max(Double(index) * 0.04, 0.2)
    }
    
    private func computePosition(index: Int) -> CGSize {
        let x = translation.width + position.width
        let y = translation.height + position.height - CGFloat(index) * spacing
        
        return CGSize(width: x, height: y)
    }
    
    private func computeScale(index: Int) -> CGFloat {
        let cardScale = 1.0 - CGFloat(index) * (0.05 - scale)
        
        return max(cardScale, 0.1)
    }
    
    private func computeAngle(index: Int) -> Angle {
        let degrees = Double(index) * Double(angle)
        
        return Angle(degrees: degrees)
    }
}

#Preview {
    ImageGallery()
}
