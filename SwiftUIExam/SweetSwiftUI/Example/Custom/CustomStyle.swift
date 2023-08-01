//
//  CustomStyle.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 2023/06/08.
//

import SwiftUI

struct CustomStyle: View {
    @State private var isOn = true
    
    var body: some View {
        VStack {
            Button("커스텀 버튼 스타일1") { print("Test") }
                .buttonStyle(CustomButtonStyle())
            Button("커스텀 버튼 스타일2") { }
                .buttonStyle(CustomButtonStyle(backgroundColor: .brown,cornerRadius: 20))
            Button("커스텀 버튼 스타일3") { print("ACtion!")}
                .buttonStyle(CustomPrimitiveButtonStyle(minimumDuration: 1))
            Toggle("기본", isOn: $isOn)
            Toggle("custom", isOn: $isOn)
                .toggleStyle(CustomToggleStyle())
        }
    }
}

struct CustomStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyle()
    }
}

struct CustomButtonStyle: ButtonStyle {
    var backgroundColor: Color = .blue
    var cornerRadius: CGFloat = 6
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor))
            .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}

struct CustomPrimitiveButtonStyle: PrimitiveButtonStyle {
    var minimumDuration = 0.5
    
    func makeBody(configuration: Configuration) -> some View {
        ButtonStyleBody(configuration: configuration, minimumDuration: minimumDuration)
    }
}

private struct ButtonStyleBody: View {
    let configuration: PrimitiveButtonStyleConfiguration
    let minimumDuration: Double
    @GestureState private var isPressed = false
    
    var body: some View {
        let longPress = LongPressGesture(minimumDuration: minimumDuration)
            .updating($isPressed) { value, state, _ in
                state = value
            }
            .onEnded { _ in self.configuration.trigger() }
        
        return configuration.label
            .foregroundColor(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
            .scaleEffect(isPressed ? 0.8 : 1.0)
            .opacity(isPressed ? 0.6 : 1.0)
            .gesture(longPress)
    }
}


struct CustomToggleStyle: ToggleStyle {
    let size: CGFloat = 30
    @State private var isPressed: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        let isOn = configuration.isOn
        
        return HStack {
            configuration.label
            
            Spacer()
            
            ZStack(alignment: isOn ? .top : .bottom) {
                Capsule()
                    .fill(isOn ? Color.green : Color.red)
                    .frame(width: size, height: size * 2)
                
                Circle()
                    .frame(width: size - 2, height: isPressed ? size + 10 : size - 2)
                    .onTapGesture {
                        withAnimation {
                            isPressed.toggle()
                            configuration.isOn.toggle()
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                                isPressed = false
                            }
                        }
                    }
            }
        }
    }
}
